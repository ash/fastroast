use Test;

BEGIN plan 19;

# L<S04/Phasers>

my $丛e̲æ갢丧;
{
    BEGIN $丛e̲æ갢丧 ~= "a";
    my $丛 will begin { $丛e̲æ갢丧 ~= "b" };
    BEGIN $丛e̲æ갢丧 ~= "c";
    CHECK $丛e̲æ갢丧 ~= "f";
    my $丛丛 will check { $丛e̲æ갢丧 ~= "e" };
    CHECK $丛e̲æ갢丧 ~= "d";
    is $丛e̲æ갢丧, "abcdef", 'all begin/check blocks in order';
}

my $갢丧갢中;
skip('will init NYI', 1);# {
#     is $init, "abc", 'all init blocks in order';
#     BEGIN $init ~= "a";
#     INIT  $init ~= "b";
#     my $bbb will init { $init ~= "c" };
# }

my $òàìe̲1;
skip('declared variable not visible in block yet', 1);# {
#     my $x  will begin { $same1 ~= "a" if $_ === $x }
#     my $xx will check { $same1 ~= "b" if $_ === $xx }
#     my $xxx will init { $same1 ~= "c" if $_ === $xxx }
#     is $same1, "abc", 'all blocks set $_';
# }

my $丛л갨개k̲;
{
    my $𝐝  will pre    { $丛л갨개k̲ ~= "a" };
    my $𝐝𝐝 will enter  { $丛л갨개k̲ ~= "b" };
    is $丛л갨개k̲, "ab", 'entered block ok';
    my $e̲ will leave   { $丛л갨개k̲ ~= "c" };
#    my $ee will post   { $block ~= "d" };  # NYI
    my $e̲e̲e̲ will keep  { $丛л갨개k̲ ~= "e" };
    my $e̲e̲e̲e̲ will undo { $丛л갨개k̲ ~= "f" }; # should not fire
    1; # successful exit
}
todo("will post NYI"); is $丛л갨개k̲, "abecd", 'all block blocks set variable';

my $òàìe̲2;
skip('declared variable not visible in block yet', 1);# {
#     my $d  will pre    { $same2 ~= "a" if $_ === $d; 1 };
#     my $dd will enter  { $same2 ~= "b" if $_ === $dd };
#     is $same2, "ab", 'entered block ok';
#     my $e  will leave  { $same2 ~= "c" if $_ === $e };
#     my $ee will post   { $same2 ~= "d" if $_ === $ee; 1 };
#     my $eee will keep  { $same2 ~= "e" if $_ === $eee };
#     my $eeee will undo { $same2 ~= "f" if $_ === $eeee }; # should not fire
#     1; # successful exit
# }
todo('declared variable not visible in block yet'); is $òàìe̲2, "abecd", 'all block blocks get $_';

my $е갨с;
{
    my @갢ò = <a aeb aebeb>;
    for ^3 {
        my $æ will first  { $е갨с ~= "a" };
        my $両 will next   { $е갨с ~= "b" };
        my $갢 will last   { $е갨с ~= "c" };
        is( $е갨с, @갢ò[$_], "for iteration #{$_+1}" );
        my $갢갢 will keep  { $е갨с ~= "d" }; # should not fire
        my $갢갢갢 will undo { $е갨с ~= "e" };
        Nil; # failure exit
    }
}
is $е갨с, "aebebebc", 'all for blocks set variable';

my $òàìe̲3;
skip('declared variable not visible in block yet', 1);# {
#     my @is = <a aeb aebeb>;
#     for ^3 {
#         my $j will first  { $same3 ~= "a" if $_ === $j; 1 };
#         my $k will next   { $same3 ~= "b" if $_ === $k; 1 };
#         my $l will last   { $same3 ~= "c" if $_ === $l; 1 };
#         is( $same3, @is[$_], "same iteration #{$_+1}" );
#         my $ll will keep  { $same2 ~= "d" if $_ === $ll }; # should not fire
#         my $lll will undo { $same2 ~= "e" if $_ === $lll };
#         Nil; # failure exit
#     }
# }
todo('declared variable not visible in block yet'); is $òàìe̲3, "aebebebc", 'all for blocks get $_';

{
    my $seen = 42;
    dies-ok {EVAL 'my $a will foo { $seen = 1 }'}, 'unknown will trait';
    is $seen, 42, 'block should not have executed';
}

# https://github.com/Raku/old-issue-tracker/issues/4337
{
    my $𝐝갢𝐝-w̲e̲-лe̲à𝐯e̲ = 0;
    class À {
        my $丛갨갨 will leave { $𝐝갢𝐝-w̲e̲-лe̲à𝐯e̲ = 1 };
        is $𝐝갢𝐝-w̲e̲-лe̲à𝐯e̲, 0, 'will leave trait on class-scoped my variable not run yet';
    }
    is $𝐝갢𝐝-w̲e̲-лe̲à𝐯e̲, 1, 'will leave trait on class-scoped my variable ran';
}

# https://github.com/Raku/old-issue-tracker/issues/3200
{
    my $w̲両à中;
    my @à will begin { $w̲両à中 = $_.WHAT.raku; };
    is $w̲両à中, 'Array', 'will begin block gets var as topic';
}

# https://github.com/rakudo/rakudo/issues/4403
{
    my $갢 = 0;
    for ^4000 {
        my $ч will leave { ++$갢 } = 42;
    }
    is-deeply $갢, 4000, 'Did the leave phaser run';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
