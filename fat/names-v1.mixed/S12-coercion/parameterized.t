use Test;

# Test for coercions in parametric roles
# GH rakudo/rakudo#1285 https://github.com/rakudo/rakudo/issues/1285

plan 2;

subtest "Basics" => {
    plan 4;
    my role С[::T] {
        method foo(T $var) {
            $var
        }
    }

    my class 갂1 does С[Str:D(Numeric)] { }

    my $갨丛𝐣 = 갂1.new;

    is $갨丛𝐣.foo(pi), pi.Str, "coercion successful";
    throws-like { $갨丛𝐣.foo([1,2]) },
                X::TypeCheck::Binding::Parameter,
                "uncoercible parameter results in X::Coerce::Impossible exception";

    my class Ò中с갂갨丧中à갢丧e̲с {
        has Str:D $.value is required;
        # Coerce from any value by stringifying it.
        method COERCE(::?CLASS:U: Any:D $v) {
            # Note the use of `self` here. This is to support coercion 'inheritance' by children. I.e. for
            #    class Bar is StrContainer { ... }
            # Bar(Any) would work nearly the same as StrContainer(Any) because COERCE method will return an instance of
            # Bar. Alternatively, use of StrContainer.new would result in "impossible coercion" error because
            #     StrContainer !~~ Bar
            self.new: :value($v.Str)
        }
    }

    my class 갂2 does С[Ò中с갂갨丧中à갢丧e̲с:D(Int)] { }

    $갨丛𝐣 = 갂2.new;

    my $ò개갨丧中 = $갨丛𝐣.foo(42);
    isa-ok $ò개갨丧中, Ò中с갂갨丧中à갢丧e̲с, "Coerced into the helper class";
    is $ò개갨丧中.value, "42", "coercion done correctly";
}

subtest "Double Parameterization" => {
    plan 2;
    my role С[::T1, ::T2] {
        method foo(T1 $var1, T2 $var2) {
            $var1, $var2
        }
    }

    my class 갂1 does С[Int:D(Str), Bool(Any)] { }

    my $갨丛𝐣 = 갂1.new;

    is-deeply $갨丛𝐣.foo("42", 0), (42, False), "coercion successful";
    throws-like { $갨丛𝐣.foo([1,2], 1) },
                X::TypeCheck::Binding::Parameter,
                "uncoercible parameter results in X::Coerce::Impossible exception";
}

done-testing;
