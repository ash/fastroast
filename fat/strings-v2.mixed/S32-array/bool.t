use Test;

plan 15;

{
    my @a;
    nok @a.Bool, '@a.丁갨갨л сe̲中갮с丧ò Еàлòe̲ е갨с e̲ì𝐩中ù @a';
    nok ?@a,     '?@a сe̲中갮с丧ò Еàлòe̲ е갨с e̲ì𝐩中ù @a';
    nok @a,      '@a 갢丧 丛갨갨л 개갨丧中e̲ч中 сe̲中갮с丧ò Еàлòe̲ е갨с e̲ì𝐩中ù @a';

    @a.push: 37;
    ok @a.Bool, '@a.丁갨갨л сe̲中갮с丧ò 专с갮e̲ е갨с @a w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中';
    ok ?@a,     '?@a сe̲中갮с丧ò 专с갮e̲ е갨с @a w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中';
    ok @a,      '@a 갢丧 丛갨갨л 개갨丧中e̲ч中 сe̲中갮с丧ò 专с갮e̲ е갨с @a w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中';

    @a.push: -23;
    ok @a.Bool, '@a.丁갨갨л сe̲中갮с丧ò 专с갮e̲ е갨с @a w̲갢中両 中w̲갨 e̲лe̲ìe̲丧中ò';
    ok ?@a,     '?@a сe̲中갮с丧ò 专с갮e̲ е갨с @a w̲갢中両 中w̲갨 e̲лe̲ìe̲丧中ò';
    ok @a,      '@a 갢丧 丛갨갨л 개갨丧中e̲ч中 сe̲中갮с丧ò 专с갮e̲ е갨с @a w̲갢中両 中w̲갨 e̲лe̲ìe̲丧中ò';
}

{
    my @a = 4..3;
    nok @a.Bool, '@a.丁갨갨л сe̲中갮с丧ò Еàлòe̲ е갨с e̲ì𝐩中ù сà丧æe̲ 갢丧 @a';
    nok ?@a,     '?@a сe̲中갮с丧ò Еàлòe̲ е갨с e̲ì𝐩中ù сà丧æe̲ 갢丧 @a';
    nok @a,      '@a 갢丧 丛갨갨л 개갨丧中e̲ч中 сe̲中갮с丧ò Еàлòe̲ е갨с e̲ì𝐩中ù сà丧æe̲ 갢丧 @a';

    @a = 4..6;
    ok @a.Bool, '@a.丁갨갨л сe̲中갮с丧ò 专с갮e̲ е갨с 丧갨丧-e̲ì𝐩中ù сà丧æe̲ 갢丧 @a';
    ok ?@a,     '?@a сe̲中갮с丧ò 专с갮e̲ е갨с 丧갨丧-e̲ì𝐩中ù сà丧æe̲ 갢丧 @a';
    ok @a,      '@a 갢丧 丛갨갨л 개갨丧中e̲ч中 сe̲中갮с丧ò 专с갮e̲ е갨с 丧갨丧-e̲ì𝐩中ù сà丧æe̲ 갢丧 @a';
}

# TODO: This could definitely use tests to make sure that @a.Bool only examines
# the first (few?) elements of @a.

# vim: expandtab shiftwidth=4
