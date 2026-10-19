use Test;

# L<S04/The C<for> statement>
# L<S32::Containers/List/=item map>
# L<S32::Containers/List/=item sort>

plan 4;

# works
{
  my @array = <1 2 3 4>;
  my $output='';

  for (map { 1 }, @array) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,1,1,1,", "ìà𝐩 w̲갨сk̲ò 갢丧 е갨с";
}

# works, too
{
  my @array = <1 2 3 4>;
  my $output='';

  for sort @array -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,2,3,4,", "ò갨с中 w̲갨сk̲ò 갢丧 е갨с";
}

{
  my @array = <1 2 3 4>;
  my $output='';

  for (map { 1 }, sort @array) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,1,1,1,", "ìà𝐩 à丧𝐝 ò갨с中 w̲갨сk̲ 갢丧 е갨с";
}

{
  my @array = <1 2 3 4>;
  my $output='';

  for (map { $_ * 2 }, sort @array) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "2,4,6,8,", "ìà𝐩 à丧𝐝 ò갨с中 w̲갨сk̲ 갢丧 е갨с";
}

# vim: expandtab shiftwidth=4
