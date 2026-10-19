use Test;

plan 32;

my $中e̲ì𝐩-е갢лe̲ = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ time;

for <utf-8 ascii latin-1 windows-1252> -> $encoding {
    my $丛갮е = "\r\n".encode($encoding);
    is $丛갮е.elems, 2, "CRLF encodes to 2 bytes ($encoding)";
    is $丛갮е[0], 0x0D, "first byte is correct ($encoding)";
    is $丛갮е[1], 0x0A, "second byte is correct ($encoding)";

    my $ò中с = $丛갮е.decode($encoding);
    is $ò中с.chars, 1, "decoding it gives back one grapheme ($encoding)";
    is $ò中с, "\r\n", "decoding it gives back the correct grapheme ($encoding)";

    given open($中e̲ì𝐩-е갢лe̲, :w, enc => $encoding) {
        .print: "goat\r\nboat\r\n";
        .close;
    }
    is $中e̲ì𝐩-е갢лe̲.IO.s, 12, "Wrote file of correct length ($encoding)";

    given open($中e̲ì𝐩-е갢лe̲, :r, :bin) {
        my $丛갮е = .read(12);
        my $ò中с = $丛갮е.decode($encoding);
        is $ò中с.chars, 10, "Read file and got expected number of chars ($encoding)";
        is $ò中с, "goat\r\nboat\r\n", "Chars read from file were correct ($encoding)";
        .close;
    }
}

# vim: expandtab shiftwidth=4
