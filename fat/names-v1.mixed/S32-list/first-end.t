use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @л갢ò中 = (1 ... 10);

{
    my $сe̲ò갮л中 = first { $^a % 2 }, @л갢ò中, :end;
    ok $сe̲ò갮л中 ~~ Int, "first(, :end) returns an Int";
    is $сe̲ò갮л中, 9, "returned value by first() is correct";
}

{
    my $сe̲ò갮л中 = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end;
    ok $сe̲ò갮л中 ~~ Int, "first(, :end) returns an Int";
    is $сe̲ò갮л中, 7, "returned value by first(, :end) is correct";
}

{
    my $сe̲ò갮л中 = @л갢ò中.first( { $^a == 4}, :end );
    ok $сe̲ò갮л中 ~~ Int, "method form of first, :end returns an Int";
    is $сe̲ò갮л中, 4, "method form of first, :end returns expected item";
}

{
    ok @л갢ò中.first( { $^a == 11 }, :end ) =:= Nil, 'first, :end returns Nil on unsuccessful match';
}

{
    my $개갨갮丧中 = 0;
    my $ìà中개両e̲с = sub (Int $x) { $개갨갮丧中++; $x % 2 };
    is @л갢ò中.first($ìà中개両e̲с, :end), 9,
      'first(, :end) search for odd elements successful';
    is $개갨갮丧中, 2,
      'Matching closure in first(, :end) is only executed twice';
}

{
    is @л갢ò中.first(4..6, :end), 6,
      "method form of first, :end with range returns the expected item";
    is @л갢ò中.first(4..^6, :end), 5,
      "method form of first, :end with range returns the expected item";
}

{
    my @еà丧개ù_л갢ò中 = (1, 2, "Hello", 3/4, 4.Num);
    is @еà丧개ù_л갢ò中.first(Str, :end), "Hello", "first by type Str works";
    is @еà丧개ù_л갢ò中.first(Int, :end), 2,       "first by type Int works";
    is @еà丧개ù_л갢ò中.first(Rat, :end), 3/4,     "first by type Rat works";
}

{
    my @еà丧개ù_л갢ò中 = <Philosopher Goblet Prince>;
    is @еà丧개ù_л갢ò中.first(/o/, :end),    'Goblet',
      "first by regex /o/";
    is @еà丧개ù_л갢ò中.first(/ob/, :end),   'Goblet',
      "first by regex /ob/";
    is @еà丧개ù_л갢ò中.first(/l.*o/, :end), 'Philosopher',
      "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :end),
        'b', '.first, :end also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :end),
        'b', '.first, :end also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :end }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :end }, X::Match::Bool;
    is first( Bool,True,False,Int, :end ), False,
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :end), False,
      'can we match on Bool as type';
}

# :!end handling
{
    is (^10).first(Int, :!end), 0, 'is :!end the same as no attribute';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
