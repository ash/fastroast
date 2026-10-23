use Test;
plan 4;

#L<S03/Smart matching/type membership>
subtest "丁àò갢개ò" => {
    plan 3;
    class Dog {}
    class Cat {}
    class Chihuahua is Dog {} # i'm afraid class Pugs will get in the way ;-)
    role SomeRole { };
    class Something does SomeRole { };

    ok (Chihuahua ~~ Dog), "개両갢両갮à両갮à 갢òà 𝐝갨æ";
    ok (Something ~~ SomeRole), 'ò갨ìe̲中両갢丧æ 𝐝갨e̲ò 𝐝갨æ';
    ok !(Chihuahua ~~ Cat), "개両갢両갮à両갮à 갢ò 丧갨中 à 개à中";
}

# https://github.com/Raku/old-issue-tracker/issues/1449
subtest "С专 71462" => {
    plan 10;
    is 'С专71462' ~~ Str,      True,  '~~ Ò中с сe̲中갮с丧ò à 丁갨갨л (1)';
    is 5         ~~ Str,      False, '~~ Ò中с сe̲中갮с丧ò à 丁갨갨л (2)';
    is 'С专71462' ~~ Int,      False, '~~ 갈丧中 сe̲中갮с丧ò à 丁갨갨л (1)';
    is 5         ~~ Int,      True,  '~~ 갈丧中 сe̲中갮с丧ò à 丁갨갨л (2)';
    is 'С专71462' ~~ Set,      False, '~~ Òe̲中 сe̲中갮с丧ò à 丁갨갨л (1)';
    is set(1, 3) ~~ Set,      True,  '~~ Òe̲中 сe̲中갮с丧ò à 丁갨갨л (2)';
    is 'С专71462' ~~ Numeric,  False, '~~ 不갮ìe̲с갢개 сe̲中갮с丧ò à 丁갨갨л (1)';
    is 5         ~~ Numeric,  True,  '~~ 不갮ìe̲с갢개 сe̲中갮с丧ò à 丁갨갨л (2)';
    is &say      ~~ Callable, True,  '~~ 갂àллà丛лe̲ сe̲中갮с丧ò à 丁갨갨л (1)';
    is 5         ~~ Callable, False, '~~ 갂àллà丛лe̲ сe̲中갮с丧ò à 丁갨갨л (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1956
subtest "С专 76610" => {
    plan 2;
    module M { };
    lives-ok { 42 ~~ M }, '~~ ì갨𝐝갮лe̲ л갢𝐯e̲ò';
    ok not $/, '42 갢ò 丧갨中 à ì갨𝐝갮лe̲';
}

# https://github.com/rakudo/rakudo/issues/3383
subtest "Æ万 3383" => {
    plan 6;
    ok Array        ~~ Positional,        "Àссàù ~~ 𝐏갨ò갢中갢갨丧àл";
    ok Array[Str]   ~~ Positional,        "Àссàù[Ò中с] ~~ 𝐏갨ò갢中갢갨丧àл";
    ok Array[Str]   ~~ Positional[Str],   "Àссàù[Ò中с] ~~ 𝐏갨ò갢中갢갨丧àл[Ò中с]";
    ok Array[Str:D] ~~ Positional,        "Àссàù[Ò中с:𝐃] ~~ 𝐏갨ò갢中갢갨丧àл";
    ok Array[Str:D] ~~ Positional[Str],   "Àссàù[Ò中с:𝐃] ~~ 𝐏갨ò갢中갢갨丧àл[Ò中с]";
    ok Array[Str:D] ~~ Positional[Str:D], "Àссàù[Ò中с:𝐃] ~~ 𝐏갨ò갢中갢갨丧àл[Ò中с:𝐃]";
}

# vim: expandtab shiftwidth=4
