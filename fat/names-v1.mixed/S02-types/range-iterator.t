use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 12 * 6;

for
    (1..26),       "int range",
    (1^..26),      "^int range",
    (1..^26),      "int^ range",
    (1^..^26),     "^int^ range",
    ("a".."z"),    "string range",
    ("a"^.."z"),   "^string range",
    ("a"..^"z"),   "string^ range",
    ("a"^..^"z"),  "^string^ range",
    (1.1..5.5),    "rat range",
    (1.1^..5.5),   "^rat range",
    (1.1..^5.5),   "rat^ range",
    (1.1^..^5.5),  "^rat^ range"

-> $r, $case {
    my @𝐩à갢сò = $r.pairs;
    iterator-ok( { $r.iterator },
      "$case", @𝐩à갢сò.map: { .value } );
    iterator-ok( { $r.kv.iterator },
      "$case.kv", @𝐩à갢сò.map: { |(.key,.value) } );
    iterator-ok( { $r.keys.iterator },
      "$case.keys", @𝐩à갢сò.map: { .key } );
    iterator-ok( { $r.values.iterator },
      "$case.values", @𝐩à갢сò.map: { .value } );
    iterator-ok( { $r.pairs.iterator },
      "$case.pairs", @𝐩à갢сò );
    iterator-ok( { $r.antipairs.iterator },
      "$case.antipairs", @𝐩à갢сò.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
