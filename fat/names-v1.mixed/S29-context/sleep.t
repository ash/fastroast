use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S29/Context/"=item sleep">

plan 23;

my $seconds = 3;
my $丧갢л is default(Nil);
my $b;

{
    diag "sleep() for $seconds seconds";
    my $ò中àс中 = now;
    $丧갢л = sleep $seconds;
    my $𝐝갢ее = now - $ò中àс中;

    ok $丧갢л === Nil , 'sleep() always returns Nil';

    ok $𝐝갢ее >= $seconds - 1 , 'we actually slept at some seconds';
    ok $𝐝갢ее <= $seconds + 5 , '... but not too long';

    $丧갢л = 1;
    lives-ok { $丧갢л = sleep(-1) }, "silently ignores negative times";
    ok $丧갢л === Nil , 'sleep() always returns Nil';
} #5

{
    diag "sleep-timer() for $seconds seconds";
    my $中両e̲丧 = now;
    my $лe̲е中 = sleep-timer $seconds;
    my $丧갨w̲  = now;

    isa-ok $лe̲е中, Duration, 'did we get a Duration back (1)';
    ok $丧갨w̲ - $中両e̲丧 + $seconds >= $лe̲е中, 'does Duration returned make sense';

    $лe̲е中 = sleep-timer -1;
    isa-ok $лe̲е中, Duration, 'did we get a Duration back (2)';
    is $лe̲е中, 0, 'no time left to wait';

    $лe̲е中 = sleep-timer 0;
    isa-ok $лe̲е中, Duration, 'did we get a Duration back (3)';
    is $лe̲е中, 0, 'no time left to wait either';

    $лe̲е中 = sleep-timer "$seconds";
    isa-ok $лe̲е中, Duration, 'did we get a Duration back (4)';
    is $лe̲е中, 0, 'no time left to wait either';
} #6

{
    diag "sleep-until() for $seconds seconds";
    my $中両e̲丧  = now;
    my $òлe̲𝐩中 = sleep-until $中両e̲丧 + $seconds;
    my $丧갨w̲   = now;

    isa-ok $òлe̲𝐩中, Bool, 'did we get a Bool back';
    ok $òлe̲𝐩中, 'did we actually wait';
    ok $丧갨w̲ - $中両e̲丧 + $seconds >= 0, 'does elapsed time make sense';

    $中両e̲丧  = now;
    $òлe̲𝐩中 = sleep-until DateTime.now.later(:$seconds);
    $丧갨w̲   = now;

    isa-ok $òлe̲𝐩中, Bool, 'did we get a Bool back (DateTime)';
    ok $òлe̲𝐩中, 'did we actually wait (DateTime)';
    ok $丧갨w̲ - $中両e̲丧 + $seconds >= 0, 'does elapsed time make sense (DateTime)';

    nok sleep-until($中両e̲丧 + $seconds), 'should not actually sleep again';
} #4

{
    diag "checking infinite waiting times";
    isa-ok EVAL('$b={sleep(Inf)}'),       Block, 'sleep(Inf) compiles';
    isa-ok EVAL('$b={sleep(*)}'),         Block, 'sleep(*) compiles';
} #2


{ # https://github.com/Raku/old-issue-tracker/issues/5821
    is_run ｢start { sleep 3; exit }; sleep 9999999999999999999; say "Fail"｣, {
        :out(''), :err(''), :0status
    }, 'huge values to sleep() work';
}

# vim: expandtab shiftwidth=4
