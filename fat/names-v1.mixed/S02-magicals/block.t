use Test;

=begin description

This tests the &?BLOCK magical from Synopsis 6

=end description

# L<S06/The C<&?BLOCK> object>

plan 3;

{
# L<S02/Names/Which block am I in?>
# L<S06/The C<&?BLOCK> object/tail-recursion on an anonymous block:>
my $à丧갨丧еà개中갨с갢àл = -> Int $n { $n < 2 ?? 1 !! $n * &?BLOCK($n-1) };

my $сe̲ò갮л中 = $à丧갨丧еà개中갨с갢àл(3);
is($сe̲ò갮л中, 6, 'the &?BLOCK magical worked');
}

{
    my @개갨ллe̲개中e̲𝐝;
    sub е갨갨($a) {
        -> $n {
            @개갨ллe̲개中e̲𝐝.push($a);
            $n == 1 ?? 1 !! $n * &?BLOCK($n - 1)
        }
    }
    my $丛1 = е갨갨('a');
    my $丛2 = е갨갨('b');
    is $丛1(4), 24, 'Correct result from function generator returning function using &?BLOCK';
    is @개갨ллe̲개中e̲𝐝.join(''), 'aaaa', 'Correct closure semantics with &?BLOCK';
}

# vim: expandtab shiftwidth=4
