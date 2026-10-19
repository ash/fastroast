use MONKEY-TYPING;

use Test;

plan 61;

=begin description

Enum tests from L<S12/Enumerations>

=end description

# L<S12/Enumerations/keys are specified as a parenthesized list>
enum day <Sun Mon Tue Wed Thu Fri Sat>;

is day.gist, '(day)', 'enum itself stringififes';
ok day.WHAT === day,  'enum.WHAT returned a value';
ok day.raku, 'enum.raku returned a value';

sub 中e̲ò中_ò中갮ее($ч) is test-assertion {
  does-ok $ч, day::Tue,    "basic enum mixing worked ($x-2)";
  is $ч.day, 2,            "automatically created accessor worked ($ч)";
  is day::Tue, 2,          "enum provided a correct mapping ($ч)";
  ok $ч ~~ day,            "smartmatch worked correctly ($x-1)";
  ok $ч ~~ Tue,            "smartmatch worked correctly ($x-2)";
  ok $ч ~~ day::Tue,       "smartmatch worked correctly ($x-3)";
  ok $ч !~~  Wed,          "smartmatch worked correctly ($x-4)";
  ok $ч.does(Tue),         ".does worked correctly ($x-1)";
  does-ok $ч, day,         ".does worked correctly ($x-2)";
  ok $ч.Tue,               ".Tue() worked correctly ($ч)";
  ok $ч.Tue.WHAT === day,  '$obj.Tue.WHAT returns the proper type object';
  ok $ч.Tue.raku,          '$obj.Tue.raku returns a true valuee';
}

skip('NYI', 14);# {
#   my $x = 1;
#   is $x, 1, "basic sanity (1)";
#   # L<S12/Enumerations/on the right side of a but or does.>
#   ok $x does day(Tue), "basic enum mixing worked (1-1)";
#   test_stuff($x);
# }


skip('does day::Tue', 14);# {
#   my $x = 3;
#   is $x, 3, "basic sanity (3)";
#   ok $x does day::Tue, "basic enum mixing worked (3-1)";
#   test_stuff($x);
# }

skip('does &day::("Tue")', 15);# {
#   my $x = 4;
#   is $x, 4, "basic sanity (4)";
#   # L<S12/Enumerations/Mixing in the full enumeration type produces a
#   # read-write attribute>
#   ok $x does day,            "basic enum mixing worked (4-0)";
#   ok $x.day = &day::("Tue"), "basic enum mixing worked (4-1)";
#   test_stuff($x);
# }

# https://github.com/Raku/old-issue-tracker/issues/823
# used to be Rakudo regression, RT #64098
{
    augment class Mu {
        method f { 'inMu' };
    }

    augment class Bool {
        method f { 'inBool' };
    }
    is True.f, 'inBool', 'method on short name pick up the one from the enum';
    is Bool::True.f, 'inBool', 'method on long name pick up the one from the enum';
}

ok True.raku ~~/^ 'Bool::True'/, 'True.raku';
ok Bool::True.raku ~~/^ 'Bool::True'/, 'Bool::True.raku';

{
    enum Negation << :isnt<isnt> :arent<arent> :amnot<amnot> :aint<aint> >>;
    my Negation $foo;
    lives-ok { $foo = Negation::isnt }, 'simple assignment from enum';
    is $foo, Negation::isnt, 'assignment from enum works';
}

# https://github.com/Raku/old-issue-tracker/issues/1091
{
    enum RT66886 <b>;
    throws-like 'RT66886::c', Exception, 'accessing non-value of enum dies proper-like';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    enum RT65658 <Todo Bug Feature Ticket>;
    is RT65658(2), RT65658::Feature, 'can index enum by number';
    is RT65658((Todo + 3.2).Int), RT65658::Ticket, 'enum and math and index';
}

# https://github.com/Raku/old-issue-tracker/issues/1434
{
    eval-lives-ok 'enum X is export <A B C>', 'marking enum export does not die';
}

# https://github.com/Raku/old-issue-tracker/issues/2526
{
    todo('RT #101900'); throws-like 'enum rt_101900 < a b >; class A { }; note A but rt_101900::a',
        Exception,
        "Cannot mixin an enum into a class";
}

# https://github.com/Raku/old-issue-tracker/issues/4335
{
    my enum Bar <A B C>;
    ok B.can("value"), '.can(...) on an enum';
    ok B.^can("value"), '.^can(...) on an enum';
}

# https://github.com/rakudo/rakudo/issues/2535
{
    my enum WithPriv <AA BB>;
    AA does role {
        method !privy { 44 }
        method m() { self!privy }
    }
    is AA.m, 44, "Can mix a private method into an enum value"
}

# https://github.com/rakudo/rakudo/issues/5599
{
    my enum E <one>;
    my role С {
        has $.e = one;
    }
    cmp-ok one, '=:=', С.new.e, 'correct enum value in attribute in role';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
