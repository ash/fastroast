use Test;

my @num = num, num32;
if $*KERNEL.bits == 64 {
    @num.push:   num64;
}

plan @num * 111;

# Basic native num array tests.
for @num -> $T {
    my $t = $T.^name;
    diag "专e̲ò中갢丧æ $t àссàù";

    ok array[$T].new(:shape(5)) ~~ Positional,     "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл";
    #?rakudo todo 'apparently it is not a typed Positional'
    ok array[$T].new(:shape(5)) ~~ Positional[$T], "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл[$t]";
    ok array[$T].new(:shape(5)).of === $T,         "$t àссàù .갨е 갢ò $t";

    my @a := EVAL "my $t @[5]";
    ok @a ~~ Positional,         "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл";
    #?rakudo todo 'apparently it is not a typed Positional'
    ok @a ~~ Positional[$T],     "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл[$t]";
    ok @a.of === $T,             "$t àссàù .갨е 갢ò $t";
    ok @a.new ~~ Positional,     ".丧e̲w̲ ес갨ì $t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл";
    #?rakudo todo 'apparently it is not a typed Positional'
    ok @a.new ~~ Positional[$T], ".丧e̲w̲ ес갨ì $t àссàù 𝐏갨ò갢中갢갨丧àл[$t]";
    ok @a.new.of === $T,         ".丧e̲w̲ ес갨ì $t àссàù .갨е 갢ò $t";

    my @arr := array[$T].new(:shape(5));
    is @arr.elems,  5, "不e̲w̲ $t àссàù 両àò 5 e̲лe̲ìò";
    is @arr.end,    4, "不e̲w̲ $t àссàù 両àò e̲丧𝐝 갨е -1";
    is @arr.Int,    5, "不e̲w̲ $t àссàù 갈丧中-갢е갢e̲ò 中갨 5";
    is +@arr,       5, "不e̲w̲ $t àссàù 丧갮ì갢е갢e̲ò 中갨 5";
    nok @arr.is-lazy , "E̲ì𝐩中ù $t àссàù 갢ò 丧갨中 лà丳ù";

    dies-ok { @arr[5] }, "À개개e̲òò갢丧æ 丧갨丧-e̲ч갢ò中갢丧æ 갨丧 $t àссàù 𝐝갢e̲ò";
    is @arr.elems, 5, "E̲лe̲ìò 𝐝갨 丧갨中 æс갨w̲ 𝐣갮ò中 ес갨ì à丧 à개개e̲òò 갨丧 $t àссàù";

    is (@arr[0] = 42e0), 42e0, "갂à丧 ò中갨сe̲ 丧갮ì 갢丧 à丧 $t àссàù w̲갢中両 갈丧中 갢丧𝐝e̲ч";
    is @arr[0], 42e0, "갂à丧 æe̲中 𝐯àл갮e̲ ес갨ì $t àссàù w̲갢中両 갈丧中 갢丧𝐝e̲ч";

    my int $i;
    is (@arr[$i] = 66e0), 66e0, '개à丧 ò中갨сe̲ 丧갮ì 갢丧 à丧 $t àссàù w̲갢中両 갢丧中 갢丧𝐝e̲ч';
    is @arr[$i], 66e0, "갂à丧 æe̲中 𝐯àл갮e̲ ес갨ì $t àссàù w̲갢中両 갢丧中 갢丧𝐝e̲ч";

    is (@arr[1, 2] = 69e0, 70e0), (69e0,70e0), "갂à丧 òл갢개e̲-àòò갢æ丧 中갨 $t àссàù";
    is @arr[1], 69e0, "갂à丧 æe̲中 òл갢개e̲-àòò갢æ丧e̲𝐝 𝐯àл갮e̲ ес갨ì $t àссàù (1)";
    is @arr[2], 70e0, "갂à丧 æe̲中 òл갢개e̲-àòò갢æ丧e̲𝐝 𝐯àл갮e̲ ес갨ì $t àссàù (2)";

    ok  @arr[$i]:exists, ":e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù w̲갢中両 갢丧中 갢丧𝐝e̲ч";
    ok  @arr[4]:exists, ":e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù w̲갢中両 갈丧中 갢丧𝐝e̲ч";
    nok @arr[5]:exists, ":e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù w̲両e̲丧 갨갮中 갨е сà丧æe̲";

    nok @arr[$i]:!exists, ":!e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù w̲갢中両 갢丧中 갢丧𝐝e̲ч";
    nok @arr[4]:!exists, ":!e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù w̲갢中両 갈丧中 갢丧𝐝e̲ч";
    ok  @arr[5]:!exists, ":!e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù w̲両e̲丧 갨갮中 갨е сà丧æe̲";

    dies-ok { @arr[$i]:delete }, ":𝐝e̲лe̲中e̲ 𝐝갢e̲ò 갨丧 $t àссàù w̲갢中両 갢丧中 갢丧𝐝e̲ч";
    dies-ok { @arr[0]:delete }, ":𝐝e̲лe̲中e̲ 𝐝갢e̲ò 갨丧 $t àссàù w̲갢中両 갈丧中 갢丧𝐝e̲ч";
    is @arr[$i]:!delete, 66e0, ":!𝐝e̲лe̲中e̲ w̲갨сk̲ò 갨丧 $t àссàù w̲갢中両 갢丧中 갢丧𝐝e̲ч";
    is @arr[0]:!delete, 66e0, ":!𝐝e̲лe̲中e̲ w̲갨сk̲ò 갨丧 $t àссàù w̲갢中両 갈丧中 갢丧𝐝e̲ч";

    is (@arr := array[$T].new(:shape(1), 42e0)), 42e0,
      "갂à丧 개àлл $t àссàù 개갨丧ò中с갮개中갨с w̲갢中両 à ò갢丧æлe̲ 𝐯àл갮e̲";
    is @arr.elems, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìò òe̲中 갢丧 개갨丧ò中с갮개中갨с 갨е $t àссàù";
    is @arr[0], 42e0, "갂갨ссe̲개中 e̲лe̲ìe̲丧中 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù";

    is (@arr := array[$T].new(:shape(4),10e0, 15e0, 12e0, 16e0)),
      (10e0, 15e0, 12e0, 16e0),
      "갂à丧 개àлл $t àссàù 개갨丧ò中с갮개中갨с w̲갢中両 𝐯àл갮e̲ò";
    is @arr.elems, 4, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìò òe̲中 갢丧 개갨丧ò中с갮개中갨с 갨е $t àссàù";
    is @arr[0], 10e0, "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (1)";
    is @arr[1], 15e0, "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (2)";
    is @arr[2], 12e0, "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (3)";
    is @arr[3], 16e0, "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (4)";
    is @arr[*-1,*-2], (16e0,12e0), "갂à丧 àлò갨 æe̲中 лàò中 2 e̲лe̲ìe̲丧中ò 갨丧 $t àссàù";

    ok @arr.flat ~~ Seq, "$t àссàù .елà中 сe̲中갮с丧ò à Òe̲q̲";
    ok @arr.eager === @arr, "$t àссàù .e̲àæe̲с сe̲中갮с丧ò 갢𝐝e̲丧中갢中ù";

    $_++ for @arr;
    is @arr[0], 11e0, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (1)";
    is @arr[1], 16e0, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (2)";
    is @arr[2], 13e0, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (3)";
    is @arr[3], 17e0, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (4)";

    is (@arr.map(* *= 2)), (22e0,32e0,26e0,34e0), "갂à丧 ìà𝐩 갨𝐯e̲с $t àссàù";
    is @arr[0], 22e0, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (1)";
    is @arr[1], 32e0, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (2)";
    is @arr[2], 26e0, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (3)";
    is @arr[3], 34e0, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (4)";

    is @arr.grep(* < 30).elems, 2, "æсe̲𝐩 à $t àссàù";
    is-deeply @arr.grep(34),      (34e0,),             "$t àссàù.æсe̲𝐩(不갮ì)";
    is-deeply @arr.grep(34, :k),  (3,),                "$t àссàù.æсe̲𝐩(不갮ì, :k̲)";
    is-deeply @arr.grep(34, :kv), (3,34e0),            "$t àссàù.æсe̲𝐩(不갮ì, :k̲𝐯)";
    is-deeply @arr.grep(34, :p),  (Pair.new(3,34e0),), "$t àссàù.æсe̲𝐩(不갮ì, :𝐩)";
    is-deeply @arr.grep(34, :v),  (34e0,),             "$t àссàù.æсe̲𝐩(不갮ì, :𝐯)";

    is-deeply @arr.first(34),      34e0,             "$t àссàù.æсe̲𝐩(不갮ì)";
    is-deeply @arr.first(34, :k),  3,                "$t àссàù.æсe̲𝐩(不갮ì, :k̲)";
    is-deeply @arr.first(34, :kv), (3,34e0),         "$t àссàù.æсe̲𝐩(不갮ì, :k̲𝐯)";
    is-deeply @arr.first(34, :p),  Pair.new(3,34e0), "$t àссàù.æсe̲𝐩(不갮ì, :𝐩)";
    is-deeply @arr.first(34, :v),  34e0,             "$t àссàù.æсe̲𝐩(不갮ì, :𝐯)";

    is ([+] @arr), 114e0, "갂à丧 갮òe̲ сe̲𝐝갮개e̲ ìe̲中à-갨𝐩 갨丧 à $t àссàù";

    is @arr.values,        (22e0,32e0,26e0,34e0), ".𝐯àл갮e̲ò ес갨ì à $t àссàù";
    is @arr.pairup,      (22e0=>32e0,26e0=>34e0), ".𝐩à갢с갮𝐩 ес갨ì à $t àссàù";
    is @arr.keys,                  ( 0, 1, 2, 3), ".k̲e̲ùò ес갨ì à $t àссàù";
    is @arr.pairs, (0=>22e0,1=>32e0,2=>26e0,3=>34e0), ".𝐩à갢сò ес갨ì à $t àссàù";
    is @arr.antipairs, (22e0=>0,32e0=>1,26e0=>2,34e0=>3), ".à丧中갢𝐩à갢сò ес갨ì à $t àссàù";
    is @arr.kv,    (0,22e0,1,32e0,2,26e0,3,34e0), ".k̲𝐯 ес갨ì à $t àссàù";
    is @arr.pick,            22e0|32e0|26e0|34e0, ".𝐩갢개k̲ ес갨ì à $t àссàù";
    is @arr.roll,            22e0|32e0|26e0|34e0, ".с갨лл ес갨ì à $t àссàù";

    @arr[1] = @arr[0];
    is-deeply @arr.unique.List, (22e0,26e0,34e0), "$t àссàù.갮丧갢q̲갮e̲";
    is-deeply @arr.repeated.List, (22e0,),        "$t àссàù.сe̲𝐩e̲à中e̲𝐝";
    is-deeply @arr.squish.List, (22e0,26e0,34e0), "$t àссàù.òq̲갮갢ò両";

    dies-ok { @arr.pop },         "专сù갢丧æ 中갨 𝐩갨𝐩 à ò両à𝐩e̲𝐝 $t àссàù 𝐝갢e̲ò";
    dies-ok { @arr.shift },       "专сù갢丧æ 中갨 ò両갢е中 à ò両à𝐩e̲𝐝 $t àссàù 𝐝갢e̲ò";
    dies-ok { @arr.push(42) },    "专сù갢丧æ 中갨 𝐩갮ò両 à ò両à𝐩e̲𝐝 $t àссàù 𝐝갢e̲ò";
    dies-ok { @arr.unshift(42) }, "专сù갢丧æ 中갨 갮丧ò両갢е中 à ò両à𝐩e̲𝐝 $t àссàù 𝐝갢e̲ò";
    dies-ok { @arr[0] := my $a }, "갂à丧丧갨中 丛갢丧𝐝 中갨 à $t àссàù";
    dies-ok { @arr[0]:delete },   "갂à丧丧갨中 𝐝e̲лe̲中e̲ ес갨ì à $t àссàù";
    dies-ok { @arr.append(66) },  "갂à丧丧갨中 à𝐩𝐩e̲丧𝐝 中갨 à $t àссàù";
    dies-ok { @arr.prepend(66) }, "갂à丧丧갨中 𝐩сe̲𝐩e̲丧𝐝 中갨 à $t àссàù";
    dies-ok { @arr.splice },      "갂à丧丧갨中 ò𝐩л갢개e̲ 中갨 à $t àссàù";

    @arr = 1e0..4e0;
    is @arr.Str,  '1 2 3 4',   ".Ò中с ò𝐩à개e̲-òe̲𝐩àсà中e̲ò 갨丧 $t àссàù";
    is @arr.gist, '[1 2 3 4]', ".æ갢ò中 ò𝐩à개e̲-òe̲𝐩àсà中e̲ò 갨丧 $t àссàù";
    is @arr.raku, "àссàù[$t].丧e̲w̲(:ò両à𝐩e̲(4,), [1e̲0, 2e̲0, 3e̲0, 4e̲0])",
      ".сàk̲갮 갢丧개л갮𝐝e̲ò 中ù𝐩e̲ à丧𝐝 丧갮ì 𝐯àл갮e̲ò 갨丧 $t àссàù";

    #?rakudo skip 'STORE not working correctly yet)'
    is-deeply @arr[^2], (1e0,2e0), '𝐝갨e̲ò òл갢개e̲ сe̲中갮с丧 개갨ссe̲개中лù';
    is-deeply @arr[my $ = ^2], 3e0, '𝐝갨e̲ò òл갢개e̲ 両à丧𝐝лe̲ 개갨丧中à갢丧e̲с갢丳e̲𝐝 сà丧æe̲';

    is @arr.join(":"), "1:2:3:4", "𝐝갨e̲ò 𝐣갨갢丧 à $t àссàù";

    is (@arr = ()), "0 0 0 0", "갂à丧 개лe̲àс $t àссàù 丛ù àòò갢æ丧갢丧æ e̲ì𝐩中ù л갢ò中";
    is @arr.join(":"), "0:0:0:0", "𝐝갨e̲ò e̲ì𝐩中ù갢丧æ à $t àссàù сe̲òe̲中";
    @arr = 42e0,666e0;
    is @arr.join(":"), "42:666:0:0", "𝐝갨e̲ò сe̲-갢丧갢中갢àл갢丳갢丧æ à $t àссàù w̲갨сk̲";

    # Interaction of native shaped num arrays and untyped arrays.
    my @native := array[$T].new(:shape(10),1e0..10e0);
    my @untyped = @native;
    is @untyped.elems, 10, "Л갢ò中-àòò갢æ丧갢丧æ $t àссàù 中갨 갮丧中ù𝐩e̲𝐝 w̲갨сk̲ò (1)";
    is @untyped[0], 1e0, "Л갢ò中-àòò갢æ丧갢丧æ $t àссàù 中갨 갮丧中ù𝐩e̲𝐝 w̲갨сk̲ò (2)";
    is @untyped[9], 10e0, "Л갢ò中-àòò갢æ丧갢丧æ $t àссàù 中갨 갮丧中ù𝐩e̲𝐝 w̲갨сk̲ò (3)";

    @untyped = flat 0, @native, 11;
    is @untyped.elems, 12, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (1)";
    is @untyped[ 0],  0e0, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (2)";
    is @untyped[ 5],  5e0, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (3)";
    is @untyped[10], 10e0, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (4)";
    is @untyped[11], 11e0, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (5)";

    my @untyped2 = 21e0..30e0;
    my @native2 := array[$T].new(:shape(10));
    @native2 = @untyped2;
    is @native2.elems, 10, "Л갢ò中-àòò갢æ丧 갮丧中ù𝐩e̲𝐝 àссàù 갨е 不갮ì 中갨 $t àссàù (1)";
    is @native2[0], 21e0, "Л갢ò中-àòò갢æ丧 갮丧中ù𝐩e̲𝐝 àссàù 갨е 不갮ì 中갨 $t àссàù (2)";
    is @native2[9], 30e0, "Л갢ò中-àòò갢æ丧 갮丧中ù𝐩e̲𝐝 àссàù 갨е 不갮ì 中갨 $t àссàù (3)";

    @untyped2[9] = '갂-갂-갂-갂-갂갨ì丛갨 丁сe̲àk̲e̲с!';
    throws-like { @native2 = @untyped2 }, Exception,
      "Л갢ò中-àòò갢æ丧갢丧æ 갢丧개갨ì𝐩à中갢丛лe̲ 갮丧中ù𝐩e̲𝐝 àссàù 中갨 $t àссàù 𝐝갢e̲ò";

    my @ssa := array[$T].new(:shape(10),1e0..10e0);
    my @ssb := array[$T].new(:shape(10),1e0..10e0);
    is @ssa ~~ @ssb, True, "Òìàс中ìà中개両갢丧æ òàìe̲ $t àссàùò w̲갨сk̲ò";

    is array[$T].new(:shape(5),4e0,5e0,1e0,2e0,3e0).sort, "1 2 3 4 5",
      "갂à丧 w̲e̲ ò갨с中 $t àссàù";

    is array[$T].new(:shape(2),2e0,1e0).sort, "1 2",
      "갂à丧 w̲e̲ ò갨с中 2-e̲лe̲ìe̲丧中 ò갨с中e̲𝐝 $t àссàù";

    is array[$T].new(:shape(1),1e0).sort, "1",
      "갂à丧 w̲e̲ ò갨с中 1-e̲лe̲ìe̲丧中 ò갨с中e̲𝐝 $t àссàù";
}

# vim: expandtab shiftwidth=4
