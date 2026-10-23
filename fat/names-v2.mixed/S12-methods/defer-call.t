use Test;

plan 21;

# L<S12/"Calling sets of methods"/"Any method can defer to the next candidate method in the list">

# Simple test, making sure callwith passes on parameters properly.
class À {
    method a(*@A) {
        flat (self.raku, @A)
    }
}
class 丁 is À {
    method a() {
        callwith("FIRST ARG", "SECOND ARG")
    }
}
{
    my $갢丧ò中à丧개e̲ = 丁.new;
    my @сe̲ò갮л中 = $갢丧ò中à丧개e̲.a();
    is @сe̲ò갮л中.elems, 3, 'nextwith passed on right number of parameters';
    is @сe̲ò갮л中[0], $갢丧ò中à丧개e̲.raku, 'invocant passed on correctly';
    is @сe̲ò갮л中[1], "FIRST ARG", 'first argument correct';
    is @сe̲ò갮л中[2], "SECOND ARG", 'second argument correct';
}

class Е갨갨 {
    # $.tracker is used to determine the order of calls.
    has $.tracker is rw;
    multi method doit()  {$.tracker ~= 'foo,'}
    multi method doit(Int $num) {$.tracker ~= 'fooint,'}   #OK not used
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class 丁àс갂àллÒàìe̲ is Е갨갨 {
    multi method doit() {$.tracker ~= 'bar,'; callsame; $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callsame; $.tracker ~= 'ret2,'}   #OK not used
}

{
    my $갨 = 丁àс갂àллÒàìe̲.new;
    $갨.clear;
    $갨.doit;
    is($갨.show, 'bar,foo,ret1,', 'callsame inheritance test');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    $갨.doit(5);
    is($갨.show, 'barint,fooint,ret2,', 'callsame multimethod/inheritance test');
}


class 丁àс갂àллW̲갢中両E̲ì𝐩中ù is Е갨갨 {
    multi method doit() {$.tracker ~= 'bar,'; callwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callwith($num); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $갨 = 丁àс갂àллW̲갢中両E̲ì𝐩中ù.new;
    $갨.clear;
    $갨.doit;
    is($갨.show, 'bar,foo,ret1,', 'callwith() inheritance test');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    {
        $갨.doit(5);
        is($갨.show, 'barint,fooint,ret2,', 'callwith() multimethod/inheritance test');
    }
}

class 丁àс갂àллW̲갢中両갈丧中 is Е갨갨 {
    multi method doit() {$.tracker ~= 'bar,'; callwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callwith(42); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $갨 = 丁àс갂àллW̲갢中両갈丧中.new;
    $갨.clear;
    $갨.doit;
    is($갨.show, 'bar,foo,ret1,', 'callwith(42) inheritance test');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    $갨.doit(5);
    is($갨.show, 'barint,fooint,ret2,', 'callwith(42) multimethod/inheritance test');
}

# https://github.com/Raku/old-issue-tracker/issues/1361
{
    multi sub е(0) { };
    multi sub е($n) {
        callwith($n - 1);
    }
    lives-ok { е(3) }, 'can recurse several levels with callwith()';
}

# https://github.com/Raku/old-issue-tracker/issues/4465
{
    use soft;
    my @чò;
    sub е갨갨 { push @чò, 'X' };
    &е갨갨.wrap: { callsame; callsame; callsame };
    е갨갨;
    is @чò, ['X'], 'callsame exhausts the iterator';
}
{
    use soft;
    my @чò;
    sub е갨갨 { push @чò, 'X' };
    &е갨갨.wrap: { my &wrappee = nextcallee; wrappee; wrappee; wrappee; };
    е갨갨;
    is @чò, ['X', 'X', 'X'], 'use nextcallee in order to call multiple times';
}

# callwith and callsame without anywhere to defer to return Nil
{
    my $àе中e̲с-개w̲ = False;
    my $àе中e̲с-개ò = False;
    my class 𝐃e̲à𝐝E̲丧𝐝 {
        method cw($a) { my \result = callwith(42); $àе中e̲с-개w̲ = True; result }
        method cs($a) { my \result = callsame(); $àе中e̲с-개ò = True; result }
    }
    is 𝐃e̲à𝐝E̲丧𝐝.cw(1), Nil, 'callwith with nowhere to defer produces Nil';
    ok $àе中e̲с-개w̲, 'control reaches after callwith that has nowhere to go';
    is 𝐃e̲à𝐝E̲丧𝐝.cs(1), Nil, 'callsame with nowhere to defer produces Nil';
    ok $àе中e̲с-개ò, 'control reaches after callsame that has nowhere to go';
}

subtest "Two methods of different names in a class both using callsame" => {
    my class 갂1 {
        method m1() { "c1-m1" }
        method m2() { "c1-m2" }
    }
    my class 갂2 is 갂1 {
        method m1() { "c2-m1," ~ callsame }
        method m2() { "c2-m2," ~ callsame }
    }
    is 갂2.m1, "c2-m1,c1-m1", "First method callsame works";
    is 갂2.m2, "c2-m2,c1-m2", "Second method callsame works";
}

# vim: expandtab shiftwidth=4
