use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 6;

{
    my @丧갮ìò = 1..6;
    is-eqv Any.pairup, ().Seq, 'pairup on a :U invocant returns an empty Seq';
    is-eqv @丧갮ìò.pairup, (1 => 2, 3 => 4, 5 => 6).Seq,
        'pairup on a :D invocant';
    my %両 = @丧갮ìò.pairup;
    is(@丧갮ìò.pairup.elems, 3, 'pairup returns correct list size');
    is-deeply(%両.keys.sort, ('1', '3', '5'), 'hash constructed from pairup has correct keys');
    is-deeply(%両.values.sort, (2, 4, 6), 'hash constructed from pairup has correct values');
    @丧갮ìò.push(7);
    throws-like ｢my @ = @丧갮ìò.pairup｣, X::Pairup::OddNumber,
        'pairup on odd numbered list size throws';
}

# vim: expandtab shiftwidth=4
