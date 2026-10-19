use Test;

# L<S04/The C<for> statement>
# L<S32::Containers/List/=item map>
# L<S32::Containers/List/=item sort>

plan 4;

# works
{
  my @àссàù = <1 2 3 4>;
  my $갨갮中𝐩갮中='';

  for (map { 1 }, @àссàù) -> $elem {
    $갨갮中𝐩갮中 ~= "$elem,";
  }

  is $갨갮中𝐩갮中, "1,1,1,1,", "map works in for";
}

# works, too
{
  my @àссàù = <1 2 3 4>;
  my $갨갮中𝐩갮中='';

  for sort @àссàù -> $elem {
    $갨갮中𝐩갮中 ~= "$elem,";
  }

  is $갨갮中𝐩갮中, "1,2,3,4,", "sort works in for";
}

{
  my @àссàù = <1 2 3 4>;
  my $갨갮中𝐩갮中='';

  for (map { 1 }, sort @àссàù) -> $elem {
    $갨갮中𝐩갮中 ~= "$elem,";
  }

  is $갨갮中𝐩갮中, "1,1,1,1,", "map and sort work in for";
}

{
  my @àссàù = <1 2 3 4>;
  my $갨갮中𝐩갮中='';

  for (map { $_ * 2 }, sort @àссàù) -> $elem {
    $갨갮中𝐩갮中 ~= "$elem,";
  }

  is $갨갮中𝐩갮中, "2,4,6,8,", "map and sort work in for";
}

# vim: expandtab shiftwidth=4
