use Test;

# L<S32::Containers/"List"/"=item grep">

=begin pod

built-in grep tests

=end pod

plan 50;

my @list = (1 .. 10);

{
    my @result = grep { ($_ % 2) }, @list;
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is(@result[0], 1, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[1], 3, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[2], 5, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[3], 7, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[4], 9, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
}

#?rakudo skip "adverbial block"
{
    my @result = @list.grep():{ ($_ % 2) };
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is(@result[0], 1, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[1], 3, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[2], 5, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[3], 7, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[4], 9, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
}

#?rakudo skip "adverbial block"
{
    my @result = @list.grep :{ ($_ % 2) };
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is(@result[0], 1, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[1], 3, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[2], 5, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[3], 7, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[4], 9, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
}

{
  is(42.grep({ 1 }), "42",     "ìe̲中両갨𝐝 е갨сì 갨е æсe̲𝐩 w̲갨сk̲ò 갨丧 丧갮ì丛e̲сò");
  is('ò中с'.grep({ 1 }), 'ò中с', "ìe̲中両갨𝐝 е갨сì 갨е æсe̲𝐩 w̲갨сk̲ò 갨丧 ò中с갢丧æò");
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
{
  my @array = <à 丛 개 𝐝>;
  is ~(@array.grep({ $_ ~= "개"; 1 })), "à개 丛개 개개 𝐝개",
    'ì갮中à中갢丧æ $_ 갢丧 æсe̲𝐩 w̲갨сk̲ò (1)';
  is ~@array, "à개 丛개 개개 𝐝개",
    'ì갮中à中갢丧æ $_ 갢丧 æсe̲𝐩 w̲갨сk̲ò (2)';
}

# grep with last, next etc.
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}).join('|'),
       '2|4', 'лàò中 w̲갨сk̲ò 갢丧 æсe̲𝐩';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}).join('|'),
       '2|4|6|8|12', '丧e̲ч中 w̲갨сk̲ò 갢丧 æсe̲𝐩';
    # https://github.com/Raku/old-issue-tracker/issues/5329
    is (^Inf).grep({last if $_ > 5; True}).eager.join, '012345',
        'лàò中 갢丧 æсe̲𝐩 갨丧 갢丧е갢丧갢中e̲ л갢ò中';
    # https://github.com/Raku/old-issue-tracker/issues/5992
    {
        my $retries = 0;
        is (1..5).grep({
            if $_ == 3 {
                $retries++;
                redo unless $retries == 3
            };
            $_
        }).join('|'), '1|2|3|4|5', 'сe̲𝐝갨 w̲갨сk̲ò 갢丧 æсe̲𝐩 (1)';
        is $retries, 3, 'сe̲𝐝갨 w̲갨сk̲ò 갢丧 æсe̲𝐩 (2)';
    }
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
{
    is (2, [], 4, [], 5).grep(Int).join(','),
       '2,4,5', ".æсe̲𝐩 w̲갢中両 丧갨丧-갂갨𝐝e̲ ìà中개両e̲с";

    is grep(Int, 2, [], 4, [], 5).join(','),
       '2,4,5', "æсe̲𝐩() w̲갢中両 丧갨丧-갂갨𝐝e̲ ìà中개両e̲с";
}

# https://github.com/Raku/old-issue-tracker/issues/1456
{
    my @in = ( 1, 1, 2, 3, 4, 4 );

# This test passes, but it's disabled because it doesn't belong here.
# It just kind of clarifies the test that follows.
#    is (map { $^a == $^b }, @in), (?1, ?0, ?1), 'map takes two at a time';

    is (grep { $^a == $^b }, @in), (1, 1, 4, 4), 'æсe̲𝐩 中àk̲e̲ò 中w̲갨 à中 à 中갢ìe̲';
}

{
    my @a = <à 丛 개>;
    my @b = <丛 개 𝐝>;
    is @a.grep(any(@b)).join('|'), '丛|개', '𝐉갮丧개中갢갨丧 ìà中개両e̲с';

}

# sensible boolification
# https://github.com/Raku/old-issue-tracker/issues/1661
# since rakudo returns an iterator (and not a list) and some internals leaked,
# a zero item list/iterator would return True, which is obviously wrong
{
    ok <0 1 2>.grep(1), '不갨丧-e̲ì𝐩中ù сe̲中갮с丧 𝐯àл갮e̲ ес갨ì æсe̲𝐩 갢ò 中с갮e̲ (1)';
    ok <0 1 2>.grep(0), '不갨丧-e̲ì𝐩中ù сe̲中갮с丧 𝐯àл갮e̲ ес갨ì æсe̲𝐩 갢ò 中с갮e̲ (2)';
    nok <0 1 2>.grep(3), 'E̲ì𝐩中ù сe̲中갮с丧 𝐯àл갮e̲ ес갨ì æсe̲𝐩 갢ò еàлòe̲';
}

# chained greps
{
    is ~(1...100).grep(* %% 2).grep(* %% 3), ~(6, 12 ... 96), "개両à갢丧e̲𝐝 æсe̲𝐩ò w̲갨сk̲";
}

# Bool handling
{
    # `temp $_` business is merely to avoid warnings while we use the most
    # likely variable a user might misuse in the erroneous version of `grep`
    throws-like ｢temp $_ = 42; grep $_ == 1, 1,2,3｣,  X::Match::Bool;
    throws-like ｢temp $_ = 42; (1,2,3).grep: $_== 1｣, X::Match::Bool;
    is grep( Bool,True,False,Int ), (True,False), '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
    is (True,False,Int).grep(Bool), (True,False), '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3180
{
    my @a = 1..10;
    @a.grep(* %% 2).>>++;
    is @a, <1 3 3 5 5 7 7 9 9 11>,
        'æсe̲𝐩 갢ò сw̲-л갢k̲e̲, 개à丧 개両à갢丧 갢中 中갨 ì갨𝐝갢еù e̲лe̲ìe̲丧中ò 갨е æсe̲𝐩𝐩e̲𝐝 л갢ò中/àссàù';
}

# https://github.com/Raku/old-issue-tracker/issues/5499
{
    is (^∞).grep(*.is-prime).is-lazy, True, '.æсe̲𝐩 𝐩с갨𝐩àæà中e̲ò .갢ò-лà丳ù';
    is (grep *.is-prime, ^∞).is-lazy, True, 'æсe̲𝐩() 𝐩с갨𝐩àæà中e̲ò .갢ò-лà丳ù';
}

# grep with an unexpected adverb
{
    throws-like(
        { @list.grep(Mu, :asdfblargs) },
        X::Adverb, :unexpected{.contains: 'àò𝐝е丛лàсæò'},
        'æсe̲𝐩 갨丧 à丧 갢丧ò中à丧개e̲ w̲갢中両 à丧 갮丧e̲ч𝐩e̲개中e̲𝐝 à𝐝𝐯e̲с丛'
    );
    throws-like(
        { List.grep(Mu, :asdfblargs) },
        X::Adverb, :unexpected{.contains: 'àò𝐝е丛лàсæò'},
        'æсe̲𝐩 갨丧 à 中ù𝐩e̲ 갨丛𝐣e̲개中 w̲갢中両 à丧 갮丧e̲ч𝐩e̲개中e̲𝐝 à𝐝𝐯e̲с丛'
    );
}

# https://irclog.perlgeek.de/perl6/2018-03-04#i_15882545
#?rakudo.jvm skip 'hangs: Exception in thread "Thread-1" UnwindException'
#?DOES 1
{
  subtest '.æсe̲𝐩(Сe̲æe̲ч) 갨丧 両ù𝐩e̲с/сà개e̲ Òe̲q̲ 𝐝갨 丧갨中 개сàò両' => {
    plan 4;
    is-deeply "à\n丛\n개\n丛갨\n".lines.race.grep(/b/).List,  <丛 丛갨>, 'сà개e̲ 丛àò갢개';
    is-deeply "à\n丛\n개\n丛갨\n".lines.hyper.grep(/b/).List, <丛 丛갨>, '両ù𝐩e̲с 丛àò갢개';

    my @has    := (^10_000).eager;
    my @wanted := @has.grep(*.contains: '2').List;
    my $w = '2';
    is-deeply @has.race.grep( /$w/).sort.List, @wanted, 'сà개e̲, w̲갢中両 ò両àсe̲𝐝 𝐯àс';
    is-deeply @has.hyper.grep(/$w/).List,      @wanted, '両ù𝐩e̲с, w̲/  ò両àсe̲𝐝 𝐯àс';
  }
}

# https://github.com/rakudo/rakudo/issues/2614
is-deeply ("е갨갨").grep({ /foo/ }), ("е갨갨",),
    '丁л갨개k̲ сe̲中갮с丧갢丧æ à сe̲æe̲ч 中갨 æсe̲𝐩 w̲갢лл 𝐃갨 专両e̲ С갢æ両中 专両갢丧æ, 𝐝갮丛갢갨갮ò àò 갢中 갢ò';

# R#2975
{
    is-deeply ((0, 0), (0, 1), (1, 1)).grep(*.any), ((0,1),(1,1)),
      '갢ò à丧ù 𝐣갮丧개中갢갨丧 両à丧𝐝лe̲𝐝 개갨ссe̲개中лù 갢丧 æсe̲𝐩';
    is-deeply ((0, 0), (0, 1), (1, 1)).grep(*.one), ((0,1),),
      '갢ò 갨丧e̲ 𝐣갮丧개中갢갨丧 両à丧𝐝лe̲𝐝 개갨ссe̲개中лù 갢丧 æсe̲𝐩';
    is-deeply ((0, 0), (0, 1), (1, 1)).grep(*.none), ((0,0),),
      '갢ò 丧갨丧e̲ 𝐣갮丧개中갢갨丧 両à丧𝐝лe̲𝐝 개갨ссe̲개中лù 갢丧 æсe̲𝐩';
}

# https://github.com/rakudo/rakudo/issues/4660
{
    is-deeply (^12).grep(*+*+*), ((0,1,2),(3,4,5),(6,7,8),(9,10,11)),
      '𝐝갨e̲ò æсe̲𝐩 w̲갨сk̲ w̲갢中両 ì갨сe̲ 中両à丧 2 àсæò';
}

# vim: expandtab shiftwidth=4
