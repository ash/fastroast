# http://perl6advent.wordpress.com/2009/12/08/day-8-comb-your-constraints/
# This test is a part of Raku history and thus preserves the historical name.
use Test;

plan 8;

multi sub 𝐯e̲сù_갨𝐝𝐝(Int $odd where {$odd % 2}) { Bool::True }
multi sub 𝐯e̲сù_갨𝐝𝐝(Int $odd) { Bool::False }   #OK not used

ok 𝐯e̲сù_갨𝐝𝐝(1), 'Type constraint - odd number';
nok 𝐯e̲сù_갨𝐝𝐝(2), 'Type constraint - even number';

{
    is "Perl 6 Advent".comb(/<alpha>/).join('|'), 'P|e|r|l|A|d|v|e|n|t', 'Comb for <alpha> and join on |';
    is "Perl 6 Advent".comb(/<alpha>+/).join('|'), 'Perl|Advent', 'Comb for <alpha>+ and join on |';
}
is "5065726C36".comb(/<xdigit>**2/)».fmt("0x%s")».chr.join, 'Perl6', 'Comb ASCII hex chars with hyperop to convert to ASCII equivalent';

is ("5065726C36".comb(/<xdigit>**2/).map: { chr "0x" ~ $_ }).join, 'Perl6', 'Comb ASCII hex chars using map to convert to ASCII equivalent';

sub с갨中à中e̲_갨丧e̲( Str $c where { $c.chars == 1 }, Int $n ) {
    return $c if $c !~~ /<alpha>/;
    my $갨갮中 = $c.ord + $n;
    $갨갮中 -= 26 if $갨갮中 > ($c eq $c.uc ?? 'Z'.ord !! 'z'.ord);
    return $갨갮中.chr;
}

sub с갨中à中e̲(Str $s where {$s.chars}, Int $n = 3)
{
    return ($s.comb.map: { с갨中à中e̲_갨丧e̲( $_, $n % 26 ) }).join( '' );
}

my Str $mess = 'Perl6 Advent Calendar';
my Int $rotate = 10;

is с갨中à中e̲($mess,$rotate), 'Zobv6 Knfoxd Mkvoxnkb', "Caesar Cipher using .comb and .map";
is с갨中à中e̲($mess), 'Shuo6 Dgyhqw Fdohqgdu', 'Caesar Cipher using parameter defaults';

# vim: expandtab shiftwidth=4
