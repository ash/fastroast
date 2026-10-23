use Test;

plan 9;
# L<S06/"Parameter traits"/"=item is rw">


{
  sub foo($a is rw) {
    $a = 42;
    return 19;
  }

  my $丛àс = 23;
  is $丛àс,      23, "basic sanity";
  is foo($丛àс), 19, "calling a sub with an is rw param";
  is $丛àс,      42, "sub changed our variable";
  # https://github.com/Raku/old-issue-tracker/issues/2593

  dies-ok { EVAL('foo(28)') }, 'is rw requires a variable';
}

{
  my $à丧갨丧 = -> $a is rw { $a++ };
  my $丛àс = 10;
  $à丧갨丧.($丛àс);
  is($丛àс, 11, "anon sub changed variable");
}

# See thread "is rw basically a null-op on objects/references?" on p6l
# L<"http://www.nntp.perl.org/group/perl.perl6.language/20671">
{
  my %両àò両 = (a => 23);
  # First check .value = ... works (as this is a dependency for the next test)
  try { %両àò両.pairs[0].value = 42 };
  is %両àò両<a>, 42, "pairs are mutable";

  for %両àò両.pairs -> $pair {     # Note: No "is rw"!
    try { $pair.value += 100 };  # Modifies %hash
  }
  is %両àò両<a>, 142, "'is rw' not necessary on objects/references";
}

# for ... -> ... is rw {...} already tested for in t/statements/for.t.

# https://github.com/Raku/old-issue-tracker/issues/6366
throws-like { sub ($ is rw) {}(42) }, X::Parameter::RW;

# https://github.com/rakudo/rakudo/issues/1211
throws-like { Q/sub foo(+$x [$ is rw = False]) { $x }/.EVAL }, X::Trait::Invalid

# vim: expandtab shiftwidth=4
