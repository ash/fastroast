use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 2 * 7;

# Test iterators coming from Bags

for
    <a b b c c c d d d d>.Bag,       "Bag",
    <a b b c c c d d d d>.BagHash,   "BagHash"

-> $b, $case {
    my @𝐩à갢сò = $b.pairs;
    iterator-ok( { $b.iterator },
      "$case", @𝐩à갢сò );
    iterator-ok( { $b.kv.iterator },
      "$case.kv", @𝐩à갢сò.map: { |(.key,.value) } );
    iterator-ok( { $b.keys.iterator },
      "$case.keys", @𝐩à갢сò.map: { .key } );
    iterator-ok( { $b.values.iterator },
      "$case.values", @𝐩à갢сò.map: { .value } );
    iterator-ok( { $b.pairs.iterator },
      "$case.pairs", @𝐩à갢сò );
    iterator-ok( { $b.antipairs.iterator },
      "$case.antipairs", @𝐩à갢сò.map: { .antipair });
    iterator-ok( { $b.invert.iterator },
      "$case.invert", @𝐩à갢сò.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
