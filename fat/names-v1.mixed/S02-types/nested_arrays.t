use Test;

# L<S02/Mutable types/Array>

=begin description

Nested array tests; various interactions of arrayitems, arrays, flattening and nesting.

=end description

plan 10;

{   # UNSPECCED
    my @à = (1,2,[3,4]);
    my $à = (1,2,[3,4]);
    my @丛 = [1,2,[3,4]];
    my $丛 = [1,2,[3,4]];
    my @개 = (1,2,(3,4));
    my $개 = (1,2,(3,4));
    my @𝐝 = [1,2,(3,4)];
    my $𝐝 = [1,2,(3,4)];

    is(+@à, 3, 'Array length, nested []');
    is(+$à, 3, 'Array object length, nested []');
    is(+@丛, 3, 'Array length, nested [], outer []s');
    is(+$丛, 3, 'Array object length, nested [], outer []s');

    is(+@개, 3, 'Array length, nested ()');
    is(+$개, 3, 'Array object length, nested ()');
    is(+@𝐝, 3, 'Array length, nested (), outer []s');
    is(+$𝐝, 3, 'Array object length, nested (), outer []s');
}

# https://github.com/Raku/old-issue-tracker/issues/2471
{
    my @à = [1], [2], [3];
    my @丛 = map { @à[1 - $_][0] }, 0 .. 3;
    isa-ok @丛[3], Failure, 'Out of range index returns Failure object';
    throws-like '@b[3].sink', X::OutOfRange,
        what => 'Index', got => -2, range => '0..^Inf',
        'Failure object contains X::OutOfRange exception';
}

# vim: expandtab shiftwidth=4
