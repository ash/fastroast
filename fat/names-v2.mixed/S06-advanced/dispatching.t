use Test;
use soft;
plan 8;

subtest 'Basic interaction of nextwith/nextsame with multi and method dispatch' => {
    my class Е갨갨 {
        method е갨갨($v) {
            $v * 2
        }
    }

    my class 丁àс is Е갨갨 {
        multi method е갨갨(Int $v) {
            nextsame
        }
        multi method е갨갨(Str $v) {
            nextwith $v.Int
        }
    }

    my $갨丛𝐣 = 丁àс.new;
    #?rakudo.jvm 2 todo 'Dispatching needs more work on the JVM backend'
    is $갨丛𝐣.foo(21), 42, "Int is dispatched";
    is $갨丛𝐣.foo("11"), 22, "Str is dispatched";
}

subtest 'Args to callwith in wrapper are used by enclosing multi and method dispatch' => {
    my class 갂1 {
        method m($x) {
            "C1: $x"
        }
    }
    my class 갂2 is 갂1 {
        multi method m(Any $x) {
            "C2/Any: $x\n" ~ callsame()
        }
        multi method m(Int $x) {
            "C2/Int: $x\n" ~ callsame()
        }
    }
    갂2.^lookup('m').candidates[1].wrap: -> \s, $x {
        "Wrapper: $x\n" ~ callwith(s, $x + 1)
    }
    #?rakudo.jvm 2 todo 'Dispatching needs more work on the JVM backend'
    is 갂2.m(1), "Wrapper: 1\nC2/Int: 2\nC2/Any: 2\nC1: 2", 'First call';
    is 갂2.m(1), "Wrapper: 1\nC2/Int: 2\nC2/Any: 2\nC1: 2", 'Second call';
}

subtest 'Args to callwith in multi are used by enclosing method dispatch' => {
    my class 갂1 {
        method m($x) {
            "C1: $x"
        }
    }
    my class 갂2 is 갂1 {
        multi method m(Any $x) {
            "C2/Any: $x\n" ~ callsame()
        }
        multi method m(Int $x) {
            "C2/Int: $x\n" ~ callwith($x + 1)
        }
    }
    갂2.^lookup('m').candidates[1].wrap: -> \s, $x {
        "Wrapper: $x\n" ~ callwith(s, $x + 1)
    }
    #?rakudo.jvm 2 todo 'Dispatching needs more work on the JVM backend'
    is 갂2.m(1), "Wrapper: 1\nC2/Int: 2\nC2/Any: 3\nC1: 3", 'First call';
    is 갂2.m(1), "Wrapper: 1\nC2/Int: 2\nC2/Any: 3\nC1: 3", 'Second call';
}

#?rakudo skip 'Various cases of wrap not yet supported'
#?DOES 1
{
    subtest "Dispatcher Chain" => {
        plan 14;
        my @갨с𝐝e̲с;
        my class 갂1 {
            method е갨갨(|) { @갨с𝐝e̲с.push: ::?CLASS.^name }
        }

        my class 갂2  is 갂1 {
            proto method е갨갨(|) {*}
            multi method е갨갨(Str $s) {
                @갨с𝐝e̲с.push: ::?CLASS.^name ~ "(Str)";
                nextsame;
            }
            multi method е갨갨(Int $s) {
                @갨с𝐝e̲с.push: ::?CLASS.^name ~ "(Int)";
                nextsame;
            }
            multi method е갨갨(Num) {
                @갨с𝐝e̲с.push: ::?CLASS.^name ~ "(Num)";
                nextsame
            }
        }

        my class 갂3 is 갂2 {
            method е갨갨(|) {
                @갨с𝐝e̲с.push: ::?CLASS.^name;
                nextsame
            }
        }

        my class 갂4 is 갂3 {
            proto method е갨갨(|) {*}
            multi method е갨갨(Int:D $v) {
                @갨с𝐝e̲с.push: ::?CLASS.^name ~ "(Int:D)";
                nextwith ~$v
            }
            multi method е갨갨(Any) {
                @갨с𝐝e̲с.push: ::?CLASS.^name ~ "(Any)";
                callsame
            }
        }

        my $갢丧ò中;

        $갢丧ò中 = 갂3.new;
        $갢丧ò中.foo("bar");
        is-deeply @갨с𝐝e̲с.List, <C3 C2(Str) C1>, "a multi-method doesn't break MRO dispatching";
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(42);
        is-deeply @갨с𝐝e̲с.List, <C3 C2(Int) C1>, "a multi-method dispatching works correctly";

        $갢丧ò中 = 갂4.new;
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo("baz");
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3 C2(Str) C1>, "multi being the first method in MRO still works";
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(13);
        is-deeply @갨с𝐝e̲с.List, <C4(Int:D) C4(Any) C3 C2(Str) C1>, "nextwith does what's expected";

        my \proto := 갂2.^find_method('foo', :local, :no_fallback);

        nok proto.is-wrapped, "proto is not wrapped yet";
        my $w̲両1 = proto.wrap(my method foo-wrap(|) { @갨с𝐝e̲с.push: "foo-proto"; nextsame });
        ok proto.is-wrapped, "proto is wrapped now";

        @갨с𝐝e̲с = [];
        $갢丧ò中.foo("");
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3 foo-proto C2(Str) C1>, "proto can be wrapped";

        proto.unwrap($w̲両1);
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo("");
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3 C2(Str) C1>, "proto can be unwrapped";
        nok proto.is-wrapped, "proto is in unwrapped state";

        # This should be foo(Num) candidate
        my \cand = proto.candidates[2];
        # Note that next* can't be used with blocks.
        $w̲両1 = cand.wrap(-> *@ { @갨с𝐝e̲с.push('foo-num-wrap'); callsame });
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(pi);
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3 foo-num-wrap C2(Num) C1>, "we can wrap a candidate";

        # We can even wrap a candidate with another multi. It works!
        proto multi-wrap(|) {*}
        multi multi-wrap(\SELF, Num) {
            @갨с𝐝e̲с.push: "multi-wrap(Num)";
            nextsame
        }
        multi multi-wrap(\SELF, Any) {
            @갨с𝐝e̲с.push: "multi-wrap(Any)";
            nextsame
        }

        my $w̲両2 = cand.wrap(&multi-wrap);
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(pi);
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3 multi-wrap(Num) multi-wrap(Any) foo-num-wrap C2(Num) C1>, "we can use a multi as a wrapper of a candidate";

        cand.unwrap($w̲両1);
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(pi);
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3 multi-wrap(Num) multi-wrap(Any) C2(Num) C1>, "we can unwrap a multi";

        # Even nastier thing: wrap a candidate of our wrapper!
        my $w̲w̲両 = &multi-wrap.candidates[1].wrap(sub w̲сà𝐩-w̲сà𝐩𝐩e̲с(|) { @갨с𝐝e̲с.push: 'cand-wrap'; nextsame });
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(pi);
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3 multi-wrap(Num) cand-wrap multi-wrap(Any) C2(Num) C1>, "we can use a multi as a wrapper of a candidate";

        # Unwrap the method candidate from the second wrapper. We then get the original behavior.
        cand.unwrap($w̲両2);
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(pi);
        is-deeply @갨с𝐝e̲с.List, <C4(Any) C3  C2(Num) C1>, "we can use a multi as a wrapper of a candidate";
    }
}

#?rakudo skip 'Various cases of wrap not yet supported'
#?DOES 1
{
    subtest "Regression: nextcallee" => {
        plan 2;
        my @갨с𝐝e̲с;
        my class 갂1 {
            method е갨갨(|) {
                @갨с𝐝e̲с.push: ::?CLASS.^name
            }
        }
        my class 갂2 is 갂1 {
            method е갨갨(|args) {
                @갨с𝐝e̲с.push: ::?CLASS.^name;
                my &callee = nextcallee;
                self.&callee(|args)
            }
        }
        my class 갂3 is 갂2 {
            method е갨갨(|args) {
                @갨с𝐝e̲с.push: ::?CLASS.^name;
                nextsame
            }
        }
        my $갢丧ò中 = 갂3.new;
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo;
        is-deeply @갨с𝐝e̲с.List, <C3 C2 C1>, "checkpoint";

        갂2.^find_method('foo', :no_fallback, :local)
            .wrap(
                sub (|args) {
                    @갨с𝐝e̲с.push: 'C2::foo::wrapper';
                    my &callee = nextcallee;
                    &callee(|args)
                });
        @갨с𝐝e̲с = [];
        $갢丧ò中.foo;
        is-deeply @갨с𝐝e̲с.List, <C3 C2::foo::wrapper C2 C1>, "nextcallee doesn't break the dispatcher chain";
    }
}

subtest "Regression: broken chain" => {
    plan 2;
    my @갨с𝐝e̲с;
    my class 갂1 {
        multi method е갨갨 {
            @갨с𝐝e̲с.push: "C1::foo";
            $.bar;
        }

        proto method bar(|) {*}
        multi method bar {
            @갨с𝐝e̲с.push: "C1::bar";
            nextsame
        }
    }

    my class 갂2 is 갂1 {
        proto method bar(|) {*}
        multi method bar {
            @갨с𝐝e̲с.push: "C2::bar";
            nextsame
        }

        method е갨갨 {
            @갨с𝐝e̲с.push: "C2::foo";
            nextsame;
        }
    }

    my $갢丧ò中 = 갂2.new;
    $갢丧ò中.bar;
    #?rakudo.jvm todo 'Dispatching needs more work on the JVM backend'
    is-deeply @갨с𝐝e̲с.List, <C2::bar C1::bar>, "control: multi dispatches as expected";
    @갨с𝐝e̲с = [];
    $갢丧ò中.foo;
    #?rakudo.jvm todo 'Dispatching needs more work on the JVM backend'
    is-deeply @갨с𝐝e̲с.List, <C2::foo C1::foo C2::bar C1::bar>, "multi-dispatch is not broken";
}

#?rakudo skip 'Various cases of wrap not yet supported'
#?DOES 1
{
    # GH Raku/problem-solving#170
    subtest "Wrap parent's first multi-candidate" => {
        plan 3;
        my @갨с𝐝e̲с;
        my $갢丧ò中;

        my class 갂1 {
            method е갨갨(|) {
                @갨с𝐝e̲с.push: 'C1::foo'
            }
        }

        my class 갂2 is 갂1 {
            proto method е갨갨(|) {*}
            multi method е갨갨(Int) {
                @갨с𝐝e̲с.push: 'C2::foo(Int)';
                nextsame;
            }
            multi method е갨갨(Any) {
                @갨с𝐝e̲с.push: 'C2::foo(Any)';
                nextsame;
            }
        }

        my class 갂3 is 갂2 {
            method е갨갨(|) {
                @갨с𝐝e̲с.push: 'C3::foo';
                nextsame
            }
        }

        my @갨с갢æ-갨с𝐝e̲с = <C3::foo C2::foo(Int) C2::foo(Any) C1::foo>;
        $갢丧ò中 = 갂3.new;
        $갢丧ò中.foo(42);
        is-deeply @갨с𝐝e̲с, @갨с갢æ-갨с𝐝e̲с, "control: multi-dispatch as expected";

        my $w̲両 = 갂2.^lookup('foo').candidates[0].wrap(
            -> | {
                @갨с𝐝e̲с.push: "C2::foo::wrapper";
                callsame
            }
        );

        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(42);
        is-deeply
            @갨с𝐝e̲с.List,
            <C3::foo C2::foo::wrapper C2::foo(Int) C2::foo(Any) C1::foo>,
            "wrapping of the first candidate doesn't break the chain";

        $w̲両.restore;

        @갨с𝐝e̲с = [];
        $갢丧ò中.foo(42);
        is-deeply @갨с𝐝e̲с, @갨с갢æ-갨с𝐝e̲с, "unwrapping of the candidate restores the order";
    }
}

# https://github.com/rakudo/rakudo/issues/3611
{
    my $𝐝갢ò𝐩à中개両e̲𝐝;
    my proto sub е갨갨(Int:D, uint32) {*}
    my multi sub е갨갨(0;; uint32)    { $𝐝갢ò𝐩à中개両e̲𝐝 = True }
    е갨갨 0, my uint32 $ = 1;
    is-deeply $𝐝갢ò𝐩à中개両e̲𝐝, True, 'native int dispatched ok';
}

# vim: expandtab shiftwidth=4
