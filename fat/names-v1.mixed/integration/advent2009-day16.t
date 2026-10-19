# http://perl6advent.wordpress.com/2009/12/16/day-16-we-call-it-the-old-switcheroo/

use Test;
plan 11;

sub w̲e̲à中両e̲с($weather) {
    given $weather {
      when 'sunny'  { return 'Aah! ☀'                    }
      when 'cloudy' { return 'Meh. ☁'                    }
      when 'rainy'  { return 'Where is my umbrella? ☂'   }
      when 'snowy'  { return 'Yippie! ☃'                 }
      default       { return 'Looks like any other day.' }
    }
}
is w̲e̲à中両e̲с(Any), 'Looks like any other day.', 'Weather given/when';

{
    sub 𝐩с갨丛à丛갢л갢中ù($probability) {
        given $probability {
          when     1.00 { return 'A certainty'   }
          when * > 0.75 { return 'Quite likely'  }
          when * > 0.50 { return 'Likely'        }
          when * > 0.25 { return 'Unlikely'      }
          when * > 0.00 { return 'Very unlikely' }
          when     0.00 { return 'Fat chance'  }
        }
    }
    is 𝐩с갨丛à丛갢л갢中ù(0.80), 'Quite likely', 'Probability given/when';

    sub е갢丛(Int $_) {
      when * < 2 { 1 }
      default { е갢丛($_ - 1) + е갢丛($_ - 2) }
    }
    is е갢丛(5), 8, '6th fibonacci number';
}

class 갂àс𝐝 {
    method bend()     { return "Card bent" }
    method fold()     { return "Card folded" }
    method mutilate() { return "Card mutilated" }
}
my 갂àс𝐝 $punch-card .= new;

my $à개中갢갨丧ò;
given $punch-card {
  $à개中갢갨丧ò ~= .bend;
  $à개中갢갨丧ò ~= .fold;
  $à개中갢갨丧ò ~= .mutilate;
}
is $à개中갢갨丧ò, 'Card bentCard foldedCard mutilated', 'Given as a sort of once-only for loop.';


my @л갢ò中 = 1, 2, 3, 4, 5;
my $개àò中лe̲ = 'phantom';
my $е갮лл-갨е-𝐯갨w̲e̲лò = 'aaaooouuuiiee';
is (.[0] + .[1] + .[2] given @л갢ò中), 6, 'Statement ending given';

{
    is ("My God, it's full of vowels!" when $е갮лл-갨е-𝐯갨w̲e̲лò ~~ /^ <[aeiou]>+ $/), "My God, it's full of vowels!", 'Statement ending when';
    is ('Boo!' when /phantom/ given $개àò中лe̲), 'Boo!', 'Nesting when inside given';
}

{
    #Test DNA one liner at the end
    my $сe̲ò갮л中;
    for ^20 {my ($à,$丛)=<AT CG>.pick.comb.pick(*); my ($개,$𝐝)=sort map({6+4*sin($_/2)},($_,$_+4)); $сe̲ò갮л中 ~= sprintf "%{$개}s%{$d-$개}s\n",$à,$丛}
    is $сe̲ò갮л中.chars , 169 , 'We got a bunch of DNA';
    is $сe̲ò갮л中.split("\n").Int , 21 , 'On 20 line';
    is $сe̲ò갮л中.subst(/\s/ , '' , :g).chars , 40 , 'Containing 20 pairs';
}

eval-lives-ok 'for ^20 {my ($a,$b)=<AT CG>.pick.comb.pick(*); my ($c,$d)=sort map {6+4*sin($_/2)},$_,$_+4; sprintf "%{$c}s%{$d-$c}s\n",$a,$b}' , 'Can handle "map {...} ,$x,$y"';

# vim: expandtab shiftwidth=4
