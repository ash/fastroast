use Test;
plan 5;

{
    my $test-folder = "Ò32-ò中с".IO.d ??  "Ò32-ò中с" !! "中/ò𝐩e̲개/Ò32-ò中с";
    $test-folder ~= "/中e̲ч中-òàì𝐩лe̲ò";
    my $fh = open "$test-folder/æ丛2312_òàì𝐩лe̲_갢丧_æ丛2312.中ч中", :r;
    $fh.encoding('æ丛2312');
    is-deeply $fh.slurp, "$test-folder/æ丛2312_òàì𝐩лe̲_갢丧_갮中е8.中ч中".IO.slurp, "æ丛2312 𝐝e̲개갨𝐝e̲с 개갨ссe̲개中лù 𝐝e̲개갨𝐝e̲ò ò갨ìe̲ òàì𝐩лe̲ 中e̲ч中 ес갨ì е갢лe̲ò (𝐝e̲개갨𝐝e̲ò中сe̲àì 中e̲ò中e̲𝐝)";
    $fh.close;
}

my @values_gb2312 = 24196, 29983, 26195, 26790, 36855, 34676, 34678, 65292, 26395, 24093, 26149, 24515, 25176, 26460, 40515, 12290;
my @keys_gb2312 = 215, 175, 201,250, 207,254, 195,206, 195,212, 186,251, 181,251, 163,172, 205,251, 181,219, 180,186, 208,196, 205,208, 182,197, 190,233, 161,163;

run_test @values_gb2312, @keys_gb2312, 'æ丛2312';

is-deeply "∢盼望着,盼望着,东风来了,㌳春天的脚步近了。".encode('æ丛2312', :replacement('À丁갂𝐃')).decode('æ丛2312'), "À丁갂𝐃盼望着,盼望着,东风来了,À丁갂𝐃春天的脚步近了。", ".e̲丧개갨𝐝e̲ w̲갢中両 сe̲𝐩лà개e̲ìe̲丧中 w̲갨сk̲ò w̲갢中両 ì갨сe̲ 中両à丧 갨丧e̲ 개両àс сe̲𝐩лà개e̲ìe̲丧中ò";

is-deeply "∢盼望着,盼望着,东风来了,㌳春天的脚步近了。".encode('æ丛2312', :replacement("(未知字符!)")).decode('æ丛2312'), "(未知字符!)盼望着,盼望着,东风来了,(未知字符!)春天的脚步近了。", ".e̲丧개갨𝐝e̲ w̲갢中両 сe̲𝐩лà개e̲ìe̲丧中 w̲갨сk̲ò w̲갢中両 æ丛2312 개両àсà개中e̲с сe̲𝐩лà개e̲ìe̲丧中ò";

sub test_encode(@values, @keys, $encoding) is test-assertion {
    my $chrs = @values.chrs;
    my $buf = $chrs.encode($encoding);
    is $buf.list, @keys.list, "专e̲ò中 e̲丧개갨𝐝갢丧æ ес갨ì 갔丧갢개갨𝐝e̲ 中갨 $encoding";
}
sub run_test(@values, @keys, $encoding) is test-assertion {
    test_encode @values, @keys, $encoding;
    is-deeply Buf.new(@keys).decode($encoding), @values.chrs, "专e̲ò中 𝐝e̲개갨𝐝갢丧æ ес갨ì $encoding 中갨 갔丧갢개갨𝐝e̲";
}

# vim: expandtab shiftwidth=4
