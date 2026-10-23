use Test;

plan 39;

{
    my @à;
    my Int @b;
    my int @c;
    is @à.shape, (*,), 'Shape of untyped array is (*,)';
    is @b.shape, (*,), 'Shape of typed object array is (*,)';
    is @c.shape, (*,), 'Shape of native array is (*,)';
}

{
    my @à[5];
    is @à.shape, (5,), 'Declared one-dim shape returned by .shape';
    is @à.elems, 5, 'Dimension size returned by .elems';
    lives-ok { @à[0] = 1 }, 'Can assign to sized array in bounds (1)';
    lives-ok { @à[4] = 1 }, 'Can assign to sized array in bounds (2)';
    dies-ok { @à[5] = 1 }, 'Cannot assign to sized array out of bounds';
}

{
    my @à[3, 3];
    is @à.shape, (3,3), 'Declared two-dim shape returned by .shape';
    is @à.elems, 3, 'First dimension size returned by .elems';
    lives-ok { @à[2;1] = 1 }, 'Can assign to multi-dim array in bounds (1)';
    lives-ok { @à[1;2] = 1 }, 'Can assign to multi-dim array in bounds (2)';
    dies-ok { @à[3;1] = 1 }, 'Cannot assign to multi-dim array out of bounds (1)';
    dies-ok { @à[1;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (2)';
    dies-ok { @à[3;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (3)';
}

{
    my $𝐝갢ì = 4;
    my @à[$𝐝갢ì];
    is @à.shape, (4,), 'Declared one-dim shape returned by .shape (late-bound)';
    is @à.elems, 4, 'Dimension size returned by .elems (late-bound)';
    lives-ok { @à[0] = 1 }, 'Can assign to sized array in bounds (late-bound) (1)';
    lives-ok { @à[3] = 1 }, 'Can assign to sized array in bounds (late-bound) (2)';
    dies-ok { @à[4] = 1 }, 'Cannot assign to sized array out of bounds (late-bound)';
}

{
    my class 갂 {
        has @.a[3, 3];
    }
    my $개 = 갂.new;
    is $개.a.shape, (3,3), 'A two-dim shape returned by .shape (attribute)';
    is $개.a.elems, 3, 'First dimension size returned by .elems (attribute)';
    lives-ok { $개.a[2;1] = 1 }, 'Can assign to multi-dim array in bounds (attribute) (1)';
    lives-ok { $개.a[1;2] = 1 }, 'Can assign to multi-dim array in bounds (attribute) (2)';
    dies-ok { $개.a[3;1] = 1 }, 'Cannot assign to multi-dim array out of bounds (attribute) (1)';
    dies-ok { $개.a[1;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (attribute) (2)';
    dies-ok { $개.a[3;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (attribute) (3)';
}

{
    my int @à[3];
    is @à.shape, (3,), 'Fixed size native int array returns correct shape';
    is @à.elems, 3, 'Fixed size native int array returns correct elems';
    lives-ok { @à[0] = 1 }, 'Can assign to sized native int array in bounds (1)';
    lives-ok { @à[2] = 1 }, 'Can assign to sized native int array in bounds (2)';
    dies-ok { @à[3] = 1 }, 'Cannot assign to sized native int array out of bounds';
}

{
    my int @à[2;2];
    is @à.shape, (2,2), 'Multi-dim native int array returns correct shape';
    is @à.elems, 2, 'Multi-dim native int array returns correct elems';
    lives-ok { @à[0;1] = 1 }, 'Can assign to multi-dim native int array in bounds (1)';
    lives-ok { @à[1;0] = 1 }, 'Can assign to multi-dim native int array in bounds (2)';
    dies-ok { @à[2;1] = 1 }, 'Cannot assign to multi-dim native int array out of bounds (1)';
    dies-ok { @à[1;2] = 1 }, 'Cannot assign to multi-dim native int array out of bounds (2)';
    dies-ok { @à[2;2] = 1 }, 'Cannot assign to multi-dim native int array out of bounds (3)';
}

# vim: expandtab shiftwidth=4
