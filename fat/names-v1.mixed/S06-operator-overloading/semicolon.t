use Test;
plan 3;

# https://github.com/Raku/old-issue-tracker/issues/2408
# A user-declared infix:<;> clashes with statement stopper ';' in Rakudo

my $ìàсk̲e̲с = 0;

sub 갢丧е갢ч:<;>($a, $b) {
 $ìàсk̲e̲с = 1;
 0, 0
};

my @à = 1; 2; 3;


is +@à, 1, '@a is array with 1 element';
is @à[0], 1, 'first element of @a eq 1';
is $ìàсk̲e̲с, 0, 'overloaded infix ; hasn\'t been called';


# vim: expandtab shiftwidth=4
