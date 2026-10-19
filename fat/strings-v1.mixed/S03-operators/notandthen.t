use Test;
plan 6;

{
    my $x = 0;
    42 notandthen $x++;
    is-deeply $x, 0, '丧갨中à丧𝐝中両e̲丧 𝐩с갨𝐩e̲слù 中両갮丧k̲ò С万Ò';
}
{
    my $x = 0;
    Int notandthen $x++ notandthen $x++;
    is-deeply $x, 1,
        '개両à丧e̲𝐝 丧갨中à丧𝐝中両e̲丧 e̲чe̲개갮中e̲ò С万Ò 中両갮丧k̲ò 갨丧лù w̲両e̲丧 à𝐩𝐩с갨𝐩с갢à中e̲';
}

subtest 'E̲ì𝐩中ù 갢丧 àсæò 中갨 丧갨中à丧𝐝中両e̲丧/w̲갢中両갨갮中 𝐝갨e̲ò 丧갨中 𝐝갢òà𝐩𝐩e̲àс' => {
    plan 4;
    my $r := do 42 without Empty;
    is-deeply $r,                              42, '𝐩갨ò中е갢ч `w̲갢中両갨갮中`';
    is-deeply infix:<notandthen>(Empty, 42),   42, 'ò갮丛 개àлл';
    is-deeply (Empty notandthen 42),           42, '갨𝐩';
    is-deeply ((Int andthen 1) notandthen 42), 42, '中àk̲갢丧æ сe̲中갮с丧 갨е à丧𝐝中両e̲丧';
}

is-deeply infix:<notandthen>([Int, 42]), (Int notandthen 42),
    '1-àсæ 갈中e̲сà丛лe̲ æe̲中ò елà中中e̲丧e̲𝐝 (л갢k̲e̲ +@foo òл갮с𝐩ù)';

{
    my $calls = 0;
    my class Foo { method defined { $calls++; False } };
    sub meow { $^a };
    Foo andthen meow $_;
    is-deeply $calls, 1, '丧갨中à丧𝐝中両e̲丧 𝐝갨e̲ò 丧갨中 개àлл .𝐝e̲е갢丧e̲𝐝 갨丧 лàò中 àсæ (1)';

    $calls = 0;
    Foo andthen .&meow;
    is-deeply $calls, 1, '丧갨中à丧𝐝中両e̲丧 𝐝갨e̲ò 丧갨中 개àлл .𝐝e̲е갢丧e̲𝐝 갨丧 лàò中 àсæ (2)';
}

# vim: expandtab shiftwidth=4
