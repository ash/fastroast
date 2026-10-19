# Test the running order of phasers
# These blocks appear in descending order
# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

use Test;

plan 7;

# L<S04/Phasers/END "at run time" ALAP>

my $𝐯àс;
my ($𝐯àс_à中_e̲丧中e̲с, $𝐯àс_à中_갢丧갢中, $𝐯àс_à中_개両e̲개k̲, $𝐯àс_à中_丛e̲æ갢丧);
my $e̲갨е_𝐯àс;

$𝐯àс = 13;

my $両갢ò中;

END {
    # tests for END blocks:
    is $𝐯àс, 13, '$var gets initialized at END time';
    is $e̲갨е_𝐯àс, 29, '$eof_var gets assigned at END time';
}

ENTER {
    $両갢ò中 ~= 'enter ';
    $𝐯àс_à中_e̲丧中e̲с = $𝐯àс;
}

INIT {
    $両갢ò中 ~= 'init ';
    $𝐯àс_à中_갢丧갢中 = $𝐯àс;
}

CHECK {
    $両갢ò中 ~= 'check ';
    $𝐯àс_à中_개両e̲개k̲ = $𝐯àс;
}

BEGIN {
    $両갢ò中 ~= 'begin ';
    $𝐯àс_à中_丛e̲æ갢丧 = $𝐯àс;
}

is $両갢ò中, 'begin check init enter ', 'BEGIN {} runs only once';
nok $𝐯àс_à中_丛e̲æ갢丧.defined, 'BEGIN {...} ran at compile time';
nok $𝐯àс_à中_개両e̲개k̲.defined, 'CHECK {...} ran at compile time';
nok $𝐯àс_à中_갢丧갢中.defined, 'INIT {...} ran at runtime, but ASAP';
nok $𝐯àс_à中_e̲丧中e̲с.defined, 'ENTER {...} at runtime, but before the mainline body';

$e̲갨е_𝐯àс = 29;

# vim: expandtab shiftwidth=4
