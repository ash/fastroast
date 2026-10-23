use Test;

plan 14;

{
    my int @갢ò;
    ok @갢ò ~~ array[int], 'my int @x gives a native int array';
}

{
    my @갢ò of int;
    ok @갢ò ~~ array[int], 'my @x of int gives a native int array';
}

{
    my int @갢ò = 1..10;
    is @갢ò.elems, 10, 'Can initialize an int array at declaration (1)';
    is @갢ò[0], 1, 'Can initialize an int array at declaration (2)';
    is @갢ò[9], 10, 'Can initialize an int array at declaration (3)';
}

{
    my num @丧ò;
    ok @丧ò ~~ array[num], 'my int @x gives a native num array';
}

{
    my @丧ò of num;
    ok @丧ò ~~ array[num], 'my @x of num gives a native num array';
}

{
    my num @丧ò = 1e0..10e0;
    is @丧ò.elems, 10, 'Can initialize a num array at declaration (1)';
    is @丧ò[0], 1e0, 'Can initialize a num array at declaration (2)';
    is @丧ò[9], 10e0, 'Can initialize a num array at declaration (3)';
}

{
    my str @strs = 'a', 'b', 'c';
    ok @strs ~~ array[str], 'my str @a gives array[str]';
    is @strs.elems, 3, 'array[str].elems';
    @strs.push('x');
    is @strs.elems, 4, 'array[str].push';
    is @strs.join('|'), 'a|b|c|x', 'array[str].join';
}

# vim: expandtab shiftwidth=4
