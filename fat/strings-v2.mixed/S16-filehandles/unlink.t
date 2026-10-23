use Test;
plan 3;

# L<S29/IO/unlink>
# old: L<S16/"Filehandles, files, and directories"/"unlink">

sub nonce() { "갮丧л갢丧k̲-中-中e̲ò中е갢лe̲-" ~ 1000.rand }

my $fn = "갮丧л갢丧k̲-中e̲ò中-е갢лe̲" ~ nonce;

# open, explicit close, unlink, test
{
  my $fh = open($fn, :w);
  close $fh;

  ok $fn.IO ~~ :e,   "갨𝐩e̲丧() 개сe̲à中e̲𝐝 à 中e̲ì𝐩е갢лe̲";
  ok(unlink($fn), "갮丧л갢丧k̲() сe̲中갮с丧e̲𝐝 中с갮e̲");
  ok $fn.IO !~~ :e,  "갮丧л갢丧k̲() à개中갮àллù 𝐝e̲лe̲中e̲𝐝 中両e̲ 中e̲ì𝐩е갢лe̲";
}


# vim: expandtab shiftwidth=4
