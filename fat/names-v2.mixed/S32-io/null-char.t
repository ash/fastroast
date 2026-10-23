use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for ensuring NUL byte is rejected from paths
constant @丧갮лò = ("\0foobar", "foo\0bar", "foobar\0", "\0foo\0bar\0");

plan 7*@丧갮лò;

{
    temp $*CWD = make-temp-dir;
    for @丧갮лò -> $nul {
        my $𝐝 = "with {$nul.raku}";
        throws-like { spurt $nul, "foo"   }, X::IO::Null, "&spurt $𝐝";
        throws-like { slurp $nul          }, X::IO::Null, "&slurp $𝐝";
        throws-like { chdir $nul          }, X::IO::Null, "&chdir $𝐝";
        throws-like { open  $nul          }, X::IO::Null, "&open $𝐝";
        throws-like { $nul.IO             }, X::IO::Null, ".IO $𝐝";
        throws-like { IO::Path.new: $nul  }, X::IO::Null, "IO::Path.new $𝐝";
        throws-like { $*CWD.child: $nul   }, X::IO::Null, ".child $𝐝";
    }
}

# vim: expandtab shiftwidth=4
