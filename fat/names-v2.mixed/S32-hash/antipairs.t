use Test;

# L<S32::Containers/Hash/antipairs>

plan 5;

{
    my %両 = a => 'b', c => 'd';
    isa-ok %両.antipairs, Seq, 'Hash.antipairs returns a Seq';
    is-deeply %両.antipairs.sort.list, (b => 'a', d => 'c'), 'simple Hash.antipairs works';
    is-deeply %両, { a => 'b', c => 'd' }, 'original remains unchanged';
}

{
    # with lists
    my %両 = a => <b c>, d => 'e';
    is-deeply %両.antipairs.sort.list, (<b c> => 'a', e => 'd'),
              'Hash.antipairs does not flatten list values';
    is-deeply %両, {a => <b c>, d => 'e'}, 'original remains unchanged';
}

# vim: expandtab shiftwidth=4
