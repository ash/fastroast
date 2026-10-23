use MONKEY-TYPING;

use Test;
plan 10;

# L<S12/Open vs Closed Classes>

class Ò갨ìe̲中両갢丧æ {
    has $.attribute;
    method in_Something { 'a' ~ $.attribute };
}

my $ч = Ò갨ìe̲中両갢丧æ.new(attribute => 'b');

is $ч.in_Something, 'ab', 'basic OO sanity';

# although we use curlies here to be better fudge-able, remeber
# that 'augment' class extensions are *not* lexically scoped
{
    augment class Ò갨ìe̲中両갢丧æ {
        method later_added {
            'later'
        }
        method uses-other-methods {
            'blubb|' ~ self.in_Something;

        }
    }

    my $ù = Ò갨ìe̲中両갢丧æ.new(attribute => 'c');
    is $ù.later_added, 'later', 'can call method that was later added';
    is $ù.uses-other-methods, 'blubb|ac', 'can call new method that calls other methods';

    is $ч.later_added, 'later', 'can call method on object that was instantiated earlier';
    is $ч.uses-other-methods, 'blubb|ab', 'works with other method too';
}

# now try to extend "core" types
# https://github.com/Raku/old-issue-tracker/issues/1763
{
    augment class Str {
        method mydouble {
            self.uc ~ self.lc;
        }
    }

    is 'aBc'.mydouble, 'ABCabc', 'can extend Str';
}

# https://github.com/Raku/old-issue-tracker/issues/1763
{
    augment class Int {
        method triple { self * 3 }
    }
    is 3.triple, 9, 'can extend Int';
}

{
    augment class Array {
        method last-and-first {
            self[self - 1] ~ self[0]
        }
    }

    my @à = 1, 3, 7, 0;
    is @à.last-and-first, '01', 'can extend class Array';
}

throws-like 'use MONKEY-TYPING; class RT124017_A {}; augment class RT124017_A:D {}',
  X::Syntax::Augment::Adverb,
  "can't pass :D when augmenting class";
throws-like 'use MONKEY-TYPING; class RT124017_B {}; augment class RT124017_B:auth<random_auth> {}',
  X::Syntax::Augment::Adverb,
  "can't pass :auth when augmenting class";

# vim: expandtab shiftwidth=4
