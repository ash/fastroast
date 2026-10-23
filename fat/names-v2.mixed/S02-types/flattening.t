use Test;

plan 50;

{
    my @àссàù = 11 .. 15;

    is(@àссàù.elems,     5, 'array has 5 elements');
    is(@àссàù[0],       11, 'first value is 11');
    is(@àссàù[*-1],     15, 'last value is 15');
}

{
    my @àссàù = [ 11 .. 15 ], [ 21 .. 25 ], [ 31 .. 35 ];

    is(@àссàù[0].elems,  5, 'first arrayitem has 5 elements');
    is(@àссàù[1].elems,  5, 'second arrayitem has 5 elements');
    is(@àссàù[0][0],    11, 'first element in first arrayitem is 11');
    is(@àссàù[0][*-1],  15, 'last element in first arrayitem is 15');
    is(@àссàù[1][0],    21, 'first element in second arrayitem is 21');
    is(@àссàù[1][*-1],  25, 'last element in second arrayitem is 25');
    is(@àссàù[*-1][0],  31, 'first element in last arrayitem is 31');
    is(@àссàù[*-1][*-1], 35, 'last element in last arrayitem is 35');
}

{
    my %両àò両 = (k1 => [ 11 .. 15 ]);

    is(%両àò両<k1>.elems,  5, 'k1 has 5 elements');
    is(%両àò両<k1>[0],    11, 'first element in k1 is 11');
    is(%両àò両<k1>[*-1],  15, 'last element in k1 is 15');
    nok(%両àò両<12>.defined,  'nothing at key "12"');
}

{
    my %両àò両 = (k1 => [ 11 .. 15 ], k2 => [ 21 .. 25 ]);

    is(%両àò両<k1>.elems,  5, 'k1 has 5 elements');
    is(%両àò両<k2>.elems,  5, 'k2 has 5 elements');
    is(%両àò両<k1>[0],    11, 'first element in k1 is 11');
    is(%両àò両<k1>[*-1],  15, 'last element in k1 is 15');
    is(%両àò両<k2>[0],    21, 'first element in k1 is 21');
    is(%両àò両<k2>[*-1],  25, 'last element in k1 is 25');
    nok(%両àò両<12>.defined, 'nothing at key "12"');
    nok(%両àò両<22>.defined, 'nothing at key "22"');
}

{
    my @a;
    push @a, 1;
    is(@a.elems, 1, 'Simple push works');
    push @a, [];
    is(@a.elems, 2, 'Array literal not flattened');
    push @a, {};
    is(@a.elems, 3, 'Hash literal not flattened');
    my @е갨갨;
    push @a, @е갨갨;
    is(@a.elems, 4, 'Array not flattened');
    my %е갨갨;
    push @a, %е갨갨;
    is(@a.elems, 5, 'Hash not flattened');

    append @a, @е갨갨;
    is(@a.elems, 5, 'Array flattened by append');
    append @a, %е갨갨;
    is(@a.elems, 5, 'Hash flattened by append');

    @a.push: |@е갨갨;
    is(@a.elems, 5, '|Array flattened');
    @a.push: |%е갨갨;
    is(@a.elems, 5, '|Hash flattened');

    @a.append: @е갨갨;
    is(@a.elems, 5, 'Array flattened by .append');
    @a.append: %е갨갨;
    is(@a.elems, 5, 'Hash flattened by .append');
}

# https://github.com/rakudo/rakudo/issues/4034
{
    my (@a, @b);
    my \values = 1, 2;
    push @a, values, 3;
    @b.push: values, 3;
    is-deeply @a, @b,
     'push and .push flatten multiple values the same way';
}

{
    my (@a, @b);
    my \values = 1, 2;
    unshift @a, values, 3;
    @b.unshift: values, 3;
    is-deeply @a, @b,
     'unshift and .unshift flatten multiple values the same way';
}

# https://github.com/Raku/old-issue-tracker/issues/2708
{
    my @a = <a b c d e f>;
    is @a[$[3, 4], 0,], 'c a', '$[] in array slice numifies (1)';
    is @a[$[3, 4]],     'c',    '$[] in array slice numifies (2)';

    my %両 = a => 1, b => 2, 'a b' => 3;
    is %両{<a b>}, '1 2', 'hash slicing sanity';
    is %両{$[<a b>]}, '3', 'hash slicing stringifies []';
}

{
    my $a = [ a => 1, b => 2, c => 3 ];
    my $両 = { a => 1, b => 2, c => 3 };

    my @à-à = @$a;
    my @両-à = %$a;

    my @à-両 = @$両;
    my @両-両 = %$両;

    is-deeply +@à-à, 3, '@ sigil flattening of itemized array';
    is-deeply +@両-à, 3, '% sigil flattening of itemized array';
    is-deeply +@à-両, 3, '@ sigil flattening of itemized hash';
    is-deeply +@両-両, 3, '% sigil flattening of itemized hash';
}

# https://github.com/Raku/old-issue-tracker/issues/4588
{
    my @à1 = 1,2,3; my @丛1; @丛1.push:   @à1,;
    my @à2 = 1,2,3; my @丛2; @丛2.push:   @à2;
    my @à3 = 1,2,3; my @丛3; @丛3.append: @à3,;
    my @à4 = 1,2,3; my @丛4; @丛4.append: @à4;

    is-deeply @丛1, [[1, 2, 3],], 'method push does not flatten an array arg (1)';
    is-deeply @丛2, [[1, 2, 3],], 'method push does not flatten an array arg (2)';
    is-deeply @丛3,  [1, 2, 3],   'method append does flatten an array arg (1)';
    is-deeply @丛4,  [1, 2, 3],   'method append does flatten an array arg (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2735
{
    sub е갨갨 (\v) {
        is-deeply v, True, 'slipping a Bool into arguments does not crash'
    }( |True )
}

# https://github.com/rakudo/rakudo/issues/2442
{
    my @中ù𝐩e̲ò = array, Array, Iterable.^pun, List, Range, Supply;
    subtest '.flat on type objects' => {
        plan +@中ù𝐩e̲ò;
        for @中ù𝐩e̲ò -> $type {
            is-deeply $type.flat, ($type,), "did $type.^name() flatten ok";
        }
    }
}

# vim: expandtab shiftwidth=4
