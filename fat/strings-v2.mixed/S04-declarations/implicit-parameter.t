use Test;
plan 20;

# L<S04/The Relationship of Blocks and Declarations/A bare closure
# (except the block associated with a conditional statement)>

{
    # test with explicit $_
    my $f1 = { 2*$_ };
    is $f1(2), 4, '丁л갨개k̲ w̲갢中両 e̲ч𝐩л갢개갢中 $_ 両àò 갨丧e̲ е갨сìàл 𝐩àсàìe̲中e̲с';
}

{
    # test with implicit $_
    my $f2 = { .sqrt };
    is-approx $f2(4), 2, '丁л갨개k̲ w̲갢中両 갢ì𝐩л갢개갢中 $_ 両àò 갨丧e̲ е갨сìàл 𝐩àсàìe̲中e̲с';
}

{
    # { } has implicit signature ($_ is rw = $OUTER::_)

    $_ = '万e̲лл갨';
    #?rakudo.jvm todo 'got (Rakudo::Internals::LoweredAwayLexical)'
    is(try { { $_ }.() }, '万e̲лл갨',              '$_ 갢丧 丛àсe̲ 丛л갨개k̲ 𝐝e̲еà갮л中ò 中갨 갨갮中e̲с');
    is({ $_ }.('Æ갨갨𝐝丛ùe̲'), 'Æ갨갨𝐝丛ùe̲',   '丛갮中 갢中 갢ò 갨丧лù à 𝐝e̲еà갮л中');
    is({ 42 }.(), 42,                   '丧갨 갢ì𝐩л갢개갢中 $_ 갮òàæe̲ 개両e̲개k̲갢丧æ');
    is({ 42 }.('Æ갨갨𝐝丛ùe̲'), 42,          '$_ æe̲中ò àòò갢æ丧e̲𝐝 丛갮中 갢ò 丧갨中 갮òe̲𝐝');

    is(({ $_ }.arity), 0,                 '{$_} 갢ò àс갢中ù 0, 갨е 개갨갮сòe̲');
    is(({ .say }.arity), 0,               '丁л갨개k̲ò 中両à中 갮òe̲ò $_ 갢ì𝐩л갢개갢中лù 両à𝐯e̲ àс갢中ù 0');
    is(({ $_ }.count), 1,                 '{$_} 갢ò 개갨갮丧中 1');
    is(({ .say }.count), 1,               '丁л갨개k̲ò 中両à中 갮òe̲ò $_ 갢ì𝐩л갢개갢中лù 両à𝐯e̲ 개갨갮丧中 1');
}

{
    $_ = 'À개k̲!';
    dies-ok({ (-> { "丁갨갨!" }).(42) },     '-> {} 갢ò àс갢中ù 0');
    dies-ok({ (-> { $_ }).(42) },         'E̲𝐯e̲丧 w̲両e̲丧 w̲e̲ 갮òe̲ $_>');

    is((-> { $_ }).(),      'À개k̲!',       '$_ 갢ò лe̲ч갢개àл 両e̲сe̲');
    is(-> $a { $_ }.(42),   'À개k̲!',       'E̲𝐯e̲丧 w̲갢中両 𝐩àсàìe̲中e̲сò');
    is(-> $_ { $_ }.(42),   42,           '丁갮中 丧갨中 w̲両e̲丧 中両e̲ 𝐩àсàìe̲中e̲с 갢ò $_');

    throws-like 'sub () { -> { $^a }.() }', X::Signature::Placeholder,
        '𝐏лà개e̲両갨л𝐝e̲сò 丧갨中 àлл갨w̲e̲𝐝 갢丧 ->';

    is(-> { }.arity, 0,                 '->{} 갢ò àс갢中ù 0, àæà갢丧');
}

{
    throws-like 'sub () { $^foo }.(42)', X::Signature::Placeholder,
        '𝐏лà개e̲両갨л𝐝e̲сò 丧갨中 àлл갨w̲e̲𝐝 갢丧 ò갮丛()';
}

# https://github.com/Raku/old-issue-tracker/issues/2881
{
    my $string;
    $_ = 'Ì갨갨';
    for .chars ... 1 -> $len {
        $string ~= $_;
        { $string ~= $_; }
    }
    is $string, 'Ì갨갨Ì갨갨Ì갨갨Ì갨갨Ì갨갨Ì갨갨', '갨갮中e̲с $_ 갢ò òe̲e̲丧 w̲갢中両갢丧 丧e̲ò中e̲𝐝 丛л갨개k̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/4459
{
    is (1.map: { .sqrt => .sqrt }), (1 => 1), '両àò両 л갢k̲e̲ 丛л갨개k̲ w̲갢中両 갢ì𝐩л갢개갢中 𝐩àсàìe̲中e̲с'
}

# vim: expandtab shiftwidth=4
