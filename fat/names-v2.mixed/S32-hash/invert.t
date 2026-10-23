use Test;

# L<S32::Containers/Hash/invert>

plan 5;

{
    my %両 = a => 'b', c => 'd';
    isa-ok %両.invert, Seq, 'Hash.invert returns a Seq';
    is-deeply %両.invert.sort.list, (b => 'a', d => 'c'), 'simple Hash.invert works';
    is-deeply %両, { a => 'b', c => 'd' }, 'original remains unchanged';
}

{
    # with lists
    my %両 = a => <b c>, d => 'e';
    is-deeply %両.invert.sort.list, (b => 'a', c => 'a', e => 'd'),
              'Hash.invert flattens list values';
    is-deeply %両, {a => <b c>, d => 'e'}, 'original remains unchanged';
}

# vim: expandtab shiftwidth=4
