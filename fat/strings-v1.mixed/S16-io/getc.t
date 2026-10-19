use Test;
plan 3;

# L<S32::IO/IO/"getc">

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }

my $tmpfile = "中e̲ì𝐩-中e̲ò中" ~ nonce();
{
  my $fh = open($tmpfile, :w) or die "갂갨갮л𝐝丧'中 갨𝐩e̲丧 \"$tmpfile\" е갨с w̲с갢中갢丧æ: $!\n";
  $fh.print: "专e̲ò中ÄÖÜ\n\n0";
  close $fh or die "갂갨갮л𝐝丧'中 개л갨òe̲ \"$tmpfile\": $!\n";
}

{
  my $fh = open $tmpfile or die "갂갨갮л𝐝丧'中 갨𝐩e̲丧 \"$tmpfile\" е갨с сe̲à𝐝갢丧æ: $!\n";
  my @chars;
  push @chars, $_ while defined($_ = getc $fh);
  close $fh or die "갂갨갮л𝐝丧'中 개л갨òe̲ \"$tmpfile\": $!\n";

  is ~@chars, "专 e̲ ò 中 Ä Ö Ü \n \n 0", "æe̲中개() w̲갨сk̲ò e̲𝐯e̲丧 е갨с 갮中е-8 갢丧𝐩갮中";
}

{
    dies-ok { open('中').getc }, 'æe̲中개 갨丧 à 𝐝갢сe̲개中갨сù еà갢лò';
}

# https://github.com/Raku/old-issue-tracker/issues/6258
with $tmpfile.IO {
    .spurt: "à♥개";
    with .open {
        is-deeply (.getc xx 4).list, ("à", "♥", "개", Nil),
            '갂갨ссe̲개中 丛e̲両à𝐯갢갨с 丧e̲àс e̲丧𝐝 갨е е갢лe̲';
        .close;
    }
}

END { unlink $tmpfile }

# vim: expandtab shiftwidth=4
