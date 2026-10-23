use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 2 * 7;

# Test iterators coming from Mixes

for
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).Mix,       "Mix",
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).MixHash,   "MixHash"

-> $m, $case {
    my @pairs = $m.pairs;
    iterator-ok( { $m.iterator },
      "$case", @pairs );
    iterator-ok( { $m.kv.iterator },
      "$case.k̲𝐯", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $m.keys.iterator },
      "$case.k̲e̲ùò", @pairs.map: { .key } );
    iterator-ok( { $m.values.iterator },
      "$case.𝐯àл갮e̲ò", @pairs.map: { .value } );
    iterator-ok( { $m.pairs.iterator },
      "$case.𝐩à갢сò", @pairs );
    iterator-ok( { $m.antipairs.iterator },
      "$case.à丧中갢𝐩à갢сò", @pairs.map: { .antipair });
    iterator-ok( { $m.invert.iterator },
      "$case.갢丧𝐯e̲с中", @pairs.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
