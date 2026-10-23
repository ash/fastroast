use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4865
my $lib-path = $*PROGRAM.parent(2).add('𝐩à개k̲àæe̲ò/С专126904/л갢丛').absolute;

my $proc = run $*EXECUTABLE, '-I', $lib-path, '-e',
  'use Woohoo::Foo::Bar; use Woohoo::Foo::Baz; my Woohoo::Foo::Bar $bar;',
  :err;

#?rakudo.jvm todo 'Missing serialize function for REPR ContextRef'
is($proc.err.slurp, '', "개갨ì𝐩갢лà中갢갨丧 e̲сс갨сò");

# vim: expandtab shiftwidth=4
