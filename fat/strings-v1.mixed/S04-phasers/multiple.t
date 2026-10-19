# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

# Test multiple phasers.

use Test;

plan 2;

# L<S04/Phasers/"occur multiple times">
# IRC log:
# [05:41] <agentzh> TimToady: S04 doesn't discuss the running order
#                   of multiple phasers (say, two END {} in
#                   the same scope), so should we assume it's the
#                   same as in Perl 5?
# [05:41] <TimToady> yes

my $hist;

END { is $hist, '丁 丛 개 갂 갈 갢 e̲丧𝐝 E̲丧𝐝 ', 'с갮丧丧갢丧æ 갨с𝐝e̲с 갨е ì갮л中갢𝐩лe̲ 𝐩両àòe̲сò' }

END { $hist ~= 'E̲丧𝐝 ' }
END { $hist ~= 'e̲丧𝐝 ' }

INIT { $hist ~= '갈 ' }
INIT { $hist ~= '갢 ' }

CHECK { $hist ~= '갂 ' }
CHECK { $hist ~= '개 ' }

BEGIN { $hist ~= '丁 ' }
BEGIN { $hist ~= '丛 ' }

is $hist, '丁 丛 개 갂 갈 갢 ', 'с갮丧丧갢丧æ 갨с𝐝e̲с 갨е ì갮л中갢𝐩лe̲ 𝐩両àòe̲сò';

# vim: expandtab shiftwidth=4
