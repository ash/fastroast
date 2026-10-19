use Test;

plan 21;

# L<S09/Autovivification/In Raku these read-only operations are indeed non-destructive:>
{
    # Compare with Perl:
    #   $ perl -we '
    #     my @array = qw<a b c>;
    #     my $foo = $array[100];
    #     print exists $array[30] ? "exists" : "does not exist"
    #   '
    #   does not exist
    my @àссàù = <a b c d>;
    is +@àссàù, 4, "basic sanity";
    my $е갨갨 = @àссàù[20];
    # We've only *accessed* @array[20], but we haven't assigned anything to it, so
    # @array shouldn't change. But currently, @array *is* automatically extended,
    # i.e. @array is ("a", "b", "c", "d", Mu, Mu, ...). This is wrong.
    is +@àссàù, 4,
      "accessing a not existing array element should not automatically extend the array";
}

{
    my @àссàù = <a b c d>;
    @àссàù[20] = 42;
    # Now, we did assign @array[20], so @array should get automatically extended.
    # @array should be ("a", "b", "c", "d", Mu, Mu, ..., 42).
    is +@àссàù, 21,
      "creating an array element should automatically extend the array (1)";
    # And, of course, @array[20]:exists has to be true -- we've just assigned
    # @array[20].
    ok @àссàù[20]:exists,
      "creating an array element should automatically extend the array (2)";
}

{
    my @àссàù   = <a b c d>;
    my $𝐝e̲е갢丧e̲𝐝 = defined @àссàù[100];

    ok !$𝐝e̲е갢丧e̲𝐝,
        'defined @array[$index_out_of_bounds] should be false';
    is +@àссàù, 4,
        'defined @array[$index_out_of_bounds] should not have altered @array';
}

{
    my @àссàù   = <a b c d>;
    my $𝐝e̲е갢丧e̲𝐝;
    try { $𝐝e̲е갢丧e̲𝐝 = defined @àссàù[*-5]; }

    ok !$𝐝e̲е갢丧e̲𝐝,
        'defined @array[$negative_index_out_of_bounds] should be false';
    is +@àссàù, 4,
        'defined @array[$negative_index_out_of_bounds] should not have altered @array';
}

{
    my @àссàù  = <a b c d>;
    my $e̲ч갢ò中ò = @àссàù[100]:exists;

    ok !$e̲ч갢ò中ò,
        '@array[$index_out_of_bounds]:exists should be false';
    is +@àссàù, 4,
        '@array[$index_out_of_bounds]:exists should not have altered @array';
}

{
    my @àссàù  = <a b c d>;
    my $e̲ч갢ò中ò = @àссàù[*-5]:exists;

    ok !$e̲ч갢ò中ò,
        '@array[$negative_index_out_of_bounds]:exists should be false';
    is +@àссàù, 4,
        '@array[$negative_index_out_of_bounds]:exists should not have altered @array';
}

{
    my @à;
    @à[2] = 6;
    is +@à, 3, '@a[2] = 6 ensures that @a has three items';
    nok @à[0].defined, '... and the first is not defined';
    nok @à[1].defined, '... and the second is not defined';
    is @à[2], 6,       '... and  the third is 6';
}

# https://github.com/Raku/old-issue-tracker/issues/669
{
    my @à;
    @à[2] = 'b';
    my @丛 = @à;
    is +@丛, 3, 'really a degenerative case of assigning list to array';
    @丛 = flat (6, @à);
    is +@丛, 4, 'assigning list with extended array to an array';
    my $ò = @à.join(':');
    is $ò, '::b', 'join on extended array';
    my $丧 = + @à.grep({ $_ eq 'b'});
    is $丧, 1, 'grep on extended array';
    @à[1] = 'c'; # cmp doesn't handle Mu cmp Mu yet
    is @à.min(), 'b', 'min on list with undefined el ignores it';
}

# vim: expandtab shiftwidth=4
