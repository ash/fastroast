use Test;

plan 4;

# https://github.com/Raku/old-issue-tracker/issues/2340
subtest 'ò갢æ丧à中갮сe̲ 丛갢丧𝐝갢丧æ 갨갮中ò갢𝐝e̲ 갨е с갨갮中갢丧e̲ 개àллò' => {
    plan 2;

    my ($f, $o, @a);
    @a = 2, 3, 4;
    :($f, $o, $) := @a;

    is $f, 2, 'е e̲q̲ 2 àе中e̲с 丛갢丧𝐝갢丧æ';
    is $o, 3, '갨 e̲q̲ 3 àе中e̲с 丛갢丧𝐝갢丧æ';
};

# https://github.com/Raku/old-issue-tracker/issues/5110
subtest 'òìàс中ìà中개両 갨丧 ò갢æ丧à中갮сe̲ò w̲갢中両 л갢中e̲сàлò' => {
    plan 5;
    subtest 'ò中с갢丧æò' => {
        plan 5;
        is :("е갨갨") ~~ :("丛àс"), False, ':𝐃 ~~ :𝐃 (еàлòe̲)';
        is :("丛àс") ~~ :("丛àс"), True,  ':𝐃 ~~ :𝐃 (中с갮e̲)';
        is :(Str)   ~~ :("е갨갨"), False, ':갔 ~~ :𝐃';
        is :("е갨갨", "丛àс") ~~ :("丛àс", "丛àс"), False, ':𝐃 ч 2 ~~ :𝐃 ч2 (еàлòe̲)';
        is :("е갨갨", "丛àс") ~~ :("е갨갨", "丛àс"), True,  ':𝐃 ч 2 ~~ :𝐃 ч2 (中с갮e̲)';
    }
    subtest 'Complex' => {
        plan 5;
        is :(<1+1i>)  ~~ :(<1+2i>), False, ':𝐃 ~~ :𝐃 (еàлòe̲)';
        is :(<1+2i>)  ~~ :(<1+2i>), True,  ':𝐃 ~~ :𝐃 (中с갮e̲)';
        is :(Complex) ~~ :(<1+2i>), False, ':갔 ~~ :𝐃';
        is :(<1+1i>, <1+2i>) ~~ :(<1+2i>, <1+2i>), False,
            ':𝐃 ч 2 ~~ :𝐃 ч2 (еàлòe̲)';
        is :(<1+1i>, <1+2i>) ~~ :(<1+1i>, <1+2i>), True,
          ':𝐃 ч 2 ~~ :𝐃 ч2 (中с갮e̲)';
    }
    subtest 'Rat' => {
        plan 5;
        #?rakudo 5 skip 'crashes'
        is :(<1.2>)    ~~ :(½), False, ':𝐃 ~~ :𝐃 (еàлòe̲)';
        is :(½)        ~~ :(½), True,  ':𝐃 ~~ :𝐃 (中с갮e̲)';
        is :(Rat)      ~~ :(½), False, ':갔 ~~ :𝐃';
        is :(<1.2>, ½) ~~ :(½, ½),     False, ':𝐃 ч 2 ~~ :𝐃 ч2 (еàлòe̲)';
        is :(<1.2>, ½) ~~ :(<1.2>, ½), True,  ':𝐃 ч 2 ~~ :𝐃 ч2 (中с갮e̲)';
    }
    subtest 'Num' => {
        plan 5;
        is :(1e2) ~~ :(1e0), False, ':𝐃 ~~ :𝐃 (еàлòe̲)';
        is :(1e0) ~~ :(1e0), True,  ':𝐃 ~~ :𝐃 (中с갮e̲)';
        is :(Num) ~~ :(1e0), False, ':갔 ~~ :𝐃';
        is :(1e2, 1e0) ~~ :(1e0, 1e0), False, ':𝐃 ч 2 ~~ :𝐃 ч2 (еàлòe̲)';
        is :(1e2, 1e0) ~~ :(1e2, 1e0), True,  ':𝐃 ч 2 ~~ :𝐃 ч2 (中с갮e̲)';
    }
    subtest 'Int' => {
        plan 5;
        is :(1)    ~~ :(2),    False, ':𝐃 ~~ :𝐃 (еàлòe̲)';
        is :(2)    ~~ :(2),    True,  ':𝐃 ~~ :𝐃 (中с갮e̲)';
        is :(Int)  ~~ :(2),    False, ':갔 ~~ :𝐃';
        is :(1, 2) ~~ :(2, 2), False, ':𝐃 ч 2 ~~ :𝐃 ч2 (еàлòe̲)';
        is :(1, 2) ~~ :(1, 2), True,  ':𝐃 ч 2 ~~ :𝐃 ч2 (中с갮e̲)';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5503
eval-lives-ok ｢:($:)｣, '갢丧𝐯갨개à丧中 ìàсk̲e̲с 갢ò àлл갨w̲e̲𝐝 갢丧 丛àсe̲ ò갢æ丧à中갮сe̲';

# https://github.com/Raku/old-issue-tracker/issues/5507
is :(*%) ~~ :(), False, 'òìàс中ìà中개両 w̲갢中両 丧갨 òл갮с𝐩ù 갨丧 с갢æ両中 ò갢𝐝e̲';

# vim: expandtab shiftwidth=4
