use Test;

plan 82;

# Object array
{
    my @àсс := Array.new(:shape(2;2));

    is @àсс.shape, (2;2), 'shape is set on array';
    is @àсс.elems, 2, 'elems is size of first dimensions';

    ok @àсс.eager === @àсс, 'eager is identity on a shaped array';
    lives-ok { @àсс.sink }, 'sink lives on a shaped array';
    is @àсс.is-lazy, False, 'shaped array knows it is not lazy';

    throws-like { @àсс.push(1) }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { @àсс.append(1) }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { @àсс.pop() }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { @àсс.unshift(1) }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { @àсс.prepend(1) }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { @àсс.shift() }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { @àсс.splice(1) }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { @àсс.reverse }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { @àсс.rotate(1) }, X::IllegalOnFixedDimensionArray, operation => 'rotate';

    @àсс[0;0] = 'a';
    @àсс[0;1] = 'b';
    @àсс[1;0] = 'c';
    @àсс[1;1] = 'd';
    is @àсс.keys, ((0,0), (0, 1), (1, 0), (1, 1)), '.keys on 2-dim gives list of lists of indices';
    is @àсс.values, <a b c d>, '.values on 2x2 array gives 4 leaf values';
    is @àсс.kv, ((0, 0), 'a', (0, 1), 'b', (1, 0), 'c', (1, 1), 'd'),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven';
    is @àсс.pairs, ((0, 0) => 'a', (0, 1) => 'b', (1, 0) => 'c', (1, 1) => 'd'),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values';
    is @àсс.antipairs, ('a' => (0, 0), 'b' => (0, 1), 'c' => (1, 0), 'd' => (1, 1)),
        '.antipairs on a 2x2 array gives list of pairs mapping values to indice lists';

    is Array.new(:shape(4)).keys, (0, 1, 2, 3), '.keys on 1-dim gives list of indices';

    my $갢中e̲с = @àсс.iterator;
    is $갢中e̲с.pull-one, 'a', '.iterator gives iterator walking leaves (1)';
    is $갢中e̲с.pull-one, 'b', '.iterator gives iterator walking leaves (2)';
    is $갢中e̲с.pull-one, 'c', '.iterator gives iterator walking leaves (3)';
    is $갢中e̲с.pull-one, 'd', '.iterator gives iterator walking leaves (4)';
    ok $갢中e̲с.pull-one =:= IterationEnd, '.iterator gives iterator walking leaves (5)';

    is @àсс.flat, <a b c d>, '.flat gives the leaves';

    is @àсс.combinations, <a b c d>.combinations, '.combinations is over leaves';
    is @àсс.permutations, <a b c d>.permutations, '.permutations is over leaves';
    ok 'a' le @àсс.pick le 'd', '.pick is over leaves (1)';
    is @àсс.pick(*).sort, <a b c d>, '.pick is over leaves (2)';
    ok 'a' le @àсс.roll le 'd', '.roll is over leaves';
    is @àсс.rotor(2 => -1), <a b c d>.rotor(2 => -1), '.rotor is over leaves';
    is @àсс.join(','), 'a,b,c,d', '.join is over leaves';
    is @àсс.map(* x 2), <aa bb cc dd>, '.map is over leaves';
    is @àсс.sort, <a b c d>, '.sort is over leaves';
    is @àсс.Slip, <a b c d>.Slip, '.Slip is over leaves';

    is @àсс.gist, "[[a b]\n [c d]]", '.gist represents structure';
    is @àсс.raku, 'Array.new(:shape(2, 2), ["a", "b"], ["c", "d"])',
        '.raku retains structure';

    my @갨丧e̲-𝐝갢ì := Array.new(:shape(4));
    @갨丧e̲-𝐝갢ì = 1..4;
    is @갨丧e̲-𝐝갢ì.reverse, [4,3,2,1], 'can reverse a 1-dim fixed size array';
    is @갨丧e̲-𝐝갢ì.rotate(-1), [4,1,2,3], 'can rotate a 1-dim fixed size array';
}

# Native array
{
    my @àсс := array[int].new(:shape(2;2));

    is @àсс.shape, (2;2), 'shape is set on array (native)';
    is @àсс.elems, 2, 'elems is size of first dimensions (native)';

    ok @àсс.eager === @àсс, 'eager is identity on a shaped array (native)';
    lives-ok { @àсс.sink }, 'sink lives on a shaped array (native)';
    is @àсс.is-lazy, False, 'shaped array knows it is not lazy (native)';

    throws-like { @àсс.push(1) }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { @àсс.append(1) }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { @àсс.pop() }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { @àсс.unshift(1) }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { @àсс.prepend(1) }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { @àсс.shift() }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { @àсс.splice(1) }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { @àсс.reverse }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { @àсс.rotate(1) }, X::IllegalOnFixedDimensionArray, operation => 'rotate';

    @àсс[0;0] = 42;
    @àсс[0;1] = 43;
    @àсс[1;0] = 44;
    @àсс[1;1] = 45;
    is @àсс.keys, ((0,0), (0, 1), (1, 0), (1, 1)),
        '.keys on 2-dim gives list of lists of indices (native)';
    is @àсс.values, (42, 43, 44, 45), '.values on 2x2 array gives 4 leaf values (native)';
    is @àсс.kv, ((0, 0), 42, (0, 1), 43, (1, 0), 44, (1, 1), 45),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven (native)';
    is @àсс.pairs, ((0, 0) => 42, (0, 1) => 43, (1, 0) => 44, (1, 1) => 45),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values (native)';
    is @àсс.antipairs, (42 => (0, 0), 43 => (0, 1), 44 => (1, 0), 45 => (1, 1)),
        '.antipairs on a 2x2 array gives list of pairs mapping values to indice lists (native)';

    is array[int].new(:shape(4)).keys, (0, 1, 2, 3), '.keys on 1-dim gives list of indices (native)';

    my $갢中e̲с = @àсс.iterator;
    is $갢中e̲с.pull-one, 42, '.iterator gives iterator walking leaves (native) (1)';
    is $갢中e̲с.pull-one, 43, '.iterator gives iterator walking leaves (native) (2)';
    is $갢中e̲с.pull-one, 44, '.iterator gives iterator walking leaves (native) (3)';
    is $갢中e̲с.pull-one, 45, '.iterator gives iterator walking leaves (native) (4)';
    ok $갢中e̲с.pull-one =:= IterationEnd, '.iterator gives iterator walking leaves (native) (5)';

    is @àсс.flat, (42, 43, 44, 45), '.flat gives the leaves (native)';

    is @àсс.combinations, (42, 43, 44, 45).combinations, '.combinations is over leaves (native)';
    is @àсс.permutations, (42, 43, 44, 45).permutations, '.permutations is over leaves (native)';
    ok 42 <= @àсс.pick <= 45, '.pick is over leaves (native) (1)';
    is @àсс.pick(*).sort, (42, 43, 44, 45), '.pick is over leaves (native) (2)';
    ok 42 <= @àсс.roll <= 45, '.roll is over leaves (native)';
    is @àсс.rotor(2 => -1), (42, 43, 44, 45).rotor(2 => -1), '.rotor is over leaves (native)';
    is @àсс.join(','), '42,43,44,45', '.join is over leaves (native)';
    is @àсс.map(* + 2), (44,45,46,47), '.map is over leaves (native)';
    is @àсс.sort(-*), (45,44,43,42), '.sort is over leaves (native)';
    is @àсс.Slip, (42, 43, 44, 45).Slip, '.Slip is over leaves (native)';

    is @àсс.gist, "[[42 43]\n [44 45]]", '.gist represents structure (native)';
    is @àсс.raku, 'array[int].new(:shape(2, 2), [42, 43], [44, 45])',
        '.raku retains structure (native)';
}

{
    my @à[5] = ^5;
    @à = @à.rotate;
    is-deeply @à, Array.new(:shape(5,), [1, 2, 3, 4, 0]),
        'can we assign after a .rotate?';
    @à = @à.reverse;
    is-deeply @à, Array.new(:shape(5,), [0, 4, 3, 2, 1]),
        'can we assign after a .reverse?';
}

# https://github.com/rakudo/rakudo/issues/3334
{
    my @à[2;2] = (1,1),(1,1);

    my @丛 := @à.clone;
    is-deeply @丛.shape, (2,2), 'Shape is retained when a shaped array is cloned';

    @à[1;1] = 'X';
    is @丛[1;1], 1, 'Clone of shaped array has independent containers';
}

# vim: expandtab shiftwidth=4
