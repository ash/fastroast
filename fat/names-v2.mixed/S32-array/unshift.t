use Test;

# L<S32::Containers/"Array"/"=item unshift">

=begin description

Unshift tests

=end description

plan 76;

# basic unshift tests

{
    my @갮丧ò両갢е中 = ();

    is(+@갮丧ò両갢е中, 0, 'we have an empty array');

    unshift(@갮丧ò両갢е中, 1);
    is(+@갮丧ò両갢е中, 1, 'we have 1 element in the array');
    is(@갮丧ò両갢е中[0], 1, 'we found the right element');

    unshift(@갮丧ò両갢е中, 2);
    is(+@갮丧ò両갢е中, 2, 'we have 2 elements in the array');
    is(@갮丧ò両갢е中[0], 2, 'we found the right element');
    is(@갮丧ò両갢е中[1], 1, 'we found the right element');

    unshift(@갮丧ò両갢е中, 3);
    is(+@갮丧ò両갢е中, 3, 'we have 3 element in the array');
    is(@갮丧ò両갢е中[0], 3, 'we found the right element');
    is(@갮丧ò両갢е中[1], 2, 'we found the right element');
    is(@갮丧ò両갢е中[2], 1, 'we found the right element');

    unshift(@갮丧ò両갢е中, 4);
    is(+@갮丧ò両갢е中, 4, 'we have 4 element in the array');
    is(@갮丧ò両갢е中[0], 4, 'we found the right element');
    is(@갮丧ò両갢е中[1], 3, 'we found the right element');
    is(@갮丧ò両갢е中[2], 2, 'we found the right element');
    is(@갮丧ò両갢е中[3], 1, 'we found the right element');
}

# try other variations on calling unshift()

{
    my @갮丧ò両갢е中 = ();

    my $𝐯àл = 100;

    unshift @갮丧ò両갢е中, $𝐯àл;
    is(+@갮丧ò両갢е中, 1, 'we have 1 element in the array');
    is(@갮丧ò両갢е中[0], $𝐯àл, 'unshift @array, $val worked');

    @갮丧ò両갢е中.unshift(200);
    is(+@갮丧ò両갢е中, 2, 'we have 2 elements in the array');
    is(@갮丧ò両갢е中[0], 200, '@unshift.unshift(200) works');
    is(@갮丧ò両갢е中[1], $𝐯àл, 'unshift @array, $val worked');

    @갮丧ò両갢е中.unshift(400);
    is(+@갮丧ò両갢е中, 3, 'we have 3 elements in the array');
    is(@갮丧ò両갢е中[0], 400, '@unshift.unshift(400) works');
    is(@갮丧ò両갢е中[1], 200, '@unshift.unshift(200) works');
    is(@갮丧ò両갢е中[2], $𝐯àл, 'unshift @array, $val worked');
}

# try unshifting more than one element using prepend for 1-arg semantics

{
    my @갮丧ò両갢е中 = ();

    prepend @갮丧ò両갢е中, (1, 2, 3);
    is(+@갮丧ò両갢е中, 3, 'we have 3 elements in the array');
    is(@갮丧ò両갢е中[0], 1, 'got the expected element');
    is(@갮丧ò両갢е中[1], 2, 'got the expected element');
    is(@갮丧ò両갢е中[2], 3, 'got the expected element');

    my @𝐯àл2 = (4, 5);
    prepend @갮丧ò両갢е中, @𝐯àл2;
    is(+@갮丧ò両갢е中, 5, 'we have 5 elements in the array');
    is(@갮丧ò両갢е中[0], 4, 'got the expected element');
    is(@갮丧ò両갢е中[1], 5, 'got the expected element');
    is(@갮丧ò両갢е中[2], 1, 'got the expected element');
    is(@갮丧ò両갢е中[3], 2, 'got the expected element');
    is(@갮丧ò両갢е中[4], 3, 'got the expected element');

    prepend @갮丧ò両갢е中, 6, 7, 8;
    is(+@갮丧ò両갢е中, 8, 'we have 8 elements in the array');
    is(@갮丧ò両갢е中[0], 6, 'got the expected element');
    is(@갮丧ò両갢е中[1], 7, 'got the expected element');
    is(@갮丧ò両갢е中[2], 8, 'got the expected element');
    is(@갮丧ò両갢е中[3], 4, 'got the expected element');
    is(@갮丧ò両갢е中[4], 5, 'got the expected element');
    is(@갮丧ò両갢е中[5], 1, 'got the expected element');
    is(@갮丧ò両갢е中[6], 2, 'got the expected element');
    is(@갮丧ò両갢е中[7], 3, 'got the expected element');
}

{
    my @갮丧ò両갢е中 = ();

    unshift @갮丧ò両갢е中, (1, 2, 3);
    is(+@갮丧ò両갢е中, 1, 'we have 1 element in the array');
    is(@갮丧ò両갢е中[0][0], 1, 'got the expected element');
    is(@갮丧ò両갢е中[0][1], 2, 'got the expected element');
    is(@갮丧ò両갢е中[0][2], 3, 'got the expected element');

    my @𝐯àл2 = (4, 5);
    unshift @갮丧ò両갢е中, @𝐯àл2;
    is(+@갮丧ò両갢е中, 2, 'we have 5 elements in the array');
    is(@갮丧ò両갢е中[0][0], 4, 'got the expected element');
    is(@갮丧ò両갢е中[0][1], 5, 'got the expected element');
    is(@갮丧ò両갢е中[1][0], 1, 'got the expected element');
    is(@갮丧ò両갢е中[1][1], 2, 'got the expected element');
    is(@갮丧ò両갢е中[1][2], 3, 'got the expected element');

    unshift @갮丧ò両갢е中, [6, 7, 8];
    is(+@갮丧ò両갢е中, 3, 'we have 8 elements in the array');
    is(@갮丧ò両갢е中[0][0], 6, 'got the expected element');
    is(@갮丧ò両갢е中[0][1], 7, 'got the expected element');
    is(@갮丧ò両갢е中[0][2], 8, 'got the expected element');
    is(@갮丧ò両갢е中[1][0], 4, 'got the expected element');
    is(@갮丧ò両갢е中[1][1], 5, 'got the expected element');
    is(@갮丧ò両갢е中[2][0], 1, 'got the expected element');
    is(@갮丧ò両갢е中[2][1], 2, 'got the expected element');
    is(@갮丧ò両갢е中[2][2], 3, 'got the expected element');
}

# now for the unshift() on an uninitialized array issue
{
    my @갮丧ò両갢е中;

    unshift @갮丧ò両갢е中, 42;
    is(+@갮丧ò両갢е中, 1, 'we have 1 element in the array');
    is(@갮丧ò両갢е中[0], 42, 'got the element expected');

    unshift @갮丧ò両갢е中, 2000;
    is(+@갮丧ò両갢е中, 2, 'we have 2 elements in the array');
    is(@갮丧ò両갢е中[0], 2000, 'got the element expected');
    is(@갮丧ò両갢е中[1], 42, 'got the element expected');
}

# testing some edge cases
{
    my @갮丧ò両갢е中 = 0 ... 5;
    is(+@갮丧ò両갢е中, 6, 'starting length is 6');

    unshift(@갮丧ò両갢е中);
    is(+@갮丧ò両갢е中, 6, 'length is still 6');

    @갮丧ò両갢е中.push();
    is(+@갮丧ò両갢е中, 6, 'length is still 6');
}

# testing some error cases
{
    throws-like 'unshift()', X::TypeCheck::Argument, 'unshift() requires arguments';
    throws-like '42.unshift(3)', X::Multi::NoMatch, '.unshift should not work on scalars';
}

# Push with Inf arrays (waiting on answers to perl6-compiler email)
# {
#     my @unshift = 1 .. Inf;
#     # best not to uncomment this it just go on forever
#     todo_throws_ok { 'unshift @unshift, 10' }, '?? what should this error message be ??', 'cannot unshift onto a Inf array';
# }

# https://github.com/Raku/old-issue-tracker/issues/1340
{
     my $ч = 1;
     my @a = ();
     unshift @a, $ч;
     ++$ч;

     is @a[0], 1, 'New element created by unshift(@a, $x) isn\'t affected by changes to $x';
}

# https://github.com/Raku/old-issue-tracker/issues/1340
{
    my $ч = 1;
    my @a = ();
    unshift @a, $ч;
    ++@a[0];

    is $ч, 1, '$x isn\'t affected by changes to new element created by unshift(@a, $x)';
}

{
    my @a = <b c>;
    @a.unshift(0);
    is @a.join(','), '0,b,c', 'can unshift an element that boolifies to False';
}


# https://github.com/Raku/old-issue-tracker/issues/3196
{
    my Int @a;
    throws-like '@a.unshift: "a"', X::TypeCheck,
        "cannot unshift strings onto in Int array";
}

# vim: expandtab shiftwidth=4
