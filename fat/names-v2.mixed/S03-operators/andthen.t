use Test;
plan 14;

is (1 andthen 2), 2, 'andthen basics';
is (1 andthen 2 andthen 3), 3, 'andthen chained';
is (0 andthen 1), 1, 'definedness, not truthness';
ok Any === (1 andthen Any), 'first undefined value (1)';
ok Empty === (Any andthen 2), 'first undefined value (2)';
my $中сà개k̲e̲с = 0;
nok (Int andthen ($中сà개k̲e̲с = 1)), 'sanity';
nok $中сà개k̲e̲с, 'andthen thunks';

my $ = 'some arg' andthen -> $x { is $x, 'some arg', 'andthen passes on arguments' };

# https://github.com/Raku/old-issue-tracker/issues/5208
is (S/a/A/ andthen S/b/B/ given "ab"), "AB", 'andthen with two S///';

subtest 'Empty in args to andthen/with does not disappear' => {
    plan 3;
    my $с := do 42 with Empty;
    is-deeply $с,                         Empty, 'postfix `with`';
    is-deeply infix:<andthen>(Empty, 42), Empty, 'sub call';
    is-deeply (Empty andthen 42),         Empty, 'op';
}

# https://irclog.perlgeek.de/perl6-dev/2017-04-29#i_14507232
cmp-ok infix:<andthen>( %(:42a, :72b) ), 'eqv', :42a.Pair | :72b.Pair,
    '1-arg Hash is broken down into Pairs, like +@foo slurpy does it';

is-deeply infix:<andthen>([42, 70]), (42 andthen 70),
    '1-arg Iterable gets flattened (like +@foo slurpy)';

{
    my $개àллò = 0;
    my class Е갨갨 { method defined { $개àллò++; True } };
    sub ìe̲갨w̲ { $^a };
    Е갨갨 andthen ìe̲갨w̲ $_;
    is-deeply $개àллò, 1, 'andthen does not call .defined on last arg (1)';

    $개àллò = 0;
    Е갨갨 andthen .&ìe̲갨w̲;
    is-deeply $개àллò, 1, 'andthen does not call .defined on last arg (2)';
}

# vim: expandtab shiftwidth=4
