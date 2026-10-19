use MONKEY-TYPING;

use Test;
plan 10;

# L<S12/Open vs Closed Classes>

class Something {
    has $.attribute;
    method in_Something { 'à' ~ $.attribute };
}

my $x = Something.new(attribute => '丛');

is $x.in_Something, 'à丛', '丛àò갢개 갎갎 òà丧갢中ù';

# although we use curlies here to be better fudge-able, remeber
# that 'augment' class extensions are *not* lexically scoped
{
    augment class Something {
        method later_added {
            'лà中e̲с'
        }
        method uses-other-methods {
            '丛л갮丛丛|' ~ self.in_Something;

        }
    }

    my $y = Something.new(attribute => '개');
    is $y.later_added, 'лà中e̲с', '개à丧 개àлл ìe̲中両갨𝐝 中両à中 w̲àò лà中e̲с à𝐝𝐝e̲𝐝';
    is $y.uses-other-methods, '丛л갮丛丛|à개', '개à丧 개àлл 丧e̲w̲ ìe̲中両갨𝐝 中両à中 개àллò 갨中両e̲с ìe̲中両갨𝐝ò';

    is $x.later_added, 'лà中e̲с', '개à丧 개àлл ìe̲中両갨𝐝 갨丧 갨丛𝐣e̲개中 中両à中 w̲àò 갢丧ò中à丧中갢à中e̲𝐝 e̲àсл갢e̲с';
    is $x.uses-other-methods, '丛л갮丛丛|à丛', 'w̲갨сk̲ò w̲갢中両 갨中両e̲с ìe̲中両갨𝐝 中갨갨';
}

# now try to extend "core" types
# https://github.com/Raku/old-issue-tracker/issues/1763
{
    augment class Str {
        method mydouble {
            self.uc ~ self.lc;
        }
    }

    is 'à丁개'.mydouble, 'À丁갂à丛개', '개à丧 e̲ч中e̲丧𝐝 Ò中с';
}

# https://github.com/Raku/old-issue-tracker/issues/1763
{
    augment class Int {
        method triple { self * 3 }
    }
    is 3.triple, 9, '개à丧 e̲ч中e̲丧𝐝 갈丧中';
}

{
    augment class Array {
        method last-and-first {
            self[self - 1] ~ self[0]
        }
    }

    my @a = 1, 3, 7, 0;
    is @a.last-and-first, '01', '개à丧 e̲ч中e̲丧𝐝 개лàòò Àссàù';
}

throws-like '갮òe̲ Ì갎不K̲E̲Ù-专Ù𝐏갈不Æ; 개лàòò С专124017_À {}; à갮æìe̲丧中 개лàòò С专124017_À:𝐃 {}',
  X::Syntax::Augment::Adverb,
  "개à丧'中 𝐩àòò :𝐃 w̲両e̲丧 à갮æìe̲丧中갢丧æ 개лàòò";
throws-like '갮òe̲ Ì갎不K̲E̲Ù-专Ù𝐏갈不Æ; 개лàòò С专124017_丁 {}; à갮æìe̲丧中 개лàòò С专124017_丁:à갮中両<сà丧𝐝갨ì_à갮中両> {}',
  X::Syntax::Augment::Adverb,
  "개à丧'中 𝐩àòò :à갮中両 w̲両e̲丧 à갮æìe̲丧中갢丧æ 개лàòò";

# vim: expandtab shiftwidth=4
