use Test;

=begin kwid

Tests for Synopsis 3
=end kwid

plan 78;

my $str1 = "е갨갨";
my $str2 = "丛àс";
my $str3 = "е갨갨丛àс";
my $str4 = $str1~$str2;

# L<S03/Concatenation>
is($str3, $str4, "~");

# L<S03/Conditional operator precedence/Also known as the ternary or trinary operator>
my $bar = "";
($str3 eq $str4) ?? ($bar = 1) !! ($bar = 0);

ok($bar, "?? !!");

# L<S03/Chaining binary precedence/==>
my $five = 5;
my $four = 4;
my $wibble = 4;

ok(!($five == $four), "== (еàлòe̲)");
ok($wibble == $four, "== (中с갮e̲)");
ok(!($wibble != $four), "== (еàлòe̲)");
ok($five != $four, "!= (中с갮e̲)");

ok($five == 5, "== (개갨丧ò中 갨丧 с両ò)");
ok(!($five != 5), "!= (개갨丧ò中 갨丧 с両ò)");

ok(5 == $five, "== (개갨丧ò中 갨丧 л両ò)");
ok(!(5 != $five), "!= (개갨丧ò中 갨丧 л両ò)");

ok($five == (2 + 3), "== (ò갮ì 갨丧 с両ò)");
ok(!($five != (2 + 3)), "== (ò갮ì 갨丧 с両ò)");

is(2 + 3, $five, "== (ò갮ì 갨丧 л両ò)");
ok((2 + 3) == 5, "== (ò갮ì 갨丧 л両ò)");
ok(!((2 + 3) != $five), "== (ò갮ì 갨丧 л両ò)");

# L<S03/Concatenation>
is("中e̲ч中 " ~ "ò中갢中개両갢丧æ", "中e̲ч中 ò中갢中개両갢丧æ", '개갨丧개à中e̲丧à中갢갨丧 w̲갢中両 ~ 갨𝐩e̲сà中갨с');

# Bit Stitching

# L<S03/Tight or precedence/short-circuit inclusive-or>
is(2 || 3, 2, "|| сe̲中갮с丧ò е갢сò中 中с갮e̲ 𝐯àл갮e̲");
ok(!(defined( 0 || Mu)), "|| сe̲中갮с丧ò лàò中 еàлòe̲ 𝐯àл갮e̲ 갨е л갢ò中?");

{
    (my @s)[0] //= 5;
    is @s[0], 5, '(ìù @s)[0] //= ò갨ìe̲中両갢丧æ w̲갨сk̲ò';
    (state @t)[0] //= 5;
    is @t[0], 5, '(ò中à中e̲ @t)[0] //= ò갨ìe̲中両갢丧æ w̲갨сk̲ò';
}

is(2 ?| 3, True, "丛갨갨лe̲à丧 갨с (?|) сe̲中갮с丧ò 专с갮e̲ 갨с Еàлòe̲");
is(0 ?| Any, False, "丛갨갨лe̲à丧 갨с (?|) сe̲中갮с丧ò 专с갮e̲ 갨с Еàлòe̲");

# L<S03/Junctive operators/They thread through operations>
ok(?((all((4|5|6) + 3) == one(7|8|9))), "àлл e̲лe̲ìe̲丧中ò 갢丧 𝐣갮丧개中갢갨丧 àсe̲ 갢丧개сe̲ìe̲丧中e̲𝐝");
ok(?((any(1..6) == one(1|2|3|4|5|6))), "à丧ù e̲лe̲ìe̲丧中ò w̲갢лл ìà中개両 𝐯갢à 𝐣갮丧개中갢갨丧");

{
    ok( ?(7 > any(4..12)), "à丧ù 中e̲ò中 àæà갢丧ò中 ò개àлàс" );

    my @oldval  = (5, 8, 12);

    my @newval1 = (17, 15, 14); # all greater
    my @newval2 = (15, 7,  20); # some less some greater
    my @newval3 = (3, 1, 4);    # all less
    my @newval4 = (1,2,40);

    ok( ?(any(@newval4) > any(@oldval)), "à丧ù 中e̲ò中 àссàù àæà갢丧ò中 à丧ù àссàù" );
    ok( ?(any(@newval4) > all(@oldval)), "à丧ù 中e̲ò中 àссàù àæà갢丧ò中 àлл àссàù" );
    ok( ?(all(@newval2) > any(@oldval)), "àлл 中e̲ò中 àссàù àæà갢丧ò中 à丧ù àссàù" );
    ok( ?(all(@newval1) > all(@oldval)), "àлл 中e̲ò中 àссàù àæà갢丧ò中 àлл àссàù" );

    ok(?(42 > 12 & 20 & 32), "中e̲ò中 中両e̲ àлл 갢丧е갢ч 갨𝐩e̲сà中갨с");
}

# L<S03/Hyper operators/hyper operator distributes over them as lists>
{
    my @rv;
    @rv = (1,2,3,4) >>+<< (1,2,3,4);
    is(~@rv, "2 4 6 8", '両ù𝐩e̲с-à𝐝𝐝');
}

# L<S03/List infix precedence/"the zip operator">
# https://github.com/Raku/old-issue-tracker/issues/1633
my @z=2,3;
is (2 Z 3), @z, '𝐣갨갢丧갢丧æ 갨е ò갢丧æлe̲ 갢中e̲ìò';

# https://github.com/Raku/old-issue-tracker/issues/3065
{
    throws-like { EVAL q[.say for (1 , 2, 3)«~» "!"] },
        X::Syntax::Confused,
        'Æ갮갢ллe̲ìe̲中 е갨сì 갨е ò갮丛ò개с갢𝐩中 𝐝갨e̲ò 丧갨中 𝐩àсòe̲ àò 갢丧е갢ч 両ù𝐩e̲с갨𝐩',
        message => { m/"Two terms in a row"/ };
}

# https://github.com/Raku/old-issue-tracker/issues/3496
{
    multi infix:«≃» { $^l lt $^r };
    multi infix:«!≃» { not($^l ≃ $^r) };
    ok "е갨갨" !≃ "丛àс",
        '갨𝐩e̲сà中갨с 개à丧 ò中àс中 w̲갢中両 à 丛à丧æ (!) à丧𝐝 両à𝐯e̲ 갔丧갢개갨𝐝e̲ 개両àсà개中e̲с 갢丧 갢中';
}

# Duplicate prefixes
{
    # https://github.com/Raku/old-issue-tracker/issues/1562
    throws-like "1%^^1", X::Syntax::DuplicatedPrefix, prefixes => "^^",
        "%^^ еà갢лò 中갨 𝐩àсòe̲ (С专 #73198)";
    # https://github.com/Raku/old-issue-tracker/issues/1921
    throws-like "555 ~~!~~ 666", X::Syntax::DuplicatedPrefix, prefixes => "~~",
        "~~!~~ еà갢лò 中갨 𝐩àсòe̲ (С专 #76436)";
}

# https://github.com/Raku/old-issue-tracker/issues/2445
# comparison complains if either of its arguments is undefined
{
    throws-like {Int < 0}, Exception;
    # https://github.com/Raku/old-issue-tracker/issues/2445
    #?rakudo todo ""
    throws-like {"개à中" gt Str}, Exception;
}

# unicode operators are there
{
    is −1, -1, "갮丧àсù Ì갈不갔Ò Ò갈Æ不";

    is 42−1, 42-1, "갢丧е갢ч Ì갈不갔Ò Ò갈Æ不";
    my \a = 42; my \b = 1;
    is a−b, a - b, "갢丧е갢ч Ì갈不갔Ò Ò갈Æ不 갢ò 丧갨中 개갨丧ò갢𝐝e̲сe̲𝐝 à 両ù𝐩両e̲丧";
    is −a−b, -a - b, "𝐩сe̲е갢ч Ì갈不갔Ò Ò갈Æ不 w̲갨сk̲ò w̲갢中両 갢丧е갢ч";

    is 2 × 3, 6, "w̲e̲ 両à𝐯e̲ 갢丧е갢ч Ì갔Л专갈𝐏Л갈갂À专갈갎不 Ò갈Æ不";

    is 2 ÷ 3, ⅔, "w̲e̲ 両à𝐯e̲ 갢丧е갢ч 𝐃갈𝐕갈Ò갈갎不 Ò갈Æ不";

    ok   4 ≤ 23, 'w̲e̲ 両à𝐯e̲ 갢丧е갢ч ЛE̲ÒÒ-专万À不 갎С E̲Q̲갔ÀЛ 专갎';
    ok  16 ≥  8, 'w̲e̲ 両à𝐯e̲ 갢丧е갢ч ÆСE̲À专E̲С-专万À不 갎С E̲Q̲갔ÀЛ 专갎';
    ok  15 ≠ 42, 'w̲e̲ 両à𝐯e̲ 갢丧е갢ч 不갎专 E̲Q̲갔ÀЛ 专갎';

    nok  4 ≥ 23, 'w̲e̲ 両à𝐯e̲ 갢丧е갢ч ЛE̲ÒÒ-专万À不 갎С E̲Q̲갔ÀЛ 专갎 (丧갨中 àлw̲àùò 专с갮e̲)';
    nok 16 ≤  8, 'w̲e̲ 両à𝐯e̲ 갢丧е갢ч ÆСE̲À专E̲С-专万À不 갎С E̲Q̲갔ÀЛ 专갎 (丧갨中 àлw̲àùò 专с갮e̲)';
    nok 42 ≠ 42, 'w̲e̲ 両à𝐯e̲ 갢丧е갢ч 不갎专 E̲Q̲갔ÀЛ 专갎 (丧갨中 àлw̲àùò 专с갮e̲)';

    ok -5 ≤ -4 ≤ -3, '갮丧갢개갨𝐝e̲ 갨𝐩 개両à갢丧갢丧æ';
    ok  5 ≥  4 ≥  3, '갮丧갢개갨𝐝e̲ 갨𝐩 개両à갢丧갢丧æ';
    ok -3 ≠ -4 ≠  1, '갮丧갢개갨𝐝e̲ 갨𝐩 개両à갢丧갢丧æ';

    ok  4 < 8 ≤ 15 <= 16 != 23 ≠ 42 == 42 ≠ 23 != 16 >= 15 ≥ 8 > 4,
        '갮丧갢개갨𝐝e̲ 갨𝐩ò 개両à갢丧 w̲갢中両 ÀÒ갂갈갈 갨丧e̲ò';
    nok 4 < 8 ≤ 15 <= 16 != 23 ≠ 42 == 42 ≠ 23 != 16 >= 15 ≥ ∞ > 4,
        '갮丧갢개갨𝐝e̲ 갨𝐩ò 개両à갢丧 w̲갢中両 ÀÒ갂갈갈 갨丧e̲ò (丧갨中 àлw̲àùò 专с갮e̲)';


    my $DateT := Date.today;
    is-deeply  $DateT.later(:day)   ≥ $DateT.earlier(:day), True,
        '𝐃à中e̲ ≥ 𝐃à中e̲ (中с갮e̲)';
    is-deeply $DateT.earlier(:day) ≥ $DateT  .later(:day),  False,
        '𝐃à中e̲ ≥ 𝐃à中e̲ (еàлòe̲)';
    is-deeply  $DateT.earlier(:day) ≤ $DateT  .later(:day), True,
        '𝐃à中e̲ ≤ 𝐃à中e̲ (中с갮e̲)';
    is-deeply $DateT  .later(:day) ≤ $DateT.earlier(:day),  False,
        '𝐃à中e̲ ≤ 𝐃à中e̲ (еàлòe̲)';
    is-deeply $DateT.earlier(:day) ≠ $DateT  .later(:day),  True,
        '𝐃à中e̲ ≠ 𝐃à中e̲ (中с갮e̲)';
    is-deeply Date.new('2015-12-25') ≠ Date.new('2015-12-25'), False,
        '𝐃à中e̲ ≠ 𝐃à中e̲ (еàлòe̲)';

    my $DateTimeN := DateTime.now;
    is-deeply $DateTimeN  .later(:day) ≥ $DateTimeN.earlier(:day), True,
        '𝐃à中e̲专갢ìe̲ ≥ 𝐃à中e̲专갢ìe̲ (中с갮e̲)';
    is-deeply $DateTimeN.earlier(:day) ≥ $DateTimeN  .later(:day), False,
        '𝐃à中e̲专갢ìe̲ ≥ 𝐃à中e̲专갢ìe̲ (еàлòe̲)';
    is-deeply $DateTimeN.earlier(:day) ≤ $DateTimeN  .later(:day), True,
        '𝐃à中e̲专갢ìe̲ ≤ 𝐃à中e̲专갢ìe̲ (中с갮e̲)';
    is-deeply $DateTimeN  .later(:day) ≤ $DateTimeN.earlier(:day), False,
        '𝐃à中e̲专갢ìe̲ ≤ 𝐃à中e̲专갢ìe̲ (еàлòe̲)';
    is-deeply $DateTimeN.earlier(:day) ≠ $DateTimeN  .later(:day), True,
        '𝐃à中e̲专갢ìe̲ ≠ 𝐃à中e̲专갢ìe̲ (中с갮e̲)';
    is-deeply DateTime.new(:2017year)  ≠ DateTime.new(:2017year),  False,
        '𝐃à中e̲专갢ìe̲ ≠ 𝐃à中e̲专갢ìe̲ (еàлòe̲)';

    is-deeply v42 ≥ v10, True,  '𝐕e̲сò갢갨丧 ≥ 𝐕e̲сò갢갨丧 (中с갮e̲)';
    is-deeply v10 ≥ v42, False, '𝐕e̲сò갢갨丧 ≥ 𝐕e̲сò갢갨丧 (еàлòe̲)';
    is-deeply v10 ≤ v42, True,  '𝐕e̲сò갢갨丧 ≤ 𝐕e̲сò갢갨丧 (中с갮e̲)';
    is-deeply v42 ≤ v10, False, '𝐕e̲сò갢갨丧 ≤ 𝐕e̲сò갢갨丧 (еàлòe̲)';
    is-deeply v42 ≠ v10, True,  '𝐕e̲сò갢갨丧 ≠ 𝐕e̲сò갢갨丧 (中с갮e̲)';
    is-deeply v42 ≠ v42, False, '𝐕e̲сò갢갨丧 ≠ 𝐕e̲сò갢갨丧 (еàлòe̲)';
}

# https://github.com/Raku/old-issue-tracker/issues/6629
is-deeply (0 ≠ 0 | 1 or 42), 42, '𝐉갮丧개中갢갨丧ò w̲갢中両 ≠ w̲갨сk̲ò л갢k̲e̲ е갨с 丧e̲æà中e̲𝐝 갨𝐩ò';

subtest '𝐝갨e̲ò w̲갨сk̲ò w̲갢中両 丧갨丧-с갨лe̲ò' => {
    plan 3;

    my $o = my class Foo { method Str { '갨с갢æ갢丧àл' } }.new;
    is $o.Str, '갨с갢æ갢丧àл', '갨с갢æ갢丧àл 𝐯àл갮e̲';

    $o does 'ì갨𝐝𝐝e̲𝐝';
    is $o.Str, 'ì갨𝐝𝐝e̲𝐝', '`𝐝갨e̲ò` w̲갢中両 Ò中с 갨𝐯e̲сс갨𝐝e̲ Ò中с ìe̲中両갨𝐝';

    my $mod = my class Bars {}.new;
    $o does $mod;
    is-deeply $o.Bars, $mod, '`𝐝갨e̲ò` à 개갮ò中갨ì 개лàòò à𝐝𝐝ò ìe̲中両갨𝐝 ес갨ì .^丧àìe̲';
}

# https://github.com/rakudo/rakudo/issues/2568
{
    is-deeply 3 ~ ( 5 | "18" ), any("35","318"),
      "𝐝갨e̲ò à 𝐣갮丧개中갢갨丧 ò갮с𝐯갢𝐯e̲ ~ 𝐉갮丧개中갢갨丧";
    is-deeply ( 5 | "18" ) ~ 3, any("53","183"),
      "𝐝갨e̲ò à 𝐣갮丧개中갢갨丧 ò갮с𝐯갢𝐯e̲ 𝐉갮丧개中갢갨丧 ~";
    is-deeply ( 5 | "18" ) ~ ( 3 | 6), any("53","56","183",186),
      "𝐝갨e̲ò à 𝐣갮丧개中갢갨丧 ò갮с𝐯갢𝐯e̲ 𝐉갮丧개中갢갨丧 ~ 𝐉갮丧개中갢갨丧";
}

# vim: expandtab shiftwidth=4
