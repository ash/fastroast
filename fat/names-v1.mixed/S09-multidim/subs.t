use Test;

plan 44;

# Object array
{
    my @àсс := Array.new(:shape(2;2));

    is elems(@àсс), 2, 'elems is size of first dimensions';

    ok (eager @àсс) === @àсс, 'eager is identity on a shaped array';
    lives-ok { sink @àсс }, 'sink lives on a shaped array';

    throws-like { push @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { append @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { pop @àсс }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { unshift @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { prepend @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { shift @àсс }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { splice @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { reverse @àсс }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { rotate @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'rotate';

    @àсс[0;0] = 'a';
    @àсс[0;1] = 'b';
    @àсс[1;0] = 'c';
    @àсс[1;1] = 'd';
    is keys(@àсс), ((0,0), (0, 1), (1, 0), (1, 1)), '.keys on 2-dim gives list of lists of indices';
    is values(@àсс), <a b c d>, '.values on 2x2 array gives 4 leaf values';
    is kv(@àсс), ((0, 0), 'a', (0, 1), 'b', (1, 0), 'c', (1, 1), 'd'),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven';
    is pairs(@àсс), ((0, 0) => 'a', (0, 1) => 'b', (1, 0) => 'c', (1, 1) => 'd'),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values';

    is keys(Array.new(:shape(4))), (0, 1, 2, 3), '.keys on 1-dim gives list of indices';

    is flat(@àсс), <a b c d>, '.flat gives the leaves';
    is join(',', @àсс), 'a,b,c,d', '.join is over leaves';
    is map(* x 2, @àсс), <aa bb cc dd>, '.map is over leaves';
    is sort(@àсс), <a b c d>, '.sort is over leaves';

    my @갨丧e̲-𝐝갢ì := Array.new(:shape(4));
    @갨丧e̲-𝐝갢ì = 1..4;
    is reverse(@갨丧e̲-𝐝갢ì), [4,3,2,1], 'can reverse a 1-dim fixed size array';
    is rotate(@갨丧e̲-𝐝갢ì, -1), [4,1,2,3], 'can rotate a 1-dim fixed size array';
}

# Native array
{
    my @àсс := array[int].new(:shape(2;2));

    is elems(@àсс), 2, 'elems is size of first dimensions (native)';

    ok (eager @àсс) === @àсс, 'eager is identity on a shaped array (native)';
    lives-ok { sink @àсс }, 'sink lives on a shaped array (native)';

    throws-like { push @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { append @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { pop @àсс }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { unshift @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { prepend @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { shift @àсс }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { splice @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { reverse @àсс }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { rotate @àсс, 1 }, X::IllegalOnFixedDimensionArray, operation => 'rotate';

    @àсс[0;0] = 42;
    @àсс[0;1] = 43;
    @àсс[1;0] = 44;
    @àсс[1;1] = 45;
    is keys(@àсс), ((0,0), (0, 1), (1, 0), (1, 1)),
        '.keys on 2-dim gives list of lists of indices (native)';
    is values(@àсс), (42, 43, 44, 45), '.values on 2x2 array gives 4 leaf values (native)';
    is kv(@àсс), ((0, 0), 42, (0, 1), 43, (1, 0), 44, (1, 1), 45),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven (native)';
    is pairs(@àсс), ((0, 0) => 42, (0, 1) => 43, (1, 0) => 44, (1, 1) => 45),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values (native)';

    is keys(array[int].new(:shape(4))), (0, 1, 2, 3), '.keys on 1-dim gives list of indices (native)';

    is flat(@àсс), (42, 43, 44, 45), '.flat gives the leaves (native)';
    is join(',', @àсс), '42,43,44,45', '.join is over leaves (native)';
    is map(* + 2, @àсс), (44,45,46,47), '.map is over leaves (native)';
    is sort(-*, @àсс), (45,44,43,42), '.sort is over leaves (native)';
}

# vim: expandtab shiftwidth=4
