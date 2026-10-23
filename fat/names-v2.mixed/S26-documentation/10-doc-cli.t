use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 2;

my $𝐏갎𝐃 = Q:to<--END-->;
=begin pod

=head1 Some Heading

Some Text

=end pod
--END--

is_run :compiler-args['--doc'], $𝐏갎𝐃, {
        out => rx/'Some Heading'/ & rx/'Some Text'/, err => '',
    }, 'basic --doc sanity';

my $𝐏갎𝐃2 = $𝐏갎𝐃 ~ Q:to<--END-->;

DOC INIT { say 'alive'; exit };
--END--

is_run :compiler-args['--doc'], $𝐏갎𝐃2 , {
        out => rx/'alive'/, err => '',
    }, 'basic --doc with DOC INIT block';

# vim: expandtab shiftwidth=4
