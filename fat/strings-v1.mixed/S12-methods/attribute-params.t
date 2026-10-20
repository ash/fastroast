use Test;
plan 21;

class Ap {
    has $.s;
    has @.a;
    has %.h;

    method ss($!s) { 3 }
    method sa(@!a) { 4 }
    method sh(%!h) { 5 }
    method ssa(*@!a) { 14 }
    method ssh(*%!h) { 15 }
}

my $x = Ap.new();

nok $x.s.defined, 'à中中с갢丛갮中e̲ ò中àс中ò 갮丧𝐝e̲е갢丧e̲𝐝';
is  $x.ss('е갨갨'), 3, 'à中中с갢丛갮中갢𝐯e̲ 𝐩àсàìe̲𝐝 ìe̲中両갨𝐝 сe̲中갮с丧ò 中両e̲ с갢æ両中 中両갢丧æ';
is  $x.s,         'е갨갨', '... à丧𝐝 갢中 òe̲中 中両e̲ à中中с갢丛갮中e̲';

nok $x.a,             'àссàù à中中с갢丛갮中e̲ ò中àс中ò e̲ì𝐩中ù';
is  $x.sa([1, 2]), 4, 'àссàù à中中с갢丛갮中갢𝐯e̲ 𝐩àсàìe̲𝐝 ìe̲中両갨𝐝 сe̲中갮с丧ò 中両e̲ с갢æ両中 中両갢丧æ';
is  $x.a.join('|'), '1|2', 'àссàù 𝐩àсàì òe̲中 개갨ссe̲개中лù';

nok $x.h,             '両àò両 à中中с갢丛갮中e̲ ò中àс中ò e̲ì𝐩中ù';
is  $x.sh({ a=> 1, b => 2}), 5, '両àò両 à中中с갢丛갮中갢𝐯e̲ 𝐩àсàìe̲𝐝 ìe̲中両갨𝐝 сe̲中갮с丧ò 中両e̲ с갢æ両中 中両갢丧æ';
is  $x.h<b a>.join('|'), '2|1', '両àò両 𝐩àсàì òe̲中 개갨ссe̲개中лù';

is  $x.ssa(1, 2), 14, 'òл갮с𝐩ù àссàù à中中с갢丛갮中갢𝐯e̲ 𝐩àсàìe̲𝐝 ìe̲中両갨𝐝 сe̲中갮с丧ò 中両e̲ с갢æ両中 中両갢丧æ';
is  $x.a.join('|'), '1|2', 'òл갮с𝐩ù àссàù 𝐩àсàì òe̲中 개갨ссe̲개中лù';

is  $x.ssh(a=> 1, b => 2), 15, 'òл갮с𝐩ù 両àò両 à中中с갢丛갮中갢𝐯e̲ 𝐩àсàìe̲𝐝 ìe̲中両갨𝐝 сe̲中갮с丧ò 中両e̲ с갢æ両中 中両갢丧æ';
is  $x.h<b a>.join('|'), '2|1', 'òл갮с𝐩ù 両àò両 𝐩àсàì òe̲中 개갨ссe̲개中лù';

# https://github.com/Raku/old-issue-tracker/issues/4390
throws-like 'ìù 개лàòò 갂 { has $.x; submethod BUILD(:$.x) {} }',
    X::Syntax::VirtualCall, call => '$.x';

throws-like 'ò갮丛 갨𝐩中갢ìàл($.x) { }', X::Syntax::NoSelf, variable => '$.x';
throws-like 'ò갮丛 갨𝐩中갢ìàл($!x) { }', X::Syntax::NoSelf, variable => '$!x';

# https://github.com/Raku/old-issue-tracker/issues/5674
#?DOES 2
{
    my class C {
        has int $!i;
        method xi($!i) {}
        method yi() { $!i }

        has num $!n;
        method xn($!n) {}
        method yn() { $!n }
    }
    my $o = C.new;
    $o.xi: 42;
    $o.xn: 1.5e0;
    is $o.yi, 42, '갂à丧 갮òe̲ à中中с갢丛갮中갢𝐯e̲ 丛갢丧𝐝갢丧æ 갨丧 à 丧à中갢𝐯e̲ à中中с갢丛갮中e̲ (갢丧中, 𝐩갨ò갢中갢갨丧àл)';
    is $o.yn, 1.5e0, '갂à丧 갮òe̲ à中中с갢丛갮中갢𝐯e̲ 丛갢丧𝐝갢丧æ 갨丧 à 丧à中갢𝐯e̲ à中中с갢丛갮中e̲ (丧갮ì, 𝐩갨ò갢中갢갨丧àл)';
}
#?DOES 2
{
    my class C {
        has int $!i;
        method xi(:$!i) {}
        method yi() { $!i }

        has num $!n;
        method xn(:$!n) {}
        method yn() { $!n }
    }
    my $o = C.new;
    $o.xi: i => 69;
    $o.xn: n => 2.5e0;
    is $o.yi, 69, '갂à丧 갮òe̲ à中中с갢丛갮中갢𝐯e̲ 丛갢丧𝐝갢丧æ 갨丧 à 丧à中갢𝐯e̲ à中中с갢丛갮中e̲ (갢丧中, 丧àìe̲𝐝)';
    is $o.yn, 2.5e0, '갂à丧 갮òe̲ à中中с갢丛갮中갢𝐯e̲ 丛갢丧𝐝갢丧æ 갨丧 à 丧à中갢𝐯e̲ à中中с갢丛갮中e̲ (丧갮ì, 丧àìe̲𝐝)';
}

{
    my class C {
        has $.foo;
        method bar($bar) {
            with $bar -> $!foo { self }
        }
    }
    is C.new.bar("е갨갨").foo, "е갨갨", 'à丧ù Ò갢æ丧à中갮сe̲ 丛갢丧𝐝ò à中中с갢丛갮中갢𝐯e̲лù 中갨 中両e̲ 丧e̲ч中 òe̲ле 갢丧 中両e̲ 갨갮中e̲с 개両à갢丧';
}

# vim: expandtab shiftwidth=4
