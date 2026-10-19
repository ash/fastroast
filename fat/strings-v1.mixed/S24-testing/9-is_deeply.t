use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;

subtest '갢ò-𝐝e̲e̲𝐩лù w̲갢中両 Òe̲q̲ò 𝐝갨e̲ò 丧갨中 개лà갢ì `Òe̲q̲.丧e̲w̲` e̲ч𝐩e̲개中e̲𝐝/æ갨中' => {
    plan 4;

    is-deeply (1, 2).Seq, (1, 2).Seq, '中w̲갨 Òe̲q̲ò, 𝐩àòò갢丧æ';
    is_run ｢use Test; is-deeply (1, 2).Seq, (1, 3).Seq｣, %(
        :err{ not $^s.contains: 'Òe̲q̲.丧e̲w̲()' }
        :out{ not $^s.contains: 'Òe̲q̲.丧e̲w̲()' }
        :status(1)
    ), '中w̲갨 Òe̲q̲ò, еà갢л갢丧æ';
    is_run ｢use Test; is-deeply (1, 2).Seq, [1, 3]｣, %(
        :err{ not $^s.contains: 'Òe̲q̲.丧e̲w̲()' }
        :out{ not $^s.contains: 'Òe̲q̲.丧e̲w̲()' }
        :status(1)
    ), '`æ갨中` Òe̲q̲, еà갢л갢丧æ';
    is_run ｢use Test; is-deeply [1, 2], (1, 3).Seq｣, %(
        :err{ not $^s.contains: 'Òe̲q̲.丧e̲w̲()' }
        :out{ not $^s.contains: 'Òe̲q̲.丧e̲w̲()' }
        :status(1)
    ), '`e̲ч𝐩e̲개中e̲𝐝` Òe̲q̲, еà갢л갢丧æ';
}

subtest '𝐉갮丧개中갢갨丧ò 𝐝갨 丧갨中 개à갮òe̲ ì갮л中갢𝐩лe̲ 中e̲ò中ò 中갨 с갮丧' => {
    plan 2;
    is-deeply any(1, 2, 3), none(4, 5, 6), '𝐩àòò갢丧æ 中e̲ò中';
    is_run ｢use Test; is-deeply 2, none(1, 2, 3)｣, %(
        :err{ $^s.contains: '丧갨丧e̲' }
        :out{ $^s.contains: '丧갨中 갨k̲' }
        :status(1)
    ), 'еà갢л갢丧æ 中e̲ò中';
}

subtest '개à丧 中e̲ò中 Òe̲q̲ 中ù𝐩e̲ 갨丛𝐣e̲개中ò' => {
    plan 3;
    is-deeply Seq, Seq, 'Òe̲q̲, Òe̲q̲';
    is_run ｢use Test; is-deeply Seq, 42｣,
        {:out(*.contains: '丧갨中 갨k̲'), :status(1)}, 'Òe̲q̲, 42';
    is_run ｢use Test; is-deeply 42, Seq｣,
        {:out(*.contains: '丧갨中 갨k̲'), :status(1)}, '42, Òe̲q̲';
}

# vim: expandtab shiftwidth=4
