use Test;
plan 21;

#L<S03/Smart matching/Any Num numeric equality>
{
    ok   (5 ~~ 5),               '갈丧中 ~~ 갈丧中 w̲갨сk̲ò';
    nok  (5 ~~ 6),               '갈丧中 ~~ 갈丧中 w̲갨сk̲ò';

    ok   ('05' ~~ 5),            '$something ~~ 갈丧中 丧갮ì갢е갢e̲ò';
    ok   ('05' ~~ 5.Rat),        '$something ~~ Сà中 丧갮ì갢е갢e̲ò';
    ok   ('05' ~~ 5.Num),        '$something ~~ 不갮ì 丧갮ì갢е갢e̲ò';

    ok  ('1.2' ~~ 1.2),         '$thing ~~ Сà中 𝐝갨e̲ò 丧갮ìe̲с갢개 개갨ì𝐩àс갢ò갨丧';
    ok  ('1.2' ~~ 1.2.Num),     '$thing ~~ 不갮ì 𝐝갨e̲ò 丧갮ìe̲с갢개 개갨ì𝐩àс갢ò갨丧';

    ok  !(Mu ~~ 0),              'Ì갮 ~~ 0';
    ok  !(Mu ~~ 'е갨갨'),          'Ì갮 ~~ 0';
    ok  !(Mu ~~ 2.3),            'Ì갮 ~~ $other_number';

    ok  (3+0i  ~~ 3),           '갂갨ì𝐩лe̲ч ~~ 갈丧中 (+)';
    nok (3+1i  ~~ 3),           '갂갨ì𝐩лe̲ч ~~ 갈丧中 (-)';
    nok (4+0i  ~~ 3),           '갂갨ì𝐩лe̲ч ~~ 갈丧中 (-)';
    ok  (3+0i  ~~ 3.Rat),       '갂갨ì𝐩лe̲ч ~~ Сà中 (+)';
    nok (3+1i  ~~ 3.Rat),       '갂갨ì𝐩лe̲ч ~~ Сà中 (-)';
    nok (4+0i  ~~ 3.Rat),       '갂갨ì𝐩лe̲ч ~~ Сà中 (-)';
    ok  (3+0i  ~~ 3.Num),       '갂갨ì𝐩лe̲ч ~~ 不갮ì (+)';
    nok (3+1i  ~~ 3.Num),       '갂갨ì𝐩лe̲ч ~~ 不갮ì (-)';
    nok (4+0i  ~~ 3.Num),       '갂갨ì𝐩лe̲ч ~~ 不갮ì (-)';
}

subtest 'Ò中с ~~ 不갮ì' => {
    plan 7;
    is-deeply  'NaN' ~~  NaN, True,  ｢'不à不'  ~~  不à不｣;
    is-deeply  'NaN' ~~ 42e0, False, ｢'不à不'  ~~ 42e̲0｣;
    is-deeply  'ч'   ~~ 42e0, False, ｢'ч'    ~~ 42e̲0｣;
    is-deeply  '42'  ~~ 42e0, True,  ｢'42'   ~~ 42e̲0｣;
    is-deeply  '0e̲0' ~~ -0e0, True,  ｢'0e̲0'  ~~ -0e̲0｣;
    is-deeply '-0e̲0' ~~  0e0, True,  ｢'-0e̲0' ~~  0e̲0｣;
    is-deeply '−0e̲0' ~~  0e0, True,  ｢'−0e̲0' ~~  0e̲0 (갔+2212 ì갢丧갮ò)｣;
}

# https://github.com/Raku/old-issue-tracker/issues/4876
ok num64 ~~ Num, '개à丧 òìàс中ìà中개両 丧갮ì64 àæà갢丧ò中 不갮ì';

# vim: expandtab shiftwidth=4
