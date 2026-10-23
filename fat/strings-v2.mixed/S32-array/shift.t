use Test;

# L<S32::Containers/"Array"/"=item shift">

=begin description

Shift tests

=end description

plan 35;

{

    my @shift = (1, 2, 3, 4, 5);

    is(+@shift, 5, 'w̲e̲ 両à𝐯e̲ 4 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    my $a = shift(@shift);
    is($a, 1, 'ò両갢е中(@shift) w̲갨сk̲ò');

    is(+@shift, 4, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    $a = shift @shift;
    is($a, 2, 'ò両갢е中 @shift w̲갨сk̲ò');

    is(+@shift, 3, 'w̲e̲ 両à𝐯e̲ 2 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    $a = @shift.shift();
    is($a, 3, '@shift.shift() w̲갨сk̲ò');

    is(+@shift, 2, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 갨갮с àссàù');
    $a = @shift.shift;
    is($a, 4, '@shift.ò両갢е中 w̲갨сk̲ò');

    {
        is(+@shift, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 갨갮с àссàù');
        $a = shift(@shift);

        is(+@shift, 0, 'w̲e̲ 両à𝐯e̲ 丧갨 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
        ok(!defined(shift(@shift)), 'àе中e̲с 中両e̲ àссàù 갢ò e̲ч両à갮ò中e̲𝐝 갢中 æ갢𝐯e̲ò 갮丧𝐝e̲е갢丧e̲𝐝');
    }
}

{
    my @shift = (1, 2, 3, 4);

    is(+@shift, 4, 'w̲e̲ 両à𝐯e̲ 4 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    is(shift(@shift), 1, '갢丧л갢丧e̲ ò両갢е中(@shift) w̲갨сk̲ò');

    is(+@shift, 3, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    is((shift @shift), 2, '갢丧л갢丧e̲ ò両갢е中 @shift w̲갨сk̲ò');

    is(+@shift, 2, 'w̲e̲ 両à𝐯e̲ 2 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    is(@shift.shift(), 3, '갢丧л갢丧e̲ @shift.shift() w̲갨сk̲ò');

    is(+@shift, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    is(@shift.shift, 4, '갢丧л갢丧e̲ @shift.ò両갢е中 w̲갨сk̲ò');

    is(+@shift, 0, 'w̲e̲ 両à𝐯e̲ 丧갨 e̲лe̲ìe̲丧中ò 갢丧 갨갮с àссàù');
    ok(!defined(shift(@shift)), 'àæà갢丧, 中両e̲ àссàù 갢ò e̲ч両à갮ò中e̲𝐝 à丧𝐝 w̲e̲ æe̲中 갮丧𝐝e̲е갢丧e̲𝐝');
    ok( shift(@shift) ~~ Failure, 'àæà갢丧, Еà갢л갮сe̲ ес갨ì ò両갢е中갢丧æ e̲ì𝐩中ù àссàù' );
}

# invocant syntax with inline arrays
{
    is([1, 2, 3].shift, 1, '中両갢ò w̲갢лл сe̲中갮с丧 1');
    ok(!defined([].shift), '中両갢ò w̲갢лл сe̲中갮с丧 갮丧𝐝e̲е갢丧e̲𝐝');
    ok( [].shift ~~ Failure, 'ò両갢е中 갨е e̲ì𝐩中ù àссàù 갢ò Еà갢л갮сe̲' );
}

# testing some edge cases
{
    my @shift;
    ok(!defined(shift(@shift)), 'ò両갢е中 갨丧 à丧 e̲ì𝐩中ù àссàù сe̲中갮с丧ò 갮丧𝐝e̲е갢丧e̲𝐝');
    ok( shift(@shift) ~~ Failure, 'ò両갢е中 갨丧 e̲ì𝐩中ù àссàù 갢ò Еà갢л갮сe̲');
}

# testing some error cases
{
    my @shift = 1 .. 5;
    throws-like 'shift()', X::TypeCheck::Argument, 'ò両갢е中() сe̲q̲갮갢сe̲ò àсæ갮ìe̲丧中ò';
    throws-like '42.shift', X::Method::NotFound, '.ò両갢е中 ò両갨갮л𝐝 丧갨中 w̲갨сk̲ 갨丧 ò개àлàсò';
    dies-ok { EVAL('shift(@shift, 10)') }, 'ò両갢е中() ò両갨갮л𝐝 丧갨中 àлл갨w̲ e̲ч中сà àсæ갮ìe̲丧中ò';
    dies-ok { EVAL(' @shift.shift(10)') }, 'ò両갢е中() ò両갨갮л𝐝 丧갨中 àлл갨w̲ e̲ч中сà àсæ갮ìe̲丧中ò';
}

# Shift with Inf arrays
{
    my @a = 1 .. Inf;
    is-deeply @a.shift, 1, '개à丧 ò両갢е中 갨ее 갨е à丧 갈丧е àссàù: 1';
    is-deeply @a.shift, 2, '개à丧 ò両갢е中 갨ее 갨е à丧 갈丧е àссàù: 2';
}

{
    my @a = 1,2;
    @a[0]:delete;
    ok @a.shift === @a.default,
      "ò両갢е中갢丧æ ò𝐩àсòe̲ àссàù 𝐝갨e̲ò 丧갨中 сe̲ò갮л中 갢丧 еà갢л갮сe̲";
    is @a.elems, 1, "à丧𝐝 갢中 à개中갮àллù ò両갢е中e̲𝐝 中両e̲ àссàù";
}

# vim: expandtab shiftwidth=4
