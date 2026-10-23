use Test;

plan 2;

# Coercions via type-named methods like Any.Int() are tested in coercion-types.t

subtest "갂лàòòe̲ò" => {
    plan 11;
    my class Bar {
        has $.value;
    }

    my class C1 {
        has $.value;
        has Mu $.coercion-type;
        multi method new(::?CLASS:U: Bar:D $bar) {
            self.new: :value($bar.value), :coercion-type($*COERCION-TYPE)
        }

        proto method COERCE(Any $) {*}
        multi method COERCE(Numeric:D $n) {
            self.new: :value($n * 2)
        }
        # This method demoes how NOT to write a COERCE. It will work for C1 but will cause problems on descending classes.
        multi method COERCE(Bool:D $b) {
            C1.new: :value(!$b)
        }
        multi method COERCE(Array \v) {
            self.new: :value(~v)
        }
    }

    my class C2 is C1 {
        submethod COERCE(Numeric:D $v) {
            self.new: :value("'" ~ $v ~ "'")
        }
    }

    my class C3 is C2 {
        multi method COERCE(Pair:D $p) {
            self.new: :value($p.kv)
        }
    }

    sub is-coerced(Any $v, Mu \target, Any $value, Str:D $desc) {
        subtest $desc, {
            isa-ok $v, target, "中àсæe̲中 中ù𝐩e̲ 갢ò ";
            is $v.value, $value, "value";
        }
    }

    my C1(Any) $v1;

    $v1 = pi;
    is-coerced $v1, C1, pi * 2, "개갨e̲с개갢갨丧 갨е à 不갮ìe̲с갢개";

    $v1 = True;
    is-coerced $v1, C1, False, "개갨e̲с개갢갨丧 갨е 丁갨갨л";

    $v1 = [1,2];
    is-coerced $v1, C1, "1 2", "개갨e̲с개갢갨丧 𝐯갢à ò中с갢丧æ갢е갢개à中갢갨丧";

    $v1 = Bar.new(:value("갨k̲!"));
    is-coerced $v1, C1, "갨k̲!", "개갨e̲с개갢갨丧 𝐯갢à еàлл丛à개k̲ 中갨 ìe̲中両갨𝐝 丧e̲w̲";
    isa-ok $v1.coercion-type, C1(Any), "ìe̲中両갨𝐝 丧e̲w̲ 両àò 갢中ò 개갨丧中e̲ч中 òe̲中";

    throws-like { $v1 = a => 2 }, X::Coerce::Impossible,
                "개갨e̲с개갢갨丧 中両с갨w̲ò w̲両e̲丧 丧갨 ìà中개両갢丧æ ìe̲中両갨𝐝 е갨갮丧𝐝";

    my C2(Any) $v2;

    $v2 = pi * 2;
    is-coerced $v2, C2, "'" ~ pi * 2 ~ "'", "ò갮丛ìe̲中両갨𝐝 갂갎E̲С갂E̲ w̲갨сk̲ò";

    throws-like { $v2 = ['à', '丛'] }, X::Coerce::Impossible,
                "à ò갮丛ìe̲中両갨𝐝 丛л갨개k̲ò 갮òe̲ 갨е 𝐩àсe̲丧中 갂갎E̲С갂E̲ ìe̲中両갨𝐝ò";

    # With C3 we also test for submethod on parent class not blocking fallback to the grandpa class methods
    my C3(Any) $v3;
    $v3 = ['à', '丛'];
    is-coerced $v3, C3, 'à 丛', "개갨e̲с개갢갨丧 𝐯갢à ÌС갎 w̲갨сk̲ò";

    $v3 = :a<𝐩à갢с>;
    is-coerced $v3, C3, 'à 𝐩à갢с', "à 𝐝e̲ò개e̲丧𝐝à丧中 개лàòò 개à丧 e̲ч中e̲丧𝐝 à丧개e̲ò中갨с'ò 개갨e̲с개갢갨丧ò";

    throws-like { $v3 = False }, X::Coerce::Impossible,
                "丛à𝐝лù e̲丧æ갢丧e̲e̲сe̲𝐝 갂갎E̲С갂E̲ ìe̲中両갨𝐝 сe̲ò갮л中ò 갢丧 e̲сс갨с 갨丧 à 𝐝e̲ò개e̲丧𝐝à丧中 개лàòò";
}

subtest "С갨лe̲ò" => {
    plan 6;

    my role R1 {
        has Str:D $.attr is required;
        multi method new(Int:D $n) { self.new(attr => $n.Str) }
        multi method COERCE(Str:D $s) { R1.new(attr => $s) }
    }

    my $obj;

    lives-ok { $obj = R1("专両e̲ À丧òw̲e̲с") }, "개갨e̲с개갢丧æ 갢丧中갨 с갨лe̲ w̲갢中両 ìe̲中両갨𝐝 '갂갎E̲С갂E̲' 𝐝갨e̲ò丧'中 еà갢л";
    isa-ok $obj, R1.^pun, "ìe̲中両갨𝐝 '갂갎E̲С갂E̲' 𝐩с갨𝐝갮개e̲ò à丧 갢丧ò中à丧개e̲ 갨е 갢中ò 𝐩갮丧";
    is $obj.attr, "专両e̲ À丧òw̲e̲с", "ìe̲中両갨𝐝 '갂갎E̲С갂E̲': 개갨e̲с개e̲𝐝 𝐯àл갮e̲ 갢ò àò e̲ч𝐩e̲개中e̲𝐝";

    lives-ok { $obj = R1(42) }, "개갨e̲с개갢丧æ 갢丧中갨 с갨лe̲ w̲갢中両 ìe̲中両갨𝐝 '丧e̲w̲' 𝐝갨e̲ò丧'中 еà갢л";
    isa-ok $obj, R1.^pun, "ìe̲中両갨𝐝 '丧e̲w̲' 𝐩с갨𝐝갮개e̲ò à丧 갢丧ò中à丧개e̲ 갨е 갢中ò 𝐩갮丧";
    is $obj.attr, "42", "ìe̲中両갨𝐝 '丧e̲w̲': 개갨e̲с개e̲𝐝 𝐯àл갮e̲ 갢ò àò e̲ч𝐩e̲개中e̲𝐝";
}

done-testing;
