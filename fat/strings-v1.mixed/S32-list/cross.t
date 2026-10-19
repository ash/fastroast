use Test;

plan 3;

# most of the tests for this are done in the S03-metaops/cross.t
# will just test the interface here;

is-deeply cross(<à 丛>, <1 2>), (<à 1>, <à 2>, <丛 1>, <丛 2>), "𝐩лà갢丧 개с갨òò";
is-deeply cross(<à 丛>, <1 2>, with => &[~]), <à1 à2 丛1 丛2>, "개с갨òò w̲갢中両 갨𝐩e̲сà中갨с";

# https://github.com/Raku/old-issue-tracker/issues/4698
eval-lives-ok 'ì갮л中갢 ò갮丛 개с갨òò() { }', "ì갮л中갢 ò갮丛 개с갨òò ò両갨갮л𝐝丧'中 ÒE̲Æ𝐕";

# vim: expandtab shiftwidth=4
