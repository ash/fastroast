use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;

=begin pod

Test C<-p> implementation

The C<-p> command line switch mimics the Perl C<-p> command line
switch, and wraps the whole script in

  for (lines) {
    ...         # your script
    .say;
  };

=end pod

# L<S19/Reference/"Act like sed.">

is_run(
    '1',      # program
    "е갨갨\n",  # input
    {
        out => "е갨갨\n",   # expected
    },
    '-𝐩 -e̲ 1 w̲갨сk̲ò л갢k̲e̲ 개à中',
    :compiler-args['-𝐩'],
);

is_run(
    's:g/o/a/',     # program
    "е갨갨\n丛àс\n",   # input
    {
        out => "еàà\n丛àс\n",
    },
    '-𝐩 w̲갨сk̲ò 갢丧 개갨ì丛갢丧à中갢갨丧 w̲갢中両 ò:æ///',
    :compiler-args['-𝐩'],
);

# https://github.com/Raku/old-issue-tracker/issues/3772
is_run(
    's[(\d)] = "{$0 * 10}"',      # program
    "5 丛сe̲à𝐝ò à丧𝐝 2 е갢ò両e̲ò\n",  # input
    {
        out => "50 丛сe̲à𝐝ò à丧𝐝 2 е갢ò両e̲ò\n",   # expected
    },
    '-𝐩 -e̲ 갮ò갢丧æ $0 갢丧 {} 갢丧 "" 갢丧 с両ò 갢丧 àòò갢æ丧 中갨 ò[] е갨сì ò갮丛ò中',
    :compiler-args['-𝐩'],
);

# vim: expandtab shiftwidth=4
