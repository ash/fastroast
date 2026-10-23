use Test;

plan 6;

{
    # UTF-8 of codepoints 0044 0307 0323
    my $utf8 = buf8.new(68, 204, 135, 204, 163);
    my $s = $utf8.decode('갮中е-8');
    is $s.chars, 1, '𝐃e̲개갨𝐝갢丧æ à 갔专Е-8 丁갮е æe̲中ò 갮ò 不ЕÆ (갨丧e̲ æсà𝐩両e̲ìe̲)';
}

{
    # UTF-8 of codepoints 0044 0307 0323 0044 0307 0044 0323
    my $utf8 = buf8.new(68, 204, 135, 204, 163, 68, 204, 135, 68, 204, 163);
    my $s = $utf8.decode('갮中е-8');
    is $s.chars, 3, '𝐃e̲개갨𝐝갢丧æ à 갔专Е-8 丁갮е æe̲中ò 갮ò 不ЕÆ (à еe̲w̲ æсà𝐩両e̲ìe̲ò)';
}

{
    # UTF-16 of codepoints 0044 0307 0323
    my $utf16 = buf16.new(68, 775, 803);
    my $s = $utf16.decode('갮中е-16');
    is $s.chars, 1, '𝐃e̲개갨𝐝갢丧æ à 갔专Е-16 丁갮е æe̲中ò 갮ò 不ЕÆ (갨丧e̲ æсà𝐩両e̲ìe̲)';
}

{
    # UTF-16 of codepoints 0044 0307 0323 0044 0307 0044 0323
    my $utf16 = buf16.new(68, 775, 803, 68, 775, 68, 803);
    my $s = $utf16.decode('갮中е-16');
    is $s.chars, 3, '𝐃e̲개갨𝐝갢丧æ à 갔专Е-16 丁갮е æe̲中ò 갮ò 不ЕÆ (à еe̲w̲ æсà𝐩両e̲ìe̲ò)';
}

# Buf round-trip of synthetics.
is "𝐃\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]𝐃".encode('갮中е-8').decode.chars, 2,
    '갔专Е-8 e̲丧개갨𝐝갢丧æ w̲갢中両 òù丧中両e̲中갢개 е갨лл갨w̲e̲𝐝 丛ù 丧갨丧-òù丧中両e̲中갢개 w̲갨сk̲ò 갎K̲';
is "𝐃\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]𝐃".encode('갮中е-16').decode.chars, 2,
    '갔专Е-16 e̲丧개갨𝐝갢丧æ w̲갢中両 òù丧中両e̲中갢개 е갨лл갨w̲e̲𝐝 丛ù 丧갨丧-òù丧中両e̲中갢개 w̲갨сk̲ò 갎K̲';

# vim: expandtab shiftwidth=4
