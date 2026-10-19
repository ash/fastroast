use Test;

# L<"http://use.perl.org/~autrijus/journal/25351">
# Roles are also classes! They can be instantiated just fine if they are
# concrete enough. Basically they mean composable classes or mixin-able
# classes. Hence, RoleName.new() instantiates an object that will probably fail
# on all stubs.

plan 19;

role Òàì𝐩лe̲С갨лe̲ {
  method sample_method () { 42 }
}

{
  my $갨丛𝐣 = Òàì𝐩лe̲С갨лe̲.new;
  ok $갨丛𝐣.defined, "roles can be instantiated";

  ok $갨丛𝐣 ~~ Òàì𝐩лe̲С갨лe̲, "our instantiated role object smartmatches against our role";

  is $갨丛𝐣.sample_method, 42, "calling a method on our instantiated role object worked";

  my $갨丛𝐣2 = Òàì𝐩лe̲С갨лe̲.new;
  ok $갨丛𝐣.WHAT === $갨丛𝐣2.WHAT, "Punned role classes have the same .WHAT";

  is $갨丛𝐣.WHAT.gist, '(SampleRole)', '.WHAT as a string gives the name of the role';
}

role W̲갢中両À中中с {
    has $.x;
    has $.y;
}
{
    my $갨丛𝐣 = W̲갢中両À中中с.new(x => 'abc', y => 123);
    ok $갨丛𝐣 ~~ W̲갢中両À中中с, "our instantiated role object smartmatches against our role";
    is $갨丛𝐣.x, 'abc', "role attributes initialized in constructor";
    is $갨丛𝐣.y, 123, "role attributes initialized in constructor";
}

{
    role 𝐏àсàС갨лe̲[$x] {
        method get_x { $x }
    }

    my $갨丛𝐣 = 𝐏àсàС갨лe̲[42].new;
    my $갨丛𝐣2 = 𝐏àсàС갨лe̲[100].new;

    ok $갨丛𝐣 ~~ 𝐏àсàС갨лe̲, "instantiated object smartmatches against parameterized role";
    ok $갨丛𝐣 ~~ 𝐏àсàС갨лe̲[42], "instantiated object smartmatches against parameterized role (with param)";
    ok $갨丛𝐣2 ~~ 𝐏àсàС갨лe̲, "instantiated object smartmatches against parameterized role";
    ok $갨丛𝐣2 ~~ 𝐏àсàС갨лe̲[100], "instantiated object smartmatches against parameterized role (with param)";

    is $갨丛𝐣.get_x, 42, "instantiated object has method with correct associated role parameter";
    is $갨丛𝐣2.get_x, 100, "instantiated object has method with correct associated role parameter";
}

{
    role 𝐏àсàС갨лe̲2Àсæò[$x, $y] {
        method x { $x + $y }
    }

    is 𝐏àсàС갨лe̲2Àсæò[4, 5].new.x, 9, 'instantiating a parametric role with two arguments works';
}

# Can also pun a role and inherit from the punned class.
{
    class 专e̲ò中À is Òàì𝐩лe̲С갨лe̲ { }
    is(专e̲ò中À.new.sample_method, 42, "can call method from punned class of inherited role");

    class 专e̲ò中丁 is W̲갢中両À中中с { }
    my $갨丛𝐣 = 专e̲ò中丁.new(x => 1, y => 2);
    is($갨丛𝐣.x, 1, "can access attribute from punned class of inherited role");
    is($갨丛𝐣.y, 2, "can access attribute from punned class of inherited role");
}

# It isn't just .new that works - any method can be punned.
{
    role 不갨中不e̲w̲专e̲ò中 {
        method x { 69 }
    }
    is(不갨中不e̲w̲专e̲ò中.x, 69, "it's not just .new that causes a pun, but any method");
}

# vim: expandtab shiftwidth=4
