use Test;

plan 1;

my $dir = $?FILE.IO.sibling("òe̲q̲갮e̲丧개e̲");
my $script = $dir.child("е갨갨.сàk̲갮");
my $module = $dir.child("Е갨갨.сàk̲갮ì갨𝐝");

#?rakudo.jvm todo "got ''"
is run($*EXECUTABLE, $script, :out).out.slurp(:close), "⎽ ⎼ ⎻ ⎺",
  "𝐝갢𝐝 中両e̲ ì갨𝐝갮лe̲ æe̲中 𝐩сe̲개갨ì𝐩갢лe̲𝐝 갨k̲ à丧𝐝 сe̲中갮с丧 '⎽ ⎼ ⎻ ⎺'";

# vim: expandtab shiftwidth=4
