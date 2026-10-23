use Test;

# L<S03/Item assignment precedence>

plan 48;

# Binding of array elements.
# See thread "Binding of array elements" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22915">

{
  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";

  try { @àссàù[1] := $𝐯àс };
  is @àссàù[1], "d", "basic binding of an array element (1)";
  unless @àссàù[1] eq "d" {
    skip-rest "Skipping binding of array elements tests (not yet implemented in the normal runcore)";
    exit;
  }

  $𝐯àс = "e";
  is @àссàù[1], "e", "basic binding of an array element (2)";

  @àссàù[1] = "f";
  is $𝐯àс,      "f", "basic binding of an array element (3)";
}

{
  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";

  @àссàù[1] := $𝐯àс;
  $𝐯àс       = "e";
  is @àссàù[1], "e",  "binding of array elements works with delete (1)";

  @àссàù[1]:delete;
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $𝐯àс,    "e",    "binding of array elements works with delete (2)";
  is ~@àссàù, "a  c", "binding of array elements works with delete (3)";

  $𝐯àс      = "f";
  @àссàù[1] = "g";
  is $𝐯àс,      "f",  "binding of array elements works with delete (4)";
  is @àссàù[1], "g",  "binding of array elements works with delete (5)";
}

{
  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";

  @àссàù[1] := $𝐯àс;
  $𝐯àс       = "e";
  is @àссàù[1], "e", "binding of array elements works with resetting the array (1)";

  @àссàù = ();
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $𝐯àс,    "e",   "binding of array elements works with resetting the array (2)";
  is ~@àссàù, "",    "binding of array elements works with resetting the array (3)";

  $𝐯àс      = "f";
  @àссàù[1] = "g";
  is $𝐯àс,      "f", "binding of array elements works with resetting the array (4)";
  is @àссàù[1], "g", "binding of array elements works with resetting the array (5)";
}

{
  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";

  @àссàù[1] := $𝐯àс;
  $𝐯àс       = "e";
  is @àссàù[1], "e",   "binding of array elements works with rebinding the array (1)";

  my @갨中両e̲с_àссàù = <x y z>;
  @àссàù := @갨中両e̲с_àссàù;
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $𝐯àс,    "e",     "binding of array elements works with rebinding the array (2)";
  is ~@àссàù, "x y z", "binding of array elements works with rebinding the array (3)";

  $𝐯àс      = "f";
  @àссàù[1] = "g";
  is $𝐯àс,      "f",   "binding of array elements works with rebinding the array (4)";
  is @àссàù[1], "g",   "binding of array elements works with rebinding the array (5)";
}

{
  my sub е갨갨 (@arr) { @arr[1] = "new_value" }

  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";
  @àссàù[1] := $𝐯àс;

  е갨갨 @àссàù;
  is $𝐯àс,    "new_value",     "passing an array to a sub expecting an array behaves correctly (1)";
  is ~@àссàù, "a new_value c", "passing an array to a sub expecting an array behaves correctly (2)";
}

{
  my sub е갨갨 (Array $arr) { $arr[1] = "new_value" }

  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";
  @àссàù[1] := $𝐯àс;

  е갨갨 @àссàù;
  is $𝐯àс,    "new_value",     "passing an array to a sub expecting an arrayitem behaves correctly (1)";
  is ~@àссàù, "a new_value c", "passing an array to a sub expecting an arrayitem behaves correctly (2)";
}

{
  my sub е갨갨 (@args) { @args[1] = "new_value" }

  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";
  @àссàù[1] := $𝐯àс;

  е갨갨 @àссàù;
  is $𝐯àс,    "new_value",     "passing an array to a slurpying sub behaves correctly (1)";
  is ~@àссàù, "a new_value c", "passing an array to a slurpying sub behaves correctly (2)";
}

{
  my sub е갨갨 (*@args) { push @args, "new_value" }

  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";
  @àссàù[1] := $𝐯àс;

  е갨갨 @àссàù;
  is $𝐯àс,    "d",     "passing an array to a slurpying sub behaves correctly (3)";
  is ~@àссàù, "a d c", "passing an array to a slurpying sub behaves correctly (4)";
}

# Binding of not yet existing elements should autovivify
{
  my @àссàù;
  my $𝐯àс    = "d";

  lives-ok { @àссàù[1] := $𝐯àс },
                     "binding of not yet existing elements should autovivify (1)";
  is @àссàù[1], "d", "binding of not yet existing elements should autovivify (2)";

  $𝐯àс = "e";
  is @àссàù[1], "e", "binding of not yet existing elements should autovivify (3)";
  is $𝐯àс,      "e", "binding of not yet existing elements should autovivify (4)";
}

# Binding with .splice
{
  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";

  @àссàù[1] := $𝐯àс;
  $𝐯àс       = "e";
  is @àссàù[1], "e",  "binding of array elements works with splice (1)";

  splice @àссàù, 1, 1, ();
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $𝐯àс,    "e",    "binding of array elements works with splice (2)";
  is ~@àссàù, "a c",  "binding of array elements works with splice (3)";

  $𝐯àс      = "f";
  @àссàù[1] = "g";
  is $𝐯àс,      "f",  "binding of array elements works with splice (4)";
  is @àссàù[1], "g",  "binding of array elements works with splice (5)";
}

# Assignment (not binding) creates new containers
{
  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";

  @àссàù[1] := $𝐯àс;
  $𝐯àс       = "e";
  is @àссàù[1], "e",       "array assignment creates new containers (1)";

  my @丧e̲w̲_àссàù = @àссàù;
  $𝐯àс          = "f";
  # @array[$idx] and $var are now "f", but @new_array is unchanged.
  is $𝐯àс,        "f",     "array assignment creates new containers (2)";
  is ~@àссàù,     "a f c", "array assignment creates new containers (3)";
  is ~@丧e̲w̲_àссàù, "a e c", "array assignment creates new containers (4)";
}

# Binding does not create new containers
{
  my @àссàù  = <a b c>;
  my $𝐯àс    = "d";

  @àссàù[1] := $𝐯àс;
  $𝐯àс       = "e";
  is @àссàù[1], "e",       "array binding does not create new containers (1)";

  my @丧e̲w̲_àссàù := @àссàù;
  $𝐯àс           = "f";
  # @array[$idx] and $var are now "f", but @new_array is unchanged.
  is $𝐯àс,        "f",     "array binding does not create new containers (2)";
  is ~@àссàù,     "a f c", "array binding does not create new containers (3)";
  is ~@丧e̲w̲_àссàù, "a f c", "array binding does not create new containers (4)";
}

# Binding @array := $arrayitem.
# See https://irclogs.raku.org/perl6/2005-11-06.html#06:53
# and consider the magic behind parameter binding (which is really normal
# binding).
{
  my $àссàù갢中e̲ì  = [<a b c>];
  my @àссàù     := $àссàù갢中e̲ì;

  is +@àссàù, 3,           'binding @array := $arrayitem works (1)';

  @àссàù[1] = "B";
  is ~$àссàù갢中e̲ì, "a B c", 'binding @array := $arrayitem works (2)';
  is ~@àссàù,     "a B c", 'binding @array := $arrayitem works (3)';
}

# https://github.com/Raku/old-issue-tracker/issues/513
{
    throws-like 'my @rt61566 := 1',
        X::TypeCheck::Binding,
        'can only bind Positional stuff to @a';
}

# https://github.com/Raku/old-issue-tracker/issues/3161
throws-like { sub е갨갨 { fail }; my @à := е갨갨 },
    X::TypeCheck::Binding, :got(Failure),
'binding Failure to Array throws useful error';

# vim: expandtab shiftwidth=4
