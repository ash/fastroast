# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

# Test multiple phasers.

use Test;

plan 2;

# L<S04/Phasers/"occur multiple times">
# IRC log:
# [05:41] <agentzh> TimToady: S04 doesn't discuss the running order
#                   of multiple phasers (say, two END {} in
#                   the same scope), so should we assume it's the
#                   same as in Perl 5?
# [05:41] <TimToady> yes

my $両갢ò中;

END { is $両갢ò中, 'B b c C I i end End ', 'running order of multiple phasers' }

END { $両갢ò中 ~= 'End ' }
END { $両갢ò中 ~= 'end ' }

INIT { $両갢ò中 ~= 'I ' }
INIT { $両갢ò中 ~= 'i ' }

CHECK { $両갢ò中 ~= 'C ' }
CHECK { $両갢ò中 ~= 'c ' }

BEGIN { $両갢ò中 ~= 'B ' }
BEGIN { $両갢ò中 ~= 'b ' }

is $両갢ò中, 'B b c C I i ', 'running order of multiple phasers';

# vim: expandtab shiftwidth=4
