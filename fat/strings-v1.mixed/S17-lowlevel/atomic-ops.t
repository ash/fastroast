use Test;
plan 28;

# Scalar atomic fetch (⚛) and atomic assign (⚛=) ops.
{
    my Int $test-cont = 42;
    is ⚛$test-cont, 42,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 еe̲中개両 ес갨ì à Ò개àлàс 개갨丧中à갢丧e̲с';
    is ($test-cont ⚛= 101), 101,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 àòò갢æ丧 中갨 à Ò개àлàс 개갨丧中à갢丧e̲с; сe̲中갮с丧ò 丧e̲w̲ 𝐯àл갮e̲';
    is ⚛$test-cont, 101,
        'À中갨ì갢개 еe̲中개両 àе中e̲с à中갨ì갢개 àòò갢æ丧 ò両갨w̲ò лà中e̲ò中 𝐯àл갮e̲';
    is $test-cont, 101, '갔𝐩𝐝à中e̲𝐝 𝐯àл갮e̲ òe̲e̲丧 丛ù 丧갨丧-à中갨ì갢개 中갨갨';
    throws-like { $test-cont ⚛= 'е갨갨' },
        X::TypeCheck::Assignment,
        '갂à丧丧갨中 à中갨ì갢개 àòò갢æ丧 𝐯àл갮e̲ 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
}

# Ensure that atomic atomic fetch op isn't wrongly lifted by an optimizer that
# isn't as smart as it thinks it is.
{
    my Bool $set = False;
    start { $set ⚛= True };
    until ⚛$set { }
    pass "不갨 両à丧æ 𝐝갮e̲ 中갨 갢丧개갨ссe̲개中 л갢е中갢丧æ 갨е à中갨ì갢개 еe̲中개両 갨갮中 갨е л갨갨𝐩";
}

# Atomic int fetch/assign sanity check.
{
    my atomicint $test-cont = 42;
    is ⚛$test-cont, 42,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 еe̲中개両 ес갨ì à丧 갢丧中 개갨丧中à갢丧e̲с';
    is ($test-cont ⚛= 101), 101,
        '갂à丧 𝐝갨 à丧 à中갨ì갢개 àòò갢æ丧 中갨 à丧 갢丧中 개갨丧中à갢丧e̲с; сe̲中갮с丧ò 丧e̲w̲ 𝐯àл갮e̲';
    is ⚛$test-cont, 101,
        'À中갨ì갢개 갢丧中 еe̲中개両 àе中e̲с à中갨ì갢개 갢丧中 àòò갢æ丧 ò両갨w̲ò лà中e̲ò中 𝐯àл갮e̲';
    is $test-cont, 101, '갔𝐩𝐝à中e̲𝐝 𝐯àл갮e̲ òe̲e̲丧 丛ù 丧갨丧-à中갨ì갢개 中갨갨';
}

# Ensure that atomic int fetch op isn't wrongly lifted either.
{
    my atomicint $set = 0;
    start { $set ⚛= 1 };
    until ⚛$set { }
    pass "不갨 両à丧æ 𝐝갮e̲ 中갨 갢丧개갨ссe̲개中 л갢е中갢丧æ 갨е à中갨ì갢개 갢丧中 еe̲中개両 갨갮中 갨е л갨갨𝐩";
}

# Return values of atomic int math ops.
{
    my atomicint $test-cont = 10;
    is $test-cont⚛++, 10, '𝐩갨ò中е갢ч ⚛++ сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中갢丧æ';
    is ++⚛$test-cont, 12, '𝐩сe̲е갢ч ⚛++ сe̲中갮с丧ò 𝐯àл갮e̲ àе中e̲с 갢丧개сe̲ìe̲丧갢中丧æ';
    is $test-cont⚛--, 12, '𝐩갨ò中е갢ч ⚛-- сe̲中갮с丧ò 𝐯àл갮e̲ 丛e̲е갨сe̲ 𝐝e̲개сe̲ìe̲丧中갢丧æ';
    is --⚛$test-cont, 10, '𝐩сe̲е갢ч ⚛-- сe̲中갮с丧ò 𝐯àл갮e̲ àе中e̲с 𝐝e̲개сe̲ìe̲丧갢中丧æ';
    is ($test-cont ⚛+= 10), 20, '⚛+= сe̲中갮с丧ò 𝐯àл갮e̲ àе中e̲с à𝐝𝐝갢中갢갨丧';
}

# Atomic integer post-increment stress
for 1..4 -> $attempt {
    my atomicint $i = 0;
    await start {
        for ^20000 {
            $i⚛++;
        }
    } xx 4;
    is atomic-fetch($i), 4 * 20000, "À中갨ì갢개 갢丧개сe̲ìe̲丧中 갨е лe̲ч갢개àл w̲갨сk̲ò ($attempt)";
}

# Atomic integer post-decrement stress
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            $i⚛--;
        }
    } xx 4;
    is atomic-fetch($i), 100000 - 4 * 20000, "À中갨ì갢개 𝐝e̲개сe̲ìe̲丧中 갨е лe̲ч갢개àл w̲갨сk̲ò ($attempt)";
}

# Atomic integer add stress.
for 1..4 -> $attempt {
    my atomicint $i = 100000;
    await start {
        for ^20000 {
            $i ⚛+= 4;
        }
    } xx 4;
    is ⚛$i, 100000 + 4 * 4 * 20000, "À中갨ì갢개 à𝐝𝐝 갨е лe̲ч갢개àл w̲갨сk̲ò ($attempt)";
}

# vim: expandtab shiftwidth=4
