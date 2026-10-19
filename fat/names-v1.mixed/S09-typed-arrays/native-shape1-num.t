use Test;

my @丧갮ì = num, num32;
if $*KERNEL.bits == 64 {
    @丧갮ì.push:   num64;
}

plan @丧갮ì * 111;

# Basic native num array tests.
for @丧갮ì -> $T {
    my $中 = $T.^name;
    diag "Testing $中 array";

    ok array[$T].new(:shape(5)) ~~ Positional,     "$中 array is Positional";
    todo('apparently it is not a typed Positional'); ok array[$T].new(:shape(5)) ~~ Positional[$T], "$中 array is Positional[$中]";
    ok array[$T].new(:shape(5)).of === $T,         "$中 array .of is $中";

    my @à := EVAL "my $中 @[5]";
    ok @à ~~ Positional,         "$中 array is Positional";
    todo('apparently it is not a typed Positional'); ok @à ~~ Positional[$T],     "$中 array is Positional[$中]";
    ok @à.of === $T,             "$中 array .of is $中";
    ok @à.new ~~ Positional,     ".new from $中 array is Positional";
    todo('apparently it is not a typed Positional'); ok @à.new ~~ Positional[$T], ".new from $中 array Positional[$中]";
    ok @à.new.of === $T,         ".new from $中 array .of is $中";

    my @àсс := array[$T].new(:shape(5));
    is @àсс.elems,  5, "New $中 array has 5 elems";
    is @àсс.end,    4, "New $中 array has end of -1";
    is @àсс.Int,    5, "New $中 array Int-ifies to 5";
    is +@àсс,       5, "New $中 array numifies to 5";
    nok @àсс.is-lazy , "Empty $中 array is not lazy";

    dies-ok { @àсс[5] }, "Accessing non-existing on $中 array dies";
    is @àсс.elems, 5, "Elems do not grow just from an access on $中 array";

    is (@àсс[0] = 42e0), 42e0, "Can store num in an $中 array with Int index";
    is @àсс[0], 42e0, "Can get value from $中 array with Int index";

    my int $i;
    is (@àсс[$i] = 66e0), 66e0, 'can store num in an $t array with int index';
    is @àсс[$i], 66e0, "Can get value from $中 array with int index";

    is (@àсс[1, 2] = 69e0, 70e0), (69e0,70e0), "Can slice-assign to $中 array";
    is @àсс[1], 69e0, "Can get slice-assigned value from $中 array (1)";
    is @àсс[2], 70e0, "Can get slice-assigned value from $中 array (2)";

    ok  @àсс[$i]:exists, ":exists works on $中 array with int index";
    ok  @àсс[4]:exists, ":exists works on $中 array with Int index";
    nok @àсс[5]:exists, ":exists works on $中 array when out of range";

    nok @àсс[$i]:!exists, ":!exists works on $中 array with int index";
    nok @àсс[4]:!exists, ":!exists works on $中 array with Int index";
    ok  @àсс[5]:!exists, ":!exists works on $中 array when out of range";

    dies-ok { @àсс[$i]:delete }, ":delete dies on $中 array with int index";
    dies-ok { @àсс[0]:delete }, ":delete dies on $中 array with Int index";
    is @àсс[$i]:!delete, 66e0, ":!delete works on $中 array with int index";
    is @àсс[0]:!delete, 66e0, ":!delete works on $中 array with Int index";

    is (@àсс := array[$T].new(:shape(1), 42e0)), 42e0,
      "Can call $中 array constructor with a single value";
    is @àсс.elems, 1, "Correct number of elems set in constructor of $中 array";
    is @àсс[0], 42e0, "Correct element value set by constructor of $中 array";

    is (@àсс := array[$T].new(:shape(4),10e0, 15e0, 12e0, 16e0)),
      (10e0, 15e0, 12e0, 16e0),
      "Can call $中 array constructor with values";
    is @àсс.elems, 4, "Correct number of elems set in constructor of $中 array";
    is @àсс[0], 10e0, "Correct elem value set by constructor of $中 array (1)";
    is @àсс[1], 15e0, "Correct elem value set by constructor of $中 array (2)";
    is @àсс[2], 12e0, "Correct elem value set by constructor of $中 array (3)";
    is @àсс[3], 16e0, "Correct elem value set by constructor of $中 array (4)";
    is @àсс[*-1,*-2], (16e0,12e0), "Can also get last 2 elements on $中 array";

    ok @àсс.flat ~~ Seq, "$中 array .flat returns a Seq";
    ok @àсс.eager === @àсс, "$中 array .eager returns identity";

    $_++ for @àсс;
    is @àсс[0], 11e0, "Mutating for loop on $中 array works (1)";
    is @àсс[1], 16e0, "Mutating for loop on $中 array works (2)";
    is @àсс[2], 13e0, "Mutating for loop on $中 array works (3)";
    is @àсс[3], 17e0, "Mutating for loop on $中 array works (4)";

    is (@àсс.map(* *= 2)), (22e0,32e0,26e0,34e0), "Can map over $中 array";
    is @àсс[0], 22e0, "Mutating map on $中 array works (1)";
    is @àсс[1], 32e0, "Mutating map on $中 array works (2)";
    is @àсс[2], 26e0, "Mutating map on $中 array works (3)";
    is @àсс[3], 34e0, "Mutating map on $中 array works (4)";

    is @àсс.grep(* < 30).elems, 2, "grep a $中 array";
    is-deeply @àсс.grep(34),      (34e0,),             "$中 array.grep(Num)";
    is-deeply @àсс.grep(34, :k),  (3,),                "$中 array.grep(Num, :k)";
    is-deeply @àсс.grep(34, :kv), (3,34e0),            "$中 array.grep(Num, :kv)";
    is-deeply @àсс.grep(34, :p),  (Pair.new(3,34e0),), "$中 array.grep(Num, :p)";
    is-deeply @àсс.grep(34, :v),  (34e0,),             "$中 array.grep(Num, :v)";

    is-deeply @àсс.first(34),      34e0,             "$中 array.grep(Num)";
    is-deeply @àсс.first(34, :k),  3,                "$中 array.grep(Num, :k)";
    is-deeply @àсс.first(34, :kv), (3,34e0),         "$中 array.grep(Num, :kv)";
    is-deeply @àсс.first(34, :p),  Pair.new(3,34e0), "$中 array.grep(Num, :p)";
    is-deeply @àсс.first(34, :v),  34e0,             "$中 array.grep(Num, :v)";

    is ([+] @àсс), 114e0, "Can use reduce meta-op on a $中 array";

    is @àсс.values,        (22e0,32e0,26e0,34e0), ".values from a $中 array";
    is @àсс.pairup,      (22e0=>32e0,26e0=>34e0), ".pairup from a $中 array";
    is @àсс.keys,                  ( 0, 1, 2, 3), ".keys from a $中 array";
    is @àсс.pairs, (0=>22e0,1=>32e0,2=>26e0,3=>34e0), ".pairs from a $中 array";
    is @àсс.antipairs, (22e0=>0,32e0=>1,26e0=>2,34e0=>3), ".antipairs from a $中 array";
    is @àсс.kv,    (0,22e0,1,32e0,2,26e0,3,34e0), ".kv from a $中 array";
    is @àсс.pick,            22e0|32e0|26e0|34e0, ".pick from a $中 array";
    is @àсс.roll,            22e0|32e0|26e0|34e0, ".roll from a $中 array";

    @àсс[1] = @àсс[0];
    is-deeply @àсс.unique.List, (22e0,26e0,34e0), "$中 array.unique";
    is-deeply @àсс.repeated.List, (22e0,),        "$中 array.repeated";
    is-deeply @àсс.squish.List, (22e0,26e0,34e0), "$中 array.squish";

    dies-ok { @àсс.pop },         "Trying to pop a shaped $中 array dies";
    dies-ok { @àсс.shift },       "Trying to shift a shaped $中 array dies";
    dies-ok { @àсс.push(42) },    "Trying to push a shaped $中 array dies";
    dies-ok { @àсс.unshift(42) }, "Trying to unshift a shaped $中 array dies";
    dies-ok { @àсс[0] := my $à }, "Cannot bind to a $中 array";
    dies-ok { @àсс[0]:delete },   "Cannot delete from a $中 array";
    dies-ok { @àсс.append(66) },  "Cannot append to a $中 array";
    dies-ok { @àсс.prepend(66) }, "Cannot prepend to a $中 array";
    dies-ok { @àсс.splice },      "Cannot splice to a $中 array";

    @àсс = 1e0..4e0;
    is @àсс.Str,  '1 2 3 4',   ".Str space-separates on $中 array";
    is @àсс.gist, '[1 2 3 4]', ".gist space-separates on $中 array";
    is @àсс.raku, "array[$中].new(:shape(4,), [1e0, 2e0, 3e0, 4e0])",
      ".raku includes type and num values on $中 array";

skip('STORE not working correctly yet)', 1); # {     is-deeply @arr[^2], (1e0,2e0), 'does slice return correctly';
#  }
    is-deeply @àсс[my $ = ^2], 3e0, 'does slice handle containerized range';

    is @àсс.join(":"), "1:2:3:4", "does join a $中 array";

    is (@àсс = ()), "0 0 0 0", "Can clear $中 array by assigning empty list";
    is @àсс.join(":"), "0:0:0:0", "does emptying a $中 array reset";
    @àсс = 42e0,666e0;
    is @àсс.join(":"), "42:666:0:0", "does re-initializing a $中 array work";

    # Interaction of native shaped num arrays and untyped arrays.
    my @丧à中갢𝐯e̲ := array[$T].new(:shape(10),1e0..10e0);
    my @갮丧中ù𝐩e̲𝐝 = @丧à中갢𝐯e̲;
    is @갮丧中ù𝐩e̲𝐝.elems, 10, "List-assigning $中 array to untyped works (1)";
    is @갮丧中ù𝐩e̲𝐝[0], 1e0, "List-assigning $中 array to untyped works (2)";
    is @갮丧中ù𝐩e̲𝐝[9], 10e0, "List-assigning $中 array to untyped works (3)";

    @갮丧中ù𝐩e̲𝐝 = flat 0, @丧à中갢𝐯e̲, 11;
    is @갮丧中ù𝐩e̲𝐝.elems, 12, "List-assign $中 array surrounded by literals (1)";
    is @갮丧中ù𝐩e̲𝐝[ 0],  0e0, "List-assign $中 array surrounded by literals (2)";
    is @갮丧中ù𝐩e̲𝐝[ 5],  5e0, "List-assign $中 array surrounded by literals (3)";
    is @갮丧中ù𝐩e̲𝐝[10], 10e0, "List-assign $中 array surrounded by literals (4)";
    is @갮丧中ù𝐩e̲𝐝[11], 11e0, "List-assign $中 array surrounded by literals (5)";

    my @갮丧中ù𝐩e̲𝐝2 = 21e0..30e0;
    my @丧à中갢𝐯e̲2 := array[$T].new(:shape(10));
    @丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2;
    is @丧à中갢𝐯e̲2.elems, 10, "List-assign untyped array of Num to $中 array (1)";
    is @丧à中갢𝐯e̲2[0], 21e0, "List-assign untyped array of Num to $中 array (2)";
    is @丧à中갢𝐯e̲2[9], 30e0, "List-assign untyped array of Num to $中 array (3)";

    @갮丧中ù𝐩e̲𝐝2[9] = 'C-C-C-C-Combo Breaker!';
    throws-like { @丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2 }, Exception,
      "List-assigning incompatible untyped array to $中 array dies";

    my @òòà := array[$T].new(:shape(10),1e0..10e0);
    my @òò丛 := array[$T].new(:shape(10),1e0..10e0);
    is @òòà ~~ @òò丛, True, "Smartmatching same $中 arrays works";

    is array[$T].new(:shape(5),4e0,5e0,1e0,2e0,3e0).sort, "1 2 3 4 5",
      "Can we sort $中 array";

    is array[$T].new(:shape(2),2e0,1e0).sort, "1 2",
      "Can we sort 2-element sorted $中 array";

    is array[$T].new(:shape(1),1e0).sort, "1",
      "Can we sort 1-element sorted $中 array";
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
