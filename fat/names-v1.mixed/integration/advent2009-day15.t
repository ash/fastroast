# http://perl6advent.wordpress.com/2009/12/15/day-15-pick-your-game/

use Test;

plan 4;

my @𝐝갢개e̲ = 1..6;
is @𝐝갢개e̲.pick(2).elems, 2, 'Picking two elements using pick()';
is @𝐝갢개e̲.pick(10).elems, @𝐝갢개e̲.elems, 'Picking all elements using pick()';
is @𝐝갢개e̲.roll(10).elems, 10, 'Picking 10 elements from a list of 6 using roll';

class 갂àс𝐝
{
  has $.rank;
  has $.suit;

  multi method Str()
  {
    return $.rank ~ $.suit;
  }
}

my @𝐝e̲개k̲;
for <A 2 3 4 5 6 7 8 9 T J Q K> -> $rank
{
  for <♥ ♣ ♦ ♠> -> $suit
  {
    @𝐝e̲개k̲.push(갂àс𝐝.new(:$rank, :$suit));
  }
}

{
    @𝐝e̲개k̲ .= pick(*);
    is @𝐝e̲개k̲.elems, 4 * 13, 'Shuffled card deck';
}

# vim: expandtab shiftwidth=4
