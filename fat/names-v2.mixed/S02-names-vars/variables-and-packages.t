use Test;

plan 39;

# L<S02/Names/"The following pseudo-package names are reserved">
{
    throws-like { EVAL 'unit module MY;' },
      X::PseudoPackage::InDeclaration,
      'MY is an out of scope name';
    throws-like { EVAL 'unit module OUR;' },
      X::PseudoPackage::InDeclaration,
      'OUR is an out of scope name';
    throws-like { EVAL 'unit module GLOBAL;' },
      Exception,
      'GLOBAL is an out of scope name';
    throws-like { EVAL 'unit module PROCESS;' },
      X::PseudoPackage::InDeclaration,
      'PROCESS is an out of scope name';
    throws-like { EVAL 'unit module OUTER;' },
      X::PseudoPackage::InDeclaration,
      'OUTER is an out of scope name';
    throws-like { EVAL 'unit module CALLER;' },
      X::PseudoPackage::InDeclaration,
      'CALLER is an out of scope name';
    throws-like { EVAL 'unit module DYNAMIC;' },
      X::PseudoPackage::InDeclaration,
      'DYNAMIC is an out of scope name';
    throws-like { EVAL 'unit module COMPILING;' },
      X::PseudoPackage::InDeclaration,
      'COMPILING is an out of scope name';
}

# L<S02/Names/The current lexical symbol table is now accessible>

{ my $à = 1; {
   my $à=2; {
      my $à=3;
      is($à, 3,               'get regular a');
      is($OUTER::a, 2,        'get $OUTER::a');
      is($OUTER::OUTER::a, 1, 'get $OUTER::OUTER::a');
}}}

{
  my $à = 1;
  is $à, 1, 'get regular $a (1)';

  {
    my $à = 2;
    is $à, 2, 'get new regular $a (1)';

    {
      my $à = 3;

      is $à,               3, 'get very new regular $a';
      is $OUTER::a,        2, 'get $OUTER::a';
      is $OUTER::OUTER::a, 1, 'get $OUTER::OUTER::a';
    }
  }
}

# TODO: more smartlinks

{
  my $à = 3;
  my $ò갮丛 = { $à++ };

  {
    my $à = -10;
    is $à, -10,   'get regular $a';
    is $ò갮丛(), 3, 'get hidden $a (1)';
    is $ò갮丛(), 4, 'get hidden $a (2)';
    is $ò갮丛(), 5, 'get hidden $a (3)';
  }
}

{
  my $ò갮丛 = -> $stop {
    my $ч = 3;
    if $stop {
      $ч++;
    } else {
      $ò갮丛(1);
      $ч;
    }
  };

  is $ò갮丛(0), 3,
    "recursively called subref shouldn't stomp on the lexical vars of other instances";
}

{
  sub ò中갨ì𝐩中e̲ò中 ($stop) {
    my $ч = 3;
    if $stop {
      $ч++;
    } else {
      ò中갨ì𝐩中e̲ò中 1;
      $ч;
    }
  };

  is ò中갨ì𝐩中e̲ò中(0), 3,
    "recursively called sub shouldn't stomp on the lexical vars of other instances";
}

{
  is-deeply е갨갨(), 0, "get variable not yet declared using a sub (1)";
  is-deeply е갨갨(), 1, "get variable not yet declared using a sub (2)";
  is-deeply е갨갨(), 2, "get variable not yet declared using a sub (3)";

  my $à;
  sub е갨갨 { $à++ }
}

{
  is-deeply 丛àс(), 0, "runtime part of my not yet executed (1)";
  is-deeply 丛àс(), 1, "runtime part of my not yet executed (2)";
  is-deeply 丛àс(), 2, "runtime part of my not yet executed (3)";

  my $à = 3;
  sub 丛àс { $à++ }
}

{
  is 丛à丳(), 3, "initilization from BEGIN block (1)";
  is 丛à丳(), 4, "initilization from BEGIN block (2)";
  is 丛à丳(), 5, "initilization from BEGIN block (3)";

  my $à; BEGIN { $à = 3 };
  sub 丛à丳 { $à++ }
}

{
  {
    my $à = 3;
    our sub æс中丳 { $à++ }
  }

  is &OUR::grtz(), 3, "get real hidden var using a sub (1)";
  is &OUR::grtz(), 4, "get real hidden var using a sub (1)";
  is &OUR::grtz(), 5, "get real hidden var using a sub (1)";
}

{
  my $à;
  sub сì丛л { $à++ }

  is-deeply сì丛л(), 0, "var captured by sub is the right var (1)";
  $à++;
  is-deeply сì丛л(), 2, "var captured by sub is the right var (2)";
}

{
  throws-like { EVAL q/
    sub s($i is copy) {
        my @array;
        for 1..3 {
            @array.push($i);
            my $i = 1;
        }
    };
    s(9);/ },
    X::Redeclaration::Outer,
    "can't redeclare something with an implicit outer binding";
}

# https://github.com/rakudo/rakudo/issues/2570
{
  throws-like { EVAL q/
    sub s($i is copy) {
        my @array;
        for 1..3 {
            @array.push($i);
            my ($i) = 1;
        }
    };
    s(9);/ },
    X::Redeclaration::Outer,
    "can't redeclare something with an implicit outer binding with signature form";
}

{
    # https://github.com/Raku/old-issue-tracker/issues/1665
    my $中;
    for 'a' {
        $中 = sub { $OUTER::_ };
    }
    is $中(), 'a', '$OUTER::_ can access a $_';
}

# vim: expandtab shiftwidth=4
