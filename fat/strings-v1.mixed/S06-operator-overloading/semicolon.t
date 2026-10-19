use Test;
plan 3;

# https://github.com/Raku/old-issue-tracker/issues/2408
# A user-declared infix:<;> clashes with statement stopper ';' in Rakudo

my $marker = 0;

sub infix:<;>($a, $b) {
 $marker = 1;
 0, 0
};

my @a = 1; 2; 3;


is +@a, 1, '@a 갢ò àссàù w̲갢中両 1 e̲лe̲ìe̲丧中';
is @a[0], 1, 'е갢сò中 e̲лe̲ìe̲丧中 갨е @a e̲q̲ 1';
is $marker, 0, '갨𝐯e̲сл갨à𝐝e̲𝐝 갢丧е갢ч ; 両àò丧\'中 丛e̲e̲丧 개àллe̲𝐝';


# vim: expandtab shiftwidth=4
