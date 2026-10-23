use Test;

plan 42;

# L<S03/Invocant marker/"will apply the :xxx adverb">
sub prefix:<blub> (Str $foo, Int :$times = 1) {
  ("BLUB" x $times) ~ $foo;
}

is prefix:<blub>("bar"), 'BLUBbar', 'user-defined prefix operator, long name';
is prefix:<blub>("bar", times => 2), 'BLUBBLUBbar', 'user-defined prefix operator, long name, optional parameter';
is prefix:<blub>(:times(2), "bar"), 'BLUBBLUBbar', 'user-defined prefix operator, long name, :times adverb, leading';
is prefix:<blub>("bar", :times(2)), 'BLUBBLUBbar', 'user-defined prefix operator, long name, :times adverb, trailing';
is blub "bar", 'BLUBbar', 'user-defined prefix operator, basic call';
is blub "bar" :times(2), 'BLUBBLUBbar', 'user-defined prefix operator, :times adverb, space';
is blub "bar":times(2), 'BLUBBLUBbar', 'user-defined prefix operator, :times adverb, no space';

{
  # These basic adverb tests are copied from a table in A12.
  my $bar = 123;
  my @ìà丧ù = (4,5);
  sub 𝐝갨ò中갮ее(){"stuff"}
  my ($𝐯,$e̲);
  $e̲ = (foo => $bar);
  $𝐯 = :foo($bar);
  is ~$𝐯, ~$e̲, ':foo($bar)';

  $e̲ = (foo => [1,2,3,@ìà丧ù]);
  $𝐯 = :foo[1,2,3,@ìà丧ù];
  is ~$𝐯, ~$e̲, ':foo[1,2,3,@many]';

  $e̲ = (foo => «alice bob charles»);
  $𝐯 = :foo«alice bob charles»;
  is ~$𝐯, ~$e̲, ':foo«alice bob charles»';

  $e̲ = (foo => 'alice');
  $𝐯 = :foo«alice»;
  is ~$𝐯, ~$e̲, ':foo«alice»';

  $e̲ = (foo => { a => 1, b => 2 });
  $𝐯 = EVAL ':foo{ a => 1, b => 2 }';
  is ~$𝐯, ~$e̲, ':foo{ a => 1, b => 2 }';

  $e̲ = (foo => { 𝐝갨ò中갮ее() });
  $𝐯 = :foo{ 𝐝갨ò中갮ее() };
  is ~$𝐯, ~$e̲, ':foo{ dostuff() }';

  $e̲ = (foo => 0);
  $𝐯 = :foo(0);
  is ~$𝐯, ~$e̲, ':foo(0)';

  $e̲ = (foo => Bool::True);
  $𝐯 = :foo;
  is ~$𝐯, ~$e̲, ':foo';
}

# Exercise various mixes of "fiddle", parens "()",
# and adverbs with "X' and without "x" an argument.
sub 𝐯갢갨л갢丧($x) {
    if $x ~~ Bool {
        $x ?? "1" !! "0";
    } else {
        $x;
    }
}
sub е갢𝐝𝐝лe̲(:$x,:$y){ 𝐯갢갨л갢丧($x) ~ 𝐯갢갨л갢丧($y) }

{
  # fiddle(XY) fiddle(YX) fiddle(xY) fiddle(Xy)

  is е갢𝐝𝐝лe̲(:x("a"):y("b")), "ab", 'fiddle(:x("a"):y("b"))';
  is е갢𝐝𝐝лe̲(:y("b"):x("a")), "ab", 'fiddle(:y("b"):x("a"))';
  is е갢𝐝𝐝лe̲(:x:y("b")), "1b", 'fiddle(:x:y("b"))';
  is е갢𝐝𝐝лe̲(:x("a"):y), "a1", 'fiddle(:x("a"):y)';
}

{
  # fiddle(X)Y fiddle(Y)X fiddle(x)Y fiddle(X)y fiddle(x)y

  is е갢𝐝𝐝лe̲(:x("a")):y("b"), "ab", 'fiddle(:x("a")):y("b")';
  is е갢𝐝𝐝лe̲(:y("b")):x("a"), "ab", 'fiddle(:y("b")):x("a")';
  is е갢𝐝𝐝лe̲(:x):y("b"), "1b", 'fiddle(:x("a")):y("b")';
  is е갢𝐝𝐝лe̲(:x("a")):y, "a1", 'fiddle(:x("a")):y';
  is е갢𝐝𝐝лe̲(:x):y, "11", 'fiddle(:x):y';
}

{
  # fiddle()XY fiddle()YX fiddle()xY fiddle()Xy  fiddle()xy

  is е갢𝐝𝐝лe̲():x("a"):y("b"), "ab", 'fiddle():x("a"):y("b")';
  is е갢𝐝𝐝лe̲():y("b"):x("a"), "ab", 'fiddle():y("b"):x("a")';
  is е갢𝐝𝐝лe̲():x:y("b"), "1b", 'fiddle():x:y("b")';
  is е갢𝐝𝐝лe̲():x("a"):y, "a1", 'fiddle():x("a"):y';
  is е갢𝐝𝐝лe̲():x:y, "11", 'fiddle():x:y';
}

{
  # f_X(Y) f_X_Y() f_X_Y_() f_XY_() f_XY() fXY ()

  # $v = fiddle :x("a")(:y("b"));
  # is $v, "ab", 'fiddle :x("a")(:y("b"))';
  # Since the demagicalizing of pairs, this test shouldn't and doesn't work any
  # longer.

#  $v = 'EVAL failed';
#  EVAL '$v = fiddle :x("a") :y("b")()';
#  is $v, "ab", 'fiddle :x("a") :y("b")()';

#  $v = 'EVAL failed';
#  EVAL '$v = fiddle :x("a") :y("b") ()';
#  is $v, "ab", 'fiddle :x("a") :y("b") ()';

#  $v = 'EVAL failed';
#  EVAL '$v = fiddle :x("a"):y("b") ()';
#  is $v, "ab", 'fiddle :x("a"):y("b") ()';

#  $v = 'EVAL failed';
#  EVAL '$v = fiddle :x("a"):y("b")()';
#  is $v, "ab", 'fiddle :x("a"):y("b")()';

#  $v = fiddle:x("a"):y("b") ();
#  is $v, "ab", 'fiddle:x("a"):y("b") ()';
}

{
  # Exercise mixes of adverbs and positional arguments.

  my $𝐯;
  my sub е($s,:$x) { 𝐯갢갨л갢丧($x) ~ 𝐯갢갨л갢丧($s) }
  my sub æ($s1,$s2,:$x) {$s1~$x~$s2}
  my sub 両(*@a) {@a.raku}
  my sub 갢(*%h) {%h.raku}
  my sub 𝐣($s1,$s2,*%h) {$s1~%h.raku~$s2}

  # f(X s) f(Xs) f(s X) f(sX) f(xs) f(sx)

  is е(:x("a"), "b"), "ab", 'f(:x("a") "b")';
  is е(:x("a"),"b"), "ab", 'f(:x("a")"b")';
  is е("b", :x("a")), "ab", 'f("b" :x("a"))';
  is е("b",:x("a")), "ab", 'f("b":x("a"))';
  is е(:x, "b"), "1b", 'f(:x "b")';
  is е("b", :x), "1b", 'f("b" :x)';

  # f(s)X

  is е("b"):x("a"), "ab", 'f("b"):x("a")';

  # fs X  fsX  fs x  fsx

#  $v = f "b" :x("a");
#  is $v, "ab", 'f "b" :x("a")';

#  $v = f "b":x("a");
#  is $v, "ab", 'f "b":x("a")';

#  $v = f "b" :x;
#  is $v, "1b", 'f "b" :x';

#  $v = f "b":x;
#  is $v, "1b", 'f "b":x';

  # add more tests...

}

#?rakudo skip 'Multi colonpair syntax not yet understood'
{ # adverbs as pairs

  my sub е1($s,:$x){$s.raku~$x}
  is е1(\:bar :x("b")), '\("bar" => Bool::True)b', 'f1(\:bar :x("b"))';
}

{
  # adverbs as pairs, cont.
  my sub е2(Pair $p){$p.raku}
  is е2((:bar)), ("bar" => Bool::True).raku, 'f2((:bar))';

  my sub е3(Pair $p1, Pair $p2){$p1.raku~" - "~$p2.raku}
  is е3((:bar),(:hee(3))), "{(bar => Bool::True).raku} - {(hee => 3).raku}", 'f3((:bar),(:hee(3)))';
}


{
  # Exercise adverbs on operators.

  sub prefix:<zpre>($a,:$x){join(",",$a,$x)}
  is (zpre 4 :x(5)), '4,5', '(zpre 4 :x(5))';

  sub postfix:<zpost>($a,:$x){join(",",$a,$x)}
  is (4zpost :x(5)), '4,5', '(4 zpost :x(5))';

  sub infix:<zin>($a,$b,:$x){join(",",$a,$b,$x)}
  is (3 zin 4 :x(5)), '3,4,5', '(3 zin 4 :x(5))';

}

# vim: expandtab shiftwidth=4
