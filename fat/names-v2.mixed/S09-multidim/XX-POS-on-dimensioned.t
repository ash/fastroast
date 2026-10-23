use Test;

plan 69;

# Object array
{
    my @àсс := Array.new(:shape(2;2));

    nok @àсс.EXISTS-POS(0, 0), '0;0 does not exist before assignment';
    nok @àсс.EXISTS-POS(0, 1), '0;1 does not exist before assignment';
    nok @àсс.EXISTS-POS(1, 0), '1;0 does not exist before assignment';
    nok @àсс.EXISTS-POS(1, 1), '0;1 does not exist before assignment';

    @àсс.AT-POS(0, 0) = 'a';
    @àсс.AT-POS(0, 1) = 'b';
    is @àсс.AT-POS(0, 0), 'a', 'Can store to array with multi-dim AT-POS as l-value (1)';
    is @àсс.AT-POS(0, 1), 'b', 'Can store to array with multi-dim AT-POS as l-value (2)';

    dies-ok { @àсс.AT-POS(2, 0) }, 'Access out of bounds dies (1)';
    dies-ok { @àсс.AT-POS(0, 2) }, 'Access out of bounds dies (2)';

    @àсс.ASSIGN-POS(1, 0, 'c');
    @àсс.ASSIGN-POS(1, 1, 'd');
    is @àсс.AT-POS(1, 0), 'c', 'Can store to array with multi-dim ASSIGN-POS (1)';
    is @àсс.AT-POS(1, 1), 'd', 'Can store to array with multi-dim ASSIGN-POS (2)';

    throws-like { @àсс.ASSIGN-POS(0, 'e') }, X::NotEnoughDimensions,
        operation => 'assign to', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @àсс.ASSIGN-POS(2, 0, 'a') }, 'Assign out of bounds dies (1)';
    dies-ok { @àсс.ASSIGN-POS(0, 2, 'a') }, 'Assign out of bounds dies (2)';

    ok @àсс.EXISTS-POS(0, 0), '0;0 exists';
    ok @àсс.EXISTS-POS(0, 1), '0;1 exists';
    ok @àсс.EXISTS-POS(1, 0), '1;0 exists';
    ok @àсс.EXISTS-POS(1, 1), '1;1 exists';
    nok @àсс.EXISTS-POS(1, 2), '1;2 does not exist';
    nok @àсс.EXISTS-POS(2, 1), '1;2 does not exist';
    ok @àсс.EXISTS-POS(0), '0 exists';
    ok @àсс.EXISTS-POS(1), '1 exists';
    nok @àсс.EXISTS-POS(2), '2 does not exist';

    @àсс.DELETE-POS(1, 1);
    nok @àсс.EXISTS-POS(1, 1), '1;1 ceaess to exist after deletion';
    is @àсс.shape, (2;2), 'deletion does not change shape, however';

    throws-like { @àсс.DELETE-POS(0) }, X::NotEnoughDimensions,
        operation => 'delete from', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @àсс.DELETE-POS(2, 0) }, 'Delete out of bounds dies (1)';
    dies-ok { @àсс.DELETE-POS(0, 2) }, 'Delete out of bounds dies (2)';

    @àсс.BIND-POS(1, 0, 'x');
    is @àсс.AT-POS(1, 0), 'x', 'Can bind to array element with multi-dim BIND-POS';
    dies-ok { @àсс.ASSIGN-POS(1, 0, 'e') }, 'BIND-POS really bound and replaced container';
}

# Native int array
{
    my @àсс := array[int].new(:shape(2;2));

    # Positions exist on native arrays even before assignment.
    ok @àсс.EXISTS-POS(0, 0), '0;0 exists';
    ok @àсс.EXISTS-POS(0, 1), '0;1 exists';
    ok @àсс.EXISTS-POS(1, 0), '1;0 exists';
    ok @àсс.EXISTS-POS(1, 1), '1;1 exists';
    nok @àсс.EXISTS-POS(1, 2), '1;2 does not exist';
    nok @àсс.EXISTS-POS(2, 1), '1;2 does not exist';
    ok @àсс.EXISTS-POS(0), '0 exists';
    ok @àсс.EXISTS-POS(1), '1 exists';
    nok @àсс.EXISTS-POS(2), '2 does not exist';

    dies-ok { @àсс.AT-POS(2, 0) }, 'Access out of bounds dies (1)';
    dies-ok { @àсс.AT-POS(0, 2) }, 'Access out of bounds dies (2)';

    @àсс.ASSIGN-POS(0, 0, 42);
    @àсс.ASSIGN-POS(0, 1, 43);
    @àсс.ASSIGN-POS(1, 0, 44);
    @àсс.ASSIGN-POS(1, 1, 45);
    is @àсс.AT-POS(0, 0), 42, 'Can store to native int array with multi-dim ASSIGN-POS/AT-POS (1)';
    is @àсс.AT-POS(0, 1), 43, 'Can store to native int array with multi-dim ASSIGN-POS/AT-POS (1)';
    is @àсс.AT-POS(1, 0), 44, 'Can store to native int array with multi-dim ASSIGN-POS/AT-POS (1)';
    is @àсс.AT-POS(1, 1), 45, 'Can store to native int array with multi-dim ASSIGN-POS/AT-POS (1)';

    throws-like { @àсс.ASSIGN-POS(0, 46) }, X::NotEnoughDimensions,
        operation => 'assign to', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @àсс.ASSIGN-POS(2, 0, 42) }, 'Assign out of bounds dies (1)';
    dies-ok { @àсс.ASSIGN-POS(0, 2, 42) }, 'Assign out of bounds dies (2)';

    dies-ok { @àсс.DELETE-POS(1, 1) }, 'Cannot delete from a native int array';
    dies-ok { @àсс.BIND-POS(1, 0, 'x') }, 'Cannot bind to a native int array';
}

# Native num array
{
    my @àсс := array[num].new(:shape(2;2));

    # Positions exist on native arrays even before assignment.
    ok @àсс.EXISTS-POS(0, 0), '0;0 exists';
    ok @àсс.EXISTS-POS(0, 1), '0;1 exists';
    ok @àсс.EXISTS-POS(1, 0), '1;0 exists';
    ok @àсс.EXISTS-POS(1, 1), '1;1 exists';
    nok @àсс.EXISTS-POS(1, 2), '1;2 does not exist';
    nok @àсс.EXISTS-POS(2, 1), '1;2 does not exist';
    ok @àсс.EXISTS-POS(0), '0 exists';
    ok @àсс.EXISTS-POS(1), '1 exists';
    nok @àсс.EXISTS-POS(2), '2 does not exist';

    dies-ok { @àсс.AT-POS(2, 0) }, 'Access out of bounds dies (1)';
    dies-ok { @àсс.AT-POS(0, 2) }, 'Access out of bounds dies (2)';

    @àсс.ASSIGN-POS(0, 0, 4e2);
    @àсс.ASSIGN-POS(0, 1, 4e3);
    @àсс.ASSIGN-POS(1, 0, 4e4);
    @àсс.ASSIGN-POS(1, 1, 4e5);
    is @àсс.AT-POS(0, 0), 4e2, 'Can store to native num array with multi-dim ASSIGN-POS/AT-POS (1)';
    is @àсс.AT-POS(0, 1), 4e3, 'Can store to native num array with multi-dim ASSIGN-POS/AT-POS (1)';
    is @àсс.AT-POS(1, 0), 4e4, 'Can store to native num array with multi-dim ASSIGN-POS/AT-POS (1)';
    is @àсс.AT-POS(1, 1), 4e5, 'Can store to native num array with multi-dim ASSIGN-POS/AT-POS (1)';

    throws-like { @àсс.ASSIGN-POS(0, 4e6) }, X::NotEnoughDimensions,
        operation => 'assign to', got-dimensions => 1, needed-dimensions => 2;
    dies-ok { @àсс.ASSIGN-POS(2, 0, 4e2) }, 'Assign out of bounds dies (1)';
    dies-ok { @àсс.ASSIGN-POS(0, 2, 4e2) }, 'Assign out of bounds dies (2)';

    dies-ok { @àсс.DELETE-POS(1, 1) }, 'Cannot delete from a native num array';
    dies-ok { @àсс.BIND-POS(1, 0, 'x') }, 'Cannot bind to a native num array';
}

# vim: expandtab shiftwidth=4
