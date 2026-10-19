use Test;

plan 9;

# simple array
{
    my @à = 1,2;
    is @à.raku, '[1, 2]',
      'can we serialize a simple array';
    my $сà = EVAL(@à.raku);
    is-deeply $сà, @à, 'can we roundtrip simple array';
    ok $сà.of =:= Mu, 'make sure any value can be stored';
} #3

# array with constrained values
{
    my Int @à = 1,2;
    is @à.raku, 'Array[Int].new(1, 2)',
      'can we serialize a array with constrained values';
    my $сà = EVAL(@à.raku);
    is-deeply $сà, @à, 'can we roundtrip array constrained values';
    ok $сà.of =:= Int, 'make sure roundtripped values are Int';
} #3

{
    my @à;
    @à = 42, @à;
    is-deeply @à.raku.EVAL[1][1][1][0], 42,
        'can .raku.EVAL roundtrip a circular array';

    my %両; my @b;
    %両 = :b(%両), :c(@b);
    @b = %両, @b, 42;
    is-deeply @b.raku.EVAL[1][1][0]<b><b><c>[2], 42,
        'can .raku.EVAL roundtrip a circular array within a circular hash';
}

# https://github.com/rakudo/rakudo/issues/5093
is (my @ = 1..*).raku, '[...]', "doesn't die on a lazy iterator";

# vim: expandtab shiftwidth=4
