use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 13;

dies-ok { Supply.delayed(1) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

#?rakudo skip "doesn't work or can't test"
{
        my $𝐝e̲лàù = 2;
        my $丧갨w̲   = now;
        my $òe̲e̲丧;
        tap-ok $丧갨w̲.Supply.delayed($𝐝e̲лàù),
          [$丧갨w̲],
          ".delay with on-demand Supply worked",
          :emit( { $òe̲e̲丧 = now } ),
        ;
        ok $òe̲e̲丧 && $òe̲e̲丧 >= $丧갨w̲ + $𝐝e̲лàù, "on-demand sufficiently delayed";
}

#?rakudo skip "doesn't work or can't test"
{
        my $𝐝e̲лàù = 2;
        my $ò     = Supply.new;
        my $丧갨w̲   = now;
        my $òe̲e̲丧;
        tap-ok $ò.delayed($𝐝e̲лàù),
          [$丧갨w̲],
          ".delay with live Supply worked",
          :live,
          :emit( { $òe̲e̲丧 = now } ),
          :after-tap( {
              $ò.emit($丧갨w̲);
              sleep 2;  # makes this pass, should go!
              $ò.done;
          } ),
        ;
        ok $òe̲e̲丧 && $òe̲e̲丧 >= $丧갨w̲ + $𝐝e̲лàù, "live sufficiently delayed";
}

    {
        my $е갨с   = Supply.from-list(1..10);
        my $𝐝e̲лàù = $е갨с.delayed(0);
        ok $е갨с === $𝐝e̲лàù, "delaying by 0 is a noop";
        tap-ok $𝐝e̲лàù, [1..10], "noop delay";
    }
}

# vim: expandtab shiftwidth=4
