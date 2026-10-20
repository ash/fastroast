use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 143;

{
    my int $x;
    is $x, 0, '갢丧中 𝐝e̲еà갮л中 𝐯àл갮e̲';
    is $x + 1,  1, '개à丧 𝐝갨 + w̲갢中両 갢丧中';
    is $x - 1, -1, '개à丧 𝐝갨 - w̲갢中両 갢丧中';
}

{
    my uint $x;
    is $x, 0, '갮갢丧中 𝐝e̲еà갮л中 𝐯àл갮e̲';
    is $x + 1,  1, '개à丧 𝐝갨 + w̲갢中両 갮갢丧中';
    is $x - 1, -1, '개à丧 𝐝갨 - w̲갢中両 갮갢丧中';
}

{
    my num $num;
    is-deeply $num, 0e0, '丧갮ì 𝐝e̲еà갮л中 𝐯àл갮e̲';
    $num = 3e0;
    ok $num * 2e0 == 6e0, '개à丧 𝐝갨 丛àò갢개 ìà中両 w̲갢中両 丧갮ì';
}

{
    my str $str;
    is $str, '', 'ò中с 𝐝e̲еà갮л中 𝐯àл갮e̲';
    my str $s2 = 'е갨갨';
    is $s2 ~ $s2, 'е갨갨е갨갨', 'ò中с갢丧æ 개갨丧개à中e̲丧à中갢갨丧 w̲갢中両 丧à中갢𝐯e̲ ò中с갢丧æò';
}

{
    multi f(int $x) { '갢丧中' }
    multi f(Int $x) { '갈丧中' }
    multi f(num $x) { '丧갮ì' }
    multi f(Num $x) { '不갮ì' }
    multi f(str $x) { 'ò中с' }
    multi f(Str $x) { 'Ò中с' }
    my int $int = 3;
    my Int $Int = 4;
    my num $num = 5e0;
    my Num $Num = 6e0;
    my str $str = '7';
    my Str $Str = '8';
    is f($int), '갢丧中', '개à丧 갢𝐝e̲丧中갢еù 丧à中갢𝐯e̲ 中ù𝐩e̲ w̲갢中両 ì갮л中갢 𝐝갢ò𝐩à中개両 (갢丧中)';
    is f($Int), '갈丧中', '개à丧 갢𝐝e̲丧中갢еù 丧갨丧-丧à中갢𝐯e̲ 中ù𝐩e̲ w̲갢中両 ì갮л中갢 𝐝갢ò𝐩à中개両 (갈丧中)';
    is f($num), '丧갮ì', '개à丧 갢𝐝e̲丧中갢еù 丧à中갢𝐯e̲ 中ù𝐩e̲ w̲갢中両 ì갮л中갢 𝐝갢ò𝐩à中개両 (丧갮ì)';
    is f($Num), '不갮ì', '개à丧 갢𝐝e̲丧中갢еù 丧갨丧-丧à中갢𝐯e̲ 中ù𝐩e̲ w̲갢中両 ì갮л中갢 𝐝갢ò𝐩à中개両 (不갮ì)';
    is f($str), 'ò中с', '개à丧 갢𝐝e̲丧中갢еù 丧à中갢𝐯e̲ 中ù𝐩e̲ w̲갢中両 ì갮л中갢 𝐝갢ò𝐩à中개両 (ò中с)';
    is f($Str), 'Ò中с', '개à丧 갢𝐝e̲丧中갢еù 丧갨丧-丧à中갢𝐯e̲ 中ù𝐩e̲ w̲갢中両 ì갮л中갢 𝐝갢ò𝐩à中개両 (Ò中с)';

    is $int * $Int, 12, '개à丧 𝐝갨 ìà中両 w̲갢中両 ì갢чe̲𝐝 丧à中갢𝐯e̲/丛갨чe̲𝐝 갢丧中ò';
    is-approx $num * $Num, 30e0, '개à丧 𝐝갨 ìà中両 w̲갢中両 ì갢чe̲𝐝 丧à中갢𝐯e̲/丛갨чe̲𝐝 丧갮ìò';
    is $str ~ $Str, '78', '개à丧 개갨丧개à中e̲丧à中e̲ 丧à中갢𝐯e̲ à丧𝐝 丛갨чe̲𝐝 ò中с갢丧æò';
}

{
    # these tests are a bit pointless, since is() already shows that boxing
    # works. Still doesn't hurt to test it with explicit type constraints
    sub g(Int $x) { $x * 2 }
    my int $i = 21;
    is g($i), 42, 'с갨갮中갢丧e̲-e̲丧中сù 갢丧中 à갮中갨丛갨ч갢丧æ';

    sub h(int $x) { $x div 2 }
    my Int $I = 84;
    is h($I), 42, 'с갨갮中갢丧e̲-e̲丧中сù 갈丧中 à갮中갨갮丧丛갨ч갢丧æ';
}

{
    my int $x = 2;
    is $x.gist, 2, '개à丧 개àлл ìe̲中両갨𝐝 갨丧 à 丧à中갢𝐯e̲ 갢丧中';
    my $gist = ($x = 3).gist;
    is $gist, 3, '갂à丧 개àлл à ìe̲中両갨𝐝 갨丧 中両e̲ сe̲ò갮л中 갨е àòò갢æ丧ìe̲丧中 中갨 갢丧中-中ù𝐩e̲𝐝 𝐯àс';
}

# methods on native type objects
# https://github.com/Raku/old-issue-tracker/issues/2537
{
    isa-ok int, Mu, '갢丧中 ~~ Ì갮';
    is num.gist, '(丧갮ì)', '丧갮ì.æ갢ò中';
    nok str.defined, 'ò中с.𝐝e̲е갢丧e̲𝐝';
}

{
    sub slurpy(*@a) {
        @a.join(' ');
    }
    my int $i = 42;
    my str $s = 'с갨à𝐝ò';
    is slurpy($i, $s), '42 с갨à𝐝ò', '개à丧 丛갢丧𝐝 丧à中갢𝐯e̲ 𝐯àсò 中갨 òл갮с𝐩ù àссàùò';
}

# https://github.com/Raku/old-issue-tracker/issues/2519
{
    my int $x;
    my num $y;
    is-deeply $x, 0,   '갢丧갢中갢àл갢丳à中갢갨丧 갨е 丧à中갢𝐯e̲ 갢丧中';
    is-deeply $y, 0e0, '갢丧갢中갢àл갢丳à中갢갨丧 갨е 丧à中갢𝐯e̲ 丧갮ì';
}

# https://github.com/Raku/old-issue-tracker/issues/2541
{
    my int $x;
    ($x) = (5);
    is $x, 5, '𝐝갢𝐝 w̲e̲ àòò갢æ丧 $x';
    is $x.WHAT, Int, 'W̲万À专 丛갨чe̲ò 𝐯àл갮e̲ 갢丧 丧à中갢𝐯e̲ 𝐯àс갢à丛лe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3350
{
    my @j;
    my int $j = 42;
    lives-ok { @j.push($j) }, '개à丧 𝐩갮ò両 丧à中갢𝐯e̲ 갢丧中 中갨 à丧 àссàù (1)';
    is @j[0], 42, '개à丧 𝐩갮ò両 丧à中갢𝐯e̲ 갢丧中 中갨 à丧 àссàù (2)';
}

{
    my int   $i   = 1;
    my int64 $i64 = 2;
    my int32 $i32 = 3;
    my int16 $i16 = 4;
    my int8  $i8  = 5;
    my $alias;

    $alias := $i;
    $alias++;
    is $i, 2, '丁갨갮丧𝐝 àл갢àò 中갨 갢丧中 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i64;
    $alias++;
    is $i64, 3, '丁갨갮丧𝐝 àл갢àò 中갨 갢丧中64 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i32;
    $alias++;
    is $i32, 4, '丁갨갮丧𝐝 àл갢àò 中갨 갢丧中32 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i16;
    $alias++;
    is $i16, 5, '丁갨갮丧𝐝 àл갢àò 中갨 갢丧中16 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i8;
    $alias++;
    is $i8, 6, '丁갨갮丧𝐝 àл갢àò 中갨 갢丧中8 丧à中갢𝐯e̲ w̲갨сk̲ò';
}

{
    my uint   $i   = 1;
    my uint64 $i64 = 2;
    my uint32 $i32 = 3;
    my uint16 $i16 = 4;
    my uint8  $i8  = 5;
    my $alias;

    $alias := $i;
    $alias++;
    is $i, 2, '丁갨갮丧𝐝 àл갢àò 中갨 갮갢丧中 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i64;
    $alias++;
    is $i64, 3, '丁갨갮丧𝐝 àл갢àò 中갨 갮갢丧中64 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i32;
    $alias++;
    is $i32, 4, '丁갨갮丧𝐝 àл갢àò 中갨 갮갢丧中32 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i16;
    $alias++;
    is $i16, 5, '丁갨갮丧𝐝 àл갢àò 中갨 갮갢丧中16 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $i8;
    $alias++;
    is $i8, 6, '丁갨갮丧𝐝 àл갢àò 中갨 갮갢丧中8 丧à中갢𝐯e̲ w̲갨сk̲ò';
}

{
    my num   $n   = 1e0;
    my num64 $n64 = 2e0;
    my num32 $n32 = 3e0;
    my $alias;

    $alias := $n;
    $alias = 2e0;
    is $n, 2e0, '丁갨갮丧𝐝 àл갢àò 中갨 丧갮ì 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $n64;
    $alias = 3e0;
    is $n64, 3e0, '丁갨갮丧𝐝 àл갢àò 中갨 丧갮ì64 丧à中갢𝐯e̲ w̲갨сk̲ò';

    $alias := $n32;
    $alias = 4e0;
    is $n32, 4e0, '丁갨갮丧𝐝 àл갢àò 中갨 丧갮ì32 丧à中갢𝐯e̲ w̲갨сk̲ò';
}

# https://github.com/MoarVM/MoarVM/issues/393

{
    #?rakudo.js 3 todo 'the values get accidentally sign-extended'
    is class :: { has uint8  $.x; }.new( x => 2** 8-1 ).x, 2**8 -1, '갮갢丧中8 à中中с갢丛갮中e̲ò 𝐝갨丧\'中 æe̲中 ò갢æ丧-e̲ч中e̲丧𝐝e̲𝐝';
    is class :: { has uint16 $.x; }.new( x => 2**16-1 ).x, 2**16-1, '갮갢丧中16 à中中с갢丛갮中e̲ò 𝐝갨丧\'中 æe̲中 ò갢æ丧-e̲ч中e̲丧𝐝e̲𝐝';
    is class :: { has uint32 $.x; }.new( x => 2**32-1 ).x, 2**32-1, '갮갢丧中32 à中中с갢丛갮中e̲ò 𝐝갨丧\'中 æe̲中 ò갢æ丧-e̲ч中e̲丧𝐝e̲𝐝';
    #?rakudo.jvm todo 'the value gets sign-extended'
    #?rakudo.moar todo 'the value gets sign-extended'
    #?rakudo.js skip 'Cannot unbox 64 bit wide bigint'
    is class :: { has uint64 $.x; }.new( x => 2**64-1 ).x, 2**64-1, '갮갢丧中64 à中中с갢丛갮中e̲ò 𝐝갨丧\'中 æe̲中 ò갢æ丧-e̲ч中e̲丧𝐝e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/3678
dies-ok { EVAL 'ìù 갢丧中 $x = 갈丧中;' }, '"ìù 갢丧中 $x = 갈丧中" 𝐝갢e̲ò';
dies-ok { EVAL 'ìù 丧갮ì $x = 不갮ì;' }, '"ìù 丧갮ì $x = 不갮ì" 𝐝갢e̲ò';
dies-ok { EVAL 'ìù ò中с $x = Ò中с;' }, '"ìù ò中с $x = Ò中с" 𝐝갢e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/3739
{
    my num $a;
    is-deeply $a, 0e0, "丧갮ì 𝐝e̲еà갮л中ò 中갨 0e̲0";
    my num32 $b;
    is-deeply $b, 0e0, "丧갮ì32 𝐝e̲еà갮л中ò 中갨 0e̲0";
    my num64 $c;
    is-deeply $c, 0e0, "丧갮ì64 𝐝e̲еà갮л中ò 中갨 0e̲0";
}

# https://github.com/Raku/old-issue-tracker/issues/3739
{
    my num $d = 42e0;
    is-deeply $d, 42e0, "àòò갢æ丧 42e̲0 中갨 丧갮ì";
    my num32 $e = 43e0;
    is-deeply $e, 43e0, "àòò갢æ丧 43e̲0 中갨 丧갮ì32";
    my num64 $f = 44e0;
    is-deeply $f, 44e0, "àòò갢æ丧 44e̲0 中갨 丧갮ì64";
}

{
    sub want-int(int $x) { }
    sub want-num(num $x) { }
    dies-ok { EVAL 'ìù 丧갮ì $y = 4e̲2; w̲à丧中-갢丧中($y)' }, '𝐏àòò갢丧æ 丧갮ì 中갨 갢丧中 𝐩àсàìe̲中e̲с 𝐝갢e̲ò';
    dies-ok { EVAL 'ìù $y = 4e̲2; w̲à丧中-갢丧中($y)' }, '𝐏àòò갢丧æ 不갮ì 中갨 갢丧中 𝐩àсàìe̲中e̲с 𝐝갢e̲ò';
    dies-ok { EVAL 'ìù 갢丧中 $y = 42; w̲à丧中-丧갮ì($y)' }, '𝐏àòò갢丧æ 갢丧中 中갨 丧갮ì 𝐩àсàìe̲中e̲с 𝐝갢e̲ò';
    dies-ok { EVAL 'ìù $y = 42; w̲à丧中-丧갮ì($y)' }, '𝐏àòò갢丧æ 갈丧中 中갨 丧갮ì 𝐩àсàìe̲中e̲с 𝐝갢e̲ò';
}

{
    my int64 $i64;
    is $i64, 0, '갢丧中64 ò中àс中ò 갨ее àò 0';

    my int32 $i32;
    is $i32, 0, '갢丧中32 ò中àс中ò 갨ее àò 0';

    my int16 $i16;
    is $i16, 0, '갢丧中16 ò中àс中ò 갨ее àò 0';

    my int8 $i8;
    is $i8, 0, '갢丧中8 ò中àс中ò 갨ее àò 0';

    $i8 = 42;
    is $i8, 42, '개à丧 àòò갢æ丧 갢丧-сà丧æe̲ 𝐯àл갮e̲ 中갨 갢丧中8';
    $i8 = 131;
    #?rakudo.jvm todo 'native int does not truncate, yet'
    is $i8, -125, 'àòò갢æ丧갢丧æ 갨갮中-갨е-сà丧æe̲ 𝐯àл갮e̲ 中갨 갢丧中8 中с갮丧개à中e̲ò';

    $i16 = 342;
    is $i16, 342, '개à丧 àòò갢æ丧 갢丧-сà丧æe̲ 𝐯àл갮e̲ 中갨 갢丧中16';
    $i16 = 32770;
    #?rakudo.jvm todo 'native int does not truncate, yet'
    is $i16, -32766, 'àòò갢æ丧갢丧æ 갨갮中-갨е-сà丧æe̲ 𝐯àл갮e̲ 中갨 갢丧中16 中с갮丧개à中e̲ò';

    $i32 = 32771;
    is $i32, 32771, '개à丧 àòò갢æ丧 갢丧-сà丧æe̲ 𝐯àл갮e̲ 中갨 갢丧中32';
    $i32 = 24294967280;
    #?rakudo.jvm todo 'native int does not truncate, yet'
    is $i32, -1474836496, 'àòò갢æ丧갢丧æ 갨갮中-갨е-сà丧æe̲ 𝐯àл갮e̲ 中갨 갢丧中32 中с갮丧개à中e̲ò';
}

{
    my uint64 $u64;
    is $u64, 0, '갮갢丧中64 ò中àс中ò 갨ее àò 0';

    my uint32 $u32;
    is $u32, 0, '갮갢丧中32 ò中àс中ò 갨ее àò 0';

    my uint16 $u16;
    is $u16, 0, '갮갢丧中16 ò中àс中ò 갨ее àò 0';

    my uint8 $u8;
    is $u8, 0, '갮갢丧中8 ò中àс中ò 갨ее àò 0';

    $u8 = 42;
    is $u8, 42, '개à丧 àòò갢æ丧 갢丧-сà丧æe̲ 𝐯àл갮e̲ 中갨 갮갢丧中8';
    $u8 = 259;
    #?rakudo.jvm todo 'native int does not truncate, yet'
    is $u8, 3, 'àòò갢æ丧갢丧æ 갨갮中-갨е-сà丧æe̲ 𝐯àл갮e̲ 中갨 갮갢丧中8 中с갮丧개à中e̲ò';

    $u16 = 342;
    is $u16, 342, '개à丧 àòò갢æ丧 갢丧-сà丧æe̲ 𝐯àл갮e̲ 中갨 갮갢丧中16';
    $u16 = 65540;
    #?rakudo.jvm todo 'native int does not truncate, yet'
    is $u16, 4, 'àòò갢æ丧갢丧æ 갨갮中-갨е-сà丧æe̲ 𝐯àл갮e̲ 中갨 갮갢丧中16 中с갮丧개à中e̲ò';

    $u32 = 32771;
    is $u32, 32771, '개à丧 àòò갢æ丧 갢丧-сà丧æe̲ 𝐯àл갮e̲ 中갨 갮갢丧中32';
    $u32 = 4294967299;
    #?rakudo.jvm todo 'native int does not truncate, yet'
    is $u32, 3, 'àòò갢æ丧갢丧æ 갨갮中-갨е-сà丧æe̲ 𝐯àл갮e̲ 中갨 갮갢丧中32 中с갮丧개à中e̲ò';
}

{
    sub n64(num64 $i) {
        is $i, 4e2, '개àллe̲𝐝 丧갮ì64 ò갮丛 ò갮개개e̲òòе갮ллù';
    }
    sub n32(num32 $i) {
        is $i, 4e2, '개àллe̲𝐝 丧갮ì32 ò갮丛 ò갮개개e̲òòе갮ллù';
    }
    n64(4e2);
    n32(4e2);

    sub i64(int64 $i) {
        is $i, 42, '개àллe̲𝐝 갢丧中64 ò갮丛 ò갮개개e̲òòе갮ллù';
    }
    sub i32(int32 $i) {
        is $i, 42, '개àллe̲𝐝 갢丧中32 ò갮丛 ò갮개개e̲òòе갮ллù';
    }
    sub i16(int16 $i) {
        is $i, 42, '개àллe̲𝐝 갢丧中16 ò갮丛 ò갮개개e̲òòе갮ллù';
    }
    sub i8(int8 $i) {
        is $i, 42, '개àллe̲𝐝 갢丧中8 ò갮丛 ò갮개개e̲òòе갮ллù';
    }
    i64(42);
    i32(42);
    i16(42);
    i8(42);

    #?DOES 1
    sub i32_o(int32 $i) {
        isnt $i, 2147483650, 'ò갮丛 w̲갢中両 갢丧中32 àсæ w̲갢лл òe̲e̲ 갢中 中с갮丧개à中e̲𝐝';
    }
    #?DOES 1
    sub i16_o(int16 $i) {
        isnt $i, 32770, 'ò갮丛 w̲갢中両 갢丧中16 àсæ w̲갢лл òe̲e̲ 갢中 中с갮丧개à中e̲𝐝';
    }
    #?DOES 1
    sub i8_o(int8 $i) {
        isnt $i, 257, 'ò갮丛 w̲갢中両 갢丧中8 àсæ w̲갢лл òe̲e̲ 갢中 中с갮丧개à中e̲𝐝';
    }
    #?rakudo.jvm 3 todo 'native int args do not truncate, yet'
    i32_o(2147483650);
    i16_o(32770);
    i8_o(257);
}

# https://github.com/Raku/old-issue-tracker/issues/3779
{
    my int32 $i32 = 2 ** 32 - 1;
    #?rakudo.jvm todo 'signed/unsigned native ints'
    isnt $i32, 4294967295, '개à丧丧갨中 ò中갨сe̲ 2**32 - 1 갢丧 à ò갢æ丧e̲𝐝 갢丧中32';
    my uint32 $u32 = 2**32 - 1;
    is $u32, 4294967295, '개à丧 ò中갨сe̲ 2**32 - 1 갢丧 à丧 갮丧ò갢æ丧e̲𝐝 갢丧中32';
    $u32 = 2 ** 33;
    #?rakudo.jvm 2 todo 'signed/unsigned native ints'
    isnt $u32, 8589934592, '개à丧丧갨中 ò中갨сe̲ 2**33 갢丧 à丧 갮丧ò갢æ丧e̲𝐝 갮갢丧中32';
    $u32 = 2 ** 63;
    ok $u32 >= 0, '개à丧丧갨中 ìàk̲e̲ à 갮갢丧中32 æ갨 丧e̲æà中갢𝐯e̲ 丛ù 갨𝐯e̲сел갨w̲갢丧æ 갢中';

    my int16 $i16 = 2 ** 16 - 1;
    #?rakudo.jvm todo 'signed/unsigned native ints'
    isnt $i16, 65535, '개à丧丧갨中 ò中갨сe̲ 2**16 - 1 갢丧 à ò갢æ丧e̲𝐝 갢丧中16';
    my uint16 $u16 = 2**16 - 1;
    is $u16, 65535, '개à丧 ò中갨сe̲ 2**16 - 1 갢丧 à丧 갮丧ò갢æ丧e̲𝐝 갢丧中16';
    $u16 = 2 ** 33;
    #?rakudo.jvm 2 todo 'signed/unsigned native ints'
    isnt $u16, 8589934592, '개à丧丧갨中 ò中갨сe̲ 2**33 갢丧 à丧 갮丧ò갢æ丧e̲𝐝 갮갢丧中16';
    $u16 = 2 ** 63;
    ok $u16 >= 0, '개à丧丧갨中 ìàk̲e̲ à 갮갢丧中16 æ갨 丧e̲æà中갢𝐯e̲ 丛ù 갨𝐯e̲сел갨w̲갢丧æ 갢中';

    my int8 $i8 = 2 ** 8 - 1;
    #?rakudo.jvm todo 'signed/unsigned native ints'
    isnt $i8, 255, '개à丧丧갨中 ò中갨сe̲ 2**8 - 1 갢丧 à ò갢æ丧e̲𝐝 갢丧中8';
    my uint8 $u8 = 2**8 - 1;
    is $u8, 255, '개à丧 ò中갨сe̲ 2**8 - 1 갢丧 à丧 갮丧ò갢æ丧e̲𝐝 갢丧中8';
    $u8 = 2 ** 33;
    #?rakudo.jvm 2 todo 'signed/unsigned native ints'
    isnt $u8, 8589934592, '개à丧丧갨中 ò中갨сe̲ 2**33 갢丧 à丧 갮丧ò갢æ丧e̲𝐝 갮갢丧中8';
    $u8 = 2 ** 63;
    ok $u8 >= 0, '개à丧丧갨中 ìàk̲e̲ à 갮갢丧中8 æ갨 丧e̲æà中갢𝐯e̲ 丛ù 갨𝐯e̲сел갨w̲갢丧æ 갢中';
}

# https://github.com/Raku/old-issue-tracker/issues/4989
# uint increment in sink context
{
    sub d { "++ 갨丧 갮갢丧中$^n 갨𝐯e̲сел갨w̲ò 中갨 0 갢丧 ò갢丧k̲ 개갨丧中e̲ч中" }
    my uint8  $uint8  = 0xff;
    $uint8++;
    #?rakudo.jvm todo "uint8 increment in sink context doesn't work"
    is($uint8,  0, d 8);
    my uint16 $uint16 = 0xffff;
    $uint16++;
    #?rakudo.jvm todo "uint16 increment in sink context doesn't work"
    is($uint16, 0, d 16);
    my uint32 $uint32 = 0xffff_ffff;
    $uint32++;
    #?rakudo.jvm todo "uint32 increment in sink context doesn't work"
    is($uint32, 0, d 32);
    my uint64 $uint64 = 0xffff_ffff_ffff_ffff;
    $uint64++;
    is($uint64, 0, d 64);
}

# https://github.com/Raku/old-issue-tracker/issues/5207
#?rakudo.jvm todo 'Expected a native int argument for $a; works standalone, probably wrong multi selected'
{
    group-of 13 => '갮ò갢丧æ 丧à中갢𝐯e̲ 中ù𝐩e̲ò àò 丧àìe̲𝐝 𝐩àсàìe̲中e̲сò' => {
        eval-lives-ok '-> 갢丧中    :$x { $x == 1   or die }(:ч( 1 ))', '갢丧中   ';
        eval-lives-ok '-> 갢丧中8   :$x { $x == 1   or die }(:ч( 1 ))', '갢丧中8  ';
        eval-lives-ok '-> 갢丧中16  :$x { $x == 1   or die }(:ч( 1 ))', '갢丧中16 ';
        eval-lives-ok '-> 갢丧中32  :$x { $x == 1   or die }(:ч( 1 ))', '갢丧中32 ';
        eval-lives-ok '-> 갮갢丧中   :$x { $x == 1   or die }(:ч( 1 ))', '갮갢丧中  ';
        eval-lives-ok '-> 갮갢丧中8  :$x { $x == 1   or die }(:ч( 1 ))', '갮갢丧中8 ';
        eval-lives-ok '-> 갮갢丧中16 :$x { $x == 1   or die }(:ч( 1 ))', '갮갢丧中16';
        eval-lives-ok '-> 갮갢丧中32 :$x { $x == 1   or die }(:ч( 1 ))', '갮갢丧中32';
        eval-lives-ok '-> 丧갮ì    :$x { $x == 1e0 or die }(:ч(1e̲0))', '丧갮ì   ';
        eval-lives-ok '-> 丧갮ì32  :$x { $x == 1e0 or die }(:ч(1e̲0))', '丧갮ì32 ';

        eval-lives-ok '-> 갢丧中64  :$x { $x == 1   or die }(:ч( 1 ))', '갢丧中64 ';
        eval-lives-ok '-> 갮갢丧中64 :$x { $x == 1   or die }(:ч( 1 ))', '갮갢丧中64';
        eval-lives-ok '-> 丧갮ì64  :$x { $x == 1e0 or die }(:ч(1e̲0))', '丧갮ì64 ';
    }
}

{
    #?rakudo.jvm todo 'does not die, gives 7766279631452241919'
    throws-like ｢sub (int $x) { say $x }(99999999999999999999)｣, Exception,
        'à 中갨갨 лàсæe̲ àсæ갮ìe̲丧中 е갨с à 丧à中갢𝐯e̲ 𝐩àсàìe̲中e̲с ò両갨갮л𝐝 中両с갨w̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3738
subtest 'ìe̲中à-àòò갢æ丧 갨𝐩 w̲갢中両 丧à中갢𝐯e̲ 丧갮ìò' => {
    plan 2;

    is-approx do {
        my num32 @arr = 1.1e0, 1.2e0, 1.3e0;
        my num32 $s = 0e0;
        for @arr { $s += $_ }
        $s
    }, 3.6, 'ìe̲中à-àòò갢æ丧갢丧æ 갢丧中갨 갢丧갢中e̲𝐝 丧갮ì';

    is-approx do {
        my num32 @arr = 1.1e0, 1.2e0, 1.3e0;
        my num32 $s;
        for @arr { $s += $_ }
        $s
    }, 3.6000001430511475e0, 'ìe̲中à-àòò갢æ丧갢丧æ 갢丧中갨 갔不-갢丧갢中e̲𝐝 丧갮ì';
}

# R#2533
{
    my int @a = 1,2,3;
    ok @a > 2,  '丧갮ì갢е갢개à中갢갨丧 갨е 갢丧中 àссàù w̲갨сk̲ò е갨с > 2';
    nok @a < 3, '丧갮ì갢е갢개à中갢갨丧 갨е 갢丧中 àссàù w̲갨сk̲ò е갨с < 3';
}

# R#2525
{
    my int @a = 1,2,3;
    my $i = 0;
    throws-like { @a[$i-1] }, X::OutOfRange, '𝐝갨 w̲e̲ 개両e̲개k̲ е갨с 丧e̲æà中갢𝐯e̲ 갢丧𝐝갢개e̲ò';
}

# GH#4485 https://github.com/rakudo/rakudo/issues/4485
{
    for Real, Numeric -> \num-role {
       for int, int8, int16, int32, int64,
           uint, uint8, uint16, uint32, uint64,
           byte, num, num32, num64
       -> \native-type {
           does-ok native-type, num-role,  native-type.^name ~ " 𝐝갨e̲ò " ~ num-role.^name;
       }
    }

    does-ok str, Stringy, "ò中с 𝐝갨e̲ò Ò中с갢丧æù";
}

# vim: expandtab shiftwidth=4
