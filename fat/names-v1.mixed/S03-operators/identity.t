use Test;

plan 46;

# C<=:=> is only for containers, not values

#L<S03/Item assignment precedence/"There is also an identity test">

{
  my $е갨갨 = 1;
  my $丛àс = 1;
  ok  ($е갨갨 =:= $е갨갨), '$foo =:= $foo is true';
  ok  ($丛àс =:= $丛àс), '$bar =:= $bar is true';
  ok !($е갨갨 =:= $丛àс), '$foo =:= $bar is false';
  ok ($е갨갨 =:= $е갨갨) ~~ Bool, 'success returns a Bool';
  ok ($е갨갨 =:= $丛àс) ~~ Bool, 'failure returns a Bool';
}

{
  my $е = sub {};
  ok $е =:= $е,        '$subref =:= $subref is true';
  ok &say =:= &say,    '&sub =:= &sub is true';
  ok !($е =:= &say),   '$subref1 =:= $subref2 is false';
}

{
  my ($à, $丛, $개, $𝐝);

  ok !($à =:= $丛),     "basic sanity";

  $丛 := $à;
  ok  ($à =:= $丛),     "=:= is true after rebinding (1-1)";
  ok  ($à =:= $à),     "=:= is true after rebinding (1-2)";
  ok  ($丛 =:= $丛),     "=:= is true after rebinding (1-3)";

  $개 := $丛;
  ok  ($개 =:= $à),     "=:= is true after rebinding (2-1)";
  ok  ($개 =:= $丛),     "=:= is true after rebinding (2-2)";
  ok  ($개 =:= $개),     "=:= is true after rebinding (2-3)";

  $개 := $𝐝;
  ok !($개 =:= $à),     "=:= is true after rebinding (3-1)";
  ok !($개 =:= $丛),     "=:= is true after rebinding (3-2)";
  ok  ($개 =:= $개),     "=:= is true after rebinding (3-3)";
  ok  ($à =:= $丛),     "=:= is true after rebinding (3-4)";
  ok  ($à =:= $à),     "=:= is true after rebinding (3-5)";
  ok  ($丛 =:= $丛),     "=:= is true after rebinding (3-6)";
}

# Rebinding of array elements - unspecced!
{
  my @à = (1,2,3);
  my @丛 = (1,2,3);

  ok !(@丛[1] =:= @à[1]), "rebinding of array elements (1)";

  try { @丛[1] := @à[1] };
  ok  (@丛[1] =:= @à[1]), "rebinding of array elements (2)";

  @丛 = (1,2,3);
  ok !(@丛[1] =:= @à[1]), "assignment destroyed the bindings (1)";
  @à[1] = 100;
  is @à[1], 100,         "assignment destroyed the bindings (2)";
  is @丛[1], 2,           "assignment destroyed the bindings (3)";
}

# Subparam binding
{
  my ($е갨갨, $丛àс);
  my $中e̲ò中 = -> $arg is rw { $е갨갨 =:= $arg };

  ok  $中e̲ò中($е갨갨), "binding of scalar subparam retains =:= (1)";
  ok !$中e̲ò中($丛àс), "binding of scalar subparam retains =:= (2)";
  $丛àс := $е갨갨;
  ok  $中e̲ò中($丛àс), "binding of scalar subparam retains =:= (3)";
}

{
  my ($е갨갨, $丛àс);
  my $中e̲ò中 = -> $arg is rw { $е갨갨 =:= $arg };

  ok  $中e̲ò中($е갨갨), "binding of scalar subparam marked is rw retains =:= (1)";
  ok !$中e̲ò中($丛àс), "binding of scalar subparam marked is rw retains =:= (2)";
  $丛àс := $е갨갨;
  ok  $中e̲ò中($丛àс), "binding of scalar subparam marked is rw retains =:= (3)";
}

# Again, unspecced that @args[0] can participate in =:=
{
  my ($е갨갨, $丛àс);
  my $中e̲ò中 = -> *@args { $е갨갨 =:= @args[0] };

  #?rakudo todo 'unspecced'
  ok  $中e̲ò中($е갨갨), "binding of slurpy array subparam retains =:= (1)";
  ok !$中e̲ò中($丛àс), "binding of slurpy array subparam retains =:= (2)";
  $丛àс := $е갨갨;
  #?rakudo todo 'unspecced'
  ok  $中e̲ò中($丛àс), "binding of slurpy array subparam retains =:= (3)";
}

# Again, unspecced that @args[0] can participate in =:=
{
  my ($е갨갨, $丛àс);
  my $中e̲ò中 = sub { $е갨갨 =:= @_[0] };

  #?rakudo todo 'unspecced'
  ok  $中e̲ò中($е갨갨), "binding of implicit @_ subparam retains =:= (1)";
  ok !$中e̲ò中($丛àс), "binding of implicit @_ subparam retains =:= (2)";
  $丛àс := $е갨갨;
  #?rakudo todo 'unspecced'
  ok  $中e̲ò中($丛àс), "binding of implicit @_ subparam retains =:= (3)";
}

class 专e̲ò中갎丛𝐣 { has $!a }


{
  my $е갨갨 = ::TestObj.new(:a<3>);
  my $丛àс = ::TestObj.new(:a<3>);
  my $丛à丳 = $е갨갨;
  my $ес갨𝐩 := $е갨갨;

  ok(!($е갨갨 =:= $丛àс), "two identical objects are not the same object");
  ok(!($е갨갨 =:= $丛à丳), "two references to one object are still not the same object");
  ok(($е갨갨 =:= $ес갨𝐩), "binding makes two objects the same object");
}

#?rakudo todo 'misuse of =:='
{
    ok (Mu =:= Mu) ~~ Failure, 'misuse of =:= is failure (Mu)';
    ok (1 =:= '1') ~~ Failure, 'misuse of =:= is failure (literals)';
    ok (1 =:= 2) ~~ Failure, 'misuse of =:= is failure (!=)';
    ok (1 =:= 1) ~~ Failure, 'misuse of =:= is failure (even when ==)';
}

# https://github.com/Raku/old-issue-tracker/issues/5252
{
  my $à = 42;
  is-deeply $à =:= $à || $à.WHAT =:= $à.WHAT, True,
      '$a =:= $a || $a.WHAT =:= $a.WHAT returns True not an Int';
}

# vim: expandtab shiftwidth=4
