use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @л갢ò中 = (1 ... 10);

{
    my $сe̲ò갮л中 = first { $^a % 2 }, @л갢ò中, :p;
    ok $сe̲ò갮л中 ~~ Pair, "first() returns an Pair";
    is $сe̲ò갮л中, 0=>1, "returned value by first() is correct";
}

{
    my $сe̲ò갮л中 = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :p;
    ok $сe̲ò갮л中 ~~ Pair, "first() returns an Pair";
    is $сe̲ò갮л中, 0=>1, "returned value by first() is correct";
}

{
    my $сe̲ò갮л中 = @л갢ò中.first( { $^a == 4}, :p );
    ok $сe̲ò갮л中 ~~ Pair, "method form of first returns an Pair";
    is $сe̲ò갮л中, 3=>4, "method form of first returns the expected item";
}

{
    ok @л갢ò中.first( { $^a == 11 }, :p ) =:= Nil, 'first returns Nil on unsuccessful match';
}

{
    my $개갨갮丧中 = 0;
    my $ìà中개両e̲с = sub (Int $x) { $개갨갮丧中++; $x % 2 };
    is @л갢ò中.first($ìà中개両e̲с, :p), 0=>1,
      'first() search for odd elements successful';
    is $개갨갮丧中, 1, 'Matching closure in first() is only executed once';
}

{
    is @л갢ò中.first(4..6, :p), 3=>4,
      "method form of first with range returns the expected item";
    is @л갢ò中.first(4^..6, :p), 4=>5,
      "method form of first with range returns the expected item";
}

{
    my @еà丧개ù_л갢ò中 = (1, 2, "Hello", 3/4, 4.Num);
    is @еà丧개ù_л갢ò中.first(Str, :p), 2=>"Hello", "first by type Str works";
    is @еà丧개ù_л갢ò中.first(Int, :p), 0=>1,       "first by type Int works";
    is @еà丧개ù_л갢ò中.first(Rat, :p), 3=>3/4,     "first by type Rat works";
}

{
    my @еà丧개ù_л갢ò中 = <Philosopher Goblet Prince>;
    is @еà丧개ù_л갢ò中.first(/o/, :p),    0=>'Philosopher', "first by regex /o/";
    is @еà丧개ù_л갢ò中.first(/ob/, :p),   1=>'Goblet', "first by regex /ob/";
    is @еà丧개ù_л갢ò中.first(/l.*o/, :p), 0=>'Philosopher', "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :p), 1=>'b',
      '.first also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :p), 1=>'b',
      '.first also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :p }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :p }, X::Match::Bool;
    is first( Bool,True,False,Int, :p ), 0=>True,
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :p), 0=>True,
      'can we match on Bool as type';
}

# :!p handling
{
    is (^10).first(Int, :!p), 0, 'is :!p the same as no attribute';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
