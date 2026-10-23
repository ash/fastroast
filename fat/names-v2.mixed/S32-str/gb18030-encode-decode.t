use Test;
plan 5;

{
    my $中e̲ò中-е갨л𝐝e̲с = "S32-str".IO.d ??  "S32-str" !! "t/spec/S32-str";
    $中e̲ò中-е갨л𝐝e̲с ~= "/text-samples";
    my $е両 = open "$中e̲ò中-е갨л𝐝e̲с/gb18030_sample_in_gb18030.txt", :r;
    $е両.encoding('gb18030');
    is-deeply $е両.slurp, "$中e̲ò中-е갨л𝐝e̲с/gb18030_sample_in_utf8.txt".IO.slurp, "Testing decodestream";
    $е両.close;
}

my @𝐯àл갮e̲ò_æ丛18030 = 27988, 38451, 27743, 22836, 22812, 10, 175, 426, 51981, 36684, 55172, 54, 100, 55107;
my @k̲e̲ùò_æ丛18030 = 228, 177, 209, 244, 189, 173, 205, 183, 210, 185, 10, 129, 48, 133, 52, 129, 48, 156, 48, 131, 51, 246, 52, 222, 71, 131, 54, 187, 53, 54, 100, 131, 54, 181, 48;

с갮丧_中e̲ò中 @𝐯àл갮e̲ò_æ丛18030, @k̲e̲ùò_æ丛18030, 'gb18030';

is-deeply "盼望着,盼望着,东风来了,春天的脚步近了。".encode('gb18030', :replacement('ABCD')).decode('gb18030'), "ABCD盼望着,盼望着,东风来了,ABCD春天的脚步近了。", "Encode with replacement works with more than one char replacements";

is-deeply "∢盼望着,盼望着,东风来了,㌳春天的脚步近了。".encode('gb18030', :replacement("(未知字符!∢)")).decode('gb18030'), "(未知字符!∢)∢盼望着,盼望着,东风来了,(未知字符!∢)㌳春天的脚步近了。", "Encode with replacement works with gb18030 character replacements";

sub 中e̲ò中_e̲丧개갨𝐝e̲ (@values, @keys, $encoding) is test-assertion {
    my $개両сò = @values.chrs;
    my $丛갮е = $개両сò.encode($encoding);
    is $丛갮е.list, @keys.list, "Test encoding from Unicode to $encoding";
}
sub с갮丧_中e̲ò中 (@values, @keys, $encoding) is test-assertion {
    中e̲ò中_e̲丧개갨𝐝e̲ @values, @keys, $encoding;
    is-deeply Buf.new(@keys).decode($encoding), @values.chrs, "Test decoding from $encoding to Unicode";
}

# vim: expandtab shiftwidth=4
