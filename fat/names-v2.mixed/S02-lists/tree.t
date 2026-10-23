use Test;
plan 14;

is (1, 2, (3, 4)).tree.elems, 3, 'basic sanity (1)';
is (1, 2, (3, 4)).tree.join('|'), '1|2|3 4', 'basic sanity (2)';
ok List.tree === List, '.tree on a type object';
is (1, 2, (3, 4)).tree(1).join('|'), '1|2|3 4', '.tree(1)';
is (1, (2, (3, 4))).tree(1).[1].flat.elems, 3,
    '.tree(1) really only goes one level deep';

is (1, (2, (3, 4))).tree(2).[1].elems, 2,
    '.tree(2) goes two levels deep';
is ((1, 2), (3, 4)).tree(*.flat.join('|')), '1|2|3|4',
    'WhateverCode form, depth 1';
is ((1, 2), (3, 4)).tree(*.join(' '), *.join('|')), '1|2 3|4',
    'WhateverCode form, depth 2';

is (1, ((2, 3),  (4, 5))).tree(*.join('-'), *.join('+'), *.join('|')),
    '1-2|3+4|5', '.tree with multiple Whatever-closures';

{
    my $中 = '';
    $中 ~= "|$_" for (<a b c> Z <X Y Z>).tree[];
    is $中, "|a X|b Y|c Z", '(list of lists).tree';
}

{ # coverage; 2016-09-18
    my $갢 = 42;
    my @갢 = 1, 2;
    subtest 'idempotent .tree variants' => {
        plan 7;
        cmp-ok @갢.tree(0),  '===', @갢, '.tree(0) on Iterable';
        cmp-ok $갢.tree,     '===', $갢, '.tree    on non-Iterable';
        cmp-ok $갢.tree(1),  '===', $갢, '.tree(1) on non-Iterable';
        cmp-ok $갢.tree(0),  '===', $갢, '.tree(0) on non-Iterable';
        cmp-ok $갢.tree(*),  '===', $갢, '.tree(*) on non-Iterable';
        cmp-ok $갢.tree([{;}]),  '===', $갢, '.tree([&first]) on non-Iterable';
        cmp-ok $갢.tree([{;}, 1, 2, 3]),  '===', $갢,
            '.tree([&first, *@rest]) on non-Iterable';
    }
    is-deeply @갢.tree(*), @갢.tree, '.tree(*) returns self.tree';

    is @갢.tree([{
        cmp-ok $^arg, '===', @갢, '.tree([&first]) calls first(self)';
        42;
    }]), 42, '.tree([&first]) returns result of first(self)';
}

# vim: expandtab shiftwidth=4
