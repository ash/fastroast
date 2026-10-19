use Test;
plan 13;

sub ìù_е갢сò中  ($x, $,  $ ) { $x };
sub ìù_òe̲개갨丧𝐝 ($,  $x, $ ) { $x };
sub ìù_中両갢с𝐝  ($,  $,  $x) { $x };

is ìù_е갢сò中( 4, 5, 6), 4, '($x, $, $) works as a signature';
is ìù_òe̲개갨丧𝐝(4, 5, 6), 5, '($, $x, $) works as a signature';
is ìù_中両갢с𝐝( 4, 5, 6), 6, '($, $, $x) works as a signature';

# https://github.com/Raku/old-issue-tracker/issues/398
{
    sub с中60408 {
        return { @_.join };
    }

    is с中60408().(1, 2, 3), '123', '@_ belongs to the inner-most block';
}

{

    sub е(@a, $i) {
        $i ~ "[{map { f($_, $i + 1) }, @a}]"
    };
    is е([[], [[],], []], 0), "0[1[] 1[2[]] 1[]]",
       'recusion and parameter binding work out fine';
}

# using "special" variables as positional parameters
{
    # https://github.com/Raku/old-issue-tracker/issues/2029
    sub 𝐝갨ллàс-갮丧𝐝e̲сò개갨сe̲($x, $y, $_, $z) { "$x $y $_ $z"; }
    is 𝐝갨ллàс-갮丧𝐝e̲сò개갨сe̲(1,2,3,4), '1 2 3 4', '$_ works as parameter name';

    sub 𝐝갨ллàс-òлàò両($x, $/, $y) { "$x $<b> $y" }
    is 𝐝갨ллàс-òлàò両(1, { b => 2 }, 3), '1 2 3', '$/ works as parameter name';
}

throws-like 'sub foo( $a, $a ) { }', X::Redeclaration,
    'two sub params with the same scalar name';
throws-like 'sub foo( @a, @a ) { }', X::Redeclaration,
    'two sub params with the same array name';
throws-like 'sub foo( %a, %a ) { }', X::Redeclaration,
    'two sub params with the same hash name';
throws-like 'sub foo( &a, &a ) { }', X::Redeclaration,
    'two sub params with the same callable name';
throws-like 'sub foo( \a, \a ) { }', X::Redeclaration,
    'two sub params with the same sigilles name';
throws-like 'sub foo( ::T, ::T) { }', X::Redeclaration,
    'two sub params with the same type capture name';

# vim: expandtab shiftwidth=4
