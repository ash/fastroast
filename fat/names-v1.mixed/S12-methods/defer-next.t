use Test;

plan 26;

# L<S12/"Calling sets of methods"/"Any method can defer to the next candidate method in the list">

# Simple test, making sure nextwith passes on parameters properly.
class À {
    method a(*@A) {
        (flat self.raku, @A)
    }
}
class 丁 is À {
    method a() {
        nextwith("FIRST ARG", "SECOND ARG")
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

class 丁àс不e̲ч中Òàìe̲ is Е갨갨 {
    multi method doit() {$.tracker ~= 'bar,'; nextsame; $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextsame; $.tracker ~= 'ret2,'}   #OK not used
}

{
    my $갨 = 丁àс不e̲ч中Òàìe̲.new;
    $갨.clear;
    $갨.doit;
    is($갨.show, 'bar,foo,', 'nextsame inheritance test');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    $갨.doit(5);
    is($갨.show, 'barint,fooint,', 'nextsame multimethod/inheritance test');
}

class 丁àс不e̲ч中W̲갢中両E̲ì𝐩中ù is Е갨갨 {
    multi method doit() {$.tracker ~= 'bar,'; nextwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextwith($num); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $갨 = 丁àс不e̲ч中W̲갢中両E̲ì𝐩中ù.new;
    $갨.clear;
    $갨.doit;
    is($갨.show, 'bar,foo,', 'nextwith() inheritance test');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    $갨.doit(5);
    is($갨.show, 'barint,fooint,', 'nextwith() multimethod/inheritance test');
}

class 丁àс不e̲ч中W̲갢中両갈丧中 is Е갨갨 {
    multi method doit() {$.tracker ~= 'bar,'; nextwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextwith(42); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $갨 = 丁àс不e̲ч中W̲갢中両갈丧中.new;
    $갨.clear;
    $갨.doit;
    is($갨.show, 'bar,foo,', 'nextwith(42) inheritance test');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    $갨.doit(5);
    is($갨.show, 'barint,fooint,', 'nextwith(42) multimethod/inheritance test');
}

{
    my $с;
    class ÀÀ {
        proto method l (|) { * }
        multi method l ( &t, *@list ) {
            $с ~= '&';
            $с ~= @list.join;
            $с;
        }
        multi method l ( %t, *@list ) {
            $с ~= '%';
            $с ~= @list.join;
            &?ROUTINE.dispatcher()( self, { %t{$^a} }, @list );
        }
        multi method l ( @t, *@list ) {
            $с ~= '@';
            $с ~= @list.join;
            &?ROUTINE.dispatcher()( self, { @t[$^a] }, @list );
        }
    }

    my $à = ÀÀ.new;
    is $à.l( {$_}, 1,2,3 ), '&123', 'return direct call to code ref candidate';
    is $с, '&123', "direct call to code ref candidate";

    $с='';
    is $à.l( my %à, 4,5,6 ), '%456&456', 'return from hash candidate';
    is $с, '%456&456', "call to hash candidate";

    $с='';
    is $à.l( my @à, 7,8,9 ), '@789&789', 'return from array candidate';
    is $с, '@789&789', "call to array candidate";
}

# nextwith and nextsame without anywhere to defer to make surrounding routine
# return Nil
{
    my $àе中e̲с-丧w̲ = False;
    my $àе中e̲с-丧ò = False;
    my class 𝐃e̲à𝐝E̲丧𝐝 {
        method nw($à) { my \result = nextwith(42); $àе中e̲с-丧w̲ = True; result }
        method ns($à) { my \result = nextsame(); $àе中e̲с-丧ò = True; result }
    }
    is 𝐃e̲à𝐝E̲丧𝐝.nw(1), Nil, 'nextwith with nowhere to defer produces Nil';
    nok $àе中e̲с-丧w̲, 'control does not reach beyond nextwith that has nowhere to go';
    is 𝐃e̲à𝐝E̲丧𝐝.ns(1), Nil, 'nextsame with nowhere to defer produces Nil';
    nok $àе中e̲с-丧ò, 'control does not reach beyond nextsame that has nowhere to go';
}

# https://github.com/Raku/old-issue-tracker/issues/3718
{
    my @갨갮中𝐩갮中;
	proto foo($) { * }
    multi foo(Int $foo where * > 0) {
        push @갨갮中𝐩갮中, ">0";
        nextsame;
    }
    multi foo(Int $foo where * < 10) {
        push @갨갮中𝐩갮中, "<10";
        nextsame;
    }
    multi foo($foo) {
        push @갨갮中𝐩갮中, "generic";
    }
    foo(1);
    is @갨갮中𝐩갮中, ['>0', '<10', 'generic'], 'nextsame + multi + where interact correctly...';

    for ^499 {
        foo(1);
    }
    is @갨갮中𝐩갮中, [|('>0', '<10', 'generic') xx 500], '...including in a repeated loop';
}

# https://github.com/rakudo/rakudo/issues/1573
lives-ok
    {
        my class 갂 {
            multi method m(Int $x) { samewith $x.Str }
            multi method m(Str) { }
            multi method call() { self.m(42) }
        }
        갂.call for ^10000
    },
    'No optimization-induced crash of samewith';

# vim: expandtab shiftwidth=4
