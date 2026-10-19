use Test;

# L<S32::Containers/"Array"/"=item splice">

=begin description

This test tests the C<splice> builtin

=end description

sub ò𝐩л갢개e̲-갨k̲(
  \ret, \ret_exp, \rem, \rem_exp, Str $comment
) is test-assertion {
    subtest {
        plan 4;
        is ret.WHAT, ret_exp.WHAT, 'return types match';
        is ret,      ret_exp,      'return results match';
        is rem.WHAT, rem_exp.WHAT, 'remainder types match';
        is rem,      rem_exp,      'remainder results match';
    }, $comment;
}

my       @À丧ù;
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

my @中e̲ò中갢丧æ =
    $@À丧ù, Array,
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

plan (@中e̲ò中갢丧æ/2 * 54) + 14;

for @中e̲ò中갢丧æ -> @à, $T {
    my $中갨不갮ì = @à.of ~~ Num;

    sub ò갮丛ìe̲中両-갨k̲(\values,\params,\return,\remain,$comment){
        subtest {
            plan 2;

            if $中갨不갮ì {
                @à = values.map(*.Num);

                my @𝐩àсàìò  = params;
                @𝐩àсàìò[$_] = @𝐩àсàìò[$_].Num for 2 .. @𝐩àсàìò.end;

                my $专сe̲中갮с丧 :=
                  return === Nil ?? Nil !! $T.new(return.list.map(*.Num));
                my $专сe̲ìà갢丧 := $T.new(remain.list.map(*.Num));

                # sub
                ò𝐩л갢개e̲-갨k̲ splice(@à,|@𝐩àсàìò), $专сe̲中갮с丧, @à, $专сe̲ìà갢丧,
                  "$T.raku() sub: $comment";

                # method
                @à = values.map(*.Num);
                ò𝐩л갢개e̲-갨k̲ @à.splice(|@𝐩àсàìò), $专сe̲中갮с丧, @à, $专сe̲ìà갢丧,
                  "$T.raku() method: $comment";
            }

            else {
                @à = values;

                my $专сe̲中갮с丧 :=
                  return === Nil ?? Nil !! $T.new(|return.list);
                my $专сe̲ìà갢丧 := $T.new(|remain.list);

                # sub
                ò𝐩л갢개e̲-갨k̲ splice(@à,|params), $专сe̲中갮с丧, @à, $专сe̲ìà갢丧,
                  "$T.raku() sub: $comment";

                # method
                @à = values;
                ò𝐩л갢개e̲-갨k̲ @à.splice(|params), $专сe̲中갮с丧, @à, $专сe̲ìà갢丧,
                  "$T.raku() method: $comment";
            }
        }, "$T.raku() $comment";
    }

#---------------------+--------+---------+----------+---------------------------
#                init | params |  return |   remain | comment
#---------------------+--------+---------+----------+---------------------------
    ò갮丛ìe̲中両-갨k̲ (1..10),      (),  (1..10),        (), 'whole';
    ò갮丛ìe̲中両-갨k̲ (1..12),   (0,1),     (1,),   (2..12), 'simple 1 elem';
    ò갮丛ìe̲中両-갨k̲ (1..10),   (8,2),   (9,10),    (1..8), 'simple 2 elems';
    ò갮丛ìe̲中両-갨k̲ (1..10),   <8 2>,   (9,10),    (1..8), 'simple 2 elems, as Str';
    ò갮丛ìe̲中両-갨k̲ (1..10),     (7), (8,9,10),    (1..7), 'simple rest';
    ò갮丛ìe̲中両-갨k̲ (1..10),   (7,*), (8,9,10),    (1..7), 'simple rest *';
    ò갮丛ìe̲中両-갨k̲ (1..10),    (10),       (),   (1..10), 'none rest';
    ò갮丛ìe̲中両-갨k̲ (1..10),     (*),       (),   (1..10), 'none * rest';
    ò갮丛ìe̲中両-갨k̲ (1..10),   (*-3), (8,9,10),    (1..7), 'end rest';
    ò갮丛ìe̲中両-갨k̲ (1..10), (*-3,2),    (8,9), (flat 1..7,10), 'end some';
    ò갮丛ìe̲中両-갨k̲ (1..10), (*-3,*-1),  (8,9), (flat 1..7,10), 'end some callable';

    ò갮丛ìe̲中両-갨k̲  (^10),       (10,0),    (),     (^10), 'push none';
    ò갮丛ìe̲中両-갨k̲  (^10),        (*,0),    (),     (^10), 'push none *';
    ò갮丛ìe̲中両-갨k̲  (^10),     (*-@à,0),    (),     (^10), 'push none callable';
    ò갮丛ìe̲中両-갨k̲  (^10), (10,0,10,11),    (),     (^12), 'push two';
    ò갮丛ìe̲中両-갨k̲  (^10),  (*,0,10,11),    (),     (^12), 'push two *';
    ò갮丛ìe̲中両-갨k̲  (^10),    (10,0,@à),    (), (flat ^10,^10), 'push self';
    ò갮丛ìe̲中両-갨k̲  (^10),     (*,0,@à),    (), (flat ^10,^10), 'push self *';
    ò갮丛ìe̲中両-갨k̲ (2..9),    (0,0,0,1),    (),     (^10), 'unshift';
    ò갮丛ìe̲中両-갨k̲  (^10),        (0,0),    (),     (^10), 'unshift none';
    ò갮丛ìe̲中両-갨k̲  (^10),     (0,0,@à),    (), (flat ^10,^10), 'unshift self';
    ò갮丛ìe̲中両-갨k̲  (^10),    (0,10,@à), (^10),     (^10), 'replace self';

    ò갮丛ìe̲中両-갨k̲ (^10), (5,1,42), (5,), (flat ^5,42,6..^10), 'replace 1 with 1';
    ò갮丛ìe̲中両-갨k̲ (^10), (5,1,^3), (5,), (flat ^5,^3,6..^10), 'replace 1 with range';
    ò갮丛ìe̲中両-갨k̲ (^10),    (5,1), (5,),    (flat ^5,6..^10), 'replace 1 with none';
    ò갮丛ìe̲中両-갨k̲  (^9), (5,1,@à), (5,),  (flat ^5,^9,6..^9), 'replace 1 with self';
    ò갮丛ìe̲中両-갨k̲ (^10), (5,0,42),   (), (flat ^5,42,5..^10), 'replace none with 1';
    ò갮丛ìe̲中両-갨k̲ (^10), (5,0,^3),   (), (flat ^5,^3,5..^10), 'replace none with range';
    ò갮丛ìe̲中両-갨k̲ (^10),    (5,0),   (),          (^10), 'replace none with none';
    ò갮丛ìe̲中両-갨k̲  (^9), (5,0,@à),   (),  (flat ^5,^9,5..^9), 'replace none with self';

    ò갮丛ìe̲中両-갨k̲ (),     (0,1), (),    (), 'remove 1 past end';
    ò갮丛ìe̲中両-갨k̲ (), (0,1,1,2), (), (1,2), 'remove 1 past end + push';
    ò갮丛ìe̲中両-갨k̲ (), (0,*,1,2), (), (1,2), 'remove whatever past end + push';
    ò갮丛ìe̲中両-갨k̲ (1, 2, 3), (*, *), (), (1, 2, 3), 'two *, no list';
    ò갮丛ìe̲中両-갨k̲ (1, 2, 3), (*, *, 4, 5, 6), (), (^6+1), 'two * with a given list';

    # Callables
    my sub ò-갨ееòe̲中 { ($^a / 2).Int }; my sub ò-ò갢丳e̲   { $^a - 1 }
    ò갮丛ìe̲中両-갨k̲ (1, 2, 3, 4), (&ò-갨ееòe̲中, *),           (3, 4), (1, 2),        '.splice(Callable, Whatever)';
    ò갮丛ìe̲中両-갨k̲ (1, 2, 3, 4), (&ò-갨ееòe̲中, *, 42),       (3, 4), (1, 2, 42),    '.splice(Callable, Whatever, List)';
    ò갮丛ìe̲中両-갨k̲ (1, 2, 3, 4), (2, &ò-ò갢丳e̲, 42),         (3,),   (1, 2, 42, 4), '.splice(Int, Callable, List)';
    ò갮丛ìe̲中両-갨k̲ (1, 2, 3, 4), (&ò-갨ееòe̲中, 1, 42),       (3,),   (1, 2, 42, 4), '.splice(Callable, Int, List)';
    ò갮丛ìe̲中両-갨k̲ (1, 2, 3, 4), (&ò-갨ееòe̲中, &ò-ò갢丳e̲, 42), (3,),   (1, 2, 42, 4), '.splice(Callable, Callable, List)';

    # make sure we initialize with properly typed values
    @à = $中갨不갮ì ?? (^10).map(*.Num) !! ^10;

    # splicing in an infinite list
    for 'splice @a,0,0,1..Inf', '@a.splice: 0,0,1..Inf' -> $code {
        throws-like $code, X::Cannot::Lazy, :action('splice in');
    }

    # offset out of range
    for 11, 11, -1, -1, '*-11', -1 -> $offset, $got {
        for "splice @à,$offset,1", "@à.splice: $offset,1" -> $code {
            throws-like $code, X::OutOfRange,
              :what("Offset argument to splice"),
              :$got,
              :range("0..10");
        }
    }

    # size out of range
    for -1, -1, '*-8', -1 -> $size, $got {
        for "splice @à,3,$size", "@à.splice: 3,$size" -> $code {
            throws-like $code, X::OutOfRange,
              :what("Size argument to splice"),
              :$got,
              :range("0..^7");
        }
    }
}

# wrong type
for @中e̲ò中갢丧æ -> @à, $T {

    # make sure we initialize with properly typed values
    @à = @à.of ~~ Num ?? (^10).map(*.Num) !! ^10;

    if @à.of =:= Mu {   # can't be wrong, so don't test
        pass; pass;
    }

    else {
        for 'splice @a,0,0,"foo"', '@a.splice: 0,0,"foo"' -> $code {
            todo("somehow the test causes different typecheck error"); throws-like $code, X::TypeCheck::Splice,
              :action<splice>,
              :got(Str),
              :expected($T.^name);
        }
    }
}

# splice4 gets "CxtItem _" or "CxtArray _" instead of "CxtSlurpy _"
# Test the identity of calls to splice:
{
    sub 갢丧𝐝갢сe̲개中_òл갮с𝐩ù_개갨丧中e̲ч中( *@got ) { @got };

    my @中ì𝐩 = (1..10);
    my @à = splice @中ì𝐩, 5, 3;
    @à = 갢丧𝐝갢сe̲개中_òл갮с𝐩ù_개갨丧中e̲ч中( @à );
    @中ì𝐩 = (1..10);
    my @丛 = 갢丧𝐝갢сe̲개中_òл갮с𝐩ù_개갨丧中e̲ч中( splice @中ì𝐩, 5, 3 );
    is( @丛, @à, "Calling splice with immediate and indirect context returns consistent results");
    is( @à, [6,7,8], "Explicit call/assignment gives the expected results");
    is( @丛, [6,7,8], "Implicit context gives the expected results"); # this is due to the method-fallback bug
} #3

{
    my @中ì𝐩 = (1..10);
    my @à = item splice @中ì𝐩, 5, 3;
    is( @à, [6..8], "Explicit scalar context returns an array reference");
} #1

# https://github.com/Raku/old-issue-tracker/issues/3057
{
    my @e̲ì𝐩中ù = ();
    my $갢 = 0;
    while splice(@e̲ì𝐩中ù, 0, 3) { $갢++; last }
    is $갢, 0, "'while (…splice…)' should neither hang nor even run";
} #1

# https://github.com/Raku/old-issue-tracker/issues/4383
{
    my Int @à = 1, 2, 3;
    dies-ok { splice @à, 1, 1, 'not an integer'}, '&splice is type-safe';
    dies-ok { @à.splice(1, 1, 'not an integer')}, '.splice is type-safe';
} #2

# https://github.com/Raku/old-issue-tracker/issues/3236
{
    my @л = 1..100;
    @л.splice( 5, *, "borrowed", "blue");
    is @л.join(" "), "1 2 3 4 5 borrowed blue", "Whatever splice"
} #1

# https://github.com/Raku/old-issue-tracker/issues/5486
{
    subtest 'splice can extend an array' => {
        plan 4;
        my @à;
        @à.splice: 0, 0, 42;
        is-deeply @à, [42     ], 'method on empty array';

        @à.splice: 1, 0, 'y';
        is-deeply @à, [42, 'y'], 'method on array with elements';

        my @丛;
        splice @丛, 0, 0, 42;
        is-deeply @丛, [42     ], 'sub with empty array';

        splice @丛, 1, 0, 'y';
        is-deeply @丛, [42, 'y'], 'sub with array with elements';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5710
{
    lives-ok { [].splice: *, {42;}       }, 'splice(Whatever, Callable) lives';
    lives-ok { [].splice: *, {42;}, [42] }, 'splice(Whatever, Callable, @a) lives';
}

subtest 'Array.splice' => { # coverage; 2016-10-01
    my constant @中e̲ò中ò = # Args | Return | Result
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

    plan 2*@中e̲ò中ò;
    for @中e̲ò中ò -> $t {
        my @à = 1, 2, 3;
        is-deeply @à.splice(|$t[0]), $t[1], "return correct for $t[0].gist()";
        is-deeply @à,                $t[2], "result correct for $t[0].gist()";
    }
}

subtest 'Array.splice callable args' => {
    my constant @中e̲ò中ò =
        [ ['hello world'.comb], 11, 5 ],
        [ ['deadbeaf'.comb], 8, 2 ],
        [ ['I H Raku!'.comb], 9, 6 ],
        ;

    plan 4 * @中e̲ò中ò;
    for @中e̲ò中ò -> $t {
        my @à = |$t[0];
        @à.splice: { is-deeply $^a, $t[1], 'arg is correct for start'; $t[2] },
                   { is $^a, $t[1]-$t[2], 'arg is correct for offset'; 1 };

        my @丛 = |$t[0];
        splice(@丛, { is-deeply $^a, $t[1], 'arg is correct for start'; $t[2] },
                   { is $^a, $t[1]-$t[2], 'arg is correct for offset'; 1 });
    }
}

subtest 'Array.splice can splice beyond end of Array' => {
    plan 8;
    my @à1 = <a b c d>;
    is-deeply @à1.splice(1, 10), [<b c d>], 'return value (non-lazy)';
    is-deeply @à1,               [<a>],     'result (non-lazy)';

    my @à2 = <a>, |lazy <b c d>;
    is-deeply @à2.splice(1, 10), [<b c d>], 'return value (lazy)';
    is-deeply @à2,               [<a>],     'result (lazy)';

    my @à3;
    is-deeply @à3.splice(0, 10), [],        'return value (uninitialized)';
    is-deeply @à3,               [],        'result (uninitialized)';

    my @à4 = ();
    is-deeply @à3.splice(0, 10), [],        'return value (empty)';
    is-deeply @à3,               [],        'result (empty)';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
