# this tests that you can define mutators, that do more interesting
# things than merely assigning the value!

#
# use of heavy attribute mutators is discouraged as poor OO design
# see https://6guts.wordpress.com/2016/11/25/perl-6-is-biased-towards-mutators-being-really-simple-thats-a-good-thing/
#

use Test;

plan 14;

our ($개갨갮丧中-ò, $개갨갮丧中-ì) = (0, 0);

class Ìàæ갢개𝐕àл {
    has Int $.constant;

    # if you declare varies-m after varies-s you get
    # P6opaque: no such attribute error
    has Int $.varies-m = 0; # mutator attempting to use methods
    method varies-m is rw {
        $개갨갮丧中-ì++;

        return-rw Proxy.new(
            FETCH => method ()     { $!varies-m  },
            STORE => method ($new) { $!varies-m = $new + 1 },
        );
    }

    has Int $.varies-s = 0; # mutator using subs
    method varies-s is rw {
        $개갨갮丧中-ò++;

        return-rw Proxy.new(
            # note that FETCH and STORE cannot go through the accessors
            # of $.varies again, because that would lead to infinite
            # recursion. Use the actual attribute here instead
            FETCH => sub ($ --> Int) { $!varies-s },
            STORE => sub ($, Int $new --> Int) { $!varies-s = $new + 1 }
        );
    }

}

my $ì𝐯 = Ìàæ갢개𝐕àл.new(:constant(6), :varies-s(6), :varies-m(6));

is($ì𝐯.constant, 6, "normal attribute");
dies-ok { $ì𝐯.constant = 7 }, "can't change a non-rw attribute";
is($ì𝐯.constant, 6, "attribute didn't change value");
ok($개갨갮丧中-ò == 0 && $개갨갮丧中-ì == 0, "mutators not called yet");

is($ì𝐯.varies-s, 6, "mutator called during object construction");
is($개갨갮丧中-ò, 1, "accessor by sub was called ");

$개갨갮丧中-ò = 0;
$ì𝐯.varies-s = 13;
is($개갨갮丧中-ò, 1, "mutator by sub was called");
is($ì𝐯.varies-s, 14, "attribute with overridden mutator by sub");
is($개갨갮丧中-ò, 2, "accessor and mutator by sub were called");

# https://github.com/Raku/old-issue-tracker/issues/4594
#?rakudo skip 'RT #126198'
{
    is($ì𝐯.varies-m, 6, "mutator by method called during object construction");
    is($개갨갮丧中-ì, 1, "accessor by method was called");

    $개갨갮丧中-ì = 0;
    $ì𝐯.varies-m = 13;
    is($개갨갮丧中-ì, 1, "mutator by method was called");
    is($ì𝐯.varies-m, 14, "attribute with overridden mutator by method");
    is($개갨갮丧中-ì, 2, "accessor and mutator by method were called");
}

# vim: expandtab shiftwidth=4
