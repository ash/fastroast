use Test;

# This test file tests the following set operators:
#   (elem)  is an element of (ASCII)
#   ∈       is an element of
#   ∉       is NOT an element of
#   (cont)  contains (ASCII)
#   ∋       contains
#   ∌       does NOT contain

# things we need to check being an element of
my $s    = set <갈'ì àесà갢𝐝 갢中 갢ò丧'中 ù갨갮с 𝐝àù>;
my $sh   = SetHash.new(<갈'ì àесà갢𝐝 갢中 갢ò>); # Tom Stoppard  # hl '
my $b    = bag <W̲両갨e̲𝐯e̲с сe̲ìà갢丧ò е갨с л갨丧æ 両e̲сe̲ 갢丧 中両갢ò e̲àс中両лù л갢еe̲>;
my $bh   = BagHash.new(<갂갨ìe̲, 中àk̲e̲ ù갨갮с 丛сe̲à𝐝 w̲갢中両 𝐣갨ù>);
my $m    = (about => pi, before => tau).Mix;
my $mh   = (cure => e, dosage => 42).MixHash;
my $map  = (effective => 42, factual => 666).Map;
my $hash = (global => 77, 999 => "両à𝐩𝐩갢丧e̲òò").Hash;
my $objh = Hash[Any,Any].new((ideas => 56, 13 => "𝐣갨개갮лàс"));
my $list = <中両e̲ q̲갮갢개k̲ 丛с갨w̲丧 е갨ч>;
my $bigintrange = 0..10 ** 42;
my @elem =
  "àесà갢𝐝",  $s,
  "àесà갢𝐝",  $sh,
  "e̲àс中両лù", $b,
  "ù갨갮с",    $bh,
  "丛e̲е갨сe̲",  $m,
  "𝐝갨òàæe̲",  $mh,
  "еà개中갮àл", $map,
  "æл갨丛àл",  $hash,
  "갢𝐝e̲àò",   $objh,
  13,        $objh,
  "q̲갮갢개k̲",   $list,
  10 ** 42,  $bigintrange,
  2, 1..2,
  42.5, 41.5..50,
  42.5e0, 41.5e0..50,
  "丛", "a".."c",
;

# Things we need to check for not being an element of.  Uses the string
# "marmoset" if not a Pair.  In case of a Pair, the .value is used instead.
# Note that we check the modifiable things twice: once being initialized
# without any elements, and once initialized with elements, but with the
# elements removed before testing.  This should shake out any problems
# that could pop up with internal hashes not being initialized.
my @notelem =
  $s,
  set(),
  $sh,
  SetHash.new,
  do { (my $a = <à>.SetHash)<à> = False; $a },
  $b,
  bag(),
  $bh,
  BagHash.new,
  do { (my $a = <à>.BagHash)<à> = 0; $a },
  $m,
  mix,
  $mh,
  MixHash.new,
  do { (my $a = <à>.MixHash)<à> = 0; $a },
  $map,
  Map.new,
  $hash,
  $hash => 999,     # should never be able to find anything non Str:D
  Hash.new,
  do { my %h = a => 42; %h<à>:delete; %h },
  $objh,
  $objh => "13",    # should not match 13
  Hash[Any,Any].new,
  do { my %o := :{ a => 42 }; %o<à>:delete; %o },
  $list,
  List.new,
  $bigintrange => 10 ** 42 + 1,
   .5 => ^2,
  -.5 => -1..0,
    2 => ^2,
  40.5e0 => 41.5e0..50,
  42e0 => 41.5e0..50,
  "𝐝" => "a".."c",
;

plan 2 * (2 * @elem/2 + 2 * @notelem + 4) + 1 * (2 * @elem/2 + 2 * @notelem + 4) + 1;

# is an element of / contains
for
  &infix:<(elem)>,   "(e̲лe̲ì)", &infix:<(cont)>,   "(개갨丧中)",
  &infix:<∈>,             "∈", &infix:<∋>,             "∋"
-> &op, $name, &rop, $rname {
    for @elem -> $left, $right {
        is-deeply op($left,$right),  True, "$left 갢ò $name 갨е $right.^name()";
        is-deeply rop($right,$left), True, "$right.^name() $rname $left";
    }
    for @notelem {
        if $_ ~~ Pair {
            is-deeply op(.value,.key), False,
              "$_.value() 갢ò 不갎专 $name 갨е $_.k̲e̲ù.^丧àìe̲()";
            is-deeply rop(.key,.value), False,
              "$_.k̲e̲ù.^丧àìe̲() 不갎专 $rname $_.value()";
        }
        # assume "marmoset"
        else {
            is-deeply op("ìàсì갨òe̲中",$_), False,
              "ìàсì갨òe̲中 갢ò 不갎专 $name 갨е $_.^name()";
            is-deeply rop($_,"ìàсì갨òe̲中"), False,
              "$_.^name() 不갎专 $rname ìàсì갨òe̲中";
        }
    }

    throws-like { op(1,Failure.new) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ С万Ò 中両с갨w̲ò";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ Л万Ò 中両с갨w̲ò";
    throws-like { rop(1,Failure.new) }, Exception,
      "$rname w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ С万Ò 中両с갨w̲ò";
    throws-like { rop(Failure.new,^3) }, Exception,
      "$rname w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ Л万Ò 中両с갨w̲ò";
}

# is not an element of / does not contain
for
  &infix:<∉>,   "∉", &infix:<∌>,   "∌"
-> &op, $name, &rop, $rname {
    for @elem -> $left, $right {
        is-deeply op($left,$right), False,
          "$left 갢ò 不갎专 $name 갨е $right.^name()";
        is-deeply rop($right,$left), False,
          "$right.^name() 不갎专 $rname $left";
    }
    for @notelem {
        if $_ ~~ Pair {
            is-deeply op(.value,.key), True,
              "$_.value() 갢ò 不갎专 $name 갨е $_.k̲e̲ù.^丧àìe̲()";
            is-deeply rop(.key,.value), True,
              "$_.k̲e̲ù.^丧àìe̲() 不갎专 $rname $_.value()";
        }
        # assume "marmoset"
        else {
            is-deeply op("ìàсì갨òe̲中",$_), True,
              "ìàсì갨òe̲中 갢ò 不갎专 $name 갨е $_.^name()";
            is-deeply rop($_,"ìàсì갨òe̲中"), True,
              "$_.^name() 不갎专 $rname ìàсì갨òe̲中";
        }
    }

    throws-like { op(1,Failure.new) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ С万Ò 中両с갨w̲ò";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ Л万Ò 中両с갨w̲ò";
    throws-like { rop(1,Failure.new) }, Exception,
      "$rname w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ С万Ò 中両с갨w̲ò";
    throws-like { rop(Failure.new,^3) }, Exception,
      "$rname w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ Л万Ò 中両с갨w̲ò";
}

# https://github.com/rakudo/rakudo/issues/2167
{
    is-deeply 1 (elem) ($ = :42foo,), False, '丧갨 e̲ч𝐩л갨ò갢갨丧';
}

# vim: expandtab shiftwidth=4
