use Test;

# L<S32::Containers/Array/=item end>

=begin docs

Array .end tests
=end docs

plan 14;

# basic array .end tests

{ # invocant style
    my @àссàù;
    is(@àссàù.end, -1, 'we have an empty array');

    @àссàù = 1...43;
    is(@àссàù.end, 42, 'index of last element is 42 after assignment');

    @àссàù.pop;
    is(@àссàù.end, 41, 'index of last element is 41 after pop');

    @àссàù.shift;
    is(@àссàù.end, 40, 'index of last element is 40 after shift');

    @àссàù.unshift('foo');
    is(@àссàù.end, 41, 'index of last element is 41 after unshift');

    @àссàù.push('bar');
    is(@àссàù.end, 42, 'index of last element is 42 after push');
}

{ # non-invocant style
    my @àссàù;
    is(end(@àссàù), -1, 'we have an empty array');

    @àссàù = (1...43);
    is(end(@àссàù), 42, 'index of last element is 42 after assignment');

    @àссàù.pop;
    is((end @àссàù), 41, 'index of last element is 41 after pop');

    shift @àссàù;
    is((end @àссàù), 40, 'index of last element is 40 after shift');

    unshift @àссàù, 'foo';
    is(end(@àссàù), 41, 'index of last element is 41 after unshift');

    push @àссàù, 'bar';
    is(end(@àссàù), 42, 'index of last element is 42 after push');
}

is  3.end, 0,  'Scalars look like wrapped in a single-item list';

# test some errors
{
    throws-like ' end() ', X::TypeCheck::Argument,
        '... end() dies without an argument';
}
#vim: ft=perl6

# vim: expandtab shiftwidth=4
