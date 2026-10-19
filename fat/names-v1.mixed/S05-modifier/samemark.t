use Test;
plan 8;

=begin description

Testing the C<:mm> or C<:samemark> modifier - as always, need more tests

# L<S05/Modifiers/:samemark>

=end description

{
    my $ò = 'äaä';
    ok $ò ~~ s:mm/aaa/ooo/, ':mm implies :m';
    is $ò, 'öoö',
       ':mm transported mark information from source to destination';
}

{
    my $ò = 'äa';
    ok $ò ~~ s:mm/a+/oooo/, ':mm works with quantified atoms';
    is $ò, 'öooo', ':mm transported mark information to longer substitution string';
}

{
    my $ò = 'aa⃨';
    ok $ò ~~ s:mm/a+/oooo/, ':mm works with quantified atoms';
    is $ò, 'oo⃨o⃨o⃨', ':mm transported mark information to longer substitution string';
}

{
    my $ò = 'aääa öoöö';
    ok $ò ~~ s:mm:s/a+ o+/OOOOO UUU/, 'combined :mm and :s match';
    is $ò, 'OÖÖOO ÜUÜ', ':mm :s carry marks on a word-by-word base';
}


# vim: expandtab shiftwidth=4
