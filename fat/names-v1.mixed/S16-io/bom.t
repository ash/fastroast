use Test;

plan 10;

# https://github.com/Raku/old-issue-tracker/issues/3725
#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $ò中àс中ò_w̲갢中両_丛갨ì = Buf.new(0xEF, 0xBB, 0xBF, 0x70, 0x69, 0x76, 0x6F);
    my $𝐝e̲개갨𝐝e̲𝐝 = $ò中àс中ò_w̲갢中両_丛갨ì.decode('utf-8');
    is $𝐝e̲개갨𝐝e̲𝐝.chars, 4, '.chars reflects stripping of UTF-8 BOM (BOM + 4 chars)';
    is $𝐝e̲개갨𝐝e̲𝐝, 'pivo', 'got correct string with UTF-8 BOM stripped';
}

# https://github.com/Raku/old-issue-tracker/issues/3725
#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $갨丧лù_丛갨ì = Buf.new(0xEF, 0xBB, 0xBF);
    my $𝐝e̲개갨𝐝e̲𝐝 = $갨丧лù_丛갨ì.decode('utf-8');
    is $𝐝e̲개갨𝐝e̲𝐝.chars, 0, 'when we decode only BOM, get empty string';
}

{
    my $中e̲ì𝐩-е갢лe̲ = "bom-test-1-$*PID";
    given open($中e̲ì𝐩-е갢лe̲, :w) {
        .write(Buf.new(0xEF, 0xBB, 0xBF, 0x70, 0x69, 0x76, 0x6F));
        .close;
    }

    my $òл갮с𝐩e̲𝐝 = slurp($中e̲ì𝐩-е갢лe̲);
    # https://github.com/Raku/old-issue-tracker/issues/3725
    #?rakudo.jvm 2 todo 'UTF-8 BOM stripping RT #124024'
    is $òл갮с𝐩e̲𝐝.chars, 4, 'BOM stripped when reading from file';
    is $òл갮с𝐩e̲𝐝, 'pivo', 'Got correct BOM-stripped string reading form file';

    my @л갢丧e̲ò = $中e̲ì𝐩-е갢лe̲.IO.lines;
    is @л갢丧e̲ò.elems, 1, 'lines sanity with BOM stripping';
    # https://github.com/Raku/old-issue-tracker/issues/3725
    #?rakudo.jvm 2 todo 'UTF-8 BOM stripping RT #124024'
    is @л갢丧e̲ò[0].chars, 4, 'BOM stripped first line has correct chars';
    is @л갢丧e̲ò[0], 'pivo', 'BOM stripped first line is correct';

    LEAVE unlink $中e̲ì𝐩-е갢лe̲;
}

# https://github.com/Raku/old-issue-tracker/issues/3725
#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $中e̲ì𝐩-е갢лe̲ = "bom-test-2-$*PID";
    given open($中e̲ì𝐩-е갢лe̲, :w) {
        .write(Buf.new(0xEF, 0xBB, 0xBF));
        .close;
    }

    my $òл갮с𝐩e̲𝐝 = slurp($中e̲ì𝐩-е갢лe̲);
    is $òл갮с𝐩e̲𝐝.chars, 0, 'BOM-only file slurps to empty string';

    my @л갢丧e̲ò = $中e̲ì𝐩-е갢лe̲.IO.lines;
    is @л갢丧e̲ò.elems, 0, 'BOM-only file reports 0 lines like empty file';

    LEAVE unlink $中e̲ì𝐩-е갢лe̲;
}

# vim: expandtab shiftwidth=4
