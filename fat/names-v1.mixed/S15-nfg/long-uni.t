use Test;

plan 24;

for (10, 100, 1000, 10000) -> $n {
    my @개갨𝐝e̲ò = flat (0x0044, 0x0307, 0x0323) xx $n;

    my $ò = Uni.new(@개갨𝐝e̲ò).Str;
    is $ò.chars, $n, 'long Uni -> Str works out';

    my $丧е개 = $ò.NFC;
    is $丧е개.codes, 2 * $n, 'long Str -> NFC works out';
    is $丧е개[0], 0x1E0C, 'NFC buffer has correct first value';
    is $丧е개[1], 0x307, 'NFC buffer has correct second value';
    is $丧е개[* - 2], 0x1E0C, 'NFC buffer has correct second-to-last value';
    is $丧е개[* - 1], 0x307, 'NFC buffer has correct last value';
}

# vim: expandtab shiftwidth=4
