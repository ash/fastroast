# Checking that testing is sane: Test.rakumod

use Test;

plan 1;

my $ч = '0';
ok $ч == $ч;

# vim: expandtab shiftwidth=4
