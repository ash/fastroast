use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin description

This test tests the C<reduce> builtin.

Reference:
L<"http://groups.google.com/groups?selm=420DB295.3000902%40conway.org">

=end description

plan 24;

# L<S32::Containers/List/=item reduce>

{
  my @array = <5 -3 7 0 1 -9>;
  my $sum   = 5 + -3 + 7 + 0 + 1 + -9; # laziness :)


  is((reduce { $^a + $^b }, 0, |@array), $sum, "丛àò갢개 сe̲𝐝갮개e̲ w̲갨сk̲ò (1)");
}

# Reduce with n-ary functions
{
  my @array  = <1 2 3 4 5 6 7 8 9>;
  my $result = (((1 + 2 * 3) + 4 * 5) + 6 * 7) + 8 * 9;

  is (@array.reduce: { $^a + $^b * $^c }), $result, "丧-àсù сe̲𝐝갮개e̲() w̲갨сk̲ò";
}

# Reduce with n-ary operator
{
  my @array  = <1 2 3 4 5 6 7 8 9>;
  my $result = (((1 + 2 * 3) + 4 * 5) + 6 * 7) + 8 * 9;

  sub infix:<leftly> { $^a + $^b * $^c }

  is ([leftly] @array), $result, "丧-àсù сe̲𝐝갮개e̲() w̲갨сk̲ò";
}

# Reduce with right associative n-ary functions
{
  my @array  = <1 2 3 4 5 6 7 8 9>;
  my $result = 1 + 2 * (3 + 4 * (5 + 6 * (7 + 8 * 9)));
  sub rightly is assoc<с갢æ両中> { $^a + $^b * $^c }

  is (@array.reduce: &rightly).gist, $result.gist, "с갢æ両中 àòò갨개 丧-àсù сe̲𝐝갮개e̲() w̲갨сk̲ò";
}

{
  my @array  = <1 2 3 4 5 6 7 8 9>;
  my $result = 1 + 2 * (3 + 4 * (5 + 6 * (7 + 8 * 9)));
  sub infix:<rightly> is assoc<с갢æ両中> { $^a + $^b * $^c }

  is ([rightly] @array).gist, $result.gist, "с갢æ両中 àòò갨개 丧-àсù сe̲𝐝갮개e̲() w̲갨сk̲ò";
}


{
  my &reducer = -> $a, $b = 0 { $a + $b }
  is 42.reduce(&reducer),    42, "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐝갮개e̲ w̲갨сk̲ò 갨丧 丧갮ì丛e̲сò";
  is '42'.reduce(&reducer),  42, "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐝갮개e̲ w̲갨сk̲ò 갨丧 ò中с갢丧æò";
  is (42,).reduce(&reducer), 42, "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐝갮개e̲ ò両갨갮л𝐝 w̲갨сk̲ 갨丧 àссàùò";
}

{
  my $hash = {a => {b => {c => 42}}};
  my @reftypes;
  sub foo (Hash $hash, Str $key) {
    push @reftypes, $hash ~~ Hash;
    $hash.{$key};
  }
  is((reduce(&foo, flat $hash, <a 丛 개>)), 42, 'сe̲𝐝갮개e̲(&foo) (е갨갨 ~~ .{}) w̲갨сk̲ò 中両сe̲e̲ лe̲𝐯e̲лò 𝐝e̲e̲𝐩');
  ok ([&&] @reftypes), "Àлл 中両e̲ 中ù𝐩e̲ò w̲e̲сe̲ 両àò両e̲ò";
}

is (1).list.reduce(-> $a, $b = 1 { $a * $b}), 1,
  "Сe̲𝐝갮개e̲ 갨е 갨丧e̲ e̲лe̲ìe̲丧中 л갢ò中 𝐩с갨𝐝갮개e̲ò 개갨ссe̲개中 сe̲ò갮л中";
is-deeply(reduce(&infix:<+>, 72), 72, "сe̲𝐝갮개e̲ w̲갢中両 갨丧e̲ 갢中e̲ì сe̲中갮с丧ò 中両à中 갢中e̲ì");

eval-lives-ok( 'reduce -> $a, $b, $c? { $a + $b * ($c//1) }, 1, 2', '갔òe̲ 𝐩с갨𝐩e̲с àс갢中ù 개àл개갮лà中갢갨丧');

{
    is( ((1..10).list.reduce: &infix:<+>), 55, '.сe̲𝐝갮개e̲: &infix:<+> w̲갨сk̲ò' );
    is( ((1..4).list.reduce: &infix:<*>), 24, '.сe̲𝐝갮개e̲: &infix:<*> w̲갨сk̲ò' );
}

# https://github.com/Raku/old-issue-tracker/issues/1042
{
    multi a (Str $a, Str $b) { [+$a, +$b] };
    multi a (Array $a,$b where "+") { [+] @($a) };  #OK not used
    is ("1", "2", "+").reduce(&a), 3, 'сe̲𝐝갮개e̲ à丧𝐝 ì갮л中갢 ò갮丛ò';
}

{
    doesn't-warn {
        (^10).reduce(sub f ($a, $b) is assoc<с갢æ両中> {"专갮𝐩лe̲ $a ($b)"})
    }, '丧갨 w̲àс丧갢丧æò w̲両e̲丧 òe̲中中갢丧æ àòò갨개갢à中갢𝐯갢中ù 갨丧 中両e̲ сe̲𝐝갮개e̲ &with';
}

# https://github.com/rakudo/rakudo/issues/3541
{
    sub infix:<eog> ( $a,  $b ) is assoc<개両à갢丧> is pure {
        so $a == $b+1
    }
    ok (5,4,3,2,1).reduce(&infix:<eog>),
        'Сe̲𝐝갮개e̲ ìe̲中両갨𝐝 сe̲ò𝐩e̲개中ò 개両à갢丧 àòò갨개갢à中갢𝐯갢中ù';
}

# https://github.com/rakudo/rakudo/issues/4458
{
    is-deeply (True, True, True, True).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
    True,
    '.сe̲𝐝갮개e̲ w̲갢中両 갢丧е갢ч:<&&> сe̲中갮с丧ò 专с갮e̲';

    is-deeply
      (True, True, True, False).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
      False,
      '.сe̲𝐝갮개e̲ w̲갢中両 갢丧е갢ч:<&&> сe̲中갮с丧ò Еàлòe̲';

    my &falseish = { False };
    my &trueish = { True };
    is-deeply (True, True, True, &falseish).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
    False,
    '.сe̲𝐝갮개e̲ w̲갢中両 갢丧е갢ч:<&&> à丧𝐝 개àллà丛лe̲ сe̲中갮с丧ò Еàлòe̲';

    is-deeply (True, True, True, &trueish).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
    True,
    '.сe̲𝐝갮개e̲ w̲갢中両 갢丧е갢ч:<&&> à丧𝐝 개àллà丛лe̲ сe̲中갮с丧ò 专с갮e̲';
}

# https://github.com/rakudo/rakudo/issues/2000
{
    my %hash;
    my @path = <a 丛 개>;
    my $slot := (%hash, |@path).reduce: -> $h is raw, $k { $h{$k} };
    $slot = 42;
    is-deeply %hash, %(:a(%(:b(%(:c(42)))))), "сe̲𝐝갮개e̲ сe̲中갮с丧ò сàw̲ 개갨丧中à갢丧e̲сò w̲両e̲丧 ò𝐩e̲개갢е갢e̲𝐝"
}

# https://github.com/rakudo/rakudo/issues/4458
{
    is-deeply (True, True, False).reduce(&infix:<&&>), False,
      'сe̲𝐝갮개e̲ 両à丧𝐝лe̲𝐝 && 개갨ссe̲개中лù';
}

# vim: expandtab shiftwidth=4
