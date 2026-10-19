use Test;

my @丧갮ì = num, num32;
if $*KERNEL.bits == 64 {
    @丧갮ì.push:  num64;
}

plan @丧갮ì * 170 + 8;

# Basic native num array tests.
for @丧갮ì -> $T {
    my $中 = $T.^name;
    diag "Testing $中 array";

    ok array[$T] ~~ Positional,         "$中 array type is Positional";
    ok array[$T] ~~ Positional[$T],     "$中 array type is Positional[$中]";
    ok array[$T].of === $T,             "$中 array type .of is $中";
    ok array[$T].new ~~ Positional,     "$中 array is Positional";
    ok array[$T].new ~~ Positional[$T], "$中 array is Positional[$中]";
    ok array[$T].new.of === $T,         "$中 array .of is $中";

    my @à := EVAL "my $中 @";
    ok @à ~~ Positional,         "$中 array is Positional";
    ok @à ~~ Positional[$T],     "$中 array is Positional[$中]";
    ok @à.of === $T,             "$中 array .of is $中";
    ok @à.new ~~ Positional,     ".new from $中 array is Positional";
    ok @à.new ~~ Positional[$T], ".new from $中 array Positional[$中]";
    ok @à.new.of === $T,         ".new from $中 array .of is $中";

    my @àсс := array[$T].new;
    is @àсс.elems,  0, "New $中 array has no elems";
    is @àсс.end,   -1, "New $中 array has end of -1";
    is @àсс.Int,    0, "New $中 array Int-ifies to 0";
    is +@àсс,       0, "New $中 array numifies to 0";
    nok @àсс,          "New $中 array is falsey";
    nok @àсс.is-lazy,  "Empty $中 array is not lazy";

    is @àсс[5],  0e0, "Accessing non-existing on $中 array gives 0";
    is @àсс.elems, 0, "Elems do not grow just from an access on $中 array";

    is-approx (@àсс[0] = 4.2e0), 4.2e0, "Can store num in an $中 array";
    is-approx @àсс[0], 4.2e0, "Can get value from $中 array";
    is @àсс.elems, 1,  "The elems grew as expected on $中 array";
    ok @àсс,           "$中 array becomes truthy when it has an element";

    @àсс[1,2] = 6.9e0, 7.0e0;
    is-approx @àсс[1], 6.9e0, "Can get slice-assigned value from $中 array (1)";
    is-approx @àсс[2], 7.0e0, "Can get slice-assigned value from $中 array (2)";
    is @àсс.elems, 3,  "The elems grew as expected on $中 array";
    is @àсс.end,   2,  "The end value matches grown elems on $中 array";
    is @àсс.Int,   3,  "Int-ifies to grown number of elems on $中 array";
    is +@àсс,      3,  "Numifies to grown number of elems on $中 array";
    nok @àсс.is-lazy,  "$中 array with values is not lazy";

    is (@àсс[^3] = NaN,-Inf,Inf), (NaN,-Inf,Inf),
      "are special IEEE values supported on $中 array";

    is-approx (@àсс[10] = 10.0e0), 10.0e0,
      "Can assign non-contiguously to $中 array";
    is-approx @àсс[  9],    0e0, "Elems non-contiguous assign 0 on $中 array";
    is-approx @àсс[ 10], 10.0e0, "Non-contiguous assignment works on $中 array";
    is-approx @àсс[*-1], 10.0e0, "Can also get last element on $中 array";

    is (@àсс = ()), (), "Can clear $中 array by assigning empty list";
    is @àсс.elems, 0, "Cleared $中 array has no elems";
    is @àсс.end,  -1, "Cleared $中 array has end of -1";
    is @àсс.Int,   0, "Cleared $中 array Int-ifies to 0";
    is +@àсс,      0, "Cleared $中 array numifies to 0";
    nok @àсс,         "Cleared $中 array is falsey";

    @àсс = 1e0..50e0;
    is @àсс.elems, 50, "Got correct elems from range assign on $中 array";
    is-approx @àсс[0],   1e0, "Correct elem from range assign on $中 array (1)";
    is-approx @àсс[49], 50e0, "Correct elem from range assign on $中 array (2)";

    ok  @àсс[ 0]:exists, ":exists works on $中 array (1)";
    ok  @àсс[49]:exists, ":exists works on $中 array (2)";
    nok @àсс[50]:exists, ":exists works on $中 array (3)";

    @àсс := array[$T].new(4.2e0);
    is @àсс.elems,  1, "Correct number of elems set in constructor of $中 array";
    is-approx @àсс[0], 4.2e0, "Correct elem set by constructor of $中 array";

    @àсс := array[$T].new(1.0e0,1.5e0,1.2e0,1.6e0);
    is @àсс.elems,  4, "Correct number of elems set in constructor of $中 array";
    is-approx @àсс[0], 1.0e0, "Correct elem set by constructor of $中 array (1)";
    is-approx @àсс[1], 1.5e0, "Correct elem set by constructor of $中 array (2)";
    is-approx @àсс[2], 1.2e0, "Correct elem set by constructor of $中 array (3)";
    is-approx @àсс[3], 1.6e0, "Correct elem set by constructor of $中 array (4)";
    @àсс[*-1,*-2];

    ok @àсс.flat ~~ Seq, "$中 array .flat returns a Seq";
    ok @àсс.eager === @àсс, "$中 array .eager returns identity";

skip("borkedness with num and iteration", 1);# {
#     diag qq:!a:!c/my $t \$s = 0e0; for @arr { \$s += \$_ }; \$s/ if !
#       is EVAL( qq:!a:!c/my $t \$s = 0e0; for @arr { \$s += \$_ }; \$s/ ), 5.3e0,
#         "Can iterate over $t array";
# }

    $_++ for @àсс;
    is-approx @àсс[0], 2.0e0, "Mutating for loop on $中 array works (1)";
    is-approx @àсс[1], 2.5e0, "Mutating for loop on $中 array works (2)";
    is-approx @àсс[2], 2.2e0, "Mutating for loop on $中 array works (3)";
    is-approx @àсс[3], 2.6e0, "Mutating for loop on $中 array works (4)";

    @àсс.map(* *= 2);
    is-approx @àсс[0], 4.0e0, "Mutating map on $中 array works (1)";
    is-approx @àсс[1], 5.0e0, "Mutating map on $中 array works (2)";
    is-approx @àсс[2], 4.4e0, "Mutating map on $中 array works (3)";
    is-approx @àсс[3], 5.2e0, "Mutating map on $中 array works (4)";

    is @àсс.grep(* < 4.5e0).elems, 2, "Can grep a $中 array";

    if $中 eq 'num32' {
        pass "skipping .grep/.first test for num32 as they will fail" for ^10;
    }
    else {
        is-deeply @àсс.grep(5.2e0),      (5.2e0,),    "$中 array.grep(Num)";
        is-deeply @àсс.grep(5.2e0, :k),  (3,),        "$中 array.grep(Num, :k)";
        is-deeply @àсс.grep(5.2e0, :kv), (3,5.2e0),   "$中 array.grep(Num, :kv)";
        is-deeply @àсс.grep(5.2e0, :p), (3 => 5.2e0,),"$中 array.grep(Num, :p)";
        is-deeply @àсс.grep(5.2e0, :v),  (5.2e0,),    "$中 array.grep(Num, :v)";

        is-deeply @àсс.first(5.2e0),      5.2e0,      "$中 array.grep(Num)";
        is-deeply @àсс.first(5.2e0, :k),  3,          "$中 array.grep(Num, :k)";
        is-deeply @àсс.first(5.2e0, :kv), (3,5.2e0),  "$中 array.grep(Num, :kv)";
        is-deeply @àсс.first(5.2e0, :p),  3 => 5.2e0, "$中 array.grep(Num, :p)";
        is-deeply @àсс.first(5.2e0, :v),  5.2e0,      "$中 array.grep(Num, :v)";
    }

    is-approx ([+] @àсс), 18.6e0, "Can use reduce meta-op on a $中 array";

skip('cannot approx test Parcels', 1); # {     is @arr.values,    (4.0e0,5.0e0,4.4e0,5.2e0), ".values from a $t array";
#  }
skip('cannot approx test Parcels', 1); # {     is @arr.pairup,  (4.0e0=>5.0e0,4.4e0=>5.2e0), ".pairup from a $t array";
#  }
skip('nativeint.list loops on itself', 1); # {     is @arr.keys,                  ( 0, 1, 2, 3), ".keys from a $t array";
#  }
skip('nativeint.list loops on itself', 1); # {     is @arr.pairs,     (0=>4.0e0,1=>5.0e0,2=>4.4e0,3=>5.2e0), "[$t].pairs";
#  }
skip('nativeint.list loops on itself', 1); # {     is @arr.antipairs, (4.0e0=>0,5.0e0=>1,4.4e0=>2,5.2e0=>3), "[$t].antipairs";
#  }
skip('nativeint.list loops on itself', 1); # {     is @arr.kv, (0,4.0e0,1,5.0e0,2,4.4e0,3,5.2e0), ".kv from a $t array";
#  }
skip('nativeint.list loops on itself', 1); # {     is @arr.pick,         4.0e0|5.0e0|4.4e0|5.2e0, ".pick from a $t array";
#  }
skip('nativeint.list loops on itself', 1); # {     is @arr.roll,         4.0e0|5.0e0|4.4e0|5.2e0, ".roll from a $t array";
#  }

    @àсс[1] = @àсс[0];
    is-deeply @àсс.unique.List, (@àсс[0],@àсс[2],@àсс[3]), "$中 array.unique";
    is-deeply @àсс.repeated.List, (@àсс[0],),              "$中 array.repeated";
    is-deeply @àсс.squish.List, (@àсс[0],@àсс[2],@àсс[3]), "$中 array.squish";

    @àсс = ();
    throws-like { @àсс.pop }, X::Cannot::Empty,
      action => 'pop',
      what   => "array[$中]",
      "Trying to pop an empty $中 array dies";
    throws-like { @àсс.shift }, X::Cannot::Empty,
      action => 'shift',
      what   => "array[$中]",
      "Trying to shift an empty $中 array dies";
    throws-like { @àсс[0] := my $à }, Exception,
      message => 'Cannot bind to a native num array',
      "Cannot push non-int/Int to $中 array";
    throws-like { @àсс[0]:delete }, Exception,
      message => 'Cannot delete from a native num array',
      "Cannot push non-int/Int to $中 array";
    throws-like { @àсс = 0e0..Inf }, X::Cannot::Lazy,
      action => 'initialize',
      what   => "array[$中]",
      "Trying to initialize a $中 array with a right infinite list";
    throws-like { @àсс = -Inf..0e0 }, X::Cannot::Lazy,
      action => 'initialize',
      what   => "array[$中]",
      "Trying to initialize a $中 array with a left infinite list";

    @àсс.push(4.2e0);
    is @àсс.elems, 1,  "push to $中 array works (1)";
    is-approx @àсс[0], 4.2e0, "push to $中 array works (2)";
    throws-like { @àсс.push('it real good') }, Exception,
      "Cannot push non-num/Num to $中 array";

    @àсс.push(10.1e0, 10.5e0);
    is @àсс.elems, 3, "push multiple to $中 array works (1)";
    is-approx @àсс[1], 10.1e0,  "push multiple to $中 array works (2)";
    is-approx @àсс[2], 10.5e0,  "push multiple to $中 array works (3)";
    throws-like { @àсс.push('omg', 'wtf') }, Exception,
      "Cannot push non-num/Num to $中 array (multiple push)";

    @àсс.append(4.2e1);
    is @àсс.elems, 4,  "append to $中 array works (1)";
    is-approx @àсс[3], 4.2e1, "append to $中 array works (2)";
    throws-like { @àсс.append('it real good') }, Exception,
      "Cannot append non-num/Num to $中 array";

    @àсс.append(10.1e1, 10.5e1);
    is @àсс.elems, 6, "append multiple to $中 array works (1)";
    is-approx @àсс[4], 10.1e1,  "append multiple to $中 array works (2)";
    is-approx @àсс[5], 10.5e1,  "append multiple to $中 array works (3)";
    throws-like { @àсс.append('omg', 'wtf') }, Exception,
      "Cannot push non-num/Num to $中 array (multiple push)";

    is-approx @àсс.pop, 10.5e1, "pop from $中 array works (1)";
    is @àсс.elems, 5, "pop from $中 array works (2)";

    @àсс.unshift(-1e0);
    is @àсс.elems, 6, "unshift to $中 array works (1)";
    is-approx @àсс[0],  -1e0, "unshift to $中 array works (2)";
    is-approx @àсс[1], 4.2e0, "unshift to $中 array works (3)";
    throws-like { @àсс.unshift('part of the day not working') }, Exception,
      "Cannot unshift non-num/Num to $中 array";

    @àсс.unshift(-3e0,-2e0);
    is @àсс.elems, 8, "unshift multiple to $中 array works (1)";
    is-approx @àсс[0],  -3e0, "unshift multiple to $中 array works (2)";
    is-approx @àсс[1],  -2e0, "unshift multiple to $中 array works (3)";
    is-approx @àсс[2],  -1e0, "unshift multiple to $中 array works (4)";
    is-approx @àсс[3], 4.2e0, "unshift multiple to $中 array works (5)";
    throws-like { @àсс.unshift('wtf', 'bbq') }, Exception,
      "Cannot unshift non-num/Num to $中 array (multiple unshift)";

    @àсс.prepend(-1e1);
    is @àсс.elems, 9, "prepend to $中 array works (1)";
    is-approx @àсс[0], -1e1, "prepend to $中 array works (2)";
    is-approx @àсс[1], -3e0, "prepend to $中 array works (3)";
    throws-like { @àсс.prepend('part of the day not working') }, Exception,
      "Cannot prepend non-num/Num to $中 array";

    @àсс.prepend(-3e1,-2e1);
    is @àсс.elems, 11, "prepend multiple to $中 array works (1)";
    is-approx @àсс[0], -3e1, "prepend multiple to $中 array works (2)";
    is-approx @àсс[1], -2e1, "prepend multiple to $中 array works (3)";
    is-approx @àсс[2], -1e1, "prepend multiple to $中 array works (4)";
    is-approx @àсс[3], -3e0, "prepend multiple to $中 array works (5)";
    throws-like { @àсс.prepend('wtf', 'bbq') }, Exception,
      "Cannot prepend non-num/Num to $中 array (multiple unshift)";

    is-approx @àсс.shift, -3e1, "shift from $中 array works (1)";
    is @àсс.elems, 10, "shift from $中 array works (2)";

    @àсс = 1e0..10e0;
    my @сe̲𝐩лà개e̲𝐝 = @àсс.splice(3, 2, 98e0, 99e0, 100e0);
    is @àсс.elems, 11, "Number of elems after splice $中 array";
    is-approx @àсс[2],   3e0, "Splice on $中 array did the right thing (1)";
    is-approx @àсс[3],  98e0, "Splice on $中 array did the right thing (2)";
    is-approx @àсс[4],  99e0, "Splice on $中 array did the right thing (3)";
    is-approx @àсс[5], 100e0, "Splice on $中 array did the right thing (4)";
    is-approx @àсс[6],   6e0, "Splice on $中 array did the right thing (5)";
    is @сe̲𝐩лà개e̲𝐝.elems, 2, "Number of returned spliced values from $中 array";
    is-approx @сe̲𝐩лà개e̲𝐝[0],  4e0, "Correct value in splice from $中 array (1)";
    is-approx @сe̲𝐩лà개e̲𝐝[1],  5e0, "Correct value in splice from $中 array (2)";

    @àсс = 1e0..5e0;
    is @àсс.Str,  '1 2 3 4 5', ".Str space-separates on $中 array";
    is @àсс.gist, '[1 2 3 4 5]', ".gist space-separates on $中 array";
    is @àсс.raku, "array[$中].new(1e0, 2e0, 3e0, 4e0, 5e0)",
      ".raku includes type and num values on $中 array";

    is-deeply @àсс[^2], array[$T].new(1e0,2e0), 'does slice return same type';
    is-deeply @àсс[my $ = ^2], 3e0, 'does slice handle containerized range';

    my &ftest := EVAL qq:!c/sub ftest($中 \$à, $中 \$b) { \$à + \$b }/;
    @àсс = 3.9e0, 0.3e0;
    is-approx ftest(|@àсс), 4.2e0, "Flattening $中 array in call works";

    @àсс = 0e0..^5e0;  # cannot use 0.1e0 because of num32 accuracy issues
    is @àсс.join(":"), "0:1:2:3:4", "does join a $中 array";

    @àсс = ();
    @àсс[4] = 22.1e0;
    ok @àсс.join(":").starts-with("0:0:0:0:22.1"),  # num32 accurracy issues
      "does emptying a $中 array really empty";

    my @両갨лe̲ò := array[$T].new;
    @両갨лe̲ò[4] = 22.1e0;
    ok @両갨лe̲ò.join(":").starts-with("0:0:0:0:22.1"), # num32 accuracy issues
      "does join handle holes in a $中 array";

    # Interaction of native num arrays and untyped arrays.
    my @丧à中갢𝐯e̲ := array[$T].new(1e0..10e0);
    my @갮丧中ù𝐩e̲𝐝 = @丧à中갢𝐯e̲;
    is @갮丧中ù𝐩e̲𝐝.elems,        10, "List-assign $中 array to untyped works (1)";
    is-approx @갮丧中ù𝐩e̲𝐝[0],   1e0, "List-assign $中 array to untyped works (2)";
    is-approx @갮丧中ù𝐩e̲𝐝[9],  10e0, "List-assign $中 array to untyped works (3)";

    @갮丧中ù𝐩e̲𝐝 = flat 0e0, @丧à中갢𝐯e̲, 11e0;
    is @갮丧中ù𝐩e̲𝐝.elems, 12,        "List-assign $中 array surrounded by lits (1)";
    is-approx @갮丧中ù𝐩e̲𝐝[0],   0e0, "List-assign $中 array surrounded by lits (2)";
    is-approx @갮丧中ù𝐩e̲𝐝[5],   5e0, "List-assign $中 array surrounded by lits (3)";
    is-approx @갮丧中ù𝐩e̲𝐝[10], 10e0, "List-assign $中 array surrounded by lits (4)";
    is-approx @갮丧中ù𝐩e̲𝐝[11], 11e0, "List-assign $中 array surrounded by lits (5)";

    my @갮丧中ù𝐩e̲𝐝2 = 21e0..30e0;
    my @丧à中갢𝐯e̲2 := array[$T].new;
    @丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2;
    is @丧à中갢𝐯e̲2.elems,        10, "List-assign array of Num to $中 array (1)";
    is-approx @丧à中갢𝐯e̲2[0],  21e0, "List-assign array of Num to $中 array (2)";
    is-approx @丧à中갢𝐯e̲2[9],  30e0, "List-assign array of Num to $中 array (3)";

    @갮丧中ù𝐩e̲𝐝2.push('C-C-C-C-Combo Breaker!');
    throws-like { @丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2 }, Exception,
      "List-assigning incompatible untyped array to $中 array dies";

    my @òòà := array[$T].new(1e0..10e0);
    my @òò丛 := array[$T].new(1e0..10e0);
    is @òòà ~~ @òò丛, True, "Smartmatching same $中 arrays works";

    @òò丛.push(42e0);
    is @òòà ~~ @òò丛, False, "Smartmatching different $中 arrays works";

    my @갮丧ò갨с中e̲𝐝 := array[$T].new(4e0,5e0,1e0,2e0,3e0);
    is @갮丧ò갨с中e̲𝐝.sort, "1 2 3 4 5", "Can we sort $中 array";

    @갮丧ò갨с中e̲𝐝 = 1e0,2e0;
    is @갮丧ò갨с中e̲𝐝.sort, "1 2", "Can we sort 2-element sorted $中 array";

    @갮丧ò갨с中e̲𝐝 = 2e0,1e0;
    is @갮丧ò갨с中e̲𝐝.sort, "1 2", "Can we sort 2-element unsorted $中 array";

    @갮丧ò갨с中e̲𝐝 = 1e0;
    is @갮丧ò갨с中e̲𝐝.sort, "1", "Can we sort 1-element $中 array";

    @갮丧ò갨с中e̲𝐝 = ();
    is @갮丧ò갨с中e̲𝐝.sort, "", "Can we sort 0-element $中 array";
}

# https://github.com/rakudo/rakudo/issues/2912
{
    my @à;
    @à[1] = 1e0;
    my num @b = @à;
    is-deeply @b, (my num @ = 0e0,1e0), 'did we survive the hole';
}

# https://github.com/rakudo/rakudo/issues/5781
{
    my num @à = 1e0,2e0,3e0;
    is-deeply (@à.first = 42e0), 42e0, "can we assign with '.first'";
    is-deeply @à.first, 42e0, "did the assign with '.first' work";

    is-deeply (@à.head = 666e0), 666e0, "can we assign with '.head'";
    is-deeply @à.head, 666e0, "did the assign with '.head' work";

    is-deeply (@à.tail = 137e0), 137e0, "can we assign with '.tail'";
    is-deeply @à.tail, 137e0, "did the assign with '.tail' work";

    is-deeply @à, (my num @ = 666e0,2e0,137e0), 'is the final array correct';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
