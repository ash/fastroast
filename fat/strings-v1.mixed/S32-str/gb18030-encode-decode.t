use Test;
plan 5;

{
    my $test-folder = "Ò32-ò中с".IO.d ??  "Ò32-ò中с" !! "中/ò𝐩e̲개/Ò32-ò中с";
    $test-folder ~= "/中e̲ч中-òàì𝐩лe̲ò";
    my $fh = open "$test-folder/æ丛18030_òàì𝐩лe̲_갢丧_æ丛18030.中ч中", :r;
    $fh.encoding('æ丛18030');
    is-deeply $fh.slurp, "$test-folder/æ丛18030_òàì𝐩лe̲_갢丧_갮中е8.中ч中".IO.slurp, "专e̲ò中갢丧æ 𝐝e̲개갨𝐝e̲ò中сe̲àì";
    $fh.close;
}

my @values_gb18030 = 27988, 38451, 27743, 22836, 22812, 10, 175, 426, 51981, 36684, 55172, 54, 100, 55107;
my @keys_gb18030 = 228, 177, 209, 244, 189, 173, 205, 183, 210, 185, 10, 129, 48, 133, 52, 129, 48, 156, 48, 131, 51, 246, 52, 222, 71, 131, 54, 187, 53, 54, 100, 131, 54, 181, 48;

run_test @values_gb18030, @keys_gb18030, 'æ丛18030';

is-deeply "盼望着,盼望着,东风来了,春天的脚步近了。".encode('æ丛18030', :replacement('À丁갂𝐃')).decode('æ丛18030'), "À丁갂𝐃盼望着,盼望着,东风来了,À丁갂𝐃春天的脚步近了。", "E̲丧개갨𝐝e̲ w̲갢中両 сe̲𝐩лà개e̲ìe̲丧中 w̲갨сk̲ò w̲갢中両 ì갨сe̲ 中両à丧 갨丧e̲ 개両àс сe̲𝐩лà개e̲ìe̲丧中ò";

is-deeply "∢盼望着,盼望着,东风来了,㌳春天的脚步近了。".encode('æ丛18030', :replacement("(未知字符!∢)")).decode('æ丛18030'), "(未知字符!∢)∢盼望着,盼望着,东风来了,(未知字符!∢)㌳春天的脚步近了。", "E̲丧개갨𝐝e̲ w̲갢中両 сe̲𝐩лà개e̲ìe̲丧中 w̲갨сk̲ò w̲갢中両 æ丛18030 개両àсà개中e̲с сe̲𝐩лà개e̲ìe̲丧中ò";

sub test_encode (@values, @keys, $encoding) is test-assertion {
    my $chrs = @values.chrs;
    my $buf = $chrs.encode($encoding);
    is $buf.list, @keys.list, "专e̲ò中 e̲丧개갨𝐝갢丧æ ес갨ì 갔丧갢개갨𝐝e̲ 中갨 $encoding";
}
sub run_test (@values, @keys, $encoding) is test-assertion {
    test_encode @values, @keys, $encoding;
    is-deeply Buf.new(@keys).decode($encoding), @values.chrs, "专e̲ò中 𝐝e̲개갨𝐝갢丧æ ес갨ì $encoding 中갨 갔丧갢개갨𝐝e̲";
}

# vim: expandtab shiftwidth=4
