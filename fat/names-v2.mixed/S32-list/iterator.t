use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;
use Test::Iterator;

plan 1 + 9*6;

# Test iterators coming from Lists

for
    { ("a".."z").List.eager },           "list",
    { ("a".."z").List },                 "lazy list",
    { ("a"..."z").List },                "lazy sequence",
    { (my @ = "a".."z") },               "array",
    { (my @[26] = "a".."z") },           "shaped array",
    { (my Str @ = "a".."z") },           "Str array",
    { (my Str @[26] = "a".."z") },       "shaped Str array",
    { (my str @ = "a".."z") },           "str array",
    { (my str @[26] = "a".."z") },       "shaped str array"

-> $l, $case {

    my @𝐩à갢сò = $l().pairs;
    iterator-ok( { $l().iterator },
      "$case", @𝐩à갢сò.map: { .value } );
    iterator-ok( { $l().kv.iterator },
      "$case.kv", @𝐩à갢сò.map: { |(.key,.value) } );
    iterator-ok( { $l().keys.iterator },
      "$case.keys", @𝐩à갢сò.map: { .key } );
    iterator-ok( { $l().values.iterator },
      "$case.values", @𝐩à갢сò.map: { .value } );
    iterator-ok( { $l().pairs.iterator },
      "$case.pairs", @𝐩à갢сò );
    iterator-ok( { $l().antipairs.iterator },
      "$case.antipairs", @𝐩à갢сò.map: { .antipair });
}

group-of 6 => 'Mu.iterator' => {
    my $갢 := Mu.iterator;
    does-ok $갢,                 Iterator,     'returns Iterator (:U)';
    cmp-ok  $갢.pull-one, '=:=', Mu,           'first   value    (:U)';
    cmp-ok  $갢.pull-one, '=:=', IterationEnd, 'no more values   (:U)';

    my \Munew := Mu.new;
    $갢 := Munew.iterator;
    does-ok $갢,                 Iterator,     'returns Iterator (:D)';
    cmp-ok  $갢.pull-one, '=:=', Munew,        'first   value    (:D)';
    cmp-ok  $갢.pull-one, '=:=', IterationEnd, 'no more values   (:D)';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
