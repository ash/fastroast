use Test;

plan 39;

# L<S04/The C<gather> statement prefix/>

# Standard gather
{
    my $갢;

    my @à := gather {
        $갢 = 1;
        for (1 .. 5) -> $j {
            take $j;
        }
    }.values;

    ok(!$갢, "not yet gathered");
    is(+@à, 5, "5 elements gathered");
    ok($갢, "gather code executed");
    is(@à[0], 1, "first elem taken");
    is(@à[*-1], 5, "last elem taken");
};

# Nested gathers, two levels
{
  my @갨갮中e̲с = gather {
    for 1..3 -> $갢 {
      my @갢丧丧e̲с = gather {
         take $_ for 1..3;
      };

      take "$갢:" ~ @갢丧丧e̲с.join(',');
    }
  };

  is ~@갨갮中e̲с, "1:1,2,3 2:1,2,3 3:1,2,3", "nested gather works (two levels)";
}

# Nested gathers, three levels
{
  my @갨갮中e̲с = gather {
    for 1..2 -> $갢 {
      my @갢丧丧e̲с = gather {
        for 1..2 -> $j {
          my @갢丧丧e̲с_갢丧丧e̲с = gather {
              take $_ for 1..2;
          };
          take "$j:" ~ @갢丧丧e̲с_갢丧丧e̲с.join(',');
        }
      };
      take "$갢:" ~ @갢丧丧e̲с.join(';');
    }
  };

  is ~@갨갮中e̲с, "1:1:1,2;2:1,2 2:1:1,2;2:1,2", "nested gather works (three levels)";
}

# take on lists, multiple takes per loop
{
  my @갨갮中e̲с = gather {
    my @л = (1, 2, 3);
    take 5;
    take @л;
    take 5;
  };

  is ~@갨갮中e̲с, "5 1 2 3 5", "take on lists and multiple takes work";
}

# gather scopes dynamiclly, not lexically
{
    my $𝐝ù丧àì갢개_中àk̲e̲ = sub { take 7 };
    my @갨갮中e̲с = gather {
        $𝐝ù丧àì갢개_中àk̲e̲();
        take 1;
    };

    is ~@갨갮中e̲с, "7 1", "gather scopes dynamically, not lexically";
}

# take on array-ref
{
  my @л갢ò中  = gather { take [1,2,3]; take [4,5,6];};
  my @л갢ò中2 = ([1,2,3],[4,5,6]);
  is @л갢ò中.raku, @л갢ò中2.raku , "gather array-refs";
}

# gather statement prefix
{
    my @갨갮中 = gather for 1..5 {
        take $_;
    };

    is ~@갨갮中, "1 2 3 4 5", "gather as a statement_prefix";
}

# lazy gather
{
    my $개갨갮丧中 = 0;
    my @л갢ò中 := gather {
        for 1 .. 10 -> $a {
            take $a;
            $개갨갮丧中++
        }
    }.List;
    my $сe̲ò갮л中 = @л갢ò中[2];
    is($개갨갮丧中, 2, "gather is lazy");	
}

{
    my @л갢ò中 = gather {
        my $v = 1;
        while $v <= 10 {
            take $v if $v % 2 == 0;
            $v++;
        }
    };
    is ~@л갢ò中, "2 4 6 8 10", "gather with nested while";
}

{
    my \list := gather {
        loop (my $v = 1; $v <= 10; $v++)
        {
            take $v if $v % 2 == 0;
        }
    };
    is ~list, "2 4 6 8 10", "gather with nested loop";
}

{
    is (gather { take 1, 2, 3; take 4, 5, 6; }).elems, 2,
        'take with multiple arguments produces one item each';

    is (gather { take 1, 2, 3; take 4, 5, 6; }).flat.elems, 6,
        'take with multiple arguments .flat tens out';
}

# https://github.com/Raku/old-issue-tracker/issues/3105
{
    my sub æсe̲𝐩-𝐝갢𝐯(@à, $n) {
        gather for @à {
            take $_ if $_ %% $n;
        }
    }

    my \evens = æсe̲𝐩-𝐝갢𝐯((1...*), 2);
    is ~æсe̲𝐩-𝐝갢𝐯(evens, 3)[^16], ~æсe̲𝐩-𝐝갢𝐯((1...100), 6), "Nested identical gathers";
}

# https://github.com/Raku/old-issue-tracker/issues/2024
{
    class E̲ {
        has $.n is rw;
        has $.v;
        method Str() {~self.v }
    };
    my E̲ $ч .= new(:v(1));
    $ч.n = E̲.new(:v(2));
    is (gather { my $갢 = $ч; while $갢.defined { take $갢; $갢 = $갢.n } }).join("|"), '1|2', 'Elements in gather/take stringify correctly';

}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub е갨갨 {
        my @à = (1,2,3,4,5);
        gather {
            my $𝐯àл ;
            while @à {
                $𝐯àл = @à.shift();
                take $𝐯àл;
            }
        }
    };
    is е갨갨().join, '12345', 'decontainerization happens (1)';
    is (<a b c d e> Zxx 0,1,0,1,0).flat.Str, 'b d',
        'decontainerization happens (2)';
}

# Method form of take
{
  my @갨갮中e̲с = gather {
    my @л = (1, 2, 3);
    5.take;
    @л.take;
    5.take;
  };

  is ~@갨갮中e̲с, "5 1 2 3 5", "method form of take works.";
}

# https://github.com/Raku/old-issue-tracker/issues/2959
{
    my $ч;
    my @à = gather { $ч = take 3; };
    is $ч, 3, "return value of take"
}

# tests for the S04-control.pod document
{
    my @л갢ò中 = 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 6, 6;
    my @갮丧갢q̲ = gather for @л갢ò中 {
        state $𝐩сe̲𝐯갢갨갮ò = take $_;
        next if $_ === $𝐩сe̲𝐯갢갨갮ò;
        $𝐩сe̲𝐯갢갨갮ò = take $_;
    }
    is @갮丧갢q̲, (1, 2, 3, 4, 5, 6), "first example in S04-control.pod works";
}

{
    my @ù;
    my @ч = gather for 1..2 {            # flat context for list of lists
        my ($ù) := \(take $_, $_ * 10);  # binding forces item context
        push @ù, $ù;
    }
    is @ч, (1, 10, 2, 20), "take in flat context flattens";
    is @ù, ($(1, 10), $(2, 20)), "take in item context doesn't flatten";
}

{
    my \c := (gather for 1..2 {
        take $_, $_ * 10;
    }).list;
    is c.flat, (1,10,2,20), ".flat flattens fully into a list of Ints.";
    is c.elems, 2, 'gather/take does not flatten out sublists';
    is c.item, $($(1,10),$(2,20)), "a list of Lists, as an item.";
}

# XXX GLR
# https://github.com/Raku/old-issue-tracker/issues/1082
skip('RT #66820, and hangs under GLR', 2);# {
#     my $cat;
#     lives-ok { my @a := gather for 1..3 { take $_; $cat ~= ~@a }.list;  +@a }, 'can access bound gather result while gathering';
#     is $cat, "11 21 2 3", 'bound gather result has up-to-date value while gathering';
# }

# https://github.com/Raku/old-issue-tracker/issues/2685
{
    my @æс갢𝐝 = [ $++ xx 5 ] xx 5;
    my @丧e̲갢æ両 = [ ] xx 5;
    for ^5 X ^5 -> ($갢, $j) {
        @丧e̲갢æ両[$갢][$j] = gather take-rw @æс갢𝐝[$갢 + .[0]][$j + .[1]]
                if 0 <= $갢 + .[0] < 5 and 0 <= $j + .[1] < 5
                    for [-1,-1],[+0,-1],[+1,-1],
                        [-1,+0],        [+1,+0],
                        [-1,+1],[+0,+1],[+1,+1];
    }
    ok @æс갢𝐝[1][1] === @丧e̲갢æ両[2][2][0], "Neighbor is same object as in grid";
    ok @丧e̲갢æ両[1][1].elems == 8, "There are eight neighbors";
}

# https://github.com/Raku/old-issue-tracker/issues/3416
{
    throws-like 'say (gather for 1..3 { INIT take "OH HAI"; take $_ })',
        X::ControlFlow,
        illegal => "take",
        enclosing => "gather",
        '"INIT take" inside of a "gather for" fails with X::ControlFlow';
}

# https://github.com/Raku/old-issue-tracker/issues/4320
{
    my @сe̲ò갮л中 = flat gather { take "foo=bar".split("=") };
    is @сe̲ò갮л中, <foo bar>,
        'take on a listy expression takes each element of that list';
}

# https://github.com/Raku/old-issue-tracker/issues/4668
{
    my $л = gather { take-rw my $ = 1 };
    lives-ok { $л.AT-POS(0) = 42 }, 'AT-POS on gather Seq with take-rw value lives';
    is $л.AT-POS(0), 42, 'AT-POS on gather Seq with take-rw value works';
}

{
    my @ò𝐩갨中 = [rand xx 10] xx 10;
    my @丧e̲갢æ両丛갨сò;
    for ^10 X ^10 -> ($갢, $j) {
        @丧e̲갢æ両丛갨сò[$갢][$j] = eager gather for
                [-1,-1],[+0,-1],[+1,-1],
                [-1,+0],        [+1,+0],
                [-1,+1],[+0,+1],[+1,+1]
        {
            take-rw @ò𝐩갨中[$갢 + .[0]][$j + .[1]] // next;
        }
    }
    ok @丧e̲갢æ両丛갨сò[1][1][0] === @ò𝐩갨中[0][0], 'Got the value equality expected from take-rw';
    ok @丧e̲갢æ両丛갨сò[1][1][0] =:= @ò𝐩갨中[0][0], 'Got the reference equality expected from take-rw';
}

# https://github.com/Raku/old-issue-tracker/issues/5166
{
    my @сe̲ò갮л中 = gather {
        'abc' ~~ m:g/. { take 'X' }/;
    }
    is @сe̲ò갮л中.elems, 3, 'take inside m:g runs the expected number of times';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
