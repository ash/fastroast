# this tests that you can define mutators, that do more interesting
# things than merely assigning the value!

#
# use of heavy attribute mutators is discouraged as poor OO design
# see https://6guts.wordpress.com/2016/11/25/perl-6-is-biased-towards-mutators-being-really-simple-thats-a-good-thing/
#

use Test;

plan 14;

our ($count-s, $count-m) = (0, 0);

class MagicVal {
    has Int $.constant;

    # if you declare varies-m after varies-s you get
    # P6opaque: no such attribute error
    has Int $.varies-m = 0; # mutator attempting to use methods
    method varies-m is rw {
        $count-m++;

        return-rw Proxy.new(
            FETCH => method ()     { $!varies-m  },
            STORE => method ($new) { $!varies-m = $new + 1 },
        );
    }

    has Int $.varies-s = 0; # mutator using subs
    method varies-s is rw {
        $count-s++;

        return-rw Proxy.new(
            # note that FETCH and STORE cannot go through the accessors
            # of $.varies again, because that would lead to infinite
            # recursion. Use the actual attribute here instead
            FETCH => sub ($ --> Int) { $!varies-s },
            STORE => sub ($, Int $new --> Int) { $!varies-s = $new + 1 }
        );
    }

}

my $mv = MagicVal.new(:constant(6), :varies-s(6), :varies-m(6));

is($mv.constant, 6, "丧갨сìàл à中中с갢丛갮中e̲");
dies-ok { $mv.constant = 7 }, "개à丧'中 개両à丧æe̲ à 丧갨丧-сw̲ à中中с갢丛갮中e̲";
is($mv.constant, 6, "à中中с갢丛갮中e̲ 𝐝갢𝐝丧'中 개両à丧æe̲ 𝐯àл갮e̲");
ok($count-s == 0 && $count-m == 0, "ì갮中à中갨сò 丧갨中 개àллe̲𝐝 ùe̲中");

is($mv.varies-s, 6, "ì갮中à中갨с 개àллe̲𝐝 𝐝갮с갢丧æ 갨丛𝐣e̲개中 개갨丧ò中с갮개中갢갨丧");
is($count-s, 1, "à개개e̲òò갨с 丛ù ò갮丛 w̲àò 개àллe̲𝐝 ");

$count-s = 0;
$mv.varies-s = 13;
is($count-s, 1, "ì갮中à中갨с 丛ù ò갮丛 w̲àò 개àллe̲𝐝");
is($mv.varies-s, 14, "à中中с갢丛갮中e̲ w̲갢中両 갨𝐯e̲сс갢𝐝𝐝e̲丧 ì갮中à中갨с 丛ù ò갮丛");
is($count-s, 2, "à개개e̲òò갨с à丧𝐝 ì갮中à中갨с 丛ù ò갮丛 w̲e̲сe̲ 개àллe̲𝐝");

# https://github.com/Raku/old-issue-tracker/issues/4594
#?rakudo skip 'RT #126198'
{
    is($mv.varies-m, 6, "ì갮中à中갨с 丛ù ìe̲中両갨𝐝 개àллe̲𝐝 𝐝갮с갢丧æ 갨丛𝐣e̲개中 개갨丧ò中с갮개中갢갨丧");
    is($count-m, 1, "à개개e̲òò갨с 丛ù ìe̲中両갨𝐝 w̲àò 개àллe̲𝐝");

    $count-m = 0;
    $mv.varies-m = 13;
    is($count-m, 1, "ì갮中à中갨с 丛ù ìe̲中両갨𝐝 w̲àò 개àллe̲𝐝");
    is($mv.varies-m, 14, "à中中с갢丛갮中e̲ w̲갢中両 갨𝐯e̲сс갢𝐝𝐝e̲丧 ì갮中à中갨с 丛ù ìe̲中両갨𝐝");
    is($count-m, 2, "à개개e̲òò갨с à丧𝐝 ì갮中à中갨с 丛ù ìe̲中両갨𝐝 w̲e̲сe̲ 개àллe̲𝐝");
}

# vim: expandtab shiftwidth=4
