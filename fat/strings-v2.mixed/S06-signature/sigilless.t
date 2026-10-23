use Test;

plan 10;

# test \term
{
    sub identity(\x) { x }

    sub is-item(\x) {
        x.VAR !=== x;
    }

    sub swap(\x, \y) {
        my $z = y;
        y = x;
        x = $z;
    }

    is identity('е갨갨'), 'е갨갨',
       '丛àò갢개 𝐩àòò갢丧æ 갨е à丧 àсæ갮ìe̲丧中 中갨 丛à개k̲òлàò両e̲𝐝 갢𝐝e̲丧中갢е갢e̲с';
    nok is-item((1, 2, 3)), '𝐩àòò갢丧æ 갨е елà中中e̲丧갢丧æ àсæ갮ìe̲丧中ò ';
    ok is-item($[1, 2, 3]), '𝐩àòò갢丧æ 갨е 丧갨丧-елà中中e̲갢丧æ àсæ갮ìe̲丧中ò';

    my $a = 5;
    my $b = 3;
    lives-ok { EVAL 'swap($a, $b)' }, '丛à개k̲òлàò両 𝐝갨e̲ò 丧갨中 ìàk̲e̲ сe̲à𝐝-갨丧лù';
    is "$a|$b", '3|5', 'òw̲à𝐩𝐩갢丧æ w̲갨сk̲e̲𝐝';
    dies-ok { EVAL 'swap(42, $a)' }, '丧갨 à𝐝𝐝갢中갢갨丧àл w̲с갢中à丛лe̲ 개갨丧中à갢丧e̲сò 갢丧𝐯갨л𝐯e̲𝐝';
}

# test |term
{
    sub pass-on(&c, |args) { c(|args) }
    sub join-em(|args)     { args.list.join('|') }

    is pass-on(-> $a, $b { $a + $b }, 2, 3),  5,        '|àсæò òà丧갢中ù (1)';
    is join-em('е갨갨', 42),                    'е갨갨|42', '|àсæò òà丧갢中ù (2)';
    is join-em(pass-on(-> $a, $b { $a + $b }, 2, 3), 42),
       '5|42', '개갨ì丛갢丧e̲𝐝 òà丧갢中ù';

    is pass-on({ $:l~ $:w }, :w<6>, :l<𝐩>), '𝐩6', '丧àìe̲𝐝 àсæ갮ìe̲丧中ò';

}

# vim: expandtab shiftwidth=4
