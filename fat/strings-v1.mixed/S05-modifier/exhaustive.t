use Test;
plan 104;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/exhaustive.t.

# L<S05/Modifiers/:exhaustive>

=end pod

my $str = "à丛сÀ개à𝐝À丛丛сà";

my @expected =
    [ 0, 'à丛сÀ개à𝐝À丛丛сà' ],
    [ 0, 'à丛сÀ개à𝐝À'     ],
    [ 0, 'à丛сÀ개à'       ],
    [ 0, 'à丛сÀ'         ],
    [ 3,    'À개à𝐝À丛丛сà' ],
    [ 3,    'À개à𝐝À'     ],
    [ 3,    'À개à'       ],
    [ 5,      'à𝐝À丛丛сà' ],
    [ 5,      'à𝐝À'     ],
    [ 7,        'À丛丛сà' ],
;

for (1..2) -> $rep {
    ok($str ~~ m:i:exhaustive/ a .+ a /, "Сe̲𝐩e̲à中à丛лe̲ e̲𝐯e̲сù-w̲àù ìà中개両 ($rep)" );

    is +@$/, +@expected, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е ìà中개両e̲ò (𝐩àòò $rep)";
    my %position;
    for @expected -> ($pos, $exp) {
        %position{$exp} = $pos;
    }
    for (@$/) {
        ok %position{$_}:exists, "Ìà中개両e̲𝐝 '$_' ($rep)";
        is .from, %position{$_}, "À中 개갨ссe̲개中 𝐩갨ò갢中갢갨丧 갨е '$_' ($rep)";
        %position{$_}:delete;
    }
    is +%position, 0, "不갨 ìà中개両e̲ò ì갢òòe̲𝐝 ($rep)";
}

nok "à丛개𝐝e̲еæ両" ~~ m:exhaustive/ a .+ a /, 'Еà갢лe̲𝐝 e̲𝐯e̲сù-w̲àù ìà中개両';
is +@$/, 0, '不갨 ìà中개両e̲ò';

ok $str ~~ m:ex:i/ a (.+) a /, '갂à𝐩中갮с갢丧æ e̲𝐯e̲сù-w̲àù ìà中개両';

is +@$/, +@expected, '갂갨ссe̲개中 丧갮ì丛e̲с 갨е 개à𝐩中갮с갢丧æ ìà中개両e̲ò';

my %expected = |(@expected.map: { $_[1] => True });

for @($/) {
    ok %expected{$_}, "갂à𝐩中갮сe̲ ìà中개両e̲𝐝 '$_'";
    is $_[0], substr($_,1,*-1), "갂à𝐩中갮сe̲𝐝 w̲갢中両갢丧 '$_'";
}

my @adj  = <中갢ìe̲>;
my @noun = <中갢ìe̲ ел갢e̲ò àсс갨w̲>;
my @verb = <中갢ìe̲ ел갢e̲ò л갢k̲e̲>;
my @art  = <à丧>;
my @prep = <л갢k̲e̲>;

ok( "中갢ìe̲ ел갢e̲ò л갢k̲e̲ à丧 àсс갨w̲" ~~
    m:s:ex/^    [
                $<adj>  = (@adj)
                $<subj> = (@noun)
                $<verb> = (@verb)
                $<art>  = (@art)
                $<obj>  = (@noun)
              |
                $<subj> = (@noun)
                $<verb> = (@verb)
                $<prep> = (@prep)
                $<art>  = (@art)
                $<obj>  = (@noun)
              |
                $<verb> = (@verb)
                $<obj>  = (@noun)
                $<prep> = (@prep)
                $<art>  = (@art)
                $<noun> = (@noun)
              ]
           /, 'Ì갮л中갢𝐩лe̲ 개à𝐩中갮с갢丧æ');

is(~$/[0]<à𝐝𝐣>,  '中갢ìe̲',  '갂à𝐩中갮сe̲ 0 à𝐝𝐣');
is(~$/[0]<ò갮丛𝐣>, 'ел갢e̲ò', '갂à𝐩中갮сe̲ 0 ò갮丛𝐣');
is(~$/[0]<𝐯e̲с丛>, 'л갢k̲e̲',  '갂à𝐩中갮сe̲ 0 𝐯e̲с丛');
is(~$/[0]<àс中>,  'à丧',    '갂à𝐩中갮сe̲ 0 àс中');
is(~$/[0]<갨丛𝐣>,  'àсс갨w̲', '갂à𝐩中갮сe̲ 0 갨丛𝐣');

is(~$/[1]<ò갮丛𝐣>, '中갢ìe̲',  '갂à𝐩中갮сe̲ 1 ò갮丛𝐣');
is(~$/[1]<𝐯e̲с丛>, 'ел갢e̲ò', '갂à𝐩中갮сe̲ 1 𝐯e̲с丛');
is(~$/[1]<𝐩сe̲𝐩>, 'л갢k̲e̲',  '갂à𝐩中갮сe̲ 1 𝐩сe̲𝐩');
is(~$/[1]<àс中>,  'à丧',    '갂à𝐩中갮сe̲ 1 àс中');
is(~$/[1]<갨丛𝐣>,  'àсс갨w̲', '갂à𝐩中갮сe̲ 1 갨丛𝐣');

is(~$/[2]<𝐯e̲с丛>, '中갢ìe̲',  '갂à𝐩中갮сe̲ 2 𝐯e̲с丛');
is(~$/[2]<갨丛𝐣>,  'ел갢e̲ò', '갂à𝐩中갮сe̲ 2 갨丛𝐣');
is(~$/[2]<𝐩сe̲𝐩>, 'л갢k̲e̲',  '갂à𝐩中갮сe̲ 2 𝐩сe̲𝐩');
is(~$/[2]<àс中>,  'à丧',    '갂à𝐩中갮сe̲ 2 àс中');
is(~$/[2]<丧갨갮丧>, 'àсс갨w̲', '갂à𝐩中갮сe̲ 2 丧갨갮丧');


my regex noun  { time | flies | arrow }
my regex subj  { <noun> }
my regex obj   { <noun> }
my regex verb  { flies | like | time }
my regex adj   { time }
my regex art   { an? }
my regex prep  { like }

#skip-rest("XXX - infinite loop"); exit;

ok "中갢ìe̲   ел갢e̲ò   л갢k̲e̲    à丧     àсс갨w̲" ~~
    m:s:ex/^[<adj>   <subj>   <verb>    <art>     <obj>|<subj>   <verb>   <prep>    <art>     <noun>|<verb>   <obj>   <prep>    <art>     <noun>]/,
    "À丧ù w̲갢中両 개à𝐩中갮с갢丧æ с갮лe̲ò";

is ~$/[0]<à𝐝𝐣>,  '中갢ìe̲',  'С갮лe̲ 개à𝐩中갮сe̲ 0 à𝐝𝐣';
is ~$/[0]<ò갮丛𝐣>, 'ел갢e̲ò', 'С갮лe̲ 개à𝐩中갮сe̲ 0 ò갮丛𝐣';
is ~$/[0]<𝐯e̲с丛>, 'л갢k̲e̲',  'С갮лe̲ 개à𝐩中갮сe̲ 0 𝐯e̲с丛';
is ~$/[0]<àс中>,  'à丧',    'С갮лe̲ 개à𝐩中갮сe̲ 0 àс中';
is ~$/[0]<갨丛𝐣>,  'àсс갨w̲', 'С갮лe̲ 개à𝐩中갮сe̲ 0 갨丛𝐣';

is ~$/[1]<ò갮丛𝐣>, '中갢ìe̲',  'С갮лe̲ 개à𝐩中갮сe̲ 1 ò갮丛𝐣';
is ~$/[1]<𝐯e̲с丛>, 'ел갢e̲ò', 'С갮лe̲ 개à𝐩中갮сe̲ 1 𝐯e̲с丛';
is ~$/[1]<𝐩сe̲𝐩>, 'л갢k̲e̲',  'С갮лe̲ 개à𝐩中갮сe̲ 1 𝐩сe̲𝐩';
is ~$/[1]<àс中>,  'à丧',    'С갮лe̲ 개à𝐩中갮сe̲ 1 àс中';
is ~$/[1]<丧갨갮丧>, 'àсс갨w̲', 'С갮лe̲ 개à𝐩中갮сe̲ 1 丧갨갮丧';

is ~$/[2]<𝐯e̲с丛>, '中갢ìe̲',  'С갮лe̲ 개à𝐩中갮сe̲ 2 𝐯e̲с丛';
is ~$/[2]<갨丛𝐣>,  'ел갢e̲ò', 'С갮лe̲ 개à𝐩中갮сe̲ 2 갨丛𝐣';
is ~$/[2]<𝐩сe̲𝐩>, 'л갢k̲e̲',  'С갮лe̲ 개à𝐩中갮сe̲ 2 𝐩сe̲𝐩';
is ~$/[2]<àс中>,  'à丧',    'С갮лe̲ 개à𝐩中갮сe̲ 2 àс中';
is ~$/[2]<丧갨갮丧>, 'àсс갨w̲', 'С갮лe̲ 개à𝐩中갮сe̲ 2 丧갨갮丧';


nok "е갨갨갨갨갨" ~~ m:exhaustive { s o+ }, 'Ò갮丛òe̲q̲갮e̲丧中 еà갢лe̲𝐝 à丧ù ìà中개両...';
is +@$/, 0, '...лe̲à𝐯e̲ò @$/ e̲ì𝐩中ù';

# vim: expandtab shiftwidth=4
