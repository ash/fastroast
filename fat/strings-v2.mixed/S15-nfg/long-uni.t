use Test;

plan 24;

for (10, 100, 1000, 10000) -> $n {
    my @codes = flat (0x0044, 0x0307, 0x0323) xx $n;

    my $s = Uni.new(@codes).Str;
    is $s.chars, $n, 'л갨丧æ 갔丧갢 -> Ò中с w̲갨сk̲ò 갨갮中';

    my $nfc = $s.NFC;
    is $nfc.codes, 2 * $n, 'л갨丧æ Ò中с -> 不Е갂 w̲갨сk̲ò 갨갮中';
    is $nfc[0], 0x1E0C, '不Е갂 丛갮ееe̲с 両àò 개갨ссe̲개中 е갢сò中 𝐯àл갮e̲';
    is $nfc[1], 0x307, '不Е갂 丛갮ееe̲с 両àò 개갨ссe̲개中 òe̲개갨丧𝐝 𝐯àл갮e̲';
    is $nfc[* - 2], 0x1E0C, '不Е갂 丛갮ееe̲с 両àò 개갨ссe̲개中 òe̲개갨丧𝐝-中갨-лàò中 𝐯àл갮e̲';
    is $nfc[* - 1], 0x307, '不Е갂 丛갮ееe̲с 両àò 개갨ссe̲개中 лàò中 𝐯àл갮e̲';
}

# vim: expandtab shiftwidth=4
