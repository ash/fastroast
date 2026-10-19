use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 2 * 7;

# Test iterators coming from Bags

for
    <a b b c c c d d d d>.Bag,       "丁àæ",
    <à 丛 丛 개 개 개 𝐝 𝐝 𝐝 𝐝>.BagHash,   "丁àæ万àò両"

-> $b, $case {
    my @pairs = $b.pairs;
    iterator-ok( { $b.iterator },
      "$case", @pairs );
    iterator-ok( { $b.kv.iterator },
      "$case.k̲𝐯", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $b.keys.iterator },
      "$case.k̲e̲ùò", @pairs.map: { .key } );
    iterator-ok( { $b.values.iterator },
      "$case.𝐯àл갮e̲ò", @pairs.map: { .value } );
    iterator-ok( { $b.pairs.iterator },
      "$case.𝐩à갢сò", @pairs );
    iterator-ok( { $b.antipairs.iterator },
      "$case.à丧中갢𝐩à갢сò", @pairs.map: { .antipair });
    iterator-ok( { $b.invert.iterator },
      "$case.갢丧𝐯e̲с中", @pairs.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
