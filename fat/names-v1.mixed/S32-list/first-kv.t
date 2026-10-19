use Test;

# L<S32::Containers/"List"/"=item first">

plan 21;

my @л갢ò中 = 1...10;

is-deeply (first { $^a % 2 }, @л갢ò中, :kv), (0, 1),
    'first(&, @a, :kv)';
is-deeply (first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :kv), (0,1),
    'first(&, v1, v2, v3 …, :kv)';
is-deeply @л갢ò中.first({ $^a == 4}, :kv), (3, 4), '@a.first(&, :kv)';
is-deeply @л갢ò中.first({ $^a == 11 }, :kv), Nil,
    '@a.first(&, :kv) [unsuccessful match]';

{
    my $개갨갮丧中 = 0;
    is-deeply @л갢ò中.first({ $개갨갮丧中++; $^x % 2 }, :kv), (0, 1),
        '@a.first(&, :kv) search for odd elements';
    is $개갨갮丧中, 1, 'matcher got only executed once';
}

is-deeply @л갢ò中.first(4..6,  :kv), (3, 4), '@a.first(v1..v2,  :kv)';
is-deeply @л갢ò中.first(4^..6, :kv), (4, 5), '@a.first(v1^..v2, :kv)';

{
    my @еà丧개ù-л갢ò中 = (1, 2, "Hello", 3/4, 4.Num);
    is-deeply @еà丧개ù-л갢ò中.first(Str, :kv), (2, "Hello"),
        '@a.first(Str:U, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(Int, :kv), (0, 1),
        '@a.first(Int:U, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(Rat, :kv), (3, 3/4),
        '@a.first(Rat:U, :kv)';
}

{
    my @еà丧개ù-л갢ò中 = <Philosopher Goblet Prince>;
    is-deeply @еà丧개ù-л갢ò中.first(/o/,    :kv), (0, 'Philosopher'),
        '@a.first(/o/, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(/ob/,   :kv), (1, 'Goblet'),
        '@a.first(/ob/, :kv)';
    is-deeply @еà丧개ù-л갢ò中.first(/l.*o/, :kv), (0, 'Philosopher'),
        '@a.first(/l.*o/, :kv)';
}

is-deeply <a b c b a>.first('c' | 'b', :kv), (1, 'b'),
    'List:D.first(Junction:D, :kv)';

is-deeply (first 'c'|'b', <a b c b a>, :kv), (1, 'b'),
    'first(Junction:D, List:D, :kv)';

{ # Bool handling
    temp $_ = 42; # avoid `uninitialized` warning
    throws-like { first $_ == 1, 1,2,3, :kv }, X::Match::Bool,
        'first(Bool:D, v1, v2, …, :kv)';
    throws-like { (1,2,3).first: $_== 1, :kv }, X::Match::Bool,
        'List:D.first(Bool:D, :kv)';
    is-deeply first(Bool, True, False, Int, :kv ), (0, True),
      'Bool:U as matcher (sub)';
    is-deeply (True, False, Int).first(Bool, :kv), (0, True),
      'Bool:U as matcher (method)';
}

# :!kv handling
is-deeply @л갢ò中.first(Int, :!kv), 1, 'is :!kv the same as no attribute';

#vim: ft=perl6

# vim: expandtab shiftwidth=4
