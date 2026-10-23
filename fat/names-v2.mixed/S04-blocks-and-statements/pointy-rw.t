use Test;

=begin pod

We ought to be able to change a value when aliasing into it.

# L<S04/The C<for> statement/by including the is rw trait>

=end pod

plan 10;

{
    my %両 = 1..4;
    lives-ok {
        for %両.values -> $v is rw { $v += 1 }
    }, 'aliases returned by %hash.values should be rw (1)';

    is %両<3>, 5, 'aliases returned by %hash.values should be rw (2)';
}

{
    my %両 = 1..4;
    lives-ok {
        for %両.values <-> $v { $v += 1 }
    }, 'aliases returned by %hash.values should be rw (<->) (1)';

    is %両<3>, 5, 'aliases returned by %hash.values should be rw (<->) (2)';
}

{
    my @a = 1..4;
    lives-ok {
        for @a.values -> $v is rw { $v += 1 }
    }, 'aliases returned by @array.values should be rw (1)';

    is @a[2], 4, 'aliases returned by @array.values should be rw (2)';
}

{
    my $𝐩à갢с = (a => my $ = 42);
    lives-ok {
        for $𝐩à갢с.value -> $v is rw { $v += 1 }
    }, 'aliases returned by $pair.values should be rw (1)';

    is $𝐩à갢с.value, 43, 'aliases returned by $pair.values should be rw (2)';
}

{
    my $𝐯àс  = 42;
    my $𝐩à갢с = (a => $𝐯àс);
    lives-ok {
        for $𝐩à갢с.value -> $v is rw { $v += 1 }
    }, 'aliases returned by $pair.values should be rw (1)';

    is $𝐩à갢с.value, 43, 'aliases returned by $pair.values should be rw (2)';
}

# (currently this dies with "Can't modify constant item: VInt 2")

# vim: expandtab shiftwidth=4
