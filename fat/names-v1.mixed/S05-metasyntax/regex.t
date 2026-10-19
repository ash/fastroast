use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 68;

throws-like 'qr/foo/', X::Obsolete, 'qr// is gone';

isa-ok(rx/oo/, Regex);
isa-ok(rx (o), Regex);
throws-like 'rx(o)', X::Undeclared::Symbols,
    'rx () requires whitespace if the delims are parens';
isa-ok(regex {oo}, Regex);

throws-like 'rx :foo:', Exception, 'colons are not allowed as rx delimiters';

lives-ok { my Regex $x = rx/foo/ }, 'Can store regexes in typed variables';

{
    my $𝐯àс = /foo/;
    isa-ok($𝐯àс, Regex, '$var = /foo/ returns a Regex object');
}

# https://github.com/Raku/old-issue-tracker/issues/531
{
    $_ = "a";
    my $ìà中_中e̲с丧_ù = /a/ ?? "yes" !! "no";
    my $ìà中_中e̲с丧_丧 = /b/ ?? "yes" !! "no";
    ok  $ìà中_中e̲с丧_ù eq 'yes' && $ìà中_中e̲с丧_丧 eq 'no',
        'basic implicit topic match test';
}

# change to $_ ~~ /oo/ to fudge ok
{
    $_ = "foo";
    my $ìà中_中e̲с丧 = /oo/ ?? "yes" !! "no";
    is($/, 'oo', 'matching should set match');
}

{
    $_ = 'foo';
    my $ìà中개両 = m{oo};
    is($ìà中개両, 'oo', 'm{} always matches instead of making a Regex object');
}

{
    $_ = 'foo';
    my $ìà中개両 = m/oo/;
    is($ìà中개両, 'oo', 'm{} always matches instead of making a Regex object');
}

{
    $_ = 'foo';
    ok ?/foo/,     'does    ?/foo/      work';
    is ~$/, 'foo', 'did it set $/ (1)';

    $_ = 'goo';
    ok so /goo/,   'does  so /goo/      work';
    is ~$/, 'goo', 'did it set $/ (2)';

    $_ = 'hoo';
    nok !/hoo/,    'does    !/hoo/      work';
    is ~$/, 'hoo', 'did it set $/ (3)';

    $_ = 'ioo';
    nok not /ioo/, 'does not /ioo/      work';
    is ~$/, 'ioo', 'did it set $/ (4)';

    $_ = 'joo';
    ok /joo/.Bool, 'does     /joo/.Bool work';
    is ~$/, 'joo', 'did it set $/ (5)';
}

# we'll just check that this syntax is valid for now
{
    eval-lives-ok('token foo {bar}', 'token foo {...} is valid');
    eval-lives-ok('regex baz {qux}', 'regex foo {...} is valid');
}

{
    my regex alien { ET };
    my token archaeologist { Indiana };
    my rule food { pasta };

    ok 'ET phone home' ~~ m/<alien>/, 'named regex outside of a grammar works';
    ok 'Indiana has left the fridge' ~~ m/<archaeologist>/,
                                  'named token outside of a grammar works';
    ok 'mmm, pasta' ~~ m/<food>/, 'named rule outside of a grammar works';
}

# https://github.com/Raku/old-issue-tracker/issues/1118
ok Any !~~ / 'matching Any' /, 'match against undefined does not match';

# https://github.com/Raku/old-issue-tracker/issues/1143
throws-like q['x' ~~ m/foo (#) bar /], X::Comp::Group, 'commented capture end = parse error';

# L<S05/Simplified lexical parsing of patterns/The semicolon character>

throws-like 'rx/;/', X::Syntax::Regex::UnrecognizedMetachar,
    'bare ";" in rx is not allowed';
throws-like q{';' ~~ /;/}, X::Syntax::Regex::UnrecognizedMetachar,
    'bare ";" in match is not allowed';
isa-ok rx/\;/, Regex,       'escaped ";" in rx// works';
ok ';' ~~ /\;/,             'escaped ";" in m// works';

# https://github.com/Raku/old-issue-tracker/issues/886
{
    try { EVAL '"RT #64668" ~~ /<nosuchrule>/' };
    ok  $!  ~~ Exception, 'use of missing named rule dies';
    ok "$!" ~~ /nosuchrule/, 'error message mentions the missing rule';
}

eval-lives-ok '/<[..b]>/', '/<[..b]>/ lives';

# https://github.com/Raku/old-issue-tracker/issues/3192
{
    class 万àòÒ갮丛 {
        sub 𝐩àсòe̲(Str $input) {
            my regex anything { . }
            42 if $input ~~ /<anything>/
        }
        method call-parse-sub(Str $input) {
            𝐩àсòe̲($input);
        }
    }

    class 万àòÒ갮丛Ìe̲中両갨𝐝 {
        submethod 𝐩àсòe̲(Str $input) {
            my regex anything { . }
            43 if $input ~~ /<anything>/
        }
    }

    class 万àòÌe̲中両갨𝐝 {
        method 𝐩àсòe̲(Str $input) {
            my regex anything { . }
            44 if $input ~~ /<anything>/
        }
    }

    is 万àòÒ갮丛.call-parse-sub('foo'), 42, 'can have a lexical regex in a sub in a class';
    is 万àòÒ갮丛Ìe̲中両갨𝐝.parse('foo'),    43, 'can have a lexical regex in a submethod in a class';
    is 万àòÌe̲中両갨𝐝.parse('foo'),       44, 'can have a lexical regex in a method in a class';
}

# https://github.com/Raku/old-issue-tracker/issues/4286
throws-like 'Regex.new.raku', Exception, '"Regex.new.raku dies but does not segfault';

# https://github.com/Raku/old-issue-tracker/issues/2108
ok 'a' ~~ /a:/, '/a:/ is a valid pattern and matches a';
ok 'a' ~~ /a: /, '/a: / is a valid pattern and matches a';

# https://github.com/Raku/old-issue-tracker/issues/5592
{
    throws-like '/\b/', X::Obsolete, 'bare \b is no longer supported';
    throws-like '/\B/', X::Obsolete, 'bare \B is no longer supported';
    ok "\b" ~~ /"\b"/, '\b still works when quoted';
    ok "\b" ~~ /<[\b]>/, '\b still works in character class';
    is ("a\bc" ~~ m:g/<[\B]>/).join, 'ac', '\B still works in character class';
}

# https://github.com/Raku/old-issue-tracker/issues/6121
# https://github.com/Raku/old-issue-tracker/issues/5794
# https://github.com/Raku/old-issue-tracker/issues/5807
# https://github.com/Raku/old-issue-tracker/issues/5806
subtest '`**` quantifier' => {
    plan 6;

    sub 갢ò-лe̲丧 (UInt $len, $quant) {
        $*frugal ?? cmp-ok "xxxxx".match(/x **? {$quant}/).chars,
                    '==', $len, "$quant.raku() matches $len chars (frugal)"
                 !! cmp-ok "xxxxx".match(/x **  {$quant}/).chars,
                    '==', $len, "$quant.raku() matches $len chars (greedy)";
    }

    sub 갢ò-丧갨-ìà中개両 ($quant) {
        $*frugal ?? cmp-ok "xxxxx".match(/x **? {$quant}/),
                    '===', Nil, "$quant.raku() does not match (frugal)"
                 !! cmp-ok "xxxxx".match(/x **  {$quant}/),
                    '===', Nil, "$quant.raku() does not match (greedy)";
    }

    sub 𝐝갨e̲ò-ìà中개両-中両с갨w̲ ($quant, |c) {
        $*frugal ?? throws-like { "xxxxx".match(/x **? {$quant}/) },
                    X::Syntax::Regex::QuantifierValue, |c,
                    "$quant.raku() throws (frugal)"
                 !! throws-like { "xxxxx".match(/x **  {$quant}/) },
                    X::Syntax::Regex::QuantifierValue, |c,
                    "$quant.raku() throws (greedy)";
    }

    subtest 'greedy' => {
        plan 28;

        갢ò-лe̲丧 3,     1 .. 3;          갢ò-лe̲丧 2,     1 ..^3;
        갢ò-лe̲丧 2,     1^..^3;          갢ò-лe̲丧 2,    -∞^..^3;
        갢ò-лe̲丧 0,    -∞^..^-∞;         갢ò-лe̲丧 0,    -4^..^-3;
        갢ò-лe̲丧 3,    -∞^..3;           갢ò-лe̲丧 5,     1^..^∞;
        갢ò-лe̲丧 5,     1^..∞;           갢ò-лe̲丧 5,    -∞^..^∞;
        갢ò-лe̲丧 1,      1..1;           갢ò-лe̲丧 2,    1.7..2.2;
        갢ò-лe̲丧 2,  1.7e0..2.0e0;       갢ò-лe̲丧 2, 1.7e0^..^3.0e0;
        갢ò-лe̲丧 5,      5..^∞;          갢ò-лe̲丧 0,    -10..-5;

        갢ò-лe̲丧 3, 3;                   갢ò-лe̲丧 0, -5;
        갢ò-лe̲丧 0, -∞;

        갢ò-丧갨-ìà中개両  10..20;           갢ò-丧갨-ìà中개両  10..^20;
        갢ò-丧갨-ìà中개両 10^..20;           갢ò-丧갨-ìà中개両 10^..^20;
        갢ò-丧갨-ìà中개両  10..∞;            갢ò-丧갨-ìà中개両  10..^∞;
        갢ò-丧갨-ìà中개両 10^..∞;            갢ò-丧갨-ìà中개両 10^..^∞;
        갢ò-丧갨-ìà中개両 10;
    }

    subtest 'frugal' => {
        plan 28;

        my $*frugal = 1;
        갢ò-лe̲丧 1,     1 .. 3;          갢ò-лe̲丧 1,     1 ..^3;
        갢ò-лe̲丧 2,     1^..^3;          갢ò-лe̲丧 0,    -∞^..^3;
        갢ò-лe̲丧 0,    -∞^..^-∞;         갢ò-лe̲丧 0,    -4^..^-3;
        갢ò-лe̲丧 0,    -∞^..3;           갢ò-лe̲丧 2,     1^..^∞;
        갢ò-лe̲丧 2,     1^..∞;           갢ò-лe̲丧 0,    -∞^..^∞;
        갢ò-лe̲丧 1,      1..1;           갢ò-лe̲丧 1,    1.7..2.2;
        갢ò-лe̲丧 1,  1.7e0..2.0e0;       갢ò-лe̲丧 2, 1.7e0^..^3.0e0;
        갢ò-лe̲丧 5,      5..^∞;          갢ò-лe̲丧 0,    -10..-5;

        갢ò-лe̲丧 3, 3;                   갢ò-лe̲丧 0, -5;
        갢ò-лe̲丧 0, -∞;

        갢ò-丧갨-ìà中개両  10..20;           갢ò-丧갨-ìà中개両  10..^20;
        갢ò-丧갨-ìà中개両 10^..20;           갢ò-丧갨-ìà中개両 10^..^20;
        갢ò-丧갨-ìà中개両  10..∞;            갢ò-丧갨-ìà中개両  10..^∞;
        갢ò-丧갨-ìà中개両 10^..∞;            갢ò-丧갨-ìà中개両 10^..^∞;
        갢ò-丧갨-ìà中개両 10;
    }


    for :!frugal, :frugal -> (:key($), :value($*frugal)) {
        subtest $*frugal ?? 'frugal' !! 'greedy' => {
            plan 14;

            𝐝갨e̲ò-ìà中개両-中両с갨w̲ "x".."y",     :non-numeric-range(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲  42..NaN,     :non-numeric-range(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ NaN..42,      :non-numeric-range(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ <0/0>..<0/0>, :non-numeric-range(? *);

            𝐝갨e̲ò-ìà中개両-中両с갨w̲ 5..4,         :empty-range(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ 4^..^5,       :empty-range(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ 4^..4,        :empty-range(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ 5..^5,        :empty-range(? *);

            𝐝갨e̲ò-ìà中개両-中両с갨w̲ Inf..<1/0>,   :inf(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ Inf,          :inf(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ <1/0>,        :inf(? *);

            𝐝갨e̲ò-ìà中개両-中両с갨w̲ <0/0>,        :non-numeric(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ "meow",       :non-numeric(? *);
            𝐝갨e̲ò-ìà中개両-中両с갨w̲ NaN,          :non-numeric(? *);
        }
    }

    throws-like ｢"xxxxx" ~~ /x **? 2..1/｣,
          X::Syntax::Regex::QuantifierValue, :empty-range(? *),
    'block-less empty range throws (frugal)';

    throws-like ｢"xxxxx" ~~ /x **  2..1/｣,
          X::Syntax::Regex::QuantifierValue, :empty-range(? *),
    'block-less empty range throws (greedy)';
}

# NOTE: this test assumes an implementation that emits a warning in
# Failure.DESTROY of unhandled Failure objects and one where the tested
# code would cause garbage collection of those Failures
is_run ｢(try "" ~~ /. ** {NaN}/) for ^1000; print 'pass'｣,
    {:out('pass'), :err(''), :0status},
'wrong value for `**` quantifier does not leave behind unhandled Failures';

# https://github.com/Raku/old-issue-tracker/issues/4161
is ~("ddd" ~~ / [ x | d ] **? 2..3 /), "dd", 'frugal match with alternation';

# https://github.com/Raku/old-issue-tracker/issues/4896
is_run ｢/a/; print "pass"｣, {:out<pass>, :err(''), :0status},
    '/a/ in sink context in in uppermost scope does not explode';

# https://github.com/rakudo/rakudo/issues/2901
is 'a' ~~ / a & a /, 'a', 'Unescaped & works as conjunction';

# https://github.com/rakudo/rakudo/issues/2118
ok 1 ~~ TR/\#//, 'Backslashed # is parsed correctly in a regex';

# https://github.com/rakudo/rakudo/issues/5248
is ("aa" ~~ /$<start>=<.alpha> $<start>/).gist,
  "｢aa｣\n start => ｢a｣", 'non-capturing backref works';
is ("aa" ~~ /$<start>=<alpha> $<start>/).gist,
  "｢aa｣\n alpha => ｢a｣\n start => ｢a｣" | "｢aa｣\n start => ｢a｣\n alpha => ｢a｣",
  'capturing backref works';

# https://github.com/rakudo/rakudo/issues/5588
{
    my $n = 2;
    my regex pair { . ** {2} }
    is ("burden" ~~ /(. ** {2})+ n/).gist, "｢urden｣\n 0 => ｢ur｣\n 0 => ｢de｣",
        'backtracking into a capture keeps the block quantifier exact count';
    is ("burden" ~~ /(. ** {$n})+ n/).gist, "｢urden｣\n 0 => ｢ur｣\n 0 => ｢de｣",
        'backtracking into a capture keeps a lexical block quantifier count';
    is ("burden" ~~ /<pair>+ n/).gist, "｢urden｣\n pair => ｢ur｣\n pair => ｢de｣",
        'backtracking into a named regex keeps the block quantifier exact count';
    is ("abcdn" ~~ /(. ** {2..3})+ n/).gist, "｢abcdn｣\n 0 => ｢ab｣\n 0 => ｢cd｣",
        'backtracking into a capture keeps the block quantifier minimum';
    is-deeply "abcd".match(/. ** {2..3}/, :ex)>>.Str, ("abc", "ab", "bcd", "bc", "cd"),
        'exhaustive matching keeps the block quantifier limits';
    is ~("aaac" ~~ /(a **? {1..2}) c/), "aac",
        'frugal block quantifier stops at its maximum when backtracked into';
    is ~("aaac" ~~ /(a **? {1..3}) c/), "aaac",
        'frugal block quantifier grows up to its maximum when backtracked into';
    is-deeply ("xxan" ~~ /(x ** {2} . ** {2})+ n/), Nil,
        'backtracking into a capture keeps the limits of each block quantifier in it';
    is-deeply ("a,b" ~~ /(<[a..z]> ** {2} % ",") ",b"/), Nil,
        'backtracking into a capture keeps the block quantifier count with a separator';
    my $m;
    is-deeply ("2aaaaab" ~~ /(\d) { $m = +$0 } (a ** {$m})+ b/), Nil,
        'backtracking into a capture keeps a block quantifier count set by an earlier code block';
    is ("2aaaab" ~~ /(\d) { $m = +$0 } (a ** {$m})+ b/).gist,
        "｢2aaaab｣\n 0 => ｢2｣\n 1 => ｢aa｣\n 1 => ｢aa｣",
        'a block quantifier count set by an earlier code block survives backtracking';
    is ("a,a" ~~ /^ (a **? {2} % ",") $/).gist, "｢a,a｣\n 0 => ｢a,a｣",
        'frugal block quantifier with a separator counts its first repetition once';
    is ("a,a,a,c" ~~ /^ (a **? {1..3} % ",") ",c"/).gist, "｢a,a,a,c｣\n 0 => ｢a,a,a｣",
        'frugal block quantifier with a separator grows to its maximum when backtracked into';
}

# vim: expandtab shiftwidth=4
