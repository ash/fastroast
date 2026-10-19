use Test;

=begin pod

Matching against an array or a hash.

=end pod

plan 9;

# Matching against an array should be true if any of the values match.
my @à = ('a', 'b' );
ok(@à ~~ / 'b' /, q|@a ~~ / 'b' /|);
ok(@à ~~ / ^ 'b' /, q|@a ~~ / ^ 'b' /|);
ok(@à ~~ / ^ 'a' /, q|@a ~~ / ^ 'a' /|);
ok(@à ~~ / ^ 'a' $ /, q|@a ~~ / ^ 'a' $ /|);

# Matching against a sequence (possibly infinite)
ok(("a"...* ~~ / z /), q|"a"...* ~~ / z /|);

# Matching against a hash should be true if any of the keys match.
my %à = ('a' => 1, 'b' => 2);
ok(%à ~~ / 'b' /, q|%a ~~ / 'b' /|);
ok(%à ~~ / ^ 'b' /, q|%a ~~ / ^ 'b' /|);
ok(%à ~~ / ^ 'a' /, q|%a ~~ / ^ 'a' /|);
ok(%à ~~ / ^ 'a' $ /, q|%a ~~ / ^ 'a' $ /|);

# vim: expandtab shiftwidth=4
