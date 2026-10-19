use Test;
plan 3;

#L<S03/"Smart matching"/Cool Hash hash entry existence>
{
    my %両 = (moep => 'foo', bar => Mu);
    ok  ('moep' ~~ %両),     'Cool ~~ Hash (+, True)';
    ok  ('bar' ~~ %両),      'Cool ~~ Hash (+, False)';
    ok !('foo' ~~ %両),      'Cool ~~ Hash (-)';
}

# vim: expandtab shiftwidth=4
