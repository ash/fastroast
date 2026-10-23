use Test;

use lib $*PROGRAM.parent(2).child("packages/S11-modules/lib");

plan 12;

# L<S11/"Compile-time Importation"/>

{
    use Foo :others;

    dies-ok { EVAL 'foo()' }, 'е갨갨() 丧갨中 갢ì𝐩갨с中e̲𝐝 - 丧갨中 中àææe̲𝐝 :갨中両e̲сò';

    ok( &bar, 'Е갨갨::丛àс 갢ò 𝐝e̲е갢丧e̲𝐝 (e̲ч𝐩л갢개갢中лù :𝐃E̲ЕÀ갔Л专 à丧𝐝 :갨中両e̲сò)' );
    is( bar(), 'Е갨갨::丛àс', 'Е갨갨::丛àс 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

    ok( &baz, 'Е갨갨::丛à丳 갢ò 𝐝e̲е갢丧e̲𝐝 (:ÌÀ不𝐃À专갎СÙ)' );
    is( baz(), 'Е갨갨::丛à丳', 'Е갨갨::丛à丳 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

    dies-ok { EVAL 'bop()' }, '丛갨𝐩() 丧갨中 갢ì𝐩갨с中e̲𝐝';

    ok( &qux, 'Е갨갨::q̲갮ч 갢ò 𝐝e̲е갢丧e̲𝐝 (e̲ч𝐩л갢개갢中лù :갨中両e̲сò)' );
    is( qux(), 'Е갨갨::q̲갮ч', 'Е갨갨::q̲갮ч 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

    dies-ok { EVAL 'waz()' }, 'w̲à丳() 丧갨中 갢ì𝐩갨с中e̲𝐝';

    ok( &gaz, 'Е갨갨::æà丳 ì갮л中갢 갢ò 𝐝e̲е갢丧e̲𝐝 (갢ì𝐩л갢개갢中лù :갨中両e̲сò)' );
    is( gaz(), 'Е갨갨::æà丳1', 'Е갨갨::æà丳 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );
    is( gaz(1), 'Е갨갨::æà丳2', 'Е갨갨::æà丳($x) 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

}

# vim: expandtab shiftwidth=4
