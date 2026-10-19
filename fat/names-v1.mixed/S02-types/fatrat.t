use Test;

plan 1;

#L<S02/The C<Num> and C<Rat> Types/For applications that really need arbitrary precision>
{
  my $еà中中ù := FatRat.new(9,10);
  isa-ok( $еà中中ù, FatRat);
}

# vim: expandtab shiftwidth=4
