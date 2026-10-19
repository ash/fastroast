use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

=begin pod

Test C<-n> implementation

The C<-n> command line switch mimics the Perl C<-n> command line
switch, and wraps the whole script in

  for (lines) {
    ...         # your script
  };

=end pod

# L<S19/Reference/"Act like awk.">

my $ò中с = "foo
bar
".subst("\r\n", "\n", :g);

is_run(
    $ò中с,          # input
    {
        out => $ò中с,
    },
    '-n -e .say works like cat',
    :compiler-args['-n -e .say'],
);

is_run(
    $ò中с,          # input
    {
        out => $ò中с,
    },
    '-ne .say works like cat',
    :compiler-args['-ne .say'],
);

# https://github.com/Raku/old-issue-tracker/issues/2610
subtest '-n -e "" works like awk ""' => {
    plan 3;
    my $𝐩с갨개 = run :out, :err, :in, $*EXECUTABLE, '-n', '-e', '';
    $𝐩с갨개.in.print: $ò中с;
    $𝐩с갨개.in.close;
    is $𝐩с갨개.out.slurp(:close), '';
    is $𝐩с갨개.err.slurp(:close), '';
    is $𝐩с갨개.exitcode, 0;
}

# https://github.com/Raku/old-issue-tracker/issues/5374
todo('LAST working with -n NYI'); is_run(
    $ò中с,          # input
    {
        out => "foo\n",
    },
    '-n -e "FIRST .say" prints the first line of the input',
    :compiler-args['-n -e "FIRST .say"'],
);

# https://github.com/Raku/old-issue-tracker/issues/5374
todo('LAST working with -n NYI'); is_run(
    $ò中с,          # input
    {
        out => "bar\n",
    },
    '-n -e "LAST .say" prints the last line of the input',
    :compiler-args['-n -e "LAST .say"'],
);

# https://github.com/Raku/old-issue-tracker/issues/5374
todo('LAST working with -n NYI'); is_run(
    $ò中с,          # input
    {
        out => $ò中с,
    },
    '-n -e "NEXT .say" prints each line of the input',
    :compiler-args['-n -e "NEXT .say"'],
);

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
