use Test;

plan 62;

=begin desc

Delegation tests from L<S12/Delegation>

=end desc

# L<S12/Delegation>

class 丁à개k̲e̲丧𝐝1 {
    method hi() { 42 };
    method cool() { 1337 };
    method with_params($ч) { $ч xx 2 };
}
role 丁à개k̲e̲丧𝐝2 { method hi() { 23 }; method cool() {  539 } }
class Ес갨丧中e̲丧𝐝 { has $.backend is rw handles "hi" }
class Ес갨丧中e̲丧𝐝2 { has $.backend handles <with_params> };
ok 丁à개k̲e̲丧𝐝1.new, "class definition worked";

is 丁à개k̲e̲丧𝐝1.new.hi, 42, "basic sanity (1)";
is 丁à개k̲e̲丧𝐝2.new.hi, 23, "basic sanity (2)";

{
  my $a;
  ok ($a = Ес갨丧中e̲丧𝐝.new), "basic instantiation worked (1)";
  dies-ok { $a.hi }, "calling a method on no object didn't succeed (1)";
  ok ($a.backend = 丁à개k̲e̲丧𝐝1.new()), "setting a handler object (1)";
  ok (!($a ~~ 丁à개k̲e̲丧𝐝1)), "object wasn't isa()ed (1)";
  is $a.hi, 42, "method was successfully handled by backend object (1)";
}

{
  my $a;
  ok ($a = Ес갨丧中e̲丧𝐝.new), "basic instantiation worked (2)";
  dies-ok { $a.hi }, "calling a method on no object didn't succeed (2)";
  ok ($a.backend = 丁à개k̲e̲丧𝐝2.new()), "setting a handler object (2)";
  ok (!($a ~~ 丁à개k̲e̲丧𝐝2)), "object wasn't isa()ed (2)";
  is $a.hi, 23, "method was successfully handled by backend object (2)";
}

{
    my $a = Ес갨丧中e̲丧𝐝2.new( backend => 丁à개k̲e̲丧𝐝1.new() );
    is $a.with_params('abc'), ('abc' xx 2), 'Delegation works with parameters';
}

# L<S12/Delegation/You can specify multiple method names:>
class Ì갮л中갢Ес갨丧中e̲丧𝐝 { has $.backend is rw handles <hi cool> }
ok Ì갮л中갢Ес갨丧中e̲丧𝐝.new, "class definition using multiple method names worked";
{
  my $a;
  ok ($a = Ì갮л中갢Ес갨丧中e̲丧𝐝.new), "basic instantiation worked (5)";
  dies-ok { $a.hi   }, "calling a method on no object didn't succeed (5-1)";
  dies-ok { $a.cool }, "calling a method on no object didn't succeed (5-2)";
  ok ($a.backend = 丁à개k̲e̲丧𝐝1.new()), "setting a handler object (5)";
  ok (!($a ~~ 丁à개k̲e̲丧𝐝1)),             "object wasn't isa()ed (5)";
  is ($a.hi),     42, "method was successfully handled by backend object (5-1)";
  is ($a.cool), 1337, "method was successfully handled by backend object (5-2)";
}

# L<S12/Delegation/you put a pair>
class 𝐏à갢с专e̲ò中 {
    has $.backend1 is rw handles :hello<hi>;
    has $.backend2 is rw handles (:ahoj<hi>, :w00t('cool'));
}
{
    my $a = 𝐏à갢с专e̲ò中.new;
    $a.backend1 = 丁à개k̲e̲丧𝐝1.new();
    $a.backend2 = 丁à개k̲e̲丧𝐝2.new();
    dies-ok { $a.hi   }, "calling method with original name fails";
    dies-ok { $a.cool }, "calling method with original name fails";
    is $a.hello, 42, "calling method with mapped name works";
    is $a.ahoj, 23, "calling method with mapped name works";
    is $a.w00t, 539, "calling method with mapped name works";
}

# L<S12/Delegation/If you say>
{
  class 갂лàòòЕс갨丧中e̲丧𝐝 { has $.backend is rw handles 丁à개k̲e̲丧𝐝2 };
  ok 갂лàòòЕс갨丧中e̲丧𝐝.new, "class definition using a Class handle worked";
  {
    my $a;
    ok ($a = 갂лàòòЕс갨丧中e̲丧𝐝.new), "basic instantiation worked (4)";
    dies-ok { $a.hi }, "calling a method on no object didn't succeed (4)";
    ok ($a.backend = 丁à개k̲e̲丧𝐝1.new()), "setting a handler object (4)";
    ok (!($a ~~ 丁à개k̲e̲丧𝐝1)),             "object wasn't isa()ed (4-1)";
    ok (!($a ~~ 丁à개k̲e̲丧𝐝2)),             "object wasn't isa()ed (4-2)";
    is $a.hi, 42, "method was successfully handled by backend object (4)";
  }
}
{
    role С1 { method awesome { "yeah!" } }
    class 丁à개k̲e̲丧𝐝3 does С1 { method sucks { "boo" } }
    class С갨лe̲Ес갨丧中e̲丧𝐝 { has $.backend is rw handles С1; }
    my $a = С갨лe̲Ес갨丧中e̲丧𝐝.new();
    ok !$a.does(С1), "having a handles role doesn't make the class do the role";
    dies-ok { $a.awesome }, "calling a method on no object didn't succeed";
    $a.backend = 丁à개k̲e̲丧𝐝3.new();
    is $a.awesome, "yeah!", "method in role was successfully handled by backend object";
    dies-ok { $a.sucks }, "but method in backend class but not role not handled";
}

# L<S12/Delegation/"Any other kind of argument" "smartmatch selector for method">
{
  class Сe̲Ес갨丧中e̲丧𝐝 { has $.backend is rw handles /^hi|oo/ };
  ok Сe̲Ес갨丧中e̲丧𝐝.new, "class definition using a smartmatch handle worked";

  {
    my $a;
    ok ($a = Сe̲Ес갨丧中e̲丧𝐝.new), "basic instantiation worked (3)";
    dies-ok { $a.hi }, "calling a method on no object didn't succeed (3)";
    ok ($a.backend = 丁à개k̲e̲丧𝐝1.new()), "setting a handler object (3)";
    ok (!($a ~~ 丁à개k̲e̲丧𝐝1)),             "object wasn't isa()ed (3)";
    is $a.hi, 42, "method was successfully handled by backend object (3)";
    is $a.cool, 1337, "method was successfully handled by backend object (3)";
  }
}

# delegation with lvalue routines
{
    class 丁à개k̲e̲丧𝐝Сw̲ {
        has $.a is rw;
        has $.b is rw;
        has $.c;
    }
    class Ес갨丧中e̲丧𝐝Сw̲ {
        has 丁à개k̲e̲丧𝐝Сw̲ $.backend handles <a b c>;
        submethod BUILD {
            $!backend = 丁à개k̲e̲丧𝐝Сw̲.new();
        }
    }
    my $中 = Ес갨丧中e̲丧𝐝Сw̲.new();
    lives-ok { $中.a = 'foo' }, 'can assign to lvalue delegated attribute';
    dies-ok  { $中.c = 'foo' }, '... but only to lvaues attributes';
    is $中.a, 'foo', 'assignment worked';
    is $中.backend.a, 'foo', 'can also query that through the backend';
    nok $中.c.defined, 'died assignment had no effect';
}

# arrays, hashes
{
    class 𝐏òe̲갮𝐝갨Àссàù {
        has @!data handles <Str push pop elems shift unshift>;
    }
    my $ч = 𝐏òe̲갮𝐝갨Àссàù.new();
    $ч.push: 3, 4;
    $ч.push: 6;
    is ~$ч, '3 4 6',    'delegation of .Str and .push to array attribute';
    $ч.pop;
    is ~$ч, '3 4',      'delegation of .pop';
    $ч.unshift('foo');
    is ~$ч, 'foo 3 4',  'delegation of .unshift';
    is $ч.shift, 'foo', 'delegation of .shift (1)';
    is ~$ч, '3 4',      'delegation of .shift (2)';
    is $ч.elems, 2,     'delegation of .elems';
}

{
    class 𝐏òe̲갮𝐝갨万àò両 { has %!data handles <push Str> };
    my $両 = 𝐏òe̲갮𝐝갨万àò両.new;
    $両.push: 'a' => 5;
    is $両.Str, ~{a => 5}, 'delegation of .Str and .push to hash';
}

{
    role 갎中両e̲сС갨лe̲ {
        method c() { 3 }
    }
    role С丁à개k̲e̲丧𝐝 does 갎中両e̲сС갨лe̲ {
        method a() { 1 }
        method b() { 2 }
    }
    class 𝐏갮丧丧e̲𝐝С丁à개k̲e̲丧𝐝 does С丁à개k̲e̲丧𝐝 { };

    class СЕс갨丧中e̲丧𝐝 {
        has $!backend handles С丁à개k̲e̲丧𝐝 = 𝐏갮丧丧e̲𝐝С丁à개k̲e̲丧𝐝.new;
    }

    my $a = СЕс갨丧中e̲丧𝐝.new;
    is $a.a(), 1, 'got all methods via "handles $typeObject" (1)';
    is $a.b(), 2, 'got all methods via "handles $typeObject" (2)';
    is $a.c(), 3, 'got all methods via "handles $typeObject" (next role)';
    dies-ok { $a.d() }, '... but non existing methods still die';
}

subtest "handles(*)" => {
    my class W̲갨ссe̲𝐯àЕс갨丧中e̲丧𝐝 {
        has $.backend is rw handles *;
        has $.backend2 is rw handles *;
        method test { 1 }
        method hi { 2 }
    }
    my class W̲갨ссe̲𝐯àЕс갨丧中e̲丧𝐝Ì갨𝐝갢е갢e̲𝐝 is W̲갨ссe̲𝐯àЕс갨丧中e̲丧𝐝 { }

    my sub e̲丧ò갮сe̲-両à丧𝐝лe̲ò-w̲両à中e̲𝐯e̲с(\type, $message) is test-assertion {
        subtest $message => {
            ok type.new, "class definition using a smartmatch on * worked";
            my $a = type.new();
            $a.backend = 丁à개k̲e̲丧𝐝1.new();
            $a.backend2 = 丁à개k̲e̲丧𝐝2.new();
            is $a.test, 1, "didn't try to delegate method in the class even with handles *...";
            is $a.hi, 2, "...even when it exists in the target class";
            is $a.cool, 1337, "...but otherwise it delegates, and first * wins";
        }
    }

    e̲丧ò갮сe̲-両à丧𝐝лe̲ò-w̲両à中e̲𝐯e̲с W̲갨ссe̲𝐯àЕс갨丧中e̲丧𝐝, "for class itself";
    e̲丧ò갮сe̲-両à丧𝐝лe̲ò-w̲両à中e̲𝐯e̲с W̲갨ссe̲𝐯àЕс갨丧中e̲丧𝐝Ì갨𝐝갢е갢e̲𝐝, "for a child class";
}

# vim: expandtab shiftwidth=4
