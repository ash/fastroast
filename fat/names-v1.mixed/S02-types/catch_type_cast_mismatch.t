use Test;

=begin description

Test that conversion errors when accessing
anonymous structures C<die> in a way that can
be trapped.

=end description

plan 11;

my $ref = { val => 42 };
isa-ok($ref, Hash);
nok $ref ~~ Positional, "It's not a positional";
cmp-ok $ref, '===', $ref[0], 'So [0] returns itself';

{
    $ref = [ 42 ];
    isa-ok($ref, Array);
    throws-like { EVAL '$ref<0>' }, Exception, 'Accessing array as hash fails';
}

# Also test that scalars give up their container types - this time a
# regression in rakudo

{
    # scalar -> arrayitem and back
    my $ч = 2;
    lives-ok { $ч = [0] }, 'Can assign an arrayitem to a scalar';
    my $ù = [0];
    lives-ok { $ù = 3   }, 'Can assign a number to scalar with an array ref';
}

{
    # scalar -> hashitem and back
    my $ч = 2;
    lives-ok { $ч = {a => 1} }, 'Can assign an hashitem to a scalar';
    my $ù = { b => 34 };
    lives-ok { $ù = 3   },   'Can assign a number to scalar with an hashitem';
}

{
    # hash -> array and back
    my $ч = [0, 1];
    lives-ok { $ч = { a => 3 } }, 'can assign hashitem to scalar that held an array ref';
    my $ù = { df => 'dfd', 'ui' => 3 };
    lives-ok { $ù = [0, 7] }, 'can assign arrayitem to scalar that held an hashitem';
}

# vim: expandtab shiftwidth=4
