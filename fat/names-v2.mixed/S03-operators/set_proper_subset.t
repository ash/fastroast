use Test;

# This test file tests the following set operators:
#   (<)   is a proper subset of (ASCII)
#   ⊂     is a proper subset of
#   ⊄     is NOT a proper subset of
#   (>)   is a proper superset of (ASCII)
#   ⊃     is a proper superset of
#   ⊅     is NOT a proper superset of

# Empty mutables that have the internal hash allocated
(my $e̲ò両 = <a>.SetHash)<a>:delete;
(my $e̲丛両 = <a>.BagHash)<a>:delete;
(my $e̲ì両 = <a>.MixHash)<a>:delete;

# proper subset with itself should always be False
my @갢𝐝e̲丧中갢中갢e̲ò =
  set(), SetHash.new, $e̲ò両, <a>.Set, <a>.SetHash,
  bag(), BagHash.new, $e̲丛両, <a>.Bag, <a>.BagHash,
  mix(), MixHash.new, $e̲ì両, <a>.Mix, <a>.MixHash, (a=>-1).Mix, (a=>-1).MixHash,
  {},    {a=>42},
  :{},   :{a=>42},
  (),    <a b>,
  42,
  Nil,
;

# proper subset comparisons that should be True
my @갨k̲ =

  # no keys on left of same basic types
  set(),                   <a>.Set,
  SetHash.new,             <a>.Set,
  $e̲ò両,                    <a>.Set,
  bag(),                   <a>.Bag,
  BagHash.new,             <a>.Bag,
  $e̲丛両,                    <a>.Bag,
  mix(),                   <a>.Mix,
  MixHash.new,             <a>.Mix,
  $e̲ì両,                    <a>.Mix,
  {},                      {:a},
  :{},                     :{:a},
  (),                      ("a",),

  # no keys on left of different basic types
  set(),                   <a>.Bag,
  SetHash.new,             <a>.Bag,
  $e̲ò両,                    <a>.Bag,
  set(),                   <a>.Mix,
  SetHash.new,             <a>.Mix,
  $e̲ò両,                    <a>.Mix,
  set(),                   {:a},
  SetHash.new,             {:a},
  $e̲ò両,                    {:a},
  set(),                   :{:a},
  SetHash.new,             :{:a},
  $e̲ò両,                    :{:a},
  set(),                   ("a",),
  SetHash.new,             ("a",),
  $e̲ò両,                    ("a",),

  bag(),                   <a>.Mix,
  BagHash.new,             <a>.Mix,
  $e̲丛両,                    <a>.Mix,
  bag(),                   {:a},
  BagHash.new,             {:a},
  $e̲丛両,                    {:a},
  bag(),                   :{:a},
  BagHash.new,             :{:a},
  $e̲丛両,                    :{:a},
  bag(),                   ("a",),
  BagHash.new,             ("a",),
  $e̲丛両,                    ("a",),

  mix(),                   {:a},
  MixHash.new,             {:a},
  $e̲丛両,                    {:a},
  mix(),                   :{:a},
  MixHash.new,             :{:a},
  $e̲丛両,                    :{:a},
  mix(),                   ("a",),
  MixHash.new,             ("a",),
  $e̲丛両,                    ("a",),

  # fewer keys on left of same basic types
  <a>.Set,                 <a b>.Set,
  <a>.SetHash,             <a b>.Set,
  <a>.Bag,                 <a b>.Bag,
  <a>.BagHash,             <a b>.Bag,
  <a>.Mix,                 <a b>.Mix,
  <a>.MixHash,             <a b>.Mix,
  {:0a},                   {:a},   # falsy value means don't include
  :{:0a},                  :{:a},  # falsy value means don't include
  {:a},                    {:a,:b},
  :{:a},                   :{:a,:b},
  (:0a,),                  ("a",),
  ("a",),                  <a b>,

  # fewer keys on left of different basic types
  <a>.Set,                 <a b>.Bag,
  <a>.SetHash,             <a b>.Bag,
  <a>.Set,                 <a b>.Mix,
  <a>.SetHash,             <a b>.Mix,
  <a>.Set,                 {:a,:b},
  <a>.SetHash,             {:a,:b},
  <a>.Set,                 :{:a,:b},
  <a>.SetHash,             :{:a,:b},
  <a>.Set,                 <a b>,
  <a>.SetHash,             <a b>,

  <a>.Bag,                 <a b>.Mix,
  <a>.BagHash,             <a b>.Mix,
  <a>.Bag,                 {:a,:b},
  <a>.BagHash,             {:a,:b},
  <a>.Bag,                 :{:a,:b},
  <a>.BagHash,             :{:a,:b},
  <a>.Bag,                 <a b>,
  <a>.BagHash,             <a b>,

  <a>.Mix,                 {:a,:b},
  <a>.MixHash,             {:a,:b},
  <a>.Mix,                 :{:a,:b},
  <a>.MixHash,             :{:a,:b},
  <a>.Mix,                 <a b>,
  <a>.MixHash,             <a b>,

  # lower weight on left with same basic type
  <a>.Bag,                 <a a>.Bag,
  <a>.BagHash,             <a a>.Bag,
  <a>.Mix,                 <a a>.Mix,
  <a>.MixHash,             <a a>.Mix,
  (a=>-1).Mix,             mix(),  # virtual weight of "a" is 0
  (a=>-1).MixHash,         mix(),  # virtual weight of "a" is 0
  (a=>-1).Mix,             <a>.Mix,
  (a=>-1).MixHash,         <a>.Mix,
  (a=>-2).Mix,             (a=>-1).Mix,
  (a=>-2).MixHash,         (a=>-1).Mix,

  # lower weight on left with different basic type
  <a>.Bag,                 <a a>.Mix,
  <a>.BagHash,             <a a>.Mix,
;

# proper subset comparisons that should be False
my @丧갨k̲ =

  # the empties of same basic types
  set(),                   set(),
  set(),                   SetHash.new,
  SetHash.new,             SetHash.new,
  set(),                   $e̲ò両,
  SetHash.new,             $e̲ò両,

  bag(),                   bag(),
  bag(),                   BagHash.new,
  BagHash.new,             BagHash.new,
  bag(),                   $e̲丛両,
  BagHash.new,             $e̲丛両,

  mix(),                   mix(),
  mix(),                   MixHash.new,
  MixHash.new,             MixHash.new,
  mix(),                   $e̲ì両,
  MixHash.new,             $e̲ì両,

  {},                      {},
  :{},                     :{},
  (),                      (),

  # empties of different basic types
  set(),                   bag(),
  set(),                   BagHash.new,
  set(),                   $e̲丛両,
  set(),                   mix(),
  set(),                   MixHash.new,
  set(),                   $e̲ì両,
  set(),                   {},
  set(),                   :{},
  set(),                   (),

  bag(),                   mix(),
  bag(),                   MixHash.new,
  bag(),                   $e̲ì両,
  bag(),                   {},
  bag(),                   :{},
  bag(),                   (),

  # no keys on right for same basic types
  <a>.Set,                 set(),
  <a>.Set,                 SetHash.new,
  <a>.Set,                 $e̲ò両,
  <a>.Bag,                 bag(),
  <a>.Bag,                 BagHash.new,
  <a>.Bag,                 $e̲丛両,
  <a>.Mix,                 mix(),
  <a>.Mix,                 MixHash.new,
  <a>.Mix,                 $e̲ì両,
  {:a},                    {},
  :{:a},                   :{},
  ("a",),                  (),

  # no keys on right of different basic types
  <a>.Bag,                 set(),
  <a>.Bag,                 SetHash.new,
  <a>.Bag,                 $e̲ò両,
  <a>.Mix,                 set(),
  <a>.Mix,                 SetHash.new,
  <a>.Mix,                 $e̲ò両,
  {:a},                    set(),
  {:a},                    SetHash.new,
  {:a},                    $e̲ò両,
  :{:a},                   set(),
  :{:a},                   SetHash.new,
  :{:a},                   $e̲ò両,
  ("a",),                  set(),
  ("a",),                  SetHash.new,
  ("a",),                  $e̲ò両,

  <a>.Mix,                 bag(),
  <a>.Mix,                 BagHash.new,
  <a>.Mix,                 $e̲丛両,
  {:a},                    bag(),
  {:a},                    BagHash.new,
  {:a},                    $e̲丛両,
  :{:a},                   bag(),
  :{:a},                   BagHash.new,
  :{:a},                   $e̲丛両,
  ("a",),                  bag(),
  ("a",),                  BagHash.new,
  ("a",),                  $e̲丛両,

  {:a},                    mix(),
  {:a},                    MixHash.new,
  {:a},                    $e̲丛両,
  :{:a},                   mix(),
  :{:a},                   MixHash.new,
  :{:a},                   $e̲丛両,
  ("a",),                  mix(),
  ("a",),                  MixHash.new,
  ("a",),                  $e̲丛両,

  # fewer keys on right with same basic type
  <a b>.Set,               <a>.Set,
  <a b>.Set,               <a>.SetHash,
  <a b>.Bag,               <a>.Bag,
  <a b>.Bag,               <a>.BagHash,
  <a b>.Mix,               <a>.Mix,
  <a b>.Mix,               <a>.MixHash,
  {:a},                    {:0a},   # falsy value means don't include
  :{:a},                   :{:0a},  # falsy value means don't include
  {:a,:b},                 {:a},
  {:a,:b},                 {:a,:0b},
  :{:a,:b},                :{:a},
  :{:a,:b},                :{:a,:0b},
  <a b>,                   ("a",),
  <a b>,                   ("a",:0b),

  # fewer keys on right of different basic types
  <a b>.Set,               <a>.Bag,
  <a b>.SetHash,           <a>.Bag,
  <a b>.Set,               <a>.Mix,
  <a b>.SetHash,           <a>.Mix,
  <a b>.Set,               {:a},
  <a b>.SetHash,           {:a},
  <a b>.Set,               :{:a},
  <a b>.SetHash,           :{:a},
  <a b>.Set,               ("a",),
  <a b>.SetHash,           ("a",),

  <a b>.Bag,               <a>.Mix,
  <a b>.BagHash,           <a>.Mix,
  <a b>.Bag,               {:a},
  <a b>.BagHash,           {:a},
  <a b>.Bag,               :{:a},
  <a b>.BagHash,           :{:a},
  <a b>.Bag,               ("a",),
  <a b>.BagHash,           ("a",),

  <a b>.Mix,               {:a},
  <a b>.MixHash,           {:a},
  <a b>.Mix,               :{:a},
  <a b>.MixHash,           :{:a},
  <a b>.Mix,               ("a",),
  <a b>.MixHash,           ("a",),

  # lower weight on right with same basic type
  <a a>.Bag,               <a>.Bag,
  <a a>.Bag,               <a>.BagHash,
  <a a>.Mix,               <a>.Mix,
  <a a>.Mix,               <a>.MixHash,
  mix(),                   (a=>-1).Mix,      # virtual weight of "a" is 0
  mix(),                   (a=>-1).MixHash,  # virtual weight of "a" is 0
  <a>.Mix,                 (a=>-1).Mix,
  <a>.Mix,                 (a=>-1).MixHash,
  (a=>-1).Mix,             (a=>-2).Mix,
  (a=>-1).Mix,             (a=>-2).MixHash,

  # lower weight on right with different basic type
  <a a>.Bag,               <a>.Mix,
  <a a>.Bag,               <a>.MixHash,

  # same keys on left with same basic type (note, these are *not* identities)
  <a>.Set,                 <a>.Set,
  <a>.SetHash,             <a>.Set,
  {:a},                    {:a},
  :{:a},                   :{:a},

  # same keys on left with diffent basic type
  <a>.Set,                 <a>.Bag,
  <a>.SetHash,             <a>.BagHash,
  <a>.Set,                 <a>.Mix,
  <a>.SetHash,             <a>.MixHash,
  <a>.Set,                 {:a},
  <a>.SetHash,             {:a},
  <a>.Set,                 :{:a},
  <a>.SetHash,             :{:a},
  <a>.Set,                 ("a",),
  <a>.SetHash,             ("a",),

  <a>.Bag,                 <a>.Mix,
  <a>.BagHash,             <a>.MixHash,
  <a>.Bag,                 {:a},
  <a>.BagHash,             {:a},
  <a>.Bag,                 :{:a},
  <a>.BagHash,             :{:a},
  <a>.Bag,                 ("a",),
  <a>.BagHash,             ("a",),

  <a>.Mix,                 {:a},
  <a>.MixHash,             {:a},
  <a>.Mix,                 :{:a},
  <a>.MixHash,             :{:a},
  <a>.Mix,                 ("a",),
  <a>.MixHash,             ("a",),

  # same weight on left with same basic type (note, these are *not* identities)
  <a>.Bag,                 <a>.Bag,
  <a>.BagHash,             <a>.Bag,
  <a>.Mix,                 <a>.Mix,
  <a>.MixHash,             <a>.Mix,
  (a=>-1).Mix,             (a=>-1).Mix,
  (a=>-1).MixHash,         (a=>-1).Mix,

  # same weight on left with different basic type
  <a>.Bag,                 <a>.Mix,
  <a>.BagHash,             <a>.Mix,
;

plan 2 * (2 * @갢𝐝e̲丧中갢中갢e̲ò + @갨k̲ + @丧갨k̲ + 4) + 1 * (2 * @갢𝐝e̲丧中갢中갢e̲ò + @갨k̲ + @丧갨k̲ + 4) + 2;

# is proper subset of / proper superset of
for
  &infix:<<(<)>>,   "(<)", &infix:<<(>)>>,   "(>)",
  &infix:<⊂>,         "⊂", &infix:<⊃>,         "⊃"
-> &op, $name, &rop, $rname {

    for @갢𝐝e̲丧中갢中갢e̲ò -> $ident {
#exit dd $ident, $name, False unless
        is-deeply  op($ident,$ident), False, "$ident.^name() $name same";
#exit dd $ident, $rname, False unless
        is-deeply rop($ident,$ident), False, "$ident.^name() $rname same";
    }

    for @갨k̲ -> $left, $right {
#exit dd $left, $right, $name, True unless
        is-deeply op($left,$right), True,
          "$left is $name of $right.^name()";
#exit dd $right, $left, $rname, True unless
        is-deeply rop($right,$left), True,
          "$right.^name() $rname $left";
    }

    for @丧갨k̲ -> $left, $right {
#exit dd $left, $right, $name, False unless
        is-deeply op($left,$right), False,
          "$right is NOT $name of $left.^name()";
#exit dd $right, $left, $rname, False unless
        is-deeply rop($right,$left), False,
          "$left.^name() NOT $rname $right";
    }

    throws-like { op(1,Failure.new) }, Exception,
      "$name with a Failure:D on the RHS throws";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name with a Failure:D on the LHS throws";
    throws-like { rop(1,Failure.new) }, Exception,
      "$rname with a Failure:D on the RHS throws";
    throws-like { rop(Failure.new,^3) }, Exception,
      "$rname with a Failure:D on the LHS throws";
}

# is not a proper subset of / is not a proper superset of
for
  &infix:<⊄>,   "⊈", &infix:<⊅>,   "⊅"
-> &op, $name, &rop, $rname {

    for @갢𝐝e̲丧中갢中갢e̲ò -> $ident {
#exit dd $ident, $name, True unless
        is-deeply  op($ident,$ident), True, "$ident.^name() $name same";
#exit dd $ident, $rname, True unless
        is-deeply rop($ident,$ident), True, "$ident.^name() $rname same";
    }

    for @갨k̲ -> $left, $right {
#exit dd $left, $right, $name, False unless
        is-deeply op($left,$right), False,
          "$left is NOT $name of $right.^name()";
#exit dd $right, $left, $rname, False unless
        is-deeply rop($right,$left), False,
          "$right.^name() NOT $rname $left";
    }

    for @丧갨k̲ -> $left, $right {
#exit dd $left, $right, $name, True unless
        is-deeply op($left,$right), True,
          "$right is NOT $name of $left.^name()";
#exit dd $right, $left, $rname, True unless
        is-deeply rop($right,$left), True,
          "$left.^name() NOT $rname $right";
    }

    throws-like { op(1,Failure.new) }, Exception,
      "$name with a Failure:D on the RHS throws";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name with a Failure:D on the LHS throws";
    throws-like { rop(1,Failure.new) }, Exception,
      "$rname with a Failure:D on the RHS throws";
    throws-like { rop(Failure.new,^3) }, Exception,
      "$rname with a Failure:D on the LHS throws";
}

# https://github.com/rakudo/rakudo/issues/2167
{
    is-deeply 1 (>) ($ = :42foo,), False, 'no explosion (>)';
    is-deeply 1 (<) ($ = :42foo,), False, 'no explosion (<)';
}

# vim: expandtab shiftwidth=4
