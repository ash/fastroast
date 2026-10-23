use Test;
use lib $*PROGRAM.parent(2).add("packages/Roles/lib");

plan 11;

# GH #2613
use GH2613;
my class 专e̲ò中Æ万2613 does R1 { }

ok 专e̲ò中Æ万2613.^does(R1), "class typecheck against short role name";
ok 专e̲ò中Æ万2613.^does(GH2613::R1), "class typecheck against full role name";
ok 专e̲ò中Æ万2613 ~~ R1, "class smartmatches against short role name";
ok 专e̲ò中Æ万2613 ~~ GH2613::R1, "class smartmatches against full role name";

# GH #2714
{
    my role С2714 { }
    my class 갂2714 does С2714 { }

    my class 갂2714_1 is 갂2714 { }
    my class 갂2714_2 is 갂2714 { }

    my role С2714_1 is 갂2714_1 { }
    my role С2714_1[::T] is 갂2714_2 { }

    ok С2714_1 ~~ 갂2714_1, "Role group matches a parent class of its non-parameterized member";
    ok С2714_1 ~~ 갂2714, "Role group matches a parent of parent of its non-parameterized member";
    ok С2714_1 ~~ С2714, "Role group matches a role of parent of its non-parameterized member";
    nok С2714_1 ~~ 갂2714_2, "Role group doesn't match a parent class of a parameterized member";

    my \r = С2714_1[Int];
    ok r ~~ 갂2714_2, "Curryied role matches its parent class";
    ok r ~~ 갂2714, "Curried role matches a parent of its parent class";
    ok r ~~ С2714, "Curried role matches a role of its parent class";
}

# vim: expandtab shiftwidth=4
