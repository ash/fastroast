unit module FastRoast::Campaign;

# One campaign: a transform over a set of Roast files. For each file:
#
#   1. the SEED is the file fudged for Rakudo, without `#?` lines;
#   2. the transform turns it into edit groups, all applied: the FAT program;
#   3. both engines run the fat program; agreeing TAP (and exit status) is
#      `agree`, and that is the end of it;
#   4. otherwise both run the seed too. Disagreeing there as well is `base`:
#      the divergence exists without the fat and is not this campaign's.
#      Agreeing there is `fat`: the transform made the engines part;
#   5. a `fat` finding is minimized by delta debugging over the edit groups,
#      keeping a subset only while the same first test still disagrees the
#      same way, so the dossier names the few strings, names or operators
#      the divergence needs;
#   6. for a transform that promises the same verdicts (ops-v1), an oracle
#      whose own verdicts changed is recorded as `debt` on the finding: the
#      promise, not the candidate, may be what broke.

use FastRoast::Runner;
use FastRoast::Roast;
use FastRoast::Tokens;
use FastRoast::Tap;
use FastRoast::Transform;

sub write-dir(IO::Path $d) { $d.mkdir unless $d.d; $d }

sub md-cell(Str $s --> Str:D) { '`' ~ ($s // '').subst('|', '\|', :g).subst('`', "'", :g) ~ '`' }

# Whether the oracle's errors in `$stderr` report the identifier a rename
# group renames as unresolved, by its old spelling or its new one. Only the
# errors about a name that is not there count (the line that says so and the
# two after it, where "Undeclared routine:" lists the names), so a real
# divergence whose message merely mentions a renamed class is still one.
sub names-in(Str $stderr, $group --> Bool:D) is export {
    return False unless $stderr;
    my @l = $stderr.lines;
    my $text = @l.keys.grep({ @l[$_] ~~ / 'not declared' | 'Undeclared' | 'No such symbol' | 'has not been resolved' | 'Could not find symbol' | 'does not exist' / })
        .map({ @l[$_ .. min($_ + 2, @l.end)].Slip }).join("\n");
    return False unless $text;
    my @words = ($group.id.subst(/ ^ 'name:' /, ''), |$group.edits.map(*.text))
        .map(*.subst(/ ^ <[$@%&]> /, '')).unique;
    so @words.first(-> $w { $text ~~ / <!after \w> $w <!before \w> / })
}

# Delta debugging (Zeller's ddmin) over @items with a call budget: the
# smallest subset found for which &holds is still True.
sub ddmin(@start, &holds, Int:D $budget --> Hash:D) is export {
    my @items = @start; my $calls = 0; my $n = 2;
    while @items.elems >= 2 && $calls < $budget {
        my $size = (@items.elems / $n).ceiling;
        my @chunks = @items.batch($size).map(*.List);
        my $reduced = False;
        for @chunks -> @c {
            last if $calls >= $budget;
            $calls++;
            if holds(@c) { @items = @c; $n = 2; $reduced = True; last }
        }
        unless $reduced {
            for @chunks.keys -> $k {
                last if $calls >= $budget || $n == 2;   # with two chunks, a complement is a chunk
                my @rest = @chunks[(^@chunks).grep(* != $k)].map(*.Slip);
                $calls++;
                if holds(@rest) { @items = @rest; $n = max($n - 1, 2); $reduced = True; last }
            }
        }
        unless $reduced {
            last if $n >= @items.elems;
            $n = min($n * 2, @items.elems);
        }
    }
    { items => @items.List, calls => $calls, exhausted => $calls >= $budget }
}

sub judge(Str:D $rel, Str:D $name, %c --> Hash:D) is export {
    my $root = %c<roast>; my $tmp = write-dir(%c<tmp>.add(spec-dir($name)));
    my ($tname, $palette) = parse-spec($name);
    my %env = RAKULIB => $root.add('packages/Test-Helpers').absolute, RAKUPP_NO_CWD_LIB => '1';
    my sub on(Str $engine, IO::Path $file) {
        run-engine($engine, $file, $tmp, :cwd($root), :%env, :timeout(%c<timeout>))
    }
    my %r = :$rel, transform => $name, chapter => chapter-of($rel);
    my $seed = roast-seed($root, $rel, $tmp) // return %(|%r, verdict => 'skip', note => 'fudged away for rakudo');
    my @tokens = tokens($seed, $tmp) // return %(|%r, verdict => 'skip', note => 'tokens do not reassemble the file');
    my @groups = transform($tname, $seed, @tokens, :palette($palette // 'mixed'));
    return %(|%r, verdict => 'skip', note => 'nothing to fatten') unless @groups;
    # scratch files and the dossier keep the file's place in Roast:
    # tmp/SPEC/S32-str/uc.fat.t, findings/SPEC/S32-str/uc.t/
    my $at = $tmp.add($rel.IO.dirname); $at.mkdir;
    my $base = $rel.IO.basename.subst(/ '.t' $ /, '');
    my $fat-file = $at.add("$base.fat.t");
    my (%of, %cf);
    for ^4 {
        $fat-file.spurt(render($seed, @groups));
        %of = on(%c<oracle>, $fat-file); %cf = on(%c<candidate>, $fat-file);
        last if tap-agrees(%of, %cf) || !transform-info($tname)<renames>;
        # A rename the oracle's errors name was incomplete: a spelling the
        # tokens did not show (in a string the program compiles, say) still
        # refers to the old name. That name keeps its spelling; run again.
        my @bad = @groups.grep({ names-in(%of<stderr>, $_) });
        last unless @bad && @bad < @groups;
        %r<kept>.append: @bad.map(*.label);
        @groups = @groups.grep(-> $g { !@bad.first(* === $g) });
    }
    %r<groups> = @groups.elems;
    return %(|%r, verdict => 'agree', tests => tap-keys(%of<stdout>).elems) if tap-agrees(%of, %cf);
    my $seed-file = $at.add("$base.seed.t"); $seed-file.spurt($seed);
    my %os = on(%c<oracle>, $seed-file); my %cs = on(%c<candidate>, $seed-file);
    my $signature = tap-signature(%of, %cf);
    return %(|%r, verdict => 'base', :$signature, note => 'the engines disagree without the fat: ' ~ tap-signature(%os, %cs))
        unless tap-agrees(%os, %cs);
    %r<verdict> = 'fat'; %r<signature> = $signature;
    %r<kind> = tap-diff(%of, %cf) ?? 'tests' !! 'exit status';
    %r<debt> = transform-info($tname)<relation> eq 'same-verdicts' && tap-diff(%os, %of).Bool;
    # the minimum: the fewest groups that still part the engines the same way
    my @need = @groups;
    if %c<shrink> && @groups.elems > 1 {
        my $probe = $at.add("$base.probe.t");
        my %m = ddmin(@groups, -> @g {
            $probe.spurt(render($seed, @g));
            my %o = on(%c<oracle>, $probe); my %d = on(%c<candidate>, $probe);
            tap-signature(%o, %d) eq $signature
        }, %c<shrink-budget>);
        @need = %m<items>.list; %r<shrink-calls> = %m<calls>;
    }
    %r<needed> = @need.map(*.label).List;
    my $min = render($seed, @need);
    if transform-info($tname)<renames> {
        # the minimum can expose an incomplete rename the full file hid
        my $probe = $at.add("$base.min.t"); $probe.spurt($min);
        return %(|%r, verdict => 'skip', note => 'the oracle reports a renamed name as unresolved (an incomplete rename)')
            if @need.first({ names-in(on(%c<oracle>, $probe)<stderr>, $_) });
    }
    my $dir = %c<out>.add('findings').add(spec-dir($name)).add($rel); $dir.mkdir;
    $dir.add('seed.t').spurt($seed); $dir.add('fat.t').spurt(render($seed, @groups)); $dir.add('min.t').spurt($min);
    my $min-file = $dir.add('min.t');
    my %om = on(%c<oracle>, $min-file); my %cm = on(%c<candidate>, $min-file);
    $dir.add('oracle.stdout').spurt(%om<stdout>); $dir.add('oracle.stderr').spurt(%om<stderr>);
    $dir.add('candidate.stdout').spurt(%cm<stdout>); $dir.add('candidate.stderr').spurt(%cm<stderr>);
    my @rows = tap-diff(%om, %cm).head(40).map({ "| {.[0]} | {.[1]} | {.[2]} |" });
    $dir.add('finding.md').spurt(qq:to/MD/);
        # {$rel} under {$name}

        Verdict **fat**{%r<debt> ?? ' (and DEBT: the oracle changed its own verdicts under a transform that promises it would not)' !! ''}:
        the engines agree on the seed and disagree on the fattened file.

        - signature: {md-cell($signature)}
        - groups needed: {@need.elems} of {@groups.elems}{%r<shrink-calls> ?? " (found in {%r<shrink-calls>} delta-debugging calls)" !! ''}
        {@need.map({ "  - {md-cell(.label)}" }).join("\n")}
        {%r<kept> ?? "- names kept, since the oracle reported their rename: " ~ %r<kept>.map({ md-cell($_) }).join(', ') !! ''}
        - oracle: {md-cell(%c<oracle-id>)}, candidate: {md-cell(%c<candidate-id>)}

        `min.t` is the seed with only those groups applied; `fat.t` has all of them.
        Reproduce from the Roast checkout, with its Test::Helpers on RAKULIB:

            cd {$root.absolute}
            RAKULIB=packages/Test-Helpers {%c<oracle>} {$min-file.absolute}
            RAKULIB=packages/Test-Helpers {%c<candidate>} {$min-file.absolute}

        | test (depth:number) | oracle | candidate |
        |---|---|---|
        {@rows.join("\n")}
        {@rows ?? '' !! "Every test agrees; the exit status differs: oracle {%om<status>} {%om<exit>}, candidate {%cm<status>} {%cm<exit>}."}
        MD
    %r<dossier> = $dir.Str;
    %r
}

sub campaign(:@transforms!, :@files!, IO::Path:D :$roast!, IO::Path:D :$out!,
             Str:D :$oracle = 'rakudo', Str:D :$candidate = 'rakupp', Int:D :$jobs = 4,
             Int:D :$timeout = 90, Bool:D :$shrink = True, Int:D :$shrink-budget = 24 --> List:D) is export {
    write-dir($out);
    my %c = :$roast, :$out, :$oracle, :$candidate, :$timeout, :$shrink, :$shrink-budget,
            tmp => write-dir($out.add('tmp')),
            oracle-id => engine-identity($oracle), candidate-id => engine-identity($candidate);
    my @results;
    for @transforms -> $name {
        parse-spec($name);   # an unknown name dies here, before any work
        my $lock = Lock.new;
        for @files.race(:batch(1), :degree($jobs)).map(-> $rel {
            my %r = try { judge($rel, $name, %c) } // %( :$rel, transform => $name, chapter => chapter-of($rel),
                        verdict => 'error', note => ($! // 'unknown').Str.lines.head // '' );
            $lock.protect: {
                say sprintf('%-6s %-17s %s%s', %r<verdict>, $name, $rel,
                    %r<signature> ?? "  [{%r<signature>}]" !! %r<note> ?? "  ({%r<note>})" !! '');
            };
            %r
        }) -> %r { @results.push: %r }
    }
    write-report($out, @results, %c);
    @results.List
}

sub write-report(IO::Path:D $out, @results, %c) {
    my @v = <agree fat base skip error>;
    my $md = "# FastRoast\n\noracle {md-cell(%c<oracle-id>)}, candidate {md-cell(%c<candidate-id>)}\n\n";
    for @results.map(*<transform>).unique.sort -> $t {
        my @r = @results.grep(*<transform> eq $t);
        $md ~= "## $t ({transform-info(parse-spec($t)[0])<about>})\n\n| chapter | files | " ~ @v.join(' | ') ~ " |\n|---|" ~ ('---|' x (@v + 1)) ~ "\n";
        for @r.map(*<chapter>).unique.sort -> $ch {
            my @c = @r.grep(*<chapter> eq $ch);
            $md ~= "| $ch | {@c.elems} | " ~ @v.map(-> $v { @c.grep(*<verdict> eq $v).elems }).join(' | ') ~ " |\n";
        }
        $md ~= "| **all** | {@r.elems} | " ~ @v.map(-> $v { @r.grep(*<verdict> eq $v).elems }).join(' | ') ~ " |\n\n";
        my @f = @r.grep(*<verdict> eq 'fat').sort(*<rel>);
        if @f {
            $md ~= "Findings:\n\n";
            for @f -> %f {
                $md ~= "- `{%f<rel>}` — {%f<kind>}: {md-cell(%f<signature>)}{%f<debt> ?? ' **debt**' !! ''}; needs "
                    ~ (%f<needed> // ()).map({ md-cell($_) }).join(', ') ~ "\n";
            }
            $md ~= "\n";
        }
    }
    $out.add('report.md').spurt($md);
    $out.add('results.tsv').spurt("transform\tfile\tverdict\tsignature\tnote\n"
        ~ @results.sort({ .<transform>, .<rel> }).map({ (.<transform>, .<rel>, .<verdict>, .<signature> // '', .<note> // '').join("\t") }).join("\n") ~ "\n");
}
