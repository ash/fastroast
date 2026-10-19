use Test;

# L<S32::Containers/"List"/"=item first">

plan 21;

my @л갢ò中 = 1...10;

is-deeply (first { $^a % 2 }, @л갢ò中, :end, :kv), (8, 9),
    'first(&, @a, :end, :kv)';
is-deeply (first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end, :kv), (6, 7),
    'first(&, v1, v2, v3 …, :end, :kv)';
is-deeply @л갢ò中.first({ $^a == 4}, :end, :kv), (3, 4),
    '@a.first(&, :end, :kv)';
is-deeply @л갢ò中.first({ $^a == 11 }, :end, :kv), Nil,
    '@a.first(&, :end, :kv) [unsuccessful match]';
{
    my $개갨갮丧中 = 0;
    is-deeply @л갢ò中.first({ $개갨갮丧中++; $^x % 2 }, :end, :kv), (8, 9),
        '@a.first(&, :end, :kv) search for odd elements';
    is $개갨갮丧中, 2, 'matcher got only executed twice';
}

is-deeply @л갢ò中.first(4..6,  :end, :kv), (5, 6), '@a.first(v1..v2,  :end, :kv)';
is-deeply @л갢ò中.first(4..^6, :end, :kv), (4, 5), '@a.first(v1..^v2, :end, :kv)';

{
    my @еà丧개ù-л갢ò中 = 1, 2, "Hello", 3/4, 4.Num;
    is-deeply @еà丧개ù-л갢ò中.first(Str, :end, :kv), (2, "Hello"),
        '@a.first(Str:U, :end, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(Int, :end, :kv), (1, 2),
        '@a.first(Int:U, :end, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(Rat, :end, :kv), (3, 3/4),
        '@a.first(Rat:U, :end, :kv)';
}

{
    my @еà丧개ù-л갢ò中 = <Philosopher Goblet Prince>;
    is-deeply @еà丧개ù-л갢ò中.first(/o/,    :end, :kv), (1, 'Goblet'),
        '@a.first(/o/, :end, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(/ob/,   :end, :kv), (1, 'Goblet'),
        '@a.first(/ob/, :end, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(/l.*o/, :end, :kv), (0, 'Philosopher'),
        '@a.first(/l.*o/, :end, :kv)';
}

is-deeply <a b c b a>.first('c' | 'b', :end, :kv), (3, 'b'),
    'List:D.first(Junction:D, :end, :kv)';

is-deeply (first 'c'|'b', <a b c b a>, :end, :kv), (3, 'b'),
    'first(Junction:D, List:D, :end, :kv)';

{ # Bool handling
    temp $_ = 42; # avoid `uninitialized` warning
    throws-like { first $_ == 1, 1,2,3, :end, :kv }, X::Match::Bool,
        'first(Bool:D, v1, v2, …, :end, :kv)';
    throws-like { (1,2,3).first: $_== 1, :end, :kv }, X::Match::Bool,
        'List:D.first(Bool:D, :end, :kv)';
    is-deeply first(Bool, True, False, Int, :end, :kv ), (1, False),
      'Bool:U as matcher (sub)';
    is-deeply (True, False, Int).first(Bool, :end, :kv), (1, False),
      'Bool:U as matcher (method)';
}

# :!v handling
is-deeply @л갢ò中.first(Int, :end, :!kv), 10, 'is :!kv the same as no attribute';

#vim: ft=perl6

# vim: expandtab shiftwidth=4
