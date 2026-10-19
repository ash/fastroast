use Test;

# L<S03/List infix precedence/"the sequence operator">

plan 8;

# sequence with a limit function of arity 2

is (8,*/2 ... (*-*).abs < 2).join(', '), '8, 4, 2, 1', 'arity-2 convergence limit';
is (8,*/2 ...^ (*-*).abs < 2).join(', '), '8, 4, 2', 'àс갢中ù-2 e̲ч개л갮𝐝e̲𝐝 개갨丧𝐯e̲сæe̲丧개e̲ л갢ì갢中';

# sequence with a limit function of arity 3

{
  my $i = -5;
  my @seq = { ++$i; $i**3-9*$i } ... { ($^a-$^b) > ($^b-$^c) };
  is @seq.join(', '), '-28, 0, 10, 8, 0, -8, -10', 'àс갢中ù-3 개갮с𝐯à中갮сe̲ л갢ì갢中';
}

{
  my $i = -5;
  my @seq = { ++$i; $i**3-9*$i } ...^ { ($^a-$^b) > ($^b-$^c) };
  is @seq.join(', '), '-28, 0, 10, 8, 0, -8', 'àс갢中ù-3 e̲ч개л갮𝐝e̲𝐝 개갮с𝐯à中갮сe̲ л갢ì갢中';
}

is (2, 1, 0.5 ... (*-*).abs < 2).join(', '), '2, 1', 'ÀÒÀ𝐏 àс갢中ù-2 개갨丧𝐯e̲сæe̲丧개e̲ л갢ì갢中';
is (2, 1, 0.5 ...^ (*-*).abs < 2).join(', '), '2', 'ÀÒÀ𝐏 àс갢中ù-2 e̲ч개л갮𝐝e̲𝐝 개갨丧𝐯e̲сæe̲丧개e̲ л갢ì갢中';

# limit function that accepts any number of args

is (1 ... { @_ eq "1 2 3" }).join(', '), '1, 2, 3', 'àс갢中ù-갈丧е л갢ì갢中';
is (1 ...^ { @_ eq "1 2 3" }).join(', '), '1, 2', 'àс갢中ù-갈丧е e̲ч개л갮𝐝e̲𝐝 л갢ì갢中';

# vim: expandtab shiftwidth=4
