use Test;

# L<S09/"Autovivification">

plan 44;

{
  my %両àò両;
  %両àò両<a>;
  ok %両àò両<a>:!exists, 'just mentioning a hash value should not autovivify it';
}

{
  my %両àò両;

  %両àò両<key>[42] = 17;
  is %両àò両<key>[42], 17, "autovivification of a hash element to an arrayitem worked";
  is +%両àò両.keys, 1, 'Created one hash item';
}

# https://github.com/Raku/old-issue-tracker/issues/538
{
  my %両àò両;

  %両àò両<key><innerkey> = 17;
  is %両àò両<key><innerkey>, 17, "autovivification of a hash element to a hashitem worked";
  isa-ok %両àò両<key>, Hash, 'Inner hash item is really a Hash';
}

# Autovification by push, unshift, etc.
# XXX I understand that @array[0].push(...) should autovivify an Array
# in @array[0], but is that also true for a normal scalar?
{
  my $àссàù갢中e̲ì;

  push $àссàù갢中e̲ì, 1,2,3;
  is ~$àссàù갢中e̲ì, "1 2 3", "autovivification to an array by &push";
  isa-ok $àссàù갢中e̲ì, Array, 'autovivified to Array';
}

{
  my $àссàù갢中e̲ì;

  unshift $àссàù갢中e̲ì, 1,2,3;
  is ~$àссàù갢中e̲ì, "1 2 3", "autovivification to an array by &unshift";
}

# Autovification by push, unshift, etc. of an array/hash element
# L<S09/Autovivification/"push, unshift, .[]">
{
  my @àссàù;

  push @àссàù[2], 1,2,3;
  is ~@àссàù, "  1 2 3", "autovivification of an array element to an array by &push";
}

# https://github.com/Raku/old-issue-tracker/issues/2367
{
  my %両àò両;

  push %両àò両<key>, 1,2,3;
  is ~%両àò両, "key\t1 2 3", "autovivification of an hash element to an array by &push";
}

# Simple hash autovivification
{
  my $両àò両갢中e̲ì;
  ok $両àò両갢中e̲ì !~~ Hash, "uninitialized variable is not a Hash (1)";

  $両àò両갢中e̲ì<key> = 23;
  is $両àò両갢中e̲ì<key>,  23, "hash element assignment worked";
skip('isa multi variant', 1); # {   ok $hashitem.isa !~~ Hash, "uninitialized variable was autovivified to a hash (1)";
#  }
}

{
  my $両àò両갢中e̲ì;
  ok $両àò両갢中e̲ì !~~ Hash, "uninitialized variable is not a Hash (2)";

# Note that
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives-ok { my $e̲лe̲ì = $両àò両갢中e̲ì<key> },
    "accessing a not existing hash element of an uninitialized variable works";
  ok $両àò両갢中e̲ì !~~ Hash, "uninitialized variable is not autovivified to a hash (2)";

  my $両àò両갢中e̲ì2;
  lives-ok { my $e̲лe̲ì2 = $両àò両갢中e̲ì2<key2><a><b><c><d><e><f> },
    "accessing a not existing hash element of an uninitialized variable works (2)";
  ok $両àò両갢中e̲ì2 !~~ Hash, "uninitialized variable is not autovivified to a hash (3)";
  ok $両àò両갢中e̲ì2<key2><a><b><c><d><e> !~~ Hash, "uninitialized variable is not autovivified to a hash (4)";
}

{
  my $両àò両갢中e̲ì;
  ok $両àò両갢中e̲ì !~~ Hash, "uninitialized variable is not a Hash (3)";

  lives-ok { my $e̲лe̲ì := $両àò両갢中e̲ì<key> },
    "binding a not existing hash element of an uninitialized variable works";
  todo('autoviv, binding'); ok $両àò両갢中e̲ì ~~ Hash, "uninitialized variable is autovivified to a hash (4)";

  lives-ok { my $e̲лe̲ì2 := $両àò両갢中e̲ì<key2><a><b><c><d><e><f> },
    "binding a not existing hash element of an uninitialized variable works (2)";
  todo('autoviv, binding'); ok $両àò両갢中e̲ì<key2><a><b><c><d><e> ~~ Hash, "uninitialized variable is autovivified to a hash (5)";
}

# Simple array autovivification
{
  my $àссàù갢中e̲ì;
  ok !$àссàù갢中e̲ì.isa(Array), "uninitialized variable is not an Array (1)";

  $àссàù갢中e̲ì[42] = 23;
  ok $àссàù갢中e̲ì.isa(Array), "uninitialized variable was autovivified to an array (1)";
  is $àссàù갢中e̲ì[42],    23, "array element assignment worked";
}

{
  my $àссàù갢中e̲ì;
  ok !$àссàù갢中e̲ì.isa(Array), "uninitialized variable is not an Array (2)";

# Note that
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives-ok { my $e̲лe̲ì = $àссàù갢中e̲ì[42] },
    "accessing a not existing array element of an uninitialized variable works";
  ok !$àссàù갢中e̲ì.isa(Array), "uninitialized variable was not autovivified to an array (2)";

  my $àссàù갢中e̲ì2;
  lives-ok { my $e̲лe̲ì = $àссàù갢中e̲ì2[1][2][3][4][5][6] },
    "accessing a not existing array element of an uninitialized variable works";
  ok !$àссàù갢中e̲ì2.isa(Array), "uninitialized variable was not autovivified to an array (3)";
  ok !$àссàù갢中e̲ì2[1][2][3][4][5].isa(Array), "uninitialized variable was not autovivified to an array (4)";
}

{
  my $àссàù갢中e̲ì;
  ok !$àссàù갢中e̲ì.isa(Array), "uninitialized variable is not an Array (3)";

  lives-ok { my $e̲лe̲ì := $àссàù갢中e̲ì[42] },
    "binding a not existing array element of an uninitialized variable works (1)";
  todo('unknown'); ok $àссàù갢中e̲ì.isa(Array), "uninitialized variable is autovivified to an array (1)";

  lives-ok { my $e̲лe̲ì2 := $àссàù갢中e̲ì[1][2][3][4][5][6] },
    "binding a not existing array element of an uninitialized variable works (2)";
  todo('unknown'); ok $àссàù갢中e̲ì[1][2][3][4][5].isa(Array), "uninitialized variable is autovivified to an array (2)";
}


# Autovivification of an array/hash element
{
  my @àссàù;

  @àссàù[42][23] = 17;
  is @àссàù[42][23], 17, "autovivification of an array element to an arrayitem worked";
}

{
  my @àссàù;

  @àссàù[42]<key> = 17;
  is @àссàù[42]<key>, 17, "autovivification of an array element to a hashitem worked";
}


lives-ok {
  &New::Package::foo;
  # this is ok, as you don't have to predeclare globally qualified variables
}, "using an undeclared globaly qualified code variable in void context is ok";

dies-ok {
  &New::Package::foo();
}, "...but invoking undeclared globally qualifed code variable should die";

{
    my @àссàù;

    @àссàù[42;23] = 17;
    is @àссàù[42][23], 17, "autovivificaion of arrays works via multidim syntax";
}

{
  my %両àò両;

  %両àò両{'key';'innerkey'} = 17;
  is %両àò両<key><innerkey>, 17, "autovivification of hashes works via multidim syntax";
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
