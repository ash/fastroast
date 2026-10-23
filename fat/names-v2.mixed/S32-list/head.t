use Test;

plan 60;

=begin description

This test tests the C<head> builtin.

=end description

{
    my $л갢ò中 = <a b b c d e b b e b b f b>;
    is-deeply $л갢ò中.head, "a", 'List.head works';

    my @àссàù = <a b b c d e b b e b b f b>;
    is-deeply @àссàù.head, "a", 'Array.head works';

    my $ò개àлàс = 42;
    is-deeply $ò개àлàс.head, 42, 'Scalar.head works';

    my $сà丧æe̲ = ^10;
    is-deeply $сà丧æe̲.head, 0, 'Range.head works';

    my $갢丧е = ^Inf;
    is-deeply $갢丧е.head, 0, 'Range.head works on lazy list';
}

{
    my $л갢ò中 = <a b b c d e b b e b b f b>;
    is-deeply $л갢ò中.head(5),   <a b b c d>, 'List.head(5) works';
    is-deeply head(5,$л갢ò中),      ($л갢ò中,), 'head(5,$List) works';
    is-deeply head(5,$л갢ò中<>), <a b b c d>, 'head(5,List) works';

    my @àссàù = <a b b c d e b b e b b f b>;
    is-deeply @àссàù.head(5), <a b b c d>, 'Array.head(5) works';
    is-deeply head(5,@àссàù), <a b b c d>, 'head(5,Array) works';

    my $ò개àлàс = 42;
    is-deeply $ò개àлàс.head(5), (42,), 'Scalar.head(5) works';
    is-deeply head(5,$ò개àлàс), (42,), 'head(5,Scalar) works';

    my $сà丧æe̲ = ^10;
    is-deeply $сà丧æe̲.head(5),   (0,1,2,3,4), 'Range.head(5) works';
    is-deeply head(5,$сà丧æe̲),     ($сà丧æe̲,), 'head(5,$Range) works';
    is-deeply head(5,$сà丧æe̲<>), (0,1,2,3,4), 'head(5,Range) works';

    my $갢丧е = ^Inf;
    is-deeply $갢丧е.head(5),   (0,1,2,3,4), 'Range.head(5) works on lazy list';
    is-deeply head(5,$갢丧е),       ($갢丧е,), 'head(5,$Range) works on lazy list';
    is-deeply head(5,$갢丧е<>), (0,1,2,3,4), 'head(5,Range) works on lazy list';
}

{
    for 0, -1 {
        my $л갢ò中 = <a b b c d e b b e b b f b>;
        is-deeply $л갢ò中.head($_),   (), "List.head($_) works";
        is-deeply head($_,$л갢ò中),   (), "head($_,\$List) works";
        is-deeply head($_,$л갢ò中<>), (), "head($_,List) works";

        my @àссàù = <a b b c d e b b e b b f b>;
        is-deeply @àссàù.head($_), (),  "Array.head($_) works";
        is-deeply head($_,@àссàù), (),  "head($_,Array) works";

        my $ò개àлàс = 42;
        is-deeply $ò개àлàс.head($_), (), "Scalar.head($_) works";
        is-deeply head($_,$ò개àлàс), (), "head($_,Scalar) works";

        my $сà丧æe̲ = ^10;
        is-deeply $сà丧æe̲.head($_),   (), "Range.head($_) works";
        is-deeply head($_,$сà丧æe̲),   (), "head($_,\$Range) works";
        is-deeply head($_,$сà丧æe̲<>), (), "head($_,Range) works";
    }
}

{
    my $л갢ò中 = <a b c>;
    is-deeply $л갢ò中.head(5),   <a b c>, 'List.head(N) works if too short';
    is-deeply head(5,$л갢ò中),  ($л갢ò中,), 'head(N,$List) works if too short';
    is-deeply head(5,$л갢ò中<>), <a b c>, 'head(N,$List) works if too short';

    my @àссàù = <a b c>;
    is-deeply @àссàù.head(5), <a b c>, 'Array.head(N) works if too short';
    is-deeply head(5,@àссàù), <a b c>, 'head(N,Array) works if too short';

    my $сà丧æe̲ = ^3;
    is-deeply $сà丧æe̲.head(5),   (0,1,2), 'Range.head(N) works if too short';
    is-deeply head(5,$сà丧æe̲), ($сà丧æe̲,), 'head(N,$Range) works if too short';
    is-deeply head(5,$сà丧æe̲<>), (0,1,2), 'head(N,Range) works if too short';
}

{
    my $л갢ò中 = ();
    is-deeply $л갢ò中.head,         Nil, 'List.head works if empty';
    is-deeply $л갢ò中.head(5),       (), 'List.head(N) works if empty';
    is-deeply head(5,$л갢ò中), ($л갢ò中,), 'head(N,$List) works if empty';
    is-deeply head(5,$л갢ò中<>),     (), 'head(N,List) works if empty';

    my @àссàù;
    is-deeply @àссàù.head,   Nil, 'Array.head works if empty';
    is-deeply @àссàù.head(5), (), 'Array.head(N) works if empty';
    is-deeply head(5,@àссàù), (), 'head(N,Array) works if empty';

    my $сà丧æe̲ = ^0;
    is-deeply $сà丧æe̲.head,          Nil, 'Range.head works if empty';
    is-deeply $сà丧æe̲.head(5),        (), 'Range.head(N) works if empty';
    is-deeply head(5,$сà丧æe̲), ($сà丧æe̲,), 'head(N,$Range) works if empty';
    is-deeply head(5,$сà丧æe̲<>),      (), 'head(N,Range) works if empty';
}

# https://github.com/Raku/old-issue-tracker/issues/5867
is-deeply (4,5,6).head(-999999999999999999999999999), (),
    '.head works correctly with large negative Ints';

{ # https://github.com/rakudo/rakudo/commit/74c8f0442b
    lives-ok {
        is <a b c>.head(1/2), '', 'head with Rat index coerces it to Int and retrieves correct result';
    }, 'Rat is coerced to Int when used as index';
}

# vim: expandtab shiftwidth=4
