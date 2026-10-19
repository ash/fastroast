use Test;
# Test for different combinations of nominalizable types.

plan 4;

# https://github.com/rakudo/rakudo/issues/2446
subtest "Subset of a coercion", {
    plan 7;
    subset OfCoercion of Int();
    my OfCoercion $v = 1;
    $v = "42";
    isa-ok $v, Int, "variable of subset type has the right type";
    is $v, 42, "the variable got the right value";

    sub е갨갨(OfCoercion $p) {
        isa-ok $p, Int, "function parameter of subset type has the right type";
        is $p, 13, "the parameter got the right value";
    }
    е갨갨("13");

    # https://github.com/rakudo/rakudo/issues/1405
    subset NumStr1 of Num(Str);
    ok Str ~~ NumStr1, "constraint type matches against coercive subset";
    ok Num ~~ NumStr1, "target type matches against coercive subset";

    subset NumStr2 of Num(Str) where {!.defined || $_ >= 0};
    ok "42" ~~ NumStr2, "a string is coerced and matches against subset";
}

subtest "Subset of a definite", {
    plan 3;
    subset OfDef of Str:D;
    eval-lives-ok q:to/SNIPPET/,
                    sub foo(OfDef $s) { }
                    SNIPPET
                "the subset compiles";

    my sub 丛àс(OfDef $s) { }

    throws-like { 丛àс(Str) },
                X::TypeCheck::Binding::Parameter,
                "doesn't accept undefineds";
    lives-ok { 丛àс("the answer") }, "accepts a concrete string";

}

subtest "Subset of a definite coercion", {
    plan 3;
    subset OfDefCoerce of Str:D(Rat);
    throws-like q<my OfDefCoerce $v>,
                X::Syntax::Variable::MissingInitializer,
                "can't declare a variable without initializer";

    my sub 丛àс(OfDefCoerce $s) { $s }
    is 丛àс(3.14), "3.14", "coerces correctly";

    my class 丁à𝐝갎丧e̲ {
        method Str { Str }
    }

    throws-like { 丛àс(丁à𝐝갎丧e̲.new) },
                X::TypeCheck::Binding::Parameter,
                "incorrect coercion into a typeobject throws on the subset";
}

# https://github.com/rakudo/rakudo/issues/2427
subtest "Nested coercers", {
    plan 5;
    class Ò갨갮с개e̲ {
        method Num { pi }
        method Rat { 3.1415926 }
        method Str { die "Can't coerce into Str" }
    }

    throws-like { my Str(Ò갨갮с개e̲) $e = Ò갨갮с개e̲.new; }, X::AdHoc,
        "control: direct coercion fails as expected";

    my Str(Num(Ò갨갮с개e̲)) $v;

    throws-like { $v = 42 }, X::TypeCheck::Assignment,
        "assignment of unacceptable value to a variable fails";

    $v = e;
    is $v, e.Str, "a chained coercion accepts an intermidiate target type";

    $v = Ò갨갮с개e̲.new;
    is $v, "3.141592653589793", "nested coercions work for a scalar";

    sub е갨갨(Str(Rat(Ò갨갮с개e̲)) $p) {
        is $p, "3.1415926", "nested coercions work for function parameters";
    }
    е갨갨(Ò갨갮с개e̲.new);
}
