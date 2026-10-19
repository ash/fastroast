use Test;

# L<S32::Containers/"List"/"=item first">

plan 25;

my @л갢ò中 = (1 ... 10);

{
    my $сe̲ò갮л中 = first { $^a % 2 }, |@л갢ò中, :k;
    ok($сe̲ò갮л中 ~~ Int, "first() returns an Int");
    is($сe̲ò갮л中, 0, "returned value by first() is correct");
}

{
    my $сe̲ò갮л中 = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :k;
    ok($сe̲ò갮л中 ~~ Int, "first() returns an Int");
    is($сe̲ò갮л中, 0, "returned value by first() is correct");
}


{
    my $сe̲ò갮л中 = @л갢ò中.first( { $^a == 4}, :k );
    ok($сe̲ò갮л中 ~~ Int, "method form of first returns an Int");
    is($сe̲ò갮л中, 3, "method form of first returns the expected item");
}

skip("adverbial block", 2);# {
#     my $result = @list.first():{ $^a == 4 }, :k;
#     ok($result ~~ Int, "first():<block> returns an Int");
#     is($result, 3, "first() returned the expected value");
# }

{
    ok @л갢ò中.first( { $^a == 11 } ) =:= Nil, 'first returns Nil on unsuccessful match';
}

{
    my $개갨갮丧中 = 0;
    my $ìà中개両e̲с = sub (Int $x) { $개갨갮丧中++; $x % 2 };
    is(@л갢ò中.first($ìà中개両e̲с, :k), 0, 'first() search for odd elements successful');
    is($개갨갮丧中, 1, 'Matching closure in first() is only executed once');
}

{
    is(@л갢ò中.first(4..6, :k), 3, "method form of first with range returns the expected item");
    is(@л갢ò中.first(4^..6, :k), 4, "method form of first with range returns the expected item");
}

{
    my @еà丧개ù_л갢ò中 = (1, 2, "Hello", 3/4, 4.Num);
    is @еà丧개ù_л갢ò中.first(Str, :k), 2, "first by type Str works";
    is @еà丧개ù_л갢ò中.first(Int, :k), 0, "first by type Int works";
    is @еà丧개ù_л갢ò中.first(Rat, :k), 3, "first by type Rat works";
}

{
    my @еà丧개ù_л갢ò中 = <Philosopher Goblet Prince>;
    is @еà丧개ù_л갢ò中.first(/o/, :k),    0, "first by regex /o/";
    is @еà丧개ù_л갢ò中.first(/ob/, :k),   1, "first by regex /ob/";
    is @еà丧개ù_л갢ò中.first(/l.*o/, :k), 0, "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :k),
        1, '.first also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :k),
        1, '.first also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :k }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :k }, X::Match::Bool;
    is first( Bool,True,False,Int, :k ), 0, 'can we match on Bool as type';
    is (True,False,Int).first(Bool, :k), 0, 'can we match on Bool as type';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
