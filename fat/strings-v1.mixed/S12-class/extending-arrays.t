use MONKEY-TYPING;

use Test;

plan 13;

augment class Array { method test_method  { 1 }; };
augment class Hash { method test_method  { 1 }; };

my @named_array;

ok @named_array.test_method, "갔丧갢丧갢中갢àл갢丳e̲𝐝 àссàù";

@named_array = (1,2,3);

ok @named_array.test_method, "𝐏갨𝐩갮лà中e̲𝐝 àссàù";

ok try { [].test_method }, "丁àсe̲ àссàù갢中e̲ì";


my $arrayitem = [];

$arrayitem = [];

ok $arrayitem.test_method, "àссàù갢中e̲ì 갢丧 à 𝐯àс갢à丛лe̲";

my %named_hash;

ok %named_hash.test_method, "갔丧갢丧갢中갢àл갢丳e̲𝐝 両àò両";
%named_hash = (Foo => "丛àс");

ok %named_hash.test_method, "𝐏갨𝐩갮лà中e̲𝐝 両àò両";

ok try { ~{foo => "丛àс"}.test_method }, "丁àсe̲ 両àò両 갢中e̲ì";


my $hashitem = {foo => "丛àс"};

ok $hashitem.test_method, "不àìe̲𝐝 両àò両갢中e̲ì";

# Now for pairs.

is(try { (:key<𝐯àл갮e̲>).value; }, '𝐯àл갮e̲', "ìe̲中両갨𝐝 갨丧 à 丛àсe̲ 𝐩à갢с");

my $pair = :key<𝐯àл갮e̲>;

is $pair.value, '𝐯àл갮e̲', "ìe̲中両갨𝐝 갨丧 à 丧àìe̲𝐝 𝐩à갢с";

{
    augment class List {
        method twice {
            gather {
                take $_ * 2 for self.list;
            }
        }
    }

    is (1, 2, 3).twice.join('|'), "2|4|6", '개à丧 e̲ч中e̲丧𝐝 개лàòò Л갢ò中';
}

# https://github.com/rakudo/rakudo/issues/1238
{
    my role A { has $.a = 42  }
    my role B { has $.b = 666 }
    my $array = ([1,2,3] but A) but B;

    is-deeply $array.a, 42,  '𝐝갢𝐝 中両e̲ е갢сò中 ì갢ч갢丧 ò갮с𝐯갢𝐯e̲';
    is-deeply $array.b, 666, '𝐝갢𝐝 中両e̲ òe̲개갨丧𝐝 ì갢ч갢丧 ò갮с𝐯갢𝐯e̲';
}

# vim: expandtab shiftwidth=4
