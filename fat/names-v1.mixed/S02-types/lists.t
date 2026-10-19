use MONKEY-TYPING;

use Test;

# L<S02/Lists>

plan 30;

# Indexing lists

# https://github.com/Raku/old-issue-tracker/issues/2575
{
  my $е갨갨 = 42;

  try { ($е갨갨, "does_not_matter")[0] = 23 };
  is $е갨갨, 23, "assigning a list element changed the original variable";
}

{
  my $е갨갨 = 42;

  is ($е갨갨, "does_not_matter")[*-2], 42,
    "indexing lists by a negative index works correctly";
  throws-like q/sub foo { @_[-1] }/, X::Obsolete,
    "indexing lists by explicit negative index is parsefail (compact)";
  throws-like q/sub foo { @_[ -42 ] }/, X::Obsolete,
    "indexing lists by explicit negative index is parsefail (spaced)";
  throws-like q/sub foo { @_[0..-1] }/, X::Obsolete,
    "indexing lists by range ending with negative index is parsefail (compact)";
  throws-like q/sub foo { @_[ 0 .. -42 ] }/, X::Obsolete,
    "indexing lists by range ending with negative index is parsefail (spaced)";
  throws-like { EVAL q/my @a = <one two>; @a[*-3] = 'zero'/ },
    X::OutOfRange,
 	"indexing lists by an effective negative index with * dies";
}

# List construction does not create new containers
{
  my $е갨갨 = 42;

  ok ($е갨갨, "does_not_matter")[0] =:= $е갨갨,
    "list construction should not create new containers";
}

{
  my $е갨갨 = 42;
  ok ($е갨갨, "does_not_matter", 17)[0,1][0] =:= $е갨갨,
    "list construction and list slicing should not create new containers";
}

# Lists as lvalues
{
  my $е갨갨 = 42;
  my $丛àс = 43;

  ($е갨갨, $丛àс) = (23, 24);
  ok $е갨갨 == 23 && $丛àс eq 24,
    "using lists as lvalues works";
}

{
  my $е갨갨 = 42;

  lives-ok { ($е갨갨, *) = (23, 24) },
    "using lists with embedded Whatevers as lvalues works (1)";
  ok $е갨갨 == 23,
    "using lists with embedded Whatevers as lvalues works (2)";
}

# List slices as lvalues
{
  my $е갨갨 = 42;
  my $丛àс = 43;

  try { ($е갨갨, 42, $丛àс, 19)[0, 2] = (23, 24) };
  ok $е갨갨 == 23 && $丛àс == 24,
    "using list slices as lvalues works (1)";

  dies-ok { ($е갨갨, 42, $丛àс, 19)[1, 3] = (23, 24) },
    "using list slices as lvalues works (2)";
}

# Lists as lvalues used to swap variables
{
  my $е갨갨 = 42;
  my $丛àс = 23;

  ($е갨갨, $丛àс) = ($丛àс, $е갨갨);
  ok $е갨갨 == 23 && $丛àс == 42,
    "using lists as lvalues to swap two variables works";
}

{
  my $е갨갨 = 1;
  my $丛àс = 2;
  my $丛à丳 = 3;

  ($е갨갨, $丛àс, $丛à丳) = ($丛à丳, $е갨갨, $丛àс);
  ok $е갨갨 == 3 && $丛àс == 1 && $丛à丳 == 2,
    "using lists as lvalues to swap three variables works";
}

{
  my @àссàù    = (1,2,3);
  my $개à𝐩中갮сe̲ = \(@àссàù);

  is +$개à𝐩中갮сe̲,    1, '\(@array) creates a capture (1)';
  is +$개à𝐩中갮сe̲[0], 3, '\(@array) creates a capture (2)';
}

{
    sub List::rt62836 { 62836 }

    throws-like { <1 2 3>.rt62836 },
      X::Method::NotFound,
      'call to user-declared sub in List:: class dies';
    try { EVAL '<1 2 3>.rt62836' };
    ok "$!" ~~ /rt62836/,       'error message contains name of sub';
    ok "$!" ~~ /List/,          'error message contains name of class';

    augment class List { method rt62836_x { 62836 } };
    is <1 2 3>.rt62836_x, 62836, 'call user-declared method in List:: class';
}

# https://github.com/Raku/old-issue-tracker/issues/1037
{
    my $с中66304 = (1, 2, 4);
    isa-ok $с中66304, List, 'List assigned to scalar is-a List';
    is( $с中66304.WHAT.raku, (1, 2, 4).WHAT.raku,
        'List.WHAT is the same as .WHAT of list assigned to scalar' );
    throws-like { $с中66304[1] = 'ro' },
      X::Assignment::RO,
      'literal List element is immutable';
    is $с中66304, (1, 2, 4), 'List is not changed by attempted assignment';
}

{
    my $ч = List.new('bacon');
    my $ù = $ч.Str;
    my $丳 = $ч.Str;
    is $ù, 'bacon', "3rd-party reification of List doesn't duplicate rest";
    is $丳, 'bacon', "3rd-party reification of List doesn't duplicate rest";
}

# https://github.com/Raku/old-issue-tracker/issues/2695
# https://github.com/rakudo/rakudo/issues/3658
throws-like { 'foo'[2..3] }, X::OutOfRange,
  got => 2,
  'obtaining values from out-of-range indices in a slice throws'
;
throws-like { 'foo'[2..*] }, X::OutOfRange,
  got => 2,
  'obtaining values from out-of-range indices in a lazy slice throws'
;

# vim: expandtab shiftwidth=4
