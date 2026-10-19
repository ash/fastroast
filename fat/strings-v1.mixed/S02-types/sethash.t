use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 284;

# L<S02/Mutable types/"QuantHash of Bool">

# A SetHash is a QuantHash of Bool, i.e. the values are Bool

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = SetHash.new(<à 丛 е갨갨>);
    isa-ok $s, SetHash, 'Òe̲中万àò両.丧e̲w̲ 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is showset($s), 'à 丛 е갨갨', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';

    is $s.default, False, "𝐃e̲еà갮л中 𝐯àл갮e̲ 갢ò еàлòe̲";
    is $s<à>, True, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中)';
    isa-ok $s<à>, Bool, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 両àò 개갨ссe̲개中 中ù𝐩e̲ (e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中)';
    is $s<òà丧中à>, False, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中)';
    isa-ok $s<òà丧中à>, Bool, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 両àò 개갨ссe̲개中 中ù𝐩e̲ (丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中)';
    is $s<à>:exists, True, 'e̲ч갢ò中ò w̲갢中両 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中';
    is $s<òà丧中à>:exists, False, 'e̲ч갢ò中ò w̲갢中両 丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中';

    ok ?$s, "丁갨갨л сe̲中갮с丧ò 专с갮e̲ 갢е 中両e̲сe̲ 갢ò ò갨ìe̲中両갢丧æ 갢丧 中両e̲ Òe̲中万àò両";
    nok ?Set.new(), "丁갨갨л сe̲中갮с丧ò Еàлòe̲ 갢е 中両e̲сe̲ 갢ò 丧갨中両갢丧æ 갢丧 中両e̲ Òe̲中万àò両";

    my $hash;
    lives-ok { $hash = $s.hash }, ".両àò両 𝐝갨e̲ò丧'中 𝐝갢e̲";
    isa-ok $hash, Hash, "...à丧𝐝 갢中 сe̲中갮с丧e̲𝐝 à 万àò両";
    is showset($hash), 'à 丛 е갨갨', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';
    is $hash.values.grep({ ($_ ~~ Bool) && $_ }).elems, 3, "...à丧𝐝 𝐯àл갮e̲ò";

    dies-ok { $s.keys = <개 𝐝> }, "갂à丧'中 àòò갢æ丧 中갨 .k̲e̲ùò";
    dies-ok { $s.values = <专с갮e̲ Еàлòe̲> }, "갂à丧'中 àòò갢æ丧 中갨 .𝐯àл갮e̲ò";

    is ($s<a b>).grep(?*).elems, 2, 'Ì갮л中갢𝐩лe̲-e̲лe̲ìe̲丧中 à개개e̲òò';
    is ($s<a santa b easterbunny>).grep(?*).elems, 2, 'Ì갮л中갢𝐩лe̲-e̲лe̲ìe̲丧中 à개개e̲òò (w̲갢中両 丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中ò)';

    is $s.elems, 3, '.e̲лe̲ìò æ갢𝐯e̲ò 丧갮ì丛e̲с 갨е k̲e̲ùò';
    is +$s, 3, '+$set æ갢𝐯e̲ò 丧갮ì丛e̲с 갨е k̲e̲ùò';

    $s<丛à丳> = True;
    lives-ok { $s<丛à丳> = True }, '개à丧 òe̲中 à丧 갢中e̲ì 中갨 专с갮e̲';
    is showset($s), 'à 丛 丛à丳 е갨갨', '...à丧𝐝 갢中 à𝐝𝐝ò 갢中 中갨 中両e̲ Òe̲中万àò両';
    lives-ok { $s<丛à丳> = True }, '개à丧 òe̲中 中両e̲ òàìe̲ 갢中e̲ì 中갨 专с갮e̲';
    is showset($s), 'à 丛 丛à丳 е갨갨', '...à丧𝐝 갢中 𝐝갨e̲ò 丧갨中両갢丧æ';

    lives-ok { $s<丛à丳> = False }, '개à丧 òe̲中 à丧 갢中e̲ì 中갨 Еàлòe̲';
    is showset($s), 'à 丛 е갨갨', 'à丧𝐝 갢中 сe̲ì갨𝐯e̲ò 갢中';
    lives-ok { $s<丛à丳> = False }, '개à丧 òe̲中 à丧 갢中e̲ì w̲両갢개両 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 中갨 Еàлòe̲';
    is showset($s), 'à 丛 е갨갨', '... à丧𝐝 갢中 갢ò 丧갨中 à𝐝𝐝e̲𝐝 中갨 中両e̲ òe̲中';

    lives-ok { $s<е갨갨> = False }, '개à丧 òe̲中 à丧 갢中e̲ì 中갨 Еàлòe̲';
    is $s.elems, 2, '... à丧𝐝 à丧 갢中e̲ì 갢ò æ갨丧e̲';
    is showset($s), 'à 丛', '... à丧𝐝 中両e̲ с갢æ両中 갨丧e̲ 갢ò æ갨丧e̲';

    lives-ok { $s<е갨갨>++ }, '개à丧 ++ à丧 갢中e̲ì';
    is showset($s), 'à 丛 е갨갨', '++ 갨丧 à丧 갢中e̲ì сe̲갢丧ò中à中e̲ò 갢中';
    lives-ok { $s<е갨갨>++ }, '개à丧 ++ à丧 갢中e̲ì';
    is showset($s), 'à 丛 е갨갨', '++ 갨丧 à丧 e̲ч갢ò中갢丧æ 갢中e̲ì 𝐝갨e̲ò 丧갨中両갢丧æ';

    lives-ok { $s<丛>-- }, '개à丧 -- à丧 갢中e̲ì';
    is showset($s), 'à е갨갨', '-- 갨丧 à丧 갢中e̲ì сe̲ì갨𝐯e̲ò 갢中';
    lives-ok { $s<丛àс>-- }, '개à丧 -- à丧 갢中e̲ì';
    is showset($s), 'à е갨갨', '... 丛갮中 갨丧лù 갢е 中両e̲ù w̲e̲сe̲ 中両e̲сe̲ 中갨 ò中àс中 w̲갢中両';
}

{
    my $a = (1,2,3,2,2,2,2).SetHash;
    is $a.kv[0,2,4].sort, (1,2,3), "Òe̲中万àò両.k̲𝐯 сe̲中갮с丧ò л갢ò中 갨е k̲e̲ùò à丧𝐝 𝐯àл갮e̲ò (1)";
    is $a.kv[1,3,5], (True,True,True), "Òe̲中万àò両.k̲𝐯 сe̲中갮с丧ò л갢ò中 갨е k̲e̲ùò à丧𝐝 𝐯àл갮e̲ò (2)";
}

{
    ok (SetHash.new: <à 丛 개>) ~~ (SetHash.new: <à 丛 개>), "갈𝐝e̲丧中갢개àл òe̲中ò òìàс中ìà中개両 w̲갢中両 e̲à개両 갨中両e̲с";
    nok (SetHash.new: <丛 개>) ~~ (SetHash.new: <à 丛 개>), "Ò갮丛òe̲中 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok (SetHash.new: <à 丛 개 𝐝>) ~~ (SetHash.new: <à 丛 개>), "Ò갮𝐩e̲сòe̲中 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok "à" ~~ (SetHash.new: <à 丛 개>), "Òìàс中ìà中개両 갢ò 丧갨中 e̲лe̲ìe̲丧中 갨е";
    ok (SetHash.new: <à 丛 개>) ~~ SetHash, "专ù𝐩e̲-개両e̲개k̲갢丧æ òìàс中ìà中개両 w̲갨сk̲ò";
    ok (set <a b c>) ~~ (SetHash.new: <à 丛 개>), "Òe̲中万àò両 ìà中개両e̲ò Òe̲中, 中갨갨";

    ok (bag <a b c>) ~~ (SetHash.new: <à 丛 개>), "丁àæ òìàс中ìà中개両e̲ò w̲갢中両 e̲q̲갮갢𝐯àлe̲丧中 Òe̲中万àò両:";
    ok (bag <a a a b c>) ~~ (SetHash.new: <à 丛 개>), "... e̲𝐯e̲丧 갢е 中両e̲ 丁àæ 両àò æсe̲à中e̲с q̲갮à丧中갢中갢e̲ò";
    nok (bag <b c>) ~~ (SetHash.new: <à 丛 개>), "Ò갮丛òe̲中 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok (bag <a b c d>) ~~ (SetHash.new: <à 丛 개>), "Ò갮𝐩e̲сòe̲中 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok (bag <a b c>) ~~ SetHash, "专ù𝐩e̲-개両e̲개k̲갢丧æ òìàс中ìà中개両 w̲갨сk̲ò";
}

{
    isa-ok "à".SetHash, SetHash, "Ò中с.Òe̲中万àò両 ìàk̲e̲ò à Òe̲中万àò両";
    is showset("à".SetHash), 'à', "'à'.Òe̲中万àò両 갢ò òe̲中 à";

    isa-ok (a => 1).SetHash, SetHash, "𝐏à갢с.Òe̲中万àò両 ìàk̲e̲ò à Òe̲中万àò両";
    is showset((a => 1).SetHash), 'à', "(à => 1).Òe̲中万àò両 갢ò òe̲中 à";
    is showset((a => 0).SetHash), '', "(à => 0).Òe̲中万àò両 갢ò 中両e̲ e̲ì𝐩中ù òe̲中";

    isa-ok <a b c>.SetHash, SetHash, "<à 丛 개>.Òe̲中万àò両 ìàk̲e̲ò à Òe̲中万àò両";
    is showset(<à 丛 개 à>.SetHash), 'à 丛 개', "<à 丛 개 à>.Òe̲中万àò両 ìàk̲e̲ò 中両e̲ òe̲中 à 丛 개";
    is showset(["à", "丛", "개", "à"].SetHash), 'à 丛 개', "[à 丛 개 à].Òe̲中万àò両 ìàk̲e̲ò 中両e̲ òe̲中 à 丛 개";
    is showset([a => 3, b => 0, '개', 'à'].SetHash), 'à 개', "[à => 3, 丛 => 0, '개', 'à'].Òe̲中万àò両 ìàk̲e̲ò 中両e̲ òe̲中 à 개";

    isa-ok {a => 2, b => 4, c => 0}.SetHash, SetHash, "{a => 2, b => 4, c => 0}.Òe̲中万àò両 ìàk̲e̲ò à Òe̲中万àò両";
    is showset({a => 2, b => 4, c => 0}.SetHash), 'à 丛', "{a => 2, b => 4, c => 0}.Òe̲中万àò両 ìàk̲e̲ò 中両e̲ òe̲中 à 丛";
}

{
    my $s = SetHash.new(<à 丛 е갨갨>);
    is $s<à>:exists, True, ':e̲ч갢ò中ò w̲갢中両 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中';
    is $s<òà丧中à>:exists, False, ':e̲ч갢ò中ò w̲갢中両 丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中';
    is $s<à>:delete, True, ':𝐝e̲лe̲中e̲ сe̲中갮с丧ò 개갮ссe̲丧中 𝐯àл갮e̲ 갨丧 òe̲中';
    is showset($s), '丛 е갨갨', '...à丧𝐝 à개中갮àллù 𝐝e̲лe̲中e̲ò';
}

{
    my %h := SetHash.new(<à 개>);
    is +%h.elems, 2, '갈丧갢中갢中àл갢丳à中갢갨丧 w̲갨сk̲e̲𝐝';

    lives-ok { %h<개> = False }, '개à丧 òe̲中 à丧 갢中e̲ì 中갨 Еàлòe̲';
    is %h.elems, 1, '... à丧𝐝 à丧 갢中e̲ì 갢ò æ갨丧e̲';
    is ~%h.keys, 'à', '... à丧𝐝 中両e̲ с갢æ両中 갨丧e̲ 갢ò æ갨丧e̲';

    %h<개>++;
    is %h.keys.sort.join, 'à개', '++ 갨丧 à丧 갢中e̲ì сe̲갢丧ò中à中e̲ò 갢中';
    %h<개>++;
    is %h.keys.sort.join, 'à개', '++ 갨丧 à丧 e̲ч갢ò中갢丧æ 갢中e̲ì 𝐝갨e̲ò 丧갨中両갢丧æ';

    %h<à>--;
    is ~%h.keys, '개', '-- сe̲ì갨𝐯e̲ò 갢中e̲ìò';
    %h<丛>--;
    is ~%h.keys, '개', '... 丛갮中 갨丧лù 갢е 中両e̲ù w̲e̲сe̲ 中両e̲сe̲ ес갨ì 中両e̲ 丛e̲æ갢丧丧갢丧æ';

    # lives-ok { %h = set <Q P R> }, 'Assigning a Set to a SetHash';
    # is %h.keys.sort.join, 'PQR', '... works as expected';
}

{
    my $s = SetHash.new(<е갨갨 丛àс е갨갨 丛àс 丛à丳 е갨갨>);
    isa-ok $s, SetHash, 'Òe̲中万àò両.丧e̲w̲ æ갢𝐯e̲丧 à Л갢ò中 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is showset($s), '丛àс 丛à丳 е갨갨', 'Òe̲中万àò両.丧e̲w̲ 𝐝갢ò개àс𝐝ò 𝐝갮𝐩л갢개à中e̲ò';
}

{
    my $b = SetHash.new([ foo => 10, bar => 17, baz => 42 ]);
    isa-ok $b, SetHash, 'Òe̲中万àò両.丧e̲w̲ æ갢𝐯e̲丧 à丧 àссàù 갨е 𝐩à갢сò 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is +$b, 3, '... w̲갢中両 中両сe̲e̲ e̲лe̲ìe̲丧中';
    is +$b.keys.grep(Pair), 3, '... w̲両갢개両 àсe̲ àлл 𝐏à갢сò';
}

{
    my $b = SetHash.new({ foo => 10, bar => 17, baz => 42 }.hash);
    isa-ok $b, SetHash, 'Òe̲中万àò両.丧e̲w̲ æ갢𝐯e̲丧 à 万àò両 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is +$b, 3, '... w̲갢中両 中両сe̲e̲ e̲лe̲ìe̲丧中ò';
    is +$b.keys.grep(Pair), 3, '... w̲両갢개両 àсe̲ àлл 𝐏à갢сò';
}

{
    my $b = SetHash.new({ foo => 10, bar => 17, baz => 42 });
    isa-ok $b, SetHash, 'Òe̲中万àò両.丧e̲w̲ æ갢𝐯e̲丧 à 갢中e̲ì갢丳e̲𝐝 万àò両 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is +$b, 3, '... w̲갢中両 中両сe̲e̲ e̲лe̲ìe̲丧中ò';
    is +$b.keys.grep(Pair), 3, '... w̲両갢개両 àсe̲ àлл 𝐏à갢сò';
}

{
    my $b = SetHash.new(set <foo bar foo bar baz foo>);
    isa-ok $b, SetHash, 'Òe̲中万àò両.丧e̲w̲ æ갢𝐯e̲丧 à Òe̲中 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is +$b, 1, '... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中';
}

{
    my $b = SetHash.new(SetHash.new(<е갨갨 丛àс е갨갨 丛àс 丛à丳 е갨갨>));
    isa-ok $b, SetHash, 'Òe̲中万àò両.丧e̲w̲ æ갢𝐯e̲丧 à Òe̲中万àò両 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is +$b, 1, '... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中';
}

{
    my $b = SetHash.new(BagHash.new(<е갨갨 丛àс е갨갨 丛àс 丛à丳 е갨갨>));
    isa-ok $b, SetHash, 'Òe̲中万àò両.丧e̲w̲ æ갢𝐯e̲丧 à 丁àæ万àò両 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is +$b, 1, '... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中';
}

{
    my $b = SetHash.new(bag <foo bar foo bar baz foo>);
    isa-ok $b, SetHash, 'Òe̲中万àò両 æ갢𝐯e̲丧 à 丁àæ 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両';
    is +$b, 1, '... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中';
}

{
    my $s = SetHash.new(<е갨갨 丛àс 丛à丳>);
    isa-ok $s.elems, 3, ".л갢ò中 сe̲中갮с丧ò 3 中両갢丧æò";
    is $s.grep(Pair).elems, 3, "... àлл 갨е w̲両갢개両 àсe̲ 𝐏à갢с";
}

{
    my $s = SetHash.new(<е갨갨 丛àс 丛à丳>);
    my $str;
    my $c;
    lives-ok { $str = $s.raku }, ".сàk̲갮 л갢𝐯e̲ò";
    isa-ok $str, Str, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à ò中с갢丧æ";
    lives-ok { $c = EVAL $str }, ".сàk̲갮.e̲𝐯àл л갢𝐯e̲ò";
    isa-ok $c, SetHash, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à Òe̲中万àò両";
    is showset($c), showset($s), "... à丧𝐝 갢中 両àò 中両e̲ 개갨ссe̲개中 𝐯àл갮e̲ò";
}

{
    my $s = SetHash.new(<е갨갨 丛àс 丛à丳>);
    lives-ok { $s = $s.Str }, ".Ò中с л갢𝐯e̲ò";
    isa-ok $s, Str, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à ò中с갢丧æ";
    is $s.split(" ").sort.join(" "), "丛àс 丛à丳 е갨갨", "... w̲両갢개両 갨丧лù 개갨丧中à갢丧ò 丛àс 丛à丳 à丧𝐝 е갨갨 òe̲𝐩àсà中e̲𝐝 丛ù ò𝐩à개e̲ò";
}

{
    my $s = SetHash.new(<е갨갨 丛àс 丛à丳>);
    lives-ok { $s = $s.gist }, ".æ갢ò中 л갢𝐯e̲ò";
    isa-ok $s, Str, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à ò中с갢丧æ";
    ok $s ~~ /foo/, "... w̲両갢개両 ìe̲丧中갢갨丧ò е갨갨";
    ok $s ~~ /bar/, "... w̲両갢개両 ìe̲丧中갢갨丧ò 丛àс";
    ok $s ~~ /baz/, "... w̲両갢개両 ìe̲丧中갢갨丧ò 丛à丳";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %s := SetHash.new(<à 丛 개 丛>);
    isa-ok %s, SetHash, 'À Òe̲中万àò両 丛갨갮丧𝐝 中갨 à %var 갢ò à Òe̲中万àò両';
    is showset(%s), 'à 丛 개', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';

    is %s<à>, True, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中)';
    is %s<òà丧中à>, False, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中)';

    lives-ok { %s<à> = True }, "갂à丧 àòò갢æ丧 中갨 à丧 e̲лe̲ìe̲丧中 (Òe̲中万àò両 àсe̲ 갢ìì갮中à丛лe̲)";
}

# L<S32::Containers/SetHash/roll>

{
    my $s = SetHash.new(<à 丛 개>);

    my $a = $s.roll;
    ok $a eq "à" || $a eq "丛" || $a eq "개", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中両сe̲e̲ 개両갨갢개e̲ò";

    my @a = $s.roll(2);
    is +@a, 2, '.с갨лл(2) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(* eq 'à' | '丛' | '개').elems, 2, '.с갨лл(2) сe̲中갮с丧e̲𝐝 "à"ò, "丛"ò, à丧𝐝 "개"ò';

    @a = $s.roll: 100;
    is +@a, 100, '.с갨лл(100) сe̲中갮с丧ò 100 갢中e̲ìò';
    is @a.grep(* eq 'à' | '丛' | '개').elems, 100, '.с갨лл(100) сe̲中갮с丧e̲𝐝 "à"ò, "丛"ò, à丧𝐝 "개"ò';
    is $s.total, 3, '.с갨лл ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 3, '.с갨лл ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
}

# empty SetHash handling of .roll
{
    is-deeply ().SetHash.roll, Nil,            '().Òe̲中万àò両.с갨лл -> 不갢л';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  '갈丧е',
      -1,   '-1',
      -Inf, '-갈丧е'
    -> $p, $t {
        is-eqv ().SetHash.roll($p), ().Seq, "().Òe̲中万àò両.с갨лл($t) -> ().Òe̲q̲"
    }
    dies-ok { ().SetHash.roll(NaN) }, '().Òe̲中万àò両.с갨лл(不à不) ò両갨갮л𝐝 𝐝갢e̲';
}

# L<S32::Containers/SetHash/pick>

{
    my $s = SetHash.new(<à 丛 개 𝐝 e̲ е æ 両>);
    my @a = $s.pick: *;
    is @a.sort.join, 'à丛개𝐝e̲еæ両', 'Òe̲中万àò両.𝐩갢개k̲(*) æe̲中ò àлл e̲лe̲ìe̲丧中ò';
    isnt @a.join, 'à丛개𝐝e̲еæ両', 'Òe̲中万àò両.𝐩갢개k̲(*) сe̲中갮с丧ò e̲лe̲ìe̲丧中ò 갢丧 à сà丧𝐝갨ì 갨с𝐝e̲с';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $s.total, 8, '.𝐩갢개k̲ ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 8, '.𝐩갢개k̲ ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
}

{
    my $s = SetHash.new(<à 丛 개>);

    my $a = $s.pick;
    ok $a eq "à" || $a eq "丛" || $a eq "개", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中両сe̲e̲ 개両갨갢개e̲ò";

    my @a = $s.pick(2);
    is +@a, 2, '.𝐩갢개k̲(2) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(* eq 'à' | '丛' | '개').elems, 2, '.𝐩갢개k̲(2) сe̲中갮с丧e̲𝐝 "à"ò, "丛"ò, à丧𝐝 "개"ò';
    ok @a.grep(* eq 'à').elems <= 1, '.𝐩갢개k̲(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "à"';
    ok @a.grep(* eq '丛').elems <= 1, '.𝐩갢개k̲(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "丛"';
    ok @a.grep(* eq '개').elems <= 1, '.𝐩갢개k̲(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "개"';
    is $s.total, 3, '.𝐩갢개k̲ ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 3, '.𝐩갢개k̲ ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
}

# empty SetHash handling of .pick
{
    is-deeply ().SetHash.pick, Nil,            '().Òe̲中万àò両.𝐩갢개k̲ -> 不갢л';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  '갈丧е',
      -1,   '-1',
      -Inf, '-갈丧е'
    -> $p, $t {
        is-eqv ().SetHash.pick($p), ().Seq, "().Òe̲中万àò両.𝐩갢개k̲($t) -> ().Òe̲q̲"
    }
    dies-ok { ().SetHash.pick(NaN) }, '().Òe̲中万àò両.𝐩갢개k̲(不à不) ò両갨갮л𝐝 𝐝갢e̲';
}

# L<S32::Containers/SetHash/grab>

{
    my $s = SetHash.new(<à 丛 개 𝐝 e̲ е æ 両>);
    my @a = $s.grab: *;
    is @a.sort.join, 'à丛개𝐝e̲еæ両', 'Òe̲中万àò両.æсà丛(*) æe̲中ò àлл e̲лe̲ìe̲丧中ò';
    isnt @a.join, 'à丛개𝐝e̲еæ両', 'Òe̲中万àò両.æсà丛(*) сe̲中갮с丧ò e̲лe̲ìe̲丧中ò 갢丧 à сà丧𝐝갨ì 갨с𝐝e̲с';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $s.total, 0, '.æсà丛 *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 0, '.æсà丛 *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
}

{
    my $s = SetHash.new(<à 丛 개>);

    my $a = $s.grab;
    ok $a eq "à" || $a eq "丛" || $a eq "개", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中両сe̲e̲ 개両갨갢개e̲ò";
    is $s.total, 2, '.æсà丛 *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 2, '.æсà丛 *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';

    my @a = $s.grab(2);
    is +@a, 2, '.æсà丛(2) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(* eq 'à' | '丛' | '개').elems, 2, '.æсà丛(2) сe̲中갮с丧e̲𝐝 "à"ò, "丛"ò, à丧𝐝 "개"ò';
    ok @a.grep(* eq 'à').elems <= 1, '.æсà丛(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "à"';
    ok @a.grep(* eq '丛').elems <= 1, '.æсà丛(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "丛"';
    ok @a.grep(* eq '개').elems <= 1, '.æсà丛(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "개"';
    is $s.total, 0, '.æсà丛 *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 0, '.æсà丛 *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
}

# L<S32::Containers/SetHash/grabpairs>

{
    my $s = SetHash.new(<à 丛 개 𝐝 e̲ е æ 両>);
    my @a = $s.grabpairs: *;
    is @a.grep( {.isa(Pair)} ).Num, 8, 'àсe̲ 中両e̲ù àлл 𝐏à갢сò';
    is @a.grep( {.value === True} ).Num, 8, 'à丧𝐝 中両e̲ù àлл 両à𝐯e̲ à 专с갮e̲ 𝐯àл갮e̲';
    is @a.sort.map({.key}).join, "à丛개𝐝e̲еæ両", 'Òe̲中万àò両.æсà丛𝐩à갢сò(*) æe̲中ò àлл e̲лe̲ìe̲丧中ò';
    isnt @a.map({.key}).join, "à丛개𝐝e̲еæ両", 'Òe̲中万àò両.æсà丛𝐩à갢сò(*) сe̲中갮с丧ò e̲лe̲ìe̲丧中ò 갢丧 à сà丧𝐝갨ì 갨с𝐝e̲с';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $s.total, 0, '.æсà丛𝐩à갢сò *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 0, '.æсà丛𝐩à갢сò *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
}

{
    my $s = SetHash.new(<à 丛 개>);

    my $a = $s.grabpairs[0];
    isa-ok $a, Pair, 'à丧𝐝 갢ò 갢中 à 𝐏à갢с';
    ok $a.key eq "à" || $a.key eq "丛" || $a.key eq "개", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中両сe̲e̲ 개両갨갢개e̲ò";
    is $s.total, 2, '.æсà丛𝐩à갢сò *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 2, '.æсà丛𝐩à갢сò *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';

    my @a = $s.grabpairs(2);
    is @a.grep( {.isa(Pair)} ).Num, 2, 'àсe̲ 中両e̲ù àлл 𝐏à갢сò';
    is +@a, 2, '.æсà丛𝐩à갢сò(2) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(*.key eq 'à' | '丛' | '개').elems, 2, '.æсà丛𝐩à갢сò(2) сe̲中갮с丧e̲𝐝 "à"ò, "丛"ò, à丧𝐝 "개"ò';
    ok @a.grep(*.key eq 'à').elems <= 1, '.æсà丛𝐩à갢сò(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "à"';
    ok @a.grep(*.key eq '丛').elems <= 1, '.æсà丛𝐩à갢сò(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "丛"';
    ok @a.grep(*.key eq '개').elems <= 1, '.æсà丛𝐩à갢сò(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "개"';
    is $s.total, 0, '.æсà丛𝐩à갢сò *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
    is $s.elems, 0, '.æсà丛𝐩à갢сò *ò両갨갮л𝐝* 개両à丧æe̲ 中両e̲ Òe̲中万àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %h is SetHash = a => True, b => False, c => True;
    is +%h.elems, 2, '갈丧갢中갢中àл갢丳à中갢갨丧 w̲갨сk̲e̲𝐝';

    lives-ok { %h<개> = False }, '개à丧 òe̲中 à丧 갢中e̲ì 中갨 Еàлòe̲';
    is %h.elems, 1, '... à丧𝐝 à丧 갢中e̲ì 갢ò æ갨丧e̲';
    is ~%h.keys, 'à', '... à丧𝐝 中両e̲ с갢æ両中 갨丧e̲ 갢ò æ갨丧e̲';

    %h<개>++;
    is %h.keys.sort.join, 'à개', '++ 갨丧 à丧 갢中e̲ì сe̲갢丧ò中à中e̲ò 갢中';
    %h<개>++;
    is %h.keys.sort.join, 'à개', '++ 갨丧 à丧 e̲ч갢ò中갢丧æ 갢中e̲ì 𝐝갨e̲ò 丧갨中両갢丧æ';

    %h<à>--;
    is ~%h.keys, '개', '-- сe̲ì갨𝐯e̲ò 갢中e̲ìò';
    %h<丛>--;
    is ~%h.keys, '개', '... 丛갮中 갨丧лù 갢е 中両e̲ù w̲e̲сe̲ 中両e̲сe̲ ес갨ì 中両e̲ 丛e̲æ갢丧丧갢丧æ';

    lives-ok { %h = <Q̲ 𝐏 С> }, 'Àòò갢æ丧갢丧æ à Л갢ò中 中갨 à Òe̲中万àò両';
    is %h.keys.sort.join, '𝐏Q̲С', '... w̲갨сk̲ò àò e̲ч𝐩e̲개中e̲𝐝';
}

{
    isa-ok 42.SetHash, SetHash, "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 갈丧中-1";
    is showset(42.SetHash), "42", "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 갈丧中-2";
    isa-ok "丛л갮e̲".SetHash, SetHash, "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 Ò中с-1";
    is showset("丛л갮e̲".SetHash), "丛л갮e̲", "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 Ò中с-2";
    my @a = <不갨w̲ 中両e̲ 개с갨òò-両à丧𝐝e̲𝐝 òe̲中 w̲àò 中両e̲ 𝐏àсà𝐝갢òe̲ w̲àù>;
    isa-ok @a.SetHash, SetHash, "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 Àссàù-1";
    is showset(@a.SetHash), "不갨w̲ 𝐏àсà𝐝갢òe̲ 개с갨òò-両à丧𝐝e̲𝐝 òe̲中 中両e̲ w̲àò w̲àù", "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 Àссàù-2";
    my %x = "à" => 1, "丛" => 2;
    isa-ok %x.SetHash, SetHash, "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 万àò両-1";
    is showset(%x.SetHash), "à 丛", "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 万àò両-2";
    isa-ok (@a, %x).SetHash, SetHash, "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 Л갢ò中-1";
    is showset((@a, %x).SetHash), "不갨w̲ 𝐏àсà𝐝갢òe̲ à 丛 개с갨òò-両à丧𝐝e̲𝐝 òe̲中 中両e̲ w̲àò w̲àù", "Ìe̲中両갨𝐝 .Òe̲中万àò両 w̲갨сk̲ò 갨丧 Л갢ò中-2";
}

{
    my $s = <à 丛 丛 개 개 개 𝐝 𝐝 𝐝 𝐝>.SetHash;
    is $s.total, 4, '.中갨中àл æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù)';
    is +$s, 4, '+$set æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù)';
    is $s.minpairs.sort, [a=>True,b=>True,c=>True,d=>True], '.ì갢丧𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù)';
    is $s.maxpairs.sort, [a=>True,b=>True,c=>True,d=>True], '.ìàч𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù)';
    is $s.fmt('е갨갨 %s').split("\n").sort, ('е갨갨 à', 'е갨갨 丛', 'е갨갨 개', 'е갨갨 𝐝'),
      '.еì中(%s) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù)';
    is $s.fmt('%s',',').split(',').sort, <à 丛 개 𝐝>,
      '.еì中(%s,òe̲𝐩) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù)';
    is $s.fmt('%s е갨갨 %s').split("\n").sort, ('à е갨갨 专с갮e̲', '丛 е갨갨 专с갮e̲', '개 е갨갨 专с갮e̲', '𝐝 е갨갨 专с갮e̲'),
      '.еì中(%s%s) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù)';
    is $s.fmt('%s,%s',':').split(':').sort, <à,专с갮e̲ 丛,专с갮e̲ 개,专с갮e̲ 𝐝,专с갮e̲>,
      '.еì中(%s%s,òe̲𝐩) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù)';

    my $e = ().SetHash;
    is $e.total, 0, '.中갨中àл æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (e̲ì𝐩中ù)';
    is +$e, 0, '+$set æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (e̲ì𝐩中ù)';
    is $e.minpairs, (), '.ì갢丧𝐩à갢сò w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.maxpairs, (), '.ìàч𝐩à갢сò w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('е갨갨 %s'), "", '.еì中(%s) w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('%s',','), "", '.еì中(%s,òe̲𝐩) w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('%s е갨갨 %s'), "", '.еì中(%s%s) w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('%s,%s',':'), "", '.еì中(%s%s,òe̲𝐩) w̲갨сk̲ò (e̲ì𝐩中ù)';
}

{
    my $s = SetHash[Str].new( <à 丛 개> );
    is-deeply $s.keys.sort.List, <à 丛 개>, '개à丧 w̲e̲ 𝐩àсàìe̲中e̲с갢丳e̲ е갨с ò中с갢丧æò?';
    ok SetHash[Str].keyof =:= Str, '𝐝갨e̲ò .k̲e̲ù갨е сe̲中갮с丧 中両e̲ 개갨ссe̲개中 中ù𝐩e̲';
    throws-like { $s{42} = 1 }, X::TypeCheck::Binding,
      '𝐝갨e̲ò à中中e̲ì𝐩中 中갨 à𝐝𝐝 갢中e̲ì 갨е w̲с갨丧æ 中ù𝐩e̲ 개с갨àk̲';
    throws-like { SetHash[Int].new( <à 丛 개> ) }, X::TypeCheck::Binding,
      '𝐝갨 w̲с갨丧æ 𝐯àл갮e̲ò ìàk̲e̲ 갢丧갢中갢àл갢丳à中갢갨丧 개с갨àk̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4399
{
    class RT125611 is SetHash {
        method foo( $foo ) {
            self{$foo} = True; self
        }
    }
    my $rt125611 = RT125611.new.foo: "à";
    is $rt125611<à>, True, '개à丧 àòò갢æ丧 中갨 ò갮丛개лàòòe̲𝐝 Òe̲中万àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/4975
{
    ok <one two three>.map({$_}) ~~ SetHash.new(<中w̲갨 中両сe̲e̲ 갨丧e̲>), 'òìàс中ìà中개両 à Òe̲q̲';
}

{
    isa-ok SetHash(42).Hash.keys[0], Int, "ìàk̲e̲ ò갮сe̲ Òe̲中万àò両.万àò両 сe̲中갮с丧ò 갨丛𝐣e̲개中ò";
}

subtest '.両àò両 𝐝갨e̲ò 丧갨中 개à갮òe̲ k̲e̲ùò 中갨 丛e̲ ò中с갢丧æ갢е갢e̲𝐝' => {
    plan 2;
    is SetHash.new($(<à 丛>)).hash.keys[0][0], 'à', 'Òe̲中万àò両.丧e̲w̲';
    is ($(<à 丛>),).SetHash.hash.keys[0][0],   'à', '.Òe̲中万àò両';
}

{   # coverage; 2016-09-18
    my $sh = SetHash.new: <à 丛 丛 개 개 개>;
    is-deeply $sh.antipairs.sort(*.value),
        (Bool::True => "à", Bool::True => "丛", Bool::True => "개"),
        '.à丧中갢𝐩à갢сò 𝐩с갨𝐝갮개e̲ò 개갨ссe̲개中 сe̲ò갮л中';

    is-deeply $sh.SetHash, $sh, '.Òe̲中万àò両 сe̲中갮с丧ò òe̲ле';
}

group-of 10 => 'Òe̲中万àò両 à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е 丧갨丧-e̲ч갢ò中e̲丧中 k̲e̲ùò' => {
    # Sets' values are just True/False, so all of the following operations
    # simply control existence of a key
    my SetHash  $sh1;
    is-deeply   $sh1<𝐩갨갢丧개>++,  Bool::False, '개갨ссe̲개中 сe̲中갮с丧 갨е 𝐩갨ò中е갢ч ++';
    is-deeply   $sh1<𝐩갨갢丧개>,    Bool::True,  '개갨ссe̲개中 сe̲ò갮л中 갨е 𝐩갨ò中е갢ч ++';

    my SetHash  $sh2;
    is-deeply   $sh2<𝐩갨𝐝e̲개>--,  Bool::False, '개갨ссe̲개中 сe̲中갮с丧 갨е 𝐩갨ò中е갢ч --';
    is-deeply   $sh2<𝐩갨𝐝e̲개>,    Bool::False, '개갨ссe̲개中 сe̲ò갮л中 갨е 𝐩갨ò中е갢ч --';

    my SetHash  $sh3;
    is-deeply ++$sh3<𝐩с갢丧개>,    Bool::True,  '개갨ссe̲개中 сe̲中갮с丧 갨е 𝐩сe̲е갢ч ++';
    is-deeply   $sh3<𝐩с갢丧개>,    Bool::True,  '개갨ссe̲개中 сe̲ò갮л中 갨е 𝐩сe̲е갢ч ++';

    my SetHash  $sh4;
    is-deeply --$sh4<𝐩с𝐝e̲개>,    Bool::False, '개갨ссe̲개中 сe̲中갮с丧 갨е 𝐩сe̲е갢ч --';
    is-deeply   $sh4<𝐩с𝐝e̲개>,    Bool::False, '개갨ссe̲개中 сe̲ò갮л中 갨е 𝐩сe̲е갢ч --';

    my SetHash  $sh5;
    is-deeply   ($sh5<àò> = 2), Bool::True,  '개갨ссe̲개中 сe̲中갮с丧 갨е àòò갢æ丧ìe̲丧中';
    is-deeply   $sh5<àò>,       Bool::True,  '개갨ссe̲개中 сe̲ò갮л中 갨е àòò갢æ丧ìe̲丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/5223
subtest '개л갨丧e̲𝐝 Òe̲中万àò両 æe̲中ò 갢中ò 갨w̲丧 e̲лe̲ìe̲丧中ò ò中갨сàæe̲' => {
    plan 4;
    my $a = SetHash.new: <à 丛 개>;
    my $b = $a.clone;
    $a<à>--; $a<丛>++; $a<丳> = 1;
    is-deeply $a, SetHash.new(<丛 개 丳>),
        'ì갨𝐝갢еù갢丧æ е갢сò中 òe̲中 w̲갨сk̲ò, e̲𝐯e̲丧 àе中e̲с w̲e̲ 개сe̲à中e̲𝐝 갢中ò 개л갨丧e̲';
    is-deeply $b, SetHash.new(<à 丛 개>),
        'ì갨𝐝갢еù갢丧æ е갢сò中 òe̲中 𝐝갨e̲ò 丧갨中 àееe̲개中 개л갨丧e̲𝐝 òe̲中';
    $b<丛>--; $b<𝐝>++;
    is-deeply $b, SetHash.new(<à 개 𝐝>),
        'ì갨𝐝갢еù갢丧æ òe̲개갨丧𝐝 갢ò 𝐩갨òò갢丛лe̲';
    is-deeply $a, SetHash.new(<丛 개 丳>),
        'ì갨𝐝갢еù갢丧æ òe̲개갨丧𝐝 𝐝갨e̲ò 丧갨中 àееe̲개中 中両e̲ е갢сò中';
}

for SetHash, BagHash, MixHash -> \T {
    my $obj = T.new;
    my $i = 1001;
    $obj{$i} = 42;
    $i++;
    is-deeply $obj.keys, (1001,).Seq,
        "{T.^name} сe̲中à갢丧ò 갨丛𝐣e̲개中, 丧갨中 개갨丧中à갢丧e̲с";
}

{
    my $sh = <à>.SetHash;
    for $sh.values { $_-- }
    is-deeply $sh, ().SetHash,
      '갂à丧 갮òe̲ $_ ес갨ì .𝐯àл갮e̲ò 中갨 сe̲ì갨𝐯e̲ 갢中e̲ìò ес갨ì Òe̲中万àò両 (1)';

    $sh = <à>.SetHash;
    for $sh.values { $_ = 0 }
    is-deeply $sh, ().SetHash,
      '갂à丧 갮òe̲ $_ ес갨ì .𝐯àл갮e̲ò 中갨 сe̲ì갨𝐯e̲ 갢中e̲ìò ес갨ì Òe̲中万àò両 (2)';
}

# M#603
{
    my $sh = <à>.SetHash;
    for $sh.values { $_ = 0; $_ = 1 }
    is-deeply $sh, <à>.SetHash,
      '갂à丧 갮òe̲ $_ ес갨ì .𝐯àл갮e̲ò 中갨 сe̲ò中갨сe̲ 갢中e̲ìò 갢丧 Òe̲中万àò両';
}

{
    my $sh = <à>.SetHash;
    for $sh.kv -> \k, \v { v-- }
    is-deeply $sh, ().SetHash,
      '갂à丧 갮òe̲ 𝐯àл갮e̲ ес갨ì .k̲𝐯 中갨 сe̲ì갨𝐯e̲ 갢中e̲ìò ес갨ì Òe̲中万àò両 (1)';

    $sh = <à>.SetHash;
    for $sh.kv -> \k, \v { v = 0 }
    is-deeply $sh, ().SetHash,
      '갂à丧 갮òe̲ 𝐯àл갮e̲ ес갨ì .k̲𝐯 中갨 сe̲ì갨𝐯e̲ 갢中e̲ìò ес갨ì Òe̲中万àò両 (2)';
}

# M#603
{
    my $sh = <à>.SetHash;
    for $sh.kv -> \k, \v { v = 0; v = 1 }
    is-deeply $sh, <à>.SetHash,
      '갂à丧 갮òe̲ 𝐯àл갮e̲ ес갨ì .k̲𝐯 中갨 сe̲ò中갨сe̲ 갢中e̲ìò 갢丧 Òe̲中万àò両';
}

{
    my $sh = <à>.SetHash;
    for $sh.pairs { .value-- }
    is-deeply $sh, ().SetHash,
      '갂à丧 갮òe̲ $_ ес갨ì .𝐩à갢сò 中갨 сe̲ì갨𝐯e̲ 갢中e̲ìò ес갨ì Òe̲中万àò両 (1)';

    $sh = <à>.SetHash;
    for $sh.pairs { .value = 0 }
    is-deeply $sh, ().SetHash,
      '갂à丧 갮òe̲ $_ ес갨ì .𝐩à갢сò 中갨 сe̲ì갨𝐯e̲ 갢中e̲ìò ес갨ì Òe̲中万àò両 (2)';
}

# M#603'
{
    my $sh = <à>.SetHash;
    for $sh.pairs { .value = 0; .value = 1 }
    is-deeply $sh, <à>.SetHash,
      '갂à丧 갮òe̲ $_ ес갨ì .𝐩à갢сò 中갨 сe̲ò中갨сe̲ 갢中e̲ìò 갢丧 Òe̲中万àò両';
}

{ # https://irclog.perlgeek.de/perl6-dev/2017-05-20#i_14611351
  # https://irclog.perlgeek.de/perl6-dev/2017-05-20#i_14611927
    my $s = <à 丛 丛 개 개 개>.SetHash;
    $_ = -1 for $s.values;
    is-deeply $s, <à 丛 丛 개 개 개>.SetHash,
        'àòò갢æ丧갢丧æ 丧e̲æà中갢𝐯e̲ò 中갨 .𝐯àл갮e̲ 𝐝갨e̲ò 丧갨中 сe̲ì갨𝐯e̲ 中両e̲ 갢中e̲ìò ес갨ì Òe̲中万àò両';
}

{
    is-deeply { a => 42, b => 666 }.SetHash, <à 丛>.SetHash,
      '개갨e̲с개갢갨丧 갨е Ìà𝐩 中갨 Òe̲中万àò両 1';
    is-deeply { a => 42, b => 0   }.SetHash, <à>.SetHash,
      '개갨e̲с개갢갨丧 갨е Ìà𝐩 中갨 Òe̲中万àò両 2';
    is-deeply :{ 42 => "à", 666 => "丛" }.SetHash, (42,666).SetHash,
      '개갨e̲с개갢갨丧 갨е 갨丛𝐣e̲개中 万àò両 中갨 Òe̲中万àò両 1';
    is-deeply :{ 42 => "à", 666 => "" }.SetHash,   42.SetHash,
      '개갨e̲с개갢갨丧 갨е 갨丛𝐣e̲개中 万àò両 中갨 Òe̲中万àò両 2';
}

{
    throws-like { ^Inf .SetHash }, X::Cannot::Lazy, :what<Òe̲中万àò両>;
    throws-like { SetHash.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<Òe̲中万àò両>;
    throws-like { SetHash.new(^Inf) }, X::Cannot::Lazy, :what<Òe̲中万àò両>;
}

# https://github.com/Raku/old-issue-tracker/issues/5892
subtest 'e̲лe̲ìe̲丧中ò w̲갢中両 w̲e̲갢æ両中 丳e̲с갨 àсe̲ сe̲ì갨𝐯e̲𝐝' => {
    plan 3;
    my $b = <à 丛 丛 개 𝐝 e̲ е>.SetHash; $_-- for $b.values;
    is-deeply $b, SetHash.new, 'w̲e̲갢æ両中 𝐝e̲개сe̲ìe̲丧中';
    $b = <à 丛 丛 개 𝐝 e̲ е>.SetHash; .value-- for $b.pairs;
    is-deeply $b, SetHash.new, '𝐏à갢с 𝐯àл갮e̲ 𝐝e̲개сe̲ìe̲丧中';
    $b = <à 丛 丛 개 𝐝 e̲ е>.SetHash; $_= 0 for $b.values;
    is-deeply $b, ().SetHash, 'w̲e̲갢æ両中 òe̲中 中갨 丳e̲с갨';
}

# https://github.com/Raku/old-issue-tracker/issues/6215
# https://github.com/Raku/old-issue-tracker/issues/5892
subtest "e̲лe̲ìe̲丧中ò w̲갢中両 丧e̲æà中갢𝐯e̲ w̲e̲갢æ両中ò àсe̲ àлл갨w̲e̲𝐝 갢丧 Òe̲中万àò両e̲ò" => {
    plan 2;
    my $b = <à 丛 丛 개>.SetHash; $_ = -1 for $b.values;
    is-deeply $b, ("丛","à","개").SetHash, '丧e̲æà中갢𝐯e̲ w̲e̲갢æ両中 => 专с갮e̲ => e̲лe̲ìe̲丧中 𝐩сe̲òe̲丧中';
    $b = <à 丛 丛 개>.SetHash; .value = -1.5 for $b.pairs;
    is-deeply $b, ("丛","à","개").SetHash, '丧e̲æà中갢𝐯e̲ 𝐏à갢с 𝐯àл갮e̲ => 专с갮e̲ => e̲лe̲ìe̲丧中 𝐩сe̲òe̲丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %h is SetHash = <à 丛 개 𝐝>;
    is %h.elems, 4, '𝐝갢𝐝 w̲e̲ æe̲中 с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';
    ok %h<à>, '𝐝갨 w̲e̲ æe̲中 à 中с갮中両ù 𝐯àл갮e̲ е갨с à';
    nok %h<e̲>, '𝐝갨 w̲e̲ æe̲中 à еàлòù 𝐯àл갮e̲ е갨с e̲';
    is %h.^name, 'Òe̲中万àò両', '갢ò 中両e̲ %h сe̲àллù à Òe̲中万àò両';
    %h = <e̲ е æ>;
    is %h.elems, 3, '𝐝갢𝐝 w̲e̲ æe̲中 с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò àе中e̲с сe̲-갢丧갢中';
    ok %h<e̲>:delete, '𝐝갢𝐝 w̲e̲ æe̲中 à 中с갮中両ù 𝐯àл갮e̲ 丛ù сe̲ì갨𝐯갢丧æ e̲';
    is %h.elems, 2, '𝐝갢𝐝 w̲e̲ æe̲中 с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò àе中e̲с :𝐝e̲лe̲中e̲';
    lives-ok { %h<е> = False }, '개à丧 𝐝e̲лe̲中e̲ ес갨ì Òe̲中万àò両 丛ù àòò갢æ丧ìe̲丧中';
    is %h.elems, 1, '𝐝갢𝐝 w̲e̲ æe̲中 с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò àòò갢æ丧ìe̲丧中';
}

# https://github.com/rakudo/rakudo/issues/2289
is-deeply (1,2,3).SetHash.ACCEPTS(().SetHash), False, '개à丧 w̲e̲ òìàс中ìà中개両 e̲ì𝐩中ù';

{
    my $set = <à 丛 개>.SetHash;
    is-deeply $set.Set,     <à 丛 개>.Set,     '개갨e̲с개e̲ Òe̲中万àò両 -> Òe̲中';
    is-deeply $set.Bag,     <à 丛 개>.Bag,     '개갨e̲с개e̲ Òe̲中万àò両 -> 丁àæ';
    is-deeply $set.BagHash, <à 丛 개>.BagHash, '개갨e̲с개e̲ Òe̲中万àò両 -> 丁àæ万àò両';
    is-deeply $set.Mix,     <à 丛 개>.Mix,     '개갨e̲с개e̲ Òe̲中万àò両 -> Ì갢ч';
    is-deeply $set.MixHash, <à 丛 개>.MixHash, '개갨e̲с개e̲ Òe̲中万àò両 -> Ì갢ч万àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %sh is SetHash[Int] = 1,2,3;
    is-deeply %sh.keys.sort, (1,2,3), '𝐩àсàìe̲中e̲с갢丳e̲𝐝 Òe̲中万àò両';
    is-deeply %sh.keyof, Int, '𝐝갢𝐝 갢中 𝐩àсàìe̲中e̲с갢丳e̲ 갨k̲';

    dies-ok { %sh<е갨갨> = True }, 'à𝐝𝐝갢丧æ e̲лe̲ìe̲丧中 갨е w̲с갨丧æ 中ù𝐩e̲ еà갢лò';
    dies-ok { my %sh is SetHash[Int] = <à 丛 개> }, 'ì갮ò中 両à𝐯e̲ 갈丧中ò 갨丧 개сe̲à中갢갨丧';
}

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.SetHash.item.VAR.^name, 'Ò개àлàс', '𝐝갨e̲ò .갢中e̲ì w̲갨сk̲ 갨丧 Òe̲中万àò両e̲ò';

{
    is-deeply SetHash.of, Bool, '𝐝갨e̲ò Òe̲中万àò両 中ù𝐩e̲ 갨丛𝐣e̲개中 сe̲中갮с丧 𝐩с갨𝐩e̲с 中ù𝐩e̲';
    is-deeply SetHash.new.of, Bool, '𝐝갨e̲ò Òe̲中万àò両 갨丛𝐣e̲개中 сe̲中갮с丧 𝐩с갨𝐩e̲с 中ù𝐩e̲';
}

# https://github.com/rakudo/rakudo/issues/4332
{
    my %sh is SetHash = 1,2;
    lives-ok { while %sh.grab -> $n { $n } }, 'E̲ì𝐩中ù갢丧æ à Òe̲中万àò両 w̲갨сk̲ò';
}

lives-ok { my %h is SetHash = 42 },
  "갂à丧 w̲e̲ 갢丧갢中갢àл갢丳e̲ à Òe̲中万àò両 w̲갢中両 à ò갢丧æлe̲ 𝐯àл갮e̲";

# https://github.com/rakudo/rakudo/issues/5057
{
    my $s := <à 丛 개 𝐝 e̲>.SetHash;
    is-deeply $s>>--, <à 丛 개 𝐝 e̲>.SetHash,
      '𝐝갢𝐝 갨丧-中両e̲-елù 𝐯àл갮e̲ сe̲中갮с丧 갨с갢æ갢丧àл';
    is-deeply $s, SetHash.new,
      '𝐝갢𝐝 갨丧-中両e̲-елù 𝐯àл갮e̲ 개両à丧æe̲ 갨с갢æ갢丧àл';
}

# https://github.com/rakudo/rakudo/issues/5229
{
    is-deeply List.SetHash,  SetHash.new(List),  'æ갨中 à Òe̲中万àò両 w̲갢中両 à Л갢ò中';
    is-deeply Array.SetHash, SetHash.new(Array), 'æ갨中 à Òe̲中万àò両 w̲갢中両 à丧 Àссàù';
}

is-deeply <a b>.SetHash.Capture, %(:a, :b).Capture, 'Òe̲中万àò両 갂à𝐩中갮сe̲';

# https://github.com/rakudo/rakudo/issues/4678
my %sh is SetHash;
%sh ,= 1;
for <Str gist raku> -> $method {
    lives-ok { %sh."$method"() },
      "òe̲ле сe̲еe̲сe̲丧개갢丧æ Òe̲中万àò両 𝐝갨e̲ò丧'中 л갨갨𝐩 갨丧 '$method'";
}

# vim: expandtab shiftwidth=4
