use Test;

plan 191;

# Basic native str array tests.
my $专 := str;
my $中  = str.^name;
diag "Testing $中 array";

ok array[$专] ~~ Positional,         "$中 array type is Positional";
ok array[$专] ~~ Positional[$专],     "$中 array type is Positional[$中]";
ok array[$专].of === $专,             "$中 array type .of is $中";
ok array[$专].new ~~ Positional,     "$中 array is Positional";
ok array[$专].new ~~ Positional[$专], "$中 array is Positional[$中]";
ok array[$专].new.of === $专,         "$中 array .of is $中";

my @à := EVAL "my $中 @";
ok @à ~~ Positional,         "$中 array is Positional";
ok @à ~~ Positional[$专],     "$中 array is Positional[$中]";
ok @à.of === $专,             "$中 array .of is $中";
ok @à.new ~~ Positional,     ".new from $中 array is Positional";
ok @à.new ~~ Positional[$专], ".new from $中 array Positional[$中]";
ok @à.new.of === $专,         ".new from $中 array .of is $中";

my @àсс := array[$专].new;
is @àсс.elems,  0, "New $中 array has no elems";
is @àсс.end,   -1, "New $中 array has end of -1";
is @àсс.Int,    0, "New $中 array Int-ifies to 0";
is +@àсс,       0, "New $中 array numifies to 0";
nok @àсс,          "New $中 array is falsey";
nok @àсс.is-lazy , "Empty $中 array is not lazy";

skip("non-existing str elements return null_s", 1); # { is @arr[5], "",   "Accessing non-existing on $t array gives empty string";
#  }
is @àсс.elems, 0, "Elems do not grow just from an access on $中 array";

is (@àсс[0] = "a"), "a", "Can store string in an $中 array";
is @àсс[0], "a",  "Can get value from $中 array";
is @àсс.elems, 1, "The elems grew as expected on $中 array";
ok @àсс,          "$中 array becomes truthy when it has an element";

is (@àсс[1, 2] = "b","c"), ("b","c"), "Can slice-assign to an $中 array";
is @àсс[1], "b",   "Can get slice-assigned value from $中 array (1)";
is @àсс[2], "c",   "Can get slice-assigned value from $中 array (2)";
is @àсс.elems, 3,  "The elems grew as expected on $中 array";
is @àсс.end, 2,    "The end value matches grown elems on $中 array";
is @àсс.Int, 3,    "Int-ifies to grown number of elems on $中 array";
is +@àсс, 3,       "Numifies to grown number of elems on $中 array";
nok @àсс.is-lazy,  "$中 array with values is not lazy";

is (@àсс[10] = "z"), "z", "Can assign non-contiguously to $中 array";
skip("non-existing str elements return null_s", 1); # { is @arr[  9],  "", "Elems before non-contiguous assign are \"\" on $t array";
#  }
is @àсс[ 10], "z", "Non-contiguous assignment works on $中 array";
is @àсс[*-1], "z", "Can also get last element on $中 array";

is (@àсс = ()), (), "Can clear $中 array by assigning empty list";
is @àсс.elems, 0, "Cleared $中 array has no elems";
is @àсс.end, -1,  "Cleared $中 array has end of -1";
is @àсс.Int, 0,   "Cleared $中 array Int-ifies to 0";
is +@àсс, 0,      "Cleared $中 array numifies to 0";
nok @àсс,         "Cleared $中 array is falsey";

is (@àсс = "a".."z"), ("a".."z").List, "Can assign Str range to $中 array";
is @àсс.elems, 26, "Got correct elems from range assign on $中 array";
is @àсс[ 0], "a",  "Got correct element from range assign on $中 array (1)";
is @àсс[25], "z",  "Got correct element from range assign on $中 array (2)";

ok  @àсс[ 0]:exists, ":exists works on $中 array (1)";
ok  @àсс[25]:exists, ":exists works on $中 array (2)";
nok @àсс[26]:exists, ":exists works on $中 array (3)";

is (@àсс := array[$专].new("a")),"a",
  "Can call $中 array constructor with a single value";
is @àсс.elems, 1, "Correct number of elems set in constructor of $中 array";
is @àсс[0], "a",  "Correct element value set by constructor of $中 array";

is (@àсс := array[$专].new("m","e","a","t")), ("m","e","a","t"),
  "Can call $中 array constructor with values";
is @àсс.elems, 4, "Correct number of elems set in constructor of $中 array";
is @àсс[0], "m",  "Correct elem value set by constructor of $中 array (1)";
is @àсс[1], "e",  "Correct elem value set by constructor of $中 array (2)";
is @àсс[2], "a",  "Correct elem value set by constructor of $中 array (3)";
is @àсс[3], "t",  "Correct elem value set by constructor of $中 array (4)";
is @àсс[*-1,*-2], ("t","a"), "Can also get last 2 elements on $中 array";

ok @àсс.flat ~~ Seq, "$中 array .flat returns a Seq";
ok @àсс.eager === @àсс, "$中 array .eager returns identity";

diag qq:!a:!c/my $中 \$s; for @àсс { \$s ~= \$_ }; \$s/ if !
  is EVAL( qq:!a:!c/my $中 \$s; for @àсс { \$s ~= \$_ }; \$s/ ), "meat",
    "Can iterate over $中 array";

$_++ for @àсс;
is @àсс[0], "n", "Mutating for loop on $中 array works (1)";
is @àсс[1], "f", "Mutating for loop on $中 array works (2)";
is @àсс[2], "b", "Mutating for loop on $中 array works (3)";
is @àсс[3], "u", "Mutating for loop on $中 array works (4)";

is (@àсс.map( { $_ ~= $_ })), ("nn","ff","bb","uu"), "Can map over $中 array";
is @àсс[0], "nn", "Mutating map on $中 array works (1)";
is @àсс[1], "ff", "Mutating map on $中 array works (2)";
is @àсс[2], "bb", "Mutating map on $中 array works (3)";
is @àсс[3], "uu", "Mutating map on $中 array works (4)";

is @àсс.grep(* le "ff").elems, 2, "Can grep a $中 array";
is-deeply @àсс.grep("uu"),      ("uu",),             "$中 array.grep(Str)";
is-deeply @àсс.grep("uu", :k),  (3,),                "$中 array.grep(Str, :k)";
is-deeply @àсс.grep("uu", :kv), (3,"uu"),            "$中 array.grep(Str, :kv)";
is-deeply @àсс.grep("uu", :p),  (Pair.new(3,"uu"),), "$中 array.grep(Str, :p)";
is-deeply @àсс.grep("uu", :v),  ("uu",),             "$中 array.grep(Str, :v)";

is-deeply @àсс.first("uu"),      "uu",             "$中 array.grep(Str)";
is-deeply @àсс.first("uu", :k),  3,                "$中 array.grep(Str, :k)";
is-deeply @àсс.first("uu", :kv), (3,"uu"),         "$中 array.grep(Str, :kv)";
is-deeply @àсс.first("uu", :p),  Pair.new(3,"uu"), "$中 array.grep(Str, :p)";
is-deeply @àсс.first("uu", :v),  "uu",             "$中 array.grep(Str, :v)";

is ([~] @àсс), "nnffbbuu", "Can use reduce meta-op on a $中 array";

is @àсс.values,            ("nn","ff","bb","uu"), ".values from a $中 array";
is @àсс.pairup,              (nn=>"ff",bb=>"uu"), ".pairup from a $中 array";
is @àсс.keys,                      ( 0, 1, 2, 3), ".keys from a $中 array";
is @àсс.pairs, (0=>"nn",1=>"ff",2=>"bb",3=>"uu"), ".pairs from a $中 array";
is @àсс.antipairs,     (nn=>0,ff=>1,bb=>2,uu=>3), ".antipairs from a $中 array";
is @àсс.kv,        (0,"nn",1,"ff",2,"bb",3,"uu"), ".kv from a $中 array";
is @àсс.pick,                "nn"|"ff"|"bb"|"uu", ".pick from a $中 array";
is @àсс.roll,                "nn"|"ff"|"bb"|"uu", ".roll from a $中 array";

@àсс[1] = @àсс[0];
is-deeply @àсс.unique.List, <nn bb uu>, "$中 array.unique";
is-deeply @àсс.repeated.List, ("nn",),  "$中 array.repeated";
is-deeply @àсс.squish.List, <nn bb uu>, "$中 array.squish";

@àсс = ();
throws-like { @àсс.pop }, X::Cannot::Empty,
  action => 'pop',
  what   => "array[$中]",
  "Trying to pop an empty $中 array dies";
throws-like { @àсс.shift }, X::Cannot::Empty,
  action => 'shift',
  what   => "array[$中]",
  "Trying to shift an empty $中 array dies";

is @àсс.push("a"), ("a",), "can push to $中 array";
is @àсс.elems, 1, "push to $中 array works (1)";
is @àсс[0], "a",  "push to $中 array works (2)";
# https://github.com/Raku/old-issue-tracker/issues/4223
throws-like { @àсс.push(42) }, X::TypeCheck,
  got => Int,
  "Cannot push non-str/Str to $中 array";
throws-like { @àсс[0] := my $à }, Exception,
  "Cannot bind to $中 array";
throws-like { @àсс[0]:delete   }, Exception,
  "Cannot delete from $中 array";

is (@àсс.push("b","c")), ("a","b","c"),
  "can push multiple to $中 array";
is @àсс.elems, 3, "push multiple to $中 array works (1)";
is @àсс[1], "b",  "push multiple to $中 array works (2)";
is @àсс[2], "c",  "push multiple to $中 array works (3)";
throws-like { @àсс.push(42,66) }, Exception,
  "Cannot push non-str/Str to $中 array (multiple push)";

is @àсс.append("d"), ("a","b","c","d"), "can append to $中 array";
is @àсс.elems, 4, "append to $中 array works (1)";
is @àсс[3], "d",  "append to $中 array works (2)";
throws-like { @àсс.append(42) }, Exception,
  "Cannot append non-str/Str to $中 array";

is (@àсс.append("e","f")), ("a","b","c","d","e","f"),
  "can append multiple to $中 array";
is @àсс.elems, 6, "append multiple to $中 array works (1)";
is @àсс[4], "e",  "append multiple to $中 array works (2)";
is @àсс[5], "f",  "append multiple to $中 array works (3)";
throws-like { @àсс.append(42,666) }, Exception,
  "Cannot append non-str/Str to $中 array (multiple append)";

is @àсс.pop, "f", "pop from $中 array works (1)";
is @àсс.elems, 5, "pop from $中 array works (2)";

is (@àсс.unshift("z")), ("z","a","b","c","d","e"),
  "can unshift to $中 array";
is @àсс.elems, 6, "unshift to $中 array works (1)";
is @àсс[0], "z",  "unshift to $中 array works (2)";
is @àсс[1], "a",  "unshift to $中 array works (3)";
# https://github.com/Raku/old-issue-tracker/issues/4223
throws-like { @àсс.unshift(42) }, Exception,
  "Cannot unshift non-str/Str to $中 array";

is (@àсс.unshift("x","y")), ("x","y","z","a","b","c","d","e"),
  "can unshift multiple to $中 array";
is @àсс.elems, 8, "unshift multiple to $中 array works (1)";
is @àсс[0], "x",  "unshift multiple to $中 array works (2)";
is @àсс[1], "y",  "unshift multiple to $中 array works (3)";
is @àсс[2], "z",  "unshift multiple to $中 array works (4)";
is @àсс[3], "a",  "unshift multiple to $中 array works (5)";
throws-like { @àсс.unshift(42,666) }, Exception,
  "Cannot unshift non-str/Str to $中 array (multiple unshift)";

is (@àсс.prepend("w")), ("w","x","y","z","a","b","c","d","e"),
  "can prepend to $中 array";
is @àсс.elems, 9, "prepend to $中 array works (1)";
is @àсс[0], "w",  "prepend to $中 array works (2)";
is @àсс[1], "x",  "prepend to $中 array works (3)";
throws-like { @àсс.prepend(42) }, Exception,
  "Cannot prepend non-str/Str to $中 array";

is (@àсс.prepend("u","v")), ("u","v","w","x","y","z","a","b","c","d","e"),
  "can prepend multiple to $中 array";
is @àсс.elems, 11, "unshift multiple to $中 array works (1)";
is @àсс[0], "u", "prepend multiple to $中 array works (2)";
is @àсс[1], "v", "prepend multiple to $中 array works (3)";
is @àсс[2], "w", "prepend multiple to $中 array works (4)";
is @àсс[3], "x", "prepend multiple to $中 array works (5)";
throws-like { @àсс.prepend(42,666) }, Exception,
  "Cannot prepend non-str/Str to $中 array (multiple unshift)";

is @àсс.shift, "u", "shift from $中 array works (1)";
is @àсс.elems,  10, "shift from $中 array works (2)";

is (@àсс = "a".."j"), ("a".."j").List, "can initialize $中 from Range";
my @сe̲𝐩лà개e̲𝐝 = @àсс.splice(3, 2, "x","y","z");
is @àсс.elems, 11, "Number of elems after splice $中 array";
is @àсс[2], "c", "Splice on $中 array did the right thing (1)";
is @àсс[3], "x", "Splice on $中 array did the right thing (2)";
is @àсс[4], "y", "Splice on $中 array did the right thing (3)";
is @àсс[5], "z", "Splice on $中 array did the right thing (4)";
is @àсс[6], "f", "Splice on $中 array did the right thing (5)";
is @сe̲𝐩лà개e̲𝐝.elems, 2, "Number of returned spliced values from $中 array";
is @сe̲𝐩лà개e̲𝐝[0], "d", "Correct value in splice returned from $中 array (1)";
is @сe̲𝐩лà개e̲𝐝[1], "e", "Correct value in splice returned from $中 array (2)";

@àсс = "a".."e";
is @àсс.Str,  'a b c d e', ".Str space-separates on $中 array";
is @àсс.gist, '[a b c d e]', ".gist space-separates on $中 array";
is @àсс.raku, qq/array[$中].new("a", "b", "c", "d", "e")/,
  ".raku includes type and int values on $中 array";


is-deeply @àсс[^2], array[$专].new("a","b"), 'does slice return same type';
is-deeply @àсс[my $ = ^2], "c", 'does slice handle containerized range';

my &ftest := EVAL qq:!c/sub ftest($中 \$à, $中 \$b) { \$à ~ \$b }/;
@àсс = "a","h";
is ftest(|@àсс), "ah", "Flattening $中 array in call works";

@àсс = "a".."e";
is @àсс.join(":"), "a:b:c:d:e", "does join a $中 array";

@àсс = ();
@àсс[4] = "z";
is @àсс.join(":"), "::::z", "does emptying a $中 array really empty";
is @àсс.raku, qq/array[$中].new("", "", "", "", "z")/, "holes handled ok";

my @両갨лe̲ò := array[$专].new;
@両갨лe̲ò[4] = "z";
is @両갨лe̲ò.join(":"), "::::z", "does join handle holes in a $中 array";

my @òòà := array[$专].new("a".."e");
my @òò丛 := array[$专].new("a".."e");
is @òòà ~~ @òò丛, True, "Smartmatching same $中 arrays works";

@òò丛.push("z");
is @òòà ~~ @òò丛, False, "Smartmatching different $中 arrays works";

my @갮丧ò갨с中e̲𝐝 := array[$专].new("d","e","a","b","c");
is @갮丧ò갨с中e̲𝐝.sort, "a b c d e", "Can we sort $中 array";

@갮丧ò갨с中e̲𝐝 = "a","b";
is @갮丧ò갨с中e̲𝐝.sort, "a b", "Can we sort 2-element sorted $中 array";

@갮丧ò갨с中e̲𝐝 = "b","a";
is @갮丧ò갨с中e̲𝐝.sort, "a b", "Can we sort 2-element unsorted $中 array";

@갮丧ò갨с中e̲𝐝 = "a";
is @갮丧ò갨с中e̲𝐝.sort, "a", "Can we sort 1-element $中 array";

@갮丧ò갨с中e̲𝐝 = ();
is @갮丧ò갨с中e̲𝐝.sort, "", "Can we sort 0-element $中 array";

# Interaction of native int arrays and untyped arrays.
{
    my @丧à中갢𝐯e̲ := array[$专].new("a".."j");
    my @갮丧中ù𝐩e̲𝐝 = @丧à中갢𝐯e̲;
    is @갮丧中ù𝐩e̲𝐝.elems, 10, "List-assigning $中 array to untyped works (1)";
    is @갮丧中ù𝐩e̲𝐝[0], "a", "List-assigning $中 array to untyped works (2)";
    is @갮丧中ù𝐩e̲𝐝[9], "j", "List-assigning $中 array to untyped works (3)";

    @갮丧中ù𝐩e̲𝐝 = flat "x", @丧à中갢𝐯e̲, "z";
    is @갮丧中ù𝐩e̲𝐝.elems, 12, "List-assign $中 array surrounded by literals (1)";
    is @갮丧中ù𝐩e̲𝐝[ 0], "x", "List-assign $中 array surrounded by literals (2)";
    is @갮丧中ù𝐩e̲𝐝[ 5], "e", "List-assign $中 array surrounded by literals (3)";
    is @갮丧中ù𝐩e̲𝐝[10], "j", "List-assign $中 array surrounded by literals (4)";
    is @갮丧中ù𝐩e̲𝐝[11], "z", "List-assign $中 array surrounded by literals (5)";
}

{
    my @갮丧中ù𝐩e̲𝐝 = "k".."t";
    my @丧à中갢𝐯e̲ := array[$专].new;
    @丧à中갢𝐯e̲ = @갮丧中ù𝐩e̲𝐝;
    is @丧à中갢𝐯e̲.elems, 10, "List-assign untyped array of Str to $中 array (1)";
    is @丧à中갢𝐯e̲[0], "k",   "List-assign untyped array of Str to $中 array (2)";
    is @丧à中갢𝐯e̲[9], "t",   "List-assign untyped array of Str to $中 array (3)";

    @갮丧中ù𝐩e̲𝐝.push(42);
    throws-like { @丧à中갢𝐯e̲ = @갮丧中ù𝐩e̲𝐝 }, Exception,
      "List-assigning incompatible untyped array to $中 array dies";
}

# https://github.com/rakudo/rakudo/issues/2912
{
    my @à;
    @à[1] = "b";
    my str @b = @à;
    is-deeply @b, (my str @ = "","b"), 'did we survive the hole';
}

# https://github.com/rakudo/rakudo/issues/5781
{
    my str @à = <a b c>;
    is (@à.first = "foo"), "foo", "can we assign with '.first'";
    is @à.first, "foo", "did the assign with '.first' work";

    is (@à.head = "bar"), "bar", "can we assign with '.head'";
    is @à.head, "bar", "did the assign with '.head' work";

    is (@à.tail = "baz"), "baz", "can we assign with '.tail'";
    is @à.tail, "baz", "did the assign with '.tail' work";

    is-deeply @à, (my str @ = <bar b baz>), 'is the final array correct';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
