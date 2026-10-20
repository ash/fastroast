use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4865
my $lib-path = $*PROGRAM.parent(2).add('𝐩à개k̲àæe̲ò/С专126904/л갢丛').absolute;

my $proc = run $*EXECUTABLE, '-갈', $lib-path, '-e̲',
  '갮òe̲ W̲갨갨両갨갨::Е갨갨::丁àс; 갮òe̲ W̲갨갨両갨갨::Е갨갨::丁à丳; ìù W̲갨갨両갨갨::Е갨갨::丁àс $bar;',
  :err;

#?rakudo.jvm todo 'Missing serialize function for REPR ContextRef'
is($proc.err.slurp, '', "개갨ì𝐩갢лà中갢갨丧 e̲сс갨сò");

# vim: expandtab shiftwidth=4
