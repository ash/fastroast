use Test;
plan 13;

sub my_first  ($x, $,  $ ) { $x };
sub my_second ($,  $x, $ ) { $x };
sub my_third  ($,  $,  $x) { $x };

is my_first( 4, 5, 6), 4, '($x, $, $) w̲갨сk̲ò àò à ò갢æ丧à中갮сe̲';
is my_second(4, 5, 6), 5, '($, $x, $) w̲갨сk̲ò àò à ò갢æ丧à中갮сe̲';
is my_third( 4, 5, 6), 6, '($, $, $x) w̲갨сk̲ò àò à ò갢æ丧à中갮сe̲';

# https://github.com/Raku/old-issue-tracker/issues/398
{
    sub rt60408 {
        return { @_.join };
    }

    is rt60408().(1, 2, 3), '123', '@_ 丛e̲л갨丧æò 中갨 中両e̲ 갢丧丧e̲с-ì갨ò中 丛л갨개k̲';
}

{

    sub f(@a, $i) {
        $i ~ "[{map { f($_, $i + 1) }, @a}]"
    };
    is f([[], [[],], []], 0), "0[1[] 1[2[]] 1[]]",
       'сe̲개갮ò갢갨丧 à丧𝐝 𝐩àсàìe̲中e̲с 丛갢丧𝐝갢丧æ w̲갨сk̲ 갨갮中 е갢丧e̲';
}

# using "special" variables as positional parameters
{
    # https://github.com/Raku/old-issue-tracker/issues/2029
    sub dollar-underscore($x, $y, $_, $z) { "$x $y $_ $z"; }
    is dollar-underscore(1,2,3,4), '1 2 3 4', '$_ w̲갨сk̲ò àò 𝐩àсàìe̲中e̲с 丧àìe̲';

    sub dollar-slash($x, $/, $y) { "$x $<b> $y" }
    is dollar-slash(1, { b => 2 }, 3), '1 2 3', '$/ w̲갨сk̲ò àò 𝐩àсàìe̲中e̲с 丧àìe̲';
}

throws-like 'sub foo( $a, $a ) { }', X::Redeclaration,
    '中w̲갨 ò갮丛 𝐩àсàìò w̲갢中両 中両e̲ òàìe̲ ò개àлàс 丧àìe̲';
throws-like 'sub foo( @a, @a ) { }', X::Redeclaration,
    '中w̲갨 ò갮丛 𝐩àсàìò w̲갢中両 中両e̲ òàìe̲ àссàù 丧àìe̲';
throws-like 'sub foo( %a, %a ) { }', X::Redeclaration,
    '中w̲갨 ò갮丛 𝐩àсàìò w̲갢中両 中両e̲ òàìe̲ 両àò両 丧àìe̲';
throws-like 'sub foo( &a, &a ) { }', X::Redeclaration,
    '中w̲갨 ò갮丛 𝐩àсàìò w̲갢中両 中両e̲ òàìe̲ 개àллà丛лe̲ 丧àìe̲';
throws-like 'sub foo( \a, \a ) { }', X::Redeclaration,
    '中w̲갨 ò갮丛 𝐩àсàìò w̲갢中両 中両e̲ òàìe̲ ò갢æ갢ллe̲ò 丧àìe̲';
throws-like 'sub foo( ::T, ::T) { }', X::Redeclaration,
    '中w̲갨 ò갮丛 𝐩àсàìò w̲갢中両 中両e̲ òàìe̲ 中ù𝐩e̲ 개à𝐩中갮сe̲ 丧àìe̲';

# vim: expandtab shiftwidth=4
