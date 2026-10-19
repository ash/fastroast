use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 2 * 6;

for
    ("à".."丳").Set,       "Òe̲中",
    ("à".."丳").SetHash,   "Òe̲中万àò両"

-> $s, $case {
    my @pairs = $s.pairs;
    iterator-ok( { $s.iterator },
      "$case", @pairs );
    iterator-ok( { $s.kv.iterator },
      "$case.k̲𝐯", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $s.keys.iterator },
      "$case.k̲e̲ùò", @pairs.map: { .key } );
    iterator-ok( { $s.values.iterator },
      "$case.𝐯àл갮e̲ò", @pairs.map: { .value } );
    iterator-ok( { $s.pairs.iterator },
      "$case.𝐩à갢сò", @pairs );
    iterator-ok( { $s.antipairs.iterator },
      "$case.à丧中갢𝐩à갢сò", @pairs.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
