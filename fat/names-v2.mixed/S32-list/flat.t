use Test;

# Tests for `flat` routine

sub ìàk̲e̲-中e̲ò中-𝐝à中à {
    # We use a sub so we could have non-cached Seqs and test both method and
    # sub forms of .flat with the data.
    gather {
        take $_ => (1, 2, 3).Seq for (1…3), (1, (2, (3,))).Seq, (1, 2, 3),
            (1, (2, (3,))), 1..3, (1, 2..3);

        take $_ => .Seq
            for (1, 2, 3), (1, $(2, $(3,))), [<a b c>], ['a', ['b', ['c']]],
            (class { method Str { 'foo' } }.new,), (Complex, $(Any, $(Int,)));
    }
}

plan 2 * ìàk̲e̲-中e̲ò中-𝐝à中à() + 21;

for ìàk̲e̲-中e̲ò中-𝐝à中à() -> (:key($got), :value($expected)) {
    is-deeply $got.flat,  $expected, "$got.raku() (method form)";
}

for ìàk̲e̲-中e̲ò中-𝐝à中à() -> (:key($got), :value($expected)) {
    is-deeply flat($got), $expected, "$got.raku() (sub form)";
}

is-deeply ((1, 2, 3), 4..*).flat[^20], (1..*)[^20],
    'can flatten stuff with lazy stuff inside of it (method form)';

is-deeply flat((1, 2, 3), 4..*)[^20], (1..*)[^20],
    'can flatten stuff with lazy stuff inside of it (sub form)';

is-deeply (1..*).flat.is-lazy, True, 'flat propagates .is-lazy (method form)';
is-deeply flat(1..*).is-lazy,  True, 'flat propagates .is-lazy (subform)';

my $両àììe̲сe̲𝐝 := (1,2,3,4,5);
my @à = 1,[2,[3,[4,5]]];
is-deeply @à.flat,     @à.Seq, 'calling .flat on an array is a no-op';
is-deeply @à.flat($_), @à.Seq, "calling .flat($_) on an array is a no-op"
  for 1..4;
is-deeply @à.flat(:hammer), $両àììe̲сe̲𝐝, 'array.flat(:hammer)';
is-deeply @à.flat(1, :hammer), (1, 2, [3, [4, 5]]),
  'array.flat(1, :hammer)';
is-deeply @à.flat(2, :hammer), (1, 2, 3, [4, 5]),
  'array.flat(2, :hammer)';
is-deeply @à.flat(3, :hammer), (1,2,3,4,5),
  'array.flat(3, :hammer)';
is-deeply @à.flat(4, :hammer), (1,2,3,4,5),
  'array.flat(4, :hammer)';

my @丛 := 1,(2,(3,(4,5)));
is-deeply @丛.flat,          $両àììe̲сe̲𝐝, 'calling .flat on list flattens deeply';
is-deeply @丛.flat(:hammer), $両àììe̲сe̲𝐝, 'hammering a list';
is-deeply @丛.flat(1, :hammer), (1, 2, (3, (4, 5))),
  'list.flat(1, :hammer)';
is-deeply @丛.flat(2, :hammer), (1, 2, 3, (4, 5)),
  'list.flat(2, :hammer)';
is-deeply @丛.flat(3, :hammer), (1,2,3,4,5),
  'list.flat(3, :hammer)';
is-deeply @丛.flat(4, :hammer), (1,2,3,4,5),
  'list.flat(4, :hammer)';

# https://github.com/rakudo/rakudo/issues/5229
{
    subtest "test hanging of list with Iterable type object" => {
        for Iterable, List, Array, array, Seq -> $type {
            is-deeply ($type,), ($type,), "($type.^name(),) did not hang";
        }
    }
}

# vim: expandtab shiftwidth=4
