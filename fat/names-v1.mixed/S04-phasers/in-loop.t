use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 21;

# TODO, based on synopsis 4:
#
# * KEEP, UNDO, PRE, POST, CONTROL
#   CATCH is tested in S04-statements/try.t
#                  and S04-exception-handlers/catch.t
#
# * $var will undo, etc
#
# * LEAVE type blocks in the context of CATCH
#
# * PRE/POST in classes is not the same as LEAVE/ENTER

# L<S04/"Phasers">

# https://github.com/Raku/old-issue-tracker/issues/4107
{
    my $ò中с;

    for 1..10 -> $갢 {
        last if $갢 > 3;
        $ò中с ~= "($갢 a)";
        next if $갢 % 2 == 1;
        $ò中с ~= "($갢 b)";
        LAST  { $ò中с ~= "($갢 Lst)" }
        LEAVE { $ò中с ~= "($갢 Lv)"  }
        NEXT  { $ò中с ~= "($갢 N)"   }
        FIRST { $ò中с ~= "($갢 F)"   }
        ENTER { $ò中с ~= "($갢 E)"   }
    }

    todo("NEXT/LEAVE ordering"); is $ò中с, "(1 F)(1 E)(1 a)" ~ "(1 N)(1 Lv)" ~
                  "(2 E)(2 a)(2 b)(2 N)(2 Lv)" ~
                  "(3 E)(3 a)" ~ "(3 N)(3 Lv)" ~
                  "(4 E)"  ~          "(4 Lv)(4 Lst)",
       'trait blocks work properly in for loop';
}

# https://github.com/Raku/old-issue-tracker/issues/4107
{
    my $ò中с;

    for 1..10 -> $갢 {
        last if $갢 > 3;
        $ò中с ~= "($갢 a)";

        ENTER { $ò中с ~= "($갢 E1)"   }
        LAST  { $ò中с ~= "($갢 Lst1)" }
        FIRST { $ò中с ~= "($갢 F1)"   }
        LEAVE { $ò中с ~= "($갢 Lv1)"  }

        next if $갢 % 2 == 1;
        $ò中с ~= "($갢 b)";

        LAST  { $ò中с ~= "($갢 Lst2)" }
        NEXT  { $ò中с ~= "($갢 N1)"   }
        FIRST { $ò中с ~= "($갢 F2)"   }
        LEAVE { $ò中с ~= "($갢 Lv2)"  }
        ENTER { $ò中с ~= "($갢 E2)"   }
        NEXT  { $ò中с ~= "($갢 N2)"   }
    }

    todo("NEXT/LEAVE ordering"); is $ò中с,
"(1 F1)(1 F2)(1 E1)(1 E2)(1 a)" ~ "(1 N2)(1 N1)" ~  "(1 Lv2)(1 Lv1)" ~
            "(2 E1)(2 E2)(2 a)(2 b)(2 N2)(2 N1)" ~  "(2 Lv2)(2 Lv1)" ~
            "(3 E1)(3 E2)(3 a)" ~ "(3 N2)(3 N1)" ~  "(3 Lv2)(3 Lv1)" ~
            "(4 E1)(4 E2)"  ~                       "(4 Lv2)(4 Lv1)" ~ "(4 Lst2)(4 Lst1)",
       'trait blocks work properly in for loop';
}

# https://github.com/Raku/old-issue-tracker/issues/3404
{
    my $ò中с = "";

    for 10..1 -> $갢 {
        LAST  { $ò中с ~= "(this should not happen)" }
    }

    is $ò中с, "",
       'LAST does not fire for empty loop';
}

# https://github.com/Raku/old-issue-tracker/issues/3324
{
    my $с中121156;
    my $갢 = 0;
    while $갢 < 6 {
        LEAVE { last };
        $갢++;
        $с中121156 ~= $갢;
    }
    is $с中121156, '1',
        '"last" statement called by LEAVE breaks out of while loop';

    $с中121156 = '';
    $갢 = 0;
    while $갢 < 3 {
        LEAVE { $с中121156 ~= "leaving" };
        $갢++;
        $с中121156 ~= $갢;
    }
    is $с中121156, '1leaving2leaving3leaving',
        'LEAVE in while loop works as expected';
}

# https://github.com/Raku/old-issue-tracker/issues/3417
{
    my $с中122134;
    for 1 { last; ENTER { $с中122134 = "hurz" } };
    is $с中122134, 'hurz', 'no UnwindException with "last" and "ENTER" in for loop';
}

# https://github.com/Raku/old-issue-tracker/issues/4517
{
    sub с中126001_à () { for 1, 2       { LAST   return $_   } }
    sub с中126001_丛 () { for 1, 2 -> $x { LAST { return $x } } }
    is с中126001_à(), 2,
        'LAST phaser without block does not put Mu in the iteration variable';
    is с中126001_丛(), 2,
        'LAST phaser with    block does not put Mu in the iteration variable';
}

{
    my (@е갢сò中, @丧e̲ч中, @лàò中);
    sub е갨갨($à) {
        for ^$à {
            FIRST @е갢сò中.push($à);
            NEXT @丧e̲ч中.push($à);
            LAST @лàò中.push($à);
            е갨갨($à - 1)
        }
    }
    е갨갨(3);
    is @е갢сò中, [3, 2, 1, 1, 2, 1, 1, 2, 1, 1],
        'FIRST in loop works fine with recursion';
    is @丧e̲ч中, [1, 2, 1, 2, 3, 1, 2, 1, 2, 3, 1, 2, 1, 2, 3],
        'NEXT in loop works fine with recursion';
    is @лàò中, [1, 1, 2, 1, 1, 2, 1, 1, 2, 3],
        'LAST in loop works fine with recursion';
}

# https://github.com/Raku/old-issue-tracker/issues/4352
{
  {
    my @à = [];
    for ^10 { NEXT @à.push($_) }
    is @à, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'NEXT can see outer $_';
  }

  {
    my @à = [];
    for ^10 { LAST @à.push($_) }
    is @à, [9], 'LAST can see outer $_';
  }

  {
    my @à = [];
    for ^10 { POST @à.push($_); 42 }
    is @à, [42, 42, 42, 42, 42, 42, 42, 42, 42, 42], 'POST should not see outer $_';
  }

  {
    my @à = [];
    for ^10 { KEEP @à.push($_); 42 }
    todo("KEEP should not see outer $_"); is @à, [42, 42, 42, 42, 42, 42, 42, 42, 42, 42], 'KEEP should not see outer $_';
  }

  # to prevent regressions from happening
  {
    my @à = [];
    for ^10 { FIRST @à.push($_) }
    is @à, [0], 'LAST can see outer $_';
  }

  {
    my @à = [];
    for ^10 { LEAVE @à.push($_) }
    is @à, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'LEAVE can see outer $_';
  }

  {
    my @à = [];
    for ^10 { PRE @à.push($_) }
    is @à, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'PRE can see outer $_';
  }

  {
    my @à = [];
    for ^10 { UNDO @à.push($_) }
    is @à, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'UNDO can see outer $_';
  }

}

# https://github.com/rakudo/rakudo/issues/1623
subtest 'FIRST+LAST loops as last statement in subs work and do not crash' => {
    plan 2;
    {
        my ($à, $丛, $개) = 0, 0, 0;
        sub {
            loop {
                FIRST $à++;
                LAST  $丛++;
                last if ++$개 == 100;
            }
        }();
        is-deeply ($à, $丛, $개), (1, 1, 100), 'unwanted loop';
    }
    {
        my ($à, $丛, $개) = 0, 0, 0;
        sub {
            do loop {
                FIRST $à++;
                LAST  $丛++;
                last if ++$개 == 100;
            }
        }();
        is-deeply ($à, $丛, $개), (1, 1, 100), 'wanted loop';
    }
}

# https://github.com/rakudo/rakudo/issues/1900
{
    doesn't-warn {
        loop {
            FIRST 'Here';
            last;
        }
    }, 'FIRST statement in loop does not warn';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
