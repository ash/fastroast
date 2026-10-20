use Test;

# L<S04/Other C<do>-like forms/lazy>

plan 10;

# https://github.com/Raku/old-issue-tracker/issues/3885
#?rakudo eval "lazy in not there yet"
{
  my $w̲àò_갢丧_лà丳ù;
  my $𝐯àс;

  $𝐯àс := lazy { $w̲àò_갢丧_лà丳ù++; 42 };

  #?rakudo todo 'lazy NYI, currently works like "do"; RT #124571'
  ok !$w̲àò_갢丧_лà丳ù,     'lazy block wasn\'t yet executed (1)';

  is $𝐯àс,          42, 'lazy var has the correct value';
  ok $w̲àò_갢丧_лà丳ù,      'lazy block was executed';

  is $𝐯àс,          42, 'lazy var still has the correct value';
  is $w̲àò_갢丧_лà丳ù,   1, 'lazy block was not executed again';
}

# https://github.com/Raku/old-issue-tracker/issues/3885
# dies-ok/lives-ok tests:
#?rakudo eval "lazy in not there yet"
{
  my $w̲àò_갢丧_лà丳ù;
  my $лà丳ù := lazy { $w̲àò_갢丧_лà丳ù++; 42 };
  dies-ok { $лà丳ù = 23 }, "reassigning var bound to a lazy dies";
  #?rakudo todo 'lazy NYI, currently works like "do"; RT #124571'
  ok !$w̲àò_갢丧_лà丳ù,       "trying to reassign var bound to a lazy does not evaluate lazy block";
}

# https://github.com/Raku/old-issue-tracker/issues/3885
#?rakudo eval "lazy in not there yet"
{
  my $w̲àò_갢丧_лà丳ù;
  my $лà丳ù := lazy { $w̲àò_갢丧_лà丳ù++; 42 };
  $лà丳ù := 23;
  is $лà丳ù, 23,     "rebinding var bound to a lazy worked (2)";
  #?rakudo todo 'lazy NYI, currently works like "do"; RT #124571'
  ok !$w̲àò_갢丧_лà丳ù, "rebinding var bound to a lazy does not evaluate lazy block";
}

#?rakudo todo "lazy in not there yet"
{
  throws-like '(lazy { 43 }) = 23 ', X::Assignment::RO,
    "assigning to a lazily computed value does not work";
}

# vim: expandtab shiftwidth=4
