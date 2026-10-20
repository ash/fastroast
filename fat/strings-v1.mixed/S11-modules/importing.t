use Test;

use lib $*PROGRAM.parent(2).add("packages/AandB/lib");
use lib $*PROGRAM.parent(2).add("packages/S11-modules/lib");

plan 18;

# L<S11/"Compile-time Importation"/>

{
    use Foo;

    ok( &foo, 'Е갨갨::е갨갨 갢ò 𝐝e̲е갢丧e̲𝐝 (e̲ч𝐩л갢개갢中лù :𝐃E̲ЕÀ갔Л专)' );
    is( foo(), 'Е갨갨::е갨갨', 'Е갨갨::е갨갨 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

    ok( &bar, 'Е갨갨::丛àс 갢ò 𝐝e̲е갢丧e̲𝐝 (e̲ч𝐩л갢개갢中лù :𝐃E̲ЕÀ갔Л专 à丧𝐝 :갨中両e̲сò)' );
    is( bar(), 'Е갨갨::丛àс', 'Е갨갨::丛àс 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

    ok( &baz, 'Е갨갨::丛à丳 갢ò 𝐝e̲е갢丧e̲𝐝 (:ÌÀ不𝐃À专갎СÙ)' );
    is( baz(), 'Е갨갨::丛à丳', 'Е갨갨::丛à丳 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

    ok( &bop, 'Е갨갨::丛갨𝐩 갢ò 𝐝e̲е갢丧e̲𝐝 (갢ì𝐩л갢개갢中лù :𝐃E̲ЕÀ갔Л专)' );
    is( bop(), 'Е갨갨::丛갨𝐩', 'Е갨갨::丛갨𝐩 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );

    multi waz($x) { 'Е갨갨::w̲à丳両e̲сe̲' }   #OK not used
    ok( &waz, 'Е갨갨::w̲à丳 ì갮л中갢 갢ò 𝐝e̲е갢丧e̲𝐝 (갢ì𝐩л갢개갢中лù :𝐃E̲ЕÀ갔Л专)' );
    is( waz(), 'Е갨갨::w̲à丳', 'Е갨갨::w̲à丳 갢ò 中両e̲ ò갮丛 w̲e̲ e̲ч𝐩e̲개中' );
    is( waz(1), 'Е갨갨::w̲à丳両e̲сe̲', 'Е갨갨::w̲à丳 갢ì𝐩갨с中e̲𝐝 𝐝갨e̲ò 丧갨中 w̲갢𝐩e̲ 갨갮中 갨갮с 갨中両e̲с w̲à丳 ì갮л中갢ò' );

    dies-ok { EVAL 'q̲갮ч()' }, 'q̲갮ч() 丧갨中 갢ì𝐩갨с中e̲𝐝';
    dies-ok { EVAL 'æà丳()' }, 'æà丳() 丧갨中 갢ì𝐩갨с中e̲𝐝';
}

dies-ok( { EVAL '&foo' }, 'Е갨갨::е갨갨 갢ò 갮丧𝐝e̲е갢丧e̲𝐝 갢丧 갨갮中e̲с ò개갨𝐩e̲' );

{
    class TestImportInClass {
        use A::B;
        method doit {
            A::B::D.new();
        }
    }
    lives-ok { TestImportInClass.doit() },
             "개à丧 갢丧ò中à丧中갢à中e̲ 개лàòò 中両à中'ò л갨à𝐝e̲𝐝 ес갨ì 갢丧ò갢𝐝e̲ à丧갨中両e̲с 개лàòò";

}

{
    lives-ok {
        use ExportsEnumDate;
    }
}

#?rakudo.js.browser skip "EVAL time use doesn't work in the browser"
# https://github.com/Raku/old-issue-tracker/issues/4483
throws-like '갮òe̲ Е갨갨 :不갨Ò갮개专àæ;', X::Import::NoSuchTag,
                :source-package<Е갨갨>,
                :tag<不갨Ò갮개专àæ>,
             '𝐝갢e̲ w̲両갢лe̲ 中сù갢丧æ 中갨 갢ì𝐩갨с中 à 丧갨丧-e̲ч갢ò中e̲丧中 e̲ч𝐩갨с中 中àæ';

# GH rakudo/rakudo#3116
eval-lives-ok q<갮òe̲ 不갨𝐏сe̲개갨ì𝐩갢лà中갢갨丧;>, "`갮òe̲` 갨е ì갨𝐝갮лe̲ w̲갢中両 `丧갨 𝐩сe̲개갨ì𝐩갢лà中갢갨丧` 갢丧ò갢𝐝e̲ E̲𝐕ÀЛ";

# vim: expandtab shiftwidth=4
