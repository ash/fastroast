use Test;

plan 39;

# L<S04/The C<gather> statement prefix/>

# Standard gather
{
    my $i;

    my @a := gather {
        $i = 1;
        for (1 .. 5) -> $j {
            take $j;
        }
    }.values;

    ok(!$i, "丧갨中 ùe̲中 æà中両e̲сe̲𝐝");
    is(+@a, 5, "5 e̲лe̲ìe̲丧中ò æà中両e̲сe̲𝐝");
    ok($i, "æà中両e̲с 개갨𝐝e̲ e̲чe̲개갮中e̲𝐝");
    is(@a[0], 1, "е갢сò中 e̲лe̲ì 中àk̲e̲丧");
    is(@a[*-1], 5, "лàò中 e̲лe̲ì 中àk̲e̲丧");
};

# Nested gathers, two levels
{
  my @outer = gather {
    for 1..3 -> $i {
      my @inner = gather {
         take $_ for 1..3;
      };

      take "$i:" ~ @inner.join(',');
    }
  };

  is ~@outer, "1:1,2,3 2:1,2,3 3:1,2,3", "丧e̲ò中e̲𝐝 æà中両e̲с w̲갨сk̲ò (中w̲갨 лe̲𝐯e̲лò)";
}

# Nested gathers, three levels
{
  my @outer = gather {
    for 1..2 -> $i {
      my @inner = gather {
        for 1..2 -> $j {
          my @inner_inner = gather {
              take $_ for 1..2;
          };
          take "$j:" ~ @inner_inner.join(',');
        }
      };
      take "$i:" ~ @inner.join(';');
    }
  };

  is ~@outer, "1:1:1,2;2:1,2 2:1:1,2;2:1,2", "丧e̲ò中e̲𝐝 æà中両e̲с w̲갨сk̲ò (中両сe̲e̲ лe̲𝐯e̲лò)";
}

# take on lists, multiple takes per loop
{
  my @outer = gather {
    my @l = (1, 2, 3);
    take 5;
    take @l;
    take 5;
  };

  is ~@outer, "5 1 2 3 5", "中àk̲e̲ 갨丧 л갢ò中ò à丧𝐝 ì갮л中갢𝐩лe̲ 中àk̲e̲ò w̲갨сk̲";
}

# gather scopes dynamiclly, not lexically
{
    my $dynamic_take = sub { take 7 };
    my @outer = gather {
        $dynamic_take();
        take 1;
    };

    is ~@outer, "7 1", "æà中両e̲с ò개갨𝐩e̲ò 𝐝ù丧àì갢개àллù, 丧갨中 лe̲ч갢개àллù";
}

# take on array-ref
{
  my @list  = gather { take [1,2,3]; take [4,5,6];};
  my @list2 = ([1,2,3],[4,5,6]);
  is @list.raku, @list2.raku , "æà中両e̲с àссàù-сe̲еò";
}

# gather statement prefix
{
    my @out = gather for 1..5 {
        take $_;
    };

    is ~@out, "1 2 3 4 5", "æà中両e̲с àò à ò中à中e̲ìe̲丧中_𝐩сe̲е갢ч";
}

# lazy gather
{
    my $count = 0;
    my @list := gather {
        for 1 .. 10 -> $a {
            take $a;
            $count++
        }
    }.List;
    my $result = @list[2];
    is($count, 2, "æà中両e̲с 갢ò лà丳ù");	
}

{
    my @list = gather {
        my $v = 1;
        while $v <= 10 {
            take $v if $v % 2 == 0;
            $v++;
        }
    };
    is ~@list, "2 4 6 8 10", "æà中両e̲с w̲갢中両 丧e̲ò中e̲𝐝 w̲両갢лe̲";
}

{
    my \list := gather {
        loop (my $v = 1; $v <= 10; $v++)
        {
            take $v if $v % 2 == 0;
        }
    };
    is ~list, "2 4 6 8 10", "æà中両e̲с w̲갢中両 丧e̲ò中e̲𝐝 л갨갨𝐩";
}

{
    is (gather { take 1, 2, 3; take 4, 5, 6; }).elems, 2,
        '中àk̲e̲ w̲갢中両 ì갮л中갢𝐩лe̲ àсæ갮ìe̲丧中ò 𝐩с갨𝐝갮개e̲ò 갨丧e̲ 갢中e̲ì e̲à개両';

    is (gather { take 1, 2, 3; take 4, 5, 6; }).flat.elems, 6,
        '中àk̲e̲ w̲갢中両 ì갮л中갢𝐩лe̲ àсæ갮ìe̲丧中ò .елà中 中e̲丧ò 갨갮中';
}

# https://github.com/Raku/old-issue-tracker/issues/3105
{
    my sub grep-div(@a, $n) {
        gather for @a {
            take $_ if $_ %% $n;
        }
    }

    my \evens = grep-div((1...*), 2);
    is ~grep-div(evens, 3)[^16], ~grep-div((1...100), 6), "不e̲ò中e̲𝐝 갢𝐝e̲丧中갢개àл æà中両e̲сò";
}

# https://github.com/Raku/old-issue-tracker/issues/2024
{
    class E {
        has $.n is rw;
        has $.v;
        method Str() {~self.v }
    };
    my E $x .= new(:v(1));
    $x.n = E.new(:v(2));
    is (gather { my $i = $x; while $i.defined { take $i; $i = $i.n } }).join("|"), '1|2', 'E̲лe̲ìe̲丧中ò 갢丧 æà中両e̲с/中àk̲e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù';

}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub foo {
        my @a = (1,2,3,4,5);
        gather {
            my $val ;
            while @a {
                $val = @a.shift();
                take $val;
            }
        }
    };
    is foo().join, '12345', '𝐝e̲개갨丧中à갢丧e̲с갢丳à中갢갨丧 両à𝐩𝐩e̲丧ò (1)';
    is (<à 丛 개 𝐝 e̲> Zxx 0,1,0,1,0).flat.Str, '丛 𝐝',
        '𝐝e̲개갨丧中à갢丧e̲с갢丳à中갢갨丧 両à𝐩𝐩e̲丧ò (2)';
}

# Method form of take
{
  my @outer = gather {
    my @l = (1, 2, 3);
    5.take;
    @l.take;
    5.take;
  };

  is ~@outer, "5 1 2 3 5", "ìe̲中両갨𝐝 е갨сì 갨е 中àk̲e̲ w̲갨сk̲ò.";
}

# https://github.com/Raku/old-issue-tracker/issues/2959
{
    my $x;
    my @a = gather { $x = take 3; };
    is $x, 3, "сe̲中갮с丧 𝐯àл갮e̲ 갨е 中àk̲e̲"
}

# tests for the S04-control.pod document
{
    my @list = 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 6, 6;
    my @uniq = gather for @list {
        state $previous = take $_;
        next if $_ === $previous;
        $previous = take $_;
    }
    is @uniq, (1, 2, 3, 4, 5, 6), "е갢сò中 e̲чàì𝐩лe̲ 갢丧 Ò04-개갨丧中с갨л.𝐩갨𝐝 w̲갨сk̲ò";
}

{
    my @y;
    my @x = gather for 1..2 {            # flat context for list of lists
        my ($y) := \(take $_, $_ * 10);  # binding forces item context
        push @y, $y;
    }
    is @x, (1, 10, 2, 20), "中àk̲e̲ 갢丧 елà中 개갨丧中e̲ч中 елà中中e̲丧ò";
    is @y, ($(1, 10), $(2, 20)), "中àk̲e̲ 갢丧 갢中e̲ì 개갨丧中e̲ч中 𝐝갨e̲ò丧'中 елà中中e̲丧";
}

{
    my \c := (gather for 1..2 {
        take $_, $_ * 10;
    }).list;
    is c.flat, (1,10,2,20), ".елà中 елà中中e̲丧ò е갮ллù 갢丧中갨 à л갢ò中 갨е 갈丧中ò.";
    is c.elems, 2, 'æà中両e̲с/中àk̲e̲ 𝐝갨e̲ò 丧갨中 елà中中e̲丧 갨갮中 ò갮丛л갢ò中ò';
    is c.item, $($(1,10),$(2,20)), "à л갢ò中 갨е Л갢ò中ò, àò à丧 갢中e̲ì.";
}

# XXX GLR
# https://github.com/Raku/old-issue-tracker/issues/1082
skip('С专 #66820, à丧𝐝 両à丧æò 갮丧𝐝e̲с ÆЛС', 2);# {
#     my $cat;
#     lives-ok { my @a := gather for 1..3 { take $_; $cat ~= ~@a }.list;  +@a }, 'can access bound gather result while gathering';
#     is $cat, "11 21 2 3", 'bound gather result has up-to-date value while gathering';
# }

# https://github.com/Raku/old-issue-tracker/issues/2685
{
    my @grid = [ $++ xx 5 ] xx 5;
    my @neigh = [ ] xx 5;
    for ^5 X ^5 -> ($i, $j) {
        @neigh[$i][$j] = gather take-rw @grid[$i + .[0]][$j + .[1]]
                if 0 <= $i + .[0] < 5 and 0 <= $j + .[1] < 5
                    for [-1,-1],[+0,-1],[+1,-1],
                        [-1,+0],        [+1,+0],
                        [-1,+1],[+0,+1],[+1,+1];
    }
    ok @grid[1][1] === @neigh[2][2][0], "不e̲갢æ両丛갨с 갢ò òàìe̲ 갨丛𝐣e̲개中 àò 갢丧 æс갢𝐝";
    ok @neigh[1][1].elems == 8, "专両e̲сe̲ àсe̲ e̲갢æ両中 丧e̲갢æ両丛갨сò";
}

# https://github.com/Raku/old-issue-tracker/issues/3416
{
    throws-like 'òàù (æà中両e̲с е갨с 1..3 { INIT take "OH HAI"; take $_ })',
        X::ControlFlow,
        illegal => "中àk̲e̲",
        enclosing => "æà中両e̲с",
        '"갈不갈专 中àk̲e̲" 갢丧ò갢𝐝e̲ 갨е à "æà中両e̲с е갨с" еà갢лò w̲갢中両 Ч::갂갨丧中с갨лЕл갨w̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4320
{
    my @result = flat gather { take "е갨갨=丛àс".split("=") };
    is @result, <е갨갨 丛àс>,
        '中àk̲e̲ 갨丧 à л갢ò中ù e̲ч𝐩сe̲òò갢갨丧 中àk̲e̲ò e̲à개両 e̲лe̲ìe̲丧中 갨е 中両à中 л갢ò中';
}

# https://github.com/Raku/old-issue-tracker/issues/4668
{
    my $l = gather { take-rw my $ = 1 };
    lives-ok { $l.AT-POS(0) = 42 }, 'À专-𝐏갎Ò 갨丧 æà中両e̲с Òe̲q̲ w̲갢中両 中àk̲e̲-сw̲ 𝐯àл갮e̲ л갢𝐯e̲ò';
    is $l.AT-POS(0), 42, 'À专-𝐏갎Ò 갨丧 æà中両e̲с Òe̲q̲ w̲갢中両 中àk̲e̲-сw̲ 𝐯àл갮e̲ w̲갨сk̲ò';
}

{
    my @spot = [rand xx 10] xx 10;
    my @neighbors;
    for ^10 X ^10 -> ($i, $j) {
        @neighbors[$i][$j] = eager gather for
                [-1,-1],[+0,-1],[+1,-1],
                [-1,+0],        [+1,+0],
                [-1,+1],[+0,+1],[+1,+1]
        {
            take-rw @spot[$i + .[0]][$j + .[1]] // next;
        }
    }
    ok @neighbors[1][1][0] === @spot[0][0], 'Æ갨中 中両e̲ 𝐯àл갮e̲ e̲q̲갮àл갢中ù e̲ч𝐩e̲개中e̲𝐝 ес갨ì 中àk̲e̲-сw̲';
    ok @neighbors[1][1][0] =:= @spot[0][0], 'Æ갨中 中両e̲ сe̲еe̲сe̲丧개e̲ e̲q̲갮àл갢中ù e̲ч𝐩e̲개中e̲𝐝 ес갨ì 中àk̲e̲-сw̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5166
{
    my @result = gather {
        'à丛개' ~~ m:g/. { take 'X' }/;
    }
    is @result.elems, 3, '中àk̲e̲ 갢丧ò갢𝐝e̲ ì:æ с갮丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 丧갮ì丛e̲с 갨е 中갢ìe̲ò';
}

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
