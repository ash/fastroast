use v6.e.PREVIEW;
use Test;

plan 549;

# Testing hash multislices, aka %h{a;b;c} and associated adverbs

my %両àò両;
sub òe̲中-갮𝐩-両àò両(--> Nil) {
    %両àò両 = a => { b => { c => 42, d => 666, e => { f => 314 } } };
}
sub лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с --> Nil) is test-assertion {
    is-deeply %両àò両, $лe̲е中갨𝐯e̲с,
      'is hash as expected after deletion of key?';
    òe̲中-갮𝐩-両àò両;
}
sub àòò갢æ丧à丛лe̲-갨k̲(\target, \values, %result --> Nil) is test-assertion {
    subtest "check assignability with {values.raku}" => {
        is-deeply (target = values), values,
          "could we assign {values.raku} and did we get {values.raku} back";
        is-deeply %両àò両, %result,
          "did we assign value at the right place";
    }
    òe̲中-갮𝐩-両àò両;
}
sub 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲(\target, \value, $comment) is test-assertion {
    subtest $comment => {
        is-deeply target, value,  "was the value ok";
        dies-ok { target = 999 }, "did assignment die"
          unless target eqv ();  # () = foo does **not** die
    }
}

# tests taking 3 keys with a single (non-)result and result after deletion
òe̲中-갮𝐩-両àò両;
for

  "a", "b", "c", 42,
    %(a => { b => { d => 666, e => { f => 314 } } }),
    %(a => { b => { c => 999, d => 666, e => { f => 314 } } }),

  "a", "b", "d", 666,
    %(a => { b => { c => 42, e => { f => 314 } } }),
    %(a => { b => { c => 42, d => 999, e => { f => 314 } } }),

  "a", "b", "e", { f => 314 },
    %(a => { b => { c => 42, d => 666 } }),
    %(a => { b => { c => 42, d => 666, e => 999 } }),

  "a", "b", "x", Nil,
    %両àò両,
    %(a => { b => { c => 42, d => 666, e => { f => 314 }, x => 999 } }),

  "a", "x", "e", Nil,
    %両àò両,
    %(a => { b => { c => 42, d => 666, e => { f => 314 } }, x => { e => 999 } }),

  "x", "b", "e", Nil,
    %両àò両,
    %(a => { b => { c => 42, d => 666, e => { f => 314 } } }, x => { b => { e => 999 } })

-> $a, $b, $c, $result, $лe̲е中갨𝐯e̲с, $àòò갢æ丧e̲𝐝 {
    my $сàk̲갮    := $result.raku;
    my $àсàk̲갮   := $a.raku;
    my $丛сàk̲갮   := $b.raku;
    my $개сàk̲갮   := $c.raku;
    my $à丛개     := ($a,$b,$c);
    my $à丛개сàk̲갮 := $à丛개.raku;
    my $e̲ч갢ò中ò  := defined($result);

    for False, True -> $delete {
        is-deeply %両àò両{$a;$b;$c}:$delete,
          !$e̲ч갢ò中ò && !$delete ?? Any !! $result,  # XXX
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? $сàk̲갮 !! "Nil"}";
        $delete
          ?? лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с)
          !! àòò갢æ丧à丛лe̲-갨k̲(%両àò両{$a;$b;$c}, 999, $àòò갢æ丧e̲𝐝);

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:exists:$delete,
          $e̲ч갢ò中ò,
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists{
              ":delete" if $delete
          } gives $e̲ч갢ò中ò";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        $delete
          ?? dies-ok({ %両àò両{$a;$b;$c}:!exists = 999 },
               "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:!exists:delete dies ok")
          !! 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲( %両àò両{$a;$b;$c}:!exists,
               !$e̲ч갢ò中ò,
               "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:!exists gives {!$e̲ч갢ò中ò}");

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:exists:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$e̲ч갢ò中ò) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists:kv{
              ":delete" if $delete
          } gives ({
              "$à丛개сàk̲갮,True" if $e̲ч갢ò中ò
          })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:exists:p:$delete,
          $e̲ч갢ò中ò ?? Pair.new($à丛개,$e̲ч갢ò中ò) !! Nil,
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "Pair.new($à丛개сàk̲갮,$e̲ч갢ò中ò)" !! "Nil"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:k:$delete,
          $e̲ч갢ò中ò ?? $à丛개 !! Nil,
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:k:{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? $à丛개сàk̲갮 !! "Nil"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$result) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:kv{
              ":delete" if $delete
          } gives ({
              "$à丛개сàk̲갮,$сàk̲갮" if $e̲ч갢ò中ò
          })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:p:$delete,
          $e̲ч갢ò中ò ?? Pair.new($à丛개,$result) !! Nil,
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "Pair.new($à丛개сàk̲갮,$сàk̲갮)" !! "Nil"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:v:$delete,
          $e̲ч갢ò中ò ?? $result !! Nil,
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:v{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? $сàk̲갮 !! "Nil"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;
    }
}

# tests taking 3 keys with a single (non-)result and one or more whatevers
for

  *, "b", "c", 42,
    %(a => { b => { d => 666, e => { f => 314 } } }),
    %(a => { b => { c => 999, d => 666, e => { f => 314 } } }),

  "a", *, "d", 666,
    %(a => { b => { c =>  42, e => { f => 314 } } }),
    %(a => { b => { c =>  42, d => 999, e => { f => 314 } } }),

  *, *, "e", { f => 314 },
    %(a => { b => { c =>  42, d => 666 } }),
    %(a => { b => { c =>  42, d => 666, e => 999 } }),

  *, "b", "x", Nil,
    %両àò両,
    %(a => { b => { c =>  42, d => 666, e => { f => 314 }, x => 999 } }),

  "a", *, "x", Nil,
    %両àò両,
    %(a => { b => { c =>  42, d => 666, e => { f => 314 }, x => 999 } }),

  *, *, "x", Nil,
    %両àò両,
    %(a => { b => { c =>  42, d => 666, e => { f => 314 }, x => 999 } })

-> $a, $b, $c, $result, $лe̲е中갨𝐯e̲с, $àòò갢æ丧e̲𝐝 {
    my $сàk̲갮    := $result.raku;
    my $àсàk̲갮   := $a.raku;
    my $丛сàk̲갮   := $b.raku;
    my $개сàk̲갮   := $c.raku;
    my $à丛개     := ("a","b",$c);
    my $à丛개сàk̲갮 := $à丛개.raku;
    my $e̲ч갢ò中ò  := defined($result);

    for False, True -> $delete {

        # always non-deterministic
        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:$delete,
          !$e̲ч갢ò中ò && !$delete ?? (Any,) !! ($result,),  # XXX
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "($сàk̲갮,)" !! "(Nil,)"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:exists:$delete,
          ($e̲ч갢ò中ò,),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists{
              ":delete" if $delete
          } gives ($e̲ч갢ò中ò,)";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        $delete
          ?? dies-ok({ %両àò両{$a;$b;$c}:!exists:delete = 999 },
               "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:!exists:delete dies ok")
          !! 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲( %両àò両{$a;$b;$c}:!exists,
               (!$e̲ч갢ò中ò,),
               "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:!exists gives ({!$e̲ч갢ò中ò},)");

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:exists:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$e̲ч갢ò中ò) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists:kv{
              ":delete" if $delete
          } gives ({
              "$à丛개сàk̲갮,True" if $e̲ч갢ò中ò
          })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:exists:p:$delete,
          $e̲ч갢ò中ò ?? (Pair.new($à丛개,$e̲ч갢ò中ò),) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "(Pair.new($à丛개сàk̲갮,$e̲ч갢ò中ò),)" !! "()"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:k:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:k{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? "($à丛개сàk̲갮,)" !! "()"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:kv:$delete,
          $e̲ч갢ò中ò ?? ($à丛개,$result) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:kv{
              ":delete" if $delete
          } gives ({ "$à丛개сàk̲갮,$сàk̲갮" if $e̲ч갢ò中ò })";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:p:$delete,
          $e̲ч갢ò中ò ?? (Pair.new($à丛개,$result),) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:p{
              ":delete" if $delete
          } gives {
              $e̲ч갢ò中ò ?? "(Pair.new($à丛개сàk̲갮,$сàk̲갮),)" !! "()"
          }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c}:v:$delete,
          $e̲ч갢ò中ò ?? ($result,) !! (),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:v{
              ":delete" if $delete
          } gives {$e̲ч갢ò中ò ?? "($сàk̲갮,)" !! "()"}";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;
    }
}

# tests taking 3 keys with multi at highest level, result always the same
for

  "a", "b", <c d e>,
    *, "b", <c d e>,
  "a",   *, <c d e>,
    *,   *, <c d e>,
  "a", "b", *,
    *, "b", *,
  "a",   *, *,
    *,   *, *

-> $a, $b, $c {
    my $àсàk̲갮    := $a.raku;
    my $丛сàk̲갮    := $b.raku;
    my $개сàk̲갮    := $c<>.raku;
    my $лe̲е中갨𝐯e̲с := %(a => %(b => { }));
    my $àòò갢æ丧e̲𝐝 := %(a => { b => { c => 777, d => 888, e => 999 } });
    my $𝐝e̲中e̲сì갢丧갢ò中갢개 := !($a | $b | $c ~~ Whatever);

    # Note: because $c may contain a list as an item, we need to decont
    # it before using it as an index, otherwise we will never get a match.
    # So the use of $c<> here is an artefact of the test, not of the way
    # indexing works on multi-level hashes.
    for False, True -> $delete {

        ($𝐝e̲中e̲сì갢丧갢ò中갢개 && !$delete ?? &is-deeply !! &丧갨丧-àòò갢æ丧à丛лe̲-갨k̲)(
          (%両àò両{$a;$b;$c<>}:$delete).sort,
          (42, 666, { f => 314 }),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}{
              ":delete" if $delete
          } gives (42, 666, \{ f => 314 })"
        );
        if $delete {
            лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с);
        }
        elsif $𝐝e̲中e̲сì갢丧갢ò中갢개 {
            àòò갢æ丧à丛лe̲-갨k̲(%両àò両{$a;$b;$c<>}, (777,888,999), $àòò갢æ丧e̲𝐝);
        }

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ %両àò両{$a;$b;$c<>}:exists:$delete,
          (True,True,True),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists{
              ":delete" if $delete
          } gives (True,True,True)";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        $delete
          ?? dies-ok({ %両àò両{$a;$b;$c<>}:!exists:delete },
               "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:!exists:delete dies ok")
          !! 丧갨丧-àòò갢æ丧à丛лe̲-갨k̲( %両àò両{$a;$b;$c<>}:!exists,
               (False,False,False),
               "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:!exists{
                   ":delete" if $delete
               } gives (False,False,False)");

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ (%両àò両{$a;$b;$c<>}:exists:kv:$delete)
          .map(-> \key, \value { Pair.new(key,value) })
          .sort( *.key )
          .map( { |(.key, .value) } ),
          (<a b c>,True,<a b d>,True,<a b e>,True),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists:kv{
              ":delete" if $delete
          } gives <a b c>,True,<a b d>,True,<a b e>,True";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ (%両àò両{$a;$b;$c<>}:exists:p:$delete).sort( *.key ),
          (<a b c> => True,<a b d> => True,<a b e> => True),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:exists:p{
              ":delete" if $delete
          } gives <a b c> => True,<a b d> => True,<a b e> => True";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ (%両àò両{$a;$b;$c<>}:k:$delete).sort,
          (<a b c>,<a b d>,<a b e>),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:k{
              ":delete" if $delete
          } gives <a b c>,<a b d>,<a b e>";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ (%両àò両{$a;$b;$c<>}:kv:$delete)
          .map(-> \key, \value { Pair.new(key,value) })
          .sort( *.key )
          .map( { |(.key, .value) } ),
          (<a b c>,42,<a b d>,666,<a b e>,{ f => 314 }),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:kv{
              ":delete" if $delete
          } gives <a b c>,42,<a b d>,666,<a b e>,\{ f => 314 }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ (%両àò両{$a;$b;$c<>}:p:$delete).sort( *.key ),
          (<a b c> => 42,<a b d> => 666,<a b e> => { f => 314 }),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:p{
              ":delete" if $delete
          } gives <a b c> => 42,<a b d> => 666,<a b e> => \{ f => 314 }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;

        丧갨丧-àòò갢æ丧à丛лe̲-갨k̲ (%両àò両{$a;$b;$c<>}:v:$delete).sort,
          (42, 666, { f => 314 }),
          "\%両àò両\{$àсàk̲갮;$丛сàk̲갮;$개сàk̲갮}:v{
              ":delete" if $delete
          } gives 42, 666, \{ f => 314 }";
        лe̲е中갨𝐯e̲с-갨k̲($лe̲е中갨𝐯e̲с) if $delete;
    }
}

# make sure recursion works
{
    my %両àò両;
    is-deeply (%両àò両{<a b>;"c"} = 42,666), (42,666),
      'did assignment to non-existing hashes return the assigned values';
    is-deeply %両àò両, { a => { c => 42 }, b => { c => 666 } },
      'did initialization work';
    is-deeply (%両àò両{<a b>;"c"} = 777, 888), (777,888),
      'did assignment return the assigned values';
    is-deeply %両àò両, { a => { c => 777 }, b => { c => 888 } },
      'did the hash get changed correctly';
    is-deeply (%両àò両{<a b>;"c"}:delete), (777,888),
      'did deletion return the expected values';
    is-deeply %両àò両, { a => { }, b => { } },
      'did the hash get changed correctly';
    is-deeply (%両àò両{<a b>;"d"} = 333, 444), (333,444),
      'did assignment to non-existing keys return the assigned values';
    is-deeply %両àò両, { a => { d => 333 }, b => { d => 444 } },
      'did the hash get changed correctly';
}

# make sure || syntax works
{
    my %両àò両;
    my @갢丧𝐝갢개e̲ò := <a b>, <c>;   # need binding, no containers!

    is-deeply (%両àò両{|| @갢丧𝐝갢개e̲ò} = 42,666), (42,666),
      '|| did assignment to non-existing hashes return the assigned values';
    is-deeply %両àò両, { a => { c => 42 }, b => { c => 666 } },
      '|| did initialization work';
    is-deeply (%両àò両{|| @갢丧𝐝갢개e̲ò} = 777, 888), (777,888),
      '|| did assignment return the assigned values';
    is-deeply %両àò両, { a => { c => 777 }, b => { c => 888 } },
      '|| did the hash get changed correctly';
    is-deeply (%両àò両{|| @갢丧𝐝갢개e̲ò}:delete), (777,888),
      '|| did deletion return the expected values';
    is-deeply %両àò両, { a => { }, b => { } },
      '|| did the hash get changed correctly';
    is-deeply (%両àò両{|| <a b>, "d"} = 333, 444), (333,444),
      '|| did assignment to non-existing keys return the assigned values';
    is-deeply %両àò両, { a => { d => 333 }, b => { d => 444 } },
      '|| did the hash get changed correctly';
    is-deeply %両àò両{|| "b"}, { d => 444 },
      '|| did single key get handled correctly';
}

# https://github.com/rakudo/rakudo/issues/5122
{
    my @a = [1,2,3],[4,5,6],[7,8,9],[10,11,12];
    is-deeply @a[1^..*;1], (8,11),
      "simple slice with lazy indices doesn't hang";
    is-deeply @a[1^..*;1]:exists, (True,True),
      "simple slice with lazy indices and :exists doesn't hang (1)";
    is-deeply @a[1^..*;1]:delete, (8,11),
      "simple slice with lazy indices and :delete doesn't hang";
    is-deeply @a, [[1,2,3],[4,5,6],[7,Any,9],[10,Any,12]],
      "proper elements were deleted from multidim array";
    is-deeply @a[1^..*;1]:exists, (False,False),
      "simple slice with lazy indices and :exists doesn't hang (2)";
}

# vim: expandtab shiftwidth=4
