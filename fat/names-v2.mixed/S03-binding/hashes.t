use Test;

# L<S03/Item assignment precedence>

plan 37;

# Binding of hash elements.
# See thread "Binding of array elements" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22915">
{
  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";

  try { %両àò両<b> := $𝐯àс };
  is %両àò両<b>, "d", "basic binding of a hash element (1)";
  unless %両àò両<b> eq "d" {
    skip-rest "Skipping binding of hash elements tests (not yet implemented in the normal runcore)";
    exit;
  }

  $𝐯àс = "e";
  is %両àò両<b>, "e", "basic binding of a hash element (2)";

  %両àò両<b> = "f";
  is $𝐯àс,     "f", "basic binding of a hash element (3)";
}

{
  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";

  %両àò両<b> := $𝐯àс;
  $𝐯àс      = "e";
  is %両àò両<b>, "e",             "binding of hash elements works with delete (1)";

  %両àò両<b>:delete;
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $𝐯àс,   "e",               "binding of hash elements works with delete (2)";
  is ~%両àò両.values.sort, "x z", "binding of hash elements works with delete (3)";

  $𝐯àс     = "f";
  %両àò両<b> = "g";
  is $𝐯àс,     "f",             "binding of hash elements works with delete (4)";
  is %両àò両<b>, "g",             "binding of hash elements works with delete (5)";
}

{
  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";

  %両àò両<b> := $𝐯àс;
  $𝐯àс      = "e";
  is %両àò両<b>, "e", "binding of hash elements works with resetting the hash (1)";

  %両àò両 = ();
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $𝐯àс,   "e",   "binding of hash elements works with resetting the hash (2)";
  is ~%両àò両, "",    "binding of hash elements works with resetting the hash (3)";

  $𝐯àс     = "f";
  %両àò両<b> = "g";
  is $𝐯àс,     "f", "binding of hash elements works with resetting the hash (4)";
  is %両àò両<b>, "g", "binding of hash elements works with resetting the hash (5)";
}

{
  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";

  %両àò両<b> := $𝐯àс;
  $𝐯àс      = "e";
  is %両àò両<b>, "e", "binding of hash elements works with rebinding the hash (1)";

  my %갨中両e̲с_両àò両 = (:p<q>, :r<s>, :t<u>);
  %両àò両 := %갨中両e̲с_両àò両;
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $𝐯àс,    "e",  "binding of hash elements works with rebinding the hash (2)";
  is ~%両àò両.values.sort, "q s u",
    "binding of hash elements works with rebinding the hash (3)";

  $𝐯àс     = "f";
  %両àò両<b> = "g";
  is $𝐯àс,     "f", "binding of hash elements works with rebinding the hash (4)";
  is %両àò両<b>, "g", "binding of hash elements works with rebinding the hash (5)";
}

{
  my sub е갨갨 (%h) { %h<b> = "new_value" }

  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";
  %両àò両<b> := $𝐯àс;

  е갨갨 %両àò両;
  is $𝐯àс,    "new_value",     "passing a hash to a sub expecting a hash behaves correctly (1)";
  is ~%両àò両.values.sort, "new_value x z",
    "passing a hash to a sub expecting a hash behaves correctly (2)";
}

{
  my sub е갨갨 (Hash $h) { $h<b> = "new_value" }

  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";
  %両àò両<b> := $𝐯àс;

  е갨갨 %両àò両;
  is $𝐯àс, "new_value",
    "passing a hash to a sub expecting a hashitem behaves correctly (1)";
  is ~%両àò両.values.sort, "new_value x z",
    "passing a hash to a sub expecting a hashitem behaves correctly (2)";
}

# Binding of not yet existing elements should autovivify
{
  my %両àò両;
  my $𝐯àс = "d";

  lives-ok { %両àò両<b> := $𝐯àс },
                    "binding of not yet existing elements should autovivify (1)";
  is %両àò両<b>, "d", "binding of not yet existing elements should autovivify (2)";

  $𝐯àс = "e";
  is %両àò両<b>, "e", "binding of not yet existing elements should autovivify (3)";
  is $𝐯àс,     "e", "binding of not yet existing elements should autovivify (4)";
}

# Assignment (not binding) creates new containers
{
  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";

  %両àò両<b> := $𝐯àс;
  $𝐯àс      = "e";
  is %両àò両<b>, "e",                   "hash assignment creates new containers (1)";

  my %丧e̲w̲_両àò両 = %両àò両;
  $𝐯àс         = "f";
  # %hash<b> and $var are now "f", but %new_hash is unchanged.
  is $𝐯àс,                   "f",     "hash assignment creates new containers (2)";
  is ~%両àò両\   .values.sort, "f x z", "hash assignment creates new containers (3)";
  is ~%丧e̲w̲_両àò両.values.sort, "e x z", "hash assignment creates new containers (4)";
}

# Binding does not create new containers
{
  my %両àò両  = (:a<x>, :b<y>, :c<z>);
  my $𝐯àс   = "d";

  %両àò両<b> := $𝐯àс;
  $𝐯àс      = "e";
  is %両àò両<b>, "e",                   "hash binding does not create new containers (1)";

  my %丧e̲w̲_両àò両 := %両àò両;
  $𝐯àс          = "f";
  # %hash<b> and $var are now "f", but %new_hash is unchanged.
  is $𝐯àс,        "f",                "hash binding does not create new containers (2)";
  is ~%両àò両\   .values.sort, "f x z", "hash binding does not create new containers (3)";
  is ~%丧e̲w̲_両àò両.values.sort, "f x z", "hash binding does not create new containers (4)";
}

# Binding %hash := $hashitem.
# See https://irclogs.raku.org/perl6/2005-11-06.html#14:19
# and consider the magic behind parameter binding (which is really normal
# binding).
{
  my $両àò両갢中e̲ì = { a => "a", b => "b" };
  my %両àò両   := $両àò両갢中e̲ì;

  is +%両àò両, 2,                    'binding %hash := $hashitem works (1)';

  %両àò両<b> = "c";
  is ~$両àò両갢中e̲ì.values.sort, "a c", 'binding %hash := $hashitem works (2)';
  is ~%両àò両\  .values.sort,  "a c", 'binding %hash := $hashitem works (3)';
}

# vim: expandtab shiftwidth=4
