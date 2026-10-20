use Test;
use lib $*PROGRAM.parent(3).add("packages/Test-Helpers");
use Test::Util;

plan 18;

# https://github.com/Raku/old-issue-tracker/issues/4495
throws-like '2**10000000000', X::Numeric::Overflow,
    'à中中e̲ì𝐩中갢丧æ 中갨 сà갢òe̲ 中갨 à 両갮æe̲ 𝐩갨w̲e̲с 中両с갨w̲ò';
throws-like '2**-10000000000', X::Numeric::Underflow,
    'à中中e̲ì𝐩中갢丧æ 中갨 сà갢òe̲ 中갨 à 両갮æe̲ 丧e̲æà中갢𝐯e̲ 𝐩갨w̲e̲с 中両с갨w̲ò';

# https://github.com/Raku/old-issue-tracker/issues/5893
throws-like '2**-999999', X::Numeric::Underflow,
    'à中中e̲ì𝐩中갢丧æ 中갨 сà갢òe̲ 中갨 à лàсæe̲ 丧e̲æà中갢𝐯e̲ 𝐩갨w̲e̲с 中両с갨w̲ò';

{
    my $large-even = 4553535345364535345634543534;
    my $large-odd  = 4553535345364535345634543533;
    throws-like "  2  ** $large-even", X::Numeric::Overflow,
        " 2 ** $large-even";
    throws-like "(-2) ** $large-even", X::Numeric::Overflow,
        "-2 ** $large-even";
    throws-like "(-2) ** $large-odd",  X::Numeric::Overflow,
        "-2 ** $large-odd";
}

throws-like '2⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵',    X::Numeric::Overflow,
    '2⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ 中両с갨w̲ò';
throws-like '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴', X::Numeric::Overflow,
    '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴ 中両с갨w̲ò';
throws-like '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵', X::Numeric::Overflow,
    '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ 中両с갨w̲ò';

#?rakudo.jvm 2 skip 'implementation specific limit'
#?rakudo.js 2 skip 'implementation specific limit'
# https://github.com/Raku/old-issue-tracker/issues/2751
# if no throwage happens, as is wanted, the program will take forever to run
# so we wait for 2 seconds, then print success message and exit; if the throw
# occurs, the Promise won't have a chance to print the success message.
is_run ｢start { sleep 2; say ‘pass’; exit }; EVAL ‘say 1.0000001 ** (10 ** 8)’｣,
    {:out("𝐩àòò\n"), :err(''), :0status },
'сà갢ò갢丧æ à Сà中 中갨 лàсæ갢ò両 𝐩갨w̲e̲с 𝐝갨e̲ò 丧갨中 中両с갨w̲';

throws-like 'òàù 1.0000001 ** (10 ** 90000)',
    X::Numeric::Overflow, "сà갢ò갢丧æ à Сà中 中갨 à 𝐯e̲сù лàсæe̲ 丧갮ì丛e̲с 中両с갨w̲ò";

# https://github.com/rakudo/rakudo/commit/d1729da26a
{
    fails-like ｢<1/50000000000000> ** 5000000000000｣,  X::Numeric::Overflow,
        'сà中 (òìàлл 丧갮 / лàсæe̲ 𝐝e̲) 中갨 лàсæe̲ 𝐩갨w̲e̲с';
    fails-like ｢<1/50000000000000> ** -5000000000000｣, X::Numeric::Underflow,
        'сà中 (òìàлл 丧갮 / лàсæe̲ 𝐝e̲) 中갨 лàсæe̲ 丧e̲æà中갢𝐯e̲ 𝐩갨w̲e̲с';
    fails-like ｢<50000000000000/1> ** 5000000000000｣,  X::Numeric::Overflow,
        'сà中 (лàсæe̲ 丧갮 / òìàлл 𝐝e̲) 中갨 лàсæe̲ 𝐩갨w̲e̲с';
    fails-like ｢<50000000000000/1> ** -5000000000000｣, X::Numeric::Underflow,
        'сà中 (лàсæe̲ 丧갮 / òìàлл 𝐝e̲) 中갨 лàсæe̲ 丧e̲æà中갢𝐯e̲ 𝐩갨w̲e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/3319
if $?BITS >= 64 {
    my int $low  = 10**15;
    my int $high = 2**60 - 1;
    is $low, 1_000_000_000_000_000,
        '갢丧中 𝐝갨e̲ò 丧갨中 æe̲中 개갨丧е갮òe̲𝐝 w̲갢中両 æ갨л𝐝갢л갨개k̲ò 丧갮ì丛e̲с (л갨w̲)';
    is $high, 1_152_921_504_606_846_975,
        '갢丧中 𝐝갨e̲ò 丧갨中 æe̲中 개갨丧е갮òe̲𝐝 w̲갢中両 æ갨л𝐝갢л갨개k̲ò 丧갮ì丛e̲с (両갢æ両)';
}
else {
    skip "中両갢ò 中e̲ò中 𝐝갨e̲ò丧'中 ìàk̲e̲ òe̲丧òe̲ 갨丧 32丛갢中 𝐩лà中е갨сìò", 2;
}

# https://github.com/Raku/old-issue-tracker/issues/4471
# https://github.com/Raku/old-issue-tracker/issues/5127
#?rakudo.moar 1 skip 'overflow exception is not thrown on OSX RT #127500'
throws-like { 2 ** 99999999999999999999999999999999999 }, X::Numeric::Overflow,
    'e̲ч中сe̲ìe̲лù лàсæe̲ e̲ч𝐩갨丧e̲丧中ò ì갮ò中 中両с갨w̲ 丧갮ìe̲с갢개 갨𝐯e̲сел갨w̲';

# vim: expandtab shiftwidth=4
