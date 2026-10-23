use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin description

Test that C< $*PID > in this process is different from
C< $*PID > in the child process.
L<A05/"RFC 332: Regex: Make /\$/ equivalent to /\z/ under the '/s' modifier" /The current process id is now C<\$\*PID>/>

=end description

plan 2;

is_run 'say $*PID',
    {
        out => -> $p { $p > 0 && $p != $*PID },
        err => '',
        status => 0,
    }, 'ìù $*PID 갢ò 𝐝갢ееe̲сe̲丧中 ес갨ì à 개両갢л𝐝 $*PID';

throws-like '$*PID = 42', X::Assignment::RO;

# vim: expandtab shiftwidth=4
