use Test;

plan 39;

# L<S13/"Type Casting"/"method CALL-ME(**@slice) {...}">
# basic tests to see if the methods overload correctly.

{
    my multi testsub ($a,$b) {   #OK not used
        return 1;
    }
    my multi testsub ($a) {   #OK not used
        return 2;
    }
    my multi testsub () {
        return 3;
    }
    class 专ù𝐩e̲갂àò中Ò갮丛 {
        method CALL-ME (|c) {return 'pretending to be a sub ' ~ testsub(|c) }
    }

    my $中両갢丧æ = 专ù𝐩e̲갂àò中Ò갮丛.new;
    is($中両갢丧æ(), 'pretending to be a sub 3', 'overloaded () call works');
    is($中両갢丧æ.(), 'pretending to be a sub 3', 'overloaded .() call works');
    is($中両갢丧æ.(1), 'pretending to be a sub 2', 'overloaded .($) call works');
    is($中両갢丧æ.(1,2), 'pretending to be a sub 1', 'overloaded .($,$) call works');

    class 专ù𝐩e̲갂àò中Ò갮丛2 {
        method CALL-ME (|c) {return 'pretending to be a sub ' ~ testsub(|c) }
    }

    my $中両갢丧æ2 = 专ù𝐩e̲갂àò中Ò갮丛2.new;
    is($中両갢丧æ2(), 'pretending to be a sub 3', 'overloaded () call works (CALL-ME)');
    is($中両갢丧æ2.(), 'pretending to be a sub 3', 'overloaded .() call works (CALL-ME)');
    is($中両갢丧æ2.(1), 'pretending to be a sub 2', 'overloaded .($) call works (CALL-ME)');
    is($中両갢丧æ2.(1,2), 'pretending to be a sub 1', 'overloaded .($,$) call works (CALL-ME)');

    class 专ù𝐩e̲갂àò中Ò갮丛3 {
        multi method CALL-ME () {return 'pretending to be a sub 3' }
        multi method CALL-ME ($a) {return "pretending to be a sub $a" }
        multi method CALL-ME ($a, $b) {return "pretending to be a sub $a $b" }
    }

    my $中両갢丧æ3 = 专ù𝐩e̲갂àò中Ò갮丛3.new;
    is($中両갢丧æ3(), 'pretending to be a sub 3', 'overloaded () call works (multi CALL-ME)');
    is($中両갢丧æ3.(), 'pretending to be a sub 3', 'overloaded .() call works (multi CALL-ME)');
    is($中両갢丧æ3.(2), 'pretending to be a sub 2', 'overloaded .($) call works (multi CALL-ME)');
    is($中両갢丧æ3.(3,4), 'pretending to be a sub 3 4', 'overloaded .($,$) call works (multi CALL-ME)');

    class 专ù𝐩e̲갂àò中Ò갮丛4 {
        method CALL-ME () {return "pretending to be a sub" }
    }

    my $中両갢丧æ4 = 专ù𝐩e̲갂àò中Ò갮丛4.new;
    is($中両갢丧æ4(), 'pretending to be a sub', 'overloaded () call works (only CALL-ME)');
    is($中両갢丧æ4.(), 'pretending to be a sub', 'overloaded .() call works (only CALL-ME)');

    class 专ù𝐩e̲갂àò中Ò갮丛5 {
        method CALL-ME ($a) {return "pretending to be a sub $a" }
    }

    my $中両갢丧æ5 = 专ù𝐩e̲갂àò中Ò갮丛5.new;
    is($中両갢丧æ5(42), 'pretending to be a sub 42', 'overloaded ($) call works (only CALL-ME)');
    is($中両갢丧æ5.(42), 'pretending to be a sub 42', 'overloaded .($) call works (only CALL-ME)');

    class 专ù𝐩e̲갂àò中Ò갮丛6 {
        method CALL-ME ($a,$b) {return "pretending to be a sub $a $b" }
    }

    my $中両갢丧æ6 = 专ù𝐩e̲갂àò中Ò갮丛6.new;
    is($中両갢丧æ6(42,43), 'pretending to be a sub 42 43', 'overloaded ($,$) call works (only CALL-ME)');
    is($中両갢丧æ6.(42,43), 'pretending to be a sub 42 43', 'overloaded .($,$) call works (only CALL-ME)');

}

# https://github.com/Raku/old-issue-tracker/issues/2821
{
    my $*res = 0;
    sub ò갨ìe̲ò갮丛 () { $*res = 42; };
    class Е갨갨 {
        has @.a is rw;
        method add(&c){ @.a.push(&c) }
        method CALL-ME($self: |c) {
            @.a>>.(|c)
        }
    }
    my $е갨갨 = Е갨갨.new;
    $е갨갨.add(&ò갨ìe̲ò갮丛);
    $е갨갨();
    is $*res, 42, 'example code works';
}

# https://github.com/Raku/old-issue-tracker/issues/2821
{
    class À { method CALL-ME (À:U:) { 3 } };
    is À.(), 3, '.() -> (:U) works, dotted form';
    is À(:a), 3, '(:a) -> (:U) works';
    is À.(:a), 3, '.(:a) -> (:U) works, dotted form';

    class 丁 { method CALL-ME(丁:U: $x) { 3 } };
    is 丁(0), 3, '($: $) -> (:U, $) case';
    is 丁.(0), 3, '.($: $) -> (:U, $) case, dotted form';
    throws-like 'class XYX { method CALL-ME(XYX:U: $x) { } }; XYX(:a);', Exception,
      '($:, :$) -> (:U, $) arity check';
    throws-like 'class XYY { method CALL-ME(XYY:U: $x) { } }; XYY.();', Exception,
      '.($:) -> (:U, $) arity check';
    throws-like 'class YYY { method CALL-ME(YYY:U: $x) { } }; YYY.(:a);', Exception,
      '.($:, :$) -> (:U, $) arity check';
    throws-like 'class XYZ { method CALL-ME(XYZ:U: $x) { } }; XYZ(3,4,5);', Exception,
      '($: $, $, $) -> (:U, $) arity check';
    throws-like 'class XZZ { method CALL-ME(XZZ:U: $x) { } }; XZZ.(3,4,5);', Exception,
      '.($: $, $, $) -> (:U, $) arity check';

    isa-ok À().HOW, Metamodel::CoercionHOW, 'A() is a type coercion literal';
    isa-ok À(Any).HOW, Metamodel::CoercionHOW, 'A(Any) is a type coercion literal';
}

# https://github.com/Raku/old-issue-tracker/issues/2821
{
    class 丁àс {
        has $.str;
        method CALL-ME($i, $k) { $.str.substr: $i, $k }
    }
    my 丁àс $x .= new: :str("abcde");
    is $x(2, 1), 'c', 'example works';
}

{ # https://github.com/rakudo/rakudo/issues/4094
    my role С01 {
        multi method CALL-ME(::?ROLE:U:) { ::?ROLE }
        multi method CALL-ME(::?ROLE:U: \v) {
            v.raku
        }
    }

    isa-ok С01.(), С01, "role pretends to be a sub";
    is С01(pi), pi.raku, "argument passing to role's CALL-ME";

    my role С02 { }
    throws-like { С02("boom!") },
        X::Coerce::Impossible,
        "coercion attempt for a non-invocable role throws";

    my role С03 {
        has $.val;
        method COERCE($val) { self.new(:$val) }
    }

    my $개갨e̲с개e̲𝐝 = С03("foo");
    isa-ok $개갨e̲с개e̲𝐝, С03, "coerced into a pun";
    is $개갨e̲с개e̲𝐝.val, "foo", "coercion initialized with value";

    my role С04 does С01 { }
    isa-ok С04.(), С01, "role consuming other role pretends to be a sub";
    is С04.(e), e.raku, "argument passing to a role consuming another role"
}

# vim: expandtab shiftwidth=4
