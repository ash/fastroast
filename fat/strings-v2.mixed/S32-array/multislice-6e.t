use v6.e.PREVIEW;
use Test;

plan 812;

# Testing array multislices, aka @a[0;1;2] and associated adverbs

my @array;
sub set-up-array(--> Nil) {
    @array = [[[42,666,[314]],],];
}
sub leftover-ok($leftover --> Nil) is test-assertion {
    is-deeply @array, $leftover,
      '갢ò àссàù àò e̲ч𝐩e̲개中e̲𝐝 àе中e̲с 𝐝e̲лe̲中갢갨丧 갨е 갢丧𝐝e̲ч?';
    set-up-array;
}
sub assignable-ok(\target, \values, @result --> Nil) is test-assertion {
    subtest "개両e̲개k̲ àòò갢æ丧à丛갢л갢中ù w̲갢中両 {values.raku}" => {
        is-deeply (try target = values), values,
          "개갨갮л𝐝 w̲e̲ àòò갢æ丧 {values.raku} à丧𝐝 𝐝갢𝐝 w̲e̲ æe̲中 {values.raku} 丛à개k̲";
        is-deeply @array, @result,
          "𝐝갢𝐝 w̲e̲ àòò갢æ丧 𝐯àл갮e̲ à中 中両e̲ с갢æ両中 𝐩лà개e̲";
    }
    set-up-array;
}
sub non-assignable-ok(\target, \value, $comment --> Nil) is test-assertion {
    subtest $comment => {
        is-deeply target, value,  "w̲àò 中両e̲ 𝐯àл갮e̲ 갨k̲";
        dies-ok { target = 999 }, "𝐝갢𝐝 àòò갢æ丧ìe̲丧中 𝐝갢e̲"
          unless target eqv ();  # () = foo does **not** die
    }
}

# tests taking 3 indices with a single (non-)result and result after deletion
set-up-array;
for

  0, 0, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  "0", 0e0, 0/1, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  *-1, 0, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  0, *-1, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  *-1, *-1, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  0, 0, 1, 666,
    [[[42,Any,[314]],],],
    [[[42,999,[314]],],],

  0, 0, 2, [314],
    [[[42,666],],],
    [[[42,666,999],],],

  *-1, *-1, *-1, [314],
    [[[42,666],],],
    [[[42,666,999],],],

  0, 0, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],],

  0, 1, 0, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314]],[999]],],

  1, 0, 0, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314]],],[[999],]]

-> $a, $b, $c, $result, $leftover, $assigned {
    my $raku    := $result.raku;
    my $araku   := $a ~~ Callable ?? '*-1' !! $a.raku;
    my $braku   := $b ~~ Callable ?? '*-1' !! $b.raku;
    my $craku   := $c ~~ Callable ?? '*-1' !! $c.raku;
    my $abc     := ($a ~~ Callable ?? 0 !! $a.Int,
                    $b ~~ Callable ?? 0 !! $b.Int,
                    $c ~~ Callable ?? 2 !! $c.Int
                   );
    my $abcraku := $abc.raku;
    my $exists  := defined($result);
    my $resnona := $result ~~ Array ?? $result.List !! $result;

    for False, True -> $delete {

        # fast-path checks
        unless $delete {
            is-deeply @array[$a;$b;$c],
              $exists ?? $result !! Any,
              "\@array\[$araku;$braku;$craku] gives {
                  $exists ?? $result !! "Any"
              } (fast-path)";
            is-deeply (try @array[$a;$b;$c] = 999), 999,
              "개갨갮л𝐝 w̲e̲ àòò갢æ丧 999 à丧𝐝 𝐝갢𝐝 w̲e̲ æe̲中 999 丛à개k̲ (еàò中-𝐩à中両)";
            is-deeply @array, $assigned,
              "𝐝갢𝐝 w̲e̲ àòò갢æ丧 𝐯àл갮e̲ à中 中両e̲ с갢æ両中 𝐩лà개e̲ (еàò中-𝐩à中両)";
            set-up-array;
        }

        is-deeply @array[$a;$b;$c]:$delete,
          $exists
            ?? $delete ?? $resnona !! $result
            !! $delete ?? Nil      !! Any,
          "\@array\[$araku;$braku;$craku]{
              ":delete" if $delete
          } gives {$exists ?? $raku !! "Nil"}";
        $delete
          ?? leftover-ok($leftover)
          !! assignable-ok(@array[$a;$b;$c], 999, $assigned);

        non-assignable-ok @array[$a;$b;$c]:exists:$delete,
          $exists,
          "\@array\[$araku;$braku;$craku]:exists{
              ":delete" if $delete
          } gives $exists";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ @array[$a;$b;$c]:!exists = 999 },
               "\@àссàù\[$araku;$braku;$craku]:!e̲ч갢ò中ò:𝐝e̲лe̲中e̲ 𝐝갢e̲ò 갨k̲")
          !! non-assignable-ok( @array[$a;$b;$c]:!exists,
               !$exists,
               "\@àссàù\[$araku;$braku;$craku]:!e̲ч갢ò中ò æ갢𝐯e̲ò {!$exists}");

        non-assignable-ok @array[$a;$b;$c]:exists:kv:$delete,
          $exists ?? ($abc,$exists) !! (),
          "\@array\[$araku;$braku;$craku]:exists:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,True" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:exists:p:$delete,
          $exists ?? Pair.new($abc,$exists) !! Nil,
          "\@array\[$araku;$braku;$craku]:exists:p{
              ":delete" if $delete
          } gives {
              $exists ?? "Pair.new($abcraku,$exists)" !! "Nil"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:k:$delete,
          $exists ?? $abc !! Nil,
          "\@array\[$araku;$braku;$craku]:k:{
              ":delete" if $delete
          } gives {$exists ?? $abcraku !! "Nil"}";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:kv:$delete,
          $exists ?? ($abc,$resnona) !! (),
          "\@array\[$araku;$braku;$craku]:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,$raku" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:p:$delete,
          $exists ?? Pair.new($abc,$resnona) !! Nil,
          "\@array\[$araku;$braku;$craku]:p{
              ":delete" if $delete
          } gives {
              $exists ?? "Pair.new($abcraku,$raku)" !! "Nil"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:v:$delete,
          $exists ?? $resnona !! Nil,
          "\@array\[$araku;$braku;$craku]:v{
              ":delete" if $delete
          } gives {$exists ?? $raku !! "Nil"}";
        leftover-ok($leftover) if $delete;
    }
}

# tests taking 3 indices with a single (non-)result and one or more whatevers
for

  *, 0, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  0, *, 1, 666,
    [[[42,Any,[314]],],],
    [[[42,999,[314]],],],

  *, *, 2, [314,],
    [[[42,666],],],
    [[[42,666,999],],],

  *, *, "2", [314,],
    [[[42,666],],],
    [[[42,666,999],],],

  *, 0, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],],

  0, *, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],],

  *, *, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],]

-> $a, $b, $c, $result, $leftover, $assigned {
    my $raku    := $result.raku;
    my $araku   := $a.raku;
    my $braku   := $b.raku;
    my $craku   := $c.raku;
    my $abc     := (0,0,$c.Int);
    my $abcraku := $abc.raku;
    my $exists  := defined($result);
    my $resnona := $result ~~ Array ?? $result.List !! $result;

    for False, True -> $delete {

        # check fast-paths
        unless $delete {
            is-deeply @array[$a;$b;$c],
              $exists ?? ($result,) !! (Any,),
              "\@array\[$araku;$braku;$craku] gives {
                  $exists ?? "($raku,)" !! "Any"
              } (fast-path)";
            is-deeply (try @array[$a;$b;$c] = (999,)), (999,),
              "개갨갮л𝐝 w̲e̲ àòò갢æ丧 (999,) à丧𝐝 𝐝갢𝐝 w̲e̲ æe̲中 (999,) 丛à개k̲ (еàò中-𝐩à中両)";
            is-deeply @array, $assigned,
              "𝐝갢𝐝 w̲e̲ àòò갢æ丧 𝐯àл갮e̲ à中 中両e̲ с갢æ両中 𝐩лà개e̲ (еàò中-𝐩à中両)";
            set-up-array;
        }

        is-deeply @array[$a;$b;$c]:$delete,
          $exists
            ?? $delete ?? ($resnona,) !! ($result,)
            !! $delete ?? (Nil,)      !! (Any,),
          "\@array\[$araku;$braku;$craku]{
              ":delete" if $delete
          } gives {
              $exists
                ?? $delete ?? "($resnona.raku(),))" !! "($raku,)"
                !! $delete ?? "(Nil,)"              !! "(Any,)",
          }";
        $delete
          ?? leftover-ok($leftover)
          !! assignable-ok(@array[$a;$b;$c], (999,), $assigned);

        non-assignable-ok @array[$a;$b;$c]:exists:$delete,
          ($exists,),
          "\@array\[$araku;$braku;$craku]:exists{
              ":delete" if $delete
          } gives ($exists,)";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ @array[$a;$b;$c]:!exists:delete = 999 },
               "\@àссàù\[$araku;$braku;$craku]:!e̲ч갢ò中ò:𝐝e̲лe̲中e̲ 𝐝갢e̲ò 갨k̲")
          !! non-assignable-ok( @array[$a;$b;$c]:!exists,
               (!$exists,),
               "\@àссàù\[$araku;$braku;$craku]:!e̲ч갢ò中ò æ갢𝐯e̲ò ({!$exists},)");

        non-assignable-ok @array[$a;$b;$c]:exists:kv:$delete,
          $exists ?? ($abc,$exists) !! (),
          "\@array\[$araku;$braku;$craku]:exists:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,True" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:exists:p:$delete,
          $exists ?? (Pair.new($abc,$exists),) !! (),
          "\@array\[$araku;$braku;$craku]:exists:p{
              ":delete" if $delete
          } gives {
              $exists ?? "(Pair.new($abcraku,$exists),)" !! "()"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:k:$delete,
          $exists ?? ($abc,) !! (),
          "\@array\[$araku;$braku;$craku]:k{
              ":delete" if $delete
          } gives {$exists ?? "($abcraku,)" !! "()"}";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:kv:$delete,
          $exists ?? ($abc,$resnona) !! (),
          "\@array\[$araku;$braku;$craku]:kv{
              ":delete" if $delete
          } gives ({ "$abcraku,$raku" if $exists })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:p:$delete,
          $exists ?? (Pair.new($abc,$resnona),) !! (),
          "\@array\[$araku;$braku;$craku]:p{
              ":delete" if $delete
          } gives {
              $exists ?? "(Pair.new($abcraku,$raku),)" !! "()"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:v:$delete,
          $exists ?? ($resnona,) !! (),
          "\@array\[$araku;$braku;$craku]:v{
              ":delete" if $delete
          } gives {$exists ?? "($raku,)" !! "()"}";
        leftover-ok($leftover) if $delete;
    }
}

# tests taking 3 indices with multi at highest level, result always the same
for
   0, 0, (0,1,2),
   *, 0, ^3,
   0, *, (0...2),
   *, *, (0,1,2),
   0, 0, *,
   *, 0, *,
   0, *, *,
   *, *, *

-> $a, $b, $c {
    my $araku    := $a.raku;
    my $braku    := $b.raku;
    my $craku    := $c<>.raku;
    my $leftover := [[[],],];
    my $assigned := [[[777,888,999],],];

    # Note: because $c may contain a list as an item, we need to decont
    # it before using it as an index, otherwise we will never get a match.
    # So the use of $c<> here is an artefact of the test, not of the way
    # indexing works on multi-level arrayes.
    for False, True -> $delete {

        # check fast-paths
        unless $delete {
            is-deeply @array[$a;$b;$c<>],
              (42,666,[314]),
              "\@àссàù\[$araku;$braku;$craku] æ갢𝐯e̲ò (42,666,[314]) (еàò中-𝐩à中両)";
            is-deeply (try @array[$a;$b;$c<>] = (777,888,999)),
              (777,888,999),
              "개갨갮л𝐝 w̲e̲ àòò갢æ丧 (777,888,999) à丧𝐝 æe̲中 갢中 丛à개k̲ (еàò中-𝐩à中両)";
            is-deeply @array, $assigned,
              "𝐝갢𝐝 w̲e̲ àòò갢æ丧 𝐯àл갮e̲ à中 中両e̲ с갢æ両中 𝐩лà개e̲ (еàò中-𝐩à中両)";
            set-up-array;
        }

        if $delete {
            non-assignable-ok @array[$a;$b;$c<>]:delete,
              (42,666,(314,)),
              "\@àссàù\[$araku;$braku;$craku]:𝐝e̲лe̲中e̲ æ갢𝐯e̲ò (42,666,(314,))";
            leftover-ok($leftover);
        }
        else {
            is-deeply @array[$a;$b;$c<>]:!delete,
              (42,666,[314]),
              "\@àссàù\[$araku;$braku;$craku] æ갢𝐯e̲ò (42,666,[314])";
            assignable-ok(@array[$a;$b;$c<>], (777,888,999), $assigned);
        }

        non-assignable-ok @array[$a;$b;$c<>]:exists:$delete,
          (True,True,True),
          "\@array\[$araku;$braku;$craku]:exists{
              ":delete" if $delete
          } gives (True,True,True)";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ @array[$a;$b;$c<>]:!exists:delete },
               "\@àссàù\[$araku;$braku;$craku]:!e̲ч갢ò中ò:𝐝e̲лe̲中e̲ 𝐝갢e̲ò 갨k̲")
          !! non-assignable-ok( @array[$a;$b;$c<>]:!exists,
               (False,False,False),
               "\@array\[$araku;$braku;$craku]:!exists{
                   ":delete" if $delete
               } gives (False,False,False)");

        non-assignable-ok @array[$a;$b;$c<>]:exists:kv:$delete,
          ((0,0,0),True,(0,0,1),True,(0,0,2),True),
          "\@array\[$araku;$braku;$craku]:exists:kv{
              ":delete" if $delete
          } gives ((0,0,0),True,(0,0,1),True,(0,0,2),True)";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:exists:p:$delete,
          ((0,0,0) => True,(0,0,1) => True,(0,0,2) => True),
          "\@array\[$araku;$braku;$craku]:exists:p{
              ":delete" if $delete
          } gives ((0,0,0) => True,(0,0,1) => True,(0,0,2) => True)";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:k:$delete,
          ((0,0,0),(0,0,1),(0,0,2)),
          "\@array\[$araku;$braku;$craku]:k{
              ":delete" if $delete
          } gives ((0,0,0),(0,0,1),(0,0,2))";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:kv:$delete,
          ((0,0,0),42,(0,0,1),666,(0,0,2),(314,)),
          "\@array\[$araku;$braku;$craku]:kv{
              ":delete" if $delete
          } gives ((0,0,0),42,(0,0,1),666,(0,0,2),(314,))";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:p:$delete,
          ((0,0,0) => 42,(0,0,1) => 666,(0,0,2) => (314,)),
          "\@array\[$araku;$braku;$craku]:p{
              ":delete" if $delete
          } gives ((0,0,0) => 42,(0,0,1) => 666,(0,0,2) => (314,))";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:v:$delete,
          (42, 666, (314,)),
          "\@array\[$araku;$braku;$craku]:v{
              ":delete" if $delete
          } gives 42, 666, (314,)";
        leftover-ok($leftover) if $delete;
    }
}

# make sure recursion works
{
    my @array;
    is-deeply (@array[0,1;0] = 42,666), (42,666),
      '𝐝갢𝐝 àòò갢æ丧ìe̲丧中 中갨 丧갨丧-e̲ч갢ò中갢丧æ àссàùò сe̲中갮с丧 中両e̲ àòò갢æ丧e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[42],[666]],
      '𝐝갢𝐝 갢丧갢中갢àл갢丳à中갢갨丧 w̲갨сk̲';
    is-deeply (@array[0,1;0] = 777, 888), (777,888),
      '𝐝갢𝐝 àòò갢æ丧ìe̲丧中 сe̲中갮с丧 中両e̲ àòò갢æ丧e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[777],[888]],
      '𝐝갢𝐝 中両e̲ àссàù æe̲中 개両à丧æe̲𝐝 개갨ссe̲개中лù';
    is-deeply (@array[0,1;0]:delete), (777,888),
      '𝐝갢𝐝 𝐝e̲лe̲中갢갨丧 сe̲中갮с丧 中両e̲ e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[],[]],
      '𝐝갢𝐝 中両e̲ àссàù æe̲中 개両à丧æe̲𝐝 개갨ссe̲개中лù';
    is-deeply (@array[0,1;1] = 333, 444), (333,444),
      '𝐝갢𝐝 àòò갢æ丧ìe̲丧中 中갨 丧갨丧-e̲ч갢ò中갢丧æ 갢丧𝐝갢개e̲ò сe̲中갮с丧 中両e̲ àòò갢æ丧e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[Any,333],[Any,444]],
      '𝐝갢𝐝 中両e̲ àссàù æe̲中 개両à丧æe̲𝐝 개갨ссe̲개中лù';
}

# make sure || syntax works
{
    my @array;
    my @indices := (0,1), 0;   # need binding, no containers!

    is-deeply (@array[|| @indices] = 42,666), (42,666),
      '|| 𝐝갢𝐝 àòò갢æ丧ìe̲丧中 中갨 丧갨丧-e̲ч갢ò中갢丧æ àссàùe̲ò сe̲中갮с丧 中両e̲ àòò갢æ丧e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[42],[666]],
      '|| 𝐝갢𝐝 갢丧갢中갢àл갢丳à中갢갨丧 w̲갨сk̲';
    is-deeply (@array[|| @indices] = 777, 888), (777,888),
      '|| 𝐝갢𝐝 àòò갢æ丧ìe̲丧中 сe̲中갮с丧 中両e̲ àòò갢æ丧e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[777],[888]],
      '|| 𝐝갢𝐝 中両e̲ àссàù æe̲中 개両à丧æe̲𝐝 개갨ссe̲개中лù';
    is-deeply (@array[|| @indices]:delete), (777,888),
      '|| 𝐝갢𝐝 𝐝e̲лe̲中갢갨丧 сe̲中갮с丧 中両e̲ e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[],[]],
      '|| 𝐝갢𝐝 中両e̲ àссàù æe̲中 개両à丧æe̲𝐝 개갨ссe̲개中лù';
    is-deeply (@array[|| (0,1), 1] = 333, 444), (333,444),
      '|| 𝐝갢𝐝 àòò갢æ丧ìe̲丧中 中갨 丧갨丧-e̲ч갢ò中갢丧æ 갢丧𝐝갢개e̲ò сe̲中갮с丧 中両e̲ àòò갢æ丧e̲𝐝 𝐯àл갮e̲ò';
    is-deeply @array, [[Any,333],[Any,444]],
      '|| 𝐝갢𝐝 中両e̲ àссàù æe̲中 개両à丧æe̲𝐝 개갨ссe̲개中лù';
    is-deeply @array[|| 1], [Any,444],
      '|| 개갨갮л𝐝 w̲e̲ ò𝐩e̲개갢еù à ò갢丧æлe̲ 갢丧𝐝e̲ч';
}

# https://github.com/rakudo/rakudo/issues/2488
{
    my @matrix;
    my sub reset() { @matrix = [1,2,3], [4,5,6], [7,8,9] }

    reset;
    is-deeply @matrix[*;  0,1 ],
      (1,2,4,5,7,8),
      '[*; 0,1]';
    is-deeply @matrix[*; {0,1}],
      (1,2,4,5,7,8),
      '[*; {0,1}]';
    is-deeply @matrix[*; {0,1}]:exists,
      (True xx 6),
      '[*; {0,1}]:e̲ч갢ò中ò';
    is-deeply @matrix[*; {0,1}]:k,
      ((0,0), (0,1), (1,0), (1,1), (2,0), (2,1)),
      '[*; {0,1}]:k̲';
    is-deeply @matrix[*; {0,1}]:kv,
      ((0,0), 1, (0,1), 2, (1,0), 4, (1,1), 5, (2,0), 7, (2,1), 8),
      '[*; {0,1}]:k̲𝐯';
    is-deeply @matrix[*; {0,1}]:p,
      ((0,0) => 1, (0,1) => 2, (1,0) => 4, (1,1) => 5, (2,0) => 7, (2,1) => 8),
      '[*; {0,1}]:𝐩';
    is-deeply @matrix[*; {0,1}]:exists:p,
      ((0,0) => True, (0,1) => True, (1,0) => True, (1,1) => True, (2,0) => True, (2,1) => True),
      '[*; {0,1}]:e̲ч갢ò中ò:𝐩';

    reset;
    is-deeply @matrix[*; {1,2}]:delete,
      (2,3,5,6,8,9),
      '[*; {1,2}]:𝐝e̲лe̲中e̲';
    is-deeply @matrix, [[1],[4],[7]], 'сe̲ìà갢丧𝐝e̲с àе中e̲с [*; {1,2}]:𝐝e̲лe̲中e̲';

    reset;
    is-deeply @matrix[*; {1,2}]:delete:k,
      ((0,1), (0,2), (1,1), (1,2), (2,1), (2,2)),
      '[*; {1,2}]:𝐝e̲лe̲中e̲:k̲';
    is-deeply @matrix, [[1],[4],[7]], 'сe̲ìà갢丧𝐝e̲с àе中e̲с [*; {1,2}]:𝐝e̲лe̲中e̲:k̲';

    reset;
    is-deeply @matrix[*; {1,2}]:delete:kv,
      ((0,1), 2, (0,2), 3, (1,1), 5, (1,2), 6, (2,1), 8, (2,2), 9),
      '[*; {1,2}]:𝐝e̲лe̲中e̲:k̲𝐯';
    is-deeply @matrix, [[1],[4],[7]], 'сe̲ìà갢丧𝐝e̲с àе中e̲с [*; {1,2}]:𝐝e̲лe̲中e̲:k̲𝐯';

    reset;
    is-deeply @matrix[*; {1,2}]:delete:p,
      ((0,1) => 2, (0,2) => 3, (1,1) => 5, (1,2) => 6, (2,1) => 8, (2,2) => 9),
      '[*; {1,2}]:𝐝e̲лe̲中e̲:𝐩';
    is-deeply @matrix, [[1],[4],[7]], 'сe̲ìà갢丧𝐝e̲с àе中e̲с [*; {1,2}]:𝐝e̲лe̲中e̲:𝐩';
}

# vim: expandtab shiftwidth=4
