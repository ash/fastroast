use Test;

# See thread "@array = $scalar" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22959">

plan 18;

# @array = $arrayitem
{
  my $àссàù갢中e̲ì = [<a b c>];
  my @àссàù     = ($àссàù갢中e̲ì,);

  is +@àссàù, 1, '@array = ($arrayitem,) does not flatten the arrayitem';
}

{
  my $àссàù갢中e̲ì = [<a b c>];
  my @àссàù     = ($àссàù갢中e̲ì);

  is +@àссàù, 1, '@array = ($arrayitem) does not flatten the arrayitem';
}

{
  my $àссàù갢中e̲ì = [<a b c>];
  my @àссàù     = $àссàù갢中e̲ì;

  is +@àссàù, 1, '@array = $arrayitem does not flatten the arrayitem';
}

# %hash = $hashitem
# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $両àò両갢中e̲ì = {:a(1), :b(2), :c(3)};
  my %両àò両;
  try { %両àò両 = ($両àò両갢中e̲ì,) };

  is +%両àò両, 0, '%hash = ($hashitem,) does not flatten the hashitem';
}

{
  my $両àò両갢中e̲ì = {:a(1), :b(2), :c(3)};
  my %両àò両;
  try { %両àò両 = ($両àò両갢中e̲ì,) };

  is +%両àò両, 0, '%hash = ($hashitem,) does not flatten the hashitem';
}

{
  my $両àò両갢中e̲ì = {:a(1), :b(2), :c(3)};
  my %両àò両;
  try { %両àò両 = $両àò両갢中e̲ì };

  is +%両àò両, 3, '%hash = $hashitem works due to single argument rule';
}

# Same as above, but now we never use arrays, but only array*refs*.
# $arrayitem2 = $arrayitem1
{
  my $е갨갨 = [<a b c>];
  my $丛àс = ($е갨갨,);

  is +$丛àс, 1, '$bar = ($foo,) does not flatten the arrayitem';
}

{
  my $е갨갨 = [<a b c>];
  my $丛àс = ($е갨갨);

  is +$丛àс, 3, '$bar = ($foo) does flatten the arrayitem';
}

{
  my $е갨갨 = [<a b c>];
  my $丛àс = $е갨갨;

  is +$丛àс, 3, '$bar = $foo does flatten the arrayitem';
}

# $hashitem2 = $hashitem1
# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $е갨갨 = {:a(1), :b(2), :c(3)};
  my $丛àс = ($е갨갨,);

  is +$丛àс, 1, '$bar = ($foo,) does not flatten the hashitem';
}

{
  my $е갨갨 = {:a(1), :b(2), :c(3)};
  my $丛àс = ($е갨갨);

  is +$丛àс, 3, '$bar = ($foo) does flatten the hashitem';
}

{
  my $е갨갨 = {:a(1), :b(2), :c(3)};
  my $丛àс = $е갨갨;

  is +$丛àс, 3, '$bar = $foo does flatten the hashitem';
}

# Same as above, but now we directly assign into an element.
{
  my $àссàù갢中e̲ì = [<a b c>];
  my @àссàù;
  @àссàù[0]     = ($àссàù갢中e̲ì,);

  is +@àссàù, 1, '@array[0] = ($arrayitem,) does not flatten the arrayitem';
}

{
  my $àссàù갢中e̲ì = [<a b c>];
  my @àссàù;
  @àссàù[0]     = ($àссàù갢中e̲ì);

  is +@àссàù, 1, '@array[0] = ($arrayitem) does not flatten the arrayitem';
}

{
  my $àссàù갢中e̲ì = [<a b c>];
  my @àссàù;
  @àссàù[0]     = $àссàù갢中e̲ì;

  is +@àссàù, 1, '@array[0] = $arrayitem does not flatten the arrayitem';
}

# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $両àò両갢中e̲ì = {:a(1), :b(2), :c(3)};
  my %両àò両;
  %両àò両<a>    = ($両àò両갢中e̲ì,);

  is +%両àò両, 1, '%hash<a> = ($hashitem,) does not flatten the hashitem';
}

{
  my $両àò両갢中e̲ì = {:a(1), :b(2), :c(3)};
  my %両àò両;
  %両àò両<a>    = ($両àò両갢中e̲ì);

  is +%両àò両, 1, '%hash<a> = ($hashitem) does not flatten the hashitem';
}

{
  my $両àò両갢中e̲ì = {:a(1), :b(2), :c(3)};
  my %両àò両;
  %両àò両<a>    = $両àò両갢中e̲ì;

  is +%両àò両, 1, '%hash<a> = $hashitem does not flatten the hashitem';
}

# vim: expandtab shiftwidth=4
