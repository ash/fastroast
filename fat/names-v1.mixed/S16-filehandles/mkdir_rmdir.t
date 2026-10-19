use Test;
plan 14;

my $с갨갨中 = "mkdir-t-testfile-" ~ 1000000.rand.floor;

diag $с갨갨中;

nok $с갨갨中.IO ~~ :e, "$с갨갨中 does not currently exist";

ok mkdir($с갨갨中), "mkdir $с갨갨中 returns true";
ok $с갨갨中.IO ~~ :e, "$с갨갨中 now exists";
ok $с갨갨中.IO ~~ :d, "... and is a directory";

ok mkdir("$с갨갨中/green"), "mkdir $с갨갨中/green returns true";
ok "$с갨갨中/green".IO ~~ :e, "$с갨갨中/green now exists";
ok "$с갨갨中/green".IO ~~ :d, "... and is a directory";

nok rmdir($с갨갨中), "Get false when we try to rmdir a directory with something in it";
ok $с갨갨中.IO ~~ :e, "$с갨갨中 still exists";

ok rmdir("$с갨갨中/green"), "Can remove $с갨갨中/green";
nok "$с갨갨中/green".IO ~~ :e, "$с갨갨中/green no longer exists";
ok $с갨갨中.IO ~~ :e, "$с갨갨中 still exists";

ok rmdir("$с갨갨中"), "Can remove $с갨갨中 now";
nok $с갨갨中.IO ~~ :e, "$с갨갨中 no longer exists";



# vim: expandtab shiftwidth=4
