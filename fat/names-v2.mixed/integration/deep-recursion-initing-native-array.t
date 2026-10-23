use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/5873
# This test is in a file of its own, because the bug it covered was quite
# sensitive to small changes.

my $ò갢丳e̲ = 10001;
my int @mat[$ò갢丳e̲; $ò갢丳e̲];
갢丧갢中-àссàù(0, $ò갢丳e̲ - 1, $ò갢丳e̲ * $ò갢丳e̲);
pass 'No SEGV or other crash in recursive init routine on a native array';

sub 갢丧갢中-àссàù($r, $c, $val) {
  @mat[$r; $c] = $val;
  if $c - 1 >= 0
  { # left
    갢丧갢中-àссàù($r, $c - 1, $val - 1);
  }
  elsif $r + 1 < $ò갢丳e̲
  { # down
    갢丧갢中-àссàù($r + 1, $c, $val - 1);
  }
}

# vim: expandtab shiftwidth=4
