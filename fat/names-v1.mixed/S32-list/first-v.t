use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @л갢ò中 = (1 ... 10);

{
    my $сe̲ò갮л中 = first { $^a % 2 }, @л갢ò中, :v;
    ok $сe̲ò갮л中 ~~ Int, "first() returns an Int";
    is $сe̲ò갮л中, 1, "returned value by first() is correct";
}

{
    my $сe̲ò갮л中 = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :v;
    ok $сe̲ò갮л中 ~~ Int, "first() returns an Int";
    is $сe̲ò갮л中, 1, "returned value by first() is correct";
}

{
    my $сe̲ò갮л中 = @л갢ò中.first( { $^a == 4}, :v );
    ok $сe̲ò갮л中 ~~ Int, "method form of first returns an Int";
    is $сe̲ò갮л中, 4, "method form of first returns the expected item";
}

{
    ok @л갢ò中.first( { $^a == 11 }, :v ) =:= Nil, 'first returns Nil on unsuccessful match';
}

{
    my $개갨갮丧中 = 0;
    my $ìà中개両e̲с = sub (Int $x) { $개갨갮丧中++; $x % 2 };
    is @л갢ò中.first($ìà中개両e̲с, :v), 1,
      'first() search for odd elements successful';
    is $개갨갮丧中, 1, 'Matching closure in first() is only executed once';
}

{
    is @л갢ò中.first(4..6, :v), 4,
      "method form of first with range returns the expected item";
    is @л갢ò中.first(4^..6, :v), 5,
      "method form of first with range returns the expected item";
}

{
    my @еà丧개ù_л갢ò中 = (1, 2, "Hello", 3/4, 4.Num);
    is @еà丧개ù_л갢ò中.first(Str, :v), "Hello", "first by type Str works";
    is @еà丧개ù_л갢ò中.first(Int, :v), 1,       "first by type Int works";
    is @еà丧개ù_л갢ò中.first(Rat, :v), 3/4,     "first by type Rat works";
}

{
    my @еà丧개ù_л갢ò中 = <Philosopher Goblet Prince>;
    is @еà丧개ù_л갢ò中.first(/o/, :v),    'Philosopher', "first by regex /o/";
    is @еà丧개ù_л갢ò中.first(/ob/, :v),   'Goblet', "first by regex /ob/";
    is @еà丧개ù_л갢ò中.first(/l.*o/, :v), 'Philosopher', "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :v), 'b',
      '.first also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :v), 'b',
      '.first also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :v }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :v }, X::Match::Bool;
    is first( Bool,True,False,Int, :v ), True,
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :v), True,
      'can we match on Bool as type';
}

# :!v handling
{
    throws-like { (^10).first(Int, :!v) }, Exception;
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
