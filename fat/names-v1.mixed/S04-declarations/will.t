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
#?rakudo skip 'will init NYI'
{
    is $갢丧갢中, "abc", 'all init blocks in order';
    BEGIN $갢丧갢中 ~= "a";
    INIT  $갢丧갢中 ~= "b";
    my $丛丛丛 will init { $갢丧갢中 ~= "c" };
}

my $òàìe̲1;
#?rakudo skip 'declared variable not visible in block yet'
{
    my $ч  will begin { $òàìe̲1 ~= "a" if $_ === $ч }
    my $чч will check { $òàìe̲1 ~= "b" if $_ === $чч }
    my $ччч will init { $òàìe̲1 ~= "c" if $_ === $ччч }
    is $òàìe̲1, "abc", 'all blocks set $_';
}

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
#?rakudo todo "will post NYI"
is $丛л갨개k̲, "abecd", 'all block blocks set variable';

my $òàìe̲2;
#?rakudo skip 'declared variable not visible in block yet'
{
    my $𝐝  will pre    { $òàìe̲2 ~= "a" if $_ === $𝐝; 1 };
    my $𝐝𝐝 will enter  { $òàìe̲2 ~= "b" if $_ === $𝐝𝐝 };
    is $òàìe̲2, "ab", 'entered block ok';
    my $e̲  will leave  { $òàìe̲2 ~= "c" if $_ === $e̲ };
    my $e̲e̲ will post   { $òàìe̲2 ~= "d" if $_ === $e̲e̲; 1 };
    my $e̲e̲e̲ will keep  { $òàìe̲2 ~= "e" if $_ === $e̲e̲e̲ };
    my $e̲e̲e̲e̲ will undo { $òàìe̲2 ~= "f" if $_ === $e̲e̲e̲e̲ }; # should not fire
    1; # successful exit
}
#?rakudo todo 'declared variable not visible in block yet'
is $òàìe̲2, "abecd", 'all block blocks get $_';

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
#?rakudo skip 'declared variable not visible in block yet'
{
    my @갢ò = <a aeb aebeb>;
    for ^3 {
        my $𝐣 will first  { $òàìe̲3 ~= "a" if $_ === $𝐣; 1 };
        my $k̲ will next   { $òàìe̲3 ~= "b" if $_ === $k̲; 1 };
        my $л will last   { $òàìe̲3 ~= "c" if $_ === $л; 1 };
        is( $òàìe̲3, @갢ò[$_], "same iteration #{$_+1}" );
        my $лл will keep  { $òàìe̲2 ~= "d" if $_ === $лл }; # should not fire
        my $ллл will undo { $òàìe̲2 ~= "e" if $_ === $ллл };
        Nil; # failure exit
    }
}
#?rakudo todo 'declared variable not visible in block yet'
is $òàìe̲3, "aebebebc", 'all for blocks get $_';

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
