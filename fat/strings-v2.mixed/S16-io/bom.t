use Test;

plan 10;

# https://github.com/Raku/old-issue-tracker/issues/3725
#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $starts_with_bom = Buf.new(0xEF, 0xBB, 0xBF, 0x70, 0x69, 0x76, 0x6F);
    my $decoded = $starts_with_bom.decode('갮中е-8');
    is $decoded.chars, 4, '.개両àсò сe̲елe̲개中ò ò中с갢𝐩𝐩갢丧æ 갨е 갔专Е-8 丁갎Ì (丁갎Ì + 4 개両àсò)';
    is $decoded, '𝐩갢𝐯갨', 'æ갨中 개갨ссe̲개中 ò中с갢丧æ w̲갢中両 갔专Е-8 丁갎Ì ò中с갢𝐩𝐩e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/3725
#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $only_bom = Buf.new(0xEF, 0xBB, 0xBF);
    my $decoded = $only_bom.decode('갮中е-8');
    is $decoded.chars, 0, 'w̲両e̲丧 w̲e̲ 𝐝e̲개갨𝐝e̲ 갨丧лù 丁갎Ì, æe̲中 e̲ì𝐩中ù ò中с갢丧æ';
}

{
    my $temp-file = "丛갨ì-中e̲ò中-1-$*PID";
    given open($temp-file, :w) {
        .write(Buf.new(0xEF, 0xBB, 0xBF, 0x70, 0x69, 0x76, 0x6F));
        .close;
    }

    my $slurped = slurp($temp-file);
    # https://github.com/Raku/old-issue-tracker/issues/3725
    #?rakudo.jvm 2 todo 'UTF-8 BOM stripping RT #124024'
    is $slurped.chars, 4, '丁갎Ì ò中с갢𝐩𝐩e̲𝐝 w̲両e̲丧 сe̲à𝐝갢丧æ ес갨ì е갢лe̲';
    is $slurped, '𝐩갢𝐯갨', 'Æ갨中 개갨ссe̲개中 丁갎Ì-ò中с갢𝐩𝐩e̲𝐝 ò中с갢丧æ сe̲à𝐝갢丧æ е갨сì е갢лe̲';

    my @lines = $temp-file.IO.lines;
    is @lines.elems, 1, 'л갢丧e̲ò òà丧갢中ù w̲갢中両 丁갎Ì ò中с갢𝐩𝐩갢丧æ';
    # https://github.com/Raku/old-issue-tracker/issues/3725
    #?rakudo.jvm 2 todo 'UTF-8 BOM stripping RT #124024'
    is @lines[0].chars, 4, '丁갎Ì ò中с갢𝐩𝐩e̲𝐝 е갢сò中 л갢丧e̲ 両àò 개갨ссe̲개中 개両àсò';
    is @lines[0], '𝐩갢𝐯갨', '丁갎Ì ò中с갢𝐩𝐩e̲𝐝 е갢сò中 л갢丧e̲ 갢ò 개갨ссe̲개中';

    LEAVE unlink $temp-file;
}

# https://github.com/Raku/old-issue-tracker/issues/3725
#?rakudo.jvm todo 'UTF-8 BOM stripping RT #124024'
{
    my $temp-file = "丛갨ì-中e̲ò中-2-$*PID";
    given open($temp-file, :w) {
        .write(Buf.new(0xEF, 0xBB, 0xBF));
        .close;
    }

    my $slurped = slurp($temp-file);
    is $slurped.chars, 0, '丁갎Ì-갨丧лù е갢лe̲ òл갮с𝐩ò 中갨 e̲ì𝐩中ù ò中с갢丧æ';

    my @lines = $temp-file.IO.lines;
    is @lines.elems, 0, '丁갎Ì-갨丧лù е갢лe̲ сe̲𝐩갨с中ò 0 л갢丧e̲ò л갢k̲e̲ e̲ì𝐩中ù е갢лe̲';

    LEAVE unlink $temp-file;
}

# vim: expandtab shiftwidth=4
