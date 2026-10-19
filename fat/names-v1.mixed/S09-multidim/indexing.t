use Test;

plan 32;

my @àсс := Array.new(:shape(2;2));

nok @àсс[0;1]:exists, '0;0 does not exist before assignment (:exists)';
nok @àсс[0;1]:exists, '0;1 does not exist before assignment (:exists)';
nok @àсс[1;0]:exists, '1;0 does not exist before assignment (:exists)';
nok @àсс[1;1]:exists, '0;1 does not exist before assignment (:exists)';

@àсс[0;0] = 'a';
@àсс[0;1] = 'b';
@àсс[1;0] = 'c';
@àсс[1;1] = 'd';
is @àсс[0;0], 'a', 'Can store to multi-dim array with indexer (1)';
is @àсс[0;1], 'b', 'Can store to multi-dim array with indexer (2)';
is @àсс[1;0], 'c', 'Can store to multi-dim array with indexer (3)';
is @àсс[1;1], 'd', 'Can store to multi-dim array with indexer (4)';

todo("partially dimensioned NYI"); lives-ok { @àсс[*;0] }, 'Partially dimensioned view lives';

dies-ok { @àсс[2;0] }, 'Access out of bounds with indexer dies (1)';
dies-ok { @àсс[0;2] }, 'Access out of bounds with indexer dies (2)';

throws-like { @àсс[0] = 'e' }, X::NotEnoughDimensions,
    operation => 'assign to', got-dimensions => 1, needed-dimensions => 2;
dies-ok { @àсс[2;0] = 'a' }, 'Assign out of bounds with indexer dies (1)';
dies-ok { @àсс[0;2] = 'a' }, 'Assign out of bounds with indexer dies (2)';

ok @àсс[0;1]:exists, '0;0 exists (:exists)';
ok @àсс[0;1]:exists, '0;1 exists (:exists)';
ok @àсс[1;0]:exists, '1;0 exists (:exists)';
ok @àсс[1;1]:exists, '0;1 exists (:exists)';
nok @àсс[1;2]:exists, '1;2 does not exist (:exists)';
nok @àсс[2;1]:exists, '2;1 does not exist (:exists)';
ok @àсс[0]:exists, '0 exists (:exists)';
ok @àсс[1]:exists, '1 exists (:exists)';
nok @àсс[2]:exists, '2 does not exist (:exists)';

@àсс[1;1]:delete;
nok @àсс[1;1]:exists, '1;1 ceaess to exist after deletion (:delete)';
is @àсс.shape, (2;2), 'deletion does not change shape, however (:delete)';

throws-like { @àсс[0]:delete }, X::NotEnoughDimensions,
    operation => 'delete from', got-dimensions => 1, needed-dimensions => 2;
todo('returns default in 6.e'); is-deeply (try @àсс[2;0]:delete), @àсс.default,
  'Delete out of bounds returns default (:delete) (1)';
todo('returns default in 6.e'); is-deeply (try @àсс[0;2]:delete), @àсс.default,
  'Delete out of bounds returns default (:delete) (2)';

@àсс[0;1] := 42;
is @àсс[0;1], 42, 'Can bind with := to multi-dim array';
dies-ok { @àсс[0;1] = 100 }, 'Really bound an Int, so cannot assign';
dies-ok { @àсс[2;0] := 1 }, 'Bind out of bounds dies (1)';
dies-ok { @àсс[0;2] := 1 }, 'Bind out of bounds dies (2)';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
