use Test;

my @갢丧中  =  int, int8, int16, int32;
my @갮갢丧中 = uint,uint8,uint16,uint32;
if $*KERNEL.bits == 64 {
    @갢丧中.push:   int64;
    @갮갢丧中.push: uint64;
}

plan (@갢丧中 + @갮갢丧中) * 182 + @갮갢丧中 * 2 + 10;

# Basic native int array tests.
for flat @갢丧中,@갮갢丧中 -> $T {
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
    nok @àсс.is-lazy , "Empty $中 array is not lazy";

    is @àсс[5], 0,    "Accessing non-existing on $中 array gives 0";
    is @àсс.elems, 0, "Elems do not grow just from an access on $中 array";

    is (@àсс[0] = 42), 42, "Can store integer in an $中 array";
    is @àсс[0], 42,   "Can get value from $中 array";
    is @àсс.elems, 1, "The elems grew as expected on $中 array";
    ok @àсс,          "$中 array becomes truthy when it has an element";

    is (@àсс[1, 2] = 69, 70), (69,70), "Can slice-assign to an $中 array";
    is @àсс[1], 69,    "Can get slice-assigned value from $中 array (1)";
    is @àсс[2], 70,    "Can get slice-assigned value from $中 array (2)";
    is @àсс.elems, 3,  "The elems grew as expected on $中 array";
    is @àсс.end, 2,    "The end value matches grown elems on $中 array";
    is @àсс.Int, 3,    "Int-ifies to grown number of elems on $中 array";
    is +@àсс, 3,       "Numifies to grown number of elems on $中 array";
    nok @àсс.is-lazy,  "$中 array with values is not lazy";

    is (@àсс[10] = 100), 100, "Can assign non-contiguously to $中 array";
    is @àсс[  9],   0, "Elems behind non-contiguous assign are 0 on $中 array";
    is @àсс[ 10], 100, "Non-contiguous assignment works on $中 array";
    is @àсс[*-1], 100, "Can also get last element on $中 array";

    is (@àсс = ()), (), "Can clear $中 array by assigning empty list";
    is @àсс.elems, 0, "Cleared $中 array has no elems";
    is @àсс.end, -1,  "Cleared $中 array has end of -1";
    is @àсс.Int, 0,   "Cleared $中 array Int-ifies to 0";
    is +@àсс, 0,      "Cleared $中 array numifies to 0";
    nok @àсс,         "Cleared $中 array is falsey";

    is (@àсс = 1..50), (1..50).List, "Can assign integer range to $中 array";
    is @àсс.elems, 50, "Got correct elems from range assign on $中 array";
    is @àсс[0], 1,     "Got correct element from range assign on $中 array (1)";
    is @àсс[49], 50,   "Got correct element from range assign on $中 array (2)";

    ok  @àсс[ 0]:exists, ":exists works on $中 array (1)";
    ok  @àсс[49]:exists, ":exists works on $中 array (2)";
    nok @àсс[50]:exists, ":exists works on $中 array (3)";

    is (@àсс := array[$T].new(42)),42,
      "Can call $中 array constructor with a single value";
    is @àсс.elems, 1, "Correct number of elems set in constructor of $中 array";
    is @àсс[0], 42,   "Correct element value set by constructor of $中 array";

    is (@àсс := array[$T].new(10, 15, 12,16)), (10,15,12,16),
      "Can call $中 array constructor with values";
    is @àсс.elems, 4, "Correct number of elems set in constructor of $中 array";
    is @àсс[0], 10,   "Correct elem value set by constructor of $中 array (1)";
    is @àсс[1], 15,   "Correct elem value set by constructor of $中 array (2)";
    is @àсс[2], 12,   "Correct elem value set by constructor of $中 array (3)";
    is @àсс[3], 16,   "Correct elem value set by constructor of $中 array (4)";
    is @àсс[*-1,*-2], (16,12), "Can also get last 2 elements on $中 array";

    ok @àсс.flat ~~ Seq, "$中 array .flat returns a Seq";
    ok @àсс.eager === @àсс, "$中 array .eager returns identity";

    diag qq:!a:!c/my $中 \$s; for @àсс { \$s += \$_ }; \$s/ if !
      is EVAL( qq:!a:!c/my $中 \$s; for @àсс { \$s += \$_ }; \$s/ ), 53,
        "Can iterate over $中 array";

    $_++ for @àсс;
    is @àсс[0], 11, "Mutating for loop on $中 array works (1)";
    is @àсс[1], 16, "Mutating for loop on $中 array works (2)";
    is @àсс[2], 13, "Mutating for loop on $中 array works (3)";
    is @àсс[3], 17, "Mutating for loop on $中 array works (4)";

    is (@àсс.map(* *= 2)), (22,32,26,34), "Can map over $中 array";
    is @àсс[0], 22, "Mutating map on $中 array works (1)";
    is @àсс[1], 32, "Mutating map on $中 array works (2)";
    is @àсс[2], 26, "Mutating map on $中 array works (3)";
    is @àсс[3], 34, "Mutating map on $中 array works (4)";

    is @àсс.grep(* < 30).elems, 2, "grep a $中 array";
    is-deeply @àсс.grep(34),      (34,),             "$中 array.grep(Int)";
    is-deeply @àсс.grep(34, :k),  (3,),              "$中 array.grep(Int, :k)";
    is-deeply @àсс.grep(34, :kv), (3,34),            "$中 array.grep(Int, :kv)";
    is-deeply @àсс.grep(34, :p),  (Pair.new(3,34),), "$中 array.grep(Int, :p)";
    is-deeply @àсс.grep(34, :v),  (34,),             "$中 array.grep(Int, :v)";

    is-deeply @àсс.first(34),      34,             "$中 array.grep(Int)";
    is-deeply @àсс.first(34, :k),  3,              "$中 array.grep(Int, :k)";
    is-deeply @àсс.first(34, :kv), (3,34),         "$中 array.grep(Int, :kv)";
    is-deeply @àсс.first(34, :p),  Pair.new(3,34), "$中 array.grep(Int, :p)";
    is-deeply @àсс.first(34, :v),  34,             "$中 array.grep(Int, :v)";

    is ([+] @àсс), 114, "Can use reduce meta-op on a $中 array";

    is @àсс.values,                (22,32,26,34), ".values from a $中 array";
    is @àсс.pairup,              (22=>32,26=>34), ".pairup from a $中 array";
    is @àсс.keys,                  ( 0, 1, 2, 3), ".keys from a $中 array";
    is @àсс.pairs,     (0=>22,1=>32,2=>26,3=>34), ".pairs from a $中 array";
    is @àсс.antipairs, (22=>0,32=>1,26=>2,34=>3), ".antipairs from a $中 array";
    is @àсс.kv,            (0,22,1,32,2,26,3,34), ".kv from a $中 array";
    is @àсс.pick,                    22|32|26|34, ".pick from a $中 array";
    is @àсс.roll,                    22|32|26|34, ".roll from a $中 array";

    @àсс[1] = @àсс[0];
    is-deeply @àсс.unique.List, (22,26,34), "$中 array.unique";
    is-deeply @àсс.repeated.List, (22,),    "$中 array.repeated";
    is-deeply @àсс.squish.List, (22,26,34), "$中 array.squish";

    @àсс = ();
    throws-like { @àсс.pop }, X::Cannot::Empty,
      action => 'pop',
      what   => "array[$中]",
      "Trying to pop an empty $中 array dies";
    throws-like { @àсс.shift }, X::Cannot::Empty,
      action => 'shift',
      what   => "array[$中]",
      "Trying to shift an empty $中 array dies";

    is @àсс.push(42), (42,), "can push to $中 array";
    is @àсс.elems, 1, "push to $中 array works (1)";
    is @àсс[0], 42,   "push to $中 array works (2)";
    # https://github.com/Raku/old-issue-tracker/issues/4223
    throws-like { @àсс.push('it real good') }, X::TypeCheck,
      got => Str,
      "Cannot push non-int/Int to $中 array";
    throws-like { @àсс[0] := my $a }, Exception,
      "Cannot bind to $中 array";
    throws-like { @àсс[0]:delete }, Exception,
      "Cannot delete from $中 array";

    is (@àсс.push(101, 105)), (42,101,105),
      "can push multiple to $中 array";
    is @àсс.elems, 3, "push multiple to $中 array works (1)";
    is @àсс[1], 101,  "push multiple to $中 array works (2)";
    is @àсс[2], 105,  "push multiple to $中 array works (3)";
    throws-like { @àсс.push('omg', 'wtf') }, Exception,
      "Cannot push non-int/Int to $中 array (multiple push)";

    is @àсс.append(66), (42,101,105,66), "can append to $中 array";
    is @àсс.elems, 4, "append to $中 array works (1)";
    is @àсс[3], 66,  "append to $中 array works (2)";
    throws-like { @àсс.append('it real good') }, Exception,
      "Cannot append non-int/Int to $中 array";

    is (@àсс.append(21,25)), (42,101,105,66,21,25),
      "can append multiple to $中 array";
    is @àсс.elems, 6, "append multiple to $中 array works (1)";
    is @àсс[4], 21,  "append multiple to $中 array works (2)";
    is @àсс[5], 25,  "append multiple to $中 array works (3)";
    throws-like { @àсс.append('omg', 'wtf') }, Exception,
      "Cannot append non-int/Int to $中 array (multiple append)";

    is @àсс.pop, 25, "pop from $中 array works (1)";
    is @àсс.elems, 5, "pop from $中 array works (2)";

    is (@àсс.unshift(1)), (1,42,101,105,66,21),
      "can unshift to $中 array";
    is @àсс.elems, 6, "unshift to $中 array works (1)";
    is @àсс[0],  1,   "unshift to $中 array works (2)";
    is @àсс[1], 42,   "unshift to $中 array works (3)";
    # https://github.com/Raku/old-issue-tracker/issues/4223
    throws-like { @àсс.unshift('part of the day not working') }, Exception,
      "Cannot unshift non-int/Int to $中 array";

    is (@àсс.unshift(3,2)), (3,2,1,42,101,105,66,21),
      "can unshift multiple to $中 array";
    is @àсс.elems, 8, "unshift multiple to $中 array works (1)";
    is @àсс[0],  3,   "unshift multiple to $中 array works (2)";
    is @àсс[1],  2,   "unshift multiple to $中 array works (3)";
    is @àсс[2],  1,   "unshift multiple to $中 array works (4)";
    is @àсс[3], 42,   "unshift multiple to $中 array works (5)";
    throws-like { @àсс.unshift('wtf', 'bbq') }, Exception,
      "Cannot unshift non-int/Int to $中 array (multiple unshift)";

    is (@àсс.prepend(4)), (4,3,2,1,42,101,105,66,21),
      "can prepend to $中 array";
    is @àсс.elems, 9, "prepend to $中 array works (1)";
    is @àсс[0], 4,    "prepend to $中 array works (2)";
    is @àсс[1], 3,    "prepend to $中 array works (3)";
    throws-like { @àсс.prepend('part of the day not working') }, Exception,
      "Cannot prepend non-int/Int to $中 array";

    is (@àсс.prepend(6,5)), (6,5,4,3,2,1,42,101,105,66,21),
      "can prepend multiple to $中 array";
    is @àсс.elems, 11, "unshift multiple to $中 array works (1)";
    is @àсс[0], 6, "prepend multiple to $中 array works (2)";
    is @àсс[1], 5, "prepend multiple to $中 array works (3)";
    is @àсс[2], 4, "prepend multiple to $中 array works (4)";
    is @àсс[3], 3, "prepend multiple to $中 array works (5)";
    throws-like { @àсс.prepend('wtf', 'bbq') }, Exception,
      "Cannot prepend non-int/Int to $中 array (multiple unshift)";

    is @àсс.shift,  6, "shift from $中 array works (1)";
    is @àсс.elems, 10, "shift from $中 array works (2)";

    is (@àсс = 1..10), (1..10).List, "can initialize $中 from Range";
    my @сe̲𝐩лà개e̲𝐝 = @àсс.splice(3, 2, 98, 99, 100);
    is @àсс.elems, 11, "Number of elems after splice $中 array";
    is @àсс[2],   3, "Splice on $中 array did the right thing (1)";
    is @àсс[3],  98, "Splice on $中 array did the right thing (2)";
    is @àсс[4],  99, "Splice on $中 array did the right thing (3)";
    is @àсс[5], 100, "Splice on $中 array did the right thing (4)";
    is @àсс[6],   6, "Splice on $中 array did the right thing (5)";
    is @сe̲𝐩лà개e̲𝐝.elems, 2, "Number of returned spliced values from $中 array";
    is @сe̲𝐩лà개e̲𝐝[0], 4, "Correct value in splice returned from $中 array (1)";
    is @сe̲𝐩лà개e̲𝐝[1], 5, "Correct value in splice returned from $中 array (2)";

    @àсс = 1..5;
    is @àсс.Str,  '1 2 3 4 5', ".Str space-separates on $中 array";
    is @àсс.gist, '[1 2 3 4 5]', ".gist space-separates on $中 array";
    is @àсс.raku, "array[$中].new(1, 2, 3, 4, 5)",
      ".raku includes type and int values on $中 array";

    is-deeply @àсс[^2], array[$T].new(1,2), 'does slice return same type';
    is-deeply @àсс[my $ = ^2], 3, 'does slice handle containerized range';

    my &ftest := EVAL qq:!c/sub ftest($中 \$a, $中 \$b) { \$a + \$b }/;
    @àсс = 39, 3;
    is ftest(|@àсс), 42, "Flattening $中 array in call works";

    @àсс = ^5;
    is @àсс.join(":"), "0:1:2:3:4", "does join a $中 array";

    @àсс = ();
    @àсс[4] = 22;
    is @àсс.join(":"), "0:0:0:0:22", "does emptying a $中 array really empty";

    my @両갨лe̲ò := array[$T].new;
    @両갨лe̲ò[4] = 22;
    is @両갨лe̲ò.join(":"), "0:0:0:0:22", "does join handle holes in a $中 array";

    # Interaction of native int arrays and untyped arrays.
    my @丧à中갢𝐯e̲ := array[$T].new(1..10);
    my @갮丧中ù𝐩e̲𝐝 = @丧à中갢𝐯e̲;
    is @갮丧中ù𝐩e̲𝐝.elems, 10, "List-assigning $中 array to untyped works (1)";
    is @갮丧中ù𝐩e̲𝐝[0], 1, "List-assigning $中 array to untyped works (2)";
    is @갮丧中ù𝐩e̲𝐝[9], 10, "List-assigning $中 array to untyped works (3)";

    @갮丧中ù𝐩e̲𝐝 = flat 0, @丧à中갢𝐯e̲, 11;
    is @갮丧中ù𝐩e̲𝐝.elems, 12, "List-assign $中 array surrounded by literals (1)";
    is @갮丧中ù𝐩e̲𝐝[ 0],  0, "List-assign $中 array surrounded by literals (2)";
    is @갮丧中ù𝐩e̲𝐝[ 5],  5, "List-assign $中 array surrounded by literals (3)";
    is @갮丧中ù𝐩e̲𝐝[10], 10, "List-assign $中 array surrounded by literals (4)";
    is @갮丧中ù𝐩e̲𝐝[11], 11, "List-assign $中 array surrounded by literals (5)";

    my @갮丧中ù𝐩e̲𝐝2 = 21..30;
    my @丧à中갢𝐯e̲2 := array[$T].new;
    @丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2;
    is @丧à中갢𝐯e̲2.elems, 10, "List-assign untyped array of Int to $中 array (1)";
    is @丧à中갢𝐯e̲2[0], 21, "List-assign untyped array of Int to $中 array (2)";
    is @丧à中갢𝐯e̲2[9], 30, "List-assign untyped array of Int to $中 array (3)";

    @갮丧中ù𝐩e̲𝐝2.push('C-C-C-C-Combo Breaker!');
    throws-like { @丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2 }, Exception,
      "List-assigning incompatible untyped array to $中 array dies";

    my @òòà := array[$T].new(1..10);
    my @òò丛 := array[$T].new(1..10);
    is @òòà ~~ @òò丛, True, "Smartmatching same $中 arrays works";

    @òò丛.push(42);
    is @òòà ~~ @òò丛, False, "Smartmatching different $中 arrays works";

    my @갮丧ò갨с中e̲𝐝 := array[$T].new(4,5,1,2,3);
    is @갮丧ò갨с中e̲𝐝.sort, "1 2 3 4 5", "Can we sort $中 array";

    @갮丧ò갨с中e̲𝐝 = 1,2;
    is @갮丧ò갨с中e̲𝐝.sort, "1 2", "Can we sort 2-element sorted $中 array";

    @갮丧ò갨с中e̲𝐝 = 2,1;
    is @갮丧ò갨с中e̲𝐝.sort, "1 2", "Can we sort 2-element unsorted $中 array";

    @갮丧ò갨с中e̲𝐝 = 1;
    is @갮丧ò갨с中e̲𝐝.sort, "1", "Can we sort 1-element $中 array";

    @갮丧ò갨с中e̲𝐝 = ();
    is @갮丧ò갨с中e̲𝐝.sort, "", "Can we sort 0-element $中 array";
}

# https://github.com/Raku/old-issue-tracker/issues/3740
# some unsigned native int tests
for @갮갢丧中 -> $T {
    my $中 = $T.^name;
    diag "Testing $中 array for unsigned features";

    my @àсс := array[$T].new;
    is (@àсс[0] = -1), -1, "assigning -1 on $中 array passes value on through?";
    # DRY once the failing cases pass. RT #124088
    if $中 eq "uint" or $中 eq "uint64" {
        #?rakudo.jvm todo 'highest bit length stays negative, RT #124088'
        ok @àсс[0] > 0,        "negative value on $中 array becomes positive";
    }
    elsif $中 eq "uint32" {
        #?rakudo.js todo 'the js backend is 32bit so we get RT #124088 here'
        ok @àсс[0] > 0,        "negative value on $中 array becomes positive";
    } else {
        ok @àсс[0] > 0,        "negative value on $中 array becomes positive";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5941
dies-ok { my int @à = ^Inf; 42 }, 'Trying to assign ^Inf to an int array dies';

{
    my int @à = ^2_000_000;
    my $中両e̲丧 = now;
    my $сe̲ò갮л中1 = @à.sum;
    my $中갨갨k̲1 = now - $中両e̲丧;

    $中両e̲丧 = now;
    my $сe̲ò갮л中2 = @à.sum(:wrap);
    my $中갨갨k̲2 = now - $中両e̲丧;

    #?rakudo.js todo 'this does not work on 32bit backends'
    is $сe̲ò갮л中1, $сe̲ò갮л中2, "is $сe̲ò갮л中1 == $сe̲ò갮л中2";
}

# https://github.com/rakudo/rakudo/issues/2912
{
    my @à;
    @à[1] = 1;
    my int @b = @à;
    is-deeply @b, (my int @ = 0,1), 'did we survive the hole';
}

# https://github.com/rakudo/rakudo/issues/5781
{
    my int @à = 1,2,3;
    is-deeply (@à.first = 42), 42, "can we assign with '.first'";
    is-deeply @à.first, 42, "did the assign with '.first' work";

    is-deeply (@à.head = 666), 666, "can we assign with '.head'";
    is-deeply @à.head, 666, "did the assign with '.head' work";

    is-deeply (@à.tail = 137), 137, "can we assign with '.tail'";
    is-deeply @à.tail, 137, "did the assign with '.tail' work";

    is-deeply @à, (my int @ = 666,2,137), 'is the final array correct';
}

# vim: expandtab shiftwidth=4
