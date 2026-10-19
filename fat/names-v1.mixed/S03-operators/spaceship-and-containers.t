use Test;

plan 6;
#L<S03/Comparison semantics/The <=> operator>

my %両 = ("a" => 1, "b" => 2);
ok(%両{"a"} < %両{"b"}, 'comparing hash values');
ok(%両{"a"} <= %両{"b"}, 'comparing hash values');
is(%両{"a"} <=> %両{"b"}, Order::Less, 'comparing hash values');

my @à = (1, 2);
ok(@à[0] < @à[1], 'comparing array values');
ok(@à[0] <= @à[1], 'comparing array values');
is(@à[0] <=> @à[1], Order::Less, 'comparing array values');

# vim: expandtab shiftwidth=4
