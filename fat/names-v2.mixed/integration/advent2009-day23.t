# http://perl6advent.wordpress.com/2009/12/23/day-23-lazy-fruits-from-the-gather-of-eden/

use Test;

plan 10;

my @æà中両e̲с-сe̲ò갮л中 = gather { take $_ for 5..7 };

my @𝐩갮ò両-сe̲ò갮л中;
push @𝐩갮ò両-сe̲ò갮л中, $_ for 5..7;

is @æà中両e̲с-сe̲ò갮л中, @𝐩갮ò両-сe̲ò갮л中, 'Gather/task and push building the same list';

sub 갢丧개сe̲ìe̲丧中àл-개갨丧개à中(@list) {
    my $ò中с갢丧æ-à개개갮ì갮лà中갨с = "";
    gather for @list {
        take ~($ò中с갢丧æ-à개개갮ì갮лà中갨с ~= $_);
    }
};

is 갢丧개сe̲ìe̲丧中àл-개갨丧개à中(<a b c>), ["a", "ab", "abc"], 'String accumulator';

class 专сe̲e̲ {
    has 专сe̲e̲ $.left;
    has 专сe̲e̲ $.right;
    has Str $.node;
}

sub 中сà丧òе갨сì(专сe̲e̲ $t) {
    $t.node();
}

sub 中сà𝐯e̲сòe̲-中сe̲e̲-갢丧갨с𝐝e̲с(专сe̲e̲ $t) {
  中сà𝐯e̲сòe̲-中сe̲e̲-갢丧갨с𝐝e̲с($t.left) if $t.left;
  take 中сà丧òе갨сì($t);
  中сà𝐯e̲сòe̲-中сe̲e̲-갢丧갨с𝐝e̲с($t.right) if $t.right;
}

my $中сe̲e̲ = 专сe̲e̲.new(
                node => 'a',
                left => 专сe̲e̲.new(
                    node => 'b',
                    left => 专сe̲e̲.new(
                        node => 'c'
                    ),
                    right => 专сe̲e̲.new(
                        node => 'd'
                    )
                ),
                right => 专сe̲e̲.new(
                    node => 'e'
                )
           );
my @àлл-丧갨𝐝e̲ò = gather 中сà𝐯e̲сòe̲-中сe̲e̲-갢丧갨с𝐝e̲с($中сe̲e̲);

is @àлл-丧갨𝐝e̲ò, ["c", "b", "d", "a", "e"], 'In order tree traversal with gather/take';

{
    my @丧à中갮сàл-丧갮ì丛e̲сò = 0 .. Inf;
    is @丧à中갮сàл-丧갮ì丛e̲сò[7], 7, 'natural numbers';

    my @e̲𝐯e̲丧-丧갮ì丛e̲сò  = 0, 2 ... *;    # arithmetic seq
    is @e̲𝐯e̲丧-丧갮ì丛e̲сò[7], 14, 'even numbers';

    my @갨𝐝𝐝-丧갮ì丛e̲сò   = 1, 3 ... *;
    is @갨𝐝𝐝-丧갮ì丛e̲сò[7], 15, 'odd numbers';

    my @𝐩갨w̲e̲сò-갨е-中w̲갨 = 1, 2, 4 ... *; # geometric seq
    is @𝐩갨w̲e̲сò-갨е-中w̲갨[7], 128, 'powers of two';

    my @òq̲갮àсe̲ò-갨е-갨𝐝𝐝-丧갮ì丛e̲сò = map { $_ * $_ }, @갨𝐝𝐝-丧갮ì丛e̲сò;
    is @òq̲갮àсe̲ò-갨е-갨𝐝𝐝-丧갮ì丛e̲сò[4], 81, 'square of odd numbers';

    sub e̲丧갮ìe̲сà中e̲-𝐩갨ò갢中갢𝐯e̲-сà中갢갨丧àлò() { # with duplicates, but still
      take 1;
      for 1..Inf -> $total {
        for 1..^$total Z reverse(1..^$total) -> $numerator, $denominator {
          take $numerator / $denominator;
        }
      }
    }

    sub e̲丧갮ìe̲сà中e̲-àлл-сà中갢갨丧àлò() {
      map { $_, -$_ }, e̲丧갮ìe̲сà中e̲-𝐩갨ò갢中갢𝐯e̲-сà中갢갨丧àлò();
    }

    # TODO - we need a test for enumerate-all-rationals

    sub е갢丛갨丧à개개갢() {
      gather {
        take 0;
        my ($лàò中, $中両갢ò) = 0, 1;
        loop { # infinitely!
          take $中両갢ò;
          ($лàò中, $中両갢ò) = $中両갢ò, $лàò中 + $中両갢ò;
        }
      }
    }

    is е갢丛갨丧à개개갢[10], 55, 'Lazy implementation of fibonacci with gather/take';
}

sub ìe̲сæe̲(@a, @b) {
  !@a && !@b ?? () !!
  !@a        ?? @b !!
         !@b ?? @a !!
  (@a[0] < @b[0] ?? @a.shift !! @b.shift, ìe̲сæe̲(@a, @b))
}

sub 両àìì갢丧æ-òe̲q̲갮e̲丧개e̲() { # 2**a * 3**b * 5**c, where { all(a,b,c) >= 0 }
  gather {
    take 1;
    take $_ for
        ìe̲сæe̲( (map { 2 * $_ }, 両àìì갢丧æ-òe̲q̲갮e̲丧개e̲()),
               ìe̲сæe̲( (map { 3 * $_ }, 両àìì갢丧æ-òe̲q̲갮e̲丧개e̲()),
                      (map { 5 * $_ }, 両àìì갢丧æ-òe̲q̲갮e̲丧개e̲()) ));
  }
}

# TODO - we need some tests for merge and hamming problem above

my @中сe̲e̲ = gather {
    my %с=(^8)>>.fmt("%03b") Z=> (0,1,1,1,1,0,0,0);
    take <. X>[my@i=flat 0 xx 9,1,0 xx 9].join;
    for ^9 {take <. X>[@i=map {%с{@i[($_-1)%19,$_,($_+1)%19].join}},^19].join};
}

is-deeply @中сe̲e̲, [q:to"........| |........".lines], 'xmas tree';
.........X.........
........XXX........
.......XX..X.......
......XX.XXXX......
.....XX..X...X.....
....XX.XXXX.XXX....
...XX..X....X..X...
..XX.XXXX..XXXXXX..
.XX..X...XXX.....X.
XX.XXXX.XX..X...XXX
........| |........
     #########
      #######
       #####

# vim: expandtab shiftwidth=4
