use Test;

plan 112;

# Basic native str array tests.
my $专 := str;
my $中  = $专.^name;
diag "Testing $中 array";

ok array[$专].new(:shape(5)) ~~ Positional,     "$中 array is Positional";
todo('apparently it is not a typed Positional'); ok array[$专].new(:shape(5)) ~~ Positional[$专], "$中 array is Positional[$中]";
ok array[$专].new(:shape(5)).of === $专,         "$中 array .of is $中";

my @à := EVAL "my $中 @[5]";
ok @à ~~ Positional,         "$中 array is Positional";
todo('apparently it is not a typed Positional'); ok @à ~~ Positional[$专],     "$中 array is Positional[$中]";
ok @à.of === $专,             "$中 array .of is $中";
ok @à.new ~~ Positional,     ".new from $中 array is Positional";
todo('apparently it is not a typed Positional'); ok @à.new ~~ Positional[$专], ".new from $中 array Positional[$中]";
ok @à.new.of === $专,         ".new from $中 array .of is $中";

my @àсс := array[$专].new(:shape(5));
is @àсс.elems,  5, "New $中 array has 5 elems";
is @àсс.end,    4, "New $中 array has end of -1";
is @àсс.Int,    5, "New $中 array Int-ifies to 5";
is +@àсс,       5, "New $中 array numifies to 5";
nok @àсс.is-lazy , "Empty $中 array is not lazy";

dies-ok { @àсс[5] }, "Accessing non-existing on $中 array dies";
is @àсс.elems, 5, "Elems do not grow just from an access on $中 array";

is (@àсс[0] = "b"), "b", "Can store string in an $中 array with Int index";
is @àсс[0], "b", "Can get value from $中 array with Int index";

my int $i;
is (@àсс[$i] = "a"), "a", 'can store string in an $t array with int index';
is @àсс[$i], "a", "Can get value from $中 array with int index";

is (@àсс[1, 2] = "b","c"), ("b","c"), "Can slice-assign to an $中 array";
is @àсс[1], "b", "Can get slice-assigned value from $中 array (1)";
is @àсс[2], "c", "Can get slice-assigned value from $中 array (2)";

ok  @àсс[$i]:exists, ":exists works on $中 array with int index";
ok  @àсс[4]:exists, ":exists works on $中 array with Int index";
nok @àсс[5]:exists, ":exists works on $中 array when out of range";

nok @àсс[$i]:!exists, ":!exists works on $中 array with int index";
nok @àсс[4]:!exists, ":!exists works on $中 array with Int index";
ok  @àсс[5]:!exists, ":!exists works on $中 array when out of range";

dies-ok { @àсс[$i]:delete }, ":delete dies on $中 array with int index";
dies-ok { @àсс[0]:delete }, ":delete dies on $中 array with Int index";
is @àсс[$i]:!delete, "a", ":!delete works on $中 array with int index";
is @àсс[0]:!delete, "a", ":!delete works on $中 array with Int index";

is (@àсс := array[$专].new(:shape(1), "foo")), "foo",
  "Can call $中 array constructor with a single value";
is @àсс.elems, 1, "Correct number of elems set in constructor of $中 array";
is @àсс[0], "foo",   "Correct element value set by constructor of $中 array";

is (@àсс := array[$专].new(:shape(4),"m","e","a","t")), ("m","e","a","t"),
  "Can call $中 array constructor with values";
is @àсс.elems, 4, "Correct number of elems set in constructor of $中 array";
is @àсс[0], "m",   "Correct elem value set by constructor of $中 array (1)";
is @àсс[1], "e",   "Correct elem value set by constructor of $中 array (2)";
is @àсс[2], "a",   "Correct elem value set by constructor of $中 array (3)";
is @àсс[3], "t",   "Correct elem value set by constructor of $中 array (4)";
is @àсс[*-1,*-2], ("t","a"), "Can also get last 2 elements on $中 array";

ok @àсс.flat ~~ Seq, "$中 array .flat returns a Seq";
ok @àсс.eager === @àсс, "$中 array .eager returns identity";

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

is @àсс.grep(* le "ff").elems, 2, "grep a $中 array";
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

is @àсс.values,                ("nn","ff","bb","uu"), ".values from a $中 array";
is @àсс.pairup,                  (nn=>"ff",bb=>"uu"), ".pairup from a $中 array";
is @àсс.keys,                          ( 0, 1, 2, 3), ".keys from a $中 array";
is @àсс.pairs,     (0=>"nn",1=>"ff",2=>"bb",3=>"uu"), ".pairs from a $中 array";
is @àсс.antipairs,         (nn=>0,ff=>1,bb=>2,uu=>3), ".antipairs from a $中 array";
is @àсс.kv,            (0,"nn",1,"ff",2,"bb",3,"uu"), ".kv from a $中 array";
is @àсс.pick,                    "nn"|"ff"|"bb"|"uu", ".pick from a $中 array";
is @àсс.roll,                    "nn"|"ff"|"bb"|"uu", ".roll from a $中 array";

@àсс[1] = @àсс[0];
is-deeply @àсс.unique.List, <nn bb uu>, "$中 array.unique";
is-deeply @àсс.repeated.List, ("nn",),    "$中 array.repeated";
is-deeply @àсс.squish.List, <nn bb uu>, "$中 array.squish";

dies-ok { @àсс.pop },         "Trying to pop a shaped $中 array dies";
dies-ok { @àсс.shift },       "Trying to shift a shaped $中 array dies";
dies-ok { @àсс.push(42) },    "Trying to push a shaped $中 array dies";
dies-ok { @àсс.unshift(42) }, "Trying to unshift a shaped $中 array dies";
dies-ok { @àсс[0] := my $à }, "Cannot bind to a $中 array";
dies-ok { @àсс[0]:delete },   "Cannot delete from a $中 array";
dies-ok { @àсс.append(66) },  "Cannot append to a $中 array";
dies-ok { @àсс.prepend(66) }, "Cannot prepend to a $中 array";
dies-ok { @àсс.splice },      "Cannot splice to a $中 array";

@àсс = "a" .. "d";
is @àсс.Str,  'a b c d',   ".Str space-separates on $中 array";
is @àсс.gist, '[a b c d]', ".gist space-separates on $中 array";
is @àсс.raku, qq/array[$中].new(:shape(4,), ["a", "b", "c", "d"])/,
  ".raku includes type and str values on $中 array";

skip('STORE not working correctly yet)', 1); # { is-deeply @arr[^2], <a b>, 'does slice return correctly';
#  }
is-deeply @àсс[my $ = ^2], "c", 'does slice handle containerized range';

is @àсс.join(":"), "a:b:c:d", "does join a $中 array";

is (@àсс = ()), "   ", "Can clear $中 array by assigning empty list";
is @àсс.join(":"), ":::", "does emptying a $中 array reset";
@àсс = "a","b";
is @àсс.join(":"), "a:b::", "does re-initializing a $中 array work";

# Interaction of native shaped str arrays and untyped arrays.
my @丧à中갢𝐯e̲ := array[$专].new(:shape(10),"a".."j");
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

my @갮丧中ù𝐩e̲𝐝2 = "g".."p";
my @丧à中갢𝐯e̲2 := array[$专].new(:shape(10));
@丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2;
is @丧à中갢𝐯e̲2.elems, 10, "List-assign untyped array of Str to $中 array (1)";
is @丧à中갢𝐯e̲2[0], "g", "List-assign untyped array of Str to $中 array (2)";
is @丧à中갢𝐯e̲2[9], "p", "List-assign untyped array of Str to $中 array (3)";

@갮丧中ù𝐩e̲𝐝2[9] = 666;
throws-like { @丧à中갢𝐯e̲2 = @갮丧中ù𝐩e̲𝐝2 }, Exception,
  "List-assigning incompatible untyped array to $中 array dies";

my @òòà := array[$专].new(:shape(10),"a".."j");
my @òò丛 := array[$专].new(:shape(10),"a".."j");
is @òòà ~~ @òò丛, True, "Smartmatching same $中 arrays works";

is array[$专].new(:shape(5),"d","e","a","b","c").sort, "a b c d e",
  "Can we sort $中 array";

is array[$专].new(:shape(2),"b","a").sort, "a b",
  "Can we sort 2-element sorted $中 array";

is array[$专].new(:shape(1),"a").sort, "a",
  "Can we sort 1-element sorted $中 array";

# https://github.com/rakudo/rakudo/issues/4363
lives-ok { my str @à[1]; my str @b[1]; @à = @b; @à.gist },
  "does copying from an uninitialized shaped str array work";

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
