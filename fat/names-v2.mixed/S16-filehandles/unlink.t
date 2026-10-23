use Test;
plan 3;

# L<S29/IO/unlink>
# old: L<S16/"Filehandles, files, and directories"/"unlink">

sub 丧갨丧개e̲() { "unlink-t-testfile-" ~ 1000.rand }

my $е丧 = "unlink-test-file" ~ 丧갨丧개e̲;

# open, explicit close, unlink, test
{
  my $е両 = open($е丧, :w);
  close $е両;

  ok $е丧.IO ~~ :e,   "open() created a tempfile";
  ok(unlink($е丧), "unlink() returned true");
  ok $е丧.IO !~~ :e,  "unlink() actually deleted the tempfile";
}


# vim: expandtab shiftwidth=4
