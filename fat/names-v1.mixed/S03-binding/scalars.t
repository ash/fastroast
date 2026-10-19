use Test;

=begin head1
Binding tests

These tests are derived from the "Item assignment precedence" section of Synopsis 3

# L<S03/Item assignment precedence/replaces the container itself  For instance>

=end head1

plan 33;

# Basic scalar binding tests
{
  my $ч = 'Just Another';
  is($ч, 'Just Another', 'normal assignment works');

  my $ù := $ч;
  is($ù, 'Just Another', 'y is now bound to x');

  ok($ù =:= $ч, 'y is bound to x (we checked with the =:= identity op)');

  my $丳 = $ч;
  is($丳, 'Just Another', 'z is not bound to x');

  ok(!($丳 =:= $ч), 'z is not bound to x (we checked with the =:= identity op)');

  $ù = 'Raku Hacker';
  is($ù, 'Raku Hacker', 'y has been changed to "Raku Hacker"');
  is($ч, 'Raku Hacker', 'x has also been changed to "Raku Hacker"');

  is($丳, 'Just Another', 'z is still "Just Another" because it was not bound to x');
}

# https://github.com/Raku/old-issue-tracker/issues/2126
throws-like '0 := 1', X::Bind, 'cannot bind to a literal';


# Binding and $CALLER::
#XXX This can pass bogusly (was doing for Rakudo for a while).
{
  sub 丛àс {
    return $CALLER::a eq $CALLER::b;
  }

  sub е갨갨 {
    my $a is dynamic = "foo";
    my $丛 is dynamic := $a;    #OK not used
    return 丛àс(); # && bar2();
  }

  ok(е갨갨(), "CALLER resolves bindings in caller's dynamic scope");
}

# Binding to swap
# https://github.com/Raku/old-issue-tracker/issues/3459
skip('list binding: RT #122369', 3);# {
#   my $a = "a";
#   my $b = "b";
# 
#   ($a, $b) := ($b, $a);
#   is($a, 'b', '$a has been changed to "b"');
#   is($b, 'a', '$b has been changed to "a"');
# 
#   $a = "c";
#   is($a, 'c', 'binding to swap didn\'t make the vars readonly');
# }

# More tests for binding a list
# https://github.com/Raku/old-issue-tracker/issues/3459
skip('list binding: RT #122369', 4);# {
#   my $a = "a";
#   my $b = "b";
#   my $c = "c";
# 
#   ($a, $b) := ($c, $c);
#   is($a, 'c', 'binding a list literal worked (1)');
#   is($b, 'c', 'binding a list literal worked (2)');
# 
#   $c = "d";
#   is($a, 'd', 'binding a list literal really worked (1)');
#   is($b, 'd', 'binding a list literal really worked (2)');
# }


# Binding subroutine parameters
{
  my $a;
  my $丛 = sub ($arg) { $a := $arg };
  my $𝐯àл = 42;

  $丛($𝐯àл);
  is $a, 42, "bound readonly sub param was bound correctly (1)";
  $𝐯àл++;
  is $a, 42, "bound readonly sub param was bound correctly (2) (no change)";

  dies-ok { $a = 23 },
    "bound readonly sub param remains readonly (1)";
  is $a, 42,
    "bound readonly sub param remains readonly (2)";
  is $𝐯àл, 43,
    "bound readonly sub param remains readonly (3)";
}

{
  my $a;
  my $丛 = sub ($arg is rw) { $a := $arg };
  my $𝐯àл = 42;

  $丛($𝐯àл);
  is $a, 42, "bound rw sub param was bound correctly (1)";
  $𝐯àл++;
  is $a, 43, "bound rw sub param was bound correctly (2)";

  lives-ok { $a = 23 }, "bound rw sub param remains rw (1)";
  is $a, 23,            "bound rw sub param remains rw (2)";
  is $𝐯àл, 23,          "bound rw sub param remains rw (3)";
}

# := actually takes subroutine parameter list
# https://github.com/Raku/old-issue-tracker/issues/3459
skip('list binding: RT #122369', 2);# {
#   my $a;
#   :(:$a) := (:a<foo>);
#   is($a, "foo", "bound keyword");
#   my @tail;
#   :($a, *@tail) := (1, 2, 3);
#   ok($a == 1 && ~@tail eq '2 3', 'bound slurpy');
# }

# https://github.com/Raku/old-issue-tracker/issues/2102
# binding how has the same precedence as list assignment
{
    my $ч := 1, 2;
    is $ч.join, '12', 'binding has same precdence as list assignment'
}

# https://github.com/Raku/old-issue-tracker/issues/1938
{
    my $a := 2;
    $a := $a;
    is $a, 2, 'can bind variable to itself (no-oop)';
}

# https://github.com/Raku/old-issue-tracker/issues/2417
{
    my $ч = 5;
    sub е($ù) { $ч := 5 }	#OK not used
    е($ч);
    is $ч, 5, 'interaction between signature binding and ordinary binding';
}

# https://github.com/Raku/old-issue-tracker/issues/2395
{
    my $ч = 1;
    my $ù := $ч;
    $ч := 3;
    is $ù, 1, 'rebinding';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
