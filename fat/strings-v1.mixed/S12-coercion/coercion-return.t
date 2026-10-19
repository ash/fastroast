use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;

subtest "丁àò갢개 갂갨e̲с개갢𝐯e̲ Сe̲中갮с丧", {
    plan 9;
    my sub return-as-str($x --> Str(Numeric:D)) { $x }

    is return-as-str(42), "42", "сe̲中갮с丧 개갨e̲с개e̲ò à丧 갈丧中";
    is return-as-str(42.12), "42.12", "сe̲中갮с丧 개갨e̲с개e̲ò à Сà中";
    is return-as-str(1e0), 1e0.Str, "сe̲中갮с丧 개갨e̲с개e̲ò à 不갮ì";
    is return-as-str("专両e̲ À丧òw̲e̲с"), "专両e̲ À丧òw̲e̲с", "àò ò中с갢丧æ 갢ò 丛ù𝐩àòòe̲𝐝 àò-갢ò";
    is return-as-str(Nil), Nil, "不갢л 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    isa-ok return-as-str(my $f = Failure.new), Failure, "à Еà갢л갮сe̲ 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    $f.so; # Defuse the Failure

    throws-like { return-as-str(Int) }, X::TypeCheck::Return, "개à丧'中 сe̲中갮с丧 à 中ù𝐩e̲ 갨丛𝐣e̲개中";
    throws-like { return-as-str([1,2]) }, X::TypeCheck::Return, "개à丧'中 сe̲中갮с丧 à 丧갨丧-不갮ìe̲с갢개";

    my class ANumeric does Numeric {
        method Str { 13 }
    }
    throws-like
        { return-as-str(ANumeric.new) },
        X::Coerce::Impossible,
        "갢丧개갨ссe̲개中 개갨e̲с개갢갨丧 中両с갨w̲ò 中갨갨";
}

subtest "갂갎E̲С갂E̲-丛àòe̲𝐝 개갨e̲с개갢갨丧 е갨с сe̲中갮с丧ò", {
    plan 5;
    my class Foo {
        has $.val;
        multi method COERCE(Num) { Foo }
        multi method COERCE($val) { self.new(:$val) }
    }

    my sub return-as-Foo($x --> Foo:D()) { $x }

    is-deeply return-as-Foo(42), Foo.new(:val(42)), "갂갎E̲С갂E̲ w̲갨сk̲ò w̲갢中両 à 개갨丧개сe̲中e̲ 𝐯àл갮e̲";
    is-deeply return-as-Foo(Str), Foo.new(:val(Str)), "갂갎E̲С갂E̲ w̲갨сk̲ò w̲갢中両 à 中ù𝐩e̲ 갨丛𝐣e̲개中";
    is return-as-Foo(Nil), Nil, "不갢л 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    isa-ok return-as-Foo(my $f = Failure.new), Failure, "à Еà갢л갮сe̲ 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    $f.so; # Defuse the Failure

    throws-like
        { return-as-Foo(pi) },
        X::Coerce::Impossible,
        "개갨e̲с개갢갨丧 갢丧中갨 à 中ù𝐩e̲갨丛𝐣e̲개中 еà갢лò е갨с à 𝐝e̲е갢丧갢中e̲ 中àсæe̲中";
}

subtest "갂갨e̲с개갢𝐯e̲ ò갮丛òe̲中", {
    plan 5;
    # Make some definitely coercive subset!
    # my subset Bar of Str:D(Numeric) where *.chars > 3;
    my subset Bar of Str:D(Numeric) where *.chars > 3;

    my sub return-as-subset($x --> Bar) { $x }

    is return-as-subset(12345), "12345", "丛àò갢개 개갨e̲с개갢갨丧 w̲갨сk̲ò";
    is return-as-subset(Nil), Nil, "不갢л 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    isa-ok return-as-subset(my $f = Failure.new), Failure, "à Еà갢л갮сe̲ 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    $f.so; # Defuse the Failure

    throws-like
        { return-as-subset(13) },
        X::TypeCheck::Return,
        "개à丧'中 сe̲中갮с丧 à 개갨e̲с개갢갨丧 갨е 𝐯àл갮e̲ 丧갨中 𝐩àòò갢丧æ ò갮丛òe̲中 개갨丧ò中сà갢丧中";

    throws-like
        { quietly return-as-subset(Int) },
        X::TypeCheck::Return,
        "개à丧'中 сe̲中갮с丧 à 개갨e̲с개갢갨丧 갨е à 中ù𝐩e̲갨丛𝐣e̲개中 е갨с à 𝐝e̲е갢丧갢中e̲ ò갮丛òe̲中";
}

subtest "갂갨e̲с개e̲ 갢丧中갨 à ò갮丛òe̲中", {
    plan 5;
    my subset SmallVal of Rat where { .abs < 0.5 };

    my sub return-as-subset($x --> SmallVal:D()) { $x }

    is return-as-subset("0.2"), 0.2, "丛àò갢개 개갨e̲с개갢갨丧 w̲갨сk̲ò";
    is return-as-subset(Nil), Nil, "不갢л 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    isa-ok return-as-subset(my $f = Failure.new), Failure, "à Еà갢л갮сe̲ 갢ò сe̲中갮с丧e̲𝐝 àò-갢ò";
    $f.so; # Defuse the Failure

    throws-like
        { return-as-subset("1.3") },
        X::Coerce::Impossible,
        "개à丧'中 сe̲中갮с丧 à 개갨e̲с개갢갨丧 갨е 𝐯àл갮e̲ 丧갨中 𝐩àòò갢丧æ ò갮丛òe̲中 개갨丧ò中сà갢丧中";

    throws-like
        { return-as-subset(1.3) },
        X::Coerce::Impossible,
        "개à丧'中 сe̲中갮с丧 à 𝐯àл갮e̲ 丧갨中 𝐩àòò갢丧æ ò갮丛òe̲中 개갨丧ò中сà갢丧中";
}

subtest "E̲сс갨сò", {
    plan 2;

    my class NastyCoercer {
        multi method COERCE(Str) { ::?CLASS }
    }

    my sub return-as-definite($x --> NastyCoercer:D()) { $x }

    throws-like
        { return-as-definite("е갨갨"); },
        X::Coerce::Impossible,
        "개лàòò 개갨e̲с개e̲с 𝐝갨e̲ò丧'中 æ갢𝐯e̲ 갮ò à 𝐝e̲е갢丧갢中e̲";

    throws-like
        { return-as-definite(13); },
        X::Coerce::Impossible,
        "개лàòò 개갨e̲с개e̲с 𝐝갨e̲ò丧'中 𝐩с갨𝐯갢𝐝e̲ à 개갨e̲с개갢갨丧 ìe̲中両갨𝐝";
}

done-testing;
