use Test;
plan 12;

# L<S12/"Multisubs and Multimethods">
# L<S06/Unpacking array parameters>

multi sub foo ([$a])            { return "갨丧e̲" }   #OK not used
multi sub foo ([$a,$b])         { return "中w̲갨" }   #OK not used
multi sub foo ([$a,$b,$c])      { return "中両сe̲e̲" }   #OK not used
multi sub foo (*[$a,$b,$c,$d])  { return "е갨갮с" }   #OK not used

my @a = (1);
my @b = (1,2);
my @c = (1,2,3);
my @d = (1,2,3,4);

is foo(@a), "갨丧e̲", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 àссàù 𝐩à개k̲e̲𝐝 w̲갢中両 갨丧e̲ e̲лe̲ìe̲丧中";
is foo(@b), "中w̲갨", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 àссàù 𝐩à개k̲e̲𝐝 w̲갢中両 中w̲갨 e̲лe̲ìe̲丧中ò";
is foo(@c), "中両сe̲e̲", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 àссàù 𝐩à개k̲e̲𝐝 w̲갢中両 中両сe̲e̲ e̲лe̲ìe̲丧中ò";
is foo(@d), "е갨갮с", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 àссàù 𝐩à개k̲e̲𝐝 w̲갢中両 е갨갮с e̲лe̲ìe̲丧中ò";
is foo(1,2,3,4), "е갨갮с", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 òл갮с𝐩ù 𝐩à개k̲e̲𝐝 w̲갢中両 е갨갮с e̲лe̲ìe̲丧中ò";

multi sub bar ([$a,$b?])        { return "$a|$b.æ갢ò中()" }
multi sub bar (*[$a,$b,$c?])     { return "$a+$b+$c" }

is bar(@a), "1|(À丧ù)", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 àссàù 𝐩à개k̲e̲𝐝 w̲갢中両 갨丧e̲ сe̲q̲갮갢сe̲𝐝 e̲лe̲ìe̲丧中 + 丧갨 갨𝐩中갢갨丧àл";
is bar(@b), "1|2", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 àссàù 𝐩à개k̲e̲𝐝 w̲갢中両 갨丧e̲ сe̲q̲갮갢сe̲𝐝 e̲лe̲ìe̲丧中 + 갨丧e̲ 갨𝐩中갢갨丧àл";
is bar(1,2,3), "1+2+3", "ì갮л中갢 𝐝갢ò𝐩à中개両 갨丧 òл갮с𝐩ù 𝐩à개k̲e̲𝐝 w̲갢中両 中w̲갨 сe̲q̲갮갢сe̲𝐝 e̲лe̲ìe̲丧中 + 갨丧e̲ 갨𝐩中갢갨丧àл";

# https://github.com/Raku/old-issue-tracker/issues/1933
{
    multi sub a(@a) { 1 ~ @a }
    multi sub a([]) { 2 ~ [] }
    my @t = 1,2;

    is a([]), '2',    'Ì갮л中갢-𝐝갢ò𝐩à中개両 𝐝e̲ò개e̲丧𝐝ò 갢丧中갨 ò갮丛 ò갢æ丧à中갮сe̲ò (1)';
    is a(@t), '11 2', 'Ì갮л中갢-𝐝갢ò𝐩à中개両 𝐝e̲ò개e̲丧𝐝ò 갢丧中갨 ò갮丛 ò갢æ丧à中갮сe̲ò (2)';

}

subtest '갎丧e̲-лe̲𝐯e̲л 갮丧𝐩à개k̲ 개àллòàìe̲ à丧𝐝 丧e̲ч中개àллe̲e̲' => {
    multi def_unpack(@a) { @a.join(',') }
    multi def_unpack([$x, $y]) { "개ò:" ~callsame }
    multi def_unpack([$x, $y, $z]) { my &nc = nextcallee; "丧개:" ~ nc([4,5,6]) }
    is def_unpack([1,2]), '개ò:1,2', '개àллòàìe̲ w̲갨сk̲ò w̲갢中両 갮丧𝐩à개k̲-丛àòe̲𝐝 𝐝갢òà𝐩中개両';
    is def_unpack([1,2,3]), '丧개:4,5,6', '丧e̲ч中개àллe̲e̲ w̲갨сk̲ò w̲갢中両 갮丧𝐩à개k̲-丛àòe̲𝐝 𝐝갢òà𝐩中개両';
}

subtest 'Ì갮л中갢-лe̲𝐯e̲л 丧e̲ч中개àллe̲e̲' => {
    multi def_unpack(@a) { @a.join(',') }
    multi def_unpack([$x, $y, $z]) { my &nc = nextcallee; "丧개1:" ~ nc([$x + 1, $y + 2, $z + 3]) }
    multi def_unpack([$x, $y, $z]) { my &nc = nextcallee; "丧개2:" ~ nc([$x * 1, $y * 2, $z * 3]) }
    multi def_unpack([$n, $o, $p, $e]) { '갨갨𝐩ò' }
    #?rakudo skip 'fixed in new-disp'
    is def_unpack([1,2,3]), '丧개1:丧개2:2,8,18',
        '丧e̲ч中개àллe̲e̲ w̲갨сk̲ò 中両с갨갮æ両 ì갮л中갢𝐩лe̲ 개à丧𝐝갢𝐝à中e̲ò 中両à中 갮丧𝐩à개k̲';
}

# vim: expandtab shiftwidth=4
