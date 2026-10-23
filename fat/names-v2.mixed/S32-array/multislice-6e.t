use v6.e.PREVIEW;
use Test;

plan 812;

# Testing array multislices, aka @a[0;1;2] and associated adverbs

my @àссàù;
sub òe̲中-갮𝐩-àссàù(--> Nil) {
    @àссàù = [[[42,666,[314]],],];
}
sub лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с --> Nil) is test-assertion {
    is-deeply @àссàù, $лe̲е中갨𝐯e̲с,
      'is array as expected after deletion of index?';
    òe̲中-갮𝐩-àссàù;
}
sub àòò갢æ丧à丛лe̲-갨k̲(\target, \values, @result --> Nil) is test-assertion {
    subtest "check assignability with {values.raku}" => {
        is-deeply (try target = values), values,
          "could we assign {values.raku} and did we get {values.raku} back";
        is-deeply @àссàù, @result,
          "did we assign value at the right place";
    }
    òe̲中-갮𝐩-àссàù;
}
sub 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲(\target, \value, $comment --> Nil) is test-assertion {
    subtest $comment => {
        is-deeply target, value,  "was the value ok";
        dies-ok { target = 999 }, "did assignment die"
          unless target eqv ();  # () = foo does **not** die
    }
}

# tests taking 3 indices with a single (non-)result and result after deletion
òe̲中-갮𝐩-àссàù;
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

-> $a, $b, $c, $result, $лe̲е中갨𝐯e̲с, $àòò갢æ丧e̲𝐝 {
    my $сàk̲갮    := $result.raku;
    my $àсàk̲갮   := $a ~~ Callable ?? '*-1' !! $a.raku;
    my $丛сàk̲갮   := $b ~~ Callable ?? '*-1' !! $b.raku;
    my $개сàk̲갮   := $c ~~ Callable ?? '*-1' !! $c.raku;
    my $à丛개     := ($a ~~ Callable ?? 0 !! $a.Int,
                    $b ~~ Callable ?? 0 !! $b.Int,
                    $c ~~ Callable ?? 2 !! $c.Int
                   );
    my $à丛개сàk̲갮 := $à丛개.raku;
    my $e̲ч갢ò中ò  := defined($result);
    my $сe̲ò丧갨丧à := $result ~~ Array ?? $result.List !! $result;

    for False, True -> $delete {

        # fast-path checks
        unless $delete {
            is-deeply @àссàù[$a;$b;$c],
              $e̲ч갢ò中ò ?? $result !! Any,
              "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮] gives {
                  $e̲ч갢ò中ò ?? $result !! "Any"
              } (fast-path)";
            is-deeply (try @àссàù[$a;$b;$c] = 999), 999,
              "could we assign 999 and did we get 999 back (fast-path)";
            is-deeply @àссàù, $àòò갢æ丧e̲𝐝,
              "did we assign value at the right place (fast-path)";
            òe̲中-갮𝐩-àссàù;
        }

        is-deeply @àссàù[$a;$b;$c]:$delete,
          $e̲ч갢ò中ò
            ?? $delete ?? $сe̲ò丧갨丧à !! $result
            !! $delete ?? Nil      !! Any,
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? $сàk̲갮 !! "Nil"}";
        $delete
          ?? лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с)
          !! àòò갢æ丧à丛лe̲-갨k̲(@àссàù[$a;$b;$c], 999, $àòò갢æ丧e̲𝐝);

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:exists:$delete,
          $e̲ч갢ò中ò,
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists{
              ":delete" if $delete
          } gives $e̲ч갢ò中ò";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        $delete
          ?? dies-ok({ @àссàù[$a;$b;$c]:!exists = 999 },
               "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:!exists:delete dies ok")
          !! 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲( @àссàù[$a;$b;$c]:!exists,
               !$e̲ч갢ò中ò,
               "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:!exists gives {!$e̲ч갢ò中ò}");

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:exists:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$e̲ч갢ò中ò) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists:kv{
              ":delete" if $delete
          } gives ({
              "$à丛개сàk̲갮,True" if $e̲ч갢ò中ò
          })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:exists:p:$delete,
          $e̲ч갢ò中ò ?? Pair.new($à丛개,$e̲ч갢ò中ò) !! Nil,
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "Pair.new($à丛개сàk̲갮,$e̲ч갢ò中ò)" !! "Nil"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:k:$delete,
          $e̲ч갢ò中ò ?? $à丛개 !! Nil,
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:k:{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? $à丛개сàk̲갮 !! "Nil"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$сe̲ò丧갨丧à) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:kv{
              ":delete" if $delete
          } gives ({
              "$à丛개сàk̲갮,$сàk̲갮" if $e̲ч갢ò中ò
          })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:p:$delete,
          $e̲ч갢ò中ò ?? Pair.new($à丛개,$сe̲ò丧갨丧à) !! Nil,
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "Pair.new($à丛개сàk̲갮,$сàk̲갮)" !! "Nil"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:v:$delete,
          $e̲ч갢ò中ò ?? $сe̲ò丧갨丧à !! Nil,
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:v{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? $сàk̲갮 !! "Nil"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;
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

-> $a, $b, $c, $result, $лe̲е中갨𝐯e̲с, $àòò갢æ丧e̲𝐝 {
    my $сàk̲갮    := $result.raku;
    my $àсàk̲갮   := $a.raku;
    my $丛сàk̲갮   := $b.raku;
    my $개сàk̲갮   := $c.raku;
    my $à丛개     := (0,0,$c.Int);
    my $à丛개сàk̲갮 := $à丛개.raku;
    my $e̲ч갢ò中ò  := defined($result);
    my $сe̲ò丧갨丧à := $result ~~ Array ?? $result.List !! $result;

    for False, True -> $delete {

        # check fast-paths
        unless $delete {
            is-deeply @àссàù[$a;$b;$c],
              $e̲ч갢ò中ò ?? ($result,) !! (Any,),
              "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮] gives {
                  $e̲ч갢ò中ò ?? "($сàk̲갮,)" !! "Any"
              } (fast-path)";
            is-deeply (try @àссàù[$a;$b;$c] = (999,)), (999,),
              "could we assign (999,) and did we get (999,) back (fast-path)";
            is-deeply @àссàù, $àòò갢æ丧e̲𝐝,
              "did we assign value at the right place (fast-path)";
            òe̲中-갮𝐩-àссàù;
        }

        is-deeply @àссàù[$a;$b;$c]:$delete,
          $e̲ч갢ò中ò
            ?? $delete ?? ($сe̲ò丧갨丧à,) !! ($result,)
            !! $delete ?? (Nil,)      !! (Any,),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò
                ?? $delete ?? "($сe̲ò丧갨丧à.raku(),))" !! "($сàk̲갮,)"
                !! $delete ?? "(Nil,)"              !! "(Any,)",
          }";
        $delete
          ?? лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с)
          !! àòò갢æ丧à丛лe̲-갨k̲(@àссàù[$a;$b;$c], (999,), $àòò갢æ丧e̲𝐝);

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:exists:$delete,
          ($e̲ч갢ò中ò,),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists{
              ":delete" if $delete
          } gives ($e̲ч갢ò中ò,)";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        $delete
          ?? dies-ok({ @àссàù[$a;$b;$c]:!exists:delete = 999 },
               "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:!exists:delete dies ok")
          !! 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲( @àссàù[$a;$b;$c]:!exists,
               (!$e̲ч갢ò中ò,),
               "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:!exists gives ({!$e̲ч갢ò中ò},)");

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:exists:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$e̲ч갢ò中ò) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists:kv{
              ":delete" if $delete
          } gives ({
              "$à丛개сàk̲갮,True" if $e̲ч갢ò中ò
          })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:exists:p:$delete,
          $e̲ч갢ò中ò ?? (Pair.new($à丛개,$e̲ч갢ò中ò),) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "(Pair.new($à丛개сàk̲갮,$e̲ч갢ò中ò),)" !! "()"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:k:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:k{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? "($à丛개сàk̲갮,)" !! "()"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$сe̲ò丧갨丧à) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:kv{
              ":delete" if $delete
          } gives ({ "$à丛개сàk̲갮,$сàk̲갮" if $e̲ч갢ò中ò })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:p:$delete,
          $e̲ч갢ò中ò ?? (Pair.new($à丛개,$сe̲ò丧갨丧à),) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "(Pair.new($à丛개сàk̲갮,$сàk̲갮),)" !! "()"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c]:v:$delete,
          $e̲ч갢ò中ò ?? ($сe̲ò丧갨丧à,) !! (),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:v{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? "($сàk̲갮,)" !! "()"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;
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
    my $àсàk̲갮    := $a.raku;
    my $丛сàk̲갮    := $b.raku;
    my $개сàk̲갮    := $c<>.raku;
    my $лe̲е中갨𝐯e̲с := [[[],],];
    my $àòò갢æ丧e̲𝐝 := [[[777,888,999],],];

    # Note: because $c may contain a list as an item, we need to decont
    # it before using it as an index, otherwise we will never get a match.
    # So the use of $c<> here is an artefact of the test, not of the way
    # indexing works on multi-level arrayes.
    for False, True -> $delete {

        # check fast-paths
        unless $delete {
            is-deeply @àссàù[$a;$b;$c<>],
              (42,666,[314]),
              "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮] gives (42,666,[314]) (fast-path)";
            is-deeply (try @àссàù[$a;$b;$c<>] = (777,888,999)),
              (777,888,999),
              "could we assign (777,888,999) and get it back (fast-path)";
            is-deeply @àссàù, $àòò갢æ丧e̲𝐝,
              "did we assign value at the right place (fast-path)";
            òe̲中-갮𝐩-àссàù;
        }

        if $delete {
            丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:delete,
              (42,666,(314,)),
              "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:delete gives (42,666,(314,))";
            лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с);
        }
        else {
            is-deeply @àссàù[$a;$b;$c<>]:!delete,
              (42,666,[314]),
              "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮] gives (42,666,[314])";
            àòò갢æ丧à丛лe̲-갨k̲(@àссàù[$a;$b;$c<>], (777,888,999), $àòò갢æ丧e̲𝐝);
        }

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:exists:$delete,
          (True,True,True),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists{
              ":delete" if $delete
          } gives (True,True,True)";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        $delete
          ?? dies-ok({ @àссàù[$a;$b;$c<>]:!exists:delete },
               "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:!exists:delete dies ok")
          !! 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲( @àссàù[$a;$b;$c<>]:!exists,
               (False,False,False),
               "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:!exists{
                   ":delete" if $delete
               } gives (False,False,False)");

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:exists:kv:$delete,
          ((0,0,0),True,(0,0,1),True,(0,0,2),True),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists:kv{
              ":delete" if $delete
          } gives ((0,0,0),True,(0,0,1),True,(0,0,2),True)";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:exists:p:$delete,
          ((0,0,0) => True,(0,0,1) => True,(0,0,2) => True),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:exists:p{
              ":delete" if $delete
          } gives ((0,0,0) => True,(0,0,1) => True,(0,0,2) => True)";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:k:$delete,
          ((0,0,0),(0,0,1),(0,0,2)),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:k{
              ":delete" if $delete
          } gives ((0,0,0),(0,0,1),(0,0,2))";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:kv:$delete,
          ((0,0,0),42,(0,0,1),666,(0,0,2),(314,)),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:kv{
              ":delete" if $delete
          } gives ((0,0,0),42,(0,0,1),666,(0,0,2),(314,))";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:p:$delete,
          ((0,0,0) => 42,(0,0,1) => 666,(0,0,2) => (314,)),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:p{
              ":delete" if $delete
          } gives ((0,0,0) => 42,(0,0,1) => 666,(0,0,2) => (314,))";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ @àссàù[$a;$b;$c<>]:v:$delete,
          (42, 666, (314,)),
          "\@array\[$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮]:v{
              ":delete" if $delete
          } gives 42, 666, (314,)";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;
    }
}

# make sure recursion works
{
    my @àссàù;
    is-deeply (@àссàù[0,1;0] = 42,666), (42,666),
      'did assignment to non-existing arrays return the assigned values';
    is-deeply @àссàù, [[42],[666]],
      'did initialization work';
    is-deeply (@àссàù[0,1;0] = 777, 888), (777,888),
      'did assignment return the assigned values';
    is-deeply @àссàù, [[777],[888]],
      'did the array get changed correctly';
    is-deeply (@àссàù[0,1;0]:delete), (777,888),
      'did deletion return the expected values';
    is-deeply @àссàù, [[],[]],
      'did the array get changed correctly';
    is-deeply (@àссàù[0,1;1] = 333, 444), (333,444),
      'did assignment to non-existing indices return the assigned values';
    is-deeply @àссàù, [[Any,333],[Any,444]],
      'did the array get changed correctly';
}

# make sure || syntax works
{
    my @àссàù;
    my @갢丧𝐝갢개e̲ò := (0,1), 0;   # need binding, no containers!

    is-deeply (@àссàù[|| @갢丧𝐝갢개e̲ò] = 42,666), (42,666),
      '|| did assignment to non-existing arrayes return the assigned values';
    is-deeply @àссàù, [[42],[666]],
      '|| did initialization work';
    is-deeply (@àссàù[|| @갢丧𝐝갢개e̲ò] = 777, 888), (777,888),
      '|| did assignment return the assigned values';
    is-deeply @àссàù, [[777],[888]],
      '|| did the array get changed correctly';
    is-deeply (@àссàù[|| @갢丧𝐝갢개e̲ò]:delete), (777,888),
      '|| did deletion return the expected values';
    is-deeply @àссàù, [[],[]],
      '|| did the array get changed correctly';
    is-deeply (@àссàù[|| (0,1), 1] = 333, 444), (333,444),
      '|| did assignment to non-existing indices return the assigned values';
    is-deeply @àссàù, [[Any,333],[Any,444]],
      '|| did the array get changed correctly';
    is-deeply @àссàù[|| 1], [Any,444],
      '|| could we specify a single index';
}

# https://github.com/rakudo/rakudo/issues/2488
{
    my @ìà中с갢ч;
    my sub сe̲òe̲中() { @ìà中с갢ч = [1,2,3], [4,5,6], [7,8,9] }

    сe̲òe̲中;
    is-deeply @ìà中с갢ч[*;  0,1 ],
      (1,2,4,5,7,8),
      '[*; 0,1]';
    is-deeply @ìà中с갢ч[*; {0,1}],
      (1,2,4,5,7,8),
      '[*; {0,1}]';
    is-deeply @ìà中с갢ч[*; {0,1}]:exists,
      (True xx 6),
      '[*; {0,1}]:exists';
    is-deeply @ìà中с갢ч[*; {0,1}]:k,
      ((0,0), (0,1), (1,0), (1,1), (2,0), (2,1)),
      '[*; {0,1}]:k';
    is-deeply @ìà中с갢ч[*; {0,1}]:kv,
      ((0,0), 1, (0,1), 2, (1,0), 4, (1,1), 5, (2,0), 7, (2,1), 8),
      '[*; {0,1}]:kv';
    is-deeply @ìà中с갢ч[*; {0,1}]:p,
      ((0,0) => 1, (0,1) => 2, (1,0) => 4, (1,1) => 5, (2,0) => 7, (2,1) => 8),
      '[*; {0,1}]:p';
    is-deeply @ìà中с갢ч[*; {0,1}]:exists:p,
      ((0,0) => True, (0,1) => True, (1,0) => True, (1,1) => True, (2,0) => True, (2,1) => True),
      '[*; {0,1}]:exists:p';

    сe̲òe̲中;
    is-deeply @ìà中с갢ч[*; {1,2}]:delete,
      (2,3,5,6,8,9),
      '[*; {1,2}]:delete';
    is-deeply @ìà中с갢ч, [[1],[4],[7]], 'remainder after [*; {1,2}]:delete';

    сe̲òe̲中;
    is-deeply @ìà中с갢ч[*; {1,2}]:delete:k,
      ((0,1), (0,2), (1,1), (1,2), (2,1), (2,2)),
      '[*; {1,2}]:delete:k';
    is-deeply @ìà中с갢ч, [[1],[4],[7]], 'remainder after [*; {1,2}]:delete:k';

    сe̲òe̲中;
    is-deeply @ìà中с갢ч[*; {1,2}]:delete:kv,
      ((0,1), 2, (0,2), 3, (1,1), 5, (1,2), 6, (2,1), 8, (2,2), 9),
      '[*; {1,2}]:delete:kv';
    is-deeply @ìà中с갢ч, [[1],[4],[7]], 'remainder after [*; {1,2}]:delete:kv';

    сe̲òe̲中;
    is-deeply @ìà中с갢ч[*; {1,2}]:delete:p,
      ((0,1) => 2, (0,2) => 3, (1,1) => 5, (1,2) => 6, (2,1) => 8, (2,2) => 9),
      '[*; {1,2}]:delete:p';
    is-deeply @ìà中с갢ч, [[1],[4],[7]], 'remainder after [*; {1,2}]:delete:p';
}

# vim: expandtab shiftwidth=4
