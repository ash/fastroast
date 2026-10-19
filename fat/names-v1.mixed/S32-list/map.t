use Test;
plan 62;

# L<S32::Containers/"List"/"=item map">

=begin pod

 built-in map tests

=end pod


my @л갢ò中 = (1 .. 5);

{
    my @сe̲ò갮л中 = map { $_ * 2 }, @л갢ò中;
    is(+@сe̲ò갮л中, 5, 'sub form: we got a list back');
    is @сe̲ò갮л中.join(', '), '2, 4, 6, 8, 10', 'got the values we expected';
}

skip("adverbial block", 2);# {
#     my @result = @list.map():{ $_ * 2 };
#     is(+@result, 5, 'adverbial block: we got a list back');
#     is @result.join(', '), '2, 4, 6, 8, 10', 'got the values we expected';
# }

{
    my @сe̲ò갮л中 = @л갢ò中.map: { $_ * 2 };
    is(+@сe̲ò갮л中, 5, 'invcant colon method form: we got a list back');
    is @сe̲ò갮л中.join(', '), '2, 4, 6, 8, 10', 'got the values we expected';
}

skip("closure as non-final argument", 2);# {
#     my @result = map { $_ * 2 }: @list;
#     is(+@result, 5, 'we got a list back');
#     is @result.join(', '), '2, 4, 6, 8, 10', 'got the values we expected';
# }

# Testing map that returns an array
{
    my @сe̲ò갮л中 = map { slip($_, $_ * 2) }, @л갢ò中;
    is(+@сe̲ò갮л中, 10, 'Slip returned from closure interpolates elements');
    is @сe̲ò갮л中.join(', '),
        '1, 2, 2, 4, 3, 6, 4, 8, 5, 10',
        'got the values we expected';
}

# Testing multiple statements in the closure
{
    my @сe̲ò갮л中 = map {
         my $е갮лл𝐩à中両 = "fish/$_";
         $е갮лл𝐩à中両;
    }, @л갢ò中;
    is(+@сe̲ò갮л中, 5, 'multiple statements in block: we got a list back');
    is @сe̲ò갮л中.join('|'), 'fish/1|fish/2|fish/3|fish/4|fish/5',
        'got the values we expect';
}

{
    my @л갢ò中 = 1 .. 5;
    is +(map {;$_ => 1 }, @л갢ò中), 5,
            'heuristic for block - looks like a closure';

    my %сe̲ò갮л中 = map {; $_ => ($_*2) }, @л갢ò中;
    isa-ok(%сe̲ò갮л中, Hash);
    is %сe̲ò갮л中<1 2 3 4 5>.join(', '), '2, 4, 6, 8, 10',
        ' got the hash we expect';
}

# https://github.com/Raku/old-issue-tracker/issues/4232
# map with n-ary functions
{
  is-deeply (1,2,3,4).map({ $^a + $^b }), (3,7),
    "map() works with 2-ary functions";
  is-deeply (1,2,3).map({ $^a + $^b + $^c  }), (6,),
    "map() works with 3-ary functions";
  is-deeply (1,2,3,4).map({ $^a + $^b + $^c + $^d }), (10,),
    "map() works with 4-ary functions";
  is-deeply (1,2,3,4,5).map({ $^a+$^b+$^c+$^d+$^e }), (15,),
    "map() works with 5-ary functions";
  dies-ok { (1,2,3).map( { $^a + $^b } ) },
    "argument number mismatch on odd-numbered list";
}

{
  is(42.map({$_}),    42,       "method form of map works on numbers");
  is('str'.map({$_}), 'str',    "method form of map works on strings");
}

=begin pod

Test that a constant list can have C<map> applied to it.

  ("foo","bar").map: { $_.substr(1,1) }

should be equivalent to

  my @val = ("foo","bar");
  @val = map { substr($_,1,1) }, @val;

=end pod

{
  my @e̲ч𝐩e̲개中e̲𝐝 = ("foo","bar");
  @e̲ч𝐩e̲개中e̲𝐝 = map { substr($_,1,1) }, @e̲ч𝐩e̲개中e̲𝐝;

  is((("foo","bar").map: { $_.substr(1,1) }), @e̲ч𝐩e̲개中e̲𝐝, "map of constant list works");
}


{
  my @à = (1, 2, 3);
  my @丛 = map { hash("v"=>$_, "d" => $_*2) }, @à;
  is(+@丛, 3, "should be 3 elements");

  my @개 = map { {"v"=>$_, "d" => $_*2} }, @à;
  is(+@개, 3, "should be 6 elements (bare block)");

  is map({("v"=>$_, "d" => $_*2).Slip}, @à).elems, 6, 'flattens with .Slip';
}

# Map with mutating block
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">

{
  my @àссàù = <a b c d>;
  is ~(try { @àссàù.map: { $_ ~= "c"; $_ ~ "d" } }), "acd bcd ccd dcd",
    'mutating $_ in map works (1)';
  is ~@àссàù, "ac bc cc dc",
    'mutating $_ in map works (2)';
}

sub 𝐝丛л ( Int  $val ) { 2*$val };
is( ~((1..3).map: { 2*$_ }),'2 4 6','intern method in map');
is( ~((1..3).map: { 𝐝丛л( $_ ) }),'2 4 6','extern method in map');


# map with empty lists in the block
# Test was primarily aimed at PIL2JS, which did not pass this test (fixed now).
{
  my @àссàù  = <a b c d>;
  my @сe̲ò갮л中 = map { (), }, @àссàù;

  is +@сe̲ò갮л中, 4, "map works with the map body returning an empty list";
}

{
  my @àссàù  = <a b c d>;
  my @e̲ì𝐩中ù  = ();
  my @сe̲ò갮л中 = map { @e̲ì𝐩中ù }, @àссàù;

  is +@сe̲ò갮л中, 4, "map works with the map body returning an empty array";
}

{
  my @àссàù  = <a b c d>;
  my @сe̲ò갮л中 = map { [] }, @àссàù;

  is +@сe̲ò갮л中, 4, "map works with the map body returning an empty arrayitem";
}

{
  my @àссàù  = <a b c d>;
  my $e̲ì𝐩中ù  = [];
  my @сe̲ò갮л中 = map { $e̲ì𝐩中ù }, @àссàù;

  is +@сe̲ò갮л中, 4, "map works with the map body returning an empty arrayitem variable";
}

{
  my @àссàù  = <a b c d>;
  my @сe̲ò갮л中 = map { Mu }, @àссàù;

  is +@сe̲ò갮л中, 4, "map works with the map body returning undefined";
}

{
  my @àссàù  = <a b c d>;
  my $갮丧𝐝e̲е  = Mu;
  my @сe̲ò갮л中 = map { $갮丧𝐝e̲е }, @àссàù;

  is +@сe̲ò갮л中, 4, "map works with the map body returning an undefined variable";
}

{
  my @àссàù  = <a b c d>;
  my @сe̲ò갮л中 = map { () }, @àссàù;

  is +@сe̲ò갮л中, 4, "map works with the map body returning () for each iteration";
}

# test map with a block that takes more than one parameter
{
    my @à=(1,4,2,5,3,6);
    my @сe̲中=map -> $a,$b {$a+$b}, @à;

    is(@сe̲中.elems,3,'map took 2 elements at a time');
    is(@сe̲中[0],5,'first element ok');
    is(@сe̲中[1],7,'second element ok');
    is(@сe̲中[2],9,'third element ok');

}

# map shouldn't flatten array objects
{
    my @foo = [1, 2, 3].map: { [100+$_, 200+$_] };
    is +@foo,    3,         "map should't flatten our arrayitem (1)";
    is +@foo[0], 2,         "map should't flatten our arrayitem (2)";
    is ~@foo[0], "101 201", "map should't flatten our arrayitem (3)";
}

# .thing inside map blocks should still default to $_
{
    is ~((1,2,3).map: { $_.Int }), "1 2 3", "dependency for following test (1)";
    $_ = 4; is .Int, 4,                   "dependency for following test (2)";
    is ~((1,2,3).map: { .Int }),    "1 2 3", 'int() should default to $_ inside map, too';

    is ~(({1},{2},{3}).map: { $_; $_() }), "1 2 3", 'lone $_ in map should work (1)';
    is ~(({1},{2},{3}).map: { $_() }),     "1 2 3", 'lone $_ in map should work (2)';
    is ~(({1},{2},{3}).map: { .() }),     "1 2 3", 'lone .() in map should work (2)';
}

{
    is (1..4).map({ next if $_ % 2; 2 * $_ }).join('|'),
       '4|8', 'next in map works';
    is (1..10).map({ last if $_ % 5 == 0; 2 * $_}).join(' '),
       '2 4 6 8', 'last in map works';
}

# https://github.com/Raku/old-issue-tracker/issues/622
{
    my $ч = :a<5>;
    is $ч.map({ .key, .value + 1}), ('a', 6), 'map on pair works (comma)';
    is $ч.map({ ; .key => .value + 1}), ('a' => 6), 'map on pair works (=>)';
}

# https://github.com/Raku/old-issue-tracker/issues/2723
# https://github.com/Raku/old-issue-tracker/issues/4249
{
    my @à = map &sprintf.assuming("%x"), 9..12;
    is(@à, <9 a b c>, "map over a callable with a slurpy");
}

# https://github.com/Raku/old-issue-tracker/issues/3280
{
    is [foo => (1,2,3).map: {$_}].[0].value.join(":"), '1:2:3',
        'map on list in array does not lose content';
    is {foo => (1,2,3).map: {$_}}<foo>.join(":"), '1:2:3',
        'map on list in hash does not lose content';
}

# https://github.com/Raku/old-issue-tracker/issues/3050
{
    my @à = <foo bar baz>;
    map { s/a/A/ }, @à;
    is @à.join(":"), "foo:bAr:bAz", 'map can modify what it iterates';
}

# https://github.com/Raku/old-issue-tracker/issues/4851
{
    is-deeply Any.map({ Slip }), (Slip,),
        'only defined Slips are treated specially';
}

# https://github.com/rakudo/rakudo/commit/86dc997cc2
{
    my @à = ^3 .map: -> \x --> Int { x };
    is-deeply @à, [0, 1, 2], 'non-slippy-non-phaser map push-all works';

    my $갢 = 0;
    (^3 .map: -> \x --> Int { $갢++ }).sink;
    is-deeply $갢, 3, 'non-slippy-non-phaser map sink-all works';
}

# https://github.com/rakudo/rakudo/issues/5590
{
    my $сà丧ЛÀÒ专;
    my $갢中e̲сà中갨с := (^20).map({
        LAST $сà丧ЛÀÒ专 = True;
        last if $_ == 10;
        $_
    }).iterator;
    Nil until $갢中e̲сà中갨с.pull-one =:= IterationEnd;
    ok $сà丧ЛÀÒ专, 'Did the LAST phaser get run';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
