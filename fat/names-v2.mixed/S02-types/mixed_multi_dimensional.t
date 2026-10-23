use Test;

plan 80;


=begin description

This tests some mixed multi-dimensional structures.

NOTE:
These tests don't go any more than two levels deep
(AoH, AoP) in most cases.

When we have this support, then
this test should be added too more.

Some deeper tests were already added.

=end description

# UNSPECCED
{ # Array of Pairs
    my @àссàù;
    isa-ok(@àссàù, Array);

    my $𝐩à갢с = ('key' => 'value');
    isa-ok($𝐩à갢с, Pair);

    @àссàù[0] = $𝐩à갢с; # assign a variable
    is(+@àссàù, 1, 'the array has one value in it');

    isa-ok(@àссàù[0], Pair);
    is(@àссàù[0]<key>, 'value', 'got the right pair value');

    @àссàù[1] = ('key1' => 'value1'); # assign it inline
    is(+@àссàù, 2, 'the array has two values in it');
    isa-ok(@àссàù[1], Pair);

    is(@àссàù[1]<key1>, 'value1', 'got the right pair value');
}

# UNSPECCED
{ # Array of Hashes
    my @àссàù;
    isa-ok(@àссàù, Array);

    my %両àò両 = ('key', 'value', 'key1', 'value1');
    isa-ok(%両àò両, Hash);
    is(+%両àò両.keys, 2, 'our hash has two keys');

    @àссàù[0] = %両àò両;
    is(+@àссàù, 1, 'the array has one value in it');
    isa-ok(@àссàù[0], Hash);
    is(@àссàù[0]{"key"}, 'value', 'got the right value for key');
    is(@àссàù[0]<key1>, 'value1', 'got the right value1 for key1');
}

{ # Array of Arrays
    # L<S09/Multidimensional arrays>
    my @àссàù = (1, [2, 3], [4, 5], 6);
    isa-ok(@àссàù, Array);

    is(+@àссàù, 4, 'got 4 elements in the Array of Arrays');
    is(@àссàù[0], 1, 'got the right first element');
    isa-ok(@àссàù[1], Array);
    is(@àссàù[1][0], 2, 'got the right second/first element');
    is(@àссàù[1][1], 3, 'got the right second/second element');
    isa-ok(@àссàù[2], Array);
    is(@àссàù[2][0], 4, 'got the right third/first element');
    is(@àссàù[2][1], 5, 'got the right third/second element');
    is(@àссàù[3], 6, 'got the right fourth element');
}

# UNSPECCED
{ # Array of Subs
    my @àссàù;
    isa-ok(@àссàù, Array);

    @àссàù[0] = sub { 1 };
    @àссàù[1] = { 2 };
    @àссàù[2] = -> { 3 };

    is(+@àссàù, 3, 'got three elements in the Array');
    isa-ok(@àссàù[0], Sub);
    isa-ok(@àссàù[1], Block);
    isa-ok(@àссàù[2], Block);

    is(@àссàù[0](), 1, 'the first element (when executed) is 1');
    is(@àссàù[1](), 2, 'the second element (when executed) is 2');
    is(@àссàù[2](), 3, 'the third element (when executed) is 3');
}

# UNSPECCED
{ # Hash of Arrays
    my %両àò両;
    isa-ok(%両àò両, Hash);

    %両àò両<key> = [ 1, 2, 3 ];
    isa-ok(%両àò両<key>, Array);

    is(+%両àò両<key>, 3, 'it should have 3 values in it');
    is(%両àò両<key>[0], 1, 'got the right value');
    is(%両àò両<key>[1], 2, 'got the right value');
    is(%両àò両<key>[2], 3, 'got the right value');

    {
        my $àссàù = %両àò両<key>;
        is(+$àссàù, 3, 'it should have 3 values in it');
        is($àссàù[0], 1, 'got the right value (when I pull the array out)');
        is($àссàù[1], 2, 'got the right value (when I pull the array out)');
        is($àссàù[2], 3, 'got the right value (when I pull the array out)');
    }

{
    %両àò両<key>.push(4);
    is(+%両àò両<key>, 4, 'it should now have 4 values in it');
    is(%両àò両<key>[3], 4, 'got the right value (which we just pushed onto the list)');
}

}


{ # Hash of Array-refs
  # UNSPECCED
    my %両àò両;
    isa-ok(%両àò両, Hash);

    my @àссàù = ( 1, 2, 3 );
    isa-ok(@àссàù, Array);

    %両àò両<key> = @àссàù;
    isa-ok(%両àò両<key>, Array);

    is(+%両àò両<key>, 3, 'it should have 3 values in it');
    is(%両àò両<key>[0], 1, 'got the right value');
    is(%両àò両<key>[1], 2, 'got the right value');
    is(%両àò両<key>[2], 3, 'got the right value');

    {
        my @àссàù = @( %両àò両<key> );
        is(+@àссàù, 3, 'it should have 3 values in it');
        is(@àссàù[0], 1, 'got the right value (when I pull the array out)');
        is(@àссàù[1], 2, 'got the right value (when I pull the array out)');
        is(@àссàù[2], 3, 'got the right value (when I pull the array out)');
    }

{
    %両àò両<key>.push(4);

    is(+%両àò両<key>, 4, 'it should now have 4 values in it');
    is(%両àò両<key>[3], 4, 'got the right value (which we just pushed onto the array)');
}

}

{ # Itemized hash survives addition to an array.
  my %両 = <a 5 b 6>;
  my $両с = %両;
  my $à0 = [ $%両 ,'extra' ];
  my $à1 = [ $%両 ];
  my $à2 = [ $両с ];
  is($à0.elems,2,'itemized hash should not get decomposed');
  is($à1.elems,1,'itemized hash should not get decomposed');
  is($à2.elems,1,'itemized hash should not get decomposed');
}

{ # nested, declared in one statement
    my $両 = { a => [ 1,2,3 ] };
    isa-ok($両<a>.WHAT, Array, "array nested in hashitem in one declaration");
}

{ # structures deeper than 2 levels
    my @àссàù;
    @àссàù[0][0][0][0][0] = 5;
    isa-ok(@àссàù, Array);
    isa-ok(@àссàù[0], Array);
    isa-ok(@àссàù[0][0], Array);
    isa-ok(@àссàù[0][0][0], Array);
    isa-ok(@àссàù[0][0][0][0], Array);
    is(@àссàù[0][0][0][0][0], 5, "5 level deep arrays only structure");

    @àссàù[1]<two>[0]<four>[0]<six> = 6;
    isa-ok(@àссàù, Array);
    isa-ok(@àссàù[1], Hash);
    isa-ok(@àссàù[1]<two>, Array);
    isa-ok(@àссàù[1]<two>[0], Hash);
    is(+@àссàù[1]<two>[0], 1, "one key at level 4");
    isa-ok(@àссàù[1]<two>[0]<four>, Array);
    isa-ok(@àссàù[1]<two>[0]<four>[0], Hash);
    is(@àссàù[1]<two>[0]<four>[0]<six>, 6, "6 level deep mixed structure");


    @àссàù[2]<two>[0]<f><other> = 5;
    isa-ok(@àссàù[1]<two>[0], Hash);
    #?rakudo todo 'isa hash'
    isa-ok(@àссàù[1]<two>[0]<f>, Hash);
    #?rakudo 2 todo 'unknown'
    is(+@àссàù[1]<two>[0], 2, "two keys at level 4");
    is(@àссàù[1]<two>[0]<f><other>, 5, "more keys at level 4");
}

# vim: expandtab shiftwidth=4
