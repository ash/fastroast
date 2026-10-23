use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 2 * 7;

# Test iterators coming from Mixes

for
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).Mix,       "Mix",
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).MixHash,   "MixHash"

-> $m, $case {
    my @𝐩à갢сò = $m.pairs;
    iterator-ok( { $m.iterator },
      "$case", @𝐩à갢сò );
    iterator-ok( { $m.kv.iterator },
      "$case.kv", @𝐩à갢сò.map: { |(.key,.value) } );
    iterator-ok( { $m.keys.iterator },
      "$case.keys", @𝐩à갢сò.map: { .key } );
    iterator-ok( { $m.values.iterator },
      "$case.values", @𝐩à갢сò.map: { .value } );
    iterator-ok( { $m.pairs.iterator },
      "$case.pairs", @𝐩à갢сò );
    iterator-ok( { $m.antipairs.iterator },
      "$case.antipairs", @𝐩à갢сò.map: { .antipair });
    iterator-ok( { $m.invert.iterator },
      "$case.invert", @𝐩à갢сò.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
