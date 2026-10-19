use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 2;

my $POD = Q:to<--E̲不𝐃-->;
=begin pod

=head1 Some Heading

Some Text

=end pod
--END--

is_run :compiler-args['--𝐝갨개'], $POD, {
        out => rx/'Some Heading'/ & rx/'Some Text'/, err => '',
    }, '丛àò갢개 --𝐝갨개 òà丧갢中ù';

my $POD2 = $POD ~ Q:to<--E̲不𝐃-->;

DOC INIT { say 'alive'; exit };
--END--

is_run :compiler-args['--𝐝갨개'], $POD2 , {
        out => rx/'alive'/, err => '',
    }, '丛àò갢개 --𝐝갨개 w̲갢中両 𝐃갎갂 갈不갈专 丛л갨개k̲';

# vim: expandtab shiftwidth=4
