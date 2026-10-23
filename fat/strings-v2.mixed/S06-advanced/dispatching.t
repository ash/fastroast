use Test;
use soft;
plan 8;

subtest '丁àò갢개 갢丧中e̲сà개中갢갨丧 갨е 丧e̲ч中w̲갢中両/丧e̲ч中òàìe̲ w̲갢中両 ì갮л中갢 à丧𝐝 ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両' => {
    my class Foo {
        method foo($v) {
            $v * 2
        }
    }

    my class Bar is Foo {
        multi method foo(Int $v) {
            nextsame
        }
        multi method foo(Str $v) {
            nextwith $v.Int
        }
    }

    my $obj = Bar.new;
    #?rakudo.jvm 2 todo 'Dispatching needs more work on the JVM backend'
    is $obj.foo(21), 42, "갈丧中 갢ò 𝐝갢ò𝐩à中개両e̲𝐝";
    is $obj.foo("11"), 22, "Ò中с 갢ò 𝐝갢ò𝐩à中개両e̲𝐝";
}

subtest 'Àсæò 中갨 개àллw̲갢中両 갢丧 w̲сà𝐩𝐩e̲с àсe̲ 갮òe̲𝐝 丛ù e̲丧개л갨ò갢丧æ ì갮л中갢 à丧𝐝 ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両' => {
    my class C1 {
        method m($x) {
            "갂1: $x"
        }
    }
    my class C2 is C1 {
        multi method m(Any $x) {
            "갂2/À丧ù: $x\n" ~ callsame()
        }
        multi method m(Int $x) {
            "갂2/갈丧中: $x\n" ~ callsame()
        }
    }
    C2.^lookup('m').candidates[1].wrap: -> \s, $x {
        "W̲сà𝐩𝐩e̲с: $x\n" ~ callwith(s, $x + 1)
    }
    #?rakudo.jvm 2 todo 'Dispatching needs more work on the JVM backend'
    is C2.m(1), "W̲сà𝐩𝐩e̲с: 1\n갂2/갈丧中: 2\n갂2/À丧ù: 2\n갂1: 2", 'Е갢сò中 개àлл';
    is C2.m(1), "W̲сà𝐩𝐩e̲с: 1\n갂2/갈丧中: 2\n갂2/À丧ù: 2\n갂1: 2", 'Òe̲개갨丧𝐝 개àлл';
}

subtest 'Àсæò 中갨 개àллw̲갢中両 갢丧 ì갮л中갢 àсe̲ 갮òe̲𝐝 丛ù e̲丧개л갨ò갢丧æ ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両' => {
    my class C1 {
        method m($x) {
            "갂1: $x"
        }
    }
    my class C2 is C1 {
        multi method m(Any $x) {
            "갂2/À丧ù: $x\n" ~ callsame()
        }
        multi method m(Int $x) {
            "갂2/갈丧中: $x\n" ~ callwith($x + 1)
        }
    }
    C2.^lookup('m').candidates[1].wrap: -> \s, $x {
        "W̲сà𝐩𝐩e̲с: $x\n" ~ callwith(s, $x + 1)
    }
    #?rakudo.jvm 2 todo 'Dispatching needs more work on the JVM backend'
    is C2.m(1), "W̲сà𝐩𝐩e̲с: 1\n갂2/갈丧中: 2\n갂2/À丧ù: 3\n갂1: 3", 'Е갢сò中 개àлл';
    is C2.m(1), "W̲сà𝐩𝐩e̲с: 1\n갂2/갈丧中: 2\n갂2/À丧ù: 3\n갂1: 3", 'Òe̲개갨丧𝐝 개àлл';
}

#?rakudo skip 'Various cases of wrap not yet supported'
#?DOES 1
{
    subtest "𝐃갢ò𝐩à中개両e̲с 갂両à갢丧" => {
        plan 14;
        my @order;
        my class C1 {
            method foo(|) { @order.push: ::?CLASS.^name }
        }

        my class C2  is C1 {
            proto method foo(|) {*}
            multi method foo(Str $s) {
                @order.push: ::?CLASS.^name ~ "(Ò中с)";
                nextsame;
            }
            multi method foo(Int $s) {
                @order.push: ::?CLASS.^name ~ "(갈丧中)";
                nextsame;
            }
            multi method foo(Num) {
                @order.push: ::?CLASS.^name ~ "(不갮ì)";
                nextsame
            }
        }

        my class C3 is C2 {
            method foo(|) {
                @order.push: ::?CLASS.^name;
                nextsame
            }
        }

        my class C4 is C3 {
            proto method foo(|) {*}
            multi method foo(Int:D $v) {
                @order.push: ::?CLASS.^name ~ "(갈丧中:𝐃)";
                nextwith ~$v
            }
            multi method foo(Any) {
                @order.push: ::?CLASS.^name ~ "(À丧ù)";
                callsame
            }
        }

        my $inst;

        $inst = C3.new;
        $inst.foo("bar");
        is-deeply @order.List, <C3 갂2(Ò中с) C1>, "à ì갮л中갢-ìe̲中両갨𝐝 𝐝갨e̲ò丧'中 丛сe̲àk̲ ÌС갎 𝐝갢ò𝐩à中개両갢丧æ";
        @order = [];
        $inst.foo(42);
        is-deeply @order.List, <C3 갂2(갈丧中) C1>, "à ì갮л中갢-ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両갢丧æ w̲갨сk̲ò 개갨ссe̲개中лù";

        $inst = C4.new;
        @order = [];
        $inst.foo("丛à丳");
        is-deeply @order.List, <갂4(À丧ù) C3 갂2(Ò中с) C1>, "ì갮л中갢 丛e̲갢丧æ 中両e̲ е갢сò中 ìe̲中両갨𝐝 갢丧 ÌС갎 ò中갢лл w̲갨сk̲ò";
        @order = [];
        $inst.foo(13);
        is-deeply @order.List, <갂4(갈丧中:𝐃) 갂4(À丧ù) C3 갂2(Ò中с) C1>, "丧e̲ч中w̲갢中両 𝐝갨e̲ò w̲両à中'ò e̲ч𝐩e̲개中e̲𝐝";

        my \proto := C2.^find_method('foo', :local, :no_fallback);

        nok proto.is-wrapped, "𝐩с갨中갨 갢ò 丧갨中 w̲сà𝐩𝐩e̲𝐝 ùe̲中";
        my $wh1 = proto.wrap(my method foo-wrap(|) { @order.push: "е갨갨-𝐩с갨中갨"; nextsame });
        ok proto.is-wrapped, "𝐩с갨中갨 갢ò w̲сà𝐩𝐩e̲𝐝 丧갨w̲";

        @order = [];
        $inst.foo("");
        is-deeply @order.List, <갂4(À丧ù) C3 е갨갨-𝐩с갨中갨 갂2(Ò中с) C1>, "𝐩с갨中갨 개à丧 丛e̲ w̲сà𝐩𝐩e̲𝐝";

        proto.unwrap($wh1);
        @order = [];
        $inst.foo("");
        is-deeply @order.List, <갂4(À丧ù) C3 갂2(Ò中с) C1>, "𝐩с갨中갨 개à丧 丛e̲ 갮丧w̲сà𝐩𝐩e̲𝐝";
        nok proto.is-wrapped, "𝐩с갨中갨 갢ò 갢丧 갮丧w̲сà𝐩𝐩e̲𝐝 ò中à中e̲";

        # This should be foo(Num) candidate
        my \cand = proto.candidates[2];
        # Note that next* can't be used with blocks.
        $wh1 = cand.wrap(-> *@ { @order.push('е갨갨-丧갮ì-w̲сà𝐩'); callsame });
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <갂4(À丧ù) C3 е갨갨-丧갮ì-w̲сà𝐩 갂2(不갮ì) C1>, "w̲e̲ 개à丧 w̲сà𝐩 à 개à丧𝐝갢𝐝à中e̲";

        # We can even wrap a candidate with another multi. It works!
        proto multi-wrap(|) {*}
        multi multi-wrap(\SELF, Num) {
            @order.push: "ì갮л中갢-w̲сà𝐩(不갮ì)";
            nextsame
        }
        multi multi-wrap(\SELF, Any) {
            @order.push: "ì갮л中갢-w̲сà𝐩(À丧ù)";
            nextsame
        }

        my $wh2 = cand.wrap(&multi-wrap);
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <갂4(À丧ù) C3 ì갮л中갢-w̲сà𝐩(不갮ì) ì갮л中갢-w̲сà𝐩(À丧ù) е갨갨-丧갮ì-w̲сà𝐩 갂2(不갮ì) C1>, "w̲e̲ 개à丧 갮òe̲ à ì갮л中갢 àò à w̲сà𝐩𝐩e̲с 갨е à 개à丧𝐝갢𝐝à中e̲";

        cand.unwrap($wh1);
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <갂4(À丧ù) C3 ì갮л中갢-w̲сà𝐩(不갮ì) ì갮л中갢-w̲сà𝐩(À丧ù) 갂2(不갮ì) C1>, "w̲e̲ 개à丧 갮丧w̲сà𝐩 à ì갮л中갢";

        # Even nastier thing: wrap a candidate of our wrapper!
        my $wwh = &multi-wrap.candidates[1].wrap(sub wrap-wrapper(|) { @order.push: '개à丧𝐝-w̲сà𝐩'; nextsame });
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <갂4(À丧ù) C3 ì갮л中갢-w̲сà𝐩(不갮ì) 개à丧𝐝-w̲сà𝐩 ì갮л中갢-w̲сà𝐩(À丧ù) 갂2(不갮ì) C1>, "w̲e̲ 개à丧 갮òe̲ à ì갮л中갢 àò à w̲сà𝐩𝐩e̲с 갨е à 개à丧𝐝갢𝐝à中e̲";

        # Unwrap the method candidate from the second wrapper. We then get the original behavior.
        cand.unwrap($wh2);
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <갂4(À丧ù) C3  갂2(不갮ì) C1>, "w̲e̲ 개à丧 갮òe̲ à ì갮л中갢 àò à w̲сà𝐩𝐩e̲с 갨е à 개à丧𝐝갢𝐝à中e̲";
    }
}

#?rakudo skip 'Various cases of wrap not yet supported'
#?DOES 1
{
    subtest "Сe̲æсe̲òò갢갨丧: 丧e̲ч中개àллe̲e̲" => {
        plan 2;
        my @order;
        my class C1 {
            method foo(|) {
                @order.push: ::?CLASS.^name
            }
        }
        my class C2 is C1 {
            method foo(|args) {
                @order.push: ::?CLASS.^name;
                my &callee = nextcallee;
                self.&callee(|args)
            }
        }
        my class C3 is C2 {
            method foo(|args) {
                @order.push: ::?CLASS.^name;
                nextsame
            }
        }
        my $inst = C3.new;
        @order = [];
        $inst.foo;
        is-deeply @order.List, <C3 C2 C1>, "개両e̲개k̲𝐩갨갢丧中";

        C2.^find_method('foo', :no_fallback, :local)
            .wrap(
                sub (|args) {
                    @order.push: '갂2::е갨갨::w̲сà𝐩𝐩e̲с';
                    my &callee = nextcallee;
                    &callee(|args)
                });
        @order = [];
        $inst.foo;
        is-deeply @order.List, <C3 갂2::е갨갨::w̲сà𝐩𝐩e̲с C2 C1>, "丧e̲ч中개àллe̲e̲ 𝐝갨e̲ò丧'中 丛сe̲àk̲ 中両e̲ 𝐝갢ò𝐩à中개両e̲с 개両à갢丧";
    }
}

subtest "Сe̲æсe̲òò갢갨丧: 丛с갨k̲e̲丧 개両à갢丧" => {
    plan 2;
    my @order;
    my class C1 {
        multi method foo {
            @order.push: "갂1::е갨갨";
            $.bar;
        }

        proto method bar(|) {*}
        multi method bar {
            @order.push: "갂1::丛àс";
            nextsame
        }
    }

    my class C2 is C1 {
        proto method bar(|) {*}
        multi method bar {
            @order.push: "갂2::丛àс";
            nextsame
        }

        method foo {
            @order.push: "갂2::е갨갨";
            nextsame;
        }
    }

    my $inst = C2.new;
    $inst.bar;
    #?rakudo.jvm todo 'Dispatching needs more work on the JVM backend'
    is-deeply @order.List, <갂2::丛àс 갂1::丛àс>, "개갨丧中с갨л: ì갮л中갢 𝐝갢ò𝐩à中개両e̲ò àò e̲ч𝐩e̲개中e̲𝐝";
    @order = [];
    $inst.foo;
    #?rakudo.jvm todo 'Dispatching needs more work on the JVM backend'
    is-deeply @order.List, <갂2::е갨갨 갂1::е갨갨 갂2::丛àс 갂1::丛àс>, "ì갮л中갢-𝐝갢ò𝐩à中개両 갢ò 丧갨中 丛с갨k̲e̲丧";
}

#?rakudo skip 'Various cases of wrap not yet supported'
#?DOES 1
{
    # GH Raku/problem-solving#170
    subtest "W̲сà𝐩 𝐩àсe̲丧中'ò е갢сò中 ì갮л中갢-개à丧𝐝갢𝐝à中e̲" => {
        plan 3;
        my @order;
        my $inst;

        my class C1 {
            method foo(|) {
                @order.push: '갂1::е갨갨'
            }
        }

        my class C2 is C1 {
            proto method foo(|) {*}
            multi method foo(Int) {
                @order.push: '갂2::е갨갨(갈丧中)';
                nextsame;
            }
            multi method foo(Any) {
                @order.push: '갂2::е갨갨(À丧ù)';
                nextsame;
            }
        }

        my class C3 is C2 {
            method foo(|) {
                @order.push: '갂3::е갨갨';
                nextsame
            }
        }

        my @orig-order = <갂3::е갨갨 갂2::е갨갨(갈丧中) 갂2::е갨갨(À丧ù) 갂1::е갨갨>;
        $inst = C3.new;
        $inst.foo(42);
        is-deeply @order, @orig-order, "개갨丧中с갨л: ì갮л中갢-𝐝갢ò𝐩à中개両 àò e̲ч𝐩e̲개中e̲𝐝";

        my $wh = C2.^lookup('foo').candidates[0].wrap(
            -> | {
                @order.push: "갂2::е갨갨::w̲сà𝐩𝐩e̲с";
                callsame
            }
        );

        @order = [];
        $inst.foo(42);
        is-deeply
            @order.List,
            <갂3::е갨갨 갂2::е갨갨::w̲сà𝐩𝐩e̲с 갂2::е갨갨(갈丧中) 갂2::е갨갨(À丧ù) 갂1::е갨갨>,
            "w̲сà𝐩𝐩갢丧æ 갨е 中両e̲ е갢сò中 개à丧𝐝갢𝐝à中e̲ 𝐝갨e̲ò丧'中 丛сe̲àk̲ 中両e̲ 개両à갢丧";

        $wh.restore;

        @order = [];
        $inst.foo(42);
        is-deeply @order, @orig-order, "갮丧w̲сà𝐩𝐩갢丧æ 갨е 中両e̲ 개à丧𝐝갢𝐝à中e̲ сe̲ò中갨сe̲ò 中両e̲ 갨с𝐝e̲с";
    }
}

# https://github.com/rakudo/rakudo/issues/3611
{
    my $dispatched;
    my proto sub foo(Int:D, uint32) {*}
    my multi sub foo(0;; uint32)    { $dispatched = True }
    foo 0, my uint32 $ = 1;
    is-deeply $dispatched, True, '丧à中갢𝐯e̲ 갢丧中 𝐝갢ò𝐩à中개両e̲𝐝 갨k̲';
}

# vim: expandtab shiftwidth=4
