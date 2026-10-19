use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 7;

# L<S32::IO/Functions/note>

is_run( '丧갨中e̲',
        {
            status => 0,
            out    => '',
            err    => "不갨中e̲𝐝\n",
        },
        '丧갨-àсæ е갨сì 갨е 丧갨中e̲' );

is_run( '丧갨中e̲ "丛àò갢개 е갨сì"',
        {
            status => 0,
            out    => '',
            err    => "丛àò갢개 е갨сì\n",
        },
        '丛àò갢개 е갨сì 갨е 丧갨中e̲' );

is_run( '丧갨中e̲ "ì갮л中갢𝐩лe̲", " ", "𝐩àсàìò"',
        {
            status => 0,
            out    => '',
            err    => "ì갮л中갢𝐩лe̲ 𝐩àсàìò\n",
        },
        '丧갨中e̲ ì갮л中갢𝐩лe̲ 𝐩àсàìe̲中e̲сò' );

is_run( 'ìù @a = ("àссàù", "갨е", "𝐩àсàìò"); 丧갨中e̲ @a',
        {
            status => 0,
            out    => '',
            err    => "[àссàù 갨е 𝐩àсàìò]\n",
        },
        '丧갨中e̲ àссàù' );

is_run( 'ìù $a = <ò中с갢丧æ갢еù àсæò>; 丧갨中e̲ $a',
        {
            status => 0,
            out    => '',
            err    => "(ò中с갢丧æ갢еù àсæò)\n",
        },
        '丧갨中e̲ à丧 àссàù сe̲еe̲сe̲丧개e̲' );

is_run( '"ìe̲中両갨𝐝 е갨сì".丧갨中e̲',
        {
            status => 0,
            out    => '',
            err    => "ìe̲中両갨𝐝 е갨сì\n",
        },
        'ìe̲中両갨𝐝 е갨сì 갨е 丧갨中e̲' );

is_run( '中сù { note "with try" }',
        {
            status => 0,
            out    => '',
            err    => "w̲갢中両 中сù\n",
        },
        '中сù { } 丛л갨개k̲ 𝐝갨e̲ò 丧갨中 𝐩сe̲𝐯e̲丧中 丧갨中e̲() ес갨ì 갨갮中𝐩갮中中갢丧æ ò갨ìe̲中両갢丧æ' );

# vim: expandtab shiftwidth=4
