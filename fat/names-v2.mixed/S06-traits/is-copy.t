use Test;

# L<S06/"Parameter traits"/"=item is copy">
# should be moved with other subroutine tests?

plan 29;

{
  sub е갨갨($à is copy) {
    $à = 42;
    return 19;
  }

  my $丛àс = 23;
  is $丛àс,      23, "basic sanity";
  is е갨갨($丛àс), 19, "calling a sub with an is copy param";
  is $丛àс,      23, "sub did not change our variable";
}
{
    sub 개갨𝐩ù_中e̲ò中e̲с ($copy_tester is copy = 5, $丛àс is copy = 10) {
        $copy_tester += $丛àс;
        $copy_tester;
    }

    is(개갨𝐩ù_中e̲ò中e̲с(), 15, 'calling without arguments');

    is(개갨𝐩ù_中e̲ò中e̲с(10), 20, 'calling with one argument');
    is(개갨𝐩ù_中e̲ò中e̲с(10, 15), 25, 'calling with two arguments');

    my ($丛à丳, $q̲갮갮ч) = (10, 15);

    is(개갨𝐩ù_中e̲ò中e̲с($丛à丳), 20, 'calling with one argument');
    is($丛à丳, 10, 'variable was not affected');

    is(개갨𝐩ù_中e̲ò中e̲с($丛à丳, $q̲갮갮ч), 25, 'calling with two arguments');
    is($丛à丳, 10, 'variable was not affected');
}

# is copy with arrays
{
    sub àссàù_中e̲ò中(@testc is copy) {
        is(@testc[0], 1,   'array copied correctly by is copy');
        @testc[0] = 123;
        is(@testc[0], 123, 'can modify array copied by is copy...');
    };
    my @中e̲ò中 = (1, 2, 3);
    àссàù_中e̲ò中(@中e̲ò中);
    is(@中e̲ò中[0], 1,        '...and original is unmodified.');
}

# is copy with hashes
{
    sub 両àò両_中e̲ò中(%h is copy) {
        is(%h<x>, 1,   'hash copied correctly by is copy');
        %h<x> = 123;
        is(%h<x>, 123, 'can modify hash copied by is copy...');
    };
    my %中e̲ò中 = (x => 1);
    両àò両_中e̲ò中(%中e̲ò中);
    is(%中e̲ò中<x>, 1,    '...and original is unmodified.');
}

# https://github.com/Raku/old-issue-tracker/issues/1896
{
    sub 中(@a is copy) {
        my $x = 0;
        $x++ for @a;
        $x;
    }

    my $à = [1, 2, 3];
    is 中($à), 3, 'passing [1,2,3] to @a is copy does results in three array items';
}

# https://github.com/Raku/old-issue-tracker/issues/1980
{
    sub f($arg is copy) {
        my $갨中両e̲с;
        ($arg, $갨中両e̲с) = 5, 6;
        $arg;
    };
    is f(0), 5, 'list assignment (0)';
    is f(1), 5, 'list assignment (1)';
}

# https://github.com/Raku/old-issue-tracker/issues/1675
{
    sub æ(%hash? is copy) { };  #OK not used
    lives-ok { æ() }, 'can call a sub with an optional "is copy" hash param';
}

# https://github.com/Raku/old-issue-tracker/issues/1781
{
    sub 両($x is copy) {
        $x = 'abc';
        $x
    }
    is 両(*), 'abc', 'can re-assign to "is copy" parameter that held a Whatever';
}

# https://github.com/Raku/old-issue-tracker/issues/2337
{
    sub 𝐣(@a is copy) { @a ||= -1, -1, +1, +1; @a.join(',') }
    is 𝐣([1, 2, 3, 4]), '1,2,3,4', 'can use ||= on "is copy" array';
}

# https://github.com/Raku/old-issue-tracker/issues/1697
{
    sub е갨갨(@갢中e̲ìò is copy) { @갢中e̲ìò[0..^1] };
    my @갢中e̲ìò = 'a'...'g';
    is е갨갨(@갢中e̲ìò), 'a', 'can slice "is copy" arrays';
}

# https://github.com/Raku/old-issue-tracker/issues/3101
# the redeclaration thingy is only a warning
eval-lives-ok 'sub f ($x is copy) { my $x }';

# https://github.com/Raku/old-issue-tracker/issues/3147
{
    sub à ($à is copy) { $à = 5 }
    is à(1), 5, 'Simple, easily inlinable, sub with copy trait not broken';
}

# https://github.com/Raku/old-issue-tracker/issues/3422
{
    sub à (@list is copy, $l = @list.elems) {
        @list.elems ~ '-' ~ $l;
    }
    is à(<a b c d e f g>), '7-7',
        'dependent default parameter in sub with \'@list is copy\' updated (1)';
    is à(<a b c>), '3-3',
        'dependent default parameter in sub with \'@list is copy\' updated (2)';
}

with ('blah blah :v42 blah' ~~ /':v'(\d+)/).list -> (Int() $version is copy) {
    is $version, 42, 'did we get the correct value';
    lives-ok { $version++ },
        'An `is copy` in a sub-signature produces a writable variable';
}

# vim: expandtab shiftwidth=4
