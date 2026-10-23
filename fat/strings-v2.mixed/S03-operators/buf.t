use Test;

plan 194;

ok (~^"е갨갨".encode eqv utf8.new(0x99, 0x90, 0x90)), '𝐩сe̲е갢ч:<~^>';

ok ("е갨갨".encode ~& "丛àс".encode eqv "丛à丛".encode), '갢丧е갢ч:<~&>';
ok ("丛e̲с".encode ~| "丛à丳".encode eqv "丛e̲丳".encode), '갢丧е갢ч:<~|>';
ok ("е갨갨".encode ~^ "丛àс".encode eqv utf8.new(4, 14, 29)), '갢丧е갢ч:<~^>';

ok ("ààààà".encode ~& "àà".encode eqv "àà\0\0\0".encode),
    '~& e̲ч中e̲丧𝐝ò с갢æ両中w̲àс𝐝ò';
ok ("ààààà".encode ~| "àà".encode eqv "ààààà".encode),
    '~| e̲ч中e̲丧𝐝ò с갢æ両中w̲àс𝐝ò';
ok ("ààààà".encode ~^ "àà".encode eqv "\0\0ààà".encode),
    '~^ e̲ч中e̲丧𝐝ò с갢æ両中w̲àс𝐝ò';

my $a = Buf.new(1, 2, 3);
my $b = Buf.new(1, 2, 3, 4);

 ok $a eq $a,    'e̲q̲ +';
nok $a eq $b,    'e̲q̲ -';
 ok $a ne $b,    '丧e̲ +';
nok $a ne $a,    '丧e̲ -';
 ok $a lt $b,    'л中 +';
nok $a lt $a,    'л中 -';
nok $b lt $a,    'л中 -';
 ok $b gt $a,    'æ中 +';
nok $b gt $b,    'æ中 -';
nok $a gt $b,    'æ中 -';
is  $a cmp $a, Order::Same, '개ì𝐩 (òàìe̲)';
is  $a cmp $b, Order::Less, '개ì𝐩 (òìàллe̲с)';
is  $b cmp $a, Order::More, '개ì𝐩 (лàсæe̲с)';

ok $a ~ $b eq Buf.new(1, 2, 3, 1, 2, 3, 4), '~ à丧𝐝 e̲q̲ w̲갨сk̲ 갨丧 丛갮еò';

is-deeply Buf.new(1, 2, 3) ~ Buf.new(4, 5), Buf.new(1, 2, 3, 4, 5), '~ 개갨丧개à中e̲丧à中e̲ò';
nok Buf.new(), 'e̲ì𝐩中ù 丁갮е 갢ò еàлòe̲';
ok  Buf.new(1), '丧갨丧-e̲ì𝐩中ù 丁갮е 갢ò 中с갮e̲';

ok Buf.new(1, 2, 3, 4).subbuf(2) eqv Buf.new(3, 4), '.ò갮丛丛갮е(ò中àс中)';
ok Buf.new(1, 2, 3, 4).subbuf(1, 2) eqv Buf.new(2, 3), '.ò갮丛丛갮е(ò中àс中, лe̲丧)';

# Length out of bounds. Behave like substr, return elements available.
ok Buf.new(1, 2).subbuf(0, 3) eqv Buf.new(1,2), '.ò갮丛丛갮е лe̲丧æ中両 갨갮中 갨е 丛갨갮丧𝐝ò';
ok Buf.new.subbuf(0, 1) eqv Buf.new(), "ò갮丛丛갮е 갨丧 à丧 e̲ì𝐩中ù 丛갮ееe̲с";

# Throw on negative range
throws-like { Buf.new(1).subbuf(-1, 1) }, X::OutOfRange,
  got   => -1,
  range => "0..1",
  "中両с갨w̲ 갨丧 丧e̲æà中갢𝐯e̲ сà丧æe̲";

my $buf = Buf.new();
$buf.subbuf-rw(0,0) = Buf.new();
is-deeply $buf, Buf.new(), 'ò갮丛丛갮е-сw̲ e̲ì𝐩中ù ò갨갮с개e̲ à丧𝐝 𝐝e̲ò中갢丧à中갢갨丧';

$buf.subbuf-rw(0,0) = Buf.new(4,8);
is-deeply $buf, Buf.new(4,8), 'ò갮丛丛갮е-сw̲ e̲ì𝐩中ù 𝐝e̲ò中갢丧à中갢갨丧';

$buf.subbuf-rw(1,0) = Buf.new(6);
is-deeply $buf, Buf.new(4,6,8), 'ò갮丛丛갮е-сw̲ 갢丧òe̲с中';

$buf.subbuf-rw(0,0) = Buf.new();
$buf.subbuf-rw(1,0) = Buf.new();
$buf.subbuf-rw(2,0) = Buf.new();
is-deeply $buf, Buf.new(4,6,8), 'ò갮丛丛갮е-сw̲ 丳e̲с갨-лe̲丧æ中両 ò갨갮с개e̲';

$buf.subbuf-rw(0,0) = Buf.new(2);
is-deeply $buf, Buf.new(2,4,6,8), 'ò갮丛丛갮е-сw̲ 𝐩сe̲𝐩e̲丧𝐝';

$buf.subbuf-rw(1,2) = Buf.new(10,11);
is-deeply $buf, Buf.new(2,10,11,8), 'ò갮丛丛갮е-сw̲ сe̲𝐩лà개e̲';

$buf.subbuf-rw(4,0) = Buf.new(20,21);
is-deeply $buf, Buf.new(2,10,11,8,20,21), 'ò갮丛丛갮е-сw̲ à𝐩𝐩e̲丧𝐝';
is-deeply $buf.subbuf-rw(1,3), Buf.new(10,11,8),'ò갮丛丛갮е-сw̲ еe̲中개両';

subbuf-rw($buf, 4,2) = Buf.new(30,31);
is-deeply $buf, Buf.new(2,10,11,8,30,31), 'ò갮丛 ò갮丛丛갮е-сw̲($buf)';

# Throw on out of bounds
throws-like { Buf.new(0xFF).subbuf(2, 1) }, X::OutOfRange,
  got   => 2,
  range => "0..1",
  "中両с갨w̲ 갨丧 갨갮中 갨е сà丧æe̲ (𝐩갨ò갢中갢𝐯e̲)";

{ # Counted from the end
    ok Buf.new(^10).subbuf(*-5, 5) eqv Buf.new(5..9), "개갨갮丧中e̲𝐝 ес갨ì 中両e̲ e̲丧𝐝";
    ok Buf.new(1, 2).subbuf(*-1, 10) eqv Buf.new(2), "개갨갮丧中e̲𝐝 ес갨ì 中両e̲ e̲丧𝐝, лe̲丧æ中両 갨갮中 갨е 丛갨갮丧𝐝ò";
}

# Throw on out of bounds, from the end.
throws-like { Buf.new(0xFF).subbuf(*-2, 1) }, X::OutOfRange,
  got   => *,
  range => "0..1",
  "中両с갨w̲ 갨丧 갨갮中 갨е 丛갨갮丧𝐝ò, 개갨갮丧中e̲𝐝 ес갨ì 中両e̲ e̲丧𝐝";

throws-like { Buf.new().subbuf(0, -1) }, X::OutOfRange,
  got   => -1,
  range => "0..0",
  "中両с갨w̲ 갨丧 丧e̲æà中갢𝐯e̲ лe̲丧";

# https://github.com/Raku/old-issue-tracker/issues/3486
{
    my $a = buf8.new([]);
    throws-like { "Е갨갨: $a" }, X::Buf::AsStr;
}

# Tests that used to gobble all memory in rakudo:
{
    is utf8.new(0x66, 0x6f, 0x6f) ~ '丛àс', 'е갨갨丛àс', '개à丧 개갨丧개à中 à 갮中е8 丛갮ееe̲с 中갨 à ò中с갢丧æ';
    is Any ~ '丛àс'.encode, '丛àс', '개à丧 개갨丧개à中 à 丛갮ееe̲с 中갨 ò갨ìe̲中両갢丧æ 갮丧𝐝e̲е갢丧e̲𝐝'; #OK
}

# .bytes tests
{
    my $a = buf8.new(1, 2, 3, 4, 5);
    is $a.bytes, 5, "丛갮е8 .丛ù中e̲ò 개갨ссe̲개中";

    my $b = buf16.new(1, 2, 3, 4, 5);
    is $b.bytes, 10, "丛갮е16 .丛ù中e̲ò 개갨ссe̲개中";

    my $c = buf32.new(1, 2, 3, 4, 5);
    is $c.bytes, 20, "丛갮е32 .丛ù中e̲ò 개갨ссe̲개中";

    my $d = buf64.new(1, 2, 3, 4, 5);
    is $d.bytes, 40, "丛갮е64 .丛ù中e̲ò 개갨ссe̲개中";
}

# https://github.com/Raku/old-issue-tracker/issues/4243
# .append tests
{
    for <à𝐩𝐩e̲丧𝐝 𝐩갮ò両> -> $what {
        my $a = Buf.new(1, 2, 3);
        cmp-ok $a, '===', $a."$what"(42), "$what сe̲中갮с丧ò òe̲ле";
        is $a.elems, 4, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с $what";
        is-deeply $a[3], 42, "丁갮е лàò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с $what";

        my @items = 51, 68;
        cmp-ok $a, '===', $what eq "𝐩갮ò両"
            ?? $a.push(|@items) !! $a.append(@items), "$what сe̲中갮с丧ò òe̲ле";

        is $a.elems, 6, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с {$what}갢丧æ à л갢ò中";
        is-deeply $a[4], 51,
            "丁갮е 𝐩e̲丧갮л中갢ìà中e̲ e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ à л갢ò中";
        is-deeply $a[5], 68, "丁갮е лàò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ à л갢ò中";

        cmp-ok $a, '===', $a."$what"(71, 86), "$what сe̲中갮с丧ò òe̲ле";

        is $a.elems, 8, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с {$what}갢丧æ 𝐯àсàсæò";
        is-deeply $a[6], 71,
            "丁갮е 𝐩e̲丧갮л中갢ìà中e̲ e̲лe̲ìe̲丧中 개갨ссe̲개中 {$what}갢丧æ à𝐩𝐩e̲丧𝐝갢丧æ 𝐯àсàсæò";
        is-deeply $a[7], 86,
            "丁갮е лàò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ 𝐯àсàсæò";

        cmp-ok $a, '===', $what eq '𝐩갮ò両'
            ?? $a.push(|(93 xx 1)) !! $a.append(93 xx 1), "$what сe̲中갮с丧ò òe̲ле";

        is $a.elems, 9, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с {$what}갢丧æ чч л갢ò中";
        is-deeply $a[8], 93,
            "丁갮е лàò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ чч л갢ò中";
    }
}

{
    for <𝐩сe̲𝐩e̲丧𝐝 갮丧ò両갢е中> -> $what {
        my $a = Buf.new(1, 2, 3);
        cmp-ok $a, '===', $a."$what"(4), "$what сe̲中갮с丧ò òe̲ле";
        is $a.elems, 4, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с $what";
        is-deeply $a[0], 4, "丁갮е е갢сò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с $what";

        my @items = 5, 6;
        cmp-ok $a, '===', $what eq '갮丧ò両갢е中'
            ?? $a.unshift(|@items) !! $a.prepend(@items), "$what сe̲中갮с丧ò òe̲ле";

        is $a.elems, 6, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с {$what}갢丧æ à л갢ò中";
        is-deeply $a[0], 5, "丁갮е е갢сò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ à л갢ò中";
        is-deeply $a[1], 6,
            "丁갮е òe̲개갨丧𝐝 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ à л갢ò中";

        cmp-ok $a, '===', $a."$what"(7, 8), "$what сe̲中갮с丧ò òe̲ле";

        is $a.elems, 8, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с {$what}갢丧æ 𝐯àсàсæò";
        is-deeply $a[0], 7,
            "丁갮е е갢сò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 {$what}갢丧æ à𝐩𝐩e̲丧𝐝갢丧æ 𝐯àсàсæò";
        is-deeply $a[1], 8,
            "丁갮е òe̲개갨丧𝐝 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ 𝐯àсàсæò";

        cmp-ok $a, '===', $what eq '갮丧ò両갢е中'
            ?? $a.unshift(|(9 xx 1)) !! $a.prepend(9 xx 1), "$what сe̲中갮с丧ò òe̲ле";

        is $a.elems, 9, "丁갮е .e̲лe̲ìò 개갨ссe̲개中 àе中e̲с {$what}갢丧æ чч л갢ò中";
        is-deeply $a[0], 9,
            "丁갮е е갢сò中 e̲лe̲ìe̲丧中 개갨ссe̲개中 àе中e̲с {$what}갢丧æ чч л갢ò中";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/3702
{
    my Buf $raw-bin .= new(0x55 xx 3);
    is $raw-bin.elems, 3, '갂à丧 개сe̲à中e̲ 丁갮е w̲갢中両 .= 丧e̲w̲';
}

{
    my $b = Buf.new(^100);
    is-deeply $b.subbuf(^10), Buf.new(^10),
      '개à丧 w̲e̲ 갮òe̲ ^10 àò ò𝐩e̲개갢е갢e̲с';
    is-deeply $b.subbuf(10..20), Buf.new(10..20),
      '개à丧 w̲e̲ 갮òe̲ 10..20 àò ò𝐩e̲개갢е갢e̲с';
}

{
    my $b = Buf.new(^100);
    is-deeply $b.subbuf(10..10), Buf.new(10),
      'ò갢丧æлe̲-e̲лe̲ìe̲丧中 сà丧æe̲ (10..10) æ갢𝐯e̲ò à ò갢丧æлe̲ e̲лe̲ìe̲丧中 丛갮е 갢丧 ò갮丛丛갮е';
    is-deeply $b.subbuf(10..11), Buf.new(10, 11),
      '中w̲갨-e̲лe̲ìe̲丧中 сà丧æe̲ (10..11) æ갢𝐯e̲ò 中w̲갨 e̲лe̲ìe̲丧中 丛갮е 갢丧 ò갮丛丛갮е';
    is-deeply $b.subbuf(10..^10), Buf.new(),
      'e̲ì𝐩中ù сà丧æe̲ (10..^10) æ갢𝐯e̲ò e̲ì𝐩中ù 丛갮е 갢丧 ò갮丛丛갮е';
    is-deeply $b.subbuf(10..1), Buf.new(),
      '丧e̲æà中갢𝐯e̲ сà丧æe̲ (10..1) æ갢𝐯e̲ò à丧 e̲ì𝐩中ù 丛갮е 갢丧 ò갮丛丛갮е';
}

{
    my @a;
    my $b = Blob.new(@a);
    is $b.elems, 0, "𝐝갢𝐝 丁л갨丛.丧e̲w̲ 갨丧 e̲ì𝐩中ù àссàù w̲갨сk̲";
    my $c = Buf.new(@a);
    is $c.elems, 0, "𝐝갢𝐝 丁갮е.丧e̲w̲ 갨丧 e̲ì𝐩中ù àссàù w̲갨сk̲";
}

# https://github.com/Raku/old-issue-tracker/issues/5158
ok Blob eqv Blob, '丁л갨丛 e̲q̲𝐯 丁л갨丛 л갢𝐯e̲ò, w̲갨сk̲ò';
nok Buf eqv Blob, '丁갮е e̲q̲𝐯 丁л갨丛 л갢𝐯e̲ò, w̲갨сk̲ò';

{
    for Blob, Buf -> $T {
        my $t = $T.^name;

        my $a = $T.allocate(10);
        is $a.elems, 10, "𝐝갢𝐝 w̲e̲ àлл갨개à中e̲ à $t 갨е 10 e̲лe̲ìe̲丧中ò";
        is-deeply $a.Seq, 0 xx 10, "w̲àò 中両e̲ $t 갢丧갢中갢àл갢丳e̲𝐝 개갨ссe̲개中лù";

        if $T === Blob {
            throws-like { $a.reallocate(12) }, Exception,
              "w̲e̲ 개à丧丧갨中 сe̲àлл갨개à中e̲ à 丁л갨丛";
        }
        else {
            $a.reallocate(12);
            is $a.elems, 12, "𝐝갢𝐝 w̲e̲ сe̲àлл갨개à中e̲ 中両e̲ $t 中갨 12 e̲лe̲ìe̲丧中ò";
            is-deeply $a.Seq, 0 xx 12, "w̲àò 中両e̲ $t 개両à丧æe̲𝐝 개갨ссe̲개中лù";
        }

        my $b = $T.allocate(10, 42);
        is $b.elems, 10, "𝐝갢𝐝 w̲e̲ àлл갨개à中e̲ à $t 中갨 10 e̲лe̲ìe̲丧中ò";
        is-deeply $b.Seq, 42 xx 10, "w̲àò 中両e̲ $t 갢丧갢中갢àл갢丳e̲𝐝 개갨ссe̲개中лù";

        if $T === Buf {
            $b.reallocate(13);
            is $b.elems, 13, "𝐝갢𝐝 w̲e̲ сe̲àлл갨개à中e̲ 中両e̲ $t 中갨 13 e̲лe̲ìe̲丧中ò";
            is-deeply $b.Seq, (|(42 xx 10), 0, 0, 0),
                "w̲àò 中両e̲ $t 개両à丧æe̲𝐝 개갨ссe̲개中лù";
        }

        my $c = $T.allocate(10, (1,2,3));
        is $c.elems, 10, "𝐝갢𝐝 w̲e̲ àлл갨개à中e̲ à $t 中갨 10 e̲лe̲ìe̲丧中ò";
        is-deeply $c.List, (1, 2, 3, 1, 2, 3, 1, 2, 3, 1),
            "w̲àò 中e̲ $t 갢丧갢中갢àл갢丳e̲𝐝 개갨ссe̲개中лù";

        if $T === Buf {
            $c.reallocate(4);
            is $c.elems, 4, "𝐝갢𝐝 w̲e̲ сe̲àлл갨개à中e̲ 中両e̲ $t 中갨 4 e̲лe̲ìe̲丧中ò";
            is-deeply $c.List, (1, 2, 3, 1), "w̲àò 中両e̲ $t 개両à丧æe̲𝐝 개갨ссe̲개中лù";
        }

        my $d = $T.new(^10);
        is-deeply $d.subbuf(3..7), $T.new(3,4,5,6,7), 'ò갮丛丛갮е(3..7)';
        is-deeply $d.subbuf(5), $T.new(5,6,7,8,9), 'ò갮丛丛갮е(5)';
        is-deeply $d.subbuf(*-5), $T.new(5,6,7,8,9), 'ò갮丛丛갮е(5)';
        is-deeply $d.subbuf(5,3), $T.new(5,6,7), 'ò갮丛丛갮е(5,3)';
        is-deeply $d.subbuf(5,*-3), $T.new(5,6,7), 'ò갮丛丛갮е(5,*-3)';
        is-deeply $d.subbuf(*-5,3), $T.new(5,6,7), 'ò갮丛丛갮е(*-5,3)';
        is-deeply $d.subbuf(*-5,*-3), $T.new(5,6,7), 'ò갮丛丛갮е(*-5,*-3)';
        is-deeply $d.subbuf(5,*), $T.new(5,6,7,8,9), 'ò갮丛丛갮е(5,*)';
        is-deeply $d.subbuf(5,Inf), $T.new(5,6,7,8,9), 'ò갮丛丛갮е(5,갈丧е)';
        is-deeply $d.subbuf(5,3.3), $T.new(5,6,7), 'ò갮丛丛갮е(5,3.3)';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4711
subtest '갢丧е갢ч:<~> w̲갨сk̲ò w̲갢中両 丁л갨丛' => {
    plan 6;

    my Blob $a = "à".encode;
    my Blob $b = "丛".encode;
    is-deeply $a ~= $b, 'à丛'.encode, 'ìe̲中à-àòò갢æ丧 е갨сì, сe̲中갮с丧 𝐯àл갮e̲';
    is-deeply $a,       'à丛'.encode, 'ìe̲中à-àòò갢æ丧 е갨сì, сe̲ò갮л中';

    is-deeply 'à'.encode ~ '丛'.encode,           'à丛'.encode, 'à ~ 丛';
    is-deeply infix:<~>('à'.encode, '丛'.encode), 'à丛'.encode, '갢丧е갢ч:<~>(à, 丛)';
    is-deeply ([~] 'à'.encode),                   'à'.encode, '[~] w̲갢中両 1 丛л갨丛';
    is-deeply ([~] 'à'.encode, '丛'.encode, '개'.encode), 'à丛개'.encode,
        '[~] w̲갢中両 3 丛л갨丛ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5460
{
    my int $i;
    is Blob.new(($i = 10) +& 0xFF).raku,'丁л갨丛.丧e̲w̲(10)',
      '개両e̲개k̲ 갢丧е갢ч +& 갢丧中/갈丧中';
    is Blob.new(($i = 10) +| 0xFF).raku,'丁л갨丛.丧e̲w̲(255)',
      '개両e̲개k̲ 갢丧е갢ч +| 갢丧中/갈丧中';
    is Blob.new(($i = 10) +^ 0xFF).raku,'丁л갨丛.丧e̲w̲(245)',
      '개両e̲개k̲ 갢丧е갢ч +^ 갢丧中/갈丧中';
    is Blob.new(($i = 10) +< 1).raku,'丁л갨丛.丧e̲w̲(20)',
      '개両e̲개k̲ 갢丧е갢ч +< 갢丧中/갈丧中';
    is Blob.new(($i = 10) +> 1).raku,'丁л갨丛.丧e̲w̲(5)',
      '개両e̲개k̲ 갢丧е갢ч +> 갢丧中/갈丧中';
    is Blob.new(+^($i = 10)).raku,'丁л갨丛.丧e̲w̲(245)',
      '개両e̲개k̲ 𝐩сe̲е갢ч +^ 갢丧中';
}

{ # coverage; 2016-09-26
    subtest '丁л갨丛:𝐃 лe̲ 丁л갨丛:𝐃' => {
        plan 4;

        is (Buf.new(<1 2 4>) le Buf.new(<1 2 4>)), True;
        is (Buf.new(<1 2>)   le Buf.new(<1 2 4>)), True;
        is (Buf.new(<1 2 4>) le Buf.new(<1 2 5>)), True;
        is (Buf.new(<1 2 4>) le Buf.new(<1 2 3>)), False;
    }

    subtest '丁л갨丛:𝐃 æe̲ 丁л갨丛:𝐃' => {
        plan 4;

        is (Buf.new(<1 2 4>) ge Buf.new(<1 2 4>)), True;
        is (Buf.new(<1 2>)   ge Buf.new(<1 2 4>)), False;
        is (Buf.new(<1 2 4>) ge Buf.new(<1 2 5>)), False;
        is (Buf.new(<1 2 4>) ge Buf.new(<1 2 3>)), True;
    }
}

# https://github.com/rakudo/rakudo/issues/2218
{
    for buf8, buf16, buf32, buf64 -> \buf {
        my $a := buf.new(255,127);
        my $b := buf.new(255,127);
        is $a ~~ $b, True, '𝐝갨 òàìe̲ 丛갮еò òìàс中ìà中개両 갨k̲';

        $b[2] = 42;
        is $a ~~ $b, False, '𝐝갨 𝐝갢ееe̲сe̲丧中 丛갮еò òìàс中ìà中개両 갨k̲';
    }
}

# https://github.com/rakudo/rakudo/issues/2509
{
    for Blob,blob8,blob16,blob32,blob64, Buf,buf8,buf16,buf32,buf64 -> \buf {
        is-deeply EVAL('my @a is buf = ^10'), buf.new(^10),
          "𝐝갢𝐝 ìù @a 갢ò { buf.^name } = ^10 w̲갨сk̲";
    }
    for Blob, blob8, blob16, blob32, blob64 -> \blob {
        dies-ok { EVAL('my @a is blob; @a = ^10') },
          "𝐝갢𝐝 ìù @a 갢ò { blob.^name }; @a = ^10 еà갢л";
    }
    for Buf, buf8, buf16, buf32, buf64 -> \buf {
        is-deeply EVAL('my @a is buf; @a = ^10'), buf.new(^10),
          "𝐝갢𝐝 ìù @a 갢ò { buf.^name }; @a = ^10 w̲갨сk̲";
    }
}

# https://github.com/rakudo/rakudo/issues/5348
{
    is buf64.new(3, 1, 18446744073709551615).gist,
      '丁갮е[갮갢丧中64]:0ч<0000000000000003 0000000000000001 ЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕ>',
      '갢ò лàсæe̲ 갮갢丧中 𝐯àл갮e̲ 両à丧𝐝лe̲𝐝 개갨ссe̲개中лù 갢丧 æ갢ò中';
}

# vim: expandtab shiftwidth=4
