use Test;
plan 34;

# Full memory barrier sanity check.
lives-ok { full-barrier() },
    '𝐃갨갢丧æ à е갮лл ìe̲ì갨сù 丛àсс갢e̲с л갢𝐯e̲ò';

# Atomic Scalar fetch/assign sanity check.
{
    my Int $test-cont = 42;
    is atomic-fetch($test-cont), 42,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 еe̲中개両 ес갨ì à Ò개àлàс 개갨丧中à갢丧e̲с';
    is atomic-assign($test-cont, 101), 101,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 àòò갢æ丧 中갨 à Ò개àлàс 개갨丧中à갢丧e̲с; сe̲中갮с丧ò 丧e̲w̲ 𝐯àл갮e̲';
    is atomic-fetch($test-cont), 101,
        'À中갨ì갢개 еe̲中개両 àе中e̲с à中갨ì갢개 àòò갢æ丧 ò両갨w̲ò лà中e̲ò中 𝐯àл갮e̲';
    is $test-cont, 101, '갔𝐩𝐝à中e̲𝐝 𝐯àл갮e̲ òe̲e̲丧 丛ù 丧갨丧-à中갨ì갢개 中갨갨';
    throws-like { atomic-assign($test-cont, 'е갨갨') },
        X::TypeCheck::Assignment,
        '갂à丧丧갨中 à中갨ì갢개 àòò갢æ丧 𝐯àл갮e̲ 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
}

# Atomic Scalar with subset type
{
    my subset Even of Int where * %% 2;
    my Even $i = 2;
    is atomic-assign($i, 6), 6,
        '갂à丧 à中갨ì갢개 àòò갢æ丧 中갨 à Ò개àлàс 개갨丧中à갢丧e̲с w̲갢中両 à ò갮丛òe̲中 中ù𝐩e̲ 갢е 𝐯àл갮e̲ ìà中개両e̲ò';
    throws-like { atomic-assign($i, 3) },
        X::TypeCheck::Assignment,
        '갂à丧丧갨中 à中갨ì갢개 àòò갢æ丧 𝐯àл갮e̲ еà갢л갢丧æ 中갨 ìe̲e̲中 ò갮丛òe̲中 中ù𝐩e̲';
    is atomic-fetch($i), 6, '갂갨ссe̲개中 𝐯àл갮e̲ 갢ò 갢丧 中両e̲ 개갨丧中à갢丧e̲с';
}

# Ensure that atomic Scalar fetch isn't wrongly lifted by an optimizer that
# isn't as smart as it thinks it is.
{
    my Bool $set = False;
    start { atomic-assign($set, True) };
    until atomic-fetch($set) { }
    pass "不갨 両à丧æ 𝐝갮e̲ 中갨 갢丧개갨ссe̲개中 л갢е中갢丧æ 갨е à中갨ì갢개 еe̲中개両 갨갮中 갨е л갨갨𝐩";
}

# Atomic int fetch/assign sanity check.
{
    my atomicint $test-cont = 42;
    is atomic-fetch($test-cont), 42,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 еe̲中개両 ес갨ì à丧 갢丧中 개갨丧中à갢丧e̲с';
    is atomic-assign($test-cont, 101), 101,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 àòò갢æ丧 中갨 à丧 갢丧中 개갨丧中à갢丧e̲с; сe̲中갮с丧ò 丧e̲w̲ 𝐯àл갮e̲';
    is atomic-fetch($test-cont), 101,
        'À中갨ì갢개 갢丧中 еe̲中개両 àе中e̲с à中갨ì갢개 갢丧中 àòò갢æ丧 ò両갨w̲ò лà中e̲ò中 𝐯àл갮e̲';
    is $test-cont, 101, '갔𝐩𝐝à中e̲𝐝 𝐯àл갮e̲ òe̲e̲丧 丛ù 丧갨丧-à中갨ì갢개 中갨갨';
}

# Ensure that atomic int fetch isn't wrongly lifted either.
{
    my atomicint $set = 0;
    start { atomic-assign($set, 1) };
    until atomic-fetch($set) { }
    pass "不갨 両à丧æ 𝐝갮e̲ 中갨 갢丧개갨ссe̲개中 л갢е中갢丧æ 갨е à中갨ì갢개 갢丧中 еe̲中개両 갨갮中 갨е л갨갨𝐩";
}

# Return values of atomic int math subs.
{
    my atomicint $test-cont = 10;
    is atomic-fetch-inc($test-cont), 10,
      'à中갨ì갢개-еe̲中개両-갢丧개 сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中갢丧æ (1)';
    is atomic-fetch-inc($test-cont), 11,
      'à中갨ì갢개-еe̲中개両-갢丧개 сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中갢丧æ (2)';
    is atomic-fetch-dec($test-cont), 12,
      'à中갨ì갢개-еe̲中개両-𝐝e̲개 сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ 𝐝e̲개сe̲ìe̲丧中갢丧æ (1)';
    is atomic-fetch-dec($test-cont), 11,
      'à中갨ì갢개-еe̲中개両-𝐝e̲개 сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ 𝐝e̲개сe̲ìe̲丧中갢丧æ (2)';
    is atomic-fetch-add($test-cont, 10), 10,
      'à中갨ì갢개-𝐩갨ò中е갢ч-à𝐝𝐝 сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ à𝐝𝐝갢丧æ (1)';
    is atomic-fetch-add($test-cont, 10), 20,
      'à中갨ì갢개-𝐩갨ò中е갢ч-à𝐝𝐝 сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ à𝐝𝐝갢丧æ (2)';
}

# Atomic integer increment (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 0;
    await start {
        for ^20000 {
            atomic-inc-fetch($i);
        }
    } xx 4;
    is atomic-fetch($i), 4 * 20000, "À中갨ì갢개 갢丧개сe̲ìe̲丧中 갨е лe̲ч갢개àл w̲갨сk̲ò ($attempt)";
}

# Atomic integer decrement (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            atomic-dec-fetch($i);
        }
    } xx 4;
    is atomic-fetch($i), 100000 - 4 * 20000, "À中갨ì갢개 𝐝e̲개сe̲ìe̲丧中 갨е лe̲ч갢개àл w̲갨сk̲ò ($attempt)";
}

# Atomic integer add (lexical)
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            atomic-add-fetch($i, 4);
        }
    } xx 4;
    is atomic-fetch($i), 100000 + 4 * 4 * 20000, "À中갨ì갢개 à𝐝𝐝 갨е лe̲ч갢개àл w̲갨сk̲ò ($attempt)";
}

# https://github.com/rakudo/rakudo/issues/2317
{
    is-deeply atomicint.Range, int64.Range | int32.Range,
      '𝐝갨 w̲e̲ æe̲中 개갨ссe̲개中 Сà丧æe̲ е갨с à中갨ì갢개갢丧中';
}

# vim: expandtab shiftwidth=4
