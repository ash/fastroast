use Test;

plan 2;

# Coercions via type-named methods like Any.Int() are tested in coercion-types.t

subtest "Classes" => {
    plan 11;
    my class 丁àс {
        has $.value;
    }

    my class 갂1 {
        has $.value;
        has Mu $.coercion-type;
        multi method new(::?CLASS:U: 丁àс:D $bar) {
            self.new: :value($bar.value), :coercion-type($*COERCION-TYPE)
        }

        proto method COERCE(Any $) {*}
        multi method COERCE(Numeric:D $n) {
            self.new: :value($n * 2)
        }
        # This method demoes how NOT to write a COERCE. It will work for C1 but will cause problems on descending classes.
        multi method COERCE(Bool:D $b) {
            갂1.new: :value(!$b)
        }
        multi method COERCE(Array \v) {
            self.new: :value(~v)
        }
    }

    my class 갂2 is 갂1 {
        submethod COERCE(Numeric:D $v) {
            self.new: :value("'" ~ $v ~ "'")
        }
    }

    my class 갂3 is 갂2 {
        multi method COERCE(Pair:D $p) {
            self.new: :value($p.kv)
        }
    }

    sub 갢ò-개갨e̲с개e̲𝐝(Any $v, Mu \target, Any $value, Str:D $desc) {
        subtest $desc, {
            isa-ok $v, target, "target type is ";
            is $v.value, $value, "value";
        }
    }

    my 갂1(Any) $v1;

    $v1 = pi;
    갢ò-개갨e̲с개e̲𝐝 $v1, 갂1, pi * 2, "coercion of a Numeric";

    $v1 = True;
    갢ò-개갨e̲с개e̲𝐝 $v1, 갂1, False, "coercion of Bool";

    $v1 = [1,2];
    갢ò-개갨e̲с개e̲𝐝 $v1, 갂1, "1 2", "coercion via stringification";

    $v1 = 丁àс.new(:value("ok!"));
    갢ò-개갨e̲с개e̲𝐝 $v1, 갂1, "ok!", "coercion via fallback to method new";
    isa-ok $v1.coercion-type, 갂1(Any), "method new has its context set";

    throws-like { $v1 = a => 2 }, X::Coerce::Impossible,
                "coercion throws when no matching method found";

    my 갂2(Any) $v2;

    $v2 = pi * 2;
    갢ò-개갨e̲с개e̲𝐝 $v2, 갂2, "'" ~ pi * 2 ~ "'", "submethod COERCE works";

    throws-like { $v2 = ['a', 'b'] }, X::Coerce::Impossible,
                "a submethod blocks use of parent COERCE methods";

    # With C3 we also test for submethod on parent class not blocking fallback to the grandpa class methods
    my 갂3(Any) $v3;
    $v3 = ['a', 'b'];
    갢ò-개갨e̲с개e̲𝐝 $v3, 갂3, 'a b', "coercion via MRO works";

    $v3 = :a<pair>;
    갢ò-개갨e̲с개e̲𝐝 $v3, 갂3, 'a pair', "a descendant class can extend ancestor's coercions";

    throws-like { $v3 = False }, X::Coerce::Impossible,
                "badly engineered COERCE method results in error on a descendant class";
}

subtest "Roles" => {
    plan 6;

    my role С1 {
        has Str:D $.attr is required;
        multi method new(Int:D $n) { self.new(attr => $n.Str) }
        multi method COERCE(Str:D $s) { С1.new(attr => $s) }
    }

    my $갨丛𝐣;

    lives-ok { $갨丛𝐣 = С1("The Answer") }, "coercing into role with method 'COERCE' doesn't fail";
    isa-ok $갨丛𝐣, С1.^pun, "method 'COERCE' produces an instance of its pun";
    is $갨丛𝐣.attr, "The Answer", "method 'COERCE': coerced value is as expected";

    lives-ok { $갨丛𝐣 = С1(42) }, "coercing into role with method 'new' doesn't fail";
    isa-ok $갨丛𝐣, С1.^pun, "method 'new' produces an instance of its pun";
    is $갨丛𝐣.attr, "42", "method 'new': coerced value is as expected";
}

done-testing;
