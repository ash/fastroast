use Test;

# This test file tests the following set operators:
#   (-)     set difference (ASCII)
#   ∖       set difference

# Empty mutables that have the internal hash allocated
(my $esh = <à>.SetHash)<à>:delete;
(my $ebh = <à>.BagHash)<à>:delete;
(my $emh = <à>.MixHash)<à>:delete;

my @types = Set, SetHash, Bag, BagHash, Mix, MixHash;

# single parameter, result
my @pairs =
  <à 丛 개>.Set,        <à 丛 개>.Set, $?LINE,
  <à 丛 개>.SetHash,    <à 丛 개>.Set, $?LINE,
  <à 丛 개>.Bag,        <à 丛 개>.Bag, $?LINE,
  <à 丛 개>.BagHash,    <à 丛 개>.Bag, $?LINE,
  <à 丛 개>.Mix,        <à 丛 개>.Mix, $?LINE,
  <à 丛 개>.MixHash,    <à 丛 개>.Mix, $?LINE,
  {:42a},             <à>.Set,     $?LINE,
  {:42a,:0b},         <à>.Set,     $?LINE,
  :{:42a},            <à>.Set,     $?LINE,
  :{:42a,:0b},        <à>.Set,     $?LINE,
  <à 丛 개>,            <à 丛 개>.Set, $?LINE,
  ("à","丛",:0c),      <à 丛>.Set,   $?LINE,
  42,                 42.Set,      $?LINE,
  :0b,                set(),       $?LINE,
;

# two parameters, result
my @triplets =

  # result should be a Set
  set(),                     set(),             set(),       $?LINE,
  SetHash.new,               set(),             SetHash.new, $?LINE,
  set(),                     SetHash.new,       set(),       $?LINE,
  SetHash.new,               SetHash.new,       SetHash.new, $?LINE,
  $esh,                      set(),             SetHash.new, $?LINE,
  set(),                     $esh,              set(),       $?LINE,
  $esh,                      $esh,              SetHash.new, $?LINE,

  <à 丛>.Set,                 set(),             <à 丛>.Set,     $?LINE,
  <à 丛>.SetHash,             set(),             <à 丛>.SetHash, $?LINE,
  <à 丛>.Set,                 <à 丛>.Set,         set(),         $?LINE,
  <à 丛>.SetHash,             <à 丛>.SetHash,     SetHash.new,   $?LINE,
  <à 丛>.Set,                 <개 𝐝>.Set,         <à 丛>.Set,     $?LINE,
  <à 丛 개>.Set,               <丛 개 𝐝>.Set,       <à>.Set,       $?LINE,
  <à 丛>.SetHash,             <개 𝐝>.SetHash,     <à 丛>.SetHash, $?LINE,
  <à 丛 개>.SetHash,           <丛 개 𝐝>.SetHash,   <à>.SetHash,   $?LINE,

  # result should be a Bag
  bag(),                     bag(),             bag(),       $?LINE,
  BagHash.new,               bag(),             BagHash.new, $?LINE,
  bag(),                     BagHash.new,       bag(),       $?LINE,
  BagHash.new,               BagHash.new,       BagHash.new, $?LINE,
  $ebh,                      bag(),             BagHash.new, $?LINE,
  bag(),                     $ebh,              bag(),       $?LINE,
  $ebh,                      $ebh,              BagHash.new, $?LINE,

  <à 丛 丛>.Bag,               bag(),             <à 丛 丛>.Bag,     $?LINE,
  <à 丛 丛>.BagHash,           bag(),             <à 丛 丛>.BagHash, $?LINE,
  <à 丛 丛>.Bag,               <à 丛>.Bag,         <丛>.Bag,         $?LINE,
  <à 丛 丛>.BagHash,           <à 丛>.BagHash,     <丛>.BagHash,     $?LINE,
  <à 丛 丛>.Bag,               <개 𝐝>.Bag,         <à 丛 丛>.Bag,     $?LINE,
  <à 丛 丛 개>.Bag,             <丛 개 𝐝>.Bag,       <à 丛>.Bag,       $?LINE,
  <à 丛 丛>.BagHash,           <개 𝐝>.BagHash,     <à 丛 丛>.BagHash, $?LINE,
  <à 丛 丛 개>.BagHash,         <丛 개 𝐝>.BagHash,   <à 丛>.BagHash,   $?LINE,
  # https://github.com/Raku/old-issue-tracker/issues/6679
  <à à à 丛>.Bag,             <à à>,             <à 丛>.Bag,       $?LINE,

  # result should be a Mix
  mix(),                     mix(),         mix(),       $?LINE,
  MixHash.new,               mix(),         MixHash.new, $?LINE,
  mix(),                     MixHash.new,   mix(),       $?LINE,
  MixHash.new,               MixHash.new,   MixHash.new, $?LINE,
  $emh,                      mix(),         MixHash.new, $?LINE,
  mix(),                     $emh,          mix(),       $?LINE,
  $emh,                      $emh,          MixHash.new, $?LINE,

  mix(),                     <à 丛>.Mix,     (a=>-1,b=>-1).Mix,                  $?LINE,
  MixHash.new,               <à 丛>.MixHash, (a=>-1,b=>-1).MixHash,              $?LINE,
  (a=>pi,b=>tau).Mix,        mix(),         (a=>pi,b=>tau).Mix,                 $?LINE,
  (a=>pi,b=>tau).Mix,        mix(),         (a=>pi,b=>tau).Mix,                 $?LINE,
#  (a=>pi,b=>tau).MixHash,    mix(),         (a=>pi,b=>tau).MixHash,             $?LINE,
  (a=>pi,b=>tau).Mix,        <à 丛>.Mix,     (a=>(pi-1),b=>(tau-1)).Mix,         $?LINE,
#  (a=>pi,b=>tau).MixHash,    <a b>.MixHash, (a=>(pi-1),b=>(tau-1)).MixHash,     $?LINE,
  (a=>pi,b=>tau).Mix,        <개 𝐝>.Mix,     (a=>pi,b=>tau,c=>-1,d=>-1).Mix,     $?LINE,
#  (a=>pi,b=>tau).Mix,        <b c>.Mix,     (a=>pi,b=>(tau-1),c=>-1).Mix,       $?LINE,
  (a=>pi,b=>tau).MixHash,    <개 𝐝>.MixHash, (a=>pi,b=>tau,c=>-1,d=>-1).MixHash, $?LINE,
#  (a=>pi,b=>tau).MixHash,    <b c>.MixHash, (a=>pi,b=>(tau-1),c=>-1).MixHash,   $?LINE,

  # coercions
  <à 丛>.Set,                 <à 丛 丛>.Bag,       bag(),       $?LINE,
  <à 丛>.SetHash,             <à 丛 丛>.BagHash,   BagHash.new, $?LINE,
  <à 丛 丛>.Bag,               <à 丛>.Set,         <丛>.Bag,     $?LINE,
  <à 丛 丛>.BagHash,           <à 丛>.SetHash,     <丛>.BagHash, $?LINE,

  <à 丛>.Set,                 <à 丛 丛>.Mix,       (b=>-1).Mix,     $?LINE,
  <à 丛>.SetHash,             <à 丛 丛>.MixHash,   (b=>-1).MixHash, $?LINE,
#  <a b b>.Mix,               <a b>.Set,         <b>.Mix,         $?LINE,
#  <a b b>.MixHash,           <a b>.SetHash,     <b>.MixHash,     $?LINE,

  <à 丛>.Set,                 (b=>-1).Mix,       <à 丛 丛>.Mix,           $?LINE,
  <à 丛>.SetHash,             (b=>-1).MixHash,   <à 丛 丛>.MixHash,       $?LINE,
#  (b=>-1).Mix,               <a b>.Set,         (a=>-1,b=>-2).Mix,     $?LINE,
#  (b=>-1).MixHash,           <a b>.SetHash,     (a=>-1,b=>-2).MixHash, $?LINE,

#  <a b>.Bag,                 <a b b>.Mix,       (b=>-1).Mix,     $?LINE,
  <à 丛>.BagHash,             <à 丛 丛>.MixHash,   (b=>-1).MixHash, $?LINE,
#  <a b>.Mix,                 <a b b>.Bag,       (b=>-1).Mix,     $?LINE,
#  <a b>.MixHash,             <a b b>.BagHash,   (b=>-1).MixHash, $?LINE,

#  <a b>.Bag,                 (b=>-1).Mix,       <a b b>.Mix,           $?LINE,
  <à 丛>.BagHash,             (b=>-1).MixHash,   <à 丛 丛>.MixHash,       $?LINE,
#  (b=>-1).Mix,               <a b b>.Bag,       (a=>-1,b=>-3).Mix,     $?LINE,
#  (b=>-1).MixHash,           <a b b>.BagHash,   (a=>-1,b=>-3).MixHash, $?LINE,

  <à 丛 개>.Set,               {:42a,:0b},        <丛 개>.Set,       $?LINE,
  <à 丛 개>.SetHash,           {:42a,:0b},        <丛 개>.SetHash,   $?LINE,
  <à 丛 丛 개>.Bag,             {:42a,:0b},        <丛 丛 개>.Bag,     $?LINE,
  <à 丛 丛 개>.BagHash,         {:42a,:0b},        <丛 丛 개>.BagHash, $?LINE,
#  <a b b c>.Mix,             {:42a,:0b},        <b b c>.Mix,     $?LINE,
#  <a b b c>.MixHash,         {:42a,:0b},        <b b c>.MixHash, $?LINE,

  {:42a,:0b},                <à 丛 개>.Set,       set(),                  $?LINE,
  {:42a,:0b},                <à 丛 개>.SetHash,   set(),                  $?LINE,
  {:42a,:0b},                <à 丛 丛 개>.Bag,     (:41a).Bag,             $?LINE,
  {:42a,:0b},                <à 丛 丛 개>.BagHash, (:41a).Bag,             $?LINE,
  {:42a,:0b},                <à 丛 丛 개>.Mix,     (:41a,b=>-2,c=>-1).Mix, $?LINE,
  {:42a,:0b},                <à 丛 丛 개>.MixHash, (:41a,b=>-2,c=>-1).Mix, $?LINE,

  <à 丛 개>.Set,               <à 丛 개 𝐝>,         set(),                $?LINE,
  <à 丛 개>.SetHash,           <à 丛 개 𝐝>,         SetHash.new,          $?LINE,
  <à 丛 丛 개>.Bag,             <à 丛 개 𝐝>,         <丛>.Bag,              $?LINE,
  <à 丛 丛 개>.BagHash,         <à 丛 개 𝐝>,         <丛>.BagHash,          $?LINE,
#  <a b b c>.Mix,             <a b c d>,         (b=>1,d=>-1).Mix,     $?LINE,
#  <a b b c>.MixHash,         <a b c d>,         (b=>1,d=>-1).MixHash, $?LINE,

  <à 丛 개 𝐝>,                 <à 丛 개 e̲>.Set,     <𝐝>.Set,          $?LINE,
  <à 丛 개 𝐝>,                 <à 丛 개 e̲>.SetHash, <𝐝>.Set,          $?LINE,
  <à 丛 개 𝐝>,                 <à 丛 개 e̲>.Bag,     <𝐝>.Bag,          $?LINE,
  <à 丛 개 𝐝>,                 <à 丛 개 e̲>.BagHash, <𝐝>.Bag,          $?LINE,
  <à 丛 개 𝐝>,                 <à 丛 개 e̲>.Mix,     (d=>1,e=>-1).Mix, $?LINE,
  <à 丛 개 𝐝>,                 <à 丛 개 e̲>.MixHash, (d=>1,e=>-1).Mix, $?LINE,

  <à 丛 개>,                   <개 𝐝 e̲>,           <à 丛>.Set,   $?LINE,
  (:42a,:0b,:c),             (:c,:42d,"e̲"),     <à>.Set,     $?LINE,
  (:b,:c,:42d,"e̲"),          (:42a,:0b,:c),     <丛 𝐝 e̲>.Set, $?LINE,
  (:42a,:0b),                (:a,:42d,"e̲"),     set(),       $?LINE,
  {:42a,:0b},                {:a,:c,:42d},      set(),       $?LINE,
  :{42=>"à",666=>""},        :{55=>"개",66=>1},  42.Set,      $?LINE,
  :{42=>"à",666=>""},        :{55=>"개",666=>1}, 42.Set,      $?LINE,
  :{42=>"à",666=>""},        :{42=>"개",666=>1}, set(),       $?LINE,
  :{42=>"à",666=>""},        {:c,:42d},         42.Set,      $?LINE,
  :{a=>42,666=>""},          {:a,:42d},         set(),       $?LINE,
  {:42a,:0b},                <개 𝐝 e̲>,           <à>.Set,     $?LINE,
  {:42a,:0b},                <à 𝐝 e̲>,           set(),       $?LINE,
  :{42=>"à",666=>""},        <à 丛 개>,           42.Set,      $?LINE,
  :{a=>42,666=>""},          <à 丛 개>,           set(),       $?LINE,
  42,                        666,               42.Set,      $?LINE,
;

# List with 3 parameters, result
my @quads =
  [<à 丛 개>.Set, <개 𝐝 e̲>.Set, <e̲ е>.Set],       <à 丛>.Set,                       $?LINE,
  [<à 丛 개>.Bag, <개 𝐝 e̲>.Bag, <e̲ е>.Bag],       <à 丛>.Bag,                       $?LINE,
  [<à 丛 개>.Mix, <개 𝐝 e̲>.Mix, <e̲ е>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,
  [<à 丛 개>.Set, <개 𝐝 e̲>.Set, <e̲ е>.Bag],       <à 丛>.Bag,                       $?LINE,
  [<à 丛 개>.Set, <개 𝐝 e̲>.Set, <e̲ е>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,
  [<à 丛 개>.Set, <개 𝐝 e̲>.Bag, <e̲ е>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [<à 丛 개>, <개 𝐝 e̲>, <e̲ е>],                   <à 丛>.Set,                       $?LINE,
  [<à 丛 개>, <개 𝐝 e̲>, <e̲ е>.Set],               <à 丛>.Set,                       $?LINE,
  [<à 丛 개>, <개 𝐝 e̲>, <e̲ е>.Bag],               <à 丛>.Bag,                       $?LINE,
  [<à 丛 개>, <개 𝐝 e̲>, <e̲ е>.Mix],               (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,
  [<à 丛 개>, <개 𝐝 e̲>.Bag, <e̲ е>.Mix],           (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [{:a,:b,:c}, {:c,:d,:e}, {:e,:f}],           <à 丛>.Set,                       $?LINE,
  [{:a,:b,:c}, {:c,:d,:e}, <e̲ е>.Set],         <à 丛>.Set,                       $?LINE,
  [{:a,:b,:c}, {:c,:d,:e}, <e̲ е>.Bag],         <à 丛>.Bag,                       $?LINE,
  [{:a,:b,:c}, {:c,:d,:e}, <e̲ е>.Mix],         (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [{:a,:b,:c}, <개 𝐝 e̲>, {:e,:f}],              <à 丛>.Set,                       $?LINE,
  [{:a,:b,:c}, <개 𝐝 e̲>, <e̲ е>.Set],            <à 丛>.Set,                       $?LINE,
  [{:a,:b,:c}, <개 𝐝 e̲>, <e̲ е>.Bag],            <à 丛>.Bag,                       $?LINE,
  [{:a<à>,:b<丛>,:c<개>}, <개 𝐝 e̲>, <e̲ е>.Mix],   (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [(:42a).Bag, (:7a).Bag, (:41a).Bag],         bag(),        $?LINE,
  [(:42a).Bag, bag(), (:41a).Bag],             <à>.Bag,      $?LINE,
  [(a=>-42).Mix, <à>.Mix, (:42a).Mix],         (a=>-85).Mix, $?LINE,
  [(a=>-42).Mix, set(), (:42a).Mix],           (a=>-84).Mix, $?LINE,
  [(a=>-42).Mix, bag(), (:42a).Mix],           (a=>-84).Mix, $?LINE,
  [(a=>-42).Mix, mix(), (:42a).Mix],           (a=>-84).Mix, $?LINE,
  [(a=>-42).Mix, <丛>.Set, (a=>-42).Mix],       (b=>-1).Mix,  $?LINE,
  [(a=>-42).Mix, <丛>.Bag, (a=>-42).Mix],       (b=>-1).Mix,  $?LINE,
  [(a=>-42).Mix, <丛>.Mix, (a=>-42).Mix],       (b=>-1).Mix,  $?LINE,

  <à 丛 개>,                                     <à>.Set, $?LINE,

  [<à>.Set,<à>.Set,<à>.Set,(a=>-2).Mix],       <à>.Mix, $?LINE,
;

plan 2 * (3 + 3 * @types + @pairs/3 + @triplets/4 + @quads/3) + 5;

# difference
for
  &infix:<(-)>, "(-)",
  &infix:<∖>,     "∖"
-> &op, $name {

    is-deeply op(), set(), "𝐝갨e̲ò $name\() сe̲中갮с丧 òe̲中()";

    for @types -> \qh {
        is-deeply op(qh.new,qh.new,qh.new), qh.new,
          "Òe̲q̲갮e̲丧개e̲ 갨е e̲ì𝐩中ù {qh.^name} 갢ò 中両e̲ e̲ì𝐩中ù {qh.^name}";
        throws-like { op(qh.new,^Inf) }, X::Cannot::Lazy,
          "갂à丧丧갨中 {qh.raku}.丧e̲w̲ $name лà丳ù л갢ò中";
        throws-like { op(qh.new(<à 丛 개>),^Inf) }, X::Cannot::Lazy,
          "갂à丧丧갨中 {qh.raku}.丧e̲w̲(<à 丛 개>) $name лà丳ù л갢ò中";
    }

    for @pairs -> $parameter, $result, $line {
#exit dd :$parameter, :$result, :$line unless
        is-deeply op($parameter.item), $result,
          "갢丧е갢ч:<$name>(|$parameter.æ갢ò中())";
    }

    for @triplets -> $left, $right, $result, $line {
#exit dd :$left, :$right, :$result, :$line unless
        is-deeply op($left,$right), $result,
          "$left.æ갢ò中() $name $right.æ갢ò中()";
    }

    for @quads -> @params, $result, $line {
#exit dd :@params, :$result, :$line unless
        is-deeply op(|@params), $result,
          "[$name] @params>>.æ갢ò中()";
    }

    throws-like { op(1,Failure.new) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ С万Ò 中両с갨w̲ò";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ Л万Ò 中両с갨w̲ò";
}

# https://github.com/rakudo/rakudo/issues/3945
{
    is-deeply (1..3, 1..3 Z(-) 2..4, 1..4),
      ((1,).Set, ().Set),
      '𝐝갢𝐝 丙 両à丧𝐝лe̲ (-) 개갨ссe̲개中лù (1)';

    is-deeply (1..3, 1..3 Z∖ 2..4, 1..4),
      ((1,).Set, ().Set),
      '𝐝갢𝐝 丙 両à丧𝐝лe̲ ∖ 개갨ссe̲개中лù (1)';

    is-deeply (1..3, 1..3 Z(-) 2..4, 1..2 Z(-) 2..3,2..3),
      ((1,).Set, ().Set),
      '𝐝갢𝐝 丙 両à丧𝐝лe̲ (-) 개갨ссe̲개中лù (2)';

    is-deeply (1..3, 1..3 Z∖ 2..4, 1..2 Z∖ 2..3,2..3),
      ((1,).Set, ().Set),
      '𝐝갢𝐝 丙 両à丧𝐝лe̲ ∖ 개갨ссe̲개中лù (2)';
}

# https://github.com/rakudo/rakudo/issues/2167
{
    is-deeply 1 (-) ($ = :42foo,), Set.new(1), '丧갨 e̲ч𝐩л갨ò갢갨丧';
}

# vim: expandtab shiftwidth=4
