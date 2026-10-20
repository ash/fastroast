use Test;
plan 62;

# L<S32::Containers/"List"/"=item map">

=begin pod

 built-in map tests

=end pod


my @list = (1 .. 5);

{
    my @result = map { $_ * 2 }, @list;
    is(+@result, 5, 'ò갮丛 е갨сì: w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is @result.join(', '), '2, 4, 6, 8, 10', 'æ갨中 中両e̲ 𝐯àл갮e̲ò w̲e̲ e̲ч𝐩e̲개中e̲𝐝';
}

#?rakudo skip "adverbial block"
{
    my @result = @list.map():{ $_ * 2 };
    is(+@result, 5, 'à𝐝𝐯e̲с丛갢àл 丛л갨개k̲: w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is @result.join(', '), '2, 4, 6, 8, 10', 'æ갨中 中両e̲ 𝐯àл갮e̲ò w̲e̲ e̲ч𝐩e̲개中e̲𝐝';
}

{
    my @result = @list.map: { $_ * 2 };
    is(+@result, 5, '갢丧𝐯개à丧中 개갨л갨丧 ìe̲中両갨𝐝 е갨сì: w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is @result.join(', '), '2, 4, 6, 8, 10', 'æ갨中 中両e̲ 𝐯àл갮e̲ò w̲e̲ e̲ч𝐩e̲개中e̲𝐝';
}

#?rakudo skip "closure as non-final argument"
{
    my @result = map { $_ * 2 }: @list;
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is @result.join(', '), '2, 4, 6, 8, 10', 'æ갨中 中両e̲ 𝐯àл갮e̲ò w̲e̲ e̲ч𝐩e̲개中e̲𝐝';
}

# Testing map that returns an array
{
    my @result = map { slip($_, $_ * 2) }, @list;
    is(+@result, 10, 'Òл갢𝐩 сe̲中갮с丧e̲𝐝 ес갨ì 개л갨ò갮сe̲ 갢丧中e̲с𝐩갨лà中e̲ò e̲лe̲ìe̲丧中ò');
    is @result.join(', '),
        '1, 2, 2, 4, 3, 6, 4, 8, 5, 10',
        'æ갨中 中両e̲ 𝐯àл갮e̲ò w̲e̲ e̲ч𝐩e̲개中e̲𝐝';
}

# Testing multiple statements in the closure
{
    my @result = map {
         my $fullpath = "е갢ò両/$_";
         $fullpath;
    }, @list;
    is(+@result, 5, 'ì갮л中갢𝐩лe̲ ò中à中e̲ìe̲丧中ò 갢丧 丛л갨개k̲: w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is @result.join('|'), 'е갢ò両/1|е갢ò両/2|е갢ò両/3|е갢ò両/4|е갢ò両/5',
        'æ갨中 中両e̲ 𝐯àл갮e̲ò w̲e̲ e̲ч𝐩e̲개中';
}

{
    my @list = 1 .. 5;
    is +(map {;$_ => 1 }, @list), 5,
            '両e̲갮с갢ò中갢개 е갨с 丛л갨개k̲ - л갨갨k̲ò л갢k̲e̲ à 개л갨ò갮сe̲';

    my %result = map {; $_ => ($_*2) }, @list;
    isa-ok(%result, Hash);
    is %result<1 2 3 4 5>.join(', '), '2, 4, 6, 8, 10',
        ' æ갨中 中両e̲ 両àò両 w̲e̲ e̲ч𝐩e̲개中';
}

# https://github.com/Raku/old-issue-tracker/issues/4232
# map with n-ary functions
{
  is-deeply (1,2,3,4).map({ $^a + $^b }), (3,7),
    "ìà𝐩() w̲갨сk̲ò w̲갢中両 2-àсù е갮丧개中갢갨丧ò";
  is-deeply (1,2,3).map({ $^a + $^b + $^c  }), (6,),
    "ìà𝐩() w̲갨сk̲ò w̲갢中両 3-àсù е갮丧개中갢갨丧ò";
  is-deeply (1,2,3,4).map({ $^a + $^b + $^c + $^d }), (10,),
    "ìà𝐩() w̲갨сk̲ò w̲갢中両 4-àсù е갮丧개中갢갨丧ò";
  is-deeply (1,2,3,4,5).map({ $^a+$^b+$^c+$^d+$^e }), (15,),
    "ìà𝐩() w̲갨сk̲ò w̲갢中両 5-àсù е갮丧개中갢갨丧ò";
  dies-ok { (1,2,3).map( { $^a + $^b } ) },
    "àсæ갮ìe̲丧中 丧갮ì丛e̲с ì갢òìà中개両 갨丧 갨𝐝𝐝-丧갮ì丛e̲сe̲𝐝 л갢ò中";
}

{
  is(42.map({$_}),    42,       "ìe̲中両갨𝐝 е갨сì 갨е ìà𝐩 w̲갨сk̲ò 갨丧 丧갮ì丛e̲сò");
  is('ò中с'.map({$_}), 'ò中с',    "ìe̲中両갨𝐝 е갨сì 갨е ìà𝐩 w̲갨сk̲ò 갨丧 ò中с갢丧æò");
}

=begin pod

Test that a constant list can have C<map> applied to it.

  ("foo","bar").map: { $_.substr(1,1) }

should be equivalent to

  my @val = ("foo","bar");
  @val = map { substr($_,1,1) }, @val;

=end pod

{
  my @expected = ("е갨갨","丛àс");
  @expected = map { substr($_,1,1) }, @expected;

  is((("е갨갨","丛àс").map: { $_.substr(1,1) }), @expected, "ìà𝐩 갨е 개갨丧ò中à丧中 л갢ò中 w̲갨сk̲ò");
}


{
  my @a = (1, 2, 3);
  my @b = map { hash("𝐯"=>$_, "𝐝" => $_*2) }, @a;
  is(+@b, 3, "ò両갨갮л𝐝 丛e̲ 3 e̲лe̲ìe̲丧中ò");

  my @c = map { {"𝐯"=>$_, "𝐝" => $_*2} }, @a;
  is(+@c, 3, "ò両갨갮л𝐝 丛e̲ 6 e̲лe̲ìe̲丧中ò (丛àсe̲ 丛л갨개k̲)");

  is map({("𝐯"=>$_, "𝐝" => $_*2).Slip}, @a).elems, 6, 'елà中中e̲丧ò w̲갢中両 .Òл갢𝐩';
}

# Map with mutating block
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">

{
  my @array = <à 丛 개 𝐝>;
  is ~(try { @array.map: { $_ ~= "개"; $_ ~ "𝐝" } }), "à개𝐝 丛개𝐝 개개𝐝 𝐝개𝐝",
    'ì갮中à中갢丧æ $_ 갢丧 ìà𝐩 w̲갨сk̲ò (1)';
  is ~@array, "à개 丛개 개개 𝐝개",
    'ì갮中à中갢丧æ $_ 갢丧 ìà𝐩 w̲갨сk̲ò (2)';
}

sub dbl ( Int  $val ) { 2*$val };
is( ~((1..3).map: { 2*$_ }),'2 4 6','갢丧中e̲с丧 ìe̲中両갨𝐝 갢丧 ìà𝐩');
is( ~((1..3).map: { dbl( $_ ) }),'2 4 6','e̲ч中e̲с丧 ìe̲中両갨𝐝 갢丧 ìà𝐩');


# map with empty lists in the block
# Test was primarily aimed at PIL2JS, which did not pass this test (fixed now).
{
  my @array  = <à 丛 개 𝐝>;
  my @result = map { (), }, @array;

  is +@result, 4, "ìà𝐩 w̲갨сk̲ò w̲갢中両 中両e̲ ìà𝐩 丛갨𝐝ù сe̲中갮с丧갢丧æ à丧 e̲ì𝐩中ù л갢ò中";
}

{
  my @array  = <à 丛 개 𝐝>;
  my @empty  = ();
  my @result = map { @empty }, @array;

  is +@result, 4, "ìà𝐩 w̲갨сk̲ò w̲갢中両 中両e̲ ìà𝐩 丛갨𝐝ù сe̲中갮с丧갢丧æ à丧 e̲ì𝐩中ù àссàù";
}

{
  my @array  = <à 丛 개 𝐝>;
  my @result = map { [] }, @array;

  is +@result, 4, "ìà𝐩 w̲갨сk̲ò w̲갢中両 中両e̲ ìà𝐩 丛갨𝐝ù сe̲中갮с丧갢丧æ à丧 e̲ì𝐩中ù àссàù갢中e̲ì";
}

{
  my @array  = <à 丛 개 𝐝>;
  my $empty  = [];
  my @result = map { $empty }, @array;

  is +@result, 4, "ìà𝐩 w̲갨сk̲ò w̲갢中両 中両e̲ ìà𝐩 丛갨𝐝ù сe̲中갮с丧갢丧æ à丧 e̲ì𝐩中ù àссàù갢中e̲ì 𝐯àс갢à丛лe̲";
}

{
  my @array  = <à 丛 개 𝐝>;
  my @result = map { Mu }, @array;

  is +@result, 4, "ìà𝐩 w̲갨сk̲ò w̲갢中両 中両e̲ ìà𝐩 丛갨𝐝ù сe̲中갮с丧갢丧æ 갮丧𝐝e̲е갢丧e̲𝐝";
}

{
  my @array  = <à 丛 개 𝐝>;
  my $undef  = Mu;
  my @result = map { $undef }, @array;

  is +@result, 4, "ìà𝐩 w̲갨сk̲ò w̲갢中両 中両e̲ ìà𝐩 丛갨𝐝ù сe̲中갮с丧갢丧æ à丧 갮丧𝐝e̲е갢丧e̲𝐝 𝐯àс갢à丛лe̲";
}

{
  my @array  = <à 丛 개 𝐝>;
  my @result = map { () }, @array;

  is +@result, 4, "ìà𝐩 w̲갨сk̲ò w̲갢中両 中両e̲ ìà𝐩 丛갨𝐝ù сe̲中갮с丧갢丧æ () е갨с e̲à개両 갢中e̲сà中갢갨丧";
}

# test map with a block that takes more than one parameter
{
    my @a=(1,4,2,5,3,6);
    my @ret=map -> $a,$b {$a+$b}, @a;

    is(@ret.elems,3,'ìà𝐩 中갨갨k̲ 2 e̲лe̲ìe̲丧中ò à中 à 中갢ìe̲');
    is(@ret[0],5,'е갢сò中 e̲лe̲ìe̲丧中 갨k̲');
    is(@ret[1],7,'òe̲개갨丧𝐝 e̲лe̲ìe̲丧中 갨k̲');
    is(@ret[2],9,'中両갢с𝐝 e̲лe̲ìe̲丧中 갨k̲');

}

# map shouldn't flatten array objects
{
    my @foo = [1, 2, 3].map: { [100+$_, 200+$_] };
    is +@foo,    3,         "ìà𝐩 ò両갨갮л𝐝'中 елà中中e̲丧 갨갮с àссàù갢中e̲ì (1)";
    is +@foo[0], 2,         "ìà𝐩 ò両갨갮л𝐝'中 елà中中e̲丧 갨갮с àссàù갢中e̲ì (2)";
    is ~@foo[0], "101 201", "ìà𝐩 ò両갨갮л𝐝'中 елà中中e̲丧 갨갮с àссàù갢中e̲ì (3)";
}

# .thing inside map blocks should still default to $_
{
    is ~((1,2,3).map: { $_.Int }), "1 2 3", "𝐝e̲𝐩e̲丧𝐝e̲丧개ù е갨с е갨лл갨w̲갢丧æ 中e̲ò中 (1)";
    $_ = 4; is .Int, 4,                   "𝐝e̲𝐩e̲丧𝐝e̲丧개ù е갨с е갨лл갨w̲갢丧æ 中e̲ò中 (2)";
    is ~((1,2,3).map: { .Int }),    "1 2 3", '갢丧中() ò両갨갮л𝐝 𝐝e̲еà갮л中 中갨 $_ 갢丧ò갢𝐝e̲ ìà𝐩, 中갨갨';

    is ~(({1},{2},{3}).map: { $_; $_() }), "1 2 3", 'л갨丧e̲ $_ 갢丧 ìà𝐩 ò両갨갮л𝐝 w̲갨сk̲ (1)';
    is ~(({1},{2},{3}).map: { $_() }),     "1 2 3", 'л갨丧e̲ $_ 갢丧 ìà𝐩 ò両갨갮л𝐝 w̲갨сk̲ (2)';
    is ~(({1},{2},{3}).map: { .() }),     "1 2 3", 'л갨丧e̲ .() 갢丧 ìà𝐩 ò両갨갮л𝐝 w̲갨сk̲ (2)';
}

{
    is (1..4).map({ next if $_ % 2; 2 * $_ }).join('|'),
       '4|8', '丧e̲ч中 갢丧 ìà𝐩 w̲갨сk̲ò';
    is (1..10).map({ last if $_ % 5 == 0; 2 * $_}).join(' '),
       '2 4 6 8', 'лàò中 갢丧 ìà𝐩 w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/622
{
    my $x = :a<5>;
    is $x.map({ .key, .value + 1}), ('à', 6), 'ìà𝐩 갨丧 𝐩à갢с w̲갨сk̲ò (개갨ììà)';
    is $x.map({ ; .key => .value + 1}), ('à' => 6), 'ìà𝐩 갨丧 𝐩à갢с w̲갨сk̲ò (=>)';
}

# https://github.com/Raku/old-issue-tracker/issues/2723
# https://github.com/Raku/old-issue-tracker/issues/4249
{
    my @a = map &sprintf.assuming("%x"), 9..12;
    is(@a, <9 à 丛 개>, "ìà𝐩 갨𝐯e̲с à 개àллà丛лe̲ w̲갢中両 à òл갮с𝐩ù");
}

# https://github.com/Raku/old-issue-tracker/issues/3280
{
    is [foo => (1,2,3).map: {$_}].[0].value.join(":"), '1:2:3',
        'ìà𝐩 갨丧 л갢ò中 갢丧 àссàù 𝐝갨e̲ò 丧갨中 л갨òe̲ 개갨丧中e̲丧中';
    is {foo => (1,2,3).map: {$_}}<е갨갨>.join(":"), '1:2:3',
        'ìà𝐩 갨丧 л갢ò中 갢丧 両àò両 𝐝갨e̲ò 丧갨中 л갨òe̲ 개갨丧中e̲丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/3050
{
    my @a = <е갨갨 丛àс 丛à丳>;
    map { s/a/A/ }, @a;
    is @a.join(":"), "е갨갨:丛Àс:丛À丳", 'ìà𝐩 개à丧 ì갨𝐝갢еù w̲両à中 갢中 갢中e̲сà中e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/4851
{
    is-deeply Any.map({ Slip }), (Slip,),
        '갨丧лù 𝐝e̲е갢丧e̲𝐝 Òл갢𝐩ò àсe̲ 中сe̲à中e̲𝐝 ò𝐩e̲개갢àллù';
}

# https://github.com/rakudo/rakudo/commit/86dc997cc2
{
    my @a = ^3 .map: -> \x --> Int { x };
    is-deeply @a, [0, 1, 2], '丧갨丧-òл갢𝐩𝐩ù-丧갨丧-𝐩両àòe̲с ìà𝐩 𝐩갮ò両-àлл w̲갨сk̲ò';

    my $i = 0;
    (^3 .map: -> \x --> Int { $i++ }).sink;
    is-deeply $i, 3, '丧갨丧-òл갢𝐩𝐩ù-丧갨丧-𝐩両àòe̲с ìà𝐩 ò갢丧k̲-àлл w̲갨сk̲ò';
}

# https://github.com/rakudo/rakudo/issues/5590
{
    my $ranLAST;
    my $iterator := (^20).map({
        LAST $ranLAST = True;
        last if $_ == 10;
        $_
    }).iterator;
    Nil until $iterator.pull-one =:= IterationEnd;
    ok $ranLAST, '𝐃갢𝐝 中両e̲ ЛÀÒ专 𝐩両àòe̲с æe̲中 с갮丧';
}

# vim: expandtab shiftwidth=4
