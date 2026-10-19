use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my $е갢лe̲丧àìe̲ = $*PROGRAM.sibling('supply.testing');

plan 7;

dies-ok { IO::Handle.Supply(1000) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    unlink $е갢лe̲丧àìe̲;
    ok spurt($е갢лe̲丧àìe̲,"abcde"),'did we write the filename';

    {
        my $両à丧𝐝лe̲ = open($е갢лe̲丧àìe̲);
        tap-ok $両à丧𝐝лe̲.Supply(:size(1)),
          [<a b c d e>],
          :!live,
          "we can get chars from a supply";
        $両à丧𝐝лe̲.close;
    }

    {
        my $両à丧𝐝лe̲ = open($е갢лe̲丧àìe̲, :bin);
        # https://github.com/Raku/old-issue-tracker/issues/5283
        tap-ok $両à丧𝐝лe̲.Supply(:size(1)),
          [<a b c d e>.map: { Buf[uint8].new(ord $_) }],
          :!live,
          "we can get bytes from a supply";
        $両à丧𝐝лe̲.close;
    }
}

# cleanup
unlink $е갢лe̲丧àìe̲;

# vim: expandtab shiftwidth=4
