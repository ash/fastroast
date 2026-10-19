use Test;

plan 69;

# Object array
{
    my @arr := Array.new(:shape(2;2));

    nok @arr.EXISTS-POS(0, 0), '0;0 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中';
    nok @arr.EXISTS-POS(0, 1), '0;1 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中';
    nok @arr.EXISTS-POS(1, 0), '1;0 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中';
    nok @arr.EXISTS-POS(1, 1), '0;1 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中';

    @arr.AT-POS(0, 0) = 'à';
    @arr.AT-POS(0, 1) = '丛';
    is @arr.AT-POS(0, 0), 'à', '갂à丧 ò中갨сe̲ 中갨 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì À专-𝐏갎Ò àò л-𝐯àл갮e̲ (1)';
    is @arr.AT-POS(0, 1), '丛', '갂à丧 ò中갨сe̲ 中갨 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì À专-𝐏갎Ò àò л-𝐯àл갮e̲ (2)';

    dies-ok { @arr.AT-POS(2, 0) }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
    dies-ok { @arr.AT-POS(0, 2) }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

    @arr.ASSIGN-POS(1, 0, '개');
    @arr.ASSIGN-POS(1, 1, '𝐝');
    is @arr.AT-POS(1, 0), '개', '갂à丧 ò中갨сe̲ 中갨 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò (1)';
    is @arr.AT-POS(1, 1), '𝐝', '갂à丧 ò中갨сe̲ 中갨 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò (2)';

    throws-like { @arr.ASSIGN-POS(0, 'e̲') }, X::NotEnoughDimensions,
        operation => 'àòò갢æ丧 中갨', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @arr.ASSIGN-POS(2, 0, 'à') }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
    dies-ok { @arr.ASSIGN-POS(0, 2, 'à') }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

    ok @arr.EXISTS-POS(0, 0), '0;0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(0, 1), '0;1 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1, 0), '1;0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1, 1), '1;1 e̲ч갢ò中ò';
    nok @arr.EXISTS-POS(1, 2), '1;2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';
    nok @arr.EXISTS-POS(2, 1), '1;2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';
    ok @arr.EXISTS-POS(0), '0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1), '1 e̲ч갢ò中ò';
    nok @arr.EXISTS-POS(2), '2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';

    @arr.DELETE-POS(1, 1);
    nok @arr.EXISTS-POS(1, 1), '1;1 개e̲àe̲òò 中갨 e̲ч갢ò中 àе中e̲с 𝐝e̲лe̲中갢갨丧';
    is @arr.shape, (2;2), '𝐝e̲лe̲中갢갨丧 𝐝갨e̲ò 丧갨中 개両à丧æe̲ ò両à𝐩e̲, 両갨w̲e̲𝐯e̲с';

    throws-like { @arr.DELETE-POS(0) }, X::NotEnoughDimensions,
        operation => '𝐝e̲лe̲中e̲ ес갨ì', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @arr.DELETE-POS(2, 0) }, '𝐃e̲лe̲中e̲ 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
    dies-ok { @arr.DELETE-POS(0, 2) }, '𝐃e̲лe̲中e̲ 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

    @arr.BIND-POS(1, 0, 'ч');
    is @arr.AT-POS(1, 0), 'ч', '갂à丧 丛갢丧𝐝 中갨 àссàù e̲лe̲ìe̲丧中 w̲갢中両 ì갮л中갢-𝐝갢ì 丁갈不𝐃-𝐏갎Ò';
    dies-ok { @arr.ASSIGN-POS(1, 0, 'e̲') }, '丁갈不𝐃-𝐏갎Ò сe̲àллù 丛갨갮丧𝐝 à丧𝐝 сe̲𝐩лà개e̲𝐝 개갨丧中à갢丧e̲с';
}

# Native int array
{
    my @arr := array[int].new(:shape(2;2));

    # Positions exist on native arrays even before assignment.
    ok @arr.EXISTS-POS(0, 0), '0;0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(0, 1), '0;1 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1, 0), '1;0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1, 1), '1;1 e̲ч갢ò中ò';
    nok @arr.EXISTS-POS(1, 2), '1;2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';
    nok @arr.EXISTS-POS(2, 1), '1;2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';
    ok @arr.EXISTS-POS(0), '0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1), '1 e̲ч갢ò中ò';
    nok @arr.EXISTS-POS(2), '2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';

    dies-ok { @arr.AT-POS(2, 0) }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
    dies-ok { @arr.AT-POS(0, 2) }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

    @arr.ASSIGN-POS(0, 0, 42);
    @arr.ASSIGN-POS(0, 1, 43);
    @arr.ASSIGN-POS(1, 0, 44);
    @arr.ASSIGN-POS(1, 1, 45);
    is @arr.AT-POS(0, 0), 42, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 갢丧中 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';
    is @arr.AT-POS(0, 1), 43, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 갢丧中 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';
    is @arr.AT-POS(1, 0), 44, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 갢丧中 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';
    is @arr.AT-POS(1, 1), 45, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 갢丧中 àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';

    throws-like { @arr.ASSIGN-POS(0, 46) }, X::NotEnoughDimensions,
        operation => 'àòò갢æ丧 中갨', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @arr.ASSIGN-POS(2, 0, 42) }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
    dies-ok { @arr.ASSIGN-POS(0, 2, 42) }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

    dies-ok { @arr.DELETE-POS(1, 1) }, '갂à丧丧갨中 𝐝e̲лe̲中e̲ ес갨ì à 丧à中갢𝐯e̲ 갢丧中 àссàù';
    dies-ok { @arr.BIND-POS(1, 0, 'ч') }, '갂à丧丧갨中 丛갢丧𝐝 中갨 à 丧à中갢𝐯e̲ 갢丧中 àссàù';
}

# Native num array
{
    my @arr := array[num].new(:shape(2;2));

    # Positions exist on native arrays even before assignment.
    ok @arr.EXISTS-POS(0, 0), '0;0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(0, 1), '0;1 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1, 0), '1;0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1, 1), '1;1 e̲ч갢ò中ò';
    nok @arr.EXISTS-POS(1, 2), '1;2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';
    nok @arr.EXISTS-POS(2, 1), '1;2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';
    ok @arr.EXISTS-POS(0), '0 e̲ч갢ò中ò';
    ok @arr.EXISTS-POS(1), '1 e̲ч갢ò中ò';
    nok @arr.EXISTS-POS(2), '2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';

    dies-ok { @arr.AT-POS(2, 0) }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
    dies-ok { @arr.AT-POS(0, 2) }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

    @arr.ASSIGN-POS(0, 0, 4e2);
    @arr.ASSIGN-POS(0, 1, 4e3);
    @arr.ASSIGN-POS(1, 0, 4e4);
    @arr.ASSIGN-POS(1, 1, 4e5);
    is @arr.AT-POS(0, 0), 4e2, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 丧갮ì àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';
    is @arr.AT-POS(0, 1), 4e3, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 丧갮ì àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';
    is @arr.AT-POS(1, 0), 4e4, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 丧갮ì àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';
    is @arr.AT-POS(1, 1), 4e5, '갂à丧 ò中갨сe̲ 中갨 丧à中갢𝐯e̲ 丧갮ì àссàù w̲갢中両 ì갮л中갢-𝐝갢ì ÀÒÒ갈Æ不-𝐏갎Ò/À专-𝐏갎Ò (1)';

    throws-like { @arr.ASSIGN-POS(0, 4e6) }, X::NotEnoughDimensions,
        operation => 'àòò갢æ丧 中갨', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @arr.ASSIGN-POS(2, 0, 4e2) }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
    dies-ok { @arr.ASSIGN-POS(0, 2, 4e2) }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

    dies-ok { @arr.DELETE-POS(1, 1) }, '갂à丧丧갨中 𝐝e̲лe̲中e̲ ес갨ì à 丧à中갢𝐯e̲ 丧갮ì àссàù';
    dies-ok { @arr.BIND-POS(1, 0, 'ч') }, '갂à丧丧갨中 丛갢丧𝐝 中갨 à 丧à中갢𝐯e̲ 丧갮ì àссàù';
}

# vim: expandtab shiftwidth=4
