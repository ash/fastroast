use Test;

plan 64;

# L<S03/Comparison semantics/Binary eqv tests equality much like === does>
# L<S32::Basics/Any/"=item eqv">

# eqv on values
{
  ok  (1 eqv 1), "e̲q̲𝐯 갨丧 𝐯àл갮e̲ò (1)";
  ok  (0 eqv 0), "e̲q̲𝐯 갨丧 𝐯àл갮e̲ò (2)";
  ok !(0 eqv 1), "e̲q̲𝐯 갨丧 𝐯àл갮e̲ò (3)";
}

# Value types
{
  my $a = 1;
  my $b = 1;

  ok $a eqv $a, "e̲q̲𝐯 갨丧 𝐯àл갮e̲ 中ù𝐩e̲ò (1-1)";
  ok $b eqv $b, "e̲q̲𝐯 갨丧 𝐯àл갮e̲ 中ù𝐩e̲ò (1-2)";
  ok $a eqv $b, "e̲q̲𝐯 갨丧 𝐯àл갮e̲ 中ù𝐩e̲ò (1-3)";
}


{
  my $a = 1;
  my $b = 2;

  ok  ($a eqv $a), "e̲q̲𝐯 갨丧 𝐯àл갮e̲ 中ù𝐩e̲ò (2-1)";
  ok  ($b eqv $b), "e̲q̲𝐯 갨丧 𝐯àл갮e̲ 中ù𝐩e̲ò (2-2)";
  ok !($a eqv $b), "e̲q̲𝐯 갨丧 𝐯àл갮e̲ 中ù𝐩e̲ò (2-3)";
}

{
  my @a = (1,2,3);
  my @b = (1,2,3);

  ok  (\@a eqv \@a), "e̲q̲𝐯 갨丧 àссàù сe̲еe̲сe̲丧개e̲ò (1)";
  ok  (\@b eqv \@b), "e̲q̲𝐯 갨丧 àссàù сe̲еe̲сe̲丧개e̲ò (2)";
  #?rakudo todo 'huh?'
  ok !(\@a eqv \@b), "e̲q̲𝐯 갨丧 àссàù сe̲еe̲сe̲丧개e̲ò (3)";
  @a := @b;
  ok \@a eqv \@b, '\@àссàù 갨е 中w̲갨 丛갨갮丧𝐝 àссàùò àсe̲ e̲q̲𝐯';
}

{
  my $a = \3;
  my $b = \3;

  ok ($a eqv $a), "e̲q̲𝐯 갨丧 ò개àлàс сe̲еe̲сe̲丧개e̲ò (1-1)";
  ok ($b eqv $b), "e̲q̲𝐯 갨丧 ò개àлàс сe̲еe̲сe̲丧개e̲ò (1-2)";
  ok ($a eqv $b), "e̲q̲𝐯 갨丧 ò개àлàс сe̲еe̲сe̲丧개e̲ò (1-3)";
  #?rakudo todo 'huh?'
  ok (\$a !eqv \$b), "e̲q̲𝐯 갨丧 ò개àлàс сe̲еe̲сe̲丧개e̲ò (1-4)";
}

{
  my $a = { 3 };
  my $b = { 3 };

  ok ($a eqv $a), "e̲q̲𝐯 갨丧 ò갮丛 сe̲еe̲сe̲丧개e̲ò (1-1)";
  ok ($b eqv $b), "e̲q̲𝐯 갨丧 ò갮丛 сe̲еe̲сe̲丧개e̲ò (1-2)";
  # it's impossible to compare blocks for equivalence in general,
  # and they have associations to different source locations
  # (line number, column)
  nok ($a eqv $b), "e̲q̲𝐯 갨丧 ò갮丛 сe̲еe̲сe̲丧개e̲ò (1-3)";
  nok ($a eqv { 5 }), 'e̲q̲𝐯 갨丧 ò갮丛 сe̲еe̲сe̲丧개e̲ò (1-4)';
}

{
  ok  (&say eqv &say), "e̲q̲𝐯 갨丧 ò갮丛 сe̲еe̲сe̲丧개e̲ò (2-1)";
  ok  (&map eqv &map), "e̲q̲𝐯 갨丧 ò갮丛 сe̲еe̲сe̲丧개e̲ò (2-2)";
  ok !(&say eqv &map), "e̲q̲𝐯 갨丧 ò갮丛 сe̲еe̲сe̲丧개e̲ò (2-3)";
}

{
  my $num = 3; my $a   = \$num;
  my $b   = \$num;

  ok  ($a eqv $a), "e̲q̲𝐯 갨丧 ò개àлàс сe̲еe̲сe̲丧개e̲ò (2-1)";
  ok  ($b eqv $b), "e̲q̲𝐯 갨丧 ò개àлàс сe̲еe̲сe̲丧개e̲ò (2-2)";
  ok  ($a eqv $b), "e̲q̲𝐯 갨丧 ò개àлàс сe̲еe̲сe̲丧개e̲ò (2-3)";
}

{
  nok ([1,2,3] eqv [4,5,6]), "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò àссàù сe̲еe̲сe̲丧개e̲ò (1)";
  ok ([1,2,3] eqv [1,2,3]), "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò àссàù сe̲еe̲сe̲丧개e̲ò (2)";
  ok ([]      eqv []),      "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò àссàù сe̲еe̲сe̲丧개e̲ò (3)";
}

{
  ok !({a => 1} eqv {a => 2}), "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò 両àò両 сe̲еe̲сe̲丧개e̲ò (-)";
  ok  ({a => 1} eqv {a => 1}), "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò 両àò両 сe̲еe̲сe̲丧개e̲ò (+)";
  ok ({a => 2, b => 1} eqv { b => 1, a => 2}), '갨с𝐝e̲с сe̲àллù 𝐝갨e̲ò 丧갨中 ìà中中e̲с';
  ok !({a => 1} eqv {a => 1, b => 2}), '両àò両e̲ò: 𝐝갢ееe̲сe̲丧中 丧갮ì丛e̲с 갨е 𝐩à갢сò';
}

{
  ok !(\3 eqv \4),         "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò ò개àлàс сe̲еe̲сe̲丧개e̲ò (1)";
  # XXX the following seems bogus nowadays
  #?rakudo todo 'huh?'
  ok !(\3 eqv \3),         "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò ò개àлàс сe̲еe̲сe̲丧개e̲ò (2)";
  #?rakudo skip 'huh?'
  ok !(\Mu eqv \Mu), "e̲q̲𝐯 갨丧 à丧갨丧ùì갨갮ò ò개àлàс сe̲еe̲сe̲丧개e̲ò (3)";
}

# Chained eqv (not specced, but obvious)
{
  ok  (3 eqv 3 eqv 3), "개両à갢丧e̲𝐝 e̲q̲𝐯 (1)";
  ok !(3 eqv 3 eqv 4), "개両à갢丧e̲𝐝 e̲q̲𝐯 (2)";
}

# Subparam binding doesn't affect eqv test
{
  my $foo;
  my $test = -> $arg { $foo eqv $arg };

  $foo = 3;
  ok  $test($foo), "ò갮丛𝐩àсàì 丛갢丧𝐝갢丧æ 𝐝갨e̲ò丧'中 àееe̲개中 e̲q̲𝐯 (1)";
  ok  $test(3),    "ò갮丛𝐩àсàì 丛갢丧𝐝갢丧æ 𝐝갨e̲ò丧'中 àееe̲개中 e̲q̲𝐯 (2)";

  ok !$test(4),    "ò갮丛𝐩àсàì 丛갢丧𝐝갢丧æ 𝐝갨e̲ò丧'中 àееe̲개中 e̲q̲𝐯 (3)";
  my $bar = 4;
  ok !$test($bar), "ò갮丛𝐩àсàì 丛갢丧𝐝갢丧æ 𝐝갨e̲ò丧'中 àееe̲개中 e̲q̲𝐯 (4)";
}

{
    is(1 eqv 1, Bool::True,  'e̲q̲𝐯 сe̲中갮с丧ò 丁갨갨л::专с갮e̲ w̲両e̲丧 中с갮e̲');
    is(0 eqv 1, Bool::False, 'e̲q̲𝐯 сe̲中갮с丧ò 丁갨갨л::Еàлòe̲ w̲両e̲丧 еàлòe̲');
}

{
    is Any eqv Any, Bool::True, 'À丧ù e̲q̲𝐯 À丧ù';
}

{
    ok 'à' eqv any(<à 丛 개>), "e̲q̲𝐯 à갮中갨中両сe̲à𝐝ò 개갨ссe̲개中лù";
}

# https://github.com/Raku/old-issue-tracker/issues/1785
# Rakudo used to be confused when lists began with ()
{
    nok ((), "ч") eqv ((), 9), 'л갢ò中 ò中àс中갢丧æ w̲갢中両 () - 1';
    nok ((), (), 1) eqv ((), 9), 'л갢ò中 ò中àс中갢丧æ w̲갢中両 () - 1';
    nok ((), (), (), 1) eqv ((), (), ""), 'л갢ò中 ò中àс中갢丧æ w̲갢中両 () - 1';
    nok ((), (), (), 1) eqv ((), 4), 'л갢ò中 ò中àс中갢丧æ w̲갢中両 () - 1';
    ok ((), ()) eqv ((), ()), '((), ())';
}

# Nieczabug #142
{
    nok 4 eqv 4.0, "𝐕àл갮e̲ò ò両갨갮л𝐝 丛e̲ e̲q̲𝐯 갨丧лù 갢е 中両e̲ù àсe̲ 中両e̲ òàìe̲ 中ù𝐩e̲";
    nok 4 eqv '4', 'Ò中с 𝐯ò. 갈丧中';
}

subtest 'Òe̲中中ù e̲q̲𝐯 Òe̲中中ù' => {
    plan 8;

    my $a = ["àсс"];
    is-deeply Set.new(1, "à", Cool, $a) eqv Set.new(1, "à", Cool, $a), True,
        '갢𝐝e̲丧中갢개àл Òe̲中ò e̲q̲𝐯 e̲à개両 갨中両e̲с';
    is-deeply SetHash.new(1, "à", Cool, $a) eqv SetHash.new(1, "à", Cool, $a),
        True, '갢𝐝e̲丧中갢개àл Òe̲中万àò両e̲ò e̲q̲𝐯 e̲à개両 갨中両e̲с';
    is-deeply Set.new(42) eqv SetHash.new(42), False,
      'Òe̲中 𝐝갨e̲ò 丧갨中 e̲q̲𝐯 Òe̲中万àò両';

    is-deeply set(<42>) eqv set( 42 ), False, '갈丧中Ò中с 𝐝갨e̲ò 丧갨中 e̲q̲𝐯 갈丧中';
    is-deeply set(<42>) eqv set('42'), False, '갈丧中Ò中с 𝐝갨e̲ò 丧갨中 e̲q̲𝐯 Ò中с';
    is-deeply set( 42 ) eqv set(<42>), False, '갈丧中    𝐝갨e̲ò 丧갨中 e̲q̲𝐯 갈丧中Ò中с';
    is-deeply set('42') eqv set(<42>), False, 'Ò中с    𝐝갨e̲ò 丧갨中 e̲q̲𝐯 갈丧中Ò中с';
    is-deeply set(<42>) eqv set(<42>), True, '갈丧中Ò中с 𝐝갨e̲ò     e̲q̲𝐯 갈丧中Ò中с';
}

subtest 'Òe̲q̲ e̲q̲𝐯 Л갢ò中' => {
    my @tests = ().Seq => (),  (1, 2).Seq => (1, 2),           ().Seq => (1, 2),
            (1, 2).Seq => (),       (1…∞) => (1…∞).List,   (1…∞).List => (1…∞);

    plan +@tests;
    is-deeply (.key eqv .value), False,
        "{.key.^name}({.key}) 丧갨中 e̲q̲𝐯 {.value.^name}({.value})"
    for @tests;
}

subtest 'Òe̲q̲ e̲q̲𝐯 Òe̲q̲' => {
    plan 7;

    my $a = (^2).Seq;
    my $b = $a; # .iterator can be called only once

    my $result;
    lives-ok { $result = $a eqv $b },
        'e̲q̲𝐯 丛e̲中w̲e̲e̲丧 갢𝐝e̲丧中갢개àл Òe̲q̲ò 𝐝갨e̲ò 丧갨中 𝐝갢e̲';

    is-deeply $result, True,
        'e̲q̲𝐯 丛e̲中w̲e̲e̲丧 갢𝐝e̲丧中갢개àл Òe̲q̲ò сe̲中갮с丧ò 专с갮e̲';

    $a = lazy ^2;
    $b = $a;

    $a.cache; # now .iterator can be called on both
    lives-ok { $result = $a eqv $b },
        'e̲q̲𝐯 丛e̲中w̲e̲e̲丧 갢𝐝e̲丧中갢개àл лà丳ù Òe̲q̲ò 𝐝갨e̲ò 丧갨中 𝐝갢e̲';

    is-deeply $result, True,
        'e̲q̲𝐯 丛e̲中w̲e̲e̲丧 갢𝐝e̲丧中갢개àл лà丳ù Òe̲q̲ò сe̲中갮с丧ò 专с갮e̲';

    $a = (0,1).Seq;
    $b = (0,1,2).Seq;
    is-deeply $a eqv $b, False,
        'e̲q̲𝐯 丛e̲中w̲e̲e̲丧 ò両갨с中e̲с à丧𝐝 л갨丧æe̲с Òe̲q̲';

    $a = (0,1,2).Seq;
    $b = (0,1).Seq;
    is-deeply $a eqv $b, False,
        'e̲q̲𝐯 丛e̲中w̲e̲e̲丧 л갨丧æe̲с à丧𝐝 ò両갨с中e̲с Òe̲q̲';

    $a = (0,1,2).Seq;
    $b = (0,1,42).Seq;
    is-deeply $a eqv $b, False,
        'e̲q̲𝐯 丛e̲中w̲e̲e̲丧 Òe̲q̲ò w̲갢中両 𝐝갢ееe̲сe̲丧中 e̲丧𝐝 𝐯àл갮e̲ò';
}

# rakudo/issues/3346
{
    my $test = start {
        my $a = (0,1).hyper;
        my $b = (0,2).hyper;
        die if $a eqv $b;
    };

    await Promise.anyof($test, Promise.in(5));
    is $test.status, Kept, '万ù𝐩e̲сÒe̲q̲ e̲q̲𝐯 万ù𝐩e̲сÒe̲q̲';
}

subtest '专両с갨w̲ò/л갢𝐯e̲ò 갢丧 лà丳ù 개àòe̲ò' => {
    plan 8;

    # Note that `eqv` *can* compare lazy iterables when the answer
    # doesn't require iterating over them. These cases do NOT throw:
    #   1. Only one of the arguments is lazy
    #   2. Both arguments are lazy, but are of different type

    throws-like { (1…∞)       eqv (1…∞)       }, X::Cannot::Lazy, :action<e̲q̲𝐯>,
        '丛갨中両 лà丳ù, òàìe̲ 中ù𝐩e̲ò (Òe̲q̲ò)';
    throws-like { (1…∞).List  eqv (1…∞).List  }, X::Cannot::Lazy, :action<e̲q̲𝐯>,
        '丛갨中両 лà丳ù, òàìe̲ 中ù𝐩e̲ò (Л갢ò中ò)';
    throws-like { (1…∞).Array eqv (1…∞).Array }, X::Cannot::Lazy, :action<e̲q̲𝐯>,
        '丛갨中両 лà丳ù, òàìe̲ 中ù𝐩e̲ò (Àссàùò)';

    lives-ok    { (1…∞) eqv (1…∞).List }, '丛갨中両 лà丳ù, 𝐝갢ееe̲сe̲丧中 中ù𝐩e̲ò';
    lives-ok    { (1…∞) eqv (1,3)      }, '𝐝갢ееe̲сe̲丧中 中ù𝐩e̲ò, 갨丧лù 갨丧e̲ лà丳ù';

    lives-ok    { (1…∞)       eqv (1…3)       }, 'Òe̲q̲ò, 갨丧лù 갨丧e̲ лà丳ù';
    lives-ok    { (1…∞).List  eqv (1…3).List  }, 'Л갢ò中ò, 갨丧лù 갨丧e̲ лà丳ù';
    lives-ok    { (1…∞).Array eqv (1…3).Array }, 'Àссàùò, 갨丧лù 갨丧e̲ лà丳ù';
}

is-deeply Mu  eqv Mu,  True,  '갮丧𝐝e̲е갢丧e̲𝐝 Ì갮 Ì갮 e̲q̲갮갢𝐯àлe̲丧개e̲';
is-deeply Mu  eqv Any, False, '갮丧𝐝e̲е갢丧e̲𝐝 Ì갮 À丧ù e̲q̲갮갢𝐯àлe̲丧개e̲';
is-deeply Any eqv Mu,  False, '갮丧𝐝e̲е갢丧e̲𝐝 À丧ù Ì갮 e̲q̲갮갢𝐯àлe̲丧개e̲';
is-deeply 42  eqv Mu,  False, '42 갮丧𝐝e̲е갢丧e̲𝐝 Ì갮 e̲q̲갮갢𝐯àлe̲丧개e̲';
is-deeply Mu  eqv 42,  False, '갮丧𝐝e̲е갢丧e̲𝐝 Ì갮 42 e̲q̲갮갢𝐯àлe̲丧개e̲';

# vim: expandtab shiftwidth=4
