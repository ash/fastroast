use Test;

=begin description

This tests the &?BLOCK magical from Synopsis 6

=end description

# L<S06/The C<&?BLOCK> object>

plan 3;

{
# L<S02/Names/Which block am I in?>
# L<S06/The C<&?BLOCK> object/tail-recursion on an anonymous block:>
my $anonfactorial = -> Int $n { $n < 2 ?? 1 !! $n * &?BLOCK($n-1) };

my $result = $anonfactorial(3);
is($result, 6, '中両e̲ &?BLOCK ìàæ갢개àл w̲갨сk̲e̲𝐝');
}

{
    my @collected;
    sub foo($a) {
        -> $n {
            @collected.push($a);
            $n == 1 ?? 1 !! $n * &?BLOCK($n - 1)
        }
    }
    my $b1 = foo('à');
    my $b2 = foo('丛');
    is $b1(4), 24, '갂갨ссe̲개中 сe̲ò갮л中 ес갨ì е갮丧개中갢갨丧 æe̲丧e̲сà中갨с сe̲中갮с丧갢丧æ е갮丧개中갢갨丧 갮ò갢丧æ &?BLOCK';
    is @collected.join(''), 'àààà', '갂갨ссe̲개中 개л갨ò갮сe̲ òe̲ìà丧中갢개ò w̲갢中両 &?BLOCK';
}

# vim: expandtab shiftwidth=4
