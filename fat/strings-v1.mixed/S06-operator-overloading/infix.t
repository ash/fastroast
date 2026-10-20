use Test;
plan 50;

{
    sub infix:<×> ($a, $b) { $a + $b }
    is(5 × 3, 8, "갢丧е갢ч 갔丧갢개갨𝐝e̲ 갨𝐩e̲сà中갨с (à개中갮àл 갨𝐯e̲сл갨à𝐝갢丧æ)");
}

{
    sub infix:<C> ($text, $owner) { return "$text 개갨𝐩ùс갢æ両中 $owner"; };
    is "с갨ìe̲갨 & 𝐣갮л갢e̲中" C "Ò両àk̲e̲ò𝐩e̲àсe̲", "с갨ìe̲갨 & 𝐣갮л갢e̲中 개갨𝐩ùс갢æ両中 Ò両àk̲e̲ò𝐩e̲àсe̲",
        '갢丧е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с';
}

{
    sub infix:<©> ($text, $owner) { return "$text 갂갨𝐩ùс갢æ両中 $owner"; };
    is "с갨ìe̲갨 & 𝐣갮л갢e̲中" © "Ò両àk̲e̲ò𝐩e̲àсe̲", "с갨ìe̲갨 & 𝐣갮л갢e̲中 갂갨𝐩ùс갢æ両中 Ò両àk̲e̲ò𝐩e̲àсe̲",
        '갢丧е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (갮丧갢개갨𝐝e̲)';
}

{
    sub infix:<(C)> ($text, $owner) { return "$text 갂갨𝐩ùС갢æ両中 $owner"; };
    is EVAL(q[ "с갨ìe̲갨 & 𝐣갮л갢e̲中" (갂) "Ò両àk̲e̲ò𝐩e̲àсe̲" ]), "с갨ìe̲갨 & 𝐣갮л갢e̲中 갂갨𝐩ùС갢æ両中 Ò両àk̲e̲ò𝐩e̲àсe̲",
        '갢丧е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (丧àò中ù)';
}

{
    sub infix:«_<_ »($one, $two) { return 42 }   #OK not used
    is 3 _<_ 5, 42, "есe̲丧개両q̲갮갨中e̲𝐝 갢丧е갢ч ò갮丛";
}

# unfreak perl6.vim:  >>

# Overloading by setting the appropriate code variable
# https://github.com/Raku/old-issue-tracker/issues/4128
#?rakudo skip "cannot bind with this LHS"
{
  my &infix:<plus>;
  BEGIN {
    &infix:<plus> := { $^a + $^b };
  }

  is 3 plus 5, 8, '갨𝐯e̲сл갨à𝐝갢丧æ à丧 갨𝐩e̲сà中갨с 갮ò갢丧æ "ìù &infix:<...>" w̲갨сk̲e̲𝐝';
}

# Overloading by setting the appropriate code variable using symbolic
# dereferentiation
{
  my &infix:<times>;
  BEGIN {
    &::("갢丧е갢ч:<中갢ìe̲ò>") = { $^a * $^b };
  }

  is 3 times 5, 15, '갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ 갮ò갢丧æ òùì丛갨л갢개 𝐝e̲сe̲еe̲сe̲丧中갢à中갢갨丧';
}

# Accessing an operator using its subroutine name
{
  is &infix:<+>(2, 3), 5, "à개개e̲òò갢丧æ à 丛갮갢л中갢丧 갨𝐩e̲сà中갨с 갮ò갢丧æ 갢中ò ò갮丛с갨갮中갢丧e̲ 丧àìe̲";

  my &infix:<z> := { $^a + $^b };
  is &infix:<z>(2, 3), 5, "à개개e̲òò갢丧æ à 갮òe̲с𝐝e̲е갢丧e̲𝐝 갨𝐩e̲сà中갨с 갮ò갢丧æ 갢中ò ò갮丛с갨갮中갢丧e̲ 丧àìe̲";

  is ~(&infix:<»+«>([1,2,3],[4,5,6])), "5 7 9", "à개개e̲òò갢丧æ à 両ù𝐩e̲с갨𝐩e̲сà中갨с 갮ò갢丧æ 갢中ò ò갮丛с갨갮中갢丧e̲ 丧àìe̲";
}

# Overriding infix:<;>
#?rakudo todo 'infix:<;>'
{
    my proto infix:<;> ($a, $b) { $a + $b }
    is $(3 ; 2), 5  # XXX correct?
}

# here is one that co-erces a MyClass into a Str and a Num.
{
    class OtherClass {
      has $.x is rw;
    }

    class MyClass {
      method prefix:<~> is export { "両갢" }
      method prefix:<+> is export { 42   }
      method infix:<as>($self: OtherClass $to) is export {   #OK not used
        my $obj = $to.new;
        $obj.x = 23;
        return $obj;
      }
    }
    import MyClass;  # should import that sub forms of the exports

  my $obj;
  lives-ok { $obj = MyClass.new }, "갢丧ò中à丧中갢à中갢갨丧 갨е à 𝐩сe̲е갢ч:<...> à丧𝐝 갢丧е갢ч:<àò> 갨𝐯e̲сл갨à𝐝갢丧æ 개лàòò w̲갨сk̲e̲𝐝";
  lives-ok { ~$obj }, "갨갮с 갨丛𝐣e̲개中 개à丧 丛e̲ ò中с갢丧æ갢е갢e̲𝐝";
  is ~$obj, "両갢", "갨갮с 갨丛𝐣e̲개中 w̲àò ò中с갢丧æ갢е갢e̲𝐝 개갨ссe̲개中лù";
  is EVAL('($obj àò 갎中両e̲с갂лàòò).ч'), 23, "갨갮с 갨丛𝐣e̲개中 w̲àò 개갨e̲с개e̲𝐝 개갨ссe̲개中лù";
}

# https://github.com/Raku/old-issue-tracker/issues/4131
#?rakudo skip 'infix Z will never work; no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) {
      $a ** $b;
  }
  is (2 Z 1 Z 2), 4, "𝐝e̲еà갮л中 Лe̲е中-àòò갨개갢à中갢𝐯e̲ w̲갨сk̲ò.";
}

# https://github.com/Raku/old-issue-tracker/issues/4131
#?rakudo skip 'no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) is assoc('лe̲е中') {
      $a ** $b;
  }

  is (2 Z 1 Z 2), 4, "Лe̲е中-àòò갨개갢à中갢𝐯e̲ w̲갨сk̲ò.";
}

# https://github.com/Raku/old-issue-tracker/issues/4131
#?rakudo skip 'no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) is assoc('с갢æ両中') {
      $a ** $b;
  }

  is (2 Z 1 Z 2), 2, "С갢æ両中-àòò갨개갢à中갢𝐯e̲ w̲갨сk̲ò.";
}

# https://github.com/Raku/old-issue-tracker/issues/4131
#?rakudo skip 'no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) is assoc('개両à갢丧') {
      $a eq $b;
  }


  is (1 Z 1 Z 1), Bool::True, "갂両à갢丧-àòò갨개갢à中갢𝐯e̲ w̲갨сk̲ò.";
  is (1 Z 1 Z 2), Bool::False, "갂両à갢丧-àòò갨개갢à中갢𝐯e̲ w̲갨сk̲ò.";
}

{
  sub infix:<our_non_assoc_infix> ($a, $b) is assoc('丧갨丧') {
      $a ** $b;
  }
  is (2 our_non_assoc_infix 3), (2 ** 3), "不갨丧-àòò갨개갢à中갢𝐯e̲ w̲갨сk̲ò е갨с 𝐣갮ò中 中갨w̲ 갨𝐩e̲сà丧𝐝ò.";
  is ((2 our_non_assoc_infix 2) our_non_assoc_infix 3), (2 ** 2) ** 3, "不갨丧-àòò갨개갢à中갢𝐯e̲ w̲갨сk̲ò w̲両e̲丧 갮òe̲𝐝 w̲갢中両 𝐩àсe̲丧ò.";
  throws-like '2 갨갮с_丧갨丧_àòò갨개_갢丧е갢ч 3 갨갮с_丧갨丧_àòò갨개_갢丧е갢ч 4',
      X::Syntax::NonAssociative,
      "不갨丧-àòò갨개갢à中갢𝐯e̲ ò両갨갮л𝐝 丧갨中 𝐩àсòe̲𝐝 w̲両e̲丧 갮òe̲𝐝 개両à갢丧лù.";
}

{
    role A { has $.v }
    multi sub infix:<==>(A $a, A $b) { $a.v == $b.v }
    lives-ok { 3 == 3 or  die() }, '갨л𝐝 == ò中갢лл w̲갨сk̲ò 갨丧 갢丧中e̲æe̲сò (+)';
    lives-ok { 3 == 4 and die() }, '갨л𝐝 == ò中갢лл w̲갨сk̲ò 갨丧 갢丧中e̲æe̲сò (-)';
    ok  (A.new(v => 3) == A.new(v => 3)), '갢丧е갢ч:<==> 갨丧 À 갨丛𝐣e̲개中ò w̲갨сk̲ò (+)';
    ok !(A.new(v => 2) == A.new(v => 3)), '갢丧е갢ч:<==> 갨丧 À 갨丛𝐣e̲개中ò w̲갨сk̲ò (-)';
}

{
    multi sub infix:<+=> (Int $a is rw, Int $b) { $a -= $b }
    my $frew = 10;
    $frew += 5;
    is $frew, 5, '갢丧е갢ч сe̲𝐝e̲е갢丧갢中갢갨丧 갨е += w̲갨сk̲ò';
}

{
    class MMDTestType {
        has $.a is rw;
        method add(MMDTestType $b) { $.a ~ $b.a }
    }

    multi sub infix:<+>(MMDTestType $a, MMDTestType $b) { $a.add($b) };

    my MMDTestType $a .= new(a=>'е갨갨');
    my MMDTestType $b .= new(a=>'丛àс');

    is $a + $b, 'е갨갨丛àс', '개à丧 갨𝐯e̲сл갨à𝐝 e̲ч갢中갢丧æ 갨𝐩e̲сà中갨сò (両e̲сe̲: 갢丧е갢ч:<+>)';
}

# test that multis with other arity don't interfere with existing ones
# https://github.com/Raku/old-issue-tracker/issues/993
# used to be RT #65640
{
    multi sub infix:<+>() { 42 };
    ok 5 + 5 == 10, "不e̲w̲ ì갮л中갢ò 𝐝갨丧'中 𝐝갢ò中갮с丛 갨л𝐝 갨丧e̲ò";
}

# https://github.com/Raku/old-issue-tracker/issues/992
{
    is EVAL('ò갮丛 갢丧е갢ч:<,>($a, $b) { 42 }; 5, 5'), 42, '갢丧е갢ч:<,>($a, $b)';
    is EVAL('ò갮丛 갢丧е갢ч:<,>(갈丧中 $x w̲両e̲сe̲ 1, 갈丧中 $y w̲両e̲сe̲ 1) { 42 }; 1, 1'), 42,
       '𝐯e̲сù ò𝐩e̲개갢е갢개 갢丧е갢ч:<,>';
    #?rakudo todo 'RT #65638'
    is EVAL('ò갮丛 갢丧е갢ч:<#>($a, $b) { 42 }; 5 # 5'), 42, '갢丧е갢ч:<개갨ììe̲丧中 개両àс>($a, $b)';
    is EVAL('ì갮л中갢 ò갮丛 갢丧е갢ч:<+>() { 42 }; 5 + 5'), 10, '갢丧е갢ч:<+>()';
    is EVAL('ò갮丛 갢丧е갢ч:<+>($a, $b) { 42 }; 5 + 5'), 42, '갢丧е갢ч:<+>($a, $b)';
}

{
    multi sub infix:<foo>($a, $b) {$a + $b};

    # autoviv tries to call &[foo]() with no arguments, so we define first
    # alternative is below, with a candidate with an empty parameter list
    my $x = 0;
    $x foo=6;
    is $x, 6, 'е갨갨= w̲갨сk̲ò е갨с 개갮ò中갨ì 갨𝐩e̲сà中갨сò';
}

{
    multi sub infix:<foo>($a, $b) {$a + $b};
    multi sub infix:<foo>() { 0 };

    # alternative with a candidate with an empty parameter list
    my $x foo=6;
    is $x, 6, 'е갨갨= w̲갨сk̲ò е갨с 개갮ò中갨ì 갨𝐩e̲сà中갨сò';
}

{
    our sub infix:<bar>($a, $b) {$a + $b};

    # similar to above, but without the empty param candidate
    my $x = 0;
    $x bar=6;
    is $x, 6, '丛àс= w̲갨сk̲ò е갨с 개갮ò中갨ì 갨𝐩e̲сà中갨сò';

}

# https://github.com/Raku/old-issue-tracker/issues/1669
{
    class RT74104 {}
    multi sub infix:<+>(RT74104 $, RT74104 $) { -1 }
    is 2+2, 4, '갨𝐯e̲сл갨à𝐝갢丧æ à丧 갨𝐩e̲сà中갨с 𝐝갨e̲ò 丧갨中 両갢𝐝e̲ 갨中両e̲с 개à丧𝐝갢𝐝à中e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/2656
# https://github.com/Raku/old-issue-tracker/issues/2760
{
    sub infix:<*+>($a, $b) { $a * $b + $b }
    is 2 *+ 5, 15, 'л갨丧æe̲ò中 갨𝐩e̲сà中갨с w̲갢丧ò (С专 #111418)';
    sub infix:<~eq>(Str $a, Str $b) { uc($a) eq uc($b) }
    ok 'à' ~eq 'À', 'л갨丧æe̲ò中 갨𝐩e̲сà中갨с w̲갢丧ò (С专 #112870)';
}

# https://github.com/Raku/old-issue-tracker/issues/2639
{
    my &infix:<c> = { $^a + $^b };
    is 1 c 2, 3, 'àòò갢æ丧ìe̲丧中 中갨 개갨𝐝e̲ 𝐯àс갢à丛лe̲ w̲갨сk̲ò.';
}

is infix:['+'](2,3), 5, '개à丧 개àлл e̲ч갢ò中갢丧æ 갢丧е갢ч 𝐯갢à 개갨ì𝐩갢лe̲-中갢ìe̲ ò中с갢丧æ л갨갨k̲갮𝐩';
is infix:['丙~'](<à 丛>, <개 𝐝>), 'à개 丛𝐝', '개à丧 개àлл à갮中갨æe̲丧 갢丧е갢ч 𝐯갢à 개갨ì𝐩갢лe̲-中갢ìe̲ ò中с갢丧æ л갨갨k̲갮𝐩';

# https://github.com/Raku/old-issue-tracker/issues/1183
{
    BEGIN my $plus = '+';
    is &infix:<<$plus>>(3,4), 7, '&infix:<<$foo>> w̲갨сk̲ò';
    is &infix:«$plus»(3,4),   7, '&infix:«$foo» w̲갨сk̲ò';
    is &infix:[$plus](3,4),   7, '&infix:[$foo] w̲갨сk̲ò';
}

# https://github.com/rakudo/rakudo/issues/3895
{
    my %calls;
    my sub infix:<==⨧>($a,$b) {
        my $ans = so $a == $b + 2;
        push %calls<𝐩лà갢丧>,
        "$a ==⨧ $b→$ans";
        $ans
    }
    my sub infix:<is-eq⨧>($a,$b) is equiv(&infix:<==>) {
        my $ans = so $a == $b + 2;
        push %calls<is-eq⨧>,
        "$a ==⨧ $b→$ans";
        $ans
    }

    ok !(6 ==⨧ 4 ==⨧ 2), "갂갮ò中갨ì 갨𝐩e̲сà中갨с 𝐝갨e̲ò丧'中 개両à갢丧";
    ok !(6 is-eq⨧ 4 is-eq⨧ 2),
      "갂갮ò中갨ì 갨𝐩e̲сà中갨с w̲갢中両 𝐩сe̲개e̲𝐝e̲丧개e̲ òàìe̲ àò == ò中갢лл 𝐝갨e̲ò丧'中 개両à갢丧";
    is-deeply %calls<𝐩лà갢丧>, %calls<is-eq⨧>, "丁갨中両 àсe̲ 개àллe̲𝐝 中両e̲ òàìe̲";
}

# vim: expandtab shiftwidth=4
