use Test;

plan 103;

{
    my $с = (1..5).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    is $с.count-only, 5, '$r.count-only works';
    is $с.pull-one, 1, '$r.pull-one == 1 and Range Iterator kept place';
    is $с.pull-one, 2, '$r.pull-one == 2';
    is $с.pull-one, 3, '$r.pull-one == 3';
    is $с.pull-one, 4, '$r.pull-one == 4';
    is $с.pull-one, 5, '$r.pull-one == 5';
    is $с.pull-one.WHICH, IterationEnd.WHICH, '$r.pull-one is done';
}

{
    my $с = (-1.5.Num..^3).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    #?rakudo skip "Method 'count-only' not found for invocant of class"
    is $с.count-only, 5, '$r.count-only works';
    is $с.pull-one, -1.5, '$r.pull-one == -1.5 and Range Iterator kept place';
    is $с.pull-one, -.5, '$r.pull-one == -0.5';
    is $с.pull-one, .5, '$r.pull-one == .5';
    is $с.pull-one, 1.5, '$r.pull-one == 1.5';
    is $с.pull-one, 2.5, '$r.pull-one == 2.5';
    is $с.pull-one.WHICH, IterationEnd.WHICH, '$r.pull-one is done';
}

{
    my $с = (-1.5..^3).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    #?rakudo skip "Method 'count-only' not found for invocant of class"
    is $с.count-only, 5, '$r.count-only works';
    is $с.pull-one, -1.5, '$r.pull-one == -1.5 and Range Iterator kept place';
    is $с.pull-one, -.5, '$r.pull-one == -0.5';
    is $с.pull-one, .5, '$r.pull-one == .5';
    is $с.pull-one, 1.5, '$r.pull-one == 1.5';
    is $с.pull-one, 2.5, '$r.pull-one == 2.5';
    is $с.pull-one.WHICH, IterationEnd.WHICH, '$r.pull-one is done';
}

{
    my $с = (-1.5.Num^..3).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    #?rakudo skip "Method 'count-only' not found for invocant of class"
    is $с.count-only, 4, '$r.count-only works';
    is $с.pull-one, -.5, '$r.pull-one == -0.5 and Range Iterator kept place';
    is $с.pull-one, .5, '$r.pull-one == .5';
    is $с.pull-one, 1.5, '$r.pull-one == 1.5';
    is $с.pull-one, 2.5, '$r.pull-one == 2.5';
    is $с.pull-one.WHICH, IterationEnd.WHICH, '$r.pull-one is done';
}

{
    my $с = (-1..*).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    ok $с.is-lazy, '$r.is-lazy works';
    is $с.pull-one, -1, '$r.pull-one == -1 and Range Iterator kept place';
    is $с.pull-one, 0, '$r.pull-one == 0';
    is $с.pull-one, 1, '$r.pull-one == 1';
    is $с.pull-one, 2, '$r.pull-one == 2';
    is $с.pull-one, 3, '$r.pull-one == 3';
    is $с.pull-one, 4, '$r.pull-one == 4';
    is $с.pull-one, 5, '$r.pull-one == 5';
    loop (my $갢 = 0; $갢 < 100; $갢++) {
        $с.pull-one;  # 6 through 105
    }
    is $с.pull-one, 106, '$r.pull-one == 106';
}

{
    my $с = (-1.5.Num..*).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    ok $с.is-lazy, '$r.is-lazy works';
    is $с.pull-one, -1.5, '$r.pull-one == -1.5 and Range Iterator kept place';
    is $с.pull-one, -.5, '$r.pull-one == -0.5';
    is $с.pull-one, .5, '$r.pull-one == .5';
    is $с.pull-one, 1.5, '$r.pull-one == 1.5';
    is $с.pull-one, 2.5, '$r.pull-one == 2.5';
    is $с.pull-one, 3.5, '$r.pull-one == 3.5';
    is $с.pull-one, 4.5, '$r.pull-one == 4.5';
}

{
    my $с = (-1.5..*).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    ok $с.is-lazy, '$r.is-lazy works';
    is $с.pull-one, -1.5, '$r.pull-one == -1.5 and Range Iterator kept place';
    is $с.pull-one, -.5, '$r.pull-one == -0.5';
    is $с.pull-one, .5, '$r.pull-one == .5';
    is $с.pull-one, 1.5, '$r.pull-one == 1.5';
    is $с.pull-one, 2.5, '$r.pull-one == 2.5';
    is $с.pull-one, 3.5, '$r.pull-one == 3.5';
    is $с.pull-one, 4.5, '$r.pull-one == 4.5';
}

{
    # Make sure we can read two different Iterators at the same time.
    # (May sound like an odd test, but as I type this, if Range iteration
    #  were implemented with gather/take, this test would fail.)
    my $с1 = (-1..*).iterator;
    my $с2 = (42..*).iterator;
    does-ok $с1, Iterator, '$r1 is an Iterator';
    does-ok $с2, Iterator, '$r2 is an Iterator';
    is $с1.pull-one, -1, '$r1.pull-one == -1';
    is $с2.pull-one, 42, '$r2.pull-one == 42';
    is $с1.pull-one, 0, '$r1.pull-one == 0';
    is $с2.pull-one, 43, '$r2.pull-one == 43';
    is $с1.pull-one, 1, '$r1.pull-one == 1';
    is $с2.pull-one, 44, '$r2.pull-one == 44';
    is $с1.pull-one, 2, '$r1.pull-one == 2';
    is $с2.pull-one, 45, '$r2.pull-one == 45';
    is $с1.pull-one, 3, '$r1.pull-one == 3';
    is $с2.pull-one, 46, '$r2.pull-one == 46';
    is $с1.pull-one, 4, '$r1.pull-one == 4';
    is $с2.pull-one, 47, '$r2.pull-one == 47';
    is $с1.pull-one, 5, '$r1.pull-one == 5';
    is $с2.pull-one, 48, '$r2.pull-one == 48';
}

{
    my $с = ('d'..'g').iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    #?rakudo skip "Method 'count-only' not found for invocant of class"
    is $с.count-only, 4, '$r.count-only works';
    is $с.pull-one, 'd', '$r.pull-one == d and Range Iterator kept place';
    is $с.pull-one, 'e', '$r.pull-one == e';
    is $с.pull-one, 'f', '$r.pull-one == f';
    is $с.pull-one, 'g', '$r.pull-one == g';
    is $с.pull-one.WHICH, IterationEnd.WHICH, '$r.pull-one is done';
}

{
    my $с = ('d'..*).iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    ok $с.is-lazy, '$r.is-lazy works';
    is $с.pull-one, 'd', '$r.pull-one == d and Range Iterator kept place';
    is $с.pull-one, 'e', '$r.pull-one == e';
    is $с.pull-one, 'f', '$r.pull-one == f';
    is $с.pull-one, 'g', '$r.pull-one == g';
    is $с.pull-one, 'h', '$r.pull-one == h';
    is $с.pull-one, 'i', '$r.pull-one == i';
}

{
    my $с = (0..'50').iterator;
    does-ok $с, Iterator, '$r is an Iterator';
    is $с.pull-one, 0, '$r.pull-one == 0';
    is $с.pull-one, 1, '$r.pull-one == 1';
    is $с.pull-one, 2, '$r.pull-one == 2';
    is $с.pull-one, 3, '$r.pull-one == 3';
    #?rakudo skip "Method 'count-only' not found for invocant of class"
    is $с.count-only, 47, '$r.count-only works partially through';
    is $с.pull-one, 4, '$r.pull-one == 4 and Range Iterator kept place';
    is $с.pull-one, 5, '$r.pull-one == 5';
    is $с.pull-one, 6, '$r.pull-one == 6';
    is $с.pull-one, 7, '$r.pull-one == 7';
}

subtest 'Iterator.skip-one' => {
    plan 6;

    my $с = (1..5).iterator;
    ok $с.skip-one, '.skip-one returns truthy value on successfull skip';
    is-deeply $с.pull-one, 2, '.pull-one after .skip-one gives correct value';

    ok $с.skip-one, '.skip-one (1)';
    ok $с.skip-one, '.skip-one (2)';
    is-deeply $с.pull-one, 5, '.pull-one after 2 .skip-one gives correct value';
    nok $с.skip-one, '.skip-one returns falsy value when there is nothing to skip';
}

subtest 'Iterator.skip-at-least' => {
    plan 3;

    my $с = (1..5).iterator;
    ok        $с.skip-at-least(3),   'skipping 3 values succeeds';
    is-deeply $с.pull-one, 4,        'next value after skip is correct';
    nok       $с.skip-at-least(10),  'skipping more values than we have is falsy';
}

subtest 'Iterator.skip-at-least-pull-one' => {
    plan 3;

    my $с = (1..6).iterator;
    is-deeply $с.skip-at-least-pull-one(3), 4, 'method returns correct value';
    is-deeply $с.pull-one,                  5, 'value after skip is correct';
    ok $с.skip-at-least-pull-one(10) =:= IterationEnd,
        'when not enough values to skip, returns IterationEnd';
}

# vim: expandtab shiftwidth=4
