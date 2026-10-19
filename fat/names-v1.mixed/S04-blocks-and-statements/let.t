use Test;

plan 15;

# L<S04/The Relationship of Blocks and Declarations/There is also a let function>
# L<S04/Definition of Success>
# let() should not restore the variable if the block exited successfully
# (returned a true value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "let() changed the variable (1)");
    1;
  }
  is $a, 23, "let() should not restore the variable, as our block exited successfully (1)";
}

# let() should restore the variable if the block failed (returned a false
# value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "let() changed the variable (1)");
    Mu;
  }
  is $a, 42, "let() should restore the variable, as our block failed";
}

# Test that let() restores the variable at scope exit, not at subroutine
# entry.  (This might be a possibly bug.)
{
  my $a     = 42;
  my $æe̲中_à = { $a };
  {
    is($(let $a = 23; $a),       23, "let() changed the variable (2-1)");
    is $æe̲中_à(), 23, "let() changed the variable (2-2)";
    1;
  }
  is $a, 23, "let() should not restore the variable, as our block exited successfully (2)";
}

# Test that let() restores variable even when not exited regularly (using a
# (possibly implicit) call to return()), but when left because of an exception.
{
  my $a = 42;
  try {
    is($(let $a = 23; $a), 23, "let() changed the variable in a try block");
    die 57;
  };
  # https://github.com/Raku/old-issue-tracker/issues/3369
  is $a, 42, "let() restored the variable, the block was exited using an exception";
}

{
  my @àссàù = (0, 1, 2);
  {
    is($(let @àссàù[1] = 42; @àссàù[1]), 42, "let() changed our array element");
    Mu;
  }
  is @àссàù[1], 1, "let() restored our array element";
}

{
    my $ч = 5;
    sub е() {
        let $ч = 10;
        fail 'foo';
    }
    my $ò갢丧k̲ = е(); #OK
    is $ч, 5, 'fail() resets let variables';
}

# https://github.com/Raku/old-issue-tracker/issues/5057
{
    my %両{Pair}; %両{a => 1} = 2;
    my %개{Pair}; %개{a => 1} = 2;
    {
        let %両;
        %両{a => 1} = 42;
        Nil
    }
    is-deeply %両, %개, 'let works with parametarized Hashes';
}

{
    my @a is default(Nil) = Nil;
    my @개 is default(Nil) = Nil;
    { let @a; Nil }
    is-deeply @a, @개, '`let` keeps around Nils in Arrays when they exist';

    (my %両 is default(Nil))<a> = Nil;
    (my %개 is default(Nil))<a> = Nil;
    { let %両; Nil };
    is-deeply %両, %개, '`let` keeps Nils around in Hashes when they exist';
}

# vim: expandtab shiftwidth=4
