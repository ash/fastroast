unit module FatRoast::Transform;

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

use FatRoast::Tokens;
use FatRoast::CoreNames;

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

# --- version 2 -------------------------------------------------------------
# strings-v2, names-v2 and ops-v2 keep the v1 rules and add what Roast showed
# them breaking on every engine (2026-10-23: Raku++ and Rakudo 2026.09 refused
# the same fattened files). A file the fat stops compiling, or code the
# program runs from a string and the fat rewrote, says nothing about either
# engine: the edit was the transform's defect, so v2 does not make it.

# Routines whose first argument, a Str, is code: EVAL, Test's and Roast's
# Test::Util (`throws-like 'isa(@arr, Array)', …`, `is_run ｢…｣, …`).
my @CODE-ROUTINES = <EVAL eval EVALFILE throws-like eval-dies-ok eval-lives-ok
    eval_dies_ok eval_lives_ok is_run get_out doesn't-hang warns-like
    doesn't-warn no-fatal-throws-like throws-like-any run-with-tty>;
# Routines whose every argument is a command or its arguments.
my @COMMAND-ROUTINES = <run shell qx qqx>;
# Meta-methods whose first argument names a method.
my @NAME-METHODS = <can lookup find_method find_private_method add_method
    add_multi_method add_private_method declares_method>;

# The token before $i, skipping whitespace, comments and an opening paren
# (-1 when there is none).
sub token-before(@tokens, Int:D $i --> Int:D) {
    my $j = $i - 1;
    $j-- while $j >= 0 && (@tokens[$j].class.starts-with('c')
        || @tokens[$j].class eq '' && @tokens[$j].text ~~ / ^ <[\s(]>* $ /);
    $j
}

# The tokens of the arguments of the call that token $r names, each as its
# index => the argument it is in (0 for the first): to the `)` of a call
# with parens, and for a listop to the `;` or the bracket that ends its
# statement.
sub call-args(@tokens, Int:D $r --> List:D) {
    my $base = +($r + 1 < @tokens.elems && @tokens[$r + 1].class eq '' && @tokens[$r + 1].text.starts-with('('));
    my $depth = 0; my $arg = 0; my @out;
    TOKEN: for $r + 1 ..^ @tokens.elems -> $k {
        my $t = @tokens[$k];
        if $t.class ne '' {
            @out.push: $k => +$arg if $depth >= $base && !$t.class.starts-with('c');
            next;
        }
        for $t.text.comb -> $c {
            if $c eq '(' | '[' | '{' { $depth++ }
            elsif $c eq ')' | ']' | '}' { last TOKEN if --$depth < $base }
            elsif $c eq ';' && $depth <= $base { last TOKEN }
            elsif $c eq ',' && $depth == $base { $arg++ }
        }
    }
    @out.List
}

# For each token, whether it is a string the program runs or resolves rather
# than data: code (the first argument of a CODE-ROUTINE and what is
# concatenated to it, the invocant of `.EVAL`, the program after `-e`), a
# command (any argument of a COMMAND-ROUTINE or of `Proc::Async.new`), the
# name of an operator (`cmp-ok`'s second argument), of a method (`.can('x')`,
# `."x"()`) or of a symbol looked up (`::('x')`).
sub run-strings(@tokens, Str:D $source --> List:D) {
    my @run = False xx @tokens.elems;
    for @tokens.kv -> $i, $t {
        next unless $t.class eq 'n' | 'nb' | 'k';
        my $method = $t.from > 0 && $source.substr($t.from - 1, 1) eq '.' | '^';
        if !$method && $t.text eq any(@COMMAND-ROUTINES)
          || $t.text eq 'new' && $source.substr(0, $t.from).ends-with('Proc::Async.') {
            @run[.key] = True for call-args(@tokens, $i);
        }
        elsif !$method && $t.text eq 'cmp-ok' {
            @run[.key] = True for call-args(@tokens, $i).grep(*.value == 1);
        }
        elsif $method && $t.text eq any(@NAME-METHODS) {
            @run[.key] = True for call-args(@tokens, $i).grep(*.value == 0);
        }
    }
    for @tokens.kv -> $i, $t {
        next unless $t.class eq 's';
        my $p = token-before(@tokens, $i);
        if $p >= 0 {
            my $pt = @tokens[$p];
            my $pp = token-before(@tokens, $p);
            @run[$i] = True if $pt.class ne 's' && $pt.text eq any(@CODE-ROUTINES)
                || $pt.text.ends-with('::(' | '::')
                || $pt.class eq '' && $pp >= 0 && (
                       $pt.text.trim eq '~' && @run[$pp]
                    || $pt.text.trim eq ',' && @tokens[$pp].text eq "'-e'" | '"-e"');
        }
        @run[$i] = True if @tokens[$i + 1 .. $i + 2].grep(*.defined).map(*.text).join.starts-with('.EVAL');
        @run[$i] = True if $t.from > 0 && $source.substr($t.from - 1, 1) eq '.' | '^'
            && $source.substr($t.to, 1) eq '(';
    }
    @run.List
}

# --- strings-v2 ------------------------------------------------------------
# strings-v1's letters, and v1's exceptions, and also left alone:
#   - a heredoc's opener (`q:to/END/`): it holds the terminator, and mapped,
#     the heredoc never ends (45 Roast files refused)
#   - the hex, octal or decimal digits of `\xab`, `\o17`, `\c65` without
#     brackets (v1 kept only the bracketed ones; 6 files)
#   - everything a `"…"` interpolates: the postfixes after a variable
#     (`$x.^name()`, `@a[0]`, `%h<k>`, `&f()`), `$<name>`, `$0`, `$(…)`
#   - a shell command (`qx`, `:x`) and the strings of run-strings
#   - a range's or sequence's endpoint (`'a'..'z'`) and a `.trans` range
#     (`'a..z'`): mixed letters make them ranges over 20,000 codepoints
#   - the name in a `:sym<…>`
#   - a word of a word list that is a number: `<NaN+Inf\i>`, `<0xff>`, `<1e3>`
#     are allomorphs, and with their letters mapped, strings
#   - a "string" that spells an operator the file declares: in `sub
#     prefix:<'foo1'> …; is('foo1'3, …)` the quotes are the operator's
#   - a string, or a word of a word list, that spells a name the program
#     knows: a core one (`'Str'`, `'True'`, `'X::AdHoc'`, FatRoast::CoreNames)
#     or one the file declares (a type, a routine, an accessor, an enum's
#     value). A test compares it with what code prints: mapped, `allo.^name
#     eq 'Str'` turned S32-str/val.t's logic around. And the word list an
#     `enum` declares its values with is code, not data
my @QUOTES-V2 = "'", '"', '<', '«', '｢', '“', '‘', '„', '‚', '”', '’';
sub fat-string-v2(Str:D $t, Str:D $palette = 'mixed', :&known = -> $ { False } --> Str:D) is export {
    my %map := palette($palette);
    return $t if $t.contains("\n") || $t.chars < 2;
    my $m = $t ~~ / ^ ( Q | qqww | qqw | qqx | qq | qw | qx | ww | q )? ( [ \s* ':' '!'? \w+ [ '(' <-[)]>* ')' ]? ]* ) \s* /;
    return $t if ~$m[1] ~~ / ':' [ to | heredoc | x | exec ] <!before \w> / || ($m[0] // '') eq 'qx' | 'qqx';
    my $start = $m.to;
    return $t if $start >= $t.chars - 1;
    return $t if !$m[0].defined && $t.substr(0, 1) ne any(@QUOTES-V2);
    my @c = $t.substr($start + 1, $t.chars - $start - 2).comb;
    my $n = @c.elems;
    my %number;
    if $t.substr(0, 1) eq '<' | '«' || ($m[0] // '') eq any(<qw qqw ww qqww>) {
        for @c.join.match(/ \S+ /, :g) -> $w {
            next unless val(~$w) ~~ Numeric || known(~$w);
            %number{$_} = True for $w.from ..^ $w.to;
        }
    }
    elsif known(@c.join) { return $t }
    my sub letter(Int $j) { $j < $n && (@c[$j] ~~ /<:L>/ || @c[$j] eq '_') }
    my sub ident-end(Int $j is copy) {
        $j++ while $j < $n && (@c[$j] ~~ /<:L + :N>/ || @c[$j] eq '_' || @c[$j] eq '-' | "'" && letter($j + 1));
        $j
    }
    my sub balanced(Int $j is copy, Str $open, Str $close) {
        my $d = 0;
        repeat { $d++ if @c[$j] eq $open; $d-- if @c[$j] eq $close; $j++ } until $d == 0 || $j >= $n;
        $j
    }
    my sub upto(Int $j, Str $close) { my $k = $j + 1; $k++ while $k < $n && @c[$k] ne $close; $k < $n ?? $k + 1 !! $j }
    # the postfixes an interpolated variable takes: subscripts, a call, and a
    # method call with its arguments (`$x.foo()`; `$x.foo` is text)
    my sub postfixes(Int $j is copy) {
        loop {
            last if $j >= $n;
            my $c = @c[$j];
            if $c eq '[' { $j = balanced($j, '[', ']') }
            elsif $c eq '{' { $j = balanced($j, '{', '}') }
            elsif $c eq '(' { $j = balanced($j, '(', ')') }
            elsif $c eq '<' | '«' { my $e = upto($j, $c eq '<' ?? '>' !! '»'); last if $e == $j; $j = $e }
            elsif $c eq '.' {
                my $k = $j + 1;
                $k++ if $k < $n && @c[$k] eq any(<^ ? ! + * &>);
                my $e = ident-end($k);
                last unless letter($k) && $e < $n && @c[$e] eq '(';
                $j = balanced($e, '(', ')');
            }
            else { last }
        }
        $j
    }
    my $out = ''; my $i = 0;
    while $i < $n {
        my $c = @c[$i];
        if $c eq '\\' {
            my $j = $i + 2;
            my $e = $i + 1 < $n ?? @c[$i + 1] !! '';
            if $e eq any(<x o c>) && $j < $n && @c[$j] eq '[' { $j = upto($j - 1, ']') max $j }
            elsif $e eq 'x' { $j++ while $j < $n && @c[$j] ~~ /<[0..9a..fA..F]>/ }
            elsif $e eq 'o' { $j++ while $j < $n && @c[$j] ~~ /<[0..7]>/ }
            elsif $e eq 'c' { if $j < $n && @c[$j] ~~ /\d/ { $j++ while $j < $n && @c[$j] ~~ /\d/ } elsif $j < $n { $j++ } }
            $j = $n if $j > $n;
            $out ~= @c[$i ..^ $j].join; $i = $j; next;
        }
        if $c eq any(<$ @ % &>) && $i + 1 < $n {
            my $d = @c[$i + 1];
            my $j;
            if letter($i + 1) { $j = ident-end($i + 1) }
            elsif $d eq any(<! . * ? ^ :>) && letter($i + 2) { $j = ident-end($i + 2) }
            elsif $c eq '$' && $d eq '<' | '/' { $j = $i + 1 + ($d eq '/') }
            elsif $c eq '$' && $d ~~ /\d/ { $j = $i + 1; $j++ while $j < $n && @c[$j] ~~ /\d/ }
            elsif $d eq '(' { $j = $i + 1 }
            if $j.defined {
                $j = postfixes($j);
                $out ~= @c[$i ..^ $j].join; $i = $j; next;
            }
        }
        if $c eq '{' {
            my $j = balanced($i, '{', '}');
            $out ~= @c[$i ..^ $j].join; $i = $j; next;
        }
        $out ~= %number{$i} ?? $c !! %map{$c} // $c; $i++;
    }
    $t.substr(0, $start + 1) ~ $out ~ $t.substr(*-1)
}

# The names a file declares, as a string may spell them: its types, its
# routines and methods, its accessors and its enums' values.
sub declared-names(Str:D $source --> Set:D) {
    my @n;
    @n.push: ~.[0] for $source.match(/ <|w> [ class | role | grammar | module | package | enum | subset | knowhow
        | [ [ multi | proto | only ] \s+ ]? [ sub | method | submethod | token | rule | regex ] | multi | proto ]
        \s+ ( <[\w:'-]>+ ) /, :g);
    @n.push: ~.[0] for $source.match(/ <|w> has \s+ [ <[\w:]>+ \s+ ]? <[$@%&]> <[.!]> ( <[\w'-]>+ ) /, :g);
    @n.append: (~.[0]).words for $source.match(/ <|w> enum \s+ [ <[\w:'-]>+ \s+ ]? [ '<' ( <-[>]>* ) '>' | '«' ( <-[»]>* ) '»' ] /, :g);
    @n.grep(*.chars).Set
}

# A string beside a range or sequence operator is one of its endpoints.
sub endpoint(@tokens, Int:D $i --> Bool:D) {
    my $before = $i > 0 && @tokens[$i - 1].class eq '' ?? @tokens[$i - 1].text.trim-trailing !! '';
    my $after = $i + 1 < @tokens.elems && @tokens[$i + 1].class eq '' ?? @tokens[$i + 1].text.trim-leading !! '';
    so $before ~~ / '..' '.'? '^'? $ / || $after ~~ / ^ '^'? '..' /
}

sub strings-v2(Str:D $source, @tokens, Str:D $palette --> List:D) {
    my @use = in-use-statement(@tokens);
    my @run = run-strings(@tokens, $source);
    # an operator spelled with quotes, `sub prefix:<'foo1'>`, reads as strings
    my $ops = $source.match(/ <[\w-]>+ ':' [ '<' (<-[>]>+) '>' | '«' (<-[»]>+) '»' ] /, :g).map(~*[0]).grep(/ <['"]> /).Set;
    my $declared = declared-names($source);
    my &known = -> $w { core-name($w) || $w ∈ $declared };
    my @g;
    for @tokens.kv -> $i, $t {
        next unless $t.class eq 's' && !@use[$i] && !@run[$i] && $t.text ∉ $ops;
        my $lead = $t.text.substr(0, 1);
        next if $lead eq any(<< < « >>) && $t.from > 0
            && ($source.substr($t.from - 1, 1) eq ':' || $source.substr(0, $t.from).ends-with('sym'));
        next if endpoint(@tokens, $i) || $t.text ~~ / <:L> '..' <:L> /;
        next if $lead eq any(<< < « >>) && $source.substr(0, $t.from) ~~ / <|w> enum \s+ [ <[\w:'-]>+ \s+ ]? $ /;
        my $f = fat-string-v2($t.text, $palette, :&known);
        next if $f eq $t.text;
        @g.push: Group.new(id => "string-{$t.from}",
            label => "string at line {line-of($source, $t.from)}: {excerpt($t.text)}",
            edits => [Edit.new(:from($t.from), :to($t.to), :text($f))]);
    }
    @g.List
}

# --- names-v2 --------------------------------------------------------------
# names-v1's renames, and v1's exceptions, and also:
#   - the category of an operator a file declares is not a sub's name:
#     `sub infix:<+>` renamed `infix` (33 files: "Cannot add tokens of
#     category")
#   - a variable is renamed in every string that interpolates, not just
#     `"…"` and `qq`: `“…”`, `„…”`, `«…»` and a `qq:to` heredoc's body; an
#     escaped `\$x` is text; and `'$a' ~ '$b'` inside one ends `$a` at the
#     quote (`$a'` stopped v1's match, so `$a` kept its spelling there)
#   - a name in code a string holds keeps its spelling: the strings of
#     run-strings (`throws-like 'isa(@arr, Array)', …`) and the `{…}` blocks
#     and `&f()` calls in an interpolating string
sub interpolates(Str:D $t --> Bool:D) {
    so $t.substr(0, 1) eq any('"', '“', '„', '”', '«') || $t.starts-with('<<') || $t.starts-with('qq')
      || $t ~~ / ^ <[qQ]> \w* [ \s* ':' '!'? \w+ ]* \s* ':' [ qq | double | s | scalar | a | array | h | hash | f | function | c | closure ] <!before \w> /
}
sub heredoc-opener(Str:D $t --> Bool:D) {
    so $t ~~ / ^ <[qQ]> \w* [ \s* ':' '!'? \w+ ]* \s* ':' [ to | heredoc ] <!before \w> /
}

# For each string token, whether it interpolates: a heredoc's body, which
# is its own token on the lines after the opener, as its opener does.
sub interpolating(@tokens, Str:D $source --> List:D) {
    my @bodies; my @i = False xx @tokens.elems;
    for @tokens.kv -> $k, $t {
        next unless $t.class eq 's';
        if heredoc-opener($t.text) { @bodies.push: interpolates($t.text); next }
        if @bodies && $t.text.contains("\n") && ($t.from == 0 || $source.substr($t.from - 1, 1) eq "\n") {
            @i[$k] = @bodies.shift; next;
        }
        @i[$k] = interpolates($t.text);
    }
    @i.List
}

# The parts of an interpolating string that are code: its `{…}` blocks and
# its `&f(…)` calls, as (offset, text).
sub code-parts(Str:D $text --> List:D) {
    my @p;
    for $text.match(/ <!after '\\'> '{' /, :g) -> $m {
        my $d = 0; my $j = $m.from;
        repeat { $d++ if $text.substr($j, 1) eq '{'; $d-- if $text.substr($j, 1) eq '}'; $j++ } until $d == 0 || $j >= $text.chars;
        @p.push: ($m.from, $text.substr($m.from, $j - $m.from));
    }
    @p.push: (.from, ~$_) for $text.match(/ <!after '\\'> '&' <&fat-ident> <?before '('> /, :g);
    @p.List
}

sub incomplete-v2(@tokens, Str:D $source, %groups, @run, @interp --> List:D) {
    my %at = %groups.map({ .key => .value.map(*.from).Set });
    my %bad;
    for @tokens.kv -> $i, $t {
        next if $t.class.starts-with('c');
        my @parts = $t.class ne 's' || @run[$i] ?? ((0, $t.text),) !! @interp[$i] ?? code-parts($t.text) !! ();
        for @parts -> ($off, $text) {
            for $text.match(/ (<[$@%&]>?) (<&fat-ident>) /, :g) -> $m {
                my ($sigil, $word) = ~$m[0], ~$m[1];
                my $from = $t.from + $off + $m.from;
                my @keys = $sigil eq '&' ?? ("&$word", $word) !! $sigil ?? ("$sigil$word",) !! ($word, "&$word");
                next if !$sigil && !bare-name($source, $from, $from + $m.chars);
                for @keys -> $k {
                    %bad{$k} = True if %at{$k} && !(%at{$k}{$from} || %at{$k}{$from - 1});
                }
            }
        }
    }
    %bad.keys.List
}

sub names-v2(Str:D $source, @tokens, Str:D $palette --> List:D) {
    my %vars;
    # `constant &postfix:<`> = …` declares an operator: `postfix` is its category
    for $source.match(/ <|w> [ my | our | state | constant ] \s+ [ '(' \s* ]? ( <[$@%&]> <&fat-ident> ) <!before ':' <-[:]>> /, :g) -> $m {
        %vars{~$m[0]} = True;
    }
    for $source.match(/ <|w> [ my | our | state ] \s* '(' (<-[)]>+) ')' /, :g) -> $m {
        %vars{~$_} = True for $m[0].match(/ <[$@%&]> <&fat-ident> /, :g);
    }
    my %named;
    for %vars.keys -> $v {
        my $bare = $v.substr(1);
        %named{$v} = True if $source.contains(":$v") || $source ~~ / [ ':' $bare '(' | <|w> $bare \s* '=>' ] /;
        # a placeholder `$^foo` or `$:foo` declares the `$foo` its block reads
        %named{$v} = True if $source.contains($v.substr(0, 1) ~ '^' ~ $bare) || $source.contains($v.substr(0, 1) ~ ':' ~ $bare);
    }
    my %subs;
    my $want = False; my $augment = False;
    for @tokens -> $t {
        next if $t.class eq '' && $t.text ~~ / ^ \s* $ /;
        if $t.text eq any(<augment supersede>) { $augment = True; next }
        if $t.class eq 'k' && $t.text eq any(<sub class role grammar>) { $want = !$augment; $augment = False; next }
        # `sub infix:<+>` declares an operator: `infix` is its category
        %subs{$t.text} = True if $want && $t.class eq 'n' && $t.text ~~ / ^ <&fat-ident> $ /
            && $source.substr($t.to, 2) !~~ / ^ ':' <-[:]> /
            && !$source.contains(any(":<{$t.text}>", ":«{$t.text}»"));   # `sub rightly` beside `infix:<rightly>`
        $want = False; $augment = False;
    }
    my @run = run-strings(@tokens, $source);
    my @interp = interpolating(@tokens, $source);
    my %groups;
    my sub add(Str $name, Int $from, Int $to, Str $text) {
        %groups{$name} //= [];
        %groups{$name}.push: Edit.new(:$from, :$to, :$text);
    }
    for @tokens.kv -> $i, $t {
        if $t.class eq 'nv' && %vars{$t.text} && !%named{$t.text} {
            add($t.text, $t.from, $t.to, $t.text.substr(0, 1) ~ fat-letters($t.text.substr(1), $palette));
        }
        elsif $t.class eq 'n' && %subs{$t.text} && bare-name($source, $t.from, $t.to) {
            add($t.text, $t.from, $t.to, fat-letters($t.text, $palette));
        }
        elsif $t.class eq 's' && @interp[$i] {
            for $t.text.match(/ <!after '\\'> <[$@%&]> <&fat-ident> <!before \w> /, :g) -> $m {
                my $v = ~$m;
                next unless %vars{$v} && !%named{$v};
                add($v, $t.from + $m.from, $t.from + $m.to, $v.substr(0, 1) ~ fat-letters($v.substr(1), $palette));
            }
        }
        elsif $t.class eq 'nv' && $t.text.starts-with('&') && %subs{$t.text.substr(1)} {
            add($t.text.substr(1), $t.from, $t.to, '&' ~ fat-letters($t.text.substr(1), $palette));
        }
    }
    %groups{$_}:delete for incomplete-v2(@tokens, $source, %groups, @run, @interp);
    %groups.sort(*.key).map(-> $p {
        Group.new(id => "name:{$p.key}", label => "{$p.key} ({$p.value.elems}×) -> {fat-letters($p.key, $palette)}", edits => $p.value.list)
    }).List
}

# --- ops-v2 ----------------------------------------------------------------
# ops-v1's aliases, rewritten only where they are the core operator:
#   - an operator is plain text between tokens, spaced on both sides: `(|)`
#     in `sub f(|)` is a signature, `<=` in `$x +<= 1` part of a shift's
#     assignment, `>=` in `$<x>=[…]` or `%h<a b>=(…)` a subscript and an
#     assignment. The reduce form `[<=]`, `[(|)]` is one too.
#   - a set operator follows a term, as an arithmetic one does: `sub
#     GENERATE-USAGE (|)` is no union
#   - a constant is a whole name token: not the end of `$PiClass::pi`, nor
#     inside an allomorph `<NaN+Inf\i>`
#   - an operator the file declares for itself, as an infix (`multi sub
#     infix:<->(Vector, Vector)`) or a constant (`sub pi`), keeps its ASCII
#     spelling: the alias names the core one, which knows nothing of the
#     file's candidates
my @OPS-V2 =
    set => '(elem)' => '∈', set => '(cont)' => '∋', set => '(|)' => '∪', set => '(&)' => '∩',
    set => '(-)' => '∖', set => '(^)' => '⊖', set => '(<=)' => '⊆', set => '(>=)' => '⊇',
    set => '(<)' => '⊂', set => '(>)' => '⊃', set => '(==)' => '≡', set => '(+)' => '⊎',
    set => '(.)' => '⊍',
    comparison => '<=' => '≤', comparison => '>=' => '≥', comparison => '!=' => '≠', comparison => '=~=' => '≅',
    arithmetic => '*' => '×', arithmetic => '/' => '÷', arithmetic => '-' => '−',
    sequence => '...' => '…', hyper => '>>.' => '».',
    constants => 'Inf' => '∞', constants => 'pi' => 'π', constants => 'tau' => 'τ';

sub ops-v2(Str:D $source, @tokens, Str $? --> List:D) {
    my @owner = Int xx $source.chars;
    for @tokens.kv -> $i, $t { @owner[$_] = $i for $t.from ..^ $t.to }
    my sub after-term(Int $at --> Bool) {
        my $p = $at - 1;
        $p-- while $p >= 0 && $source.substr($p, 1) ~~ /\s/;
        return False if $p < 0;
        my $t = @tokens[@owner[$p] // return False];
        so $t.class eq any(<mi mf nv s>) || ($t.class eq '' && $source.substr($p, 1) eq any(<) ] }>))
    }
    my sub spaced(Int $from, Int $to --> Bool) {
        so $from > 0 && $to < $source.chars && $source.substr($from - 1, 1) ~~ /\s/ && $source.substr($to, 1) ~~ /\s/
    }
    my sub reduce(Int $from, Int $to --> Bool) {
        so $from > 0 && $source.substr($from - 1, 1) eq '[' && $source.substr($to, 1) eq ']'
    }
    my sub declared(Str $op --> Bool) {
        so $source.contains(any("infix:<$op>", "infix:«$op»", "infix:['$op']", "infix:[\"$op\"]", "infix:<<$op>>"))
    }
    my @g; my %taken;
    for @OPS-V2 -> $rule {
        my ($family, $ascii, $to) = $rule.key, $rule.value.key, $rule.value.value;
        my @at;
        if $family eq 'constants' {
            next if $source ~~ / [ sub | constant | method | 'term:' <[<«]> | '\\' ] \s* $ascii <!before \w> /;
            for @tokens -> $t {
                next unless $t.class eq 'n' | 'nb' && $t.text eq $ascii;
                next if $t.from > 0 && $source.substr($t.from - 1, 1) ~~ / <[\w$@%&'.:-]> /;
                next if $source.substr($t.to) ~~ / ^ [ '(' | ':' | \s* '=>' ] /;
                @at.push: $t.from;
            }
        }
        else {
            next if declared($ascii);
            for @tokens -> $t {
                next unless $t.class eq '';
                for $t.text.indices($ascii) -> $off {
                    my $from = $t.from + $off; my $end = $from + $ascii.chars;
                    if $family eq 'hyper' {
                        next unless $from > 0 && $source.substr($from - 1, 1) ~~ / <[\w)\]}]> /;
                    }
                    elsif $family eq 'set' | 'comparison' {
                        next unless reduce($from, $end) || spaced($from, $end) && ($family eq 'comparison' || after-term($from));
                    }
                    else {
                        next unless spaced($from, $end) && after-term($from);
                    }
                    @at.push: $from;
                }
            }
        }
        for @at -> $from {
            my $end = $from + $ascii.chars;
            next if ($from ..^ $end).first({ %taken{$_} }).defined;
            %taken{$_} = True for $from ..^ $end;
            @g.push: Group.new(id => "op-$from",
                label => "$family at line {line-of($source, $from)}: $ascii -> $to",
                edits => [Edit.new(:$from, :to($end), :text($to))]);
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
        about => 'Texas operator spellings -> their Unicode aliases (∈ ∪ ≤ ≠ × ÷ − … ». ∞ π)' ),
    'strings-v2' => %( relation => 'oracle', code => &strings-v2, palette => True,
        about => 'strings-v1, leaving heredoc openers, escapes\' digits, interpolations, code, commands and range endpoints alone' ),
    'names-v2'   => %( relation => 'oracle', code => &names-v2, palette => True, renames => True,
        about => 'names-v1, renaming no operator category and following every interpolating string and the code in strings' ),
    'ops-v2'     => %( relation => 'same-verdicts', code => &ops-v2, palette => False,
        about => 'ops-v1, only spaced operators after a term, whole constants, and none the file declares itself' );

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
