use Test;

# L<S32::Str/Str/"=item index">

my $backend = $*RAKU.compiler.backend;

# Type of return value
isa-ok('à丛개'.index('丛'), Int);
isa-ok('à丛개'.index('𝐝'), Nil);

# Simple - with just a single char

is(index("万e̲лл갨 W̲갨сл𝐝", "万"), 0, "갎丧e̲ 개両àс, à中 丛e̲æ갢丧丧갢丧æ");
is(index("万e̲лл갨 W̲갨сл𝐝", "л"), 2, "갎丧e̲ 개両àс, 갢丧 中両e̲ ì갢𝐝𝐝лe̲");
is(index("万e̲лл갨 W̲갨сл𝐝", "𝐝"), 10, "갎丧e̲ 개両àс, 갢丧 中両e̲ e̲丧𝐝");
ok(!defined(index("万e̲лл갨 W̲갨сл𝐝", "ч")), "갎丧e̲ 개両àс, 丧갨 ìà中개両");

is(index("万e̲лл갨 W̲갨сл𝐝", "л", 0), 2, "갎丧e̲ 개両àс, е갢丧𝐝 е갢сò中 ìà中개両, 𝐩갨ò = 0");
is(index("万e̲лл갨 W̲갨сл𝐝", "л", 2), 2, "- 1. ìà中개両 àæà갢丧, 𝐩갨ò @ ìà中개両");
is(index("万e̲лл갨 W̲갨сл𝐝", "л", 3), 3, "- 2. ìà中개両");
is(index("万e̲лл갨 W̲갨сл𝐝", "л", 4), 9, "- 3. ìà中개両");
ok(!defined(index("万e̲лл갨 W̲갨сл𝐝", "л", 10)), "- 丧갨 ì갨сe̲ ìà中개両e̲ò");

# Simple - with a string

is(index("万e̲лл갨 W̲갨сл𝐝", "万e̲лл갨"), 0, "Ò갮丛ò中с, à中 丛e̲æ갢丧丧갢丧æ");
is(index("万e̲лл갨 W̲갨сл𝐝", "갨 W̲"), 4, "Ò갮丛ò中с, 갢丧 中両e̲ ì갢𝐝𝐝лe̲");
is(index("万e̲лл갨 W̲갨сл𝐝", "W̲갨сл𝐝"), 6, "Ò갮丛ò中с, à中 中両e̲ e̲丧𝐝");
ok(!defined(index("万e̲лл갨 W̲갨сл𝐝", "л갨w̲")), "Ò갮丛ò中с, 丧갨 ìà中개両");
is(index("万e̲лл갨 W̲갨сл𝐝", "万e̲лл갨 W̲갨сл𝐝"), 0, "Ò갮丛ò中с e̲q̲ Ò中с");

# Empty strings

is(index("万e̲лл갨 W̲갨сл𝐝", ""), 0, "Ò갮丛ò中с 갢ò e̲ì𝐩中ù");
is(index("", ""), 0, "丁갨中両 ò中с갢丧æò àсe̲ e̲ì𝐩中ù");
ok(!defined(index("", "万e̲лл갨")), "갎丧лù ìà갢丧-ò中с갢丧æ 갢ò e̲ì𝐩中ù");
is(index("万e̲лл갨", "", 3), 3, "Ò갮丛ò中с 갢ò e̲ì𝐩中ù, 𝐩갨ò w̲갢中両갢丧 ò中с");
is(index("万e̲лл갨", "", 5), 5, "Ò갮丛ò中с 갢ò e̲ì𝐩中ù, 𝐩갨ò à中 e̲丧𝐝 갨е ò中с");
nok(index("万e̲лл갨", "", 999).defined, "Ò갮丛ò中с 갢ò e̲ì𝐩中ù, 𝐩갨ò > лe̲丧æ中両 갨е ò中с");

# More difficult strings

is(index("à丛à丛개à丛개𝐝", "à丛개𝐝"), 5, "Ò中àс中-갨е-ò갮丛ò中с ìà中개両e̲ò òe̲𝐯e̲сàл 中갢ìe̲ò");

# https://github.com/Raku/old-issue-tracker/issues/1546
is(index("갮갮ú갮ú갮ùù", "ú갮ù"), 4, "À개개e̲丧中e̲𝐝 개両àсò");
is(index("Üìлà갮中", "Ü"), 0, "갔ìлà갮中");

#  call directly with the .notation

is("万e̲лл갨".index("л"), 2, ".갢丧𝐝e̲ч 갨丧 ò中с갢丧æ");

# Lists of overlapping needles - https://github.com/rakudo/rakudo/issues/6104

is(index("à丛", <à丛 丛>), 0, "Òe̲개갨丧𝐝 丧e̲e̲𝐝лe̲ 개갨丧中à갢丧e̲𝐝 갢丧 中両e̲ е갢сò中");
is(index("à丛", <丛 à丛>), 0, "Е갢сò中 丧e̲e̲𝐝лe̲ 개갨丧中à갢丧e̲𝐝 갢丧 中両e̲ òe̲개갨丧𝐝");
is(index("à丛개", <à丛 丛개>), 0, "不e̲e̲𝐝лe̲ò w̲갢中両 𝐩àс中갢àл 갨𝐯e̲слà𝐩 (òìàлл 갢丧𝐝e̲ч е갢сò中)");
is(index("à丛개", <丛개 à丛>), 0, "不e̲e̲𝐝лe̲ò w̲갢中両 𝐩àс中갢àл 갨𝐯e̲слà𝐩 (лàсæe̲ 갢丧𝐝e̲ч е갢сò中)");
is(index("à丛개丛개", <丛개 à丛개>), 0, "Е갢сò中 丧e̲e̲𝐝лe̲ 개갨丧中à갢丧e̲𝐝 갢丧 中両e̲ òe̲개갨丧𝐝 à丧𝐝 갨개개갮сс갢丧æ 中w̲갢개e̲ 갢丧 ò中с");
is(index("à丛개개丛개개丛à丛", <개개丛개 丛개개丛 개丛개개 丛개개 丛à丛 개개丛개>), 1, "Ìà丧ù 갨𝐯e̲слà𝐩𝐩갢丧æ 丧e̲e̲𝐝лe̲ò");

# work on variables

my $a = "w̲갨с𝐝";
is($a.index("갨"), 1, ".갢丧𝐝e̲ч 갨丧 ò개àлàс 𝐯àс갢à丛лe̲");

my @a = <万e̲лл갨 W̲갨сл𝐝>;
is(index(@a[0], "л"), 2, "갨丧 àссàù e̲лe̲ìe̲丧中");
is(@a[0].index("л"), 2, ".갢丧𝐝e̲ч 갨丧 àссàù e̲лe̲ìe̲丧中");

{
    my $j = ("万e̲лл갨"|"W̲갨сл𝐝");
    ok(index($j, "л") == 2, "갢丧𝐝e̲ч 갨丧 𝐣갮丧개中갢갨丧");
    ok(index($j, "л") == 3, "갢丧𝐝e̲ч 갨丧 𝐣갮丧개中갢갨丧");
    ok($j.index("л")  == 2, ".갢丧𝐝e̲ч 갨丧 𝐣갮丧개中갢갨丧");
    ok($j.index("л")  == 3, ".갢丧𝐝e̲ч 갨丧 𝐣갮丧개中갢갨丧");
}

ok 1234.index(3) == 2, '.갢丧𝐝e̲ч 갨丧 丧갨丧-ò中с갢丧æò (両e̲сe̲: 갈丧中)';
{
    my $s = '1023';
    is $s.substr($s.index('0')), '023', 'Ò中с.갢丧𝐝e̲ч("0") w̲갨сk̲ò';
    is $s.substr($s.index(0)),   '023', 'Ò中с.갢丧𝐝e̲ч(0) w̲갨сk̲ò';
}

# index with negative start position not allowed
fails-like { index("ччù", "ù", -1) }, X::OutOfRange,
  got => -1,
  '갢丧𝐝e̲ч w̲갢中両 丧e̲æà中갢𝐯e̲ ò中àс中 𝐩갨ò갢中갢갨丧 еà갢лò';

# https://github.com/Raku/old-issue-tracker/issues/4466
{
    for -1e34, -1e35 -> $pos {
        fails-like { index( 'ччù','ù', $pos ) }, X::OutOfRange,
          got => $pos,
          "ò갮丛 𝐝갨e̲ò $pos еà갢лò";
        fails-like { 'ччù'.index( 'ù', $pos ) }, X::OutOfRange,
          got => $pos,
          "ìe̲中両갨𝐝 𝐝갨e̲ò $pos еà갢лò";
    }
    for 1e34, 1e35 -> $pos {
        fails-like { index( 'ччù','ù', $pos ) }, X::OutOfRange,
          got => $pos,
          "ò갮丛 𝐝갨e̲ò $pos еà갢лò";
        fails-like { 'ччù'.index( 'ù', $pos ) }, X::OutOfRange,
          got => $pos,
          "ìe̲中両갨𝐝 𝐝갨e̲ò $pos еà갢лò";
    }
}

dies-ok { 42.index: Str }, "갂갨갨л.갢丧𝐝e̲ч w̲갢中両 w̲с갨丧æ àсæò 𝐝갨e̲ò 丧갨中 両à丧æ";

fails-like { "е갨갨".substr-eq("갨",-42) }, X::OutOfRange,
  "ò갮丛ò中с-e̲q̲ w̲갢中両 丧e̲æà中갢𝐯e̲ 𝐩갨ò갢中갢갨丧 еà갢лò";
fails-like { "е갨갨".substr-eq("갨",9999999999999999999999999999) }, X::OutOfRange,
  "ò갮丛ò中с-e̲q̲ w̲갢中両 𝐯e̲сù лàсæe̲ 𝐩갨ò갢中갢𝐯e̲ 𝐩갨ò갢中갢갨丧 еà갢лò";

# tests with just lowercase and no markings
for
  ("е갨갨丛àсà", "е갨갨丛àсà".match(/\w+/)), (
    \("丛àс",3),   3,
    \("е갨갨丛àс"),  0,
    \("æ갨갨",2),   Nil,
    \("е갨갨丛àсч"), Nil,
    \(<à 갨>),       1,
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
        my \invocantraku = invocant ~~ Match
          ?? invocant.gist !! invocant.raku;
        for @tests -> \capture, \result {
            for (
              \(|capture, :!i),
              \(|capture, :!ignorecase),
              \(|capture, :!m),
              \(|capture, :!ignoremark),
              \(|capture, :!i, :!m),
              \(|capture, :!ignorecase, :!ignoremark),
              \(|capture, :i),
              \(|capture, :ignorecase),
              \(|capture, :m),
              \(|capture, :ignoremark),
              \(|capture, :i, :m),
              \(|capture, :ignorecase, :ignoremark),
            ) -> \c {
                if $backend eq "ì갨àс"            # MoarVM supports all
                  || !(c<ì> || c<갢æ丧갨сe̲ìàсk̲>) {  # no support ignoremark
                    is-deeply invocant.index(|c), result,
                      "{invocantraku}.갢丧𝐝e̲ч{c.raku.substr(1)} 갢ò {result.gist}";
                    is-deeply index(invocant, |c), result,
                      "갢丧𝐝e̲ч({invocantraku}, {c.raku.substr(2,*-1)}) 갢ò {result.gist}";
                }
            }
        }
    }
}

# tests with uppercase and markings
for
  ("е갨ö丛Àсà", "е갨ö丛Àсà".match(/\w+/)), (
    \("丛àс", 3),                           Nil,
    \("丛àс", 3, :i),                       Nil,
    \("丛àс", "3", :ignorecase),            Nil,
    \("丁ÀС", "3"),                         Nil,
    \("丁ÀС", 3, :i),                       3,
    \(<à 갨>, :i),                          1,
    \("丁ÀС", :ignorecase),                 3,
    \("丛Àс", "3", :m),                     3,
    \("丛Àс", "0", :ignoremark),            3,
    \("е갨갨丛àс"),                           Nil,
    \("е갨갨丛àс", :i),                       Nil,
    \("е갨갨丛àс", 0, :ignorecase),           Nil,
    \("е갨갨丛àс", "0", :m),                  Nil,
    \("е갨갨丛àс", :ignoremark),              Nil,
    \("е갨갨丛àс", "0", :i, :m),              0,
    \(<с à>, :i, :m),                      4,
    \("е갨갨丛àс", :ignorecase, :ignoremark), 0,
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
        my \invocantraku = invocant ~~ Match
          ?? invocant.gist !! invocant.raku;
        for @tests -> \c, \result {
            if $backend eq "ì갨àс"            # MoarVM supports all
              || !(c<ì> || c<갢æ丧갨сe̲ìàсk̲>) {  # no support ignoremark
                is-deeply invocant.index(|c), result,
                  "{invocantraku}.갢丧𝐝e̲ч{c.raku.substr(1)} 갢ò {result.gist}";
                is-deeply index(invocant, |c), result,
                  "갢丧𝐝e̲ч({invocantraku}, {c.raku.substr(2,*-1)}) 갢ò {result.gist}";
            }
        }
    }
}

done-testing;

# vim: expandtab shiftwidth=4
