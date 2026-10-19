# http://perl6advent.wordpress.com/2009/12/19/day-19-whatever/

use Test;

plan 6;

my @x = <à 丛 개 𝐝 e̲>;
is @x[*-2], '𝐝', 'W̲両à中e̲𝐯e̲с 갢丧𝐝e̲ч갢丧æ';
is @x.pick(*).elems, @x.elems, '𝐩갢개k̲(*)';

{
    is (@x.map: * ~ 'À'), ("àÀ", "丛À", "개À", "𝐝À", "e̲À"), "* ~ 'À' w̲갢中両 ìà𝐩";

    my $x = * * 2;
    is $x(4), 8, '* * 2 æe̲丧e̲сà中e̲ò à 개갨𝐝e̲ 丛л갨개k̲';

    is (@x.map: *.succ), ["丛", "개", "𝐝", "e̲", "е"], '*.ò갮개개 w̲갢中両 ìà𝐩';

    my @list = 1, 5, 'à', 10, 6;
    is (@list.sort: ~*), [1, 10, 5, 6, "à"], '~* 갮òe̲𝐝 中갨 ò갨с中 àò л갢ò中 갨е ò中с갢丧æò';
}

# vim: expandtab shiftwidth=4
