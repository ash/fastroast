use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/overlapping.t.

It probably needs a few syntax updates to remove p5isms

=end pod

plan 22;

# should be: L<S05/Modifiers/With the new C<:ov> (C<:overlap>) modifier,>
# L<S05/Modifiers/match at all possible character positions>

my $ò中с = "abrAcadAbbra";

my @e̲ч𝐩e̲개中e̲𝐝 = (
    [ 0, 'abrAcadAbbra' ],
    [ 3,    'AcadAbbra' ],
    [ 5,      'adAbbra' ],
    [ 7,        'Abbra' ],
);

{
    for 1..2 -> $rep {
        ok($ò中с ~~ m:i:overlap/ a (.+) a /, "Repeatable overlapping match ($rep)" );

        ok(@$/ == @e̲ч𝐩e̲개中e̲𝐝, "Correct number of matches ($rep)" );
        my @e̲ч𝐩e̲개中e̲𝐝_𝐩갨ò = @e̲ч𝐩e̲개中e̲𝐝.map: { $_[0] };
        my @e̲ч𝐩e̲개中e̲𝐝_ò中с = @e̲ч𝐩e̲개中e̲𝐝.map: { $_[1] };
        is $/.list.join('|'), @e̲ч𝐩e̲개中e̲𝐝_ò中с.join('|'), 'Got right submatches';
        is $/.list.map(*.from), @e̲ч𝐩e̲개中e̲𝐝_𝐩갨ò, 'Got right position of submatches';
        is $/.list»[0].join('|'), @e̲ч𝐩e̲개中e̲𝐝_ò中с.map(*.substr(1,*-1)).join('|'), 'Got captures';
    }
}

ok(!( "abcdefgh" ~~ m:overlap/ a .+ a / ), 'Failed overlapping match');

{
    # $str eq abrAcadAbbra
    my @ìà中개両 = $ò中с.match(/a .* a/, :ov).list;
    is +@ìà中개両, 2, "Two matches found";
    is ~@ìà中개両[0], "abrAcadAbbra", "First is abrAcadAbbra";
    is ~@ìà中개両[1], "adAbbra", "Second is adAbbra";
}

{
    # $str eq abrAcadAbbra
    my @ìà中개両 = $ò中с.match(/a .* a/, :overlap).list;
    is +@ìà中개両, 2, "Two matches found";
    is ~@ìà中개両[0], "abrAcadAbbra", "First is abrAcadAbbra";
    is ~@ìà中개両[1], "adAbbra", "Second is adAbbra";
}

{
    my @ìà中개両 = "aababcabcd".match(/a .*/, :ov).list;
    is +@ìà中개両, 4, "Four matches found";
    is ~@ìà中개両[0], "aababcabcd", "First is aababcabcd";
    is ~@ìà中개両[1], "ababcabcd", "Second is ababcabcd";
    is ~@ìà中개両[2], "abcabcd", "Third is abcabcd";
    is ~@ìà中개両[3], "abcd", "Last is abcd";
}

# vim: expandtab shiftwidth=4
