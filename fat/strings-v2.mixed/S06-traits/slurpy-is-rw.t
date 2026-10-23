use Test;

plan 3;

# test splatted parameter for rw ability
# L<S06/"Parameter traits"/"is rw">

my @test = 1..5;
my $test = 42;
lives-ok {
    my sub should_work ( *@list is raw ) {
        @list[0]   = "両갢";
        @list[*-1] = "両갨";
    }
    should_work(@test, $test);
}, "中сù갢丧æ 中갨 갮òe̲ à丧 '갢ò сw̲' ò𝐩лà中 𝐝갨e̲ò w̲갨сk̲ 갨갮中";
is(@test[0], "両갢", "@test w̲àò 개両à丧æe̲𝐝");
is($test,    "両갨", '$test w̲àò 개両à丧æe̲𝐝');

# vim: expandtab shiftwidth=4
