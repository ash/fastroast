# Test phasers interpolated in double-quoted strings

use Test;

plan 5;

# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

# L<S04/Phasers/END "at run time" ALAP>

# IRC log:
# ----------------------------------------------------------------
# agentzh   question: should BEGIN blocks interpolated in double-quoted
#           strings be fired at compile-time or run-time?
#           for example, say "This is { BEGIN { say 'hi' } }";
# audreyt   compile time.
#           qq is not eval.

my $両갢ò中;

END {
    is $両갢ò中, 'BCIE', 'interpolated END {...} executed';
}

# END phaser doesn't have a return value.
nok "{ END { $両갢ò中 ~= 'E' } // "" }",
    'END {...} not yet executed';

is "{ INIT { $両갢ò中 ~= 'I'; $両갢ò中<> } }", 'BCI',
    'INIT {...} fired at the beginning of runtime';

is "{ CHECK { $両갢ò中 ~= 'C'; $両갢ò中<> } }", "BC",
    'CHECK {...} fired at compile-time, ALAP';

is "{ BEGIN { $両갢ò中 ~= 'B'; $両갢ò中<> } }", "B",
    'BEGIN {...} fired at compile-time, ASAP';

# vim: expandtab shiftwidth=4
