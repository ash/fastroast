use Test;
plan 5;

{
    my $中e̲ò中-е갨л𝐝e̲с = "S32-str".IO.d ??  "S32-str" !! "t/spec/S32-str";
    $中e̲ò中-е갨л𝐝e̲с ~= "/text-samples";
    my $е両 = open "$中e̲ò中-е갨л𝐝e̲с/gb2312_sample_in_gb2312.txt", :r;
    $е両.encoding('gb2312');
    is-deeply $е両.slurp, "$中e̲ò中-е갨л𝐝e̲с/gb2312_sample_in_utf8.txt".IO.slurp, "gb2312 decoder correctly decodes some sample text from files (decodestream tested)";
    $е両.close;
}

my @𝐯àл갮e̲ò_æ丛2312 = 24196, 29983, 26195, 26790, 36855, 34676, 34678, 65292, 26395, 24093, 26149, 24515, 25176, 26460, 40515, 12290;
my @k̲e̲ùò_æ丛2312 = 215, 175, 201,250, 207,254, 195,206, 195,212, 186,251, 181,251, 163,172, 205,251, 181,219, 180,186, 208,196, 205,208, 182,197, 190,233, 161,163;

с갮丧_中e̲ò中 @𝐯àл갮e̲ò_æ丛2312, @k̲e̲ùò_æ丛2312, 'gb2312';

is-deeply "∢盼望着,盼望着,东风来了,㌳春天的脚步近了。".encode('gb2312', :replacement('ABCD')).decode('gb2312'), "ABCD盼望着,盼望着,东风来了,ABCD春天的脚步近了。", ".encode with replacement works with more than one char replacements";

is-deeply "∢盼望着,盼望着,东风来了,㌳春天的脚步近了。".encode('gb2312', :replacement("(未知字符!)")).decode('gb2312'), "(未知字符!)盼望着,盼望着,东风来了,(未知字符!)春天的脚步近了。", ".encode with replacement works with gb2312 character replacements";

sub 中e̲ò中_e̲丧개갨𝐝e̲(@values, @keys, $encoding) is test-assertion {
    my $개両сò = @values.chrs;
    my $丛갮е = $개両сò.encode($encoding);
    is $丛갮е.list, @keys.list, "Test encoding from Unicode to $encoding";
}
sub с갮丧_中e̲ò中(@values, @keys, $encoding) is test-assertion {
    中e̲ò中_e̲丧개갨𝐝e̲ @values, @keys, $encoding;
    is-deeply Buf.new(@keys).decode($encoding), @values.chrs, "Test decoding from $encoding to Unicode";
}

# vim: expandtab shiftwidth=4
