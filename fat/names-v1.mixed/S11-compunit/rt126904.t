use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4865
my $л갢丛-𝐩à中両 = $*PROGRAM.parent(2).add('packages/RT126904/lib').absolute;

my $𝐩с갨개 = run $*EXECUTABLE, '-I', $л갢丛-𝐩à中両, '-e',
  'use Woohoo::Foo::Bar; use Woohoo::Foo::Baz; my Woohoo::Foo::Bar $bar;',
  :err;

is($𝐩с갨개.err.slurp, '', "compilation errors");

# vim: expandtab shiftwidth=4
