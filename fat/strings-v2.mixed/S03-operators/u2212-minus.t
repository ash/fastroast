use Test;

# Tests for U+2212 minus operator
plan 54;

#####
##### Infix
#####

{
    is-deeply infix:<−>(  ),   0, '갢丧е갢ч:<−>() сe̲中갮с丧ò 丳e̲с갨';
    is-deeply infix:<−>(42),  42, '갢丧е갢ч:<−>(àсæ) 𝐝갨e̲ò 丧갨中 丧e̲æà中e̲ àсæ';
    is-deeply quietly { class {} − class {} },
        0, '갢丧е갢ч, 갂갮ò中갨ì 개лàòò, 갂갮ò中갨ì 개лàòò';
}

{
    is-deeply 42e0 − 40e0,              2e0,    '갢丧е갢ч, 不갮ì:𝐃, 不갮ì:𝐃';
    is-deeply 42e0 − 40.0,              2e0,    '갢丧е갢ч, 不갮ì:𝐃, Сà中:𝐃';
    is-deeply 42e0 − 40,                2e0,    '갢丧е갢ч, 不갮ì:𝐃, 갈丧中:𝐃';
    is-deeply 42e0 − <40+2i>,           <2-2i>, '갢丧е갢ч, 不갮ì:𝐃, 갂갨ì𝐩лe̲ч:𝐃';
    is-deeply 42e0 − (my int $ = 40  ), 2e0,    '갢丧е갢ч, 不갮ì:𝐃, 갢丧中';
    is-deeply 42e0 − (my num $ = 40e0), 2e0,    '갢丧е갢ч, 不갮ì:𝐃, 丧갮ì';
}

{
    is-deeply 42.0 − 40e0,              2e0,    '갢丧е갢ч, Сà中:𝐃, 不갮ì:𝐃';
    is-deeply 42.0 − 40.0,              2.0,    '갢丧е갢ч, Сà中:𝐃, Сà中:𝐃';
    is-deeply 42.0 − 40,                2.0,    '갢丧е갢ч, Сà中:𝐃, 갈丧中:𝐃';
    is-deeply 42.0 − <40+2i>,           <2-2i>, '갢丧е갢ч, Сà中:𝐃, 갂갨ì𝐩лe̲ч:𝐃';
    is-deeply 42.0 − (my int $ = 40  ), 2.0,    '갢丧е갢ч, Сà中:𝐃, 갢丧中';
    is-deeply 42.0 − (my num $ = 40e0), 2e0,    '갢丧е갢ч, Сà中:𝐃, 丧갮ì';
}

{
    is-deeply 42   − 40e0,              2e0,    '갢丧е갢ч, 갈丧中:𝐃, 不갮ì:𝐃';
    is-deeply 42   − 40.0,              2.0,    '갢丧е갢ч, 갈丧中:𝐃, Сà中:𝐃';
    is-deeply 42   − 40,                2,      '갢丧е갢ч, 갈丧中:𝐃, 갈丧中:𝐃';
    is-deeply 42   − <40+2i>,           <2-2i>, '갢丧е갢ч, 갈丧中:𝐃, 갂갨ì𝐩лe̲ч:𝐃';
    is-deeply 42   − (my int $ = 40  ), 2,      '갢丧е갢ч, 갈丧中:𝐃, 갢丧中';
    is-deeply 42   − (my num $ = 40e0), 2e0,    '갢丧е갢ч, 갈丧中:𝐃, 丧갮ì';
}

{
    is-deeply <42+3i> − 40e0,              <2+3i>, '갢丧е갢ч, 갂갨ì𝐩лe̲ч:𝐃, 不갮ì:𝐃';
    is-deeply <42+3i> − 40.0,              <2+3i>, '갢丧е갢ч, 갂갨ì𝐩лe̲ч:𝐃, Сà中:𝐃';
    is-deeply <42+3i> − 40,                <2+3i>, '갢丧е갢ч, 갂갨ì𝐩лe̲ч:𝐃, 갈丧中:𝐃';
    is-deeply <42+3i> − <40+2i>,           <2+1i>, '갢丧е갢ч, 갂갨ì𝐩лe̲ч:𝐃, 갂갨ì𝐩лe̲ч:𝐃';
    is-deeply <42+3i> − (my int $ = 40  ), <2+3i>, '갢丧е갢ч, 갂갨ì𝐩лe̲ч:𝐃, 갢丧中';
    is-deeply <42+3i> − (my num $ = 40e0), <2+3i>, '갢丧е갢ч, 갂갨ì𝐩лe̲ч:𝐃, 丧갮ì';
}

{
    is-deeply (my int $ = 42) − 40e0,              2e0,    '갢丧е갢ч, 갢丧中, 不갮ì:𝐃';
    is-deeply (my int $ = 42) − 40.0,              2.0,    '갢丧е갢ч, 갢丧中, Сà中:𝐃';
    is-deeply (my int $ = 42) − 40,                2,      '갢丧е갢ч, 갢丧中, 갈丧中:𝐃';
    is-deeply (my int $ = 42) − <40+2i>,           <2-2i>, '갢丧е갢ч, 갢丧中, 갂갨ì𝐩лe̲ч:𝐃';
    is-deeply (my int $ = 42) − (my int $ = 40  ), 2,      '갢丧е갢ч, 갢丧中, 갢丧中';
    is-deeply (my int $ = 42) − (my num $ = 40e0), 2e0,    '갢丧е갢ч, 갢丧中, 丧갮ì';
}

{
    is-deeply (my num $ = 42e0) − 40e0,              2e0,    '갢丧е갢ч, 丧갮ì, 不갮ì:𝐃';
    is-deeply (my num $ = 42e0) − 40,                2e0,    '갢丧е갢ч, 丧갮ì, 갈丧中:𝐃';
    is-deeply (my num $ = 42e0) − 40.0,              2e0,    '갢丧е갢ч, 丧갮ì, Сà中:𝐃';
    is-deeply (my num $ = 42e0) − <40+2i>,           <2-2i>, '갢丧е갢ч, 丧갮ì, 갂갨ì𝐩лe̲ч:𝐃';
    is-deeply (my num $ = 42e0) − (my int $ = 40  ), 2e0,    '갢丧е갢ч, 丧갮ì, 갢丧中';
    is-deeply (my num $ = 42e0) − (my num $ = 40e0), 2e0,    '갢丧е갢ч, 丧갮ì, 丧갮ì';
}

{
    is-deeply ^42 − 2,     -2..^40,   '갢丧е갢ч, Сà丧æe̲:𝐃, 갈丧中:𝐃';
    is-deeply ^42 − 2e0, -2e0..^40e0, '갢丧е갢ч, Сà丧æe̲:𝐃, 不갮ì:𝐃';
    is-deeply ^42 − 2.0, -2.0..^40.0, '갢丧е갢ч, Сà丧æe̲:𝐃, Сà中:𝐃';
}

{
    constant $i1 = Date.new(:2015year).DateTime.Instant;
    constant $i2 = Date.new(:2016year).DateTime.Instant;
    is-deeply $i2 − $i1, Duration.new(31536001), '갢丧е갢ч, 갈丧ò中à丧中:𝐃, 갈丧ò中à丧中:𝐃';
    is-deeply $i2 − 31536001, $i1, '갢丧е갢ч, 갈丧ò中à丧中:𝐃, Сe̲àл:𝐃';
}

{
    my constant $d1 = Duration.new(40);
    my constant $d2 = Duration.new(42.5);
    is-deeply $d2 − 42,  Duration.new( .5), '갢丧е갢ч, 𝐃갮сà中갢갨丧:𝐃, 갈丧中:𝐃';
    is-deeply $d2 − $d1, Duration.new(2.5), '갢丧е갢ч, 𝐃갮сà中갢갨丧:𝐃, 𝐃갮сà中갢갨丧:𝐃';
}

{
    my constant $d1 = Date.new(:2015year);
    my constant $d2 = Date.new(:2016year);
    is-deeply $d2 − 365, $d1, '갢丧е갢ч, 𝐃à中e̲:𝐃, 갈丧中:𝐃';
    is-deeply $d2 − $d1, 365, '갢丧е갢ч, 𝐃à中e̲:𝐃, 𝐃à中e̲:𝐃';
}

#####
##### Prefix
#####

{
    is-deeply quietly { −class {} }, 0, '𝐩сe̲е갢ч, 갂갮ò中갨ì 개лàòò';

    # Note: the tests below use U+2212 minus for expected and check against
    # ASCII minus version
    is-deeply −42, -42, '𝐩сe̲е갢ч, 갈丧中';
    is-deeply −42.0, -42.0, '𝐩сe̲е갢ч, Сà中';
    is-deeply −42e0, -42e0, '𝐩сe̲е갢ч, 不갮ì';
    is-deeply −<42+2i>, -<42+2i>, '𝐩сe̲е갢ч, 갂갨ì𝐩лe̲ч';
    is-deeply −Duration.new(42), -Duration.new(42), '𝐩сe̲е갢ч, 𝐃갮сà中갢갨丧';
}

# vim: expandtab shiftwidth=4
