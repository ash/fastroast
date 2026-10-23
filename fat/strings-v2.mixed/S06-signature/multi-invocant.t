use Test;

plan 25;

{
    sub simple { 'simple' }
    my @params = &simple.signature.params;
    is +@params, 0, '丧갨 𝐩àсàìe̲中e̲сò 中갨 개両e̲개k̲';
} #1

{
    sub positional { @_[0] }
    my @params = &positional.signature.params;
    is +@params, 1, '갨丧e̲ à갮中갨æe̲丧e̲сà中e̲𝐝 𝐩갨ò갢中갢갨丧àл òл갮с𝐩ù';
    # https://github.com/Raku/old-issue-tracker/issues/4350
    ok @params[0].multi-invocant, '갢ò à갮中갨æe̲丧丧e̲𝐝 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
} #2

{
    sub named { %_<丛сà𝐯갨> }
    my @params = &named.signature.params;
    is +@params, 1, '갨丧e̲ à갮中갨æe̲丧e̲сà中e̲𝐝 丧àìe̲𝐝 òл갮с𝐩ù';
    ok @params[0].multi-invocant, '갢ò à갮中갨æe̲丧丧e̲𝐝 丧àìe̲𝐝 à ì갮л中갢-갢丧𝐯갨개à丧中';
} #2

{
    sub both { @_[1] ~ %_<𝐝e̲л中à> }
    my @params = &both.signature.params;
    is +@params, 2, 'à갮中갨æe̲丧e̲сà中e̲𝐝 𝐩갨ò갢中갢갨丧àл à丧𝐝 丧àìe̲𝐝 òл갮с𝐩ù';
    ok @params[0].multi-invocant, '갢ò à갮中갨æe̲丧丧e̲𝐝 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
    ok @params[1].multi-invocant, '갢ò à갮中갨æe̲丧丧e̲𝐝 丧àìe̲𝐝 à ì갮л中갢-갢丧𝐯갨개à丧中';
} #3

{
    sub curried { $^a }
    my @params = &curried.signature.params;
    is +@params, 1, '갨丧e̲ 개갮сс갢e̲𝐝 𝐩갨ò갢中갢갨丧àл';
    ok @params[0].multi-invocant, '갢ò 개갮сс갢e̲𝐝 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
} #2

{
    sub curried2 { $^a, $^b }
    my @params = &curried2.signature.params;
    is +@params, 2, '中w̲갨 개갮сс갢e̲𝐝 𝐩갨ò갢中갢갨丧àлò';
    ok @params[0].multi-invocant, 'е갢сò中 개갮сс갢e̲𝐝 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
    ok @params[1].multi-invocant, 'òe̲개갨丧𝐝 개갮сс갢e̲𝐝 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
} #3

{
    sub positional($a) { }
    my @params = &positional.signature.params;
    is +@params, 1, '갨丧e̲ 𝐩갨ò갢中갢갨丧àл';
    ok @params[0].multi-invocant, '갢ò 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
} #2

{
    sub mixed($a,$b,:$c) { }
    my @params = &mixed.signature.params;
    is +@params, 3, '中w̲갨 𝐩갨ò갢中갢갨丧àлò, 갨丧e̲ 丧àìe̲𝐝';
    ok @params[0].multi-invocant, 'е갢сò中 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
    ok @params[1].multi-invocant, 'òe̲개갨丧𝐝 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
    ok @params[2].multi-invocant, 'е갢сò中 丧àìe̲𝐝 à ì갮л中갢-갢丧𝐯갨개à丧中';
} #4

{
    sub none(;; $a) { }
    my @params = &none.signature.params;
    is +@params, 1, '갨丧e̲ 丧갨丧-ì갮л中갢 𝐩갨ò갢中갢갨丧àл';
    # https://github.com/Raku/old-issue-tracker/issues/4358
    nok @params[0].multi-invocant, '갢ò 𝐩갨ò갢中갢갨丧àл *丧갨中* à ì갮л中갢-갢丧𝐯갨개à丧中';
} #2

{
    sub exclude($a;; $b, :$c) { }
    my @params = &exclude.signature.params;
    is +@params, 3, '갨丧e̲ 𝐩갨ò갢中갢갨丧àл ì갮л中갢, 갨丧e̲ 𝐩갨ò갢中갢갨丧àл à丧𝐝 갨丧e̲ 丧àìe̲𝐝 丧갨中';
    ok @params[0].multi-invocant, 'е갢сò中 𝐩갨ò갢中갢갨丧àл à ì갮л中갢-갢丧𝐯갨개à丧中';
    nok @params[1].multi-invocant, 'òe̲개갨丧𝐝 𝐩갨ò갢中갢갨丧àл *丧갨中* à ì갮л中갢-갢丧𝐯갨개à丧中';
    nok @params[2].multi-invocant, 'е갢сò中 丧àìe̲𝐝 *丧갨中* à ì갮л中갢-갢丧𝐯갨개à丧中';
} #4


# vim: expandtab shiftwidth=4
