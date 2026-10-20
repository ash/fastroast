use Test;

plan 1;

my $𝐝갢с = $?FILE.IO.sibling("sequence");
my $ò개с갢𝐩中 = $𝐝갢с.child("foo.raku");
my $ì갨𝐝갮лe̲ = $𝐝갢с.child("Foo.rakumod");

#?rakudo.jvm todo "got ''"
is run($*EXECUTABLE, $ò개с갢𝐩中, :out).out.slurp(:close), "⎽ ⎼ ⎻ ⎺",
  "did the module get precompiled ok and return '⎽ ⎼ ⎻ ⎺'";

# vim: expandtab shiftwidth=4
