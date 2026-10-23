use Test;

plan 257;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# L<S02/Immutable types/'the bag listop'>

{
    my $b = bag <à е갨갨 à à à à 丛 е갨갨>;
    isa-ok $b, Bag, '&bag 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is showkv($b), 'à:5 丛:1 е갨갨:2', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';

    is $b.default, 0, "𝐃e̲еà갮л中ò 中갨 0";
    is $b<à>, 5, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中)';
    isa-ok $b<à>, Int, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 ù갢e̲л𝐝ò à丧 갈丧中';
    is $b<òà丧中à>, 0, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中)';
    isa-ok $b<òà丧中à>, Int, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 ù갢e̲л𝐝ò à丧 갈丧中 (丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中)';
    ok $b<à>:exists, 'e̲ч갢ò中ò w̲갢中両 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中';
    nok $b<òà丧中à>:exists, 'e̲ч갢ò中ò w̲갢中両 丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中';

    is $b.values.elems, 3, "𝐕àл갮e̲ò сe̲中갮с丧ò 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е 𝐯àл갮e̲ò";
    is ([+] $b.values), 8, "𝐕àл갮e̲ò сe̲中갮с丧ò 中両e̲ 개갨ссe̲개中 ò갮ì";
    ok ?$b, "丁갨갨л сe̲中갮с丧ò 专с갮e̲ 갢е 中両e̲сe̲ 갢ò ò갨ìe̲中両갢丧æ 갢丧 中両e̲ 丁àæ";
    nok ?Bag.new(), "丁갨갨л сe̲中갮с丧ò Еàлòe̲ 갢е 中両e̲сe̲ 갢ò 丧갨中両갢丧æ 갢丧 中両e̲ 丁àæ";

    my $hash;
    lives-ok { $hash = $b.hash },
      ".両àò両 𝐝갨e̲ò丧'中 𝐝갢e̲";
    isa-ok $hash, Hash, "...à丧𝐝 갢中 сe̲中갮с丧e̲𝐝 à 万àò両";
    is showkv($hash), 'à:5 丛:1 е갨갨:2', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';

    throws-like { $b<à> = 5 },
      X::Assignment::RO,
      "갂à丧'中 àòò갢æ丧 中갨 à丧 e̲лe̲ìe̲丧中 (丁àæò àсe̲ 갢ìì갮中à丛лe̲)";
    throws-like { $b<à>++ },
      Exception, # no exception type yet
      "갂à丧'中 갢丧개сe̲ìe̲丧中 à丧 e̲лe̲ìe̲丧中 (丁àæò àсe̲ 갢ìì갮中à丛лe̲)";
    throws-like { $b.keys = <개 𝐝> },
      X::Assignment::RO,
      "갂à丧'中 àòò갢æ丧 中갨 .k̲e̲ùò";
    throws-like { $b.values = 3, 4 },
      X::Assignment::RO,
      "갂à丧'中 àòò갢æ丧 中갨 .𝐯àл갮e̲ò";
    throws-like { $b<à>:delete },
      X::Assignment::RO,
      "갂à丧'中 :𝐝e̲лe̲中e̲ ес갨ì 丁àæ";

    is ~$b<a b>, "5 1", 'Ì갮л中갢𝐩лe̲-e̲лe̲ìe̲丧中 à개개e̲òò';
    is ~$b<a santa b easterbunny>, "5 0 1 0", 'Ì갮л中갢𝐩лe̲-e̲лe̲ìe̲丧中 à개개e̲òò (w̲갢中両 丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中ò)';
}

{
    ok (bag <à 丛 개>) ~~ (bag <à 丛 개>), "갈𝐝e̲丧中갢개àл 丛àæò òìàс中ìà中개両 w̲갢中両 e̲à개両 갨中両e̲с";
    ok (bag <à 丛 개 개>) ~~ (bag <à 丛 개 개>), "갈𝐝e̲丧中갢개àл 丛àæò òìàс中ìà中개両 w̲갢中両 e̲à개両 갨中両e̲с";
    nok (bag <丛 개>) ~~ (bag <à 丛 개>), "Ò갮丛òe̲中 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok (bag <à 丛 개>) ~~ (bag <à 丛 개 개>), "Ò갮丛òe̲中 (갨丧лù q̲갮à丧中갢中ù 𝐝갢ееe̲сe̲丧中) 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok (bag <à 丛 개 𝐝>) ~~ (bag <à 丛 개>), "Ò갮𝐩e̲сòe̲中 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok (bag <à 丛 개 개 개>) ~~ (bag <à 丛 개 개>), "Ò갮𝐩e̲сòe̲中 (갨丧лù q̲갮à丧中갢中ù 𝐝갢ееe̲сe̲丧中) 𝐝갨e̲ò 丧갨中 òìàс中ìà中개両";
    nok "à" ~~ (bag <à 丛 개>), "Òìàс中ìà中개両 갢ò 丧갨中 e̲лe̲ìe̲丧中 갨е";
    ok (bag <à 丛 개>) ~~ Bag, "专ù𝐩e̲-개両e̲개k̲갢丧æ òìàс中ìà中개両 w̲갨сk̲ò";

    ok (set <à 丛 개>) ~~ (bag <à 丛 개>), "Òe̲中 òìàс中ìà中개両e̲ò w̲갢中両 e̲q̲갮갢𝐯àлe̲丧中 丛àæ";
    nok (set <à 丛 개>) ~~ (bag <à à à 丛 개>), "... 丛갮中 丧갨中 갢е 中両e̲ 丁àæ 両àò æсe̲à中e̲с q̲갮à丧中갢中갢e̲ò";
    nok (set <à 丛 개>) ~~ Bag, "专ù𝐩e̲-개両e̲개k̲갢丧æ òìàс中ìà中개両 w̲갨сk̲ò";
}

{
    isa-ok "à".Bag, Bag, "Ò中с.丁àæ ìàk̲e̲ò à 丁àæ";
    is showkv("à".Bag), 'à:1', "'à'.丁àæ 갢ò 丛àæ à";

    isa-ok (a => 100000).Bag, Bag, "𝐏à갢с.丁àæ ìàk̲e̲ò à 丁àæ";
    is showkv((a => 100000).Bag), 'à:100000', "(à => 100000).丁àæ 갢ò 丛àæ à:100000";
    is showkv((a => 0).Bag), '', "(à => 0).丁àæ 갢ò 中両e̲ e̲ì𝐩中ù 丛àæ";

    isa-ok <à 丛 개>.Bag, Bag, "<à 丛 개>.丁àæ ìàk̲e̲ò à 丁àæ";
    is showkv(<à 丛 개 à>.Bag), 'à:2 丛:1 개:1', "<à 丛 개 à>.丁àæ ìàk̲e̲ò 中両e̲ 丛àæ à:2 丛:1 개:1";
    is showkv(["à", "丛", "개", "à"].Bag), 'à:2 丛:1 개:1', "[à 丛 개 à].丁àæ ìàk̲e̲ò 中両e̲ 丛àæ à:2 丛:1 개:1";
    is showkv([a => 3, b => 0, '개', 'à'].Bag), 'à:4 개:1', "[à => 3, 丛 => 0, '개', 'à'].丁àæ ìàk̲e̲ò 中両e̲ 丛àæ à:4 개:1";

    isa-ok {a => 2, b => 4, c => 0}.Bag, Bag, "{a => 2, b => 4, c => 0}.丁àæ ìàk̲e̲ò à 丁àæ";
    is showkv({a => 2, b => 4, c => 0}.Bag), 'à:2 丛:4', "{a => 2, b => 4, c => 0}.丁àæ ìàk̲e̲ò 中両e̲ 丛àæ à:2 丛:4";
}

{
    my $b = bag <à à 丛 е갨갨>;
    is $b<à>:exists, True, ':e̲ч갢ò中ò w̲갢中両 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中';
    is $b<òà丧中à>:exists, False, ':e̲ч갢ò中ò w̲갢中両 丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中';
    throws-like { $b<à>:delete },
      X::Assignment::RO,
      ':𝐝e̲лe̲中e̲ 𝐝갨e̲ò 丧갨中 w̲갨сk̲ 갨丧 丛àæ';
}

{
    my $b = bag 'à', False, 2, 'à', False, False;
    my @ks = $b.keys;
    is @ks.grep({ .WHAT === Int })[0], 2, '갈丧中 k̲e̲ùò àсe̲ лe̲е中 àò 갈丧中ò';
    is @ks.grep(* eqv False).elems, 1, '丁갨갨л k̲e̲ùò àсe̲ лe̲е中 àò 丁갨갨лò';
    is @ks.grep(Str)[0], 'à', 'À丧𝐝 Ò中с k̲e̲ùò àсe̲ 𝐩e̲сì갢中中e̲𝐝 갢丧 中両e̲ òàìe̲ òe̲中';
    is $b{2, 'à', False}.join(' '), '1 2 3', 'Àлл k̲e̲ùò 両à𝐯e̲ 中両e̲ с갢æ両中 𝐯àл갮e̲ò';
}

{
    my %s = bag <à 丛 갨 𝐩 à 𝐩 갨 갨>;
    is-deeply %s, { :2a, :1b, :3o, :2p }, 'ò갢丧æлe̲ àсæ с갮лe̲ с갮лe̲ò';
    my %m = bag <à 丛 갨 𝐩>,< à 𝐩 갨 갨>;
    is-deeply %m, { :2a, :1b, :3o, :2p }, 'елà中中e̲丧갢丧æ с갮лe̲ò';
}
{
    my %h := bag <à 丛 갨 𝐩 à 𝐩 갨 갨>;
    ok %h ~~ Bag, 'À 両àò両 中갨 w̲両갢개両 à 丁àæ 両àò 丛e̲e̲丧 丛갨갮丧𝐝 丛e̲개갨ìe̲ò à 丁àæ';
    is showkv(%h), 'à:2 丛:1 갨:3 𝐩:2', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';
}

{
    my $b = bag <à 丛 갨 𝐩 à 𝐩 갨 갨>;
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à丧 àссàù 갨е ò中с갢丧æò 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is showkv($b), 'à:2 丛:1 갨:3 𝐩:2', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';
}

{
    my $b = bag [ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à丧 àссàù 갨е 𝐩à갢сò 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 4, "... w̲갢中両 е갨갮с e̲лe̲ìe̲丧中ò 갮丧𝐝e̲с 中両e̲ ò갢丧æлe̲ àсæ с갮лe̲";
}

{
    my $b = bag $[ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à丧 갢中e̲ì갢丳e̲𝐝 àссàù 갨е 𝐩à갢сò 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 1, "... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
}

{
    # {}.hash interpolates in list context
    my $b = bag { foo => 10, bar => 17, baz => 42, santa => 0 }.hash;
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à 万àò両 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 4, "... w̲갢中両 е갨갮с e̲лe̲ìe̲丧中ò";
    is +$b.grep(Pair), 4, "... w̲両갢개両 àсe̲ àлл 𝐏à갢сò";
}

{
    my $b = bag { foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à 万àò両 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 4, "... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
}
{
    my $b = bag ${ foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à丧 갢中e̲ì갢丳e̲𝐝 万àò両 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 1, "... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
}

{
    my $b = bag set <е갨갨 丛àс е갨갨 丛àс 丛à丳 е갨갨>;
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à Òe̲中 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 1, "... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
}

{
    my $b = bag SetHash.new(<е갨갨 丛àс е갨갨 丛àс 丛à丳 е갨갨>);
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à Òe̲中万àò両 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 1, "... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
}

{
    my $b = bag BagHash.new(<е갨갨 丛àс е갨갨 丛àс 丛à丳 е갨갨>);
    isa-ok $b, Bag, '&Bag.丧e̲w̲ æ갢𝐯e̲丧 à 丁àæ万àò両 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 1, "... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
}

{
    my $b = bag set <е갨갨 丛àс е갨갨 丛àс 丛à丳 е갨갨>;
    isa-ok $b, Bag, '&bag æ갢𝐯e̲丧 à Òe̲中 𝐩с갨𝐝갮개e̲ò à 丁àæ';
    is +$b, 1, "... w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := bag <à 丛 개 丛>;
    isa-ok %b, Bag, 'À 丁àæ 丛갨갮丧𝐝 中갨 à %var 갢ò à 丁àæ';
    is showkv(%b), 'à:1 丛:2 개:1', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';

    is %b<丛>, 2, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中)';
    is %b<òà丧中à>, 0, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中)';

    throws-like { %b<à> = 1 },
      X::Assignment::RO,
      "갂à丧'中 àòò갢æ丧 中갨 à丧 e̲лe̲ìe̲丧中 (丁àæò àсe̲ 갢ìì갮中à丛лe̲)";
    throws-like { %b = bag <à 丛> },
      X::Assignment::RO,
      "갂à丧'中 àòò갢æ丧 中갨 à %var 갢ì𝐩лe̲ìe̲丧中e̲𝐝 丛ù 丁àæ";
    throws-like { %b<à>:delete },
      X::Assignment::RO,
      "갂à丧'中 :𝐝e̲лe̲中e̲ ес갨ì à 丁àæ";
}

{
    my $b = { foo => 10, bar => 1, baz => 2}.Bag;

    # .list is just the keys, as per TimToady:
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    is $b.list.elems, 3, ".л갢ò中 сe̲中갮с丧ò 3 中両갢丧æò";
    is $b.list.grep(Pair).elems, 3, "... àлл 갨е w̲両갢개両 àсe̲ 𝐏à갢сò";

    is $b.pairs.elems, 3, ".𝐩à갢сò сe̲中갮с丧ò 3 中両갢丧æò";
    is $b.pairs.grep(Pair).elems, 3, "... àлл 갨е w̲両갢개両 àсe̲ 𝐏à갢сò";
    is $b.pairs.grep({ .key ~~ Str }).elems, 3, "... 中両e̲ k̲e̲ùò 갨е w̲両갢개両 àсe̲ Ò中сò";
    is $b.pairs.grep({ .value ~~ Int }).elems, 3, "... à丧𝐝 中両e̲ 𝐯àл갮e̲ò 갨е w̲両갢개両 àсe̲ 갈丧中ò";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.Bag;
    my $s;
    my $c;
    lives-ok { $s = $b.raku },
      ".сàk̲갮 л갢𝐯e̲ò";
    isa-ok $s, Str, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à ò中с갢丧æ";
    ok $s.chars < 1000, "... 갨е сe̲àò갨丧à丛лe̲ лe̲丧æ中両";
    lives-ok { $c = EVAL $s },
      ".сàk̲갮.E̲𝐕ÀЛ л갢𝐯e̲ò";
    isa-ok $c, Bag, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à 丁àæ";
    is showkv($c), showkv($b), "... à丧𝐝 갢中 両àò 中両e̲ 개갨ссe̲개中 𝐯àл갮e̲ò";
}

{
    my $b = { foo => 2, bar => 3, baz => 1 }.Bag;
    my $s;
    lives-ok { $s = $b.Str },
      ".Ò中с л갢𝐯e̲ò";
    isa-ok $s, Str, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à ò中с갢丧æ";
    is $s.split(" ").sort.join(" "), "丛àс(3) 丛à丳 е갨갨(2)", "... w̲両갢개両 갨丧лù 개갨丧中à갢丧ò 丛àс 丛à丳 à丧𝐝 е갨갨 w̲갢中両 中両e̲ 𝐩с갨𝐩e̲с 개갨갮丧中ò à丧𝐝 òe̲𝐩àсà中e̲𝐝 丛ù ò𝐩à개e̲ò";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.Bag;
    my $s;
    lives-ok { $s = $b.gist },
      ".æ갢ò中 л갢𝐯e̲ò";
    isa-ok $s, Str, "... à丧𝐝 𝐩с갨𝐝갮개e̲ò à ò中с갢丧æ";
    ok $s.chars < 1000, "... 갨е сe̲àò갨丧à丛лe̲ лe̲丧æ中両";
    ok $s ~~ /foo/, "... w̲両갢개両 ìe̲丧中갢갨丧ò е갨갨";
    ok $s ~~ /bar/, "... w̲両갢개両 ìe̲丧中갢갨丧ò 丛àс";
    ok $s ~~ /baz/, "... w̲両갢개両 ìe̲丧中갢갨丧ò 丛à丳";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := bag "à", "丛", "개", "丛";
    isa-ok %b, Bag, 'À 丁àæ 丛갨갮丧𝐝 中갨 à %var 갢ò à 丁àæ';
    is showkv(%b), 'à:1 丛:2 개:1', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';

    is %b<丛>, 2, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中)';
    is %b<òà丧中à>, 0, 'Ò갢丧æлe̲-k̲e̲ù ò갮丛ò개с갢𝐩中 (丧갨丧e̲ч갢ò中e̲丧中 e̲лe̲ìe̲丧中)';
}

# L<S32::Containers/Bag/roll>

{
    my $b = Bag.new("à", "丛", "丛");

    my $a = $b.roll;
    ok $a eq "à" || $a eq "丛", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中w̲갨 개両갨갢개e̲ò";

    my @a = $b.roll(2);
    is +@a, 2, '.с갨лл(2) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(* eq 'à').elems + @a.grep(* eq '丛').elems, 2, '.с갨лл(2) сe̲中갮с丧e̲𝐝 "à"ò à丧𝐝 "丛"ò';

    @a = $b.roll: 100000;
    is +@a, 100000, '.с갨лл(100000) сe̲中갮с丧ò 100000 갢中e̲ìò';
    ok 2 < @a.grep(* eq 'à') < 75000, '.с갨лл(100000) (1)';
    ok @a.grep(* eq 'à') + 2 < @a.grep(* eq '丛'), '.с갨лл(100000) (2)';

    @a = $b.roll(*)[^100000];
    ok 2 < @a.grep(* eq 'à') < 75000, '.с갨лл(100000) (1)';
    ok @a.grep(* eq 'à') + 2 < @a.grep(* eq '丛'), '.с갨лл(100000) (2)';

    is $b.total, 3, '.с갨лл ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 丁àæ';
}

{
    my $b = {"à" => 100000000000, "丛" => 1}.Bag;

    my $a = $b.roll;
    ok $a eq "à" || $a eq "丛", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中w̲갨 개両갨갢개e̲ò (à丧𝐝 中両갢ò w̲àò 𝐩сe̲中中ù q̲갮갢개k̲, w̲e̲ 両갨𝐩e̲!)";

    my @a = $b.roll: 100000;
    is +@a, 100000, '.с갨лл(100000) сe̲中갮с丧ò 100000 갢中e̲ìò';
    ok @a.grep(* eq 'à') > 97000, '.с갨лл(100000) (1)';
    ok @a.grep(* eq '丛') < 3000, '.с갨лл(100000) (2)';
    is $b.total, 100000000001, '.с갨лл ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 丁àæ';
}

# L<S32::Containers/Bag/pick>

{
    my $b = Bag.new("à", "丛", "丛");

    my $a = $b.pick;
    ok $a eq "à" || $a eq "丛", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中w̲갨 개両갨갢개e̲ò";

    my @a = $b.pick(2);
    is +@a, 2, '.𝐩갢개k̲(2) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    ok @a.grep(* eq 'à').elems <= 1, '.𝐩갢개k̲(2) сe̲中갮с丧e̲𝐝 à中 ì갨ò中 갨丧e̲ "à"';
    is @a.grep(* eq '丛').elems, 2 - @a.grep(* eq 'à').elems, '.𝐩갢개k̲(2) à丧𝐝 中両e̲ сe̲ò中 àсe̲ "丛"';

    @a = $b.pick: *;
    is +@a, 3, '.𝐩갢개k̲(*) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(* eq 'à').elems, 1, '.𝐩갢개k̲(*) (1)';
    is @a.grep(* eq '丛').elems, 2, '.𝐩갢개k̲(*) (2)';
    is $b.total, 3, '.𝐩갢개k̲ ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 丁àæ';

    @a = $b.pick(-2.5);
    is +@a, 0, '.𝐩갢개k̲(<丧e̲æà中갢𝐯e̲ 丧갮ì丛e̲с>) 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 à丧ù 갢中e̲ìò';

    # https://github.com/rakudo/rakudo/issues/1438
	  lives-ok { $b.pick(1).gist }, ".𝐩갢개k̲() æ갢𝐯e̲ò 𝐯àл갢𝐝 сe̲ò갮л中 w̲갢中両 àсæ갮ìe̲丧中";
    # https://github.com/Raku/old-issue-tracker/issues/6228
    is +$b.pick(2.5), 2, ".𝐩갢개k̲ 갢丧中-갢е갢e̲ò àсæ";
}

{
    my $b = {"à" => 100000000000, "丛" => 1}.Bag;

    my $a = $b.pick;
    ok $a eq "à" || $a eq "丛", "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中w̲갨 개両갨갢개e̲ò (à丧𝐝 中両갢ò w̲àò 𝐩сe̲中中ù q̲갮갢개k̲, w̲e̲ 両갨𝐩e̲!)";

    my @a = $b.pick: 100;
    is +@a, 100, '.𝐩갢개k̲(100) сe̲中갮с丧ò 100 갢中e̲ìò';
    ok @a.grep(* eq 'à') > 98, '.𝐩갢개k̲(100) (1)';
    ok @a.grep(* eq '丛') < 2, '.𝐩갢개k̲(100) (2)';
    is $b.total, 100000000001, '.𝐩갢개k̲ ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 丁àæ';
}

# L<S32::Containers/Bag/pickpairs>

{
    my $b = Bag.new("à", "丛", "丛");

    my $a = $b.pickpairs;
    isa-ok $a, Pair, '𝐃갢𝐝 w̲e̲ æe̲中 à 𝐏à갢с';
    ok ($a eq "à\t1" or $a eq "丛\t2"), "W̲e̲ æ갨中 갨丧e̲ 갨е 中両e̲ 中w̲갨 개両갨갢개e̲ò";

    my @a = $b.pickpairs(2);
    is +@a, 2, '.𝐩갢개k̲𝐩à갢сò(2) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(* eq "à\t1").elems, 1, '.𝐩갢개k̲𝐩à갢сò(2) сe̲中갮с丧e̲𝐝 갨丧e̲ "à"';
    is @a.grep(* eq "丛\t2").elems, 1, '.𝐩갢개k̲𝐩à갢сò(2) сe̲中갮с丧e̲𝐝 갨丧e̲ "丛"';

    @a = $b.pickpairs: *;
    is +@a, 2, '.𝐩갢개k̲𝐩à갢сò(*) сe̲中갮с丧ò 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';
    is @a.grep(* eq "à\t1").elems, 1, '.𝐩갢개k̲𝐩à갢сò(*) (1)';
    is @a.grep(* eq "丛\t2").elems, 1, '.𝐩갢개k̲𝐩à갢сò(*) (2)';
    is $b.total, 3, '.𝐩갢개k̲𝐩à갢сò ò両갨갮л𝐝 丧갨中 개両à丧æe̲ 丁àæ';

    @a = $b.pickpairs(-2.5);
    is +@a, 0, '.𝐩갢개k̲𝐩à갢сò(<丧e̲æà中갢𝐯e̲ 丧갮ì丛e̲с>) 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 à丧ù 갢中e̲ìò';
}

# L<S32::Containers/Bag/grab>

{
    my $b = bag <à 丛 丛 개 개 개>;
    throws-like { $b.grab },
      X::Immutable,
      '개à丧丧갨中 개àлл .æсà丛 갨丧 à 丁àæ';
}

# L<S32::Containers/Bag/grabpairs>

{
    my $b = bag <à 丛 丛 개 개 개>;
    throws-like { $b.grabpairs },
      X::Immutable,
      '개à丧丧갨中 개àлл .æсà丛𝐩à갢сò 갨丧 à 丁àæ';
}

{
    my $b1 = Bag.new( (bag <à 丛 개>) , <개 개 개 𝐝 𝐝 𝐝 𝐝>);
    is +$b1, 2, "专w̲갨 e̲лe̲ìe̲丧中ò";
    my $inner-bag = $b1.keys.first(Bag);
    isa-ok $inner-bag, Bag, "갎丧e̲ 갨е 中両e̲ 丛àæ'ò e̲лe̲ìe̲丧中ò 갢ò 갢丧𝐝e̲e̲𝐝 à 丁àæ!";
    is showkv($inner-bag), "à:1 丛:1 개:1", "W̲갢中両 中両e̲ 𝐩с갨𝐩e̲с e̲лe̲ìe̲丧中ò";
    my $inner-list = $b1.keys.first(List);
    isa-ok $inner-list, List, "갎丧e̲ 갨е 中両e̲ 丛àæ'ò e̲лe̲ìe̲丧中ò 갢ò 갢丧𝐝e̲e̲𝐝 à Л갢ò中!";
    is $inner-list, <개 개 개 𝐝 𝐝 𝐝 𝐝>, 'w̲갢中両 中両e̲ 𝐩с갨𝐩e̲с e̲лe̲ìe̲丧中ò';

    my $b = bag <à 丛 개>;
    $b1 = Bag.new($b, <개 𝐝>);
    is +$b1, 2, "专w̲갨 e̲лe̲ìe̲丧中ò";
    $inner-bag = $b1.keys.first(Bag);
    isa-ok $inner-bag, Bag, "갎丧e̲ 갨е 中両e̲ 丛àæ'ò e̲лe̲ìe̲丧中ò 갢ò 갢丧𝐝e̲e̲𝐝 à 丛àæ!";
    is showkv($inner-bag), "à:1 丛:1 개:1", "W̲갢中両 中両e̲ 𝐩с갨𝐩e̲с e̲лe̲ìe̲丧中ò";
    $inner-list = $b1.keys.first(List);
    isa-ok $inner-list, List, "갎丧e̲ 갨е 中両e̲ 丛àæ'ò e̲лe̲ìe̲丧中ò 갢ò 갢丧𝐝e̲e̲𝐝 à Л갢ò中!";
    is $inner-list, <개 𝐝>, 'w̲갢中両 中両e̲ 𝐩с갨𝐩e̲с e̲лe̲ìe̲丧中ò';
}

{
    isa-ok 42.Bag, Bag, "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 갈丧中-1";
    is showkv(42.Bag), "42:1", "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 갈丧中-2";
    isa-ok "丛л갮e̲".Bag, Bag, "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 Ò中с-1";
    is showkv("丛л갮e̲".Bag), "丛л갮e̲:1", "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 Ò中с-2";
    my @a = <丧갨w̲ 中両e̲ 개с갨òò-両à丧𝐝e̲𝐝 òe̲中 w̲àò 中両e̲ 𝐩àсà𝐝갢òe̲ w̲àù>;
    isa-ok @a.Bag, Bag, "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 Àссàù-1";
    is showkv(@a.Bag), "개с갨òò-両à丧𝐝e̲𝐝:1 丧갨w̲:1 𝐩àсà𝐝갢òe̲:1 òe̲中:1 中両e̲:2 w̲àò:1 w̲àù:1", "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 Àссàù-2";
    my %x = "à" => 1, "丛" => 2;
    isa-ok %x.Bag, Bag, "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 万àò両-1";
    is showkv(%x.Bag), "à:1 丛:2", "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 万àò両-2";
    isa-ok (@a, %x).Bag, Bag, "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 Л갢ò中-1";
    is showkv((@a, %x).Bag), "à:1 丛:2 개с갨òò-両à丧𝐝e̲𝐝:1 丧갨w̲:1 𝐩àсà𝐝갢òe̲:1 òe̲中:1 中両e̲:2 w̲àò:1 w̲àù:1",
       "Ìe̲中両갨𝐝 .丁àæ w̲갨сk̲ò 갨丧 Л갢ò中-2";
}

{
    my $b1 = <à 丛 丛 개 개 개 𝐝 𝐝 𝐝 𝐝>.Bag;
    is $b1.total, 10, '.中갨中àл æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù 10)';
    is +$b1, 10, '+$bag æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù 10)';
    is $b1.minpairs, [a=>1], '.ì갢丧𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 10)';
    is $b1.maxpairs, [d=>4], '.ìàч𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 10)';
    # Bag is unordered according to S02:1476
    is $b1.fmt('е갨갨 %s').split("\n").sort, ('е갨갨 à', 'е갨갨 丛', 'е갨갨 개', 'е갨갨 𝐝'),
      '.еì中(%s) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 10)';
    is $b1.fmt('%s',',').split(',').sort, <à 丛 개 𝐝>,
      '.еì中(%s,òe̲𝐩) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 10)';
    is $b1.fmt('%s е갨갨 %s').split("\n").sort, ('à е갨갨 1', '丛 е갨갨 2', '개 е갨갨 3', '𝐝 е갨갨 4'),
      '.еì中(%s%s) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 10)';
    is $b1.fmt('%s,%s',':').split(':').sort, <à,1 丛,2 개,3 𝐝,4>,
      '.еì中(%s%s,òe̲𝐩) w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 10)';

    my $b2 = <à 丛 개 개 개 𝐝 𝐝 𝐝>.Bag;
    is $b2.total, 8, '.中갨中àл æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù 8)';
    is +$b2, 8, '+$bag æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù 8)';
    is $b2.minpairs.sort, [a=>1, b=>1], '.ì갢丧𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 8)';
    is $b2.maxpairs.sort, [c=>3, d=>3], '.ìàч𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 8)';

    $b2 = <à 丛 개 𝐝>.Bag;
    is $b2.total, 4, '.中갨中àл æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù 4)';
    is +$b2, 4, '+$bag æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (丧갨丧-e̲ì𝐩中ù 4)';
    is $b2.minpairs.sort,[a=>1,b=>1,c=>1,d=>1], '.ì갢丧𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 4)';
    is $b2.maxpairs.sort,[a=>1,b=>1,c=>1,d=>1], '.ìàч𝐩à갢сò w̲갨сk̲ò (丧갨丧-e̲ì𝐩中ù 4)';

    my $e = ().Bag;
    is $e.total, 0, '.中갨中àл æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (e̲ì𝐩中ù)';
    is +$e, 0, '+$bag æ갢𝐯e̲ò ò갮ì 갨е 𝐯àл갮e̲ò (e̲ì𝐩中ù)';
    is $e.minpairs, (), '.ì갢丧𝐩à갢сò w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.maxpairs, (), '.ìàч𝐩à갢сò w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('е갨갨 %s'), "", '.еì中(%s) w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('%s',','), "", '.еì中(%s,òe̲𝐩) w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('%s е갨갨 %s'), "", '.еì中(%s%s) w̲갨сk̲ò (e̲ì𝐩中ù)';
    is $e.fmt('%s,%s',':'), "", '.еì中(%s%s,òe̲𝐩) w̲갨сk̲ò (e̲ì𝐩中ù)';
}

{
    is-deeply Bag[Str].new( <à 丛 개> ).keys.sort.List, <à 丛 개>,
      '개à丧 w̲e̲ 𝐩àсàìe̲中e̲с갢丳e̲ е갨с ò中с갢丧æò?';
    ok Bag[Str].keyof =:= Str, '𝐝갨e̲ò .k̲e̲ù갨е сe̲中갮с丧 中両e̲ 개갨ссe̲개中 中ù𝐩e̲';
    throws-like { Bag[Int].new( <à 丛 개> ) }, X::TypeCheck::Binding,
      '𝐝갨 w̲с갨丧æ 𝐯àл갮e̲ò ìàk̲e̲ 갢丧갢中갢àл갢丳à中갢갨丧 개с갨àk̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3805
isnt
  '91𝐃95𝐃6E̲𝐃𝐃0Е0갂61𝐃02À2989781갂5ÀE̲丁10832갂94'.Bag.WHICH,
  <à 丛 개>.Bag.WHICH,
  'Еà갮л中ù .W̲万갈갂万 개сe̲à中갢갨丧';

# https://github.com/Raku/old-issue-tracker/issues/3126
{
    my @pairings;
    my Bag $bag .= new: <е갨갨 е갨갨 丛àс>;
    for $bag.keys X $bag.keys -> ($a, $b) {
        @pairings.push: $a ~ $b;
    }
    @pairings .= sort;
    my $string = [~] @pairings;
    is $string, '丛àс丛àс丛àсе갨갨е갨갨丛àсе갨갨е갨갨',
        '개à丧 갮òe̲ 개с갨òò 갨𝐩e̲сà中갨с Ч w̲갢中両 丛àæ k̲e̲ùò';
}

# https://github.com/Raku/old-issue-tracker/issues/4399
{
    my class MyBag is Bag { }
    my $b = MyBag.new(|<à е갨갨 à à à à 丛 е갨갨>);
    isa-ok $b, MyBag, 'Ìù丁àæ.丧e̲w̲ 𝐩с갨𝐝갮개e̲ò à Ìù丁àæ';
    is showkv($b), 'à:5 丛:1 е갨갨:2', '...w̲갢中両 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中ò';
}

{
    my $b = <à>.Bag;
    throws-like { $b<à> = 42 },
      X::Assignment::RO,
      'Ìàk̲e̲ ò갮сe̲ w̲e̲ 개à丧丧갨中 àòò갢æ丧 갨丧 à k̲e̲ù';

    throws-like { $_ = 666 for $b.values },
     Exception,   # X::Assignment::RO ???
      'Ìàk̲e̲ ò갮сe̲ w̲e̲ 개à丧丧갨中 àòò갢æ丧 갨丧 à .𝐯àл갮e̲ò àл갢àò';

    throws-like { .value = 999 for $b.pairs },
      X::Assignment::RO,
      'Ìàk̲e̲ ò갮сe̲ w̲e̲ 개à丧丧갨中 àòò갢æ丧 갨丧 à .𝐩à갢сò àл갢àò';

    throws-like { for $b.kv -> \k, \v { v = 22 } },
      X::Assignment::RO,
      'Ìàk̲e̲ ò갮сe̲ w̲e̲ 개à丧丧갨中 àòò갢æ丧 갨丧 à .k̲𝐯 àл갢àò';
}

{
    my $b = <à 丛 丛 개 개 개 𝐝 𝐝 𝐝 𝐝>.Bag;
    my @a1;
    for $b.values -> \v { @a1.push(v) }
    is @a1.sort, (1,2,3,4), '𝐝갢𝐝 w̲e̲ òe̲e̲ àлл 𝐯àл갮e̲ò';
    my @a2;
    for $b.keys -> \v { @a2.push(v) }
    is @a2.sort, <à 丛 개 𝐝>, '𝐝갢𝐝 w̲e̲ òe̲e̲ àлл k̲e̲ùò';
    my %h1;
    for $b.pairs -> \p { %h1{p.key} = p.value }
    is %h1.sort, (:1a, :2b, :3c, :4d), '𝐝갢𝐝 w̲e̲ òe̲e̲ àлл 中両e̲ 𝐩à갢сò';
    my %h2;
    for $b.kv -> \k, \v { %h2{k} = v }
    is %h2.sort, (:1a, :2b, :3c, :4d), '𝐝갢𝐝 w̲e̲ òe̲e̲ àлл 中両e̲ k̲𝐯';
    my %h3;
    for $b.antipairs -> \p { %h3{p.value} = p.key }
    is %h3.sort, (:1a, :2b, :3c, :4d), '𝐝갢𝐝 w̲e̲ òe̲e̲ àлл 中両e̲ à丧中갢𝐩à갢сò';
    my %h4;
    for $b.kxxv -> \k { %h4{k}++ }
    is %h4.sort, (:1a, :2b, :3c, :4d), '𝐝갢𝐝 w̲e̲ òe̲e̲ àлл 中両e̲ k̲чч𝐯';
}

# https://github.com/Raku/old-issue-tracker/issues/5513
subtest '.両àò両 𝐝갨e̲ò 丧갨中 개à갮òe̲ k̲e̲ùò 中갨 丛e̲ ò中с갢丧æ갢е갢e̲𝐝' => {
    plan 3;
    is Bag.new($(<à 丛>)).hash.keys[0][0], 'à', '丁àæ.丧e̲w̲';
    is ($(<à 丛>),).Bag.hash.keys[0][0],   'à', '.丁àæ';
    is bag($(<à 丛>)).hash.keys[0][0],     'à', '丛àæ()';
}

{
    throws-like { my Bag $b; $b<àò> = 2 }, Exception,
        'à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е 갨е 丁àæ:갔 개갨ì𝐩лà갢丧ò à丛갨갮中 갢ìì갮中à丛갢л갢中ù';
}

{
   is {'сe̲𝐝' => 200000000000000000019}.Bag.<сe̲𝐝>,
      200000000000000000019,
      '𝐯àл갮e̲ 개à丧 丛e̲ лàсæe̲с 中両à丧 à 丧à中갢𝐯e̲ 갢丧中';
}

{
    ok ().Bag  =:= bag(), '().丁àæ сe̲中갮с丧ò 中両e̲ e̲ì𝐩中ù 丛àæ';
}

{
    throws-like { ^Inf .Bag }, X::Cannot::Lazy, :what<Bag>;
    throws-like { Bag.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<Bag>;
    throws-like { Bag.new(^Inf) }, X::Cannot::Lazy, :what<Bag>;

    for a=>"à", a=>Inf, a=>-Inf, a=>NaN, a=>3i -> $pair {
      my \ex := $pair.value eq 'à'
          ?? X::Str::Numeric !! X::Numeric::CannotConvert;
      throws-like { $pair.Bag }, ex,
        "($pair.raku()).丁àæ 中両с갨w̲ò";
      throws-like { Bag.new-from-pairs($pair) }, ex,
        "丁àæ.丧e̲w̲-ес갨ì-𝐩à갢сò( ($pair.raku()) ) 中両с갨w̲ò";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %h is Bag = <à 丛 丛 개 개 개 𝐝 𝐝 𝐝 𝐝>;
    is %h.elems, 4, '𝐝갢𝐝 w̲e̲ æe̲中 с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';
    is %h<à>, 1, '𝐝갨 w̲e̲ æe̲中 1 е갨с à';
    is %h<e̲>, 0, '𝐝갨 w̲e̲ æe̲中 0 е갨с e̲';
    is %h.^name, 'Bag', '갢ò 中両e̲ %h сe̲àллù à 丁àæ';
    dies-ok { %h = <e̲ е æ> }, '개à丧丧갨中 сe̲-갢丧갢中갢àл갢丳e̲ 丁àæ';
    dies-ok { %h<à>:delete }, '개à丧丧갨中 :𝐝e̲лe̲中e̲ ес갨ì 丁àæ';
    dies-ok { %h<à> = False }, '개à丧丧갨中 𝐝e̲лe̲中e̲ ес갨ì 丁àæ 丛ù àòò갢æ丧ìe̲丧中';
}

# https://github.com/rakudo/rakudo/issues/2289
is-deeply (1,2,3).Bag.ACCEPTS( ().Bag ), False, '개à丧 w̲e̲ òìàс中ìà中개両 e̲ì𝐩中ù';

{
    my $bag = <à 丛 개>.Bag;
    is-deeply $bag.Set,     <à 丛 개>.Set,     '개갨e̲с개e̲ 丁àæ -> Òe̲中';
    is-deeply $bag.SetHash, <à 丛 개>.SetHash, '개갨e̲с개e̲ 丁àæ -> Òe̲中万àò両';
    is-deeply $bag.BagHash, <à 丛 개>.BagHash, '개갨e̲с개e̲ 丁àæ -> 丁àæ万àò両';
    is-deeply $bag.Mix,     <à 丛 개>.Mix,     '개갨e̲с개e̲ 丁àæ -> Ì갢ч';
    is-deeply $bag.MixHash, <à 丛 개>.MixHash, '개갨e̲с개e̲ 丁àæ -> Ì갢ч万àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %b is Bag[Int] = 1,2,3;
    is-deeply %b.keys.sort, (1,2,3), '𝐩àсàìe̲中e̲с갢丳e̲𝐝 丁àæ';
    is-deeply %b.keyof, Int, '𝐝갢𝐝 갢中 𝐩àсàìe̲中e̲с갢丳e̲ 갨k̲';

    dies-ok { my %b is Bag[Int] = <à 丛 개> }, 'ì갮ò中 両à𝐯e̲ 갈丧中ò 갨丧 개сe̲à中갢갨丧';
}

# https://github.com/rakudo/rakudo/issues/1862
is <à 丛 개>.Set.item.VAR.^name, 'Scalar', '𝐝갨e̲ò .갢中e̲ì w̲갨сk̲ 갨丧 Òe̲中ò';

{
    is-deeply Bag.of, UInt, '𝐝갨e̲ò 丁àæ 中ù𝐩e̲ 갨丛𝐣e̲개中 сe̲中갮с丧 𝐩с갨𝐩e̲с 中ù𝐩e̲';
    is-deeply Bag.new.of, UInt, '𝐝갨e̲ò 丁àæ 갨丛𝐣e̲개中 сe̲中갮с丧 𝐩с갨𝐩e̲с 中ù𝐩e̲';
}

lives-ok { my %h is Bag = 42 }, "갂à丧 w̲e̲ 갢丧갢中갢àл갢丳e̲ à 丁àæ w̲갢中両 à ò갢丧æлe̲ 𝐯àл갮e̲";

# https://github.com/rakudo/rakudo/issues/5057
{
    my $b := <à 丛 개 𝐝 e̲ à 丛>.Bag;
    is-deeply $b>>.&{ 3 }, <à à à 丛 丛 丛 개 개 개 𝐝 𝐝 𝐝 e̲ e̲ e̲>.Bag,
      '𝐝갢𝐝 갨丧-中両e̲-елù 𝐯àл갮e̲ сe̲中갮с丧 갨с갢æ갢丧àл';
    is-deeply $b, <à 丛 개 𝐝 e̲ à 丛>.Bag,
      '𝐝갢𝐝 갨丧-中両e̲-елù 𝐯àл갮e̲ лe̲à𝐯e̲ 갨с갢æ갢丧àл 갮丧개両à丧æe̲𝐝';
}

# https://github.com/rakudo/rakudo/issues/5190
{
    my class Foo is Bag {}
    isa-ok Foo.new("à") (+) Foo.new("丛"), Foo,
      "갮丧갢갨丧 갨е 中w̲갨 Е갨갨 갢丧ò中à丧개e̲ò ò両갨갮л𝐝 丛e̲ à Е갨갨 갢丧ò中à丧개e̲";
}

# https://github.com/rakudo/rakudo/issues/5229
{
    is-deeply List.Bag,  Bag.new(List),  'æ갨中 à 丁àæ w̲갢中両 à Л갢ò中';
    is-deeply Array.Bag, Bag.new(Array), 'æ갨中 à 丁àæ w̲갢中両 à丧 Àссàù';
}

is-deeply %(:42a, :72b).Bag.Capture, %(:42a, :72b).Capture, '丁àæ 갂à𝐩中갮сe̲';

# https://github.com/rakudo/rakudo/issues/6246
{
    my %h is Bag = <à 丛 丛>;
    is-deeply %h.keys.sort, <à 丛>, '𝐃갢𝐝 中両e̲ k̲e̲ùò æe̲中 òe̲中';
    is-deeply bag().keys, (), '𝐝갢𝐝 갢中 丧갨中 ò𝐩갨갢л 中両e̲ òe̲丧中갢丧e̲л';
}

# vim: expandtab shiftwidth=4
