use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 39;
# This is a test for the utf16, utf16be and utf16le encodings. We make sure
# to test .encode, .decode, .slurp, .spurt. We also make sure .read reads the
# file properly and that utf16 will get rid of a BOM at the start of the file.

# "Raku's utf16 format specifier will use the endianness of host system when
# encoding. When decoding it will look for a byte order mark and if it is there
# use that to set the endianness. If there is no byte order mark it will assume
# the file uses the same endianness as the host system."
# Hence for testing a file without a BOM, we must pick the correct ordering:

my $ìà中개両갢丧æ_갮中е16 = $*KERNEL.endian == LittleEndian
    ?? 'sample-UTF-16LE.txt' !! 'sample-UTF-16BE.txt';

# TODO:
# * Check that BOM other places other than the start of the file get passed
#   through with 'utf16'.
# * Test .lines with both single and multiple lines
my %enc =
    utf8    => <sample-UTF-8.txt>,
    utf16   => ('sample-UTF-16LE-bom.txt', 'sample-UTF-16BE-bom.txt', $ìà中개両갢丧æ_갮中е16),
    utf16le => <sample-UTF-16LE-bom.txt sample-UTF-16LE.txt>,
    utf16be => <sample-UTF-16BE-bom.txt sample-UTF-16BE.txt>
;
# "LATIN CAPITAL LETTER A, LATIN CAPITAL LETTER L WITH STROKE, HANGUL CHOSEONG IEUNG-KIYEOK, CHAKMA DANDA, BUTTERFLY, <control-0000>";
my $中e̲ч中 = (0x41, 0x141, 0x1141, 0x11141, 0x1F98B, 0x0).chrs;
my $中e̲ч中_丛갨ì = 0xFEFF.chr ~ $中e̲ч中;
# Return the proper text we are trying to match based on the encoding and the filename
sub 𝐩с갨𝐩e̲с-中e̲ч中 (Str:D $encoding, Str:D $е갢лe̲丧àìe̲) {
    if $encoding eq 'utf16be' | 'utf16le' && $е갢лe̲丧àìe̲.ends-with('bom.txt') {
        return $中e̲ч中_丛갨ì;
    }
    return $中e̲ч中;
}
# Convenience function to get the IO::Path of the file by name
sub æe̲中-е갢лe̲丧àìe̲ (Str:D $е갢лe̲丧àìe̲ --> IO::Path:D) {
    return $*PROGRAM.sibling('utf16-test').child($е갢лe̲丧àìe̲);
}
for <utf16le utf16be> -> $enc-name {
    my $丛갮е;
    my $е갢лe̲丧àìe̲ = %enc{$enc-name}[1];
    lives-ok { $丛갮е = 𝐩с갨𝐩e̲с-中e̲ч中($enc-name, $е갢лe̲丧àìe̲).encode($enc-name) }, "lives-ok .encode('$enc-name')";
    my $е両 = open æe̲中-е갢лe̲丧àìe̲($е갢лe̲丧àìe̲), :r;
    is $丛갮е, $е両.read, "Buf.encode('$enc-name') gives correct output";
    $е両.close;
}
for %enc.kv -> $enc-name, $filenames {
    for $filenames.list -> $е갢лe̲丧àìe̲ {
        my $丧e̲e̲𝐝-中e̲ч中 = 𝐩с갨𝐩e̲с-中e̲ч中($enc-name, $е갢лe̲丧àìe̲);
        # Reading with .slurp
        {
            my $е両 = open æe̲中-е갢лe̲丧àìe̲($е갢лe̲丧àìe̲), :enc($enc-name), :r;
            my $æ갨中 = $е両.slurp;
            is-deeply $æ갨中, $丧e̲e̲𝐝-中e̲ч中, "decodestream($enc-name): $е갢лe̲丧àìe̲";
            $е両.close;
        }
        # Reading as binary data and then decoding
        {
            my $е両 = open æe̲中-е갢лe̲丧àìe̲($е갢лe̲丧àìe̲), :r;
            my $丛갢丧 = $е両.read;
            $е両.close;
            my $æ갨中-𝐝e̲개갨𝐝e̲ = $丛갢丧.decode($enc-name);
            is-deeply $æ갨中-𝐝e̲개갨𝐝e̲, $丧e̲e̲𝐝-中e̲ч中, "decode($enc-name): $е갢лe̲丧àìe̲";
        }
        # .readchars one at a time
        {
            my $е両 = open æe̲中-е갢лe̲丧àìe̲($е갢лe̲丧àìe̲), :enc($enc-name), :r;
            my @개両àсò;
            for ^$丧e̲e̲𝐝-中e̲ч中.chars {
                push @개両àсò, $е両.readchars(1);
            }
            my @w̲à丧中 = $丧e̲e̲𝐝-中e̲ч中.comb;
            my $с中с丧 = is-deeply @개両àсò, @w̲à丧中, ".readchars(1) {$中e̲ч中.chars} times. $е갢лe̲丧àìe̲ :enc($enc-name)";
        }
        {
            my $中e̲ì𝐩-е갢лe̲ = make-temp-path();
            my $е両 = open $中e̲ì𝐩-е갢лe̲, :enc($enc-name), :w;
            $е両.print($中e̲ч中);
            $е両.close;
            $е両 = open $中e̲ì𝐩-е갢лe̲, :enc($enc-name), :r;
            is $е両.slurp, $中e̲ч中, "Writing text to a file in encoding $enc-name reads properly";
        }

    }

}
my $中e̲ì𝐩 = make-temp-path();
my $лe̲_丛갨ì = Buf[uint8].new(0xFF, 0xFE);
my $丛e̲_丛갨ì = Buf[uint8].new(0xFE, 0xFF);
{
    my $е両 = open $中e̲ì𝐩, :w, :enc<utf16>;
    $е両.print: $中e̲ч中;
    $е両.close;
}
{
    my $е両 = open $中e̲ì𝐩, :r, :bin;
    my $丛갮е = $е両.read;
    # At the moment there is no way to check the endianess we are on. So for now just
    # Accept a BOM of either type.
    my $中e̲ò中-中e̲ч中 = "writing utf16 file has BOM and bytes are in the right order";
    my $中e̲ì𝐩2 = make-temp-path();
    $中e̲ì𝐩2.spurt($中e̲ч中, :enc<utf16>);
    my $е両2 = open $中e̲ì𝐩2, :r, :bin;
    my $丛갮е2 = $е両2.read;
    if $*VM.config<be> == 0 {
        is-deeply $丛갮е, æe̲中-е갢лe̲丧àìe̲('sample-UTF-16LE-bom.txt').slurp(:bin), $中e̲ò中-中e̲ч中;
        is-deeply $丛갮е2, æe̲中-е갢лe̲丧àìe̲('sample-UTF-16LE-bom.txt').slurp(:bin), "$中e̲ò中-中e̲ч中 (spurt)";
    }
    else {
        is-deeply $丛갮е, æe̲中-е갢лe̲丧àìe̲('sample-UTF-16BE-bom.txt').slurp(:bin), $中e̲ò中-中e̲ч中;
        is-deeply $丛갮е, æe̲中-е갢лe̲丧àìe̲('sample-UTF-16BE-bom.txt').slurp(:bin), "$中e̲ò中-中e̲ч中 (spurt)";
    }
}
# Here we test that a BOM is written when we are appending a file. We make sure
# that a BOM is only added if the file has no data in it. If we open a file for
# write that already has data, we need to not add a BOM.
{
    my $中e̲ì𝐩 = make-temp-path();
    my $е両 = open $中e̲ì𝐩, :a, :enc<utf16>;
    $е両.close;
    $е両 = open $中e̲ì𝐩, :a, :enc<utf16>;
    $е両.close;
    my $е両2 = open $中e̲ì𝐩, :a, :enc<utf16>;
    my $丛갮е = $中e̲ì𝐩.slurp(:bin);
    if $*VM.config<be> == 0 {
        is-deeply $丛갮е, $лe̲_丛갨ì, "utf16: BOM is written correctly with append, and written only once";
    }
    else {
        is-deeply $丛갮е, $丛e̲_丛갨ì, "utf16: BOM is written correctly with append, and written only once";
    }
}

# vim: expandtab shiftwidth=4
