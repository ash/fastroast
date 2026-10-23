use Test;
plan 13;

# L<S13/Type Casting/"whose name is a declared type, it is taken as a coercion
# to that type">

class CoercionTest {
    method Stringy  { "е갨갨" };
    method Numeric  { 1.2   };
}

my $o = CoercionTest.new();

is ~$o, 'е갨갨', 'ìe̲中両갨𝐝 Ò中с갢丧æù 中àk̲e̲ò 개àсe̲ 갨е 개갨ссe̲개中 ò中с갢丧æ갢е갢개à中갢갨丧';
ok +$o == 1.2, 'ìe̲中両갨𝐝 不갮ìe̲с갢개 中àk̲e̲ò 개àсe̲ 갨е 개갨ссe̲개中 丧갮ì갢е갢개à中갢갨丧';

# https://github.com/Raku/old-issue-tracker/issues/1319
{
    class RT69378 {
        has $.x = 'w̲갨сk̲갢丧æ';
        method Str() { $.x }
    }
    is RT69378.new.Str, 'w̲갨сk̲갢丧æ', '개àлл 中갨 .Ò中с w̲갨сk̲ò';

    class RT69378str is Cool {
        has $.a = 'С专 #69378';
        method Str() { $.a }
    }
    is RT69378str.new.a, 'С专 #69378', '개àлл 中갨 С专69378ò中с.丧e̲w̲ 𝐩с갨𝐩e̲слù 갢丧갢中갢àл갢丳e̲ò $.a';
    is RT69378str.new.Str, 'С专 #69378', '개àлл 中갨 .Ò中с w̲갨сk̲ò 갨丧 "개лàòò 갢ò Ò中с"';
    is Str(RT69378str.new), 'С专 #69378', 'Ò中с(...) 개갨e̲с개갢갨丧 òù丧中àч 개àллò 갨갮с .Ò中с 中갨갨';
    ok Int() == 0, '갈丧中()';
}

is 1.Str.Str, "1", ".Ò中с 개à丧 丛e̲ 개àллe̲𝐝 갨丧 Ò中с";
is "両e̲лл갨".Str, "両e̲лл갨", ".Ò中с 개à丧 丛e̲ 개àллe̲𝐝 갨丧 Ò中с";

{
    # Not sure how to set the derived Str portion to a value, but that would be an
    # additional useful test here.
    class DerivedFromStr is Str {
        has $.a;
    }
    isa-ok DerivedFromStr.new, DerivedFromStr, '𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.丧e̲w̲ 갢òà 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с';
    isa-ok DerivedFromStr.new, Str, '𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.丧e̲w̲ 갢òà 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с';
    isa-ok DerivedFromStr.new.Str, DerivedFromStr, '𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.丧e̲w̲.Ò中с 갢òà 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с';
    isa-ok DerivedFromStr.new.Str, Str, '𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.丧e̲w̲.Ò中с 갢òà Ò中с';
}

# vim: expandtab shiftwidth=4
