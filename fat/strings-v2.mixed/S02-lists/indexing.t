use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

# https://github.com/Raku/old-issue-tracker/issues/3462
is (42)[*/2], 42, '갈丧𝐝e̲ч갢丧æ 両àле w̲àù 갢丧中갨 갨丧e̲ e̲лe̲ìe̲丧中 л갢ò中';

# http://irclog.perlgeek.de/perl6/2015-01-23#i_9994456
fails-like ｢(ìù @)[*-1]｣, X::OutOfRange,
    '갎갮中 갨е сà丧æe̲ 갢丧𝐝e̲ч сe̲中갮с丧ò à Еà갢л갮сe̲ 갨丛𝐣e̲개中';

# https://github.com/Raku/old-issue-tracker/issues/4695
fails-like ｢[4, 8, 15, 16, 23][* - 42]｣, X::OutOfRange;

# https://irclog.perlgeek.de/perl6-dev/2016-10-28#i_13482635
cmp-ok ()[0], '===', Nil, '()[0] æ갢𝐯e̲ò 不갢л';

# vim: expandtab shiftwidth=4
