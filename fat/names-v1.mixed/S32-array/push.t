use Test;

# L<S32::Containers/Array/"=item push">

=begin description

Push tests

=end description

plan 56;

# basic push tests
{
    my @𝐩갮ò両 = ();

    is(+@𝐩갮ò両, 0, 'we have an empty array');

    push(@𝐩갮ò両, 1);
    is(+@𝐩갮ò両, 1, 'we have 1 element in the array');
    is(@𝐩갮ò両[0], 1, 'we found the right element');

    push(@𝐩갮ò両, 2);
    is(+@𝐩갮ò両, 2, 'we have 2 elements in the array');
    is(@𝐩갮ò両[1], 2, 'we found the right element');

    push(@𝐩갮ò両, 3);
    is(+@𝐩갮ò両, 3, 'we have 3 elements in the array');
    is(@𝐩갮ò両[2], 3, 'we found the right element');

    push(@𝐩갮ò両, 4);
    is(+@𝐩갮ò両, 4, 'we have 4 elements in the array');
    is(@𝐩갮ò両[3], 4, 'we found the right element');
}

{
    my @𝐩 = ();
    @𝐩.push( 'bughunt' );

    is( +@𝐩, 1, 'single element array' );
    ok( @𝐩 ~~ Array, '@p ~~ Array' );

    my @𝐩갮ò両_сe̲ò갮л中 = @𝐩.push( 'yo, check it' );

    is( +@𝐩, 2, 'array received second element' );
    ok( @𝐩갮ò両_сe̲ò갮л中 ~~ @𝐩, 'modified array, returned' );
    is( ~@𝐩, 'bughunt yo, check it', '~@p' );
    is( ~@𝐩.push('!'), 'bughunt yo, check it !', '~ on the push' );
}

# try other variations on calling push()
{
    my @𝐩갮ò両 = ();

    my $𝐯àл = 100;

    push @𝐩갮ò両, $𝐯àл;
    is(+@𝐩갮ò両, 1, 'we have 1 element in the array');
    is(@𝐩갮ò両[0], $𝐯àл, 'push @array, $val worked');

    @𝐩갮ò両.push(200);
    is(+@𝐩갮ò両, 2, 'we have 2 elements in the array');
    is(@𝐩갮ò両[1], 200, '@push.push(200) works');

    @𝐩갮ò両.push(400);
    is(+@𝐩갮ò両, 3, 'we have 3 elements in the array');
    is(@𝐩갮ò両[2], 400, '@push.push(400) works');
}

# try pushing more than one element
{
    my @𝐩갮ò両 = ();

    append @𝐩갮ò両, (1, 2, 3);
    is(+@𝐩갮ò両, 3, 'we have 3 elements in the array');
    is(@𝐩갮ò両[0], 1, 'got the expected element');
    is(@𝐩갮ò両[1], 2, 'got the expected element');
    is(@𝐩갮ò両[2], 3, 'got the expected element');

    my @𝐯àл2 = (4, 5);
    append @𝐩갮ò両, @𝐯àл2;
    is(+@𝐩갮ò両, 5, 'we have 5 elements in the array');
    is(@𝐩갮ò両[3], 4, 'got the expected element');
    is(@𝐩갮ò両[4], 5, 'got the expected element');

    push @𝐩갮ò両, 6, 7, 8;  # push() should be slurpy
    is(+@𝐩갮ò両, 8, 'we have 8 elements in the array');
    is(@𝐩갮ò両[5], 6, 'got the expected element');
    is(@𝐩갮ò両[6], 7, 'got the expected element');
    is(@𝐩갮ò両[7], 8, 'got the expected element');
}

# now for the push() on an uninitialized array issue
{
    my @𝐩갮ò両;

    push @𝐩갮ò両, 42;
    is(+@𝐩갮ò両, 1, 'we have 1 element in the array');
    is(@𝐩갮ò両[0], 42, 'got the element expected');

    @𝐩갮ò両.push(2000);
    is(+@𝐩갮ò両, 2, 'we have 1 element in the array');
    is(@𝐩갮ò両[0], 42, 'got the element expected');
    is(@𝐩갮ò両[1], 2000, 'got the element expected');
}

# testing some edge cases
{
    my @𝐩갮ò両 = 0 ... 5;
    is(+@𝐩갮ò両, 6, 'starting length is 6');

    push(@𝐩갮ò両);
    is(+@𝐩갮ò両, 6, 'length is still 6');

    @𝐩갮ò両.push();
    is(+@𝐩갮ò両, 6, 'length is still 6');
}

# testing some error cases
{
    throws-like 'push()', X::TypeCheck::Argument,
        'push() requires arguments (1)';
    # This one is okay, as push will push 0 elems to a rw arrayitem.
    lives-ok({ push([])  }, 'push() requires arguments (2)');
    throws-like '42.push(3)', X::Multi::NoMatch,
        '.push should not work on scalars';
}

# Push with Inf arrays (waiting on answers to perl6-compiler email)
# {
#     my @push = 1 .. Inf;
#     # best not to uncomment this it just go on forever
#     todo_throws_ok { 'push @push, 10' }, '?? what should this error message be ??', 'cannot push onto a Inf array';
# }

# nested arrayitems
{
    my @𝐩갮ò両 = ();
    push @𝐩갮ò両, $[ 21 ... 25 ];

    is(@𝐩갮ò両.elems,     1, 'nested arrayitem, array length is 1');
    is(@𝐩갮ò両[0].elems,  5, 'nested arrayitem, arrayitem length is 5');
    is(@𝐩갮ò両[0][0],    21, 'nested arrayitem, first value is 21');
    is(@𝐩갮ò両[0][*-1],  25, 'nested arrayitem, last value is 25');
}

# https://github.com/Raku/old-issue-tracker/issues/1340
{
    {
        my $ч = 1;
        my @a = ();
        push @a, $ч;
        ++$ч;

        is @a[0], 1, 'New element created by push(@a, $x) isn\'t affected by changes to $x';
    }
    {
        my $ч = 1;
        my @a = ();
        push @a, $ч;
        ++@a[0];

        is $ч, 1, '$x isn\'t affected by changes to new element created by push(@a, $x)';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2626
{
    my %両 = ( <foo> => []);
    push %両<foo>, my $е갨갨 = 'bar';
    is %両<foo>, 'bar', 'pushing assignment to array-in-hash';
}

# https://github.com/Raku/old-issue-tracker/issues/3196
{
    my Int @a;
    throws-like '@a.push: "a"', X::TypeCheck,
        "cannot push strings onto in Int array";
}

# https://github.com/Raku/old-issue-tracker/issues/2733
{
    class С专112660 { has Method @.slots; };
    throws-like 'RT112660.new.slots.push: [1, 2, 3]', X::TypeCheck::Assignment,
        'pushing non-A objects to an attribute array typed with A dies'
}

# R#2943
{
    dies-ok { my @a; push    @a, a => 52 }, 'no named on push()';
    dies-ok { my @a; append  @a, a => 52 }, 'no named on append()';
    dies-ok { my @a; unshift @a, a => 52 }, 'no named on unshifth()';
    dies-ok { my @a; prepend @a, a => 52 }, 'no named on prepend()';
}

# vim: expandtab shiftwidth=4
