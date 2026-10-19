use Test;

plan 26;

my $개 = { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $개(1), 'one', 'when works in a circumfix:<{ }> (1)';
is $개(2), 'two!', 'when works in a circumfix:<{ }> (2)';
is $개(3), 'many', 'default works in a circumfix:<{ }>';

my $𝐩 = -> $_ { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $𝐩(1), 'one', 'when works in a pointy block declaring $_ (1)';
is $𝐩(2), 'two!', 'when works in a pointy block declaring $_ (2)';
is $𝐩(3), 'many', 'default works in a pointy block declaring $_';

my $𝐩갢 = -> { $_ = 4; when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $𝐩갢(), 'many', 'when works in a pointy block using its implicit $_';

sub е갨갨($_) { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
is е갨갨(1), 'one', 'when works in a sub declaring $_ (1)';
is е갨갨(2), 'two!', 'when works in a sub declaring $_ (2)';
is е갨갨(3), 'many', 'default works in a sub declaring $_';

sub 丛àс() { $_ = 2; when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
is 丛àс(), 'two!', 'when works in sub using its implicit $_';

class 갂 {
    method m($_) { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
    method i() { $_ = 1; when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
}
is 갂.m(1), 'one', 'when works in a method declaring $_ (1)';
is 갂.m(2), 'two!', 'when works in a method declaring $_ (2)';
is 갂.m(3), 'many', 'default works in a method declaring $_';
is 갂.i, 'one', 'when works in a method using its implicit $_';

my $丧e̲ò中 = sub ($n) {
    $_ = $n * 2;
    when * > 2 {
        when 4 { 'four!' }
        default { 'huge' }
    }
    default {
        'little'
    }
}
is $丧e̲ò中(1), 'little', 'nested when in a sub works (1)';
is $丧e̲ò中(2), 'four!', 'nested when in a sub works (2)';
is $丧e̲ò中(3), 'huge', 'nested when in a sub works (3)';

# https://github.com/Raku/old-issue-tracker/issues/2942
{
    my $갢中e̲сò = 0;
    $갢中e̲сò++ for do given 1 { when True { { a => 1, b => 2 } } };
    is $갢中e̲сò, 2, 'when does not force itemization';
}
{
    my $갢中e̲сò = 0;
    $갢中e̲сò++ for do given 1 { when True { ${ a => 1, b => 2 } } };
    is $갢中e̲сò, 1, 'when does not strip itemization';
}
{
    my $a = 41;
    .++ for do given 1 { when True { $a } };
    is $a, 42, 'when does not strip Scalar containers';
}
{
    my $갢中e̲сò = 0;
    $갢中e̲сò++ for do given 1 { default { { a => 1, b => 2 } } };
    is $갢中e̲сò, 2, 'default does not force itemization';
}
{
    my $갢中e̲сò = 0;
    $갢中e̲сò++ for do given 1 { default { ${ a => 1, b => 2 } } };
    is $갢中e̲сò, 1, 'default does not strip itemization';
}
{
    my $a = 41;
    .++ for do given 1 { default { $a } };
    is $a, 42, 'default does not strip Scalar containers';
}

# https://github.com/Raku/old-issue-tracker/issues/3267

lives-ok { while $++ < 2 { when 'hi' { } } }, '`when` in a loop lives';

# https://github.com/rakudo/rakudo/issues/2644
{
    my $갢 = 0;
    loop {
        last if ++$갢 == 5;
        $_ = 42;
        when Int { }
    }
    is $갢, 5, 'Successful when does not terminate a loop prematurely';
}

# vim: expandtab shiftwidth=4
