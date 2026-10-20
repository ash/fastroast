unit module FastRoast::Roast;

# Roast files as seeds. The list is Roast's own `spectest.data`, every file it
# names (Rakudo's `make spectest` leaves out the 60 marked `stress`). A seed
# is one file fudged FOR RAKUDO, since Rakudo is the oracle and the fattened
# program must be one it can run: Roast's `fudge` invoked as Rakudo's own
# spectest and Raku++'s run-roast invoke it, `--keep-exit-code
# --version=v6.d rakudo.moar`. The implementation is `rakudo.moar`, not
# `rakudo`: fudge matches a directive's name as a prefix of the
# implementation's, so `rakudo` misses the `#?rakudo.moar` lines (twelve files
# carry them). Without --keep-exit-code fudge ends every file it rewrites with
# `exit(1)`, and the engines' own exit statuses could not be compared. The
# fudged file still carries its `#?` directive lines; they are dropped, because
# an engine that honours them natively (Raku++ does) would apply them a second
# time and skip tests the oracle runs.
#
# The trees `fatten` writes are not seeds: they start from the file as Roast
# has it, directives included, and run the way Roast runs.

sub roast-files(IO::Path:D $root, :@chapters --> List:D) is export {
    my $list = $root.add('spectest.data');
    die "no spectest.data in {$root.Str}" unless $list.f;
    my @files = $list.lines.grep({ .chars && !.starts-with('#') }).map(*.words[0])
        .grep({ $root.add($_).f });
    @files .= grep(-> $f { @chapters.first({ $f.starts-with($_) }).defined }) if @chapters;
    @files.sort.List
}

# The seed program for one file: its text fudged for Rakudo, without `#?`
# lines. Str:U when Rakudo's fudge leaves nothing to run (`skip-file`).
sub roast-seed(IO::Path:D $root, Str:D $rel, IO::Path:D $tmp --> Str) is export {
    $tmp.mkdir unless $tmp.d;
    my $text;
    my $fudge = $root.add('fudge');
    if $fudge.f {
        my $out = $tmp.add($rel ~ '.fudged.t'); $out.parent.mkdir;
        my $p = run('perl', $fudge.Str, '--keep-exit-code', '--version=v6.d', 'rakudo.moar',
                    $rel, $out.absolute, :out, :err, :cwd($root.Str));
        my $to = $p.out.slurp(:close).trim; $p.err.slurp(:close);
        return Str unless $to;
        $text = ($to eq $rel ?? $root.add($rel) !! $to.IO).slurp;
        $out.unlink if $out.e;
    }
    else { $text = $root.add($rel).slurp }
    $text.lines.grep({ !/ ^ \s* '#?' / }).join("\n") ~ "\n"
}

# The chapter a file belongs to (`S32-str/uc.t` -> `S32-str`).
sub chapter-of(Str:D $rel --> Str:D) is export { $rel.split('/')[0] }
