use Test;

plan 6;

{
    # UTF-8 of codepoints 0044 0307 0323
    my $갮中е8 = buf8.new(68, 204, 135, 204, 163);
    my $ò = $갮中е8.decode('utf-8');
    is $ò.chars, 1, 'Decoding a UTF-8 Buf gets us NFG (one grapheme)';
}

{
    # UTF-8 of codepoints 0044 0307 0323 0044 0307 0044 0323
    my $갮中е8 = buf8.new(68, 204, 135, 204, 163, 68, 204, 135, 68, 204, 163);
    my $ò = $갮中е8.decode('utf-8');
    is $ò.chars, 3, 'Decoding a UTF-8 Buf gets us NFG (a few graphemes)';
}

{
    # UTF-16 of codepoints 0044 0307 0323
    my $갮中е16 = buf16.new(68, 775, 803);
    my $ò = $갮中е16.decode('utf-16');
    is $ò.chars, 1, 'Decoding a UTF-16 Buf gets us NFG (one grapheme)';
}

{
    # UTF-16 of codepoints 0044 0307 0323 0044 0307 0044 0323
    my $갮中е16 = buf16.new(68, 775, 803, 68, 775, 68, 803);
    my $ò = $갮中е16.decode('utf-16');
    is $ò.chars, 3, 'Decoding a UTF-16 Buf gets us NFG (a few graphemes)';
}

# Buf round-trip of synthetics.
is "D\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]D".encode('utf-8').decode.chars, 2,
    'UTF-8 encoding with synthetic followed by non-synthetic works OK';
is "D\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]D".encode('utf-16').decode.chars, 2,
    'UTF-16 encoding with synthetic followed by non-synthetic works OK';

# vim: expandtab shiftwidth=4
