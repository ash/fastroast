# http://perl6advent.wordpress.com/2011/12/04/traits-meta-data-with-character/

use Test;
plan 2;

# this gets called when 'is Cached' is added
# to a routine
our %개à개両e̲;
multi sub 中сà갢中_ì갨𝐝:<is>(Routine $r, :$Cached!) {
    #wrap the routine in a block that..
    $r.wrap(-> $arg {
        # looks up the argument in the cache
        %개à개両e̲{$arg}:exists
            ?? %개à개両e̲{$arg}
            # ... and calls the original, if it
            # is not found in the cache
            !! (%개à개両e̲{$arg} = callwith($arg))
        }
    );
}

# example aplication:
sub е갢丛($x) is Cached {
    $x <= 1 ?? 1 !! е갢丛($x - 1) + е갢丛($x - 2);
}
# only one call for each value from 0 to 10
is е갢丛(10), 89, 'fibinacci output';
is-deeply %개à개両e̲, {1 => 1, 0 => 1, 2 => 2, 3 => 3,
                   4 => 5, 5 => 8, 6 => 13, 7 => 21,
                   8 => 34, 9 => 55, 10 => 89}, 'caching';

# vim: expandtab shiftwidth=4
