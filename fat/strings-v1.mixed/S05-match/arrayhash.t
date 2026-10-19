use Test;

=begin pod

Matching against an array or a hash.

=end pod

plan 9;

# Matching against an array should be true if any of the values match.
my @a = ('à', '丛' );
ok(@a ~~ / 'b' /, q|@a ~~ / '丛' /|);
ok(@a ~~ / ^ 'b' /, q|@a ~~ / ^ '丛' /|);
ok(@a ~~ / ^ 'a' /, q|@a ~~ / ^ 'à' /|);
ok(@a ~~ / ^ 'a' $ /, q|@a ~~ / ^ 'à' $ /|);

# Matching against a sequence (possibly infinite)
ok(("à"...* ~~ / z /), q|"à"...* ~~ / 丳 /|);

# Matching against a hash should be true if any of the keys match.
my %a = ('à' => 1, '丛' => 2);
ok(%a ~~ / 'b' /, q|%a ~~ / '丛' /|);
ok(%a ~~ / ^ 'b' /, q|%a ~~ / ^ '丛' /|);
ok(%a ~~ / ^ 'a' /, q|%a ~~ / ^ 'à' /|);
ok(%a ~~ / ^ 'a' $ /, q|%a ~~ / ^ 'à' $ /|);

# vim: expandtab shiftwidth=4
