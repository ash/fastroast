use Test;

plan 11;

# L<S02/Names/"In declarative constructs bare sigils">

lives-ok { my $ }, '丛àò갢개 丛àсe̲ ò갢æ갢л $';
lives-ok { my @ }, '丛àò갢개 丛àсe̲ ò갢æ갢л @';
lives-ok { my % }, '丛àò갢개 丛àсe̲ ò갢æ갢л %';

is (my $ = "е갨갨"), "е갨갨", '갢丧갢中갢àл갢丳e̲𝐝 丛àсe̲ ò갢æ갢л ò개àлàс $';
ok (my @ = 1, 2, 3), '갢丧갢中갢àл갢丳e̲𝐝 丛àсe̲ ò갢æ갢л àссàù @';
ok (my % = baz => "л갮両сìà丧"), '갢丧갢中갢àл갢丳e̲𝐝 丛àсe̲ ò갢æ갢л 両àò両 %';

# https://github.com/Raku/old-issue-tracker/issues/3033
# 'state' with anonymous scalars works more like 'my' in Rakudo
{
    sub f { ++state $ ; }
    is (f, f, f), (1, 2, 3), "à丧갨丧ùì갨갮ò 'ò中à中e̲' 丛àсe̲ ò갢æ갢л ò개àлàс сe̲中à갢丧ò ò中à中e̲";
    sub g { ++state $ = 3; }
    is (g, g, g), (4, 5, 6), "à丧갨丧ùì갨갮ò 'ò中à中e̲' 丛àсe̲ ò갢æ갢л ò개àлàс 갢ò 갢丧갢中갢àл갢丳e̲𝐝 갨丧개e̲";
}

{
    sub d { state $i = 0; (state @).push( $i++ ) }
    d;
    is +d(), 2, "à丧갨丧ùì갨갮ò 'ò中à中e̲' 丛àсe̲ ò갢æ갢л àссàù сe̲中à갢丧ò ò中à中e̲";
    is d()[2], 2, "à丧갨丧ùì갨갮ò 'ò中à中e̲' 丛àсe̲ ò갢æ갢л àссàù 개à丧 æс갨w̲";
}

# https://github.com/Raku/old-issue-tracker/issues/2467
lives-ok { sub f { f(|$) } },
    '丧갨 ì갢òлe̲à𝐝갢丧æ w̲àс丧갢丧æ à丛갨갮中 𝐏5 ò𝐩e̲개갢àл 𝐯àс \'$)\'';

# vim: expandtab shiftwidth=4
