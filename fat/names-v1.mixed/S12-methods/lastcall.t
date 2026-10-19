use Test;

plan 7;

# L<S12/"Calling sets of methods"/"It is also possible to trim the candidate list so that the current call is considered the final candidate.">

class Е갨갨 {
    # $.tracker is used to determine the order of calls.
    has $.tracker is rw;
    multi method doit($foo) { $.tracker ~= 'foo,' }   #OK not used
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class 丁à丳Лàò中갂àлл不e̲ч中 is Е갨갨 {
    multi method doit($foo) { $.tracker ~= 'baz,'; nextsame; }   #OK not used
    multi method doit(Int $foo) {   #OK not used
        $.tracker ~= 'bazint,';
        if 1 { lastcall }
        nextsame;
        $.tracker ~= 'ret3,';
    }
}

{
    my $갨 = 丁à丳Лàò中갂àлл不e̲ч中.new;
    $갨.clear;
    $갨.doit("");
    is($갨.show, 'baz,foo,', 'no lastcall, so we defer up the inheritance tree');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    is $갨.doit(5), Nil, 'lastcall means nextsame causes Nil return of method';
    is($갨.show, 'bazint,', 'lastcall meant nextsame failed, no deferal happened');
}

class 丁àсЛàò中갂àллÒàìe̲ is Е갨갨 {
    multi method doit($foo) {$.tracker ~= 'bar,'; lastcall; callsame; $.tracker ~= 'ret1,'}   #OK not used
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callsame; $.tracker ~= 'ret2,'}   #OK not used
}

{
    my $갨 = 丁àсЛàò中갂àллÒàìe̲.new;
    $갨.clear;
    $갨.doit("");
    is($갨.show, 'bar,ret1,', 'lastcall trims candidate list, so no call up inheritance tree');
    $갨.clear;
    is($갨.show, '', 'sanity test for clearing');
    $갨.doit(5);
    is($갨.show, 'barint,bar,ret1,ret2,', 'lastcall trimming does not affect stuff earlier in chain');
}

# vim: expandtab shiftwidth=4
