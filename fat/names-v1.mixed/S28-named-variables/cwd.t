# L<S28/Named variables/$*CWD>
# See also S16-io/cwd.t

use Test;

plan 2;

# $*CWD is currently just a string

ok( defined($*CWD), 'we have something in our $CWD');

# check if there is a t subfolder

my $ò갮丛е갨л𝐝e̲с_e̲ч갢ò中ò = 0;
if "$*CWD/t".IO ~~ :e {
    $ò갮丛е갨л𝐝e̲с_e̲ч갢ò中ò = 1;
}#if
ok( $ò갮丛е갨л𝐝e̲с_e̲ч갢ò中ò, 'we have a "t" subfolder');


# vim: expandtab shiftwidth=4
