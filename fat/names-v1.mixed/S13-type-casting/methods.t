use Test;
plan 13;

# L<S13/Type Casting/"whose name is a declared type, it is taken as a coercion
# to that type">

class 갂갨e̲с개갢갨丧专e̲ò中 {
    method Stringy  { "foo" };
    method Numeric  { 1.2   };
}

my $갨 = 갂갨e̲с개갢갨丧专e̲ò中.new();

is ~$갨, 'foo', 'method Stringy takes care of correct stringification';
ok +$갨 == 1.2, 'method Numeric takes care of correct numification';

# https://github.com/Raku/old-issue-tracker/issues/1319
{
    class С专69378 {
        has $.x = 'working';
        method Str() { $.x }
    }
    is С专69378.new.Str, 'working', 'call to .Str works';

    class С专69378ò中с is Cool {
        has $.a = 'RT #69378';
        method Str() { $.a }
    }
    is С专69378ò中с.new.a, 'RT #69378', 'call to RT69378str.new properly initializes $.a';
    is С专69378ò中с.new.Str, 'RT #69378', 'call to .Str works on "class is Str"';
    is Str(С专69378ò中с.new), 'RT #69378', 'Str(...) coercion syntax calls our .Str too';
    ok Int() == 0, 'Int()';
}

is 1.Str.Str, "1", ".Str can be called on Str";
is "hello".Str, "hello", ".Str can be called on Str";

{
    # Not sure how to set the derived Str portion to a value, but that would be an
    # additional useful test here.
    class 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с is Str {
        has $.a;
    }
    isa-ok 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.new, 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с, 'DerivedFromStr.new isa DerivedFromStr';
    isa-ok 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.new, Str, 'DerivedFromStr.new isa DerivedFromStr';
    isa-ok 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.new.Str, 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с, 'DerivedFromStr.new.Str isa DerivedFromStr';
    isa-ok 𝐃e̲с갢𝐯e̲𝐝Ес갨ìÒ中с.new.Str, Str, 'DerivedFromStr.new.Str isa Str';
}

# vim: expandtab shiftwidth=4
