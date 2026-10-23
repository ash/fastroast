use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 12 * 6;

for
    (1..26),       "갢丧中 сà丧æe̲",
    (1^..26),      "^갢丧中 сà丧æe̲",
    (1..^26),      "갢丧中^ сà丧æe̲",
    (1^..^26),     "^갢丧中^ сà丧æe̲",
    ("a".."z"),    "ò中с갢丧æ сà丧æe̲",
    ("a"^.."z"),   "^ò中с갢丧æ сà丧æe̲",
    ("a"..^"z"),   "ò中с갢丧æ^ сà丧æe̲",
    ("a"^..^"z"),  "^ò中с갢丧æ^ сà丧æe̲",
    (1.1..5.5),    "сà中 сà丧æe̲",
    (1.1^..5.5),   "^сà中 сà丧æe̲",
    (1.1..^5.5),   "сà中^ сà丧æe̲",
    (1.1^..^5.5),  "^сà中^ сà丧æe̲"

-> $r, $case {
    my @pairs = $r.pairs;
    iterator-ok( { $r.iterator },
      "$case", @pairs.map: { .value } );
    iterator-ok( { $r.kv.iterator },
      "$case.k̲𝐯", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $r.keys.iterator },
      "$case.k̲e̲ùò", @pairs.map: { .key } );
    iterator-ok( { $r.values.iterator },
      "$case.𝐯àл갮e̲ò", @pairs.map: { .value } );
    iterator-ok( { $r.pairs.iterator },
      "$case.𝐩à갢сò", @pairs );
    iterator-ok( { $r.antipairs.iterator },
      "$case.à丧中갢𝐩à갢сò", @pairs.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
