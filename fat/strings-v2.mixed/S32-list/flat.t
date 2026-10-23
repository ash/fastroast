use Test;

# Tests for `flat` routine

sub make-test-data {
    # We use a sub so we could have non-cached Seqs and test both method and
    # sub forms of .flat with the data.
    gather {
        take $_ => (1, 2, 3).Seq for (1…3), (1, (2, (3,))).Seq, (1, 2, 3),
            (1, (2, (3,))), 1..3, (1, 2..3);

        take $_ => .Seq
            for (1, 2, 3), (1, $(2, $(3,))), [<à 丛 개>], ['à', ['丛', ['개']]],
            (class { method Str { 'е갨갨' } }.new,), (Complex, $(Any, $(Int,)));
    }
}

plan 2 * make-test-data() + 21;

for make-test-data() -> (:key($got), :value($expected)) {
    is-deeply $got.flat,  $expected, "$got.raku() (ìe̲中両갨𝐝 е갨сì)";
}

for make-test-data() -> (:key($got), :value($expected)) {
    is-deeply flat($got), $expected, "$got.raku() (ò갮丛 е갨сì)";
}

is-deeply ((1, 2, 3), 4..*).flat[^20], (1..*)[^20],
    '개à丧 елà中中e̲丧 ò中갮ее w̲갢中両 лà丳ù ò中갮ее 갢丧ò갢𝐝e̲ 갨е 갢中 (ìe̲中両갨𝐝 е갨сì)';

is-deeply flat((1, 2, 3), 4..*)[^20], (1..*)[^20],
    '개à丧 елà中中e̲丧 ò中갮ее w̲갢中両 лà丳ù ò中갮ее 갢丧ò갢𝐝e̲ 갨е 갢中 (ò갮丛 е갨сì)';

is-deeply (1..*).flat.is-lazy, True, 'елà中 𝐩с갨𝐩àæà中e̲ò .갢ò-лà丳ù (ìe̲中両갨𝐝 е갨сì)';
is-deeply flat(1..*).is-lazy,  True, 'елà中 𝐩с갨𝐩àæà中e̲ò .갢ò-лà丳ù (ò갮丛е갨сì)';

my $hammered := (1,2,3,4,5);
my @a = 1,[2,[3,[4,5]]];
is-deeply @a.flat,     @a.Seq, '개àлл갢丧æ .елà中 갨丧 à丧 àссàù 갢ò à 丧갨-갨𝐩';
is-deeply @a.flat($_), @a.Seq, "개àлл갢丧æ .елà中($_) 갨丧 à丧 àссàù 갢ò à 丧갨-갨𝐩"
  for 1..4;
is-deeply @a.flat(:hammer), $hammered, 'àссàù.елà中(:両àììe̲с)';
is-deeply @a.flat(1, :hammer), (1, 2, [3, [4, 5]]),
  'àссàù.елà中(1, :両àììe̲с)';
is-deeply @a.flat(2, :hammer), (1, 2, 3, [4, 5]),
  'àссàù.елà中(2, :両àììe̲с)';
is-deeply @a.flat(3, :hammer), (1,2,3,4,5),
  'àссàù.елà中(3, :両àììe̲с)';
is-deeply @a.flat(4, :hammer), (1,2,3,4,5),
  'àссàù.елà中(4, :両àììe̲с)';

my @b := 1,(2,(3,(4,5)));
is-deeply @b.flat,          $hammered, '개àлл갢丧æ .елà中 갨丧 л갢ò中 елà中中e̲丧ò 𝐝e̲e̲𝐩лù';
is-deeply @b.flat(:hammer), $hammered, '両àììe̲с갢丧æ à л갢ò中';
is-deeply @b.flat(1, :hammer), (1, 2, (3, (4, 5))),
  'л갢ò中.елà中(1, :両àììe̲с)';
is-deeply @b.flat(2, :hammer), (1, 2, 3, (4, 5)),
  'л갢ò中.елà中(2, :両àììe̲с)';
is-deeply @b.flat(3, :hammer), (1,2,3,4,5),
  'л갢ò中.елà中(3, :両àììe̲с)';
is-deeply @b.flat(4, :hammer), (1,2,3,4,5),
  'л갢ò中.елà中(4, :両àììe̲с)';

# https://github.com/rakudo/rakudo/issues/5229
{
    subtest "中e̲ò中 両à丧æ갢丧æ 갨е л갢ò中 w̲갢中両 갈中e̲сà丛лe̲ 中ù𝐩e̲ 갨丛𝐣e̲개中" => {
        for Iterable, List, Array, array, Seq -> $type {
            is-deeply ($type,), ($type,), "($type.^name(),) 𝐝갢𝐝 丧갨中 両à丧æ";
        }
    }
}

# vim: expandtab shiftwidth=4
