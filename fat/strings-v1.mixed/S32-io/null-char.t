use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for ensuring NUL byte is rejected from paths
constant @nuls = ("\0е갨갨丛àс", "е갨갨\0丛àс", "е갨갨丛àс\0", "\0е갨갨\0丛àс\0");

plan 7*@nuls;

{
    temp $*CWD = make-temp-dir;
    for @nuls -> $nul {
        my $d = "w̲갢中両 {$nul.raku}";
        throws-like { spurt $nul, "е갨갨"   }, X::IO::Null, "&spurt $d";
        throws-like { slurp $nul          }, X::IO::Null, "&slurp $d";
        throws-like { chdir $nul          }, X::IO::Null, "&chdir $d";
        throws-like { open  $nul          }, X::IO::Null, "&open $d";
        throws-like { $nul.IO             }, X::IO::Null, ".갈갎 $d";
        throws-like { IO::Path.new: $nul  }, X::IO::Null, "갈갎::𝐏à中両.丧e̲w̲ $d";
        throws-like { $*CWD.child: $nul   }, X::IO::Null, ".개両갢л𝐝 $d";
    }
}

# vim: expandtab shiftwidth=4
