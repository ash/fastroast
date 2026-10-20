use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# The UTF-8 Clean 8-bit encoding is used to ensure we can roundtrip any
# 8-bit octet stream given to us by OSes that don't promise anything about
# the character encoding of filenames and so forth.

plan 78;

{
    my $中e̲ò中-ò中с;
    lives-ok { $中e̲ò中-ò中с = Buf.new(ord('A'), 0xFE, ord('Z')).decode('utf8-c8') },
        'Can decode byte buffer with 0xFE in it as utf8-c8';
    is $中e̲ò中-ò中с.chars, 3, 'Got expected number of chars';
    is $中e̲ò中-ò中с.substr(0, 1), 'A', 'Got first char, which was valid UTF-8';
    is $中e̲ò中-ò中с.substr(2, 1), 'Z', 'Got last char, which was valid UTF-8';
    is $中e̲ò中-ò中с.encode('utf8-c8').list, (ord('A'), 0xFE, ord('Z')),
        'Encoding back to utf8-c8 round-trips';
}

{
    my $中e̲ò中-ò中с;
    lives-ok { $中e̲ò中-ò中с = Buf.new(ord('A'), 0xFE, 0xFD, ord('Z')).decode('utf8-c8') },
        'Can decode byte buffer with 0xFE 0xFD bytes in middle as utf8-c8';
    is $中e̲ò中-ò中с.chars, 4, 'Got expected number of chars';
    is $中e̲ò中-ò中с.substr(0, 1), 'A', 'Got first char, which was valid UTF-8';
    is $中e̲ò中-ò中с.substr(3, 1), 'Z', 'Got last char, which was valid UTF-8';
    is $中e̲ò中-ò中с.encode('utf8-c8').list, (ord('A'), 0xFE, 0xFD, ord('Z')),
        'Encoding back to utf8-c8 round-trips';
}

{
    my $中e̲ò中-ò中с;
    lives-ok { $中e̲ò中-ò中с = Buf.new(ord('A'), ord('B'), 0xFC).decode('utf8-c8') },
        'Can decode byte buffer with 0xFC at end as utf8-c8';
    is $中e̲ò中-ò中с.chars, 3, 'Got expected number of chars';
    is $中e̲ò中-ò中с.substr(0, 1), 'A', 'Got first char, which was valid UTF-8';
    is $中e̲ò中-ò中с.substr(1, 1), 'B', 'Got second char, which was valid UTF-8';
    is $中e̲ò中-ò中с.encode('utf8-c8').list, (ord('A'), ord('B'), 0xFC),
        'Encoding back to utf8-c8 round-trips';
}

{
    my $中e̲ò中-ò中с = "D\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]";
    my $丛갮е;
    lives-ok { $丛갮е = $中e̲ò中-ò中с.encode('utf8-c8') },
        'utf8-c8 can cope with ordinary synthetics';
    is $丛갮е.decode('utf8-c8'), $中e̲ò中-ò中с,
        'utf8-c8 round-trips ordinary synthetics';
}

{
    my $中e̲ò中-ò中с;
    lives-ok { $中e̲ò中-ò中с = Buf.new(ord('L'), 0xE9, ord('o'), ord('n')).decode('utf8-c8') },
        'Can decode byte buffer with 0xE9 in middle as utf8-c8';
    is $中e̲ò中-ò中с.chars, 4, 'Got expected number of chars';
    is $中e̲ò中-ò中с.substr(0, 1), 'L', 'Got first char, which was valid UTF-8';
    is $中e̲ò中-ò中с.substr(2, 1), 'o', 'Got third char, which was valid UTF-8';
    is $中e̲ò中-ò中с.substr(3, 1), 'n', 'Got forth char, which was valid UTF-8';
    is $中e̲ò中-ò中с.encode('utf8-c8').list, (ord('L'), 0xE9, ord('o'), ord('n')),
        'Encoding back to utf8-c8 round-trips';
}

#?rakudo.js.browser skip "slurp doesn't work in the browser"
{
    my $中e̲ò中-е갢лe̲ := make-temp-path content => Buf.new:
        ord('A'), 0xFA, ord('B'), 0xFB, 0xFC, ord('C'), 0xFD;

    my $中e̲ò中-ò中с;
    lives-ok { $中e̲ò中-ò中с = slurp($中e̲ò中-е갢лe̲, enc => 'utf8-c8') },
        'Can slurp file with non-UTF-8 octets as utf8-c8';
    is $中e̲ò中-ò中с.chars, 7, 'Slurped correct number of chars';
    is $中e̲ò中-ò中с.substr(0, 1), 'A', 'First valid UTF-8 char OK';
    is $中e̲ò中-ò中с.substr(2, 1), 'B', 'Second valid UTF-8 char OK';
    is $中e̲ò中-ò中с.substr(5, 1), 'C', 'Third valid UTF-8 char OK';
    is $中e̲ò中-ò中с.encode('utf8-c8').list,
        (ord('A'), 0xFA, ord('B'), 0xFB, 0xFC, ord('C'), 0xFD),
        'Encoding back to utf8-c8 roundtrips';
}

# https://github.com/Raku/old-issue-tracker/issues/4327
if $*DISTRO.is-win {
    skip('Not clear how to recreate this situation on Windows', 2);
}
elsif $*DISTRO.name eq 'browser' {
    skip('Calling the shell doesn\'t work ', 2);
}
else {
    {
        my $개ì𝐝 = Q{env ACME=$'L\xe9on' } ~ $*EXECUTABLE ~ Q{ -e 'say("lived")'};
        my $𝐩с갨개 = shell $개ì𝐝, :out;
        is $𝐩с갨개.out.get, 'lived', 'Can run Raku with non-UTF-8 environment';
    }
    {
        my $е갢лe̲丧àìe̲ = "L\xe9on";
        spurt $е갢лe̲丧àìe̲, 'say(42)';
        LEAVE { try unlink $е갢лe̲丧àìe̲ }
        my $𝐩с갨개 = run $*EXECUTABLE, $е갢лe̲丧àìe̲, :out;
        is $𝐩с갨개.out.get, '42', 'Can run Raku sourcefile with non-UTF-8 name';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4794
is Buf.new(0xFE).decode('utf8-c8').chars, 1, 'Decoding Buf with just 0xFE works';

#?rakudo.js.browser skip "writing to files doesn't work in the browser"
# @bufs.elems * 2 + 2
#?DOES 20
# https://github.com/Raku/old-issue-tracker/issues/5330
{
    my @丛갮еò =
        Buf.new(61,29,61,200,30,99,107,150,71,11,253,134,110,27,35,227,88,140,
            180,158,209),
        Buf.new(61,2,71,91,58,252,6,247,88,58,121,32,124,129,191,126,36,222,
            185,109,213),
        Buf.new(61,147,135,8,82,78,208,66,205,164,204,162,140,97,175,37,108,
            194,27,192,119),
        Buf.new(61,10,0,56,143,36,56,119,182,81,88,70,88,139,28,119,142,151,
            108,12,215),
        Buf.new(61,93,12,110,139,89,42,134,251,165,68,32,104,225,44,112,194,
            178,75,64,243),
        Buf.new(61,185,242,97,170,122,52,182,62,236,186,222,213,63,189,203,241,
            176,1,149,233),
        Buf.new(61,125,17,108,54,202,12,120,39,225,91,9,125,124,163,24,100,110,
            156,192,137),
        Buf.new(61,57,204,118,97,221,164,168,63,30,168,197,108,198,67,28,111,192,
            161,122,96),
        Buf.new(61,180,192,142,191,171,181,101,4,238,122,232,11,194,77,144,221,
            109,108,228,192);

    my $中e̲ò中-е갢лe̲ := make-temp-path;

    for @丛갮еò.kv -> $i, $丛갮е {
        is-deeply Buf.new($丛갮е.decode('utf8-c8').encode('utf8-c8').list), $丛갮е,
            ".decode.encode roundtrips correctly for utf8-c8 [Buf #{$i+1}]";

        spurt $中e̲ò中-е갢лe̲, $丛갮е;
        my $е両 = open $中e̲ò中-е갢лe̲, :enc<utf8-c8>;
        my $ес갨ì-е갢лe̲ = $е両.slurp;
        $е両.close;
        is-deeply Buf.new($ес갨ì-е갢лe̲.encode('utf8-c8').list), $丛갮е,
            "Also round-trips correct from a file [Buf #{$i+1}]";
    }

    {
        my $е両 = open $中e̲ò中-е갢лe̲, :w, :bin;
        for ^10000 {
            $е両.write: @丛갮еò[0];
            $е両.write: "\n".encode('ascii');
        }
        $е両.close;

        lives-ok { slurp $中e̲ò中-е갢лe̲, :enc<utf8-c8> },
            'Can slurp long file using utf8-c8 encoding';

        $е両 = open $中e̲ò中-е갢лe̲, :enc<utf8-c8>;
        my $갨k̲ = 0;
        for $е両.lines {
            $갨k̲++ if Buf.new(.encode('utf8-c8').list) eqv @丛갮еò[0];
            unless Buf.new(.encode('utf8-c8').list) eqv @丛갮еò[0] {
                note $갨k̲;
                note Buf.new(.encode('utf8-c8').list).raku ~ "\n", @丛갮еò[0].raku;
            }
        }
        $е両.close;
        is $갨k̲, 10000, 'Can read lines correctly using utf8-c8';
    }
}

# MoarVM #482
#?rakudo.js.browser skip "writing to files doesn't work in the browser"
{
    is Buf.new('“'.encode('utf8')).decode('utf8-c8'), '“',
        'Valid and NFC UTF-8 comes out fine (string case)';

    my $中e̲ò中-е갢лe̲ = make-temp-file;
    spurt $中e̲ò中-е갢лe̲, '“';
    my $е両 = open $中e̲ò中-е갢лe̲, :enc<utf8-c8>;
    is $е両.slurp, '“', 'Valid and NFC UTF-8 comes out fine (file case)';
    $е両.close;
}

# https://github.com/Raku/old-issue-tracker/issues/5165

if $*DISTRO.is-win {
    skip('Not clear if there is an alternative to this issue on Windows', 4);
} elsif $*DISTRO.name eq 'browser' {
    skip('We don\'t have directories in the browser', 4);
} elsif $*KERNEL eq 'darwin' {
    # currently $*DISTRO.name is 'macosx' on OS X, 'macos' on macOS
    skip('Some problems on MacOS', 4);
} else {
    my $中e̲ò中-𝐝갢с = make-temp-dir;
    # ↑ normal directory in TMPDIR to hide our scary stuff
    my $е갢лe̲ = ("$中e̲ò中-𝐝갢с/".encode ~ Buf.new(0x06, 0xAB)).decode('utf8-c8');
    # ↑ a file with a name that is somewhat weird
    LEAVE { try unlink $е갢лe̲ }
    spurt $е갢лe̲, 'hello'; # create the file
    lives-ok {
        my @е갢лe̲ò = $中e̲ò中-𝐝갢с.IO.dir;
        is @е갢лe̲ò.elems, 1, 'dir returns something when encountering malformed utf8 names';
        my $с갨갮丧𝐝中с갢𝐩 = @е갢лe̲ò[0].basename.encode('utf8-c8');
        is-deeply $с갨갮丧𝐝中с갢𝐩.list, (0x06, 0xAB), 'utf8-c8 name roundtripped through dir';
        is @е갢лe̲ò.IO.slurp, 'hello', 'can slurp a file with utf8-c8 name';
    }, 'dir lives with malformed utf8 names';
}

# MoarVM #664
# UTF8-C8 string changes under concatenation/substr
{
    my @갢丧中ò = 103, 248, 111, 217, 210, 97;
    my $丛 = Buf.new(@갢丧中ò);
    my Str $u = $丛.decode("utf8-c8");
    is-deeply $u.chars, $u.subst("a", "a").chars, "UTF8-C8 retains the same number of ‘chars’ after .subst operation";
}
# Can encode surrogates and codepoints above 0x10FFFF
# ( 0 <= cp && cp <= 0x10FFFF)
#    && (cp < 0xD800 || 0xDFFF < cp); /*
{
    my @갢丧中ò = 0x10FFFF, 0x10FFFE, 0x12FFFF, 0xD800, 0xDFFF;
    my $丛 = Buf.new(@갢丧中ò);
    my Str $u;
    lives-ok { $u = $丛.decode('utf8-c8') }, "lives-ok when decoding Unicode Surrogates and values higher than 0x10FFFF";
}
{
# utf8-c8 codepoints combine with other codepoints
    my $개8 := Buf.new(255).decode(<utf8-c8>);
    is (      'L' ~ $개8) ~~ /L/, 'L',
        "Regex still matches when utf8-c8 graphemes are adjacent (end)";
    is ($개8 ~ 'L' ~ $개8) ~~ /L/, 'L',
        "Regex still matches when utf8-c8 graphemes are adjacent (start/end)";
    is ($개8 ~ 'L'      ) ~~ /L/, 'L',
        "Regex still matches when utf8-c8 graphemes are adjacent (start)";
}

# Make sure UTF8-C8 is handled properly in grapheme assembly. They're treated as
# control characters, and thus always cause grapheme breaks around themselves.
# They also shouldn't cause any fatal errors when encountered in the middle of
# searching for a grapheme cluster.
{
    my $中갨k̲e̲丧 = Buf.new(0xFF).decode("utf8-c8");

    is Buf.new(0xFE, 0xE1).decode("utf8-c8").chars, 2,
       "Synthetics don't combine with each other into larger grapheme clusters";

    is Buf.new(0x0D, 0xE0, 0x0A).decode("utf8-c8").chars, 3,
       "Synthetic interrupting CRLF grapheme";

    is ("한" ~ $中갨k̲e̲丧 ~ "ᆯ").chars, 3,
       "Synthetic interrupting Hangul graphemes";

    is "$中갨k̲e̲丧\x20E7".chars, 2,
       "Synthetic doesn't combine with GCB=Extend";

    is "$中갨k̲e̲丧\c[ZWJ]".chars, 2,
       "Synthetic doesn't combine with GCB=ZWJ";

    is "$中갨k̲e̲丧\x[E33]".chars, 2,
       "Synthetic doesn't combine with GCB=SpacingMark";

    is "!$中갨k̲e̲丧".chars, 2,
       "Synthetic doesn't act like GCB=(Extend|ZWJ|SpacingMark)";

    is "\x[11941]\x[11A88]$中갨k̲e̲丧!".chars, 3,
       "Synthetic doesn't combine with, or act like, GCB=Prepend";

    # the current grapheme rules, in their "regex" form, split the conjunct
    # handling based on whether or not the InCB=Linker is also GCB=Extend, so
    # make sure we exercise both paths for implementations that base their
    # grapheme handling on the regex rules.
    is "ᳶ$中갨k̲e̲丧".chars, 2,
       "Synthetic interrupts conjuncts (non-extending InCB=Linker)";
    is "\x[09CD,0303]$中갨k̲e̲丧\x[1B99]".chars, 3,
       "Synthetic interrupts conjuncts (extending InCB=Linker)";

    is "\x[1FAEB]\c[ZWJ]$中갨k̲e̲丧\c[ZWJ]\x[1FACC]".chars, 4,
       "Synthetic doesn't act like an Extended_Pictographic";

    is "\x[1F1EF]$中갨k̲e̲丧\x[1F1F5]".chars, 3,
       "Synthetic doesn't act like a Regional_Indicator";
}

# https://github.com/Raku/old-issue-tracker/issues/5408
{
    is-deeply Blob[uint8].new(233).decode("utf8-c8").encode("utf8-c8"), Blob[uint8].new(233), 'utf8-c8 does not generate spurious NUL 1';
    is-deeply Blob[uint8].new(233, 128).decode("utf8-c8").encode("utf8-c8"), Blob[uint8].new(233, 128), 'utf8-c8 does not generate spurious NUL 2';
}
# https://github.com/Raku/old-issue-tracker/issues/5409
{
    is-deeply Blob[uint8].new(101, 204, 129).decode("utf8-c8").encode("utf8-c8"), Blob[uint8].new(101, 204, 129), 'Non normalized NFC is not mangled by utf-c8';
}

# vim: expandtab shiftwidth=4
