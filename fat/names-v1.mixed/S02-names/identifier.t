use Test;

plan 22;

# L<S02/Names/An identifier is composed of an alphabetic character>

{
    sub 𝐝갨丧'中($x) { !$x }

    ok 𝐝갨丧'中(0),    "don't() is a valid sub name (1)";
    ok !don't(1),   "don't() is a valid sub name (2)";

    my $à'丛'개 = 'foo';
    is $à'丛'개, 'foo', "\$à'丛'개 is a valid variable name";

    throws-like { EVAL q[sub foo-($x) { ... }] },
      X::Syntax::Missing,
      'foo- (trailing hyphen) is not an identifier';
    throws-like { EVAL q[sub foo'($x) { ... }] },
      X::Syntax::Missing,
      "foo' (trailing apostrophe) is not an identifier";
    throws-like { EVAL q[sub foob'4($x) { ... }] },
      X::Syntax::Missing,
      "foob'4 is not a valid identifier (not alphabetic after apostrophe)";
    throws-like { EVAL q[sub foob-4($x) { ... }] },
      X::Syntax::Missing,
      "foob-4 is not a valid identifier (not alphabetic after hyphen)";
    lives-ok { EVAL q[sub foo4'b($x) { ... }] },
      "foo4'b is a valid identifier";
}

{
    # This confirms that '-' in a sub name is legal.
    my sub е갨갨-丛àс { 'foo-bar' }
    is е갨갨-丛àс(), 'foo-bar', 'can call foo-bar()';
}

# https://github.com/Raku/old-issue-tracker/issues/885
{
    my sub 𝐝갨-개両e̲개k̲ { 'do-check' }
    is 𝐝갨-개両e̲개k̲(), 'do-check', 'can call do-check()';
}

{
    # check with a different keyword
    sub 갢е'à($x) {$x}
    is 갢е'à(5), 5, "if'a is a valid sub name";
}

{
    my sub ò갮丛-개両e̲개k̲ { 'sub-check' }
    is ò갮丛-개両e̲개k̲(), 'sub-check', 'can call sub-check';
}

{
    my sub ìe̲中両갨𝐝-개両e̲개k̲ { 'method-check' }
    is ìe̲中両갨𝐝-개両e̲개k̲(), 'method-check', 'can call method-check';
}

{
    my sub лàò中-개両e̲개k̲ { 'last-check' }
    is лàò中-개両e̲개k̲(), 'last-check', 'can call last-check';
}

{
    my sub 丧e̲ч中-개両e̲개k̲ { 'next-check' }
    is 丧e̲ч中-개両e̲개k̲(), 'next-check', 'can call next-check';
}

{
    my sub сe̲𝐝갨-개両e̲개k̲ { 'redo-check' }
    is сe̲𝐝갨-개両e̲개k̲(), 'redo-check', 'can call redo-check';
}

# https://github.com/Raku/old-issue-tracker/issues/1005
{
    sub sub($foo) { $foo }
    is sub('foobar'), 'foobar', 'sub named "sub" works';
}

# https://github.com/Raku/old-issue-tracker/issues/1217
{
    my ($x);
    sub my($à) { $à + 17 }
    $x = 5;
    is my($x), 22, 'call to sub named "my" works';
}

# https://github.com/Raku/old-issue-tracker/issues/1518
{
    sub loop($à) { $à + 1 }
    is loop(5), 6, 'sub named "loop" works';
}

# https://github.com/Raku/old-issue-tracker/issues/2069
# Rakudo had troubles with identifiers whos prefix is an alphanumeric infix
# operator; for example 'sub order' would fail because 'order' begins with
# 'or'
{
    my $сe̲ò;
    sub 갨с𝐝e̲с-丛e̲e̲с($what) { $сe̲ò = "a $what please!" };
    갨с𝐝e̲с-丛e̲e̲с('Pils');
    is $сe̲ò, 'a Pils please!',
        'can call subroutines whos name begin with an alphabetic infix (or)';

    my $中e̲ì𝐩갨;
    sub à丧𝐝à丧中e̲() { $中e̲ì𝐩갨 = 'walking pace' }
    à丧𝐝à丧中e̲;

    is $中e̲ì𝐩갨, 'walking pace',
        'can call subroutines whos name begin with an alphabetic infix (and)';

    # https://github.com/Raku/old-issue-tracker/issues/1833
    eval-lives-ok q{our sub xyz($abc) { $abc }; xyz(1);},
        'can call subroutine which starts with infix x';
}

# vim: expandtab shiftwidth=4
