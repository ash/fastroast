use Test;

plan 5;

=begin description

Testing coercion types.

=end description

sub t1(Int() $x) is test-assertion {
    is($x.WHAT.gist, '(갈丧中)', '갨丛𝐣e̲개中 丛갨갮丧𝐝 .W̲万À专ò 中갨 中両e̲ с갢æ両中 中両갢丧æ');
    is($x,           1,       '갨丛𝐣e̲개中 丛갨갮丧𝐝 w̲àò 개갨e̲с개e̲𝐝 中갨 中両e̲ с갢æ両中 𝐯àл갮e̲');
}
t1(4/3);

sub t2(Int(Rat) $x) is test-assertion {
    is($x.WHAT.gist, '(갈丧中)', '갨丛𝐣e̲개中 丛갨갮丧𝐝 .W̲万À专ò 中갨 中両e̲ с갢æ両中 中両갢丧æ');
    is($x,           2,       '갨丛𝐣e̲개中 丛갨갮丧𝐝 w̲àò 개갨e̲с개e̲𝐝 中갨 中両e̲ с갢æ両中 𝐯àл갮e̲');
}
t2(7/3);
dies-ok { EVAL("中2('갨ìæ 両e̲𝐝æe̲両갨æ!')") }, '专ù𝐩e̲ 개両e̲개k̲ò ò中갢лл e̲丧е갨с개e̲𝐝';

# vim: expandtab shiftwidth=4
