use Test;

# L<S32::Containers/"List"/"=item first">

plan 26;

my @л갢ò中 = (1 ... 10);

{
    my $сe̲ò갮л中 = first { $^a % 2 }, |@л갢ò中, :end, :k;
    ok($сe̲ò갮л中 ~~ Int, "first(, :end, :k) returns an Int");
    is($сe̲ò갮л中, 8, "returned value by first() is correct");
}

{
    my $сe̲ò갮л中 = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end, :k;
    ok($сe̲ò갮л中 ~~ Int, "first(, :end, :k) returns an Int");
    is($сe̲ò갮л中, 6, "returned value by first(, :end, :k) is correct");
}


{
    my $сe̲ò갮л中 = @л갢ò中.first( { $^a == 4}, :end, :k );
    ok($сe̲ò갮л中 ~~ Int, "method form of first, :end, :k returns an Int");
    is($сe̲ò갮л中, 3, "method form of first, :end, :k returns the expected item");
}

skip("adverbial block", 2);# {
#     my $result = @list.first():{ $^a == 4 }, :end, :k;
#     ok($result ~~ Int, "first(, :end, :k):<block> returns an Int");
#     is($result, 3, "first(, :end, :k) returned the expected value");
# }

{
    ok @л갢ò中.first( { $^a == 11 }, :end, :k ) =:= Nil, 'first, :end, :k returns Nil on unsuccessful match';
}

{
    my $개갨갮丧中 = 0;
    my $ìà中개両e̲с = sub (Int $x) { $개갨갮丧中++; $x % 2 };
    is @л갢ò中.first($ìà中개両e̲с, :end, :k), 8, 'first(, :end, :k) search for odd elements successful';
    is $개갨갮丧中, 2, 'Matching closure in first(, :end, :k) is only executed twice';
}

{
    is(@л갢ò中.first(4..6, :end, :k), 5, "method form of first, :end, :k with range returns the expected item");
    is(@л갢ò中.first(4..^6, :end, :k), 4, "method form of first, :end, :k with range returns the expected item");
}

{
    my @еà丧개ù_л갢ò中 = (1, 2, "Hello", 3/4, 4.Num);
    is @еà丧개ù_л갢ò中.first(Str, :end, :k), 2, "first by type Str works";
    is @еà丧개ù_л갢ò中.first(Int, :end, :k), 1, "first by type Int works";
    is @еà丧개ù_л갢ò中.first(Rat, :end, :k), 3, "first by type Rat works";
}

{
    my @еà丧개ù_л갢ò中 = <Philosopher Goblet Prince>;
    is @еà丧개ù_л갢ò中.first(/o/, :end, :k),    1, "first by regex /o/";
    is @еà丧개ù_л갢ò中.first(/ob/, :end, :k),   1, "first by regex /ob/";
    is @еà丧개ù_л갢ò中.first(/l.*o/, :end, :k), 0, "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :end, :k),
        3, '.first, :end, :k also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :end, :k),
        3, '.first, :end, :k also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :end, :k }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :end, :k }, X::Match::Bool;
    is first( Bool,True,False,Int, :end, :k ), 1, 'can we match on Bool as type';
    is (True,False,Int).first(Bool, :end, :k), 1, 'can we match on Bool as type';
}

# :!k handling
{
    is (^10).first(Int, :!k), 0, 'is :!k the same as no attribute';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
