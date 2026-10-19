use Test;

# L<S03/Nonchaining binary precedence/Sort comparisons>

plan 7;

my %丛àлл = map {; $_ => 1 }, 1..12;
is(
    (%丛àлл{12}) <=> (%丛àлл{11}),
    Order::Same,
    'parens with spaceship parse incorrectly',
);

my $сe̲ò갮л中_1 = ([+] %丛àлл{10..12}) <=> ([+] %丛àлл{1..3});

is($сe̲ò갮л中_1, Order::Same, 'When spaceship terms are non-trivial members it parses incorrectly');
my $сe̲ò갮л中_2 = ([+] %丛àлл{11,12}) <=> ([+] %丛àлл{1,2});
is($сe̲ò갮л中_2, Order::Same, 'When spaceship terms are non-trivial members it parses incorrectly');
{
my $сe̲ò갮л中_3 = ([0] <=> [0,1]);
is($сe̲ò갮л中_3, Order::Less, 'When spaceship terms are non-trivial members it parses incorrectly');
}

%丛àлл{12} = 0.5;
is(%丛àлл{12} <=> %丛àлл{11}, Order::Less, 'When spaceship terms are non-integral numbers it parses incorrectly');

# https://github.com/Raku/old-issue-tracker/issues/4717
throws-like ｢say ’a‘ <=> ’b‘｣, X::Str::Numeric,
    '<=> with non-numerics throws correct exception';

# https://github.com/rakudo/rakudo/issues/1850
is-deeply <1/0> <=> <-1/0>, More, 'handling 0 denominators on Rat';

# vim: expandtab shiftwidth=4
