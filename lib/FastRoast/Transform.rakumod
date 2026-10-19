unit module FastRoast::Transform;

# The fattening transforms. Each is named and versioned (a renamed or changed
# rule is a new version, so findings stay reproducible), and turns a seed's
# source into EDIT GROUPS: the minimizer later drops groups to find the few a
# divergence needs, so a group is the unit that must stay consistent (every
# occurrence of one renamed variable is one group; every string literal is
# its own).
#
# A transform also declares the RELATION it promises:
#   oracle         the fattened program may behave differently from the seed;
#                  the oracle says what it now does (strings-v1, names-v1)
#   same-verdicts  every test keeps its verdict (ops-v1: the Unicode spellings
#                  are exact aliases); an oracle that breaks the promise is
#                  transformation debt, not a candidate finding

use FastRoast::Tokens;

class Edit is export { has Int $.from; has Int $.to; has Str $.text }
class Group is export { has Str $.id; has Str $.label; has Edit @.edits }

# PALETTES: what an ASCII letter becomes. A palette is the second axis of a
# campaign (`strings-v1` in `cjk`), so one rule can be run in every script.
# Every single-script palette keeps the letters in order (A..Z before a..z,
# each run ascending), so a sort over fattened strings stays a sort; the cased
# ones also keep case, so `.uc` and `.lc` still pass where they passed.
#
#   cyrillic  а-щ / А-Щ          2 bytes, cased (the case offset is 0x20, as ASCII's)
#   latin1    à-ú / À-Ú (no ×÷)  2 bytes, cased, precomposed letters with marks
#   cjk       一… ideographs      3 bytes, no case
#   hangul    가… syllables       3 bytes, no case, NFD splits each into jamo
#   astral    𝐚-𝐳 / 𝐀-𝐙 bold     4 bytes, letters without a case mapping
#   marks     a̲ (letter + U+0332) one grapheme of two codepoints, cased; no
#                                 precomposed form, so NFC keeps both
#   mixed     each letter from the palette its position picks, in turn: every
#             byte width and both kinds of grapheme in one string. It keeps
#             neither order nor case, which an oracle-relation transform allows:
#             a sort or `.uc` test may now fail, on both engines alike
my sub series(Int $from, Int $count, :@skip = ()) {
    (my @c = ($from .. 0x10FFFF).grep({ $_ ∉ @skip }).head($count)).map(*.chr).List
}
my @LOWER = 'a' .. 'z'; my @UPPER = 'A' .. 'Z';
my %PALETTE-LETTERS =
    cyrillic => [ series(0x430, 26),          series(0x410, 26) ],
    latin1   => [ series(0xE0, 26, :skip(0xF7,)), series(0xC0, 26, :skip(0xD7,)) ],
    cjk      => [ series(0x4E00 + 26, 26),    series(0x4E00, 26) ],
    hangul   => [ series(0xAC00 + 26, 26),    series(0xAC00, 26) ],
    astral   => [ series(0x1D41A, 26),        series(0x1D400, 26) ],
    marks    => [ @LOWER.map(* ~ "\x[332]").List, @UPPER.map(* ~ "\x[332]").List ];
my @ROTATION = <latin1 cjk hangul astral marks cyrillic>;
%PALETTE-LETTERS<mixed> = [
    (^26).map({ %PALETTE-LETTERS{@ROTATION[$_ % @ROTATION]}[0][$_] }).List,
    (^26).map({ %PALETTE-LETTERS{@ROTATION[$_ % @ROTATION]}[1][$_] }).List ];
my %PALETTES = %PALETTE-LETTERS.kv.map(-> $name, @l {
    $name => %( |(@LOWER Z=> @l[0].list), |(@UPPER Z=> @l[1].list) )
});

sub palette-names(--> List:D) is export { <mixed cyrillic latin1 cjk hangul astral marks> }
sub palette(Str:D $name --> Hash:D) is export {
    %PALETTES{$name} // die "unknown palette '$name' (choose {palette-names.join(', ')})"
}
sub fat-letters(Str:D $s, Str:D $palette = 'mixed' --> Str:D) is export {
    my %m := palette($palette);
    $s.comb.map({ %m{$_} // $_ }).join
}

sub line-of(Str:D $source, Int:D $at --> Int:D) { $source.substr(0, $at).indices("\n").elems + 1 }
sub excerpt(Str:D $s --> Str:D) { my $t = $s.subst(/\s+/, ' ', :g); $t.chars > 40 ?? $t.substr(0, 37) ~ '...' !! $t }

# Apply the edits of `@groups` to `$source` (they never overlap).
sub render(Str:D $source, @groups --> Str:D) is export {
    my @e = @groups.map(*.edits.Slip).sort(*.from);
    my $out = ''; my $at = 0;
    for @e -> $e { $out ~= $source.substr($at, $e.from - $at) ~ $e.text; $at = $e.to }
    $out ~ $source.substr($at)
}

# --- strings-v1 ------------------------------------------------------------
# The letters inside string literals, keeping the quoting construct, escapes
# (`\n`, `\x[41]`, `\c[NAME]`) and interpolations (`$x`, `@a`, `{ … }`). A
# string in a `use`, `no`, `need` or `require` statement is a name (a pragma
# argument, a module, a version), not data, and is left alone, as are the
# brackets that name an operator (`infix:<before>`); so is a
# multi-line token (a heredoc), whose terminator must stay as it is.
my @QUOTES = "'", '"', '<', '«', '｢', '“', '‘';
sub fat-string(Str:D $t, Str:D $palette = 'mixed' --> Str:D) is export {
    my %map := palette($palette);
    return $t if $t.contains("\n") || $t.chars < 2;
    my $m = $t ~~ / ^ ( Q | qqww | qqw | qqx | qq | qw | qx | ww | q )? ( [ ':' '!'? \w+ [ '(' <-[)]>* ')' ]? ]* ) \s* /;
    my $start = $m.to;
    return $t if $start >= $t.chars - 1;
    return $t if !$m[0].defined && $t.substr(0, 1) ne any(@QUOTES);
    my @c = $t.substr($start + 1, $t.chars - $start - 2).comb;
    my $out = ''; my $i = 0;
    while $i < @c.elems {
        my $c = @c[$i];
        if $c eq '\\' {
            my $j = $i + 2;
            if $i + 1 < @c.elems && @c[$i + 1] eq any(<x o c>) && $j < @c.elems && @c[$j] eq '[' {
                $j++ while $j < @c.elems && @c[$j] ne ']';
                $j++;
            }
            $out ~= @c[$i ..^ min($j, @c.elems)].join; $i = $j; next;
        }
        if $c eq any(<$ @ % &>) && $i + 1 < @c.elems && (@c[$i + 1] ~~ /<:L>/ || @c[$i + 1] eq any(<! . * ? ^ _>)) {
            my $j = $i + 2;
            $j++ while $j < @c.elems && (@c[$j] ~~ /<:L + :N>/ || @c[$j] eq any(<_ - '>));
            $out ~= @c[$i ..^ $j].join; $i = $j; next;
        }
        if $c eq '{' {
            my $depth = 0; my $j = $i;
            repeat { $depth++ if @c[$j] eq '{'; $depth-- if @c[$j] eq '}'; $j++ } until $depth == 0 || $j >= @c.elems;
            $out ~= @c[$i ..^ $j].join; $i = $j; next;
        }
        $out ~= %map{$c} // $c; $i++;
    }
    $t.substr(0, $start + 1) ~ $out ~ $t.substr(*-1)
}

sub in-use-statement(@tokens --> List:D) {
    my $in = False;
    @tokens.map(-> $t {
        $in = True if $t.class eq 'k' | 'n' && $t.text eq any(<use no need require>);
        $in = False if $t.class eq '' && $t.text.contains(';' | "\n");
        $in
    }).List
}

sub strings-v1(Str:D $source, @tokens, Str:D $palette --> List:D) {
    my @use = in-use-statement(@tokens);
    my @g;
    for @tokens.kv -> $i, $t {
        next unless $t.class eq 's' && !@use[$i];
        # `infix:<before>`, `&prefix:«-»`, `Foo::<$x>`: the brackets name an
        # operator or a symbol, so they are not data
        next if $t.from > 0 && $source.substr($t.from - 1, 1) eq ':' && $t.text.substr(0, 1) eq any(<< < « >>);
        my $f = fat-string($t.text, $palette);
        next if $f eq $t.text;
        @g.push: Group.new(id => "string-{$t.from}",
            label => "string at line {line-of($source, $t.from)}: {excerpt($t.text)}",
            edits => [Edit.new(:from($t.from), :to($t.to), :text($f))]);
    }
    @g.List
}

# --- names-v1 --------------------------------------------------------------
# Identifiers the file declares, renamed letter by letter through a palette:
# lexical variables declared with `my`/`our`/`state`/`constant` (every
# occurrence, inside interpolating strings too), and subs, classes, roles and
# grammars (every name token that spells them). A variable that is ever a
# named parameter or a named argument (`:$x`, `:x(…)`, `x => …`) keeps its
# name, since the key it binds to would not follow. Methods keep theirs: a
# user method can share its name with the core one the same file calls.
my token fat-ident { <[a..zA..Z_]> [ <[\w]> | <[-']> <[a..zA..Z_]> ]* }

# Whether the bare word at $from..$to is the name itself, not a method
# (`.foo`), a named argument (`:foo`, `foo =>`), a package (`foo::`) or part
# of another variable's name (`$foo` for sub `foo`).
sub bare-name(Str:D $source, Int:D $from, Int:D $to --> Bool:D) {
    return False if $from > 0 && $source.substr($from - 1, 1) ~~ / <[\w\-'$@%.!:^*?<]> /;
    !($source.substr($to) ~~ / ^ [ \s* '=>' | '::' ] /)
}

# A string the program compiles as code: the argument of EVAL, the name of an
# indirect lookup (`::('$x')`), or the invocant of `.EVAL`.
sub code-string(@tokens, Int:D $i --> Bool:D) {
    my $j = $i - 1;
    $j-- while $j >= 0 && @tokens[$j].class eq '' && @tokens[$j].text ~~ / ^ <[\s(]>* $ /;
    return True if $j >= 0 && (@tokens[$j].text eq any(<EVAL eval EVALFILE>) || @tokens[$j].text.ends-with('::(' | '::'));
    so @tokens[$i + 1 .. $i + 2].grep(*.defined).map(*.text).join.starts-with('.EVAL')
}

# The names whose rename would be incomplete. A spelling left where the tokens
# do not show the name (inside a regex, in a string the program compiles, in a
# token the highlighter cut wrongly) would leave the program naming what it no
# longer declares, so such a name keeps its spelling. In any other string a
# spelling is prose (a test's description) and does not count, nor does a
# bare word that is not the name (see bare-name).
sub incomplete(@tokens, Str:D $source, %groups --> List:D) {
    my %at = %groups.map({ .key => .value.map(*.from).Set });
    my %bad;
    for @tokens.kv -> $i, $t {
        next if $t.class.starts-with('c') || $t.class eq 's' && !code-string(@tokens, $i);
        for $t.text.match(/ (<[$@%&]>?) (<&fat-ident>) /, :g) -> $m {
            my ($sigil, $word) = ~$m[0], ~$m[1];
            my $from = $t.from + $m.from;
            my @keys = $sigil eq '&' ?? ("&$word", $word) !! $sigil ?? ("$sigil$word",) !! ($word, "&$word");
            next if !$sigil && !bare-name($source, $from, $t.from + $m.to);
            for @keys -> $k {
                %bad{$k} = True if %at{$k} && !(%at{$k}{$from} || %at{$k}{$from - 1});
            }
        }
    }
    %bad.keys.List
}

sub names-v1(Str:D $source, @tokens, Str:D $palette --> List:D) {
    my %vars;
    for $source.match(/ <|w> [ my | our | state | constant ] \s+ [ '(' \s* ]? ( <[$@%&]> <&fat-ident> ) /, :g) -> $m {
        %vars{~$m[0]} = True;
    }
    for $source.match(/ <|w> [ my | our | state ] \s* '(' (<-[)]>+) ')' /, :g) -> $m {
        %vars{~$_} = True for $m[0].match(/ <[$@%&]> <&fat-ident> /, :g);
    }
    my %named;
    for %vars.keys -> $v {
        my $bare = $v.substr(1);
        %named{$v} = True if $source.contains(":$v") || $source ~~ / [ ':' $bare '(' | <|w> $bare \s* '=>' ] /;
    }
    my %subs;
    my $want = False; my $augment = False;
    for @tokens -> $t {
        next if $t.class eq '' && $t.text ~~ / ^ \s* $ /;
        if $t.text eq any(<augment supersede>) { $augment = True; next }
        # `augment class Str` names the core class, not one the file declares
        if $t.class eq 'k' && $t.text eq any(<sub class role grammar>) { $want = !$augment; $augment = False; next }
        %subs{$t.text} = True if $want && $t.class eq 'n' && $t.text ~~ / ^ <&fat-ident> $ /;
        $want = False; $augment = False;
    }
    my %groups;
    my sub add(Str $name, Int $from, Int $to, Str $text) {
        %groups{$name} //= [];
        %groups{$name}.push: Edit.new(:$from, :$to, :$text);
    }
    for @tokens -> $t {
        if $t.class eq 'nv' && %vars{$t.text} && !%named{$t.text} {
            add($t.text, $t.from, $t.to, $t.text.substr(0, 1) ~ fat-letters($t.text.substr(1), $palette));
        }
        elsif $t.class eq 'n' && %subs{$t.text} && bare-name($source, $t.from, $t.to) {
            add($t.text, $t.from, $t.to, fat-letters($t.text, $palette));
        }
        elsif $t.class eq 's' && ($t.text.starts-with('"') || $t.text.starts-with('qq')) {
            for $t.text.match(/ <[$@%&]> <&fat-ident> <!before <[\w'-]>> /, :g) -> $m {
                my $v = ~$m;
                next unless %vars{$v} && !%named{$v};
                add($v, $t.from + $m.from, $t.from + $m.to, $v.substr(0, 1) ~ fat-letters($v.substr(1), $palette));
            }
        }
        elsif $t.class eq 'nv' && $t.text.starts-with('&') && %subs{$t.text.substr(1)} {
            add($t.text.substr(1), $t.from, $t.to, '&' ~ fat-letters($t.text.substr(1), $palette));
        }
    }
    %groups{$_}:delete for incomplete(@tokens, $source, %groups);
    %groups.sort(*.key).map(-> $p {
        Group.new(id => "name:{$p.key}", label => "{$p.key} ({$p.value.elems}×) -> {fat-letters($p.key, $palette)}", edits => $p.value.list)
    }).List
}

# --- ops-v1 ----------------------------------------------------------------
# Texas operator spellings replaced by their Unicode forms, which the language
# defines as exact aliases: every test keeps its verdict. Strings, regexes and
# comments are protected; the infix arithmetic rules fire only between spaces
# after a term, so a Whatever `*`, a prefix `-` or `//` is never touched.
my @OPS =
    'set ops' => / '(elem)' /   => '∈', 'set ops' => / '(cont)' / => '∋',
    'set ops' => / '(|)' /      => '∪', 'set ops' => / '(&)' /    => '∩',
    'set ops' => / '(-)' /      => '∖', 'set ops' => / '(^)' /    => '⊖',
    'set ops' => / '(<=)' /     => '⊆', 'set ops' => / '(>=)' /   => '⊇',
    'set ops' => / '(<)' /      => '⊂', 'set ops' => / '(>)' /    => '⊃',
    'set ops' => / '(==)' /     => '≡', 'set ops' => / '(+)' /    => '⊎',
    'set ops' => / '(.)' /      => '⊍',
    'comparison' => / <!after <[<=!>]>> '<=' <!before <[>=]>> / => '≤',
    'comparison' => / <!after <[<=!>-]>> '>=' <!before <[>=]>> / => '≥',
    'comparison' => / <!after <[!=]>> '!=' <!before <[=:]>> /    => '≠',
    'comparison' => / '=~=' /   => '≅',
    'arithmetic' => / <?after <[\w)\]]> \s> '*' <?before \s> /   => '×',
    'arithmetic' => / <?after <[\w)\]]> \s> '/' <?before \s> /   => '÷',
    'arithmetic' => / <?after <[\w)\]]> \s> '-' <?before \s> /   => '−',
    'sequence'   => / <?after <[\w)\]]> \s> '...' <?before \s> / => '…',
    'hyper'      => / '>>.' /   => '».',
    'constants'  => / <!after <[\w$@%&'-]>> 'Inf' <!before <[\w'-]>> /  => '∞',
    'constants'  => / <!after <[\w$@%&'.-]>> 'pi' <!before <[\w'-]>> /  => 'π',
    'constants'  => / <!after <[\w$@%&'.-]>> 'tau' <!before <[\w'-]>> / => 'τ';

sub ops-v1(Str:D $source, @tokens, Str $? --> List:D) {
    my @protected = False xx $source.chars;
    for @tokens -> $t {
        next unless $t.class.starts-with('s') || $t.class.starts-with('c');
        @protected[$_] = True for $t.from ..^ $t.to;
    }
    # the token a match follows (whitespace skipped): an infix needs a TERM
    # before it, and a name may be a listop (`is * * 2`: the first star is a Whatever)
    my @owner = Int xx $source.chars;
    for @tokens.kv -> $i, $t { @owner[$_] = $i for $t.from ..^ $t.to }
    my sub after-term(Int $at --> Bool) {
        my $p = $at - 1;
        $p-- while $p >= 0 && $source.substr($p, 1) ~~ /\s/;
        return False if $p < 0;
        my $t = @tokens[@owner[$p] // return False];
        so $t.class eq any(<mi mf nv s>) || ($t.class eq '' && $source.substr($p, 1) eq any(<) ] }>))
    }
    my @g; my %taken;
    for @OPS -> $rule {
        my ($family, $rx, $to) = $rule.key, $rule.value.key, $rule.value.value;
        for $source.match($rx, :g) -> $m {
            next if ($m.from ..^ $m.to).first({ @protected[$_] || %taken{$_} }).defined;
            next if $family eq 'arithmetic' | 'sequence' && !after-term($m.from);
            %taken{$_} = True for $m.from ..^ $m.to;
            @g.push: Group.new(id => "op-{$m.from}",
                label => "$family at line {line-of($source, $m.from)}: {~$m} -> $to",
                edits => [Edit.new(:from($m.from), :to($m.to), :text($to))]);
        }
    }
    @g.sort(*.edits[0].from).List
}

my %TRANSFORMS =
    'strings-v1' => %( relation => 'oracle', code => &strings-v1, palette => True,
        about => 'letters in string literals -> another script (a palette)' ),
    'names-v1'   => %( relation => 'oracle', code => &names-v1, palette => True, renames => True,
        about => 'declared variables, subs, classes, roles and grammars renamed into another script (a palette)' ),
    'ops-v1'     => %( relation => 'same-verdicts', code => &ops-v1, palette => False,
        about => 'Texas operator spellings -> their Unicode aliases (∈ ∪ ≤ ≠ × ÷ − … ». ∞ π)' );

sub transform-names(--> List:D) is export { %TRANSFORMS.keys.sort.List }
sub transform-info(Str:D $name --> Hash:D) is export {
    %TRANSFORMS{$name} // die "unknown transform '$name' (choose {transform-names.join(', ')})"
}
sub transform(Str:D $name, Str:D $source, @tokens, Str:D :$palette = 'mixed' --> List:D) is export {
    transform-info($name)<code>($source, @tokens, $palette)
}

# A campaign runs SPECS: a transform's name and, for one that maps letters, the
# palette it maps them into, as in `strings-v1:cjk`. `parse-spec` checks both
# names and gives the palette (Str for a transform without one).
sub parse-spec(Str:D $spec --> List:D) is export {
    my ($name, $palette) = $spec.split(':', 2);
    my %i := transform-info($name);
    die "transform '$name' takes no palette" if $palette.defined && !%i<palette>;
    palette($palette) if $palette.defined;
    ($name, %i<palette> ?? $palette // 'mixed' !! Str)
}
# Every name in @names that takes a palette and has none, once per palette.
sub expand-specs(@names, @palettes --> List:D) is export {
    my @p = @palettes || ('mixed',);
    @names.map(-> $n {
        $n.contains(':') || !transform-info($n)<palette> ?? $n !! @p.map({ "$n:$_" }).Slip
    }).map({ parse-spec($_); $_ }).List
}
# A spec as a directory name.
sub spec-dir(Str:D $spec --> Str:D) is export { $spec.subst(':', '.', :g) }
