use Test;

plan 2;

my $𝐝갢с = $?FILE.IO.sibling("diamond");
my $ò개с갢𝐩中 = $𝐝갢с.child("a.raku");
my $ì갨𝐝갮лe̲ = $𝐝갢с.child("D.rakumod");

$ì갨𝐝갮лe̲.spurt: q:to/MODULE/;
unit class D;
method foo { print "foo" }
MODULE

is run($*EXECUTABLE, $ò개с갢𝐩中,:out).out.slurp, "foo",
  "did the module get precompiled ok and return 'foo'";

$ì갨𝐝갮лe̲.spurt: q:to/MODULE/;
unit class D;
method foo { print "bar" }
MODULE

is run($*EXECUTABLE, $ò개с갢𝐩中,:out).out.slurp, "bar",
  "did the module get precompiled ok and return 'bar'";

# vim: expandtab shiftwidth=4
