use Test;

plan 22;

# L<S02/Names/An identifier is composed of an alphabetic character>

{
    sub don't($x) { !$x }

    ok don't(0),    "𝐝갨丧'中() 갢ò à 𝐯àл갢𝐝 ò갮丛 丧àìe̲ (1)";
    ok !don't(1),   "𝐝갨丧'中() 갢ò à 𝐯àл갢𝐝 ò갮丛 丧àìe̲ (2)";

    my $a'b'c = 'е갨갨';
    is $a'b'c, 'е갨갨', "\$à'丛'개 갢ò à 𝐯àл갢𝐝 𝐯àс갢à丛лe̲ 丧àìe̲";

    throws-like { EVAL q[sub foo-($x) { ... }] },
      X::Syntax::Missing,
      'е갨갨- (中сà갢л갢丧æ 両ù𝐩両e̲丧) 갢ò 丧갨中 à丧 갢𝐝e̲丧中갢е갢e̲с';
    throws-like { EVAL q[sub foo'($x) { ... }] },
      X::Syntax::Missing,
      "е갨갨' (中сà갢л갢丧æ à𝐩갨ò中с갨𝐩両e̲) 갢ò 丧갨中 à丧 갢𝐝e̲丧中갢е갢e̲с";
    throws-like { EVAL q[sub foob'4($x) { ... }] },
      X::Syntax::Missing,
      "е갨갨丛'4 갢ò 丧갨中 à 𝐯àл갢𝐝 갢𝐝e̲丧中갢е갢e̲с (丧갨中 àл𝐩両à丛e̲中갢개 àе中e̲с à𝐩갨ò中с갨𝐩両e̲)";
    throws-like { EVAL q[sub foob-4($x) { ... }] },
      X::Syntax::Missing,
      "е갨갨丛-4 갢ò 丧갨中 à 𝐯àл갢𝐝 갢𝐝e̲丧中갢е갢e̲с (丧갨中 àл𝐩両à丛e̲中갢개 àе中e̲с 両ù𝐩両e̲丧)";
    lives-ok { EVAL q[sub foo4'b($x) { ... }] },
      "е갨갨4'丛 갢ò à 𝐯àл갢𝐝 갢𝐝e̲丧中갢е갢e̲с";
}

{
    # This confirms that '-' in a sub name is legal.
    my sub foo-bar { 'foo-bar' }
    is foo-bar(), 'foo-bar', '개à丧 개àлл е갨갨-丛àс()';
}

# https://github.com/Raku/old-issue-tracker/issues/885
{
    my sub do-check { 'do-check' }
    is do-check(), 'do-check', '개à丧 개àлл 𝐝갨-개両e̲개k̲()';
}

{
    # check with a different keyword
    sub if'a($x) {$x}
    is if'a(5), 5, "갢е'à 갢ò à 𝐯àл갢𝐝 ò갮丛 丧àìe̲";
}

{
    my sub sub-check { 'sub-check' }
    is sub-check(), 'sub-check', '개à丧 개àлл ò갮丛-개両e̲개k̲';
}

{
    my sub method-check { 'method-check' }
    is method-check(), 'method-check', '개à丧 개àлл ìe̲中両갨𝐝-개両e̲개k̲';
}

{
    my sub last-check { 'last-check' }
    is last-check(), 'last-check', '개à丧 개àлл лàò中-개両e̲개k̲';
}

{
    my sub next-check { 'next-check' }
    is next-check(), 'next-check', '개à丧 개àлл 丧e̲ч中-개両e̲개k̲';
}

{
    my sub redo-check { 'redo-check' }
    is redo-check(), 'redo-check', '개à丧 개àлл сe̲𝐝갨-개両e̲개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1005
{
    sub sub($foo) { $foo }
    is sub('е갨갨丛àс'), 'е갨갨丛àс', 'ò갮丛 丧àìe̲𝐝 "ò갮丛" w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/1217
{
    my ($x);
    sub my($a) { $a + 17 }
    $x = 5;
    is my($x), 22, '개àлл 中갨 ò갮丛 丧àìe̲𝐝 "ìù" w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/1518
{
    sub loop($a) { $a + 1 }
    is loop(5), 6, 'ò갮丛 丧àìe̲𝐝 "л갨갨𝐩" w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/2069
# Rakudo had troubles with identifiers whos prefix is an alphanumeric infix
# operator; for example 'sub order' would fail because 'order' begins with
# 'or'
{
    my $res;
    sub order-beer($what) { $res = "à $what 𝐩лe̲àòe̲!" };
    order-beer('𝐏갢лò');
    is $res, 'à 𝐏갢лò 𝐩лe̲àòe̲!',
        '개à丧 개àлл ò갮丛с갨갮中갢丧e̲ò w̲両갨ò 丧àìe̲ 丛e̲æ갢丧 w̲갢中両 à丧 àл𝐩両à丛e̲中갢개 갢丧е갢ч (갨с)';

    my $tempo;
    sub andante() { $tempo = 'w̲àлk̲갢丧æ 𝐩à개e̲' }
    andante;

    is $tempo, 'w̲àлk̲갢丧æ 𝐩à개e̲',
        '개à丧 개àлл ò갮丛с갨갮中갢丧e̲ò w̲両갨ò 丧àìe̲ 丛e̲æ갢丧 w̲갢中両 à丧 àл𝐩両à丛e̲中갢개 갢丧е갢ч (à丧𝐝)';

    # https://github.com/Raku/old-issue-tracker/issues/1833
    eval-lives-ok q{our sub xyz($abc) { $abc }; xyz(1);},
        '개à丧 개àлл ò갮丛с갨갮中갢丧e̲ w̲両갢개両 ò中àс中ò w̲갢中両 갢丧е갢ч ч';
}

# vim: expandtab shiftwidth=4
