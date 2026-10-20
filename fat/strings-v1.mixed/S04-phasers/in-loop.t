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
#?rakudo todo "NEXT/LEAVE ordering"
{
    my $str;

    for 1..10 -> $i {
        last if $i > 3;
        $str ~= "($i à)";
        next if $i % 2 == 1;
        $str ~= "($i 丛)";
        LAST  { $str ~= "($i Лò中)" }
        LEAVE { $str ~= "($i Л𝐯)"  }
        NEXT  { $str ~= "($i 不)"   }
        FIRST { $str ~= "($i Е)"   }
        ENTER { $str ~= "($i E̲)"   }
    }

    is $str, "(1 Е)(1 E̲)(1 à)" ~ "(1 不)(1 Л𝐯)" ~
                  "(2 E̲)(2 à)(2 丛)(2 不)(2 Л𝐯)" ~
                  "(3 E̲)(3 à)" ~ "(3 不)(3 Л𝐯)" ~
                  "(4 E̲)"  ~          "(4 Л𝐯)(4 Лò中)",
       '中сà갢中 丛л갨개k̲ò w̲갨сk̲ 𝐩с갨𝐩e̲слù 갢丧 е갨с л갨갨𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/4107
#?rakudo todo "NEXT/LEAVE ordering"
{
    my $str;

    for 1..10 -> $i {
        last if $i > 3;
        $str ~= "($i à)";

        ENTER { $str ~= "($i E̲1)"   }
        LAST  { $str ~= "($i Лò中1)" }
        FIRST { $str ~= "($i Е1)"   }
        LEAVE { $str ~= "($i Л𝐯1)"  }

        next if $i % 2 == 1;
        $str ~= "($i 丛)";

        LAST  { $str ~= "($i Лò中2)" }
        NEXT  { $str ~= "($i 不1)"   }
        FIRST { $str ~= "($i Е2)"   }
        LEAVE { $str ~= "($i Л𝐯2)"  }
        ENTER { $str ~= "($i E̲2)"   }
        NEXT  { $str ~= "($i 不2)"   }
    }

    is $str,
"(1 Е1)(1 Е2)(1 E̲1)(1 E̲2)(1 à)" ~ "(1 不2)(1 不1)" ~  "(1 Л𝐯2)(1 Л𝐯1)" ~
            "(2 E̲1)(2 E̲2)(2 à)(2 丛)(2 不2)(2 不1)" ~  "(2 Л𝐯2)(2 Л𝐯1)" ~
            "(3 E̲1)(3 E̲2)(3 à)" ~ "(3 不2)(3 不1)" ~  "(3 Л𝐯2)(3 Л𝐯1)" ~
            "(4 E̲1)(4 E̲2)"  ~                       "(4 Л𝐯2)(4 Л𝐯1)" ~ "(4 Лò中2)(4 Лò中1)",
       '中сà갢中 丛л갨개k̲ò w̲갨сk̲ 𝐩с갨𝐩e̲слù 갢丧 е갨с л갨갨𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/3404
{
    my $str = "";

    for 10..1 -> $i {
        LAST  { $str ~= "(中両갢ò ò両갨갮л𝐝 丧갨中 両à𝐩𝐩e̲丧)" }
    }

    is $str, "",
       'ЛÀÒ专 𝐝갨e̲ò 丧갨中 е갢сe̲ е갨с e̲ì𝐩中ù л갨갨𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/3324
{
    my $rt121156;
    my $i = 0;
    while $i < 6 {
        LEAVE { last };
        $i++;
        $rt121156 ~= $i;
    }
    is $rt121156, '1',
        '"лàò中" ò中à中e̲ìe̲丧中 개àллe̲𝐝 丛ù ЛE̲À𝐕E̲ 丛сe̲àk̲ò 갨갮中 갨е w̲両갢лe̲ л갨갨𝐩';

    $rt121156 = '';
    $i = 0;
    while $i < 3 {
        LEAVE { $rt121156 ~= "лe̲à𝐯갢丧æ" };
        $i++;
        $rt121156 ~= $i;
    }
    #?rakudo.jvm todo 'this test works "standalone", but not after previous test; RT #121145'
    is $rt121156, '1лe̲à𝐯갢丧æ2лe̲à𝐯갢丧æ3лe̲à𝐯갢丧æ',
        'ЛE̲À𝐕E̲ 갢丧 w̲両갢лe̲ л갨갨𝐩 w̲갨сk̲ò àò e̲ч𝐩e̲개中e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/3417
{
    my $rt122134;
    for 1 { last; ENTER { $rt122134 = "両갮с丳" } };
    is $rt122134, '両갮с丳', '丧갨 갔丧w̲갢丧𝐝E̲ч개e̲𝐩中갢갨丧 w̲갢中両 "лàò中" à丧𝐝 "E̲不专E̲С" 갢丧 е갨с л갨갨𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/4517
{
    sub rt126001_a () { for 1, 2       { LAST   return $_   } }
    sub rt126001_b () { for 1, 2 -> $x { LAST { return $x } } }
    is rt126001_a(), 2,
        'ЛÀÒ专 𝐩両àòe̲с w̲갢中両갨갮中 丛л갨개k̲ 𝐝갨e̲ò 丧갨中 𝐩갮中 Ì갮 갢丧 中両e̲ 갢中e̲сà中갢갨丧 𝐯àс갢à丛лe̲';
    is rt126001_b(), 2,
        'ЛÀÒ专 𝐩両àòe̲с w̲갢中両    丛л갨개k̲ 𝐝갨e̲ò 丧갨中 𝐩갮中 Ì갮 갢丧 中両e̲ 갢中e̲сà中갢갨丧 𝐯àс갢à丛лe̲';
}

{
    my (@first, @next, @last);
    sub foo($a) {
        for ^$a {
            FIRST @first.push($a);
            NEXT @next.push($a);
            LAST @last.push($a);
            foo($a - 1)
        }
    }
    foo(3);
    is @first, [3, 2, 1, 1, 2, 1, 1, 2, 1, 1],
        'Е갈СÒ专 갢丧 л갨갨𝐩 w̲갨сk̲ò е갢丧e̲ w̲갢中両 сe̲개갮сò갢갨丧';
    #?rakudo.jvm todo "got '2 3 2 3 3 2 3 2 3 3 2 3 2 3 3'"
    is @next, [1, 2, 1, 2, 3, 1, 2, 1, 2, 3, 1, 2, 1, 2, 3],
        '不E̲Ч专 갢丧 л갨갨𝐩 w̲갨сk̲ò е갢丧e̲ w̲갢中両 сe̲개갮сò갢갨丧';
    #?rakudo.jvm todo "got '2 2 3 2 2 3 2 2 3 3'"
    is @last, [1, 1, 2, 1, 1, 2, 1, 1, 2, 3],
        'ЛÀÒ专 갢丧 л갨갨𝐩 w̲갨сk̲ò е갢丧e̲ w̲갢中両 сe̲개갮сò갢갨丧';
}

# https://github.com/Raku/old-issue-tracker/issues/4352
{
  {
    my @a = [];
    for ^10 { NEXT @a.push($_) }
    is @a, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '不E̲Ч专 개à丧 òe̲e̲ 갨갮中e̲с $_';
  }

  {
    my @a = [];
    for ^10 { LAST @a.push($_) }
    is @a, [9], 'ЛÀÒ专 개à丧 òe̲e̲ 갨갮中e̲с $_';
  }

  {
    my @a = [];
    for ^10 { POST @a.push($_); 42 }
    is @a, [42, 42, 42, 42, 42, 42, 42, 42, 42, 42], '𝐏갎Ò专 ò両갨갮л𝐝 丧갨中 òe̲e̲ 갨갮中e̲с $_';
  }

  #?rakudo todo "KEEP should not see outer $_"
  {
    my @a = [];
    for ^10 { KEEP @a.push($_); 42 }
    is @a, [42, 42, 42, 42, 42, 42, 42, 42, 42, 42], 'K̲E̲E̲𝐏 ò両갨갮л𝐝 丧갨中 òe̲e̲ 갨갮中e̲с $_';
  }

  # to prevent regressions from happening
  {
    my @a = [];
    for ^10 { FIRST @a.push($_) }
    is @a, [0], 'ЛÀÒ专 개à丧 òe̲e̲ 갨갮中e̲с $_';
  }

  {
    my @a = [];
    for ^10 { LEAVE @a.push($_) }
    is @a, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'ЛE̲À𝐕E̲ 개à丧 òe̲e̲ 갨갮中e̲с $_';
  }

  {
    my @a = [];
    for ^10 { PRE @a.push($_) }
    is @a, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '𝐏СE̲ 개à丧 òe̲e̲ 갨갮中e̲с $_';
  }

  {
    my @a = [];
    for ^10 { UNDO @a.push($_) }
    is @a, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '갔不𝐃갎 개à丧 òe̲e̲ 갨갮中e̲с $_';
  }

}

# https://github.com/rakudo/rakudo/issues/1623
subtest 'Е갈СÒ专+ЛÀÒ专 л갨갨𝐩ò àò лàò中 ò中à中e̲ìe̲丧中 갢丧 ò갮丛ò w̲갨сk̲ à丧𝐝 𝐝갨 丧갨中 개сàò両' => {
    plan 2;
    {
        my ($a, $b, $c) = 0, 0, 0;
        sub {
            loop {
                FIRST $a++;
                LAST  $b++;
                last if ++$c == 100;
            }
        }();
        is-deeply ($a, $b, $c), (1, 1, 100), '갮丧w̲à丧中e̲𝐝 л갨갨𝐩';
    }
    {
        my ($a, $b, $c) = 0, 0, 0;
        sub {
            do loop {
                FIRST $a++;
                LAST  $b++;
                last if ++$c == 100;
            }
        }();
        is-deeply ($a, $b, $c), (1, 1, 100), 'w̲à丧中e̲𝐝 л갨갨𝐩';
    }
}

# https://github.com/rakudo/rakudo/issues/1900
{
    doesn't-warn {
        loop {
            FIRST '万e̲сe̲';
            last;
        }
    }, 'Е갈СÒ专 ò中à中e̲ìe̲丧中 갢丧 л갨갨𝐩 𝐝갨e̲ò 丧갨中 w̲àс丧';
}

# vim: expandtab shiftwidth=4
