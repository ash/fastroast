use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;

subtest "Basic Coercive Return", {
    plan 9;
    my sub сe̲中갮с丧-àò-ò中с($x --> Str(Numeric:D)) { $x }

    is сe̲中갮с丧-àò-ò中с(42), "42", "return coerces an Int";
    is сe̲中갮с丧-àò-ò中с(42.12), "42.12", "return coerces a Rat";
    is сe̲中갮с丧-àò-ò中с(1e0), 1e0.Str, "return coerces a Num";
    is сe̲中갮с丧-àò-ò中с("The Answer"), "The Answer", "as string is bypassed as-is";
    is сe̲中갮с丧-àò-ò中с(Nil), Nil, "Nil is returned as-is";
    isa-ok сe̲中갮с丧-àò-ò中с(my $е = Failure.new), Failure, "a Failure is returned as-is";
    $е.so; # Defuse the Failure

    throws-like { сe̲中갮с丧-àò-ò中с(Int) }, X::TypeCheck::Return, "can't return a type object";
    throws-like { сe̲中갮с丧-àò-ò中с([1,2]) }, X::TypeCheck::Return, "can't return a non-Numeric";

    my class À不갮ìe̲с갢개 does Numeric {
        method Str { 13 }
    }
    throws-like
        { сe̲中갮с丧-àò-ò中с(À不갮ìe̲с갢개.new) },
        X::Coerce::Impossible,
        "incorrect coercion throws too";
}

subtest "COERCE-based coercion for returns", {
    plan 5;
    my class Е갨갨 {
        has $.val;
        multi method COERCE(Num) { Е갨갨 }
        multi method COERCE($val) { self.new(:$val) }
    }

    my sub сe̲中갮с丧-àò-Е갨갨($x --> Е갨갨:D()) { $x }

    is-deeply сe̲中갮с丧-àò-Е갨갨(42), Е갨갨.new(:val(42)), "COERCE works with a concrete value";
    is-deeply сe̲中갮с丧-àò-Е갨갨(Str), Е갨갨.new(:val(Str)), "COERCE works with a type object";
    is сe̲中갮с丧-àò-Е갨갨(Nil), Nil, "Nil is returned as-is";
    isa-ok сe̲中갮с丧-àò-Е갨갨(my $е = Failure.new), Failure, "a Failure is returned as-is";
    $е.so; # Defuse the Failure

    throws-like
        { сe̲中갮с丧-àò-Е갨갨(pi) },
        X::Coerce::Impossible,
        "coercion into a typeobject fails for a definite target";
}

subtest "Coercive subset", {
    plan 5;
    # Make some definitely coercive subset!
    # my subset Bar of Str:D(Numeric) where *.chars > 3;
    my subset Bar of Str:D(Numeric) where *.chars > 3;

    my sub сe̲中갮с丧-àò-ò갮丛òe̲中($x --> Bar) { $x }

    is сe̲中갮с丧-àò-ò갮丛òe̲中(12345), "12345", "basic coercion works";
    is сe̲中갮с丧-àò-ò갮丛òe̲中(Nil), Nil, "Nil is returned as-is";
    isa-ok сe̲中갮с丧-àò-ò갮丛òe̲中(my $е = Failure.new), Failure, "a Failure is returned as-is";
    $е.so; # Defuse the Failure

    throws-like
        { сe̲中갮с丧-àò-ò갮丛òe̲中(13) },
        X::TypeCheck::Return,
        "can't return a coercion of value not passing subset constraint";

    throws-like
        { quietly сe̲中갮с丧-àò-ò갮丛òe̲中(Int) },
        X::TypeCheck::Return,
        "can't return a coercion of a typeobject for a definite subset";
}

subtest "Coerce into a subset", {
    plan 5;
    my subset SmallVal of Rat where { .abs < 0.5 };

    my sub сe̲中갮с丧-àò-ò갮丛òe̲中($x --> SmallVal:D()) { $x }

    is сe̲中갮с丧-àò-ò갮丛òe̲中("0.2"), 0.2, "basic coercion works";
    is сe̲中갮с丧-àò-ò갮丛òe̲中(Nil), Nil, "Nil is returned as-is";
    isa-ok сe̲中갮с丧-àò-ò갮丛òe̲中(my $е = Failure.new), Failure, "a Failure is returned as-is";
    $е.so; # Defuse the Failure

    throws-like
        { сe̲中갮с丧-àò-ò갮丛òe̲中("1.3") },
        X::Coerce::Impossible,
        "can't return a coercion of value not passing subset constraint";

    throws-like
        { сe̲中갮с丧-àò-ò갮丛òe̲中(1.3) },
        X::Coerce::Impossible,
        "can't return a value not passing subset constraint";
}

subtest "Errors", {
    plan 2;

    my class 不àò中ù갂갨e̲с개e̲с {
        multi method COERCE(Str) { ::?CLASS }
    }

    my sub сe̲中갮с丧-àò-𝐝e̲е갢丧갢中e̲($x --> 不àò中ù갂갨e̲с개e̲с:D()) { $x }

    throws-like
        { сe̲中갮с丧-àò-𝐝e̲е갢丧갢中e̲("foo"); },
        X::Coerce::Impossible,
        "class coercer doesn't give us a definite";

    throws-like
        { сe̲中갮с丧-àò-𝐝e̲е갢丧갢中e̲(13); },
        X::Coerce::Impossible,
        "class coercer doesn't provide a coercion method";
}

done-testing;
