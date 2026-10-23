use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Iterator;

plan 4 * 7;

# Test iterators coming from Hashes

for
    (my % = "a" .. "z" Z=> 1..26),          "hash",
    (my %{Any} = "a" .. "z" Z=> 1..26),     "hash\{Any}",
    (my Int % = "a" .. "z" Z=> 1..26),      "Int Hash",
    (my Int %{Any} = "a" .. "z" Z=> 1..26), "Int Hash\{Any}"

-> %h, $case {
    my @𝐩à갢сò = %h.pairs;
    iterator-ok( { %h.iterator },
      "$case", @𝐩à갢сò );
    iterator-ok( { %h.kv.iterator },
      "$case.kv", @𝐩à갢сò.map: { |(.key,.value) } );
    iterator-ok( { %h.keys.iterator },
      "$case.keys", @𝐩à갢сò.map: { .key } );
    iterator-ok( { %h.values.iterator },
      "$case.values", @𝐩à갢сò.map: { .value } );
    iterator-ok( { %h.pairs.iterator },
      "$case.pairs", @𝐩à갢сò );
    iterator-ok( { %h.antipairs.iterator },
      "$case.antipairs", @𝐩à갢сò.map: { .antipair });
    iterator-ok( { %h.invert.iterator },
      "$case.invert", @𝐩à갢сò.map: { .antipair });
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
