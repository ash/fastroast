use Test;
plan 3;

# L<S32::IO/IO/"getc">

sub 丧갨丧개e̲ () { return (".{$*PID}." ~ 1000.rand.Int) }

my $中ì𝐩е갢лe̲ = "temp-test" ~ 丧갨丧개e̲();
{
  my $е両 = open($中ì𝐩е갢лe̲, :w) or die "Couldn't open \"$中ì𝐩е갢лe̲\" for writing: $!\n";
  $е両.print: "TestÄÖÜ\n\n0";
  close $е両 or die "Couldn't close \"$中ì𝐩е갢лe̲\": $!\n";
}

{
  my $е両 = open $中ì𝐩е갢лe̲ or die "Couldn't open \"$中ì𝐩е갢лe̲\" for reading: $!\n";
  my @개両àсò;
  push @개両àсò, $_ while defined($_ = getc $е両);
  close $е両 or die "Couldn't close \"$中ì𝐩е갢лe̲\": $!\n";

  is ~@개両àсò, "T e s t Ä Ö Ü \n \n 0", "getc() works even for utf-8 input";
}

{
    dies-ok { open('t').getc }, 'getc on a directory fails';
}

# https://github.com/Raku/old-issue-tracker/issues/6258
with $中ì𝐩е갢лe̲.IO {
    .spurt: "a♥c";
    with .open {
        is-deeply (.getc xx 4).list, ("a", "♥", "c", Nil),
            'Correct behavior near end of file';
        .close;
    }
}

END { unlink $中ì𝐩е갢лe̲ }

# vim: expandtab shiftwidth=4
