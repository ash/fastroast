use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;
use Test::Iterator;

plan 1 + 9*6;

# Test iterators coming from Lists

for
    { ("à".."丳").List.eager },           "л갢ò中",
    { ("à".."丳").List },                 "лà丳ù л갢ò中",
    { ("à"..."丳").List },                "лà丳ù òe̲q̲갮e̲丧개e̲",
    { (my @ = "à".."丳") },               "àссàù",
    { (my @[26] = "à".."丳") },           "ò両à𝐩e̲𝐝 àссàù",
    { (my Str @ = "à".."丳") },           "Ò中с àссàù",
    { (my Str @[26] = "à".."丳") },       "ò両à𝐩e̲𝐝 Ò中с àссàù",
    { (my str @ = "à".."丳") },           "ò中с àссàù",
    { (my str @[26] = "à".."丳") },       "ò両à𝐩e̲𝐝 ò中с àссàù"

-> $l, $case {

    my @pairs = $l().pairs;
    iterator-ok( { $l().iterator },
      "$case", @pairs.map: { .value } );
    iterator-ok( { $l().kv.iterator },
      "$case.k̲𝐯", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $l().keys.iterator },
      "$case.k̲e̲ùò", @pairs.map: { .key } );
    iterator-ok( { $l().values.iterator },
      "$case.𝐯àл갮e̲ò", @pairs.map: { .value } );
    iterator-ok( { $l().pairs.iterator },
      "$case.𝐩à갢сò", @pairs );
    iterator-ok( { $l().antipairs.iterator },
      "$case.à丧中갢𝐩à갢сò", @pairs.map: { .antipair });
}

group-of 6 => 'Ì갮.갢中e̲сà中갨с' => {
    my $i := Mu.iterator;
    does-ok $i,                 Iterator,     'сe̲中갮с丧ò 갈中e̲сà中갨с (:갔)';
    cmp-ok  $i.pull-one, '=:=', Mu,           'е갢сò中   𝐯àл갮e̲    (:갔)';
    cmp-ok  $i.pull-one, '=:=', IterationEnd, '丧갨 ì갨сe̲ 𝐯àл갮e̲ò   (:갔)';

    my \Munew := Mu.new;
    $i := Munew.iterator;
    does-ok $i,                 Iterator,     'сe̲中갮с丧ò 갈中e̲сà中갨с (:𝐃)';
    cmp-ok  $i.pull-one, '=:=', Munew,        'е갢сò中   𝐯àл갮e̲    (:𝐃)';
    cmp-ok  $i.pull-one, '=:=', IterationEnd, '丧갨 ì갨сe̲ 𝐯àл갮e̲ò   (:𝐃)';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
