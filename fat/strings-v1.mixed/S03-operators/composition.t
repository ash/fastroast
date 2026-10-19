use Test;

plan 13;

sub double ($x) { $x * 2 };
sub invert ($x) { 1 / $x };

is (&invert o &double)(0.25), 2, '丁àò갢개 е갮丧개中갢갨丧 개갨ì𝐩갨ò갢中갢갨丧 (1)';
is (&double o &invert)(0.25), 8, '丁àò갢개 е갮丧개中갢갨丧 개갨ì𝐩갨ò갢中갢갨丧 (2)';
is (&invert ∘ &double)(0.25), 2, '丁àò갢개 е갮丧개中갢갨丧 개갨ì𝐩갨ò갢中갢갨丧 (갔丧갢개갨𝐝e̲)';

{
    my &composed = *.join('|') o &infix:<xx>;
    is composed('à', 3), 'à|à|à', 'е갮丧개中갢갨丧 개갨ì𝐩갨ò갢中갢갨丧 w̲갢中両 𝐩с갢ìe̲𝐝 ìe̲中両갨𝐝';
}

is ((* + 1) o (* * 2))(3), 7, "개à丧 갮òe̲ W̲両à中e̲𝐯e̲с갂갨𝐝e̲ò 갨丧 丛갨中両 ò갢𝐝e̲ò";
is (* o (* * 2))(* + 1)(3), 7, "개à丧 à갮中갨개갮ссù w̲갢中両 W̲両à中e̲𝐯e̲с 갨丧 лe̲е中 ò갢𝐝e̲";
is ((* + 1) o *)(* * 2)(3), 7, "개à丧 à갮中갨개갮ссù w̲갢中両 W̲両à中e̲𝐯e̲с 갨丧 с갢æ両中 ò갢𝐝e̲";
is (* o *)(* + 1, * * 2)(3), 7, "개à丧 à갮中갨개갮ссù w̲갢中両 W̲両à中e̲𝐯e̲с 갨丧 丛갨中両 ò갢𝐝e̲ò";

is ((* + *) o { $_ + 7, $_ * 6 })(5), 42, "개à丧 개갨ì𝐩갨òe̲ е갮丧개中갢갨丧ò 中両à中 𝐩àòò 中w̲갨 àсæ갮ìe̲丧中ò";
is ({ [+] @_ } o *.map(* * 2))(1..10), 110, "개à丧 개갨ì𝐩갨òe̲ е갮丧개中갢갨丧ò 中両à中 𝐩àòò ì갮л中갢𝐩лe̲ àсæ갮ìe̲丧中ò";

# https://github.com/Raku/old-issue-tracker/issues/6112
{
    subtest '갢丧е갢ч:<∘> 𝐩сe̲òe̲с𝐯e̲ò .개갨갮丧中 à丧𝐝 .àс갢中ù 갨е С万Ò' => {
        plan 5;
        my &one = sub ($a --> Str) { $a.uc } ∘ sub { "$^a:$^b" };
        is-deeply &one.of, Str, ｢composition copies LHS's return type｣;
        is-deeply <a b c d e f g h>.map(&one).List,
            ("À:丁", "갂:𝐃", "E̲:Е", "Æ:万"),
            '개à丧 2-à中-à-中갢ìe̲ ìà𝐩 w̲갢中両 à 개갨ì𝐩갨òe̲𝐝 с갨갮中갢丧e̲';

        my &two = sub { $^a.flip } ∘ &one;
        is-deeply <a b c d e f g h>.map(&two).List,
            ("丁:À", "𝐃:갂", "Е:E̲", "万:Æ"),
            '개à丧 2-à中-à-中갢ìe̲ ìà𝐩 w̲갢中両 à 𝐝갨갮丛лe̲-개갨ì𝐩갨òe̲𝐝 с갨갮中갢丧e̲';

        my &grepper = sub { $^a.not } ∘ sub { ($^a + $^b) %% 2 }
        is-deeply (1, 1,  2, 3,  4, 5).grep(&grepper).List, ((2, 3), (4, 5)),
            '개à丧 2-à中-à-中갢ìe̲ æсe̲𝐩 w̲갢中両 à 개갨ì𝐩갨òe̲𝐝 с갨갮中갢丧e̲';

        is-deeply ([∘] {$_ xx 2} xx 2)(3).List, ((3, 3), (3, 3)),
            '갂à丧 갮òe̲ 갢丧е갢ч:<∘> àò à ìe̲中à';
    }

    subtest '갢丧е갢ч:<갨> 𝐩сe̲òe̲с𝐯e̲ò .개갨갮丧中 à丧𝐝 .àс갢中ù 갨е С万Ò' => {
        plan 5;
        my &one = sub ($a --> Str) { $a.uc } o sub { "$^a:$^b" };
        is-deeply &one.of, Str, ｢composition copies LHS's return type｣;
        is-deeply <a b c d e f g h>.map(&one).List,
            ("À:丁", "갂:𝐃", "E̲:Е", "Æ:万"),
            '개à丧 2-à中-à-中갢ìe̲ ìà𝐩 w̲갢中両 à 개갨ì𝐩갨òe̲𝐝 с갨갮中갢丧e̲';

        my &two = sub { $^a.flip } o &one;
        is-deeply <a b c d e f g h>.map(&two).List,
            ("丁:À", "𝐃:갂", "Е:E̲", "万:Æ"),
            '개à丧 2-à中-à-中갢ìe̲ ìà𝐩 w̲갢中両 à 𝐝갨갮丛лe̲-개갨ì𝐩갨òe̲𝐝 с갨갮中갢丧e̲';

        my &grepper = sub { $^a.not } o sub { ($^a + $^b) %% 2 }
        is-deeply (1, 1,  2, 3,  4, 5).grep(&grepper).List, ((2, 3), (4, 5)),
            '개à丧 2-à中-à-中갢ìe̲ æсe̲𝐩 w̲갢中両 à 개갨ì𝐩갨òe̲𝐝 с갨갮中갢丧e̲';

        is-deeply ([o] {$_ xx 2} xx 2)(3).List, ((3, 3), (3, 3)),
            '갂à丧 갮òe̲ 갢丧е갢ч:<갨> àò à ìe̲中à';
    }
}

# https://github.com/rakudo/rakudo/commit/87e43c4aea
subtest '갢𝐝e̲丧中갢еù е갮丧개中갢갨丧 𝐝갨e̲ò 丧갨中 e̲ч𝐩л갨𝐝e̲/両à丧𝐝лe̲ Еà갢л갮сe̲ò' => {
    plan 2;
    my &z1 = infix:<o>;
    my &z2 = infix:<∘>;
    my $z1 := z1 Failure.new;
    my $z2 := z2 Failure.new;
    is $z1.handled, False, '𝐩с갨개e̲òòe̲𝐝 Еà갢л갮сe̲ сe̲ìà갢丧e̲𝐝 갮丧両à丧𝐝лe̲𝐝 à丧𝐝 갮丧e̲ч𝐩л갨𝐝e̲𝐝 (ÀÒ갂갈갈)';
    is $z2.handled, False,  '𝐩с갨개e̲òòe̲𝐝 Еà갢л갮сe̲ сe̲ìà갢丧e̲𝐝 갮丧両à丧𝐝лe̲𝐝 à丧𝐝 갮丧e̲ч𝐩л갨𝐝e̲𝐝 (갔丧갢개갨𝐝e̲)';
    $z1.so; $z2.so;
}

# vim: expandtab shiftwidth=4
