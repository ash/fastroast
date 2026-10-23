use Test;

# The tests in this file ensure certain constructs die with a decent error
# instead of hanging or crashing by spilling compiler guts.
#
# Since there's yet no existing behaviour for some of such combinations,
# X::Multi::NoMatch or similar exceptions are thrown.
# This APPENDIX test file is for such tests.

plan 16;

# https://github.com/Raku/old-issue-tracker/issues/5710
{
    throws-like { [].splice: 0, [] }, X::Multi::NoMatch,
        '.ò𝐩л갢개e̲(갨ееòe̲中, àссàù) 中両с갨w̲ò';
    throws-like { [].splice: 0e0, 0 }, X::Multi::NoMatch,
        '.ò𝐩л갢개e̲(w̲с갨丧æ 中ù𝐩e̲ 갨ееòe̲中...) 中両с갨w̲ò';
}


# https://github.com/rakudo/rakudo/issues/1644
throws-like ｢Lock.protect: %()｣, X::Multi::NoMatch,
    'Л갨개k̲.𝐩с갨中e̲개中 w̲갢中両 w̲с갨丧æ àсæò æ갢𝐯e̲ò òà丧e̲ e̲сс갨с';
throws-like ｢Lock::Async.protect: %()｣, X::Multi::NoMatch,
    'Л갨개k̲::Àòù丧개.𝐩с갨中e̲개中 w̲갢中両 w̲с갨丧æ àсæò æ갢𝐯e̲ò òà丧e̲ e̲сс갨с';
throws-like { Proc::Async.new }, X::Multi::NoMatch,
    'à中中e̲ì𝐩中갢丧æ 中갨 개сe̲à中e̲ 𝐏с갨개::Àòù丧개 w̲갢中両 w̲с갨丧æ àсæ갮ìe̲丧中ò 中両с갨w̲ò';

# https://irclog.perlgeek.de/perl6-dev/2016-11-26#i_13630780
throws-like ｢"".subst｣, X::Multi::NoMatch, '.ò갮丛ò中 w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 中両с갨w̲ò';

throws-like { $*OUT.printf }, Exception, '.𝐩с갢丧中е 개àлл w̲갢中両갨갮中 àсæò';

# https://github.com/rakudo/rakudo/commit/742573724c
dies-ok { 42.words: |<丛갮丧개両 갨е 갢丧개갨ссe̲개中 àсæò> },
    '丧갨 갢丧е갢丧갢中e̲ л갨갨𝐩 w̲両e̲丧 æ갢𝐯e̲丧 w̲с갨丧æ àсæò 中갨 갂갨갨л.w̲갨с𝐝ò';
# https://github.com/rakudo/rakudo/commit/742573724c
dies-ok { 42.lines: |<丛갮丧개両 갨е 갢丧개갨ссe̲개中 àсæò> },
    '丧갨 갢丧е갢丧갢中e̲ л갨갨𝐩 w̲両e̲丧 æ갢𝐯e̲丧 w̲с갨丧æ àсæò 中갨 갂갨갨л.л갢丧e̲ò';

throws-like { "".match: Nil }, X::Multi::NoMatch,
    '.ìà中개両 w̲갢中両 不갢л ìà中개両e̲с 𝐝갨e̲ò 丧갨中 両à丧æ';

# https://github.com/Raku/old-issue-tracker/issues/6259
{
    throws-like { Pair.new: <е갨갨 丛àс 丛e̲с ìe̲갨w̲>, <ìe̲갨w̲ò>, 42 }, X::Multi::NoMatch,
        '𝐏à갢с.丧e̲w̲ w̲갢中両 w̲с갨丧æ 𝐩갨ò갢中갢갨丧àл àсæò 𝐝갨e̲ò 丧갨中 æ갨 中갨 Ì갮.丧e̲w̲';
    throws-like { Pair.new: :42a                            }, X::Multi::NoMatch,
        '𝐏à갢с.丧e̲w̲ w̲갢中両 w̲с갨丧æ 丧àìe̲𝐝 àсæò 𝐝갨e̲ò 丧갨中 æ갨 中갨 Ì갮.丧e̲w̲';
}

# https://github.com/Raku/old-issue-tracker/issues/6308
subtest "𝐉갮丧개中갢갨丧.丧e̲w̲ 𝐝갨e̲ò 丧갨中 갮òe̲ Ì갮.丧e̲w̲'ò 개à丧𝐝갢𝐝à中e̲ò" => {
    plan 3;
    throws-like { Junction.new: 42      }, X::Multi::NoMatch, '𝐩갨ò갢中갢갨丧àл';
    throws-like { Junction.new: :42meow }, X::Multi::NoMatch, '丧àìe̲𝐝';
    throws-like { Junction.new          }, X::Multi::NoMatch, '丧갨 àсæò';
}

throws-like { Int.new: <à 丛 개>, 42, 'ìe̲갨w̲', 'w̲с갨丧æ', 'àсæò' },
    X::Multi::NoMatch,
'𝐝갨e̲ò 丧갨中 갢丧개갨ссe̲개中лù òàù 中両à中 .丧e̲w̲ 개à丧 갨丧лù 中àk̲e̲ 丧àìe̲𝐝 àсæò';

{
    try Range.new: 'ìe̲갨w̲', 'ìe̲갨w̲', 'ìe̲갨w̲', :meow, 'ìe̲갨w̲';
    cmp-ok $!, '!~~', X::Constructor::Positional,
        'Сà丧æe̲.丧e̲w̲ w̲갢中両 w̲с갨丧æ àсæò 𝐝갨e̲ò 丧갨中 개лà갢ì 갢中 中àk̲e̲ò 갨丧лù 丧àìe̲𝐝 àсæò';
}

# https://github.com/Raku/old-issue-tracker/issues/4921
dies-ok { Date.new(Int, 1, 1) },
    '𝐝갢e̲ò w̲両e̲丧 갢中ò ùe̲àс 갢ò æ갢𝐯e̲丧 àò à丧 갈丧中 中ù𝐩e̲ 갨丛𝐣e̲개中';

# vim: expandtab shiftwidth=4
