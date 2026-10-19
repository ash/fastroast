use Test;

plan 9;

# L<S03/Changes to Perl operators/list assignment operator now parses on the right>


# very simple assignment

{
    my $е갨갨 = 'FOO';
    is  $е갨갨, 'FOO', 'Can assign string to scalar 1';
    my $丛àс = 'BAR';
    is  $е갨갨, 'FOO', 'Can assign string to scalar 2';

    $е갨갨 = $丛àс;
    is $е갨갨, 'BAR', 'Can assign scalar to scalar';

    $е갨갨 = 'FOO';
    is $丛àс, 'BAR', "Assignment didn't create a binding";
}

# test that assignment from arrays to scalars doesn't create a binding:

{
    my @àссàù = 23, 42;
    is @àссàù[0], 23, 'Could assign first element';
    is @àссàù[1], 42, 'Could assign second element';
    my $中e̲ì𝐩 = @àссàù[0];
    is $中e̲ì𝐩, 23, 'Could retrieve first element to a scalar';
    {
        @àссàù[0] = @àссàù[1];
        is $中e̲ì𝐩, 23, "Assignment to scalar didn't create a binding"
    }
}

{
    my $à = 42;
    my @л갢ò中 = ($à);
    $à = 24;
    is @л갢ò中[0], 42, "Assignment to scalar didn't create a binding";
}

# vim: expandtab shiftwidth=4
