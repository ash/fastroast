use Test;

plan 32;

my $temp-file = $*TMPDIR ~ '/中ì𝐩.' ~ $*PID ~ '-' ~ time;

for <utf-8 ascii latin-1 windows-1252> -> $encoding {
    my $buf = "\r\n".encode($encoding);
    is $buf.elems, 2, "갂СЛЕ e̲丧개갨𝐝e̲ò 中갨 2 丛ù中e̲ò ($encoding)";
    is $buf[0], 0x0D, "е갢сò中 丛ù中e̲ 갢ò 개갨ссe̲개中 ($encoding)";
    is $buf[1], 0x0A, "òe̲개갨丧𝐝 丛ù中e̲ 갢ò 개갨ссe̲개中 ($encoding)";

    my $str = $buf.decode($encoding);
    is $str.chars, 1, "𝐝e̲개갨𝐝갢丧æ 갢中 æ갢𝐯e̲ò 丛à개k̲ 갨丧e̲ æсà𝐩両e̲ìe̲ ($encoding)";
    is $str, "\r\n", "𝐝e̲개갨𝐝갢丧æ 갢中 æ갢𝐯e̲ò 丛à개k̲ 中両e̲ 개갨ссe̲개中 æсà𝐩両e̲ìe̲ ($encoding)";

    given open($temp-file, :w, enc => $encoding) {
        .print: "æ갨à中\r\n丛갨à中\r\n";
        .close;
    }
    is $temp-file.IO.s, 12, "W̲с갨中e̲ е갢лe̲ 갨е 개갨ссe̲개中 лe̲丧æ中両 ($encoding)";

    given open($temp-file, :r, :bin) {
        my $buf = .read(12);
        my $str = $buf.decode($encoding);
        is $str.chars, 10, "Сe̲à𝐝 е갢лe̲ à丧𝐝 æ갨中 e̲ч𝐩e̲개中e̲𝐝 丧갮ì丛e̲с 갨е 개両àсò ($encoding)";
        is $str, "æ갨à中\r\n丛갨à中\r\n", "갂両àсò сe̲à𝐝 ес갨ì е갢лe̲ w̲e̲сe̲ 개갨ссe̲개中 ($encoding)";
        .close;
    }
}

# vim: expandtab shiftwidth=4
