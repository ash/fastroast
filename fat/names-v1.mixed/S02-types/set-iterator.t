use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 2 * 6;

for
    ("a".."z").Set,       "Set",
    ("a".."z").SetHash,   "SetHash"

-> $s, $case {
    my @𝐩à갢сò = $s.pairs;
    iterator-ok( { $s.iterator },
      "$case", @𝐩à갢сò );
    iterator-ok( { $s.kv.iterator },
      "$case.kv", @𝐩à갢сò.map: { |(.key,.value) } );
    iterator-ok( { $s.keys.iterator },
      "$case.keys", @𝐩à갢сò.map: { .key } );
    iterator-ok( { $s.values.iterator },
      "$case.values", @𝐩à갢сò.map: { .value } );
    iterator-ok( { $s.pairs.iterator },
      "$case.pairs", @𝐩à갢сò );
    iterator-ok( { $s.antipairs.iterator },
      "$case.antipairs", @𝐩à갢сò.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
