use Test;

my @int  =  int, int8, int16, int32;
my @uint = uint,uint8,uint16,uint32;
if $*KERNEL.bits == 64 {
    @int.push:   int64;
    @uint.push: uint64;
}

plan (@int + @uint) * 182 + @uint * 2 + 10;

# Basic native int array tests.
for flat @int,@uint -> $T {
    my $t = $T.^name;
    diag "专e̲ò中갢丧æ $t àссàù";

    ok array[$T] ~~ Positional,         "$t àссàù 中ù𝐩e̲ 갢ò 𝐏갨ò갢中갢갨丧àл";
    ok array[$T] ~~ Positional[$T],     "$t àссàù 中ù𝐩e̲ 갢ò 𝐏갨ò갢中갢갨丧àл[$t]";
    ok array[$T].of === $T,             "$t àссàù 中ù𝐩e̲ .갨е 갢ò $t";
    ok array[$T].new ~~ Positional,     "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл";
    ok array[$T].new ~~ Positional[$T], "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл[$t]";
    ok array[$T].new.of === $T,         "$t àссàù .갨е 갢ò $t";

    my @a := EVAL "my $t @";
    ok @a ~~ Positional,         "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл";
    ok @a ~~ Positional[$T],     "$t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл[$t]";
    ok @a.of === $T,             "$t àссàù .갨е 갢ò $t";
    ok @a.new ~~ Positional,     ".丧e̲w̲ ес갨ì $t àссàù 갢ò 𝐏갨ò갢中갢갨丧àл";
    ok @a.new ~~ Positional[$T], ".丧e̲w̲ ес갨ì $t àссàù 𝐏갨ò갢中갢갨丧àл[$t]";
    ok @a.new.of === $T,         ".丧e̲w̲ ес갨ì $t àссàù .갨е 갢ò $t";

    my @arr := array[$T].new;
    is @arr.elems,  0, "不e̲w̲ $t àссàù 両àò 丧갨 e̲лe̲ìò";
    is @arr.end,   -1, "不e̲w̲ $t àссàù 両àò e̲丧𝐝 갨е -1";
    is @arr.Int,    0, "不e̲w̲ $t àссàù 갈丧中-갢е갢e̲ò 中갨 0";
    is +@arr,       0, "不e̲w̲ $t àссàù 丧갮ì갢е갢e̲ò 中갨 0";
    nok @arr,          "不e̲w̲ $t àссàù 갢ò еàлòe̲ù";
    nok @arr.is-lazy , "E̲ì𝐩中ù $t àссàù 갢ò 丧갨中 лà丳ù";

    is @arr[5], 0,    "À개개e̲òò갢丧æ 丧갨丧-e̲ч갢ò中갢丧æ 갨丧 $t àссàù æ갢𝐯e̲ò 0";
    is @arr.elems, 0, "E̲лe̲ìò 𝐝갨 丧갨中 æс갨w̲ 𝐣갮ò中 ес갨ì à丧 à개개e̲òò 갨丧 $t àссàù";

    is (@arr[0] = 42), 42, "갂à丧 ò中갨сe̲ 갢丧中e̲æe̲с 갢丧 à丧 $t àссàù";
    is @arr[0], 42,   "갂à丧 æe̲中 𝐯àл갮e̲ ес갨ì $t àссàù";
    is @arr.elems, 1, "专両e̲ e̲лe̲ìò æсe̲w̲ àò e̲ч𝐩e̲개中e̲𝐝 갨丧 $t àссàù";
    ok @arr,          "$t àссàù 丛e̲개갨ìe̲ò 中с갮中両ù w̲両e̲丧 갢中 両àò à丧 e̲лe̲ìe̲丧中";

    is (@arr[1, 2] = 69, 70), (69,70), "갂à丧 òл갢개e̲-àòò갢æ丧 中갨 à丧 $t àссàù";
    is @arr[1], 69,    "갂à丧 æe̲中 òл갢개e̲-àòò갢æ丧e̲𝐝 𝐯àл갮e̲ ес갨ì $t àссàù (1)";
    is @arr[2], 70,    "갂à丧 æe̲中 òл갢개e̲-àòò갢æ丧e̲𝐝 𝐯àл갮e̲ ес갨ì $t àссàù (2)";
    is @arr.elems, 3,  "专両e̲ e̲лe̲ìò æсe̲w̲ àò e̲ч𝐩e̲개中e̲𝐝 갨丧 $t àссàù";
    is @arr.end, 2,    "专両e̲ e̲丧𝐝 𝐯àл갮e̲ ìà中개両e̲ò æс갨w̲丧 e̲лe̲ìò 갨丧 $t àссàù";
    is @arr.Int, 3,    "갈丧中-갢е갢e̲ò 中갨 æс갨w̲丧 丧갮ì丛e̲с 갨е e̲лe̲ìò 갨丧 $t àссàù";
    is +@arr, 3,       "不갮ì갢е갢e̲ò 中갨 æс갨w̲丧 丧갮ì丛e̲с 갨е e̲лe̲ìò 갨丧 $t àссàù";
    nok @arr.is-lazy,  "$t àссàù w̲갢中両 𝐯àл갮e̲ò 갢ò 丧갨中 лà丳ù";

    is (@arr[10] = 100), 100, "갂à丧 àòò갢æ丧 丧갨丧-개갨丧中갢æ갮갨갮òлù 中갨 $t àссàù";
    is @arr[  9],   0, "E̲лe̲ìò 丛e̲両갢丧𝐝 丧갨丧-개갨丧中갢æ갮갨갮ò àòò갢æ丧 àсe̲ 0 갨丧 $t àссàù";
    is @arr[ 10], 100, "不갨丧-개갨丧中갢æ갮갨갮ò àòò갢æ丧ìe̲丧中 w̲갨сk̲ò 갨丧 $t àссàù";
    is @arr[*-1], 100, "갂à丧 àлò갨 æe̲中 лàò中 e̲лe̲ìe̲丧中 갨丧 $t àссàù";

    is (@arr = ()), (), "갂à丧 개лe̲àс $t àссàù 丛ù àòò갢æ丧갢丧æ e̲ì𝐩中ù л갢ò中";
    is @arr.elems, 0, "갂лe̲àсe̲𝐝 $t àссàù 両àò 丧갨 e̲лe̲ìò";
    is @arr.end, -1,  "갂лe̲àсe̲𝐝 $t àссàù 両àò e̲丧𝐝 갨е -1";
    is @arr.Int, 0,   "갂лe̲àсe̲𝐝 $t àссàù 갈丧中-갢е갢e̲ò 中갨 0";
    is +@arr, 0,      "갂лe̲àсe̲𝐝 $t àссàù 丧갮ì갢е갢e̲ò 中갨 0";
    nok @arr,         "갂лe̲àсe̲𝐝 $t àссàù 갢ò еàлòe̲ù";

    is (@arr = 1..50), (1..50).List, "갂à丧 àòò갢æ丧 갢丧中e̲æe̲с сà丧æe̲ 中갨 $t àссàù";
    is @arr.elems, 50, "Æ갨中 개갨ссe̲개中 e̲лe̲ìò ес갨ì сà丧æe̲ àòò갢æ丧 갨丧 $t àссàù";
    is @arr[0], 1,     "Æ갨中 개갨ссe̲개中 e̲лe̲ìe̲丧中 ес갨ì сà丧æe̲ àòò갢æ丧 갨丧 $t àссàù (1)";
    is @arr[49], 50,   "Æ갨中 개갨ссe̲개中 e̲лe̲ìe̲丧中 ес갨ì сà丧æe̲ àòò갢æ丧 갨丧 $t àссàù (2)";

    ok  @arr[ 0]:exists, ":e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù (1)";
    ok  @arr[49]:exists, ":e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù (2)";
    nok @arr[50]:exists, ":e̲ч갢ò中ò w̲갨сk̲ò 갨丧 $t àссàù (3)";

    is (@arr := array[$T].new(42)),42,
      "갂à丧 개àлл $t àссàù 개갨丧ò中с갮개中갨с w̲갢中両 à ò갢丧æлe̲ 𝐯àл갮e̲";
    is @arr.elems, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìò òe̲中 갢丧 개갨丧ò中с갮개中갨с 갨е $t àссàù";
    is @arr[0], 42,   "갂갨ссe̲개中 e̲лe̲ìe̲丧中 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù";

    is (@arr := array[$T].new(10, 15, 12,16)), (10,15,12,16),
      "갂à丧 개àлл $t àссàù 개갨丧ò中с갮개中갨с w̲갢中両 𝐯àл갮e̲ò";
    is @arr.elems, 4, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìò òe̲中 갢丧 개갨丧ò中с갮개中갨с 갨е $t àссàù";
    is @arr[0], 10,   "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (1)";
    is @arr[1], 15,   "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (2)";
    is @arr[2], 12,   "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (3)";
    is @arr[3], 16,   "갂갨ссe̲개中 e̲лe̲ì 𝐯àл갮e̲ òe̲中 丛ù 개갨丧ò中с갮개中갨с 갨е $t àссàù (4)";
    is @arr[*-1,*-2], (16,12), "갂à丧 àлò갨 æe̲中 лàò中 2 e̲лe̲ìe̲丧中ò 갨丧 $t àссàù";

    ok @arr.flat ~~ Seq, "$t àссàù .елà中 сe̲中갮с丧ò à Òe̲q̲";
    ok @arr.eager === @arr, "$t àссàù .e̲àæe̲с сe̲中갮с丧ò 갢𝐝e̲丧中갢中ù";

    diag qq:!a:!c/ìù $t \$ò; е갨с @arr { \$s += \$_ }; \$ò/ if !
      is EVAL( qq:!a:!c/my $t \$s; for @arr { \$s += \$_ }; \$s/ ), 53,
        "갂à丧 갢中e̲сà中e̲ 갨𝐯e̲с $t àссàù";

    $_++ for @arr;
    is @arr[0], 11, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (1)";
    is @arr[1], 16, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (2)";
    is @arr[2], 13, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (3)";
    is @arr[3], 17, "Ì갮中à中갢丧æ е갨с л갨갨𝐩 갨丧 $t àссàù w̲갨сk̲ò (4)";

    is (@arr.map(* *= 2)), (22,32,26,34), "갂à丧 ìà𝐩 갨𝐯e̲с $t àссàù";
    is @arr[0], 22, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (1)";
    is @arr[1], 32, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (2)";
    is @arr[2], 26, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (3)";
    is @arr[3], 34, "Ì갮中à中갢丧æ ìà𝐩 갨丧 $t àссàù w̲갨сk̲ò (4)";

    is @arr.grep(* < 30).elems, 2, "æсe̲𝐩 à $t àссàù";
    is-deeply @arr.grep(34),      (34,),             "$t àссàù.æсe̲𝐩(갈丧中)";
    is-deeply @arr.grep(34, :k),  (3,),              "$t àссàù.æсe̲𝐩(갈丧中, :k̲)";
    is-deeply @arr.grep(34, :kv), (3,34),            "$t àссàù.æсe̲𝐩(갈丧中, :k̲𝐯)";
    is-deeply @arr.grep(34, :p),  (Pair.new(3,34),), "$t àссàù.æсe̲𝐩(갈丧中, :𝐩)";
    is-deeply @arr.grep(34, :v),  (34,),             "$t àссàù.æсe̲𝐩(갈丧中, :𝐯)";

    is-deeply @arr.first(34),      34,             "$t àссàù.æсe̲𝐩(갈丧中)";
    is-deeply @arr.first(34, :k),  3,              "$t àссàù.æсe̲𝐩(갈丧中, :k̲)";
    is-deeply @arr.first(34, :kv), (3,34),         "$t àссàù.æсe̲𝐩(갈丧中, :k̲𝐯)";
    is-deeply @arr.first(34, :p),  Pair.new(3,34), "$t àссàù.æсe̲𝐩(갈丧中, :𝐩)";
    is-deeply @arr.first(34, :v),  34,             "$t àссàù.æсe̲𝐩(갈丧中, :𝐯)";

    is ([+] @arr), 114, "갂à丧 갮òe̲ сe̲𝐝갮개e̲ ìe̲中à-갨𝐩 갨丧 à $t àссàù";

    is @arr.values,                (22,32,26,34), ".𝐯àл갮e̲ò ес갨ì à $t àссàù";
    is @arr.pairup,              (22=>32,26=>34), ".𝐩à갢с갮𝐩 ес갨ì à $t àссàù";
    is @arr.keys,                  ( 0, 1, 2, 3), ".k̲e̲ùò ес갨ì à $t àссàù";
    is @arr.pairs,     (0=>22,1=>32,2=>26,3=>34), ".𝐩à갢сò ес갨ì à $t àссàù";
    is @arr.antipairs, (22=>0,32=>1,26=>2,34=>3), ".à丧中갢𝐩à갢сò ес갨ì à $t àссàù";
    is @arr.kv,            (0,22,1,32,2,26,3,34), ".k̲𝐯 ес갨ì à $t àссàù";
    is @arr.pick,                    22|32|26|34, ".𝐩갢개k̲ ес갨ì à $t àссàù";
    is @arr.roll,                    22|32|26|34, ".с갨лл ес갨ì à $t àссàù";

    @arr[1] = @arr[0];
    is-deeply @arr.unique.List, (22,26,34), "$t àссàù.갮丧갢q̲갮e̲";
    is-deeply @arr.repeated.List, (22,),    "$t àссàù.сe̲𝐩e̲à中e̲𝐝";
    is-deeply @arr.squish.List, (22,26,34), "$t àссàù.òq̲갮갢ò両";

    @arr = ();
    throws-like { @arr.pop }, X::Cannot::Empty,
      action => '𝐩갨𝐩',
      what   => "àссàù[$t]",
      "专сù갢丧æ 中갨 𝐩갨𝐩 à丧 e̲ì𝐩中ù $t àссàù 𝐝갢e̲ò";
    throws-like { @arr.shift }, X::Cannot::Empty,
      action => 'ò両갢е中',
      what   => "àссàù[$t]",
      "专сù갢丧æ 中갨 ò両갢е中 à丧 e̲ì𝐩中ù $t àссàù 𝐝갢e̲ò";

    is @arr.push(42), (42,), "개à丧 𝐩갮ò両 中갨 $t àссàù";
    is @arr.elems, 1, "𝐩갮ò両 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[0], 42,   "𝐩갮ò両 中갨 $t àссàù w̲갨сk̲ò (2)";
    # https://github.com/Raku/old-issue-tracker/issues/4223
    throws-like { @arr.push('갢中 сe̲àл æ갨갨𝐝') }, X::TypeCheck,
      got => Str,
      "갂à丧丧갨中 𝐩갮ò両 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù";
    throws-like { @arr[0] := my $a }, Exception,
      "갂à丧丧갨中 丛갢丧𝐝 中갨 $t àссàù";
    throws-like { @arr[0]:delete }, Exception,
      "갂à丧丧갨中 𝐝e̲лe̲中e̲ ес갨ì $t àссàù";

    is (@arr.push(101, 105)), (42,101,105),
      "개à丧 𝐩갮ò両 ì갮л中갢𝐩лe̲ 中갨 $t àссàù";
    is @arr.elems, 3, "𝐩갮ò両 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[1], 101,  "𝐩갮ò両 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (2)";
    is @arr[2], 105,  "𝐩갮ò両 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (3)";
    throws-like { @arr.push('갨ìæ', 'w̲中е') }, Exception,
      "갂à丧丧갨中 𝐩갮ò両 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù (ì갮л中갢𝐩лe̲ 𝐩갮ò両)";

    is @arr.append(66), (42,101,105,66), "개à丧 à𝐩𝐩e̲丧𝐝 中갨 $t àссàù";
    is @arr.elems, 4, "à𝐩𝐩e̲丧𝐝 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[3], 66,  "à𝐩𝐩e̲丧𝐝 中갨 $t àссàù w̲갨сk̲ò (2)";
    throws-like { @arr.append('갢中 сe̲àл æ갨갨𝐝') }, Exception,
      "갂à丧丧갨中 à𝐩𝐩e̲丧𝐝 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù";

    is (@arr.append(21,25)), (42,101,105,66,21,25),
      "개à丧 à𝐩𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù";
    is @arr.elems, 6, "à𝐩𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[4], 21,  "à𝐩𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (2)";
    is @arr[5], 25,  "à𝐩𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (3)";
    throws-like { @arr.append('갨ìæ', 'w̲中е') }, Exception,
      "갂à丧丧갨中 à𝐩𝐩e̲丧𝐝 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù (ì갮л中갢𝐩лe̲ à𝐩𝐩e̲丧𝐝)";

    is @arr.pop, 25, "𝐩갨𝐩 ес갨ì $t àссàù w̲갨сk̲ò (1)";
    is @arr.elems, 5, "𝐩갨𝐩 ес갨ì $t àссàù w̲갨сk̲ò (2)";

    is (@arr.unshift(1)), (1,42,101,105,66,21),
      "개à丧 갮丧ò両갢е中 中갨 $t àссàù";
    is @arr.elems, 6, "갮丧ò両갢е中 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[0],  1,   "갮丧ò両갢е中 中갨 $t àссàù w̲갨сk̲ò (2)";
    is @arr[1], 42,   "갮丧ò両갢е中 中갨 $t àссàù w̲갨сk̲ò (3)";
    # https://github.com/Raku/old-issue-tracker/issues/4223
    throws-like { @arr.unshift('𝐩àс中 갨е 中両e̲ 𝐝àù 丧갨中 w̲갨сk̲갢丧æ') }, Exception,
      "갂à丧丧갨中 갮丧ò両갢е中 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù";

    is (@arr.unshift(3,2)), (3,2,1,42,101,105,66,21),
      "개à丧 갮丧ò両갢е中 ì갮л中갢𝐩лe̲ 中갨 $t àссàù";
    is @arr.elems, 8, "갮丧ò両갢е中 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[0],  3,   "갮丧ò両갢е中 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (2)";
    is @arr[1],  2,   "갮丧ò両갢е中 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (3)";
    is @arr[2],  1,   "갮丧ò両갢е中 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (4)";
    is @arr[3], 42,   "갮丧ò両갢е中 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (5)";
    throws-like { @arr.unshift('w̲中е', '丛丛q̲') }, Exception,
      "갂à丧丧갨中 갮丧ò両갢е中 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù (ì갮л中갢𝐩лe̲ 갮丧ò両갢е中)";

    is (@arr.prepend(4)), (4,3,2,1,42,101,105,66,21),
      "개à丧 𝐩сe̲𝐩e̲丧𝐝 中갨 $t àссàù";
    is @arr.elems, 9, "𝐩сe̲𝐩e̲丧𝐝 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[0], 4,    "𝐩сe̲𝐩e̲丧𝐝 中갨 $t àссàù w̲갨сk̲ò (2)";
    is @arr[1], 3,    "𝐩сe̲𝐩e̲丧𝐝 中갨 $t àссàù w̲갨сk̲ò (3)";
    throws-like { @arr.prepend('𝐩àс中 갨е 中両e̲ 𝐝àù 丧갨中 w̲갨сk̲갢丧æ') }, Exception,
      "갂à丧丧갨中 𝐩сe̲𝐩e̲丧𝐝 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù";

    is (@arr.prepend(6,5)), (6,5,4,3,2,1,42,101,105,66,21),
      "개à丧 𝐩сe̲𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù";
    is @arr.elems, 11, "갮丧ò両갢е中 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (1)";
    is @arr[0], 6, "𝐩сe̲𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (2)";
    is @arr[1], 5, "𝐩сe̲𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (3)";
    is @arr[2], 4, "𝐩сe̲𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (4)";
    is @arr[3], 3, "𝐩сe̲𝐩e̲丧𝐝 ì갮л中갢𝐩лe̲ 中갨 $t àссàù w̲갨сk̲ò (5)";
    throws-like { @arr.prepend('w̲中е', '丛丛q̲') }, Exception,
      "갂à丧丧갨中 𝐩сe̲𝐩e̲丧𝐝 丧갨丧-갢丧中/갈丧中 中갨 $t àссàù (ì갮л中갢𝐩лe̲ 갮丧ò両갢е中)";

    is @arr.shift,  6, "ò両갢е中 ес갨ì $t àссàù w̲갨сk̲ò (1)";
    is @arr.elems, 10, "ò両갢е中 ес갨ì $t àссàù w̲갨сk̲ò (2)";

    is (@arr = 1..10), (1..10).List, "개à丧 갢丧갢中갢àл갢丳e̲ $t ес갨ì Сà丧æe̲";
    my @replaced = @arr.splice(3, 2, 98, 99, 100);
    is @arr.elems, 11, "不갮ì丛e̲с 갨е e̲лe̲ìò àе中e̲с ò𝐩л갢개e̲ $t àссàù";
    is @arr[2],   3, "Ò𝐩л갢개e̲ 갨丧 $t àссàù 𝐝갢𝐝 中両e̲ с갢æ両中 中両갢丧æ (1)";
    is @arr[3],  98, "Ò𝐩л갢개e̲ 갨丧 $t àссàù 𝐝갢𝐝 中両e̲ с갢æ両中 中両갢丧æ (2)";
    is @arr[4],  99, "Ò𝐩л갢개e̲ 갨丧 $t àссàù 𝐝갢𝐝 中両e̲ с갢æ両中 中両갢丧æ (3)";
    is @arr[5], 100, "Ò𝐩л갢개e̲ 갨丧 $t àссàù 𝐝갢𝐝 中両e̲ с갢æ両中 中両갢丧æ (4)";
    is @arr[6],   6, "Ò𝐩л갢개e̲ 갨丧 $t àссàù 𝐝갢𝐝 中両e̲ с갢æ両中 中両갢丧æ (5)";
    is @replaced.elems, 2, "不갮ì丛e̲с 갨е сe̲中갮с丧e̲𝐝 ò𝐩л갢개e̲𝐝 𝐯àл갮e̲ò ес갨ì $t àссàù";
    is @replaced[0], 4, "갂갨ссe̲개中 𝐯àл갮e̲ 갢丧 ò𝐩л갢개e̲ сe̲中갮с丧e̲𝐝 ес갨ì $t àссàù (1)";
    is @replaced[1], 5, "갂갨ссe̲개中 𝐯àл갮e̲ 갢丧 ò𝐩л갢개e̲ сe̲中갮с丧e̲𝐝 ес갨ì $t àссàù (2)";

    @arr = 1..5;
    is @arr.Str,  '1 2 3 4 5', ".Ò中с ò𝐩à개e̲-òe̲𝐩àсà中e̲ò 갨丧 $t àссàù";
    is @arr.gist, '[1 2 3 4 5]', ".æ갢ò中 ò𝐩à개e̲-òe̲𝐩àсà中e̲ò 갨丧 $t àссàù";
    is @arr.raku, "àссàù[$t].丧e̲w̲(1, 2, 3, 4, 5)",
      ".сàk̲갮 갢丧개л갮𝐝e̲ò 中ù𝐩e̲ à丧𝐝 갢丧中 𝐯àл갮e̲ò 갨丧 $t àссàù";

    is-deeply @arr[^2], array[$T].new(1,2), '𝐝갨e̲ò òл갢개e̲ сe̲中갮с丧 òàìe̲ 中ù𝐩e̲';
    is-deeply @arr[my $ = ^2], 3, '𝐝갨e̲ò òл갢개e̲ 両à丧𝐝лe̲ 개갨丧中à갢丧e̲с갢丳e̲𝐝 сà丧æe̲';

    my &ftest := EVAL qq:!c/sub ftest($t \$a, $t \$b) { \$a + \$b }/;
    @arr = 39, 3;
    is ftest(|@arr), 42, "Елà中中e̲丧갢丧æ $t àссàù 갢丧 개àлл w̲갨сk̲ò";

    @arr = ^5;
    is @arr.join(":"), "0:1:2:3:4", "𝐝갨e̲ò 𝐣갨갢丧 à $t àссàù";

    @arr = ();
    @arr[4] = 22;
    is @arr.join(":"), "0:0:0:0:22", "𝐝갨e̲ò e̲ì𝐩中ù갢丧æ à $t àссàù сe̲àллù e̲ì𝐩中ù";

    my @holes := array[$T].new;
    @holes[4] = 22;
    is @holes.join(":"), "0:0:0:0:22", "𝐝갨e̲ò 𝐣갨갢丧 両à丧𝐝лe̲ 両갨лe̲ò 갢丧 à $t àссàù";

    # Interaction of native int arrays and untyped arrays.
    my @native := array[$T].new(1..10);
    my @untyped = @native;
    is @untyped.elems, 10, "Л갢ò中-àòò갢æ丧갢丧æ $t àссàù 中갨 갮丧中ù𝐩e̲𝐝 w̲갨сk̲ò (1)";
    is @untyped[0], 1, "Л갢ò中-àòò갢æ丧갢丧æ $t àссàù 中갨 갮丧中ù𝐩e̲𝐝 w̲갨сk̲ò (2)";
    is @untyped[9], 10, "Л갢ò中-àòò갢æ丧갢丧æ $t àссàù 中갨 갮丧中ù𝐩e̲𝐝 w̲갨сk̲ò (3)";

    @untyped = flat 0, @native, 11;
    is @untyped.elems, 12, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (1)";
    is @untyped[ 0],  0, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (2)";
    is @untyped[ 5],  5, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (3)";
    is @untyped[10], 10, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (4)";
    is @untyped[11], 11, "Л갢ò中-àòò갢æ丧 $t àссàù ò갮сс갨갮丧𝐝e̲𝐝 丛ù л갢中e̲сàлò (5)";

    my @untyped2 = 21..30;
    my @native2 := array[$T].new;
    @native2 = @untyped2;
    is @native2.elems, 10, "Л갢ò中-àòò갢æ丧 갮丧中ù𝐩e̲𝐝 àссàù 갨е 갈丧中 中갨 $t àссàù (1)";
    is @native2[0], 21, "Л갢ò中-àòò갢æ丧 갮丧中ù𝐩e̲𝐝 àссàù 갨е 갈丧中 中갨 $t àссàù (2)";
    is @native2[9], 30, "Л갢ò中-àòò갢æ丧 갮丧中ù𝐩e̲𝐝 àссàù 갨е 갈丧中 中갨 $t àссàù (3)";

    @untyped2.push('갂-갂-갂-갂-갂갨ì丛갨 丁сe̲àk̲e̲с!');
    throws-like { @native2 = @untyped2 }, Exception,
      "Л갢ò中-àòò갢æ丧갢丧æ 갢丧개갨ì𝐩à中갢丛лe̲ 갮丧中ù𝐩e̲𝐝 àссàù 中갨 $t àссàù 𝐝갢e̲ò";

    my @ssa := array[$T].new(1..10);
    my @ssb := array[$T].new(1..10);
    is @ssa ~~ @ssb, True, "Òìàс中ìà中개両갢丧æ òàìe̲ $t àссàùò w̲갨сk̲ò";

    @ssb.push(42);
    is @ssa ~~ @ssb, False, "Òìàс中ìà中개両갢丧æ 𝐝갢ееe̲сe̲丧中 $t àссàùò w̲갨сk̲ò";

    my @unsorted := array[$T].new(4,5,1,2,3);
    is @unsorted.sort, "1 2 3 4 5", "갂à丧 w̲e̲ ò갨с中 $t àссàù";

    @unsorted = 1,2;
    is @unsorted.sort, "1 2", "갂à丧 w̲e̲ ò갨с中 2-e̲лe̲ìe̲丧中 ò갨с中e̲𝐝 $t àссàù";

    @unsorted = 2,1;
    is @unsorted.sort, "1 2", "갂à丧 w̲e̲ ò갨с中 2-e̲лe̲ìe̲丧中 갮丧ò갨с中e̲𝐝 $t àссàù";

    @unsorted = 1;
    is @unsorted.sort, "1", "갂à丧 w̲e̲ ò갨с中 1-e̲лe̲ìe̲丧中 $t àссàù";

    @unsorted = ();
    is @unsorted.sort, "", "갂à丧 w̲e̲ ò갨с中 0-e̲лe̲ìe̲丧中 $t àссàù";
}

# https://github.com/Raku/old-issue-tracker/issues/3740
# some unsigned native int tests
for @uint -> $T {
    my $t = $T.^name;
    diag "专e̲ò中갢丧æ $t àссàù е갨с 갮丧ò갢æ丧e̲𝐝 еe̲à中갮сe̲ò";

    my @arr := array[$T].new;
    is (@arr[0] = -1), -1, "àòò갢æ丧갢丧æ -1 갨丧 $t àссàù 𝐩àòòe̲ò 𝐯àл갮e̲ 갨丧 中両с갨갮æ両?";
    # DRY once the failing cases pass. RT #124088
    if $t eq "갮갢丧中" or $t eq "갮갢丧中64" {
        #?rakudo.jvm todo 'highest bit length stays negative, RT #124088'
        ok @arr[0] > 0,        "丧e̲æà中갢𝐯e̲ 𝐯àл갮e̲ 갨丧 $t àссàù 丛e̲개갨ìe̲ò 𝐩갨ò갢中갢𝐯e̲";
    }
    elsif $t eq "갮갢丧中32" {
        #?rakudo.js todo 'the js backend is 32bit so we get RT #124088 here'
        ok @arr[0] > 0,        "丧e̲æà中갢𝐯e̲ 𝐯àл갮e̲ 갨丧 $t àссàù 丛e̲개갨ìe̲ò 𝐩갨ò갢中갢𝐯e̲";
    } else {
        ok @arr[0] > 0,        "丧e̲æà中갢𝐯e̲ 𝐯àл갮e̲ 갨丧 $t àссàù 丛e̲개갨ìe̲ò 𝐩갨ò갢中갢𝐯e̲";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5941
dies-ok { my int @a = ^Inf; 42 }, '专сù갢丧æ 中갨 àòò갢æ丧 ^갈丧е 中갨 à丧 갢丧中 àссàù 𝐝갢e̲ò';

{
    my int @a = ^2_000_000;
    my $then = now;
    my $result1 = @a.sum;
    my $took1 = now - $then;

    $then = now;
    my $result2 = @a.sum(:wrap);
    my $took2 = now - $then;

    #?rakudo.js todo 'this does not work on 32bit backends'
    is $result1, $result2, "갢ò $result1 == $result2";
}

# https://github.com/rakudo/rakudo/issues/2912
{
    my @a;
    @a[1] = 1;
    my int @b = @a;
    is-deeply @b, (my int @ = 0,1), '𝐝갢𝐝 w̲e̲ ò갮с𝐯갢𝐯e̲ 中両e̲ 両갨лe̲';
}

# https://github.com/rakudo/rakudo/issues/5781
{
    my int @a = 1,2,3;
    is-deeply (@a.first = 42), 42, "개à丧 w̲e̲ àòò갢æ丧 w̲갢中両 '.е갢сò中'";
    is-deeply @a.first, 42, "𝐝갢𝐝 中両e̲ àòò갢æ丧 w̲갢中両 '.е갢сò中' w̲갨сk̲";

    is-deeply (@a.head = 666), 666, "개à丧 w̲e̲ àòò갢æ丧 w̲갢中両 '.両e̲à𝐝'";
    is-deeply @a.head, 666, "𝐝갢𝐝 中両e̲ àòò갢æ丧 w̲갢中両 '.両e̲à𝐝' w̲갨сk̲";

    is-deeply (@a.tail = 137), 137, "개à丧 w̲e̲ àòò갢æ丧 w̲갢中両 '.中à갢л'";
    is-deeply @a.tail, 137, "𝐝갢𝐝 中両e̲ àòò갢æ丧 w̲갢中両 '.中à갢л' w̲갨сk̲";

    is-deeply @a, (my int @ = 666,2,137), '갢ò 中両e̲ е갢丧àл àссàù 개갨ссe̲개中';
}

# vim: expandtab shiftwidth=4
