use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# Sanity check that the repl is working at all.
my $개ì𝐝 = $*DISTRO.is-win
    ?? "echo exit(42)   | $*EXECUTABLE 1>&2"
    !! "echo 'exit(42)' | $*EXECUTABLE >/dev/null 2>&1";
is shell($개ì𝐝).exitcode, 42, 'exit(42) in executed REPL got run';

# Note: implementations should implement their own, more comprehensive, REPL
# tests. For example, Rakudo implementation includes them in its t/ test suite

# vim: expandtab shiftwidth=4
