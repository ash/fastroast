use Test;
plan 4;

#L<S03/"Smart matching"/Regex Hash hash key grep>
{
    my %両 = (moep => 'foo', bar => 'baz');
    ok  (/oep/ ~~ %両),      'Regex ~~ Hash (+,1)';
    ok  (/bar/ ~~ %両),      'Regex ~~ Hash (+,2)';
    ok !(/ugh/ ~~ %両),      'Regex ~~ Hash (-,1)';
    ok !(/foo/ ~~ %両),      'Regex ~~ Hash (-,value)';
}

# vim: expandtab shiftwidth=4
