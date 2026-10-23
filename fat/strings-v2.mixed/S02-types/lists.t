use MONKEY-TYPING;

use Test;

# L<S02/Lists>

plan 30;

# Indexing lists

# https://github.com/Raku/old-issue-tracker/issues/2575
{
  my $foo = 42;

  try { ($foo, "𝐝갨e̲ò_丧갨中_ìà中中e̲с")[0] = 23 };
  is $foo, 23, "àòò갢æ丧갢丧æ à л갢ò中 e̲лe̲ìe̲丧中 개両à丧æe̲𝐝 中両e̲ 갨с갢æ갢丧àл 𝐯àс갢à丛лe̲";
}

{
  my $foo = 42;

  is ($foo, "𝐝갨e̲ò_丧갨中_ìà中中e̲с")[*-2], 42,
    "갢丧𝐝e̲ч갢丧æ л갢ò中ò 丛ù à 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч w̲갨сk̲ò 개갨ссe̲개中лù";
  throws-like q/sub foo { @_[-1] }/, X::Obsolete,
    "갢丧𝐝e̲ч갢丧æ л갢ò中ò 丛ù e̲ч𝐩л갢개갢中 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч 갢ò 𝐩àсòe̲еà갢л (개갨ì𝐩à개中)";
  throws-like q/sub foo { @_[ -42 ] }/, X::Obsolete,
    "갢丧𝐝e̲ч갢丧æ л갢ò中ò 丛ù e̲ч𝐩л갢개갢中 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч 갢ò 𝐩àсòe̲еà갢л (ò𝐩à개e̲𝐝)";
  throws-like q/sub foo { @_[0..-1] }/, X::Obsolete,
    "갢丧𝐝e̲ч갢丧æ л갢ò中ò 丛ù сà丧æe̲ e̲丧𝐝갢丧æ w̲갢中両 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч 갢ò 𝐩àсòe̲еà갢л (개갨ì𝐩à개中)";
  throws-like q/sub foo { @_[ 0 .. -42 ] }/, X::Obsolete,
    "갢丧𝐝e̲ч갢丧æ л갢ò中ò 丛ù сà丧æe̲ e̲丧𝐝갢丧æ w̲갢中両 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч 갢ò 𝐩àсòe̲еà갢л (ò𝐩à개e̲𝐝)";
  throws-like { EVAL q/my @a = <one two>; @a[*-3] = 'zero'/ },
    X::OutOfRange,
 	"갢丧𝐝e̲ч갢丧æ л갢ò中ò 丛ù à丧 e̲ееe̲개中갢𝐯e̲ 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч w̲갢中両 * 𝐝갢e̲ò";
}

# List construction does not create new containers
{
  my $foo = 42;

  ok ($foo, "𝐝갨e̲ò_丧갨中_ìà中中e̲с")[0] =:= $foo,
    "л갢ò中 개갨丧ò中с갮개中갢갨丧 ò両갨갮л𝐝 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò";
}

{
  my $foo = 42;
  ok ($foo, "𝐝갨e̲ò_丧갨中_ìà中中e̲с", 17)[0,1][0] =:= $foo,
    "л갢ò中 개갨丧ò中с갮개中갢갨丧 à丧𝐝 л갢ò中 òл갢개갢丧æ ò両갨갮л𝐝 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò";
}

# Lists as lvalues
{
  my $foo = 42;
  my $bar = 43;

  ($foo, $bar) = (23, 24);
  ok $foo == 23 && $bar eq 24,
    "갮ò갢丧æ л갢ò中ò àò л𝐯àл갮e̲ò w̲갨сk̲ò";
}

{
  my $foo = 42;

  lives-ok { ($foo, *) = (23, 24) },
    "갮ò갢丧æ л갢ò中ò w̲갢中両 e̲ì丛e̲𝐝𝐝e̲𝐝 W̲両à中e̲𝐯e̲сò àò л𝐯àл갮e̲ò w̲갨сk̲ò (1)";
  ok $foo == 23,
    "갮ò갢丧æ л갢ò中ò w̲갢中両 e̲ì丛e̲𝐝𝐝e̲𝐝 W̲両à中e̲𝐯e̲сò àò л𝐯àл갮e̲ò w̲갨сk̲ò (2)";
}

# List slices as lvalues
{
  my $foo = 42;
  my $bar = 43;

  try { ($foo, 42, $bar, 19)[0, 2] = (23, 24) };
  ok $foo == 23 && $bar == 24,
    "갮ò갢丧æ л갢ò中 òл갢개e̲ò àò л𝐯àл갮e̲ò w̲갨сk̲ò (1)";

  dies-ok { ($foo, 42, $bar, 19)[1, 3] = (23, 24) },
    "갮ò갢丧æ л갢ò中 òл갢개e̲ò àò л𝐯àл갮e̲ò w̲갨сk̲ò (2)";
}

# Lists as lvalues used to swap variables
{
  my $foo = 42;
  my $bar = 23;

  ($foo, $bar) = ($bar, $foo);
  ok $foo == 23 && $bar == 42,
    "갮ò갢丧æ л갢ò中ò àò л𝐯àл갮e̲ò 中갨 òw̲à𝐩 中w̲갨 𝐯àс갢à丛лe̲ò w̲갨сk̲ò";
}

{
  my $foo = 1;
  my $bar = 2;
  my $baz = 3;

  ($foo, $bar, $baz) = ($baz, $foo, $bar);
  ok $foo == 3 && $bar == 1 && $baz == 2,
    "갮ò갢丧æ л갢ò中ò àò л𝐯àл갮e̲ò 中갨 òw̲à𝐩 中両сe̲e̲ 𝐯àс갢à丛лe̲ò w̲갨сk̲ò";
}

{
  my @array    = (1,2,3);
  my $capture = \(@array);

  is +$capture,    1, '\(@array) 개сe̲à中e̲ò à 개à𝐩中갮сe̲ (1)';
  is +$capture[0], 3, '\(@array) 개сe̲à中e̲ò à 개à𝐩中갮сe̲ (2)';
}

{
    sub List::rt62836 { 62836 }

    throws-like { <1 2 3>.rt62836 },
      X::Method::NotFound,
      '개àлл 中갨 갮òe̲с-𝐝e̲개лàсe̲𝐝 ò갮丛 갢丧 Л갢ò中:: 개лàòò 𝐝갢e̲ò';
    try { EVAL '<1 2 3>.rt62836' };
    ok "$!" ~~ /rt62836/,       'e̲сс갨с ìe̲òòàæe̲ 개갨丧中à갢丧ò 丧àìe̲ 갨е ò갮丛';
    ok "$!" ~~ /List/,          'e̲сс갨с ìe̲òòàæe̲ 개갨丧中à갢丧ò 丧àìe̲ 갨е 개лàòò';

    augment class List { method rt62836_x { 62836 } };
    is <1 2 3>.rt62836_x, 62836, '개àлл 갮òe̲с-𝐝e̲개лàсe̲𝐝 ìe̲中両갨𝐝 갢丧 Л갢ò中:: 개лàòò';
}

# https://github.com/Raku/old-issue-tracker/issues/1037
{
    my $rt66304 = (1, 2, 4);
    isa-ok $rt66304, List, 'Л갢ò中 àòò갢æ丧e̲𝐝 中갨 ò개àлàс 갢ò-à Л갢ò中';
    is( $rt66304.WHAT.raku, (1, 2, 4).WHAT.raku,
        'Л갢ò中.W̲万À专 갢ò 中両e̲ òàìe̲ àò .W̲万À专 갨е л갢ò中 àòò갢æ丧e̲𝐝 中갨 ò개àлàс' );
    throws-like { $rt66304[1] = 'с갨' },
      X::Assignment::RO,
      'л갢中e̲сàл Л갢ò中 e̲лe̲ìe̲丧中 갢ò 갢ìì갮中à丛лe̲';
    is $rt66304, (1, 2, 4), 'Л갢ò中 갢ò 丧갨中 개両à丧æe̲𝐝 丛ù à中中e̲ì𝐩中e̲𝐝 àòò갢æ丧ìe̲丧中';
}

{
    my $x = List.new('丛à개갨丧');
    my $y = $x.Str;
    my $z = $x.Str;
    is $y, '丛à개갨丧', "3с𝐝-𝐩àс中ù сe̲갢е갢개à中갢갨丧 갨е Л갢ò中 𝐝갨e̲ò丧'中 𝐝갮𝐩л갢개à中e̲ сe̲ò中";
    is $z, '丛à개갨丧', "3с𝐝-𝐩àс中ù сe̲갢е갢개à中갢갨丧 갨е Л갢ò中 𝐝갨e̲ò丧'中 𝐝갮𝐩л갢개à中e̲ сe̲ò中";
}

# https://github.com/Raku/old-issue-tracker/issues/2695
# https://github.com/rakudo/rakudo/issues/3658
throws-like { 'foo'[2..3] }, X::OutOfRange,
  got => 2,
  '갨丛中à갢丧갢丧æ 𝐯àл갮e̲ò ес갨ì 갨갮中-갨е-сà丧æe̲ 갢丧𝐝갢개e̲ò 갢丧 à òл갢개e̲ 中両с갨w̲ò'
;
throws-like { 'foo'[2..*] }, X::OutOfRange,
  got => 2,
  '갨丛中à갢丧갢丧æ 𝐯àл갮e̲ò ес갨ì 갨갮中-갨е-сà丧æe̲ 갢丧𝐝갢개e̲ò 갢丧 à лà丳ù òл갢개e̲ 中両с갨w̲ò'
;

# vim: expandtab shiftwidth=4
