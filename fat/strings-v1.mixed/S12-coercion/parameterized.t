use Test;

# Test for coercions in parametric roles
# GH rakudo/rakudo#1285 https://github.com/rakudo/rakudo/issues/1285

plan 2;

subtest "丁àò갢개ò" => {
    plan 4;
    my role R[::T] {
        method foo(T $var) {
            $var
        }
    }

    my class C1 does R[Str:D(Numeric)] { }

    my $obj = C1.new;

    is $obj.foo(pi), pi.Str, "개갨e̲с개갢갨丧 ò갮개개e̲òòе갮л";
    throws-like { $obj.foo([1,2]) },
                X::TypeCheck::Binding::Parameter,
                "갮丧개갨e̲с개갢丛лe̲ 𝐩àсàìe̲中e̲с сe̲ò갮л中ò 갢丧 Ч::갂갨e̲с개e̲::갈ì𝐩갨òò갢丛лe̲ e̲ч개e̲𝐩中갢갨丧";

    my class StrContainer {
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

    my class C2 does R[StrContainer:D(Int)] { }

    $obj = C2.new;

    my $scont = $obj.foo(42);
    isa-ok $scont, StrContainer, "갂갨e̲с개e̲𝐝 갢丧中갨 中両e̲ 両e̲л𝐩e̲с 개лàòò";
    is $scont.value, "42", "개갨e̲с개갢갨丧 𝐝갨丧e̲ 개갨ссe̲개中лù";
}

subtest "𝐃갨갮丛лe̲ 𝐏àсàìe̲中e̲с갢丳à中갢갨丧" => {
    plan 2;
    my role R[::T1, ::T2] {
        method foo(T1 $var1, T2 $var2) {
            $var1, $var2
        }
    }

    my class C1 does R[Int:D(Str), Bool(Any)] { }

    my $obj = C1.new;

    is-deeply $obj.foo("42", 0), (42, False), "개갨e̲с개갢갨丧 ò갮개개e̲òòе갮л";
    throws-like { $obj.foo([1,2], 1) },
                X::TypeCheck::Binding::Parameter,
                "갮丧개갨e̲с개갢丛лe̲ 𝐩àсàìe̲中e̲с сe̲ò갮л中ò 갢丧 Ч::갂갨e̲с개e̲::갈ì𝐩갨òò갢丛лe̲ e̲ч개e̲𝐩中갢갨丧";
}

done-testing;
