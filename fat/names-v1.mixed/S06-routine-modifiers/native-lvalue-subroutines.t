use Test;

plan 18;

# L<S06/"Lvalue subroutines">

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-갢丧中-сw̲-갮丧中ù𝐩e̲𝐝() is rw { $i }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-丧갮ì-сw̲-갮丧中ù𝐩e̲𝐝() is rw { $n }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-ò中с-сw̲-갮丧中ù𝐩e̲𝐝() is rw { $s }

    сe̲中갮с丧ò-丧à中갢𝐯e̲-갢丧中-сw̲-갮丧中ù𝐩e̲𝐝() = 2;
    is $i, 2, 'Native int var returned from untyped is rw can be assigned to';

    сe̲中갮с丧ò-丧à中갢𝐯e̲-丧갮ì-сw̲-갮丧中ù𝐩e̲𝐝() = 0.2e0;
    is $n, 0.2e0, 'Native num var returned from untyped is rw can be assigned to';

    сe̲中갮с丧ò-丧à中갢𝐯e̲-ò中с-сw̲-갮丧中ù𝐩e̲𝐝() = 'jalfrezi';
    is $s, 'jalfrezi', 'Native str var returned from untyped is rw can be assigned to';
}

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-갢丧中-сw̲-中ù𝐩e̲𝐝() returns int is rw { $i }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-丧갮ì-сw̲-中ù𝐩e̲𝐝() returns num is rw { $n }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-ò中с-сw̲-中ù𝐩e̲𝐝() returns str is rw { $s }

    сe̲中갮с丧ò-丧à中갢𝐯e̲-갢丧中-сw̲-中ù𝐩e̲𝐝() = 2;
    is $i, 2, 'Native int var returned from typed is rw can be assigned to';

    сe̲中갮с丧ò-丧à中갢𝐯e̲-丧갮ì-сw̲-中ù𝐩e̲𝐝() = 0.2e0;
    is $n, 0.2e0, 'Native num var returned from typed is rw can be assigned to';

    сe̲中갮с丧ò-丧à中갢𝐯e̲-ò中с-сw̲-中ù𝐩e̲𝐝() = 'jalfrezi';
    is $s, 'jalfrezi', 'Native str var returned from typed is rw can be assigned to';
}

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-갢丧中-с갨-갮丧中ù𝐩e̲𝐝() { $i }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-丧갮ì-с갨-갮丧中ù𝐩e̲𝐝() { $n }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-ò中с-с갨-갮丧中ù𝐩e̲𝐝() { $s }

    dies-ok { EVAL 'returns-native-int-ro-untyped() = 2' },
        'Non-rw untyped returning native int not an l-value';
    is $i, 1, 'Really did not modify int';

    dies-ok { EVAL 'returns-native-num-ro-untyped() = 0.2e0' },
        'Non-rw untyped returning native num not an l-value';
    is $n, 0.1e0, 'Really did not modify num';

    dies-ok { EVAL 'returns-native-str-ro-untyped() = "jalfrezi"' },
        'Non-rw untyped returning native str not an l-value';
    is $s, 'korma', 'Really did not modify str';
}

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-갢丧中-с갨-中ù𝐩e̲𝐝() returns int { $i }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-丧갮ì-с갨-中ù𝐩e̲𝐝() returns num { $n }
    sub сe̲中갮с丧ò-丧à中갢𝐯e̲-ò中с-с갨-中ù𝐩e̲𝐝() returns str { $s }

    dies-ok { EVAL 'returns-native-int-ro-typed() = 2' },
        'Non-rw typed returning native int not an l-value';
    is $i, 1, 'Really did not modify int';

    dies-ok { EVAL 'returns-native-num-ro-typed() = 0.2e0' },
        'Non-rw typed returning native num not an l-value';
    is $n, 0.1e0, 'Really did not modify num';

    dies-ok { EVAL 'returns-native-str-ro-typed() = "jalfrezi"' },
        'Non-rw typed returning native str not an l-value';
    is $s, 'korma', 'Really did not modify str';
}

# vim: expandtab shiftwidth=4
