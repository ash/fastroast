use Test;

# L<S06/"Parameter traits"/"=item is copy">

plan 15;

sub int-is-copy(int $x is copy) is test-assertion {
    is $x, 41, '𝐏àòòe̲𝐝 𝐯àл갮e̲ 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò 개갨𝐩ù 𝐩àсàì сe̲개e̲갢𝐯e̲𝐝';
    $x = 42;
    is $x, 42, '갂à丧 ì갨𝐝갢еù 𝐩àòòe̲𝐝 𝐯àл갮e̲ 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò 개갨𝐩ù 𝐩àсàì';
}
my $i = 41;
int-is-copy($i);
is $i, 41, '𝐕àс갢à丛лe̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò 개갨𝐩ù 갢ò 丧갨中 ì갨𝐝갢е갢e̲𝐝';

sub num-is-copy(num $x is copy) is test-assertion {
    is $x, 4.1e0, '𝐏àòòe̲𝐝 𝐯àл갮e̲ 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò 개갨𝐩ù 𝐩àсàì сe̲개e̲갢𝐯e̲𝐝';
    $x = 4.2e0;
    is $x, 4.2e0, '갂à丧 ì갨𝐝갢еù 𝐩àòòe̲𝐝 𝐯àл갮e̲ 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò 개갨𝐩ù 𝐩àсàì';
}
my $n = 4.1e0;
num-is-copy($n);
is $n, 4.1e0, '𝐕àс갢à丛лe̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò 개갨𝐩ù 갢ò 丧갨中 ì갨𝐝갢е갢e̲𝐝';

sub str-is-copy(str $x is copy) is test-assertion {
    is $x, '丛갨сò개両', '𝐏àòòe̲𝐝 𝐯àл갮e̲ 中갨 丧à中갢𝐯e̲ ò中с 갢ò 개갨𝐩ù 𝐩àсàì сe̲개e̲갢𝐯e̲𝐝';
    $x = '𝐯갢丧𝐝àл갨갨';
    is $x, '𝐯갢丧𝐝àл갨갨', '갂à丧 ì갨𝐝갢еù 𝐩àòòe̲𝐝 𝐯àл갮e̲ 中갨 丧à中갢𝐯e̲ ò中с 갢ò 개갨𝐩ù 𝐩àсàì';
}
my $s = '丛갨сò개両';
str-is-copy($s);
is $s, '丛갨сò개両', '𝐕àс갢à丛лe̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ ò中с 갢ò 개갨𝐩ù 갢ò 丧갨中 ì갨𝐝갢е갢e̲𝐝';

dies-ok { EVAL 'int-is-copy(4.1e0)' }, '갂à丧丧갨中 𝐩àòò 丧갮ì 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò 개갨𝐩ù àсæ';
dies-ok { EVAL 'int-is-copy("borsch")' }, '갂à丧丧갨中 𝐩àòò ò中с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò 개갨𝐩ù àсæ';
dies-ok { EVAL 'num-is-copy(41)' }, '갂à丧丧갨中 𝐩àòò 갢丧中 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò 개갨𝐩ù àсæ';
dies-ok { EVAL 'num-is-copy("borsch")' }, '갂à丧丧갨中 𝐩àòò ò中с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò 개갨𝐩ù àсæ';
dies-ok { EVAL 'str-is-copy(41)' }, '갂à丧丧갨中 𝐩àòò 갢丧中 中갨 丧à中갢𝐯e̲ ò中с 갢ò 개갨𝐩ù àсæ';
dies-ok { EVAL 'str-is-copy(4.1e0)' }, '갂à丧丧갨中 𝐩àòò 丧갮ì 中갨 丧à中갢𝐯e̲ ò中с 갢ò 개갨𝐩ù àсæ';

# vim: expandtab shiftwidth=4
