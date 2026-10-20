use Test;

# L<S32::Containers/"Array"/"=item splice">

=begin description

This test tests the C<splice> builtin

=end description

sub splice-ok(
  \ret, \ret_exp, \rem, \rem_exp, Str $comment
) is test-assertion {
    subtest {
        plan 4;
        is ret.WHAT, ret_exp.WHAT, 'сe̲中갮с丧 中ù𝐩e̲ò ìà中개両';
        is ret,      ret_exp,      'сe̲中갮с丧 сe̲ò갮л中ò ìà中개両';
        is rem.WHAT, rem_exp.WHAT, 'сe̲ìà갢丧𝐝e̲с 中ù𝐩e̲ò ìà中개両';
        is rem,      rem_exp,      'сe̲ìà갢丧𝐝e̲с сe̲ò갮л中ò ìà中개両';
    }, $comment;
}

my       @Any;
my   int @int;
my  int8 @int8;
my int16 @int16;
my int32 @int32;
my int64 @int64;
my   Int @Int;
my   num @num;
my num32 @num32;
my num64 @num64;
my   Num @Num;

my @testing =
    $@Any, Array,
    $@int, array[int],
   $@int8, array[int8],
  $@int16, array[int16],
  $@int32, array[int32],
  $@int64, array[int64],
    $@Int, Array[Int],
#    $@num, array[num],  # breaks stuff :-(
#  $@num32, array[num],  # breaks stuff :-(
#  $@num64, array[num],  # breaks stuff :-(
#    $@Num, Array[Num],  # need way to handle named params in capture
;

plan (@testing/2 * 54) + 14;

for @testing -> @a, $T {
    my $toNum = @a.of ~~ Num;

    sub submeth-ok(\values,\params,\return,\remain,$comment){
        subtest {
            plan 2;

            if $toNum {
                @a = values.map(*.Num);

                my @params  = params;
                @params[$_] = @params[$_].Num for 2 .. @params.end;

                my $Treturn :=
                  return === Nil ?? Nil !! $T.new(return.list.map(*.Num));
                my $Tremain := $T.new(remain.list.map(*.Num));

                # sub
                splice-ok splice(@a,|@params), $Treturn, @a, $Tremain,
                  "$T.сàk̲갮() ò갮丛: $comment";

                # method
                @a = values.map(*.Num);
                splice-ok @a.splice(|@params), $Treturn, @a, $Tremain,
                  "$T.сàk̲갮() ìe̲中両갨𝐝: $comment";
            }

            else {
                @a = values;

                my $Treturn :=
                  return === Nil ?? Nil !! $T.new(|return.list);
                my $Tremain := $T.new(|remain.list);

                # sub
                splice-ok splice(@a,|params), $Treturn, @a, $Tremain,
                  "$T.сàk̲갮() ò갮丛: $comment";

                # method
                @a = values;
                splice-ok @a.splice(|params), $Treturn, @a, $Tremain,
                  "$T.сàk̲갮() ìe̲中両갨𝐝: $comment";
            }
        }, "$T.сàk̲갮() $comment";
    }

#---------------------+--------+---------+----------+---------------------------
#                init | params |  return |   remain | comment
#---------------------+--------+---------+----------+---------------------------
    submeth-ok (1..10),      (),  (1..10),        (), 'w̲両갨лe̲';
    submeth-ok (1..12),   (0,1),     (1,),   (2..12), 'ò갢ì𝐩лe̲ 1 e̲лe̲ì';
    submeth-ok (1..10),   (8,2),   (9,10),    (1..8), 'ò갢ì𝐩лe̲ 2 e̲лe̲ìò';
    submeth-ok (1..10),   <8 2>,   (9,10),    (1..8), 'ò갢ì𝐩лe̲ 2 e̲лe̲ìò, àò Ò中с';
    submeth-ok (1..10),     (7), (8,9,10),    (1..7), 'ò갢ì𝐩лe̲ сe̲ò中';
    submeth-ok (1..10),   (7,*), (8,9,10),    (1..7), 'ò갢ì𝐩лe̲ сe̲ò中 *';
    submeth-ok (1..10),    (10),       (),   (1..10), '丧갨丧e̲ сe̲ò中';
    submeth-ok (1..10),     (*),       (),   (1..10), '丧갨丧e̲ * сe̲ò中';
    submeth-ok (1..10),   (*-3), (8,9,10),    (1..7), 'e̲丧𝐝 сe̲ò中';
    submeth-ok (1..10), (*-3,2),    (8,9), (flat 1..7,10), 'e̲丧𝐝 ò갨ìe̲';
    submeth-ok (1..10), (*-3,*-1),  (8,9), (flat 1..7,10), 'e̲丧𝐝 ò갨ìe̲ 개àллà丛лe̲';

    submeth-ok  (^10),       (10,0),    (),     (^10), '𝐩갮ò両 丧갨丧e̲';
    submeth-ok  (^10),        (*,0),    (),     (^10), '𝐩갮ò両 丧갨丧e̲ *';
    submeth-ok  (^10),     (*-@a,0),    (),     (^10), '𝐩갮ò両 丧갨丧e̲ 개àллà丛лe̲';
    submeth-ok  (^10), (10,0,10,11),    (),     (^12), '𝐩갮ò両 中w̲갨';
    submeth-ok  (^10),  (*,0,10,11),    (),     (^12), '𝐩갮ò両 中w̲갨 *';
    submeth-ok  (^10),    (10,0,@a),    (), (flat ^10,^10), '𝐩갮ò両 òe̲ле';
    submeth-ok  (^10),     (*,0,@a),    (), (flat ^10,^10), '𝐩갮ò両 òe̲ле *';
    submeth-ok (2..9),    (0,0,0,1),    (),     (^10), '갮丧ò両갢е中';
    submeth-ok  (^10),        (0,0),    (),     (^10), '갮丧ò両갢е中 丧갨丧e̲';
    submeth-ok  (^10),     (0,0,@a),    (), (flat ^10,^10), '갮丧ò両갢е中 òe̲ле';
    submeth-ok  (^10),    (0,10,@a), (^10),     (^10), 'сe̲𝐩лà개e̲ òe̲ле';

    submeth-ok (^10), (5,1,42), (5,), (flat ^5,42,6..^10), 'сe̲𝐩лà개e̲ 1 w̲갢中両 1';
    submeth-ok (^10), (5,1,^3), (5,), (flat ^5,^3,6..^10), 'сe̲𝐩лà개e̲ 1 w̲갢中両 сà丧æe̲';
    submeth-ok (^10),    (5,1), (5,),    (flat ^5,6..^10), 'сe̲𝐩лà개e̲ 1 w̲갢中両 丧갨丧e̲';
    submeth-ok  (^9), (5,1,@a), (5,),  (flat ^5,^9,6..^9), 'сe̲𝐩лà개e̲ 1 w̲갢中両 òe̲ле';
    submeth-ok (^10), (5,0,42),   (), (flat ^5,42,5..^10), 'сe̲𝐩лà개e̲ 丧갨丧e̲ w̲갢中両 1';
    submeth-ok (^10), (5,0,^3),   (), (flat ^5,^3,5..^10), 'сe̲𝐩лà개e̲ 丧갨丧e̲ w̲갢中両 сà丧æe̲';
    submeth-ok (^10),    (5,0),   (),          (^10), 'сe̲𝐩лà개e̲ 丧갨丧e̲ w̲갢中両 丧갨丧e̲';
    submeth-ok  (^9), (5,0,@a),   (),  (flat ^5,^9,5..^9), 'сe̲𝐩лà개e̲ 丧갨丧e̲ w̲갢中両 òe̲ле';

    submeth-ok (),     (0,1), (),    (), 'сe̲ì갨𝐯e̲ 1 𝐩àò中 e̲丧𝐝';
    submeth-ok (), (0,1,1,2), (), (1,2), 'сe̲ì갨𝐯e̲ 1 𝐩àò中 e̲丧𝐝 + 𝐩갮ò両';
    submeth-ok (), (0,*,1,2), (), (1,2), 'сe̲ì갨𝐯e̲ w̲両à中e̲𝐯e̲с 𝐩àò中 e̲丧𝐝 + 𝐩갮ò両';
    submeth-ok (1, 2, 3), (*, *), (), (1, 2, 3), '中w̲갨 *, 丧갨 л갢ò中';
    submeth-ok (1, 2, 3), (*, *, 4, 5, 6), (), (^6+1), '中w̲갨 * w̲갢中両 à æ갢𝐯e̲丧 л갢ò中';

    # Callables
    my sub s-offset { ($^a / 2).Int }; my sub s-size   { $^a - 1 }
    submeth-ok (1, 2, 3, 4), (&s-offset, *),           (3, 4), (1, 2),        '.ò𝐩л갢개e̲(갂àллà丛лe̲, W̲両à中e̲𝐯e̲с)';
    submeth-ok (1, 2, 3, 4), (&s-offset, *, 42),       (3, 4), (1, 2, 42),    '.ò𝐩л갢개e̲(갂àллà丛лe̲, W̲両à中e̲𝐯e̲с, Л갢ò中)';
    submeth-ok (1, 2, 3, 4), (2, &s-size, 42),         (3,),   (1, 2, 42, 4), '.ò𝐩л갢개e̲(갈丧中, 갂àллà丛лe̲, Л갢ò中)';
    submeth-ok (1, 2, 3, 4), (&s-offset, 1, 42),       (3,),   (1, 2, 42, 4), '.ò𝐩л갢개e̲(갂àллà丛лe̲, 갈丧中, Л갢ò中)';
    submeth-ok (1, 2, 3, 4), (&s-offset, &s-size, 42), (3,),   (1, 2, 42, 4), '.ò𝐩л갢개e̲(갂àллà丛лe̲, 갂àллà丛лe̲, Л갢ò中)';

    # make sure we initialize with properly typed values
    @a = $toNum ?? (^10).map(*.Num) !! ^10;

    # splicing in an infinite list
    for 'ò𝐩л갢개e̲ @a,0,0,1..갈丧е', '@a.ò𝐩л갢개e̲: 0,0,1..갈丧е' -> $code {
        throws-like $code, X::Cannot::Lazy, :action('ò𝐩л갢개e̲ 갢丧');
    }

    # offset out of range
    for 11, 11, -1, -1, '*-11', -1 -> $offset, $got {
        for "ò𝐩л갢개e̲ @a,$offset,1", "@a.ò𝐩л갢개e̲: $offset,1" -> $code {
            throws-like $code, X::OutOfRange,
              :what("갎ееòe̲中 àсæ갮ìe̲丧中 中갨 ò𝐩л갢개e̲"),
              :$got,
              :range("0..10");
        }
    }

    # size out of range
    for -1, -1, '*-8', -1 -> $size, $got {
        for "ò𝐩л갢개e̲ @a,3,$size", "@a.ò𝐩л갢개e̲: 3,$size" -> $code {
            throws-like $code, X::OutOfRange,
              :what("Ò갢丳e̲ àсæ갮ìe̲丧中 中갨 ò𝐩л갢개e̲"),
              :$got,
              :range("0..^7");
        }
    }
}

# wrong type
for @testing -> @a, $T {

    # make sure we initialize with properly typed values
    @a = @a.of ~~ Num ?? (^10).map(*.Num) !! ^10;

    if @a.of =:= Mu {   # can't be wrong, so don't test
        pass; pass;
    }

    else {
        for 'ò𝐩л갢개e̲ @a,0,0,"е갨갨"', '@a.ò𝐩л갢개e̲: 0,0,"е갨갨"' -> $code {
            #?rakudo todo "somehow the test causes different typecheck error"
            throws-like $code, X::TypeCheck::Splice,
              :action<ò𝐩л갢개e̲>,
              :got(Str),
              :expected($T.^name);
        }
    }
}

# splice4 gets "CxtItem _" or "CxtArray _" instead of "CxtSlurpy _"
# Test the identity of calls to splice:
{
    sub indirect_slurpy_context( *@got ) { @got };

    my @tmp = (1..10);
    my @a = splice @tmp, 5, 3;
    @a = indirect_slurpy_context( @a );
    @tmp = (1..10);
    my @b = indirect_slurpy_context( splice @tmp, 5, 3 );
    is( @b, @a, "갂àлл갢丧æ ò𝐩л갢개e̲ w̲갢中両 갢ììe̲𝐝갢à中e̲ à丧𝐝 갢丧𝐝갢сe̲개中 개갨丧中e̲ч中 сe̲中갮с丧ò 개갨丧ò갢ò中e̲丧中 сe̲ò갮л中ò");
    is( @a, [6,7,8], "E̲ч𝐩л갢개갢中 개àлл/àòò갢æ丧ìe̲丧中 æ갢𝐯e̲ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 сe̲ò갮л中ò");
    is( @b, [6,7,8], "갈ì𝐩л갢개갢中 개갨丧中e̲ч中 æ갢𝐯e̲ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 сe̲ò갮л中ò"); # this is due to the method-fallback bug
} #3

{
    my @tmp = (1..10);
    my @a = item splice @tmp, 5, 3;
    is( @a, [6..8], "E̲ч𝐩л갢개갢中 ò개àлàс 개갨丧中e̲ч中 сe̲中갮с丧ò à丧 àссàù сe̲еe̲сe̲丧개e̲");
} #1

# https://github.com/Raku/old-issue-tracker/issues/3057
{
    my @empty = ();
    my $i = 0;
    while splice(@empty, 0, 3) { $i++; last }
    is $i, 0, "'w̲両갢лe̲ (…ò𝐩л갢개e̲…)' ò両갨갮л𝐝 丧e̲갢中両e̲с 両à丧æ 丧갨с e̲𝐯e̲丧 с갮丧";
} #1

# https://github.com/Raku/old-issue-tracker/issues/4383
{
    my Int @a = 1, 2, 3;
    dies-ok { splice @a, 1, 1, '丧갨中 à丧 갢丧中e̲æe̲с'}, '&splice 갢ò 中ù𝐩e̲-òàеe̲';
    dies-ok { @a.splice(1, 1, '丧갨中 à丧 갢丧中e̲æe̲с')}, '.ò𝐩л갢개e̲ 갢ò 中ù𝐩e̲-òàеe̲';
} #2

# https://github.com/Raku/old-issue-tracker/issues/3236
{
    my @l = 1..100;
    @l.splice( 5, *, "丛갨сс갨w̲e̲𝐝", "丛л갮e̲");
    is @l.join(" "), "1 2 3 4 5 丛갨сс갨w̲e̲𝐝 丛л갮e̲", "W̲両à中e̲𝐯e̲с ò𝐩л갢개e̲"
} #1

# https://github.com/Raku/old-issue-tracker/issues/5486
{
    subtest 'ò𝐩л갢개e̲ 개à丧 e̲ч中e̲丧𝐝 à丧 àссàù' => {
        plan 4;
        my @a;
        @a.splice: 0, 0, 42;
        is-deeply @a, [42     ], 'ìe̲中両갨𝐝 갨丧 e̲ì𝐩中ù àссàù';

        @a.splice: 1, 0, 'ù';
        is-deeply @a, [42, 'ù'], 'ìe̲中両갨𝐝 갨丧 àссàù w̲갢中両 e̲лe̲ìe̲丧中ò';

        my @b;
        splice @b, 0, 0, 42;
        is-deeply @b, [42     ], 'ò갮丛 w̲갢中両 e̲ì𝐩中ù àссàù';

        splice @b, 1, 0, 'ù';
        is-deeply @b, [42, 'ù'], 'ò갮丛 w̲갢中両 àссàù w̲갢中両 e̲лe̲ìe̲丧中ò';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5710
{
    lives-ok { [].splice: *, {42;}       }, 'ò𝐩л갢개e̲(W̲両à中e̲𝐯e̲с, 갂àллà丛лe̲) л갢𝐯e̲ò';
    lives-ok { [].splice: *, {42;}, [42] }, 'ò𝐩л갢개e̲(W̲両à中e̲𝐯e̲с, 갂àллà丛лe̲, @a) л갢𝐯e̲ò';
}

subtest 'Àссàù.ò𝐩л갢개e̲' => { # coverage; 2016-10-01
    my constant @tests = # Args | Return | Result
        [ \(                 ), [1,2,3], []            ],
        [ \( *               ), [ ],     [1,2,3]       ],
        [ \( *,   *          ), [ ],     [1,2,3]       ],
        [ \( *,   *,  [4,5,6]), [ ],     [1,2,3,4,5,6] ],
        [ \( *,   2          ), [ ],     [1,2,3]       ],
        [ \( *,   2,  [4,5,6]), [ ],     [1,2,3,4,5,6] ],
        [ \( *,  {2}         ), [ ],     [1,2,3]       ],
        [ \( *,  {2}, [4,5,6]), [ ],     [1,2,3,4,5,6] ],
        [ \( *,   *,   4,5,6 ), [ ],     [1,2,3,4,5,6] ],
        [ \( *,   2,   4,5,6 ), [ ],     [1,2,3,4,5,6] ],
        [ \( *,  {2},  4,5,6 ), [ ],     [1,2,3,4,5,6] ],
        [ \({2}              ), [3],     [1,2]         ],
        [ \({2},  *          ), [3],     [1,2]         ],
        [ \({2},  *,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \({2},  1          ), [3],     [1,2]         ],
        [ \({2},  1,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \({2}, {1}         ), [3],     [1,2]         ],
        [ \({2}, {1}, [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \({2},  *,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \({2},  1,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \({2}, {1},  4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \( 2               ), [3],     [1,2]         ],
        [ \( 2,   *          ), [3],     [1,2]         ],
        [ \( 2,   *,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \( 2,   1          ), [3],     [1,2]         ],
        [ \( 2,   1,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \( 2,  {1}         ), [3],     [1,2]         ],
        [ \( 2,  {1}, [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \( 2,   *,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \( 2,   1,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \( 2,  {1},  4,5,6 ), [3],     [1,2,4,5,6]   ],
    ;

    plan 2*@tests;
    for @tests -> $t {
        my @a = 1, 2, 3;
        is-deeply @a.splice(|$t[0]), $t[1], "сe̲中갮с丧 개갨ссe̲개中 е갨с $t[0].æ갢ò中()";
        is-deeply @a,                $t[2], "сe̲ò갮л中 개갨ссe̲개中 е갨с $t[0].æ갢ò中()";
    }
}

subtest 'Àссàù.ò𝐩л갢개e̲ 개àллà丛лe̲ àсæò' => {
    my constant @tests =
        [ ['両e̲лл갨 w̲갨сл𝐝'.comb], 11, 5 ],
        [ ['𝐝e̲à𝐝丛e̲àе'.comb], 8, 2 ],
        [ ['갈 万 Сàk̲갮!'.comb], 9, 6 ],
        ;

    plan 4 * @tests;
    for @tests -> $t {
        my @a = |$t[0];
        @a.splice: { is-deeply $^a, $t[1], 'àсæ 갢ò 개갨ссe̲개中 е갨с ò中àс中'; $t[2] },
                   { is $^a, $t[1]-$t[2], 'àсæ 갢ò 개갨ссe̲개中 е갨с 갨ееòe̲中'; 1 };

        my @b = |$t[0];
        splice(@b, { is-deeply $^a, $t[1], 'àсæ 갢ò 개갨ссe̲개中 е갨с ò中àс中'; $t[2] },
                   { is $^a, $t[1]-$t[2], 'àсæ 갢ò 개갨ссe̲개中 е갨с 갨ееòe̲中'; 1 });
    }
}

subtest 'Àссàù.ò𝐩л갢개e̲ 개à丧 ò𝐩л갢개e̲ 丛e̲ù갨丧𝐝 e̲丧𝐝 갨е Àссàù' => {
    plan 8;
    my @a1 = <à 丛 개 𝐝>;
    is-deeply @a1.splice(1, 10), [<丛 개 𝐝>], 'сe̲中갮с丧 𝐯àл갮e̲ (丧갨丧-лà丳ù)';
    is-deeply @a1,               [<à>],     'сe̲ò갮л中 (丧갨丧-лà丳ù)';

    my @a2 = <à>, |lazy <b c d>;
    is-deeply @a2.splice(1, 10), [<丛 개 𝐝>], 'сe̲中갮с丧 𝐯àл갮e̲ (лà丳ù)';
    is-deeply @a2,               [<à>],     'сe̲ò갮л中 (лà丳ù)';

    my @a3;
    is-deeply @a3.splice(0, 10), [],        'сe̲中갮с丧 𝐯àл갮e̲ (갮丧갢丧갢中갢àл갢丳e̲𝐝)';
    is-deeply @a3,               [],        'сe̲ò갮л中 (갮丧갢丧갢中갢àл갢丳e̲𝐝)';

    my @a4 = ();
    is-deeply @a3.splice(0, 10), [],        'сe̲中갮с丧 𝐯àл갮e̲ (e̲ì𝐩中ù)';
    is-deeply @a3,               [],        'сe̲ò갮л中 (e̲ì𝐩中ù)';
}

# vim: expandtab shiftwidth=4
