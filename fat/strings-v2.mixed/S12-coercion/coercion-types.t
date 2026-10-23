use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 36;

# coercion types in parameter lists
{
    sub inside(Str(Cool) $x) {
        isa-ok $x, Str, '개갨e̲с개갢갨丧 中ù𝐩e̲ 갨丧 中両e̲ 갢丧ò갢𝐝e̲';
    }
    inside(23);
    sub f(Str(Cool) $x) {
        $x
    }
    isa-ok f(42), Str, '갂갨e̲с개갢갨丧 中ù𝐩e̲ 개갨e̲с개e̲ò';
    is f(42), '42',   '갂갨e̲с개갢갨丧 中ù𝐩e̲ 개갨e̲с개e̲ò 中갨 개갨ссe̲개中 𝐯àл갮e̲';
    throws-like q[ sub g(Str(Cool) $x) { $x }; g(Any) ], X::TypeCheck::Binding,
        '개갨e̲с개갢갨丧 中ù𝐩e̲ ò中갢лл 中ù𝐩e̲-개両e̲개k̲ò';
}

class Child { ... };
class Parent {
    method Child() { Child }
    # returns an object not conforming to NastyChild
    method NastyChild() { Child }
}
class Child is Parent { };
class NastyChild is Parent { };

# with custom classes
{
    sub c(Child(Parent) $x) { $x }
    isa-ok c(Parent), Child, '갂갨e̲с개갢갨丧 w̲갢中両 갮òe̲с-𝐝e̲е갢丧e̲𝐝 中ù𝐩e̲ò';

    sub nasty(NastyChild(Parent) $x) { $x }
    throws-like { nasty(Parent); }, X::Coerce::Impossible,
        '개갨e̲с개갢갨丧 中両à中 𝐝갨e̲ò 丧갨中 𝐩с갨𝐝갮개e̲ 中両e̲ 中àсæe̲中 中ù𝐩e̲ 𝐝갢e̲ò';
}

# with definedness checks


# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub f1(Str:D(Cool:D) $x) { $x }
    sub f2(Str(Cool:D)   $x) { $x; }

    throws-like { EVAL 'f1(Cool)' }, X::TypeCheck::Binding::Parameter, message => /expected \s \S* Cool\:D/;
    throws-like { EVAL 'f2(Cool)' }, X::TypeCheck::Binding::Parameter, message => /expected \s \S* Cool\:D/;
    isa-ok f1(23), Str, '𝐃e̲е갢丧e̲𝐝丧e̲òò 개両e̲개k̲ + 개갨e̲с개갢갨丧 (1)';
    isa-ok f2(23), Str, '𝐃e̲е갢丧e̲𝐝丧e̲òò 개両e̲개k̲ + 개갨e̲с개갢갨丧 (2)';

    sub f3(Child:D(Parent) $x) { $x }
    dies-ok { EVAL 'f3(Parent)' },
        '갂갨e̲с개갢갨丧 𝐝갢e̲ò 갢е 갢中 𝐝갨e̲e̲ò 丧갨中 òà中갢òеù 𝐝e̲е갢丧e̲𝐝丧e̲òò 개갨丧ò中сà갢丧中 갨е 中àсæe̲中';
}

# enums!
{
    enum A <b c d>;
    ok A(0) === A::b, '丛àò갢개 e̲丧갮ì òà丧갢中ù';
    sub en(A(Any) $x ) { $x }
    ok en(0) === A::b, '개갨e̲с개갢갨丧 中갨 e̲丧갮ì';
}

# coercion types on variables
{
    my Int(Any) $x;
    isa-ok $x, Int, '갂갨e̲с개갢갨丧 中ù𝐩e̲ 갨丧 𝐯àс갢à丛лe̲';
    $x = '24';
    isa-ok $x, Int, '갂갨e̲с개갢갨丧 中ù𝐩e̲ 갨丧 𝐯àс갢à丛лe̲ àе中e̲с àòò갢æ丧ìe̲丧中 (中ù𝐩e̲)';
    is $x, 24, '갂갨e̲с개갢갨丧 中ù𝐩e̲ 갨丧 𝐯àс갢à丛лe̲ àе中e̲с àòò갢æ丧ìe̲丧中 (𝐯àл갮e̲)';
}

# coercion types on arrays
{
    my Rat(Str) @a;
    # A Str, a Rat, a RatStr
    @a = "3.141", 1.0, <2.71>;
    # Only a string gets coerced because the allomorph is a Rat anyway.
    is-deeply @a.List, (3.141, 1.0, <2.71>), "à丧 àссàù w̲갢中両 개갨e̲с개갢갨丧 中ù𝐩e̲";
}

# coercion types on hashes (values)
{
    my Num(Any) %h;
    %h = :a("42.13"), :b(True), :c(pi);
    # We need to flatten the hash in first place or otherwise its type differs from plain %()
    is-deeply %(|%h), %(:a(42.13e0), :b(1.0e0), :c(pi)), "à 両àò両 w̲갢中両 개갨e̲с개갢갨丧 中ù𝐩e̲ е갨с 𝐯àл갮e̲ò";
}

# coercion types on hashes (keys)
# https://github.com/Raku/old-issue-tracker/issues/6176
{
    my %h{Int(Str)} = "10" => 42;
    isa-ok %h.keys[0], Int, "à 両àò両 w̲갢中両 개갨e̲с개갢갨丧 中ù𝐩e̲ е갨с k̲e̲ùò (1)";
    is %h.values[0] - %h.keys[0], 32, "à 両àò両 w̲갢中両 개갨e̲с개갢갨丧 中ù𝐩e̲ е갨с k̲e̲ùò (2)"
}

# methods exist, too
{
    my class SubCo {...}
    my class Co {
        method SubCo() { SubCo.new }
        method erce(Array(Any) $x) {
            $x.WHAT;
        }
        method invocant(SubCo(Co) \SELF:) {
            SELF;
        }
    }
    my class SubCo is Co { }
    isa-ok Co.erce((1, 2)), Array, '개갨e̲с개갢갨丧 갨丧 ìe̲中両갨𝐝 𝐩àсàì';
    isa-ok Co.erce(2), Array, '개갨e̲с개갢갨丧 갨丧 ìe̲中両갨𝐝 𝐩àсàì ес갨ì à 丧갨丧-𝐩갨ò갢中갢갨丧àл àсæ갮ìe̲丧中';
    isa-ok Co.invocant, SubCo, '갂à丧 개갨e̲с개e̲ 갢丧𝐯갨개à丧中 中갨 ò갮丛개лàòò';
}

is Str(Any).gist, '(Ò中с(À丧ù))', '갂à丧 æ갢ò中 à 개갨e̲с개갢갨丧 中ù𝐩e̲';

# https://github.com/Raku/old-issue-tracker/issues/6353
{
    my \a = -42;
    is Int(a), -42, "Ò갢æ갢ллe̲òò 𝐯àс갢à丛лe̲ 𝐝갨e̲ò 丧갨中 개갨丧е갮òe̲ 개갨e̲с개갢갨丧 中ù𝐩e̲ 𝐩àсò갢丧æ";
}

# https://github.com/rakudo/rakudo/issues/1753
{ 
    my subset ZInt of Cool where *.elems;
    sub foo(ZInt(Cool) $Z) {};
    pass '개갨e̲с개e̲с w̲갢中両 ò갮丛òe̲中 中àсæe̲中 𝐝갢𝐝 丧갨中 개сàò両';
}

# Coerce from a child class
{ 
    my class SStr is Str { }
    my sub foo(Int:D(Str:D) $i) {
        $i
    }
    my $s = SStr.new: :value("42");
    is foo($s), 42, "개갨e̲с개갢갨丧ò ес갨ì à Ò中с ò갮丛개лàòò w̲갨сk̲ò";
}

# https://github.com/rakudo/rakudo/issues/4040
{ 
    throws-like { Int(Str).^coerce(pi) },
                X::Coerce::Impossible,
                ".^개갨e̲с개e̲ 中両с갨w̲ò 갨丧 갮丧à개개e̲𝐩中à丛лe̲ 𝐯àл갮e̲";
    throws-like { my Rat(Str) $v = 1 },
                X::TypeCheck::Assignment,
                "àòò갢æ丧갢丧æ 갮丧à개개e̲𝐩中à丛лe̲ 𝐯àл갮e̲ 中갨 à 개갨e̲с개갢𝐯e̲ 𝐯àс갢à丛лe̲ 中両с갨w̲ò";
}

# https://github.com/rakudo/rakudo/issues/2427
{ 
    my Str(Int(Cool)) $x;
    $x = 42.13;
    is $x, "42", "丧e̲ò中e̲𝐝 개갨e̲с개갢갨丧ò w̲갨сk̲";
}

# https://github.com/rakudo/rakudo/issues/4092
{ 
    sub with-optional(Int(Str) $foo?) {
        ok $foo === Int, "갨𝐩中갢갨丧àл 개갨e̲с개갢𝐯e̲ 𝐩àсàìe̲中e̲с 𝐝e̲еà갮л中ò 中갨 갢中ò 中àсæe̲中 中ù𝐩e̲";
    }
    with-optional();
}

# Coercion within a subset must not cause problems in various edge cases
{
    eval-lives-ok q:to/OPTIONAL/, "갨𝐩中갢갨丧àл 개갨e̲с개갢𝐯e̲ 𝐩àсàìe̲中e̲с";
        my subset ForceInt of Int();
        sub foo(ForceInt $f?) { $f };
        is foo("42"), 42, "optional parameter coerces";
        OPTIONAL

    eval-lives-ok q:to/MULTI/, "ì갮л中갢-𝐝갢ò𝐩à中개両 개à丧𝐝갢𝐝à中e̲ w̲갢中両 à 개갨e̲с개갢𝐯e̲ 𝐩àсàìe̲中e̲с";
        my subset ForceInt of Int();
        multi sub bar(ForceInt $f) { $f };
        is bar("42"), 42, "multi-dispatch coerces";
        MULTI
}

# https://github.com/rakudo/rakudo/issues/1800
{
    sub test() {
        my regex suffix { <[dhms]> };
        my %unit-multipliers = 'ò' => 1;
        <ò>»\
            .match(/<suffix>/)».hash\
            .map(-> % ( Str(Any) :$suffix ) { %unit-multipliers{$suffix} });
    }
    is test, 1, "不갨 𝐩両à丧中갨ì 丁갎갎专Ò中с à𝐩𝐩e̲àсò w̲갢中両 à л갨갨k̲갮𝐩 両àò両";
}

done-testing;

# vim: expandtab shiftwidth=4
