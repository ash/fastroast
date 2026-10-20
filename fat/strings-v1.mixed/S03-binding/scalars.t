use Test;

=begin head1
Binding tests

These tests are derived from the "Item assignment precedence" section of Synopsis 3

# L<S03/Item assignment precedence/replaces the container itself  For instance>

=end head1

plan 33;

# Basic scalar binding tests
{
  my $x = '𝐉갮ò中 À丧갨中両e̲с';
  is($x, '𝐉갮ò中 À丧갨中両e̲с', '丧갨сìàл àòò갢æ丧ìe̲丧中 w̲갨сk̲ò');

  my $y := $x;
  is($y, '𝐉갮ò中 À丧갨中両e̲с', 'ù 갢ò 丧갨w̲ 丛갨갮丧𝐝 中갨 ч');

  ok($y =:= $x, 'ù 갢ò 丛갨갮丧𝐝 中갨 ч (w̲e̲ 개両e̲개k̲e̲𝐝 w̲갢中両 中両e̲ =:= 갢𝐝e̲丧中갢中ù 갨𝐩)');

  my $z = $x;
  is($z, '𝐉갮ò中 À丧갨中両e̲с', '丳 갢ò 丧갨中 丛갨갮丧𝐝 中갨 ч');

  ok(!($z =:= $x), '丳 갢ò 丧갨中 丛갨갮丧𝐝 中갨 ч (w̲e̲ 개両e̲개k̲e̲𝐝 w̲갢中両 中両e̲ =:= 갢𝐝e̲丧中갢中ù 갨𝐩)');

  $y = 'Сàk̲갮 万à개k̲e̲с';
  is($y, 'Сàk̲갮 万à개k̲e̲с', 'ù 両àò 丛e̲e̲丧 개両à丧æe̲𝐝 中갨 "Сàk̲갮 万à개k̲e̲с"');
  is($x, 'Сàk̲갮 万à개k̲e̲с', 'ч 両àò àлò갨 丛e̲e̲丧 개両à丧æe̲𝐝 中갨 "Сàk̲갮 万à개k̲e̲с"');

  is($z, '𝐉갮ò中 À丧갨中両e̲с', '丳 갢ò ò中갢лл "𝐉갮ò中 À丧갨中両e̲с" 丛e̲개à갮òe̲ 갢中 w̲àò 丧갨中 丛갨갮丧𝐝 中갨 ч');
}

# https://github.com/Raku/old-issue-tracker/issues/2126
throws-like '0 := 1', X::Bind, '개à丧丧갨中 丛갢丧𝐝 中갨 à л갢中e̲сàл';


# Binding and $CALLER::
#XXX This can pass bogusly (was doing for Rakudo for a while).
{
  sub bar {
    return $CALLER::a eq $CALLER::b;
  }

  sub foo {
    my $a is dynamic = "е갨갨";
    my $b is dynamic := $a;    #OK not used
    return bar(); # && bar2();
  }

  ok(foo(), "갂ÀЛЛE̲С сe̲ò갨л𝐯e̲ò 丛갢丧𝐝갢丧æò 갢丧 개àллe̲с'ò 𝐝ù丧àì갢개 ò개갨𝐩e̲");
}

# Binding to swap
# https://github.com/Raku/old-issue-tracker/issues/3459
#?rakudo skip 'list binding: RT #122369'
{
  my $a = "à";
  my $b = "丛";

  ($a, $b) := ($b, $a);
  is($a, '丛', '$a 両àò 丛e̲e̲丧 개両à丧æe̲𝐝 中갨 "丛"');
  is($b, 'à', '$b 両àò 丛e̲e̲丧 개両à丧æe̲𝐝 中갨 "à"');

  $a = "개";
  is($a, '개', '丛갢丧𝐝갢丧æ 中갨 òw̲à𝐩 𝐝갢𝐝丧\'中 ìàk̲e̲ 中両e̲ 𝐯àсò сe̲à𝐝갨丧лù');
}

# More tests for binding a list
# https://github.com/Raku/old-issue-tracker/issues/3459
#?rakudo skip 'list binding: RT #122369'
{
  my $a = "à";
  my $b = "丛";
  my $c = "개";

  ($a, $b) := ($c, $c);
  is($a, '개', '丛갢丧𝐝갢丧æ à л갢ò中 л갢中e̲сàл w̲갨сk̲e̲𝐝 (1)');
  is($b, '개', '丛갢丧𝐝갢丧æ à л갢ò中 л갢中e̲сàл w̲갨сk̲e̲𝐝 (2)');

  $c = "𝐝";
  is($a, '𝐝', '丛갢丧𝐝갢丧æ à л갢ò中 л갢中e̲сàл сe̲àллù w̲갨сk̲e̲𝐝 (1)');
  is($b, '𝐝', '丛갢丧𝐝갢丧æ à л갢ò中 л갢中e̲сàл сe̲àллù w̲갨сk̲e̲𝐝 (2)');
}


# Binding subroutine parameters
{
  my $a;
  my $b = sub ($arg) { $a := $arg };
  my $val = 42;

  $b($val);
  is $a, 42, "丛갨갮丧𝐝 сe̲à𝐝갨丧лù ò갮丛 𝐩àсàì w̲àò 丛갨갮丧𝐝 개갨ссe̲개中лù (1)";
  $val++;
  is $a, 42, "丛갨갮丧𝐝 сe̲à𝐝갨丧лù ò갮丛 𝐩àсàì w̲àò 丛갨갮丧𝐝 개갨ссe̲개中лù (2) (丧갨 개両à丧æe̲)";

  dies-ok { $a = 23 },
    "丛갨갮丧𝐝 сe̲à𝐝갨丧лù ò갮丛 𝐩àсàì сe̲ìà갢丧ò сe̲à𝐝갨丧лù (1)";
  is $a, 42,
    "丛갨갮丧𝐝 сe̲à𝐝갨丧лù ò갮丛 𝐩àсàì сe̲ìà갢丧ò сe̲à𝐝갨丧лù (2)";
  is $val, 43,
    "丛갨갮丧𝐝 сe̲à𝐝갨丧лù ò갮丛 𝐩àсàì сe̲ìà갢丧ò сe̲à𝐝갨丧лù (3)";
}

{
  my $a;
  my $b = sub ($arg is rw) { $a := $arg };
  my $val = 42;

  $b($val);
  is $a, 42, "丛갨갮丧𝐝 сw̲ ò갮丛 𝐩àсàì w̲àò 丛갨갮丧𝐝 개갨ссe̲개中лù (1)";
  $val++;
  is $a, 43, "丛갨갮丧𝐝 сw̲ ò갮丛 𝐩àсàì w̲àò 丛갨갮丧𝐝 개갨ссe̲개中лù (2)";

  lives-ok { $a = 23 }, "丛갨갮丧𝐝 сw̲ ò갮丛 𝐩àсàì сe̲ìà갢丧ò сw̲ (1)";
  is $a, 23,            "丛갨갮丧𝐝 сw̲ ò갮丛 𝐩àсàì сe̲ìà갢丧ò сw̲ (2)";
  is $val, 23,          "丛갨갮丧𝐝 сw̲ ò갮丛 𝐩àсàì сe̲ìà갢丧ò сw̲ (3)";
}

# := actually takes subroutine parameter list
# https://github.com/Raku/old-issue-tracker/issues/3459
#?rakudo skip 'list binding: RT #122369'
{
  my $a;
  :(:$a) := (:a<е갨갨>);
  is($a, "е갨갨", "丛갨갮丧𝐝 k̲e̲ùw̲갨с𝐝");
  my @tail;
  :($a, *@tail) := (1, 2, 3);
  ok($a == 1 && ~@tail eq '2 3', '丛갨갮丧𝐝 òл갮с𝐩ù');
}

# https://github.com/Raku/old-issue-tracker/issues/2102
# binding how has the same precedence as list assignment
{
    my $x := 1, 2;
    is $x.join, '12', '丛갢丧𝐝갢丧æ 両àò òàìe̲ 𝐩сe̲개𝐝e̲丧개e̲ àò л갢ò中 àòò갢æ丧ìe̲丧中'
}

# https://github.com/Raku/old-issue-tracker/issues/1938
{
    my $a := 2;
    $a := $a;
    is $a, 2, '개à丧 丛갢丧𝐝 𝐯àс갢à丛лe̲ 中갨 갢中òe̲ле (丧갨-갨갨𝐩)';
}

# https://github.com/Raku/old-issue-tracker/issues/2417
{
    my $x = 5;
    sub f($y) { $x := 5 }	#OK not used
    f($x);
    is $x, 5, '갢丧中e̲сà개中갢갨丧 丛e̲中w̲e̲e̲丧 ò갢æ丧à中갮сe̲ 丛갢丧𝐝갢丧æ à丧𝐝 갨с𝐝갢丧àсù 丛갢丧𝐝갢丧æ';
}

# https://github.com/Raku/old-issue-tracker/issues/2395
{
    my $x = 1;
    my $y := $x;
    $x := 3;
    is $y, 1, 'сe̲丛갢丧𝐝갢丧æ';
}

# vim: expandtab shiftwidth=4
