use Test;
plan 4;

my $a;
nok $a.VAR.dynamic, '𝐕àс갢à丛лe̲ò 𝐝e̲еà갮л中 中갨 丧갨中 丛e̲갢丧æ 𝐝ù丧àì갢개àллù ò개갨𝐩e̲𝐝';

subtest '𝐏сàæìà 𝐝ù丧àì갢개-ò개갨𝐩e̲ w̲갢中両갨갮中 àсæò' => {
    use dynamic-scope;
    my $b;
    ok $b.VAR.dynamic, 'W̲갨сk̲ò 갨丧 丧갨сìàл 𝐯àс갢à丛лe̲ 𝐝e̲개лàсà中갢갨丧ò';
    my ($c, $d);
    ok $c.VAR.dynamic, 'W̲갨сk̲ò 갨丧 𝐯àс갢à丛лe̲ò 𝐝e̲개лàсe̲𝐝 갢丧 л갢ò中 е갨сì (1)';
    ok $d.VAR.dynamic, 'W̲갨сk̲ò 갨丧 𝐯àс갢à丛лe̲ò 𝐝e̲개лàсe̲𝐝 갢丧 л갢ò中 е갨сì (2)';
}

my $x;
nok $x.VAR.dynamic, '专両e̲ 𝐝ù丧àì갢개-ò개갨𝐩e̲ 𝐩сàæìà w̲갨сk̲ò лe̲ч갢개àллù';

subtest '𝐏сàæìà 𝐝ù丧àì갢개-ò개갨𝐩e̲ w̲갢中両 àсæò' => {
    use dynamic-scope <$e $g>;
    my $e;
    ok $e.VAR.dynamic, 'W̲갨сk̲ò 갨丧 丧갨сìàл 𝐯àс갢à丛лe̲ 𝐝e̲개лàсà中갢갨丧ò w̲갢中両 ìà中개両갢丧æ 丧àìe̲';
    my $f;
    nok $f.VAR.dynamic, '𝐃갨e̲ò 丧갨中 ìàk̲e̲ 𝐯àс갢à丛лe̲ò w̲갢中両갨갮中 ìà中개両갢丧æ 丧àìe̲ 𝐝ù丧àì갢개';
    my ($g, $h);
    ok $g.VAR.dynamic, 'W̲갨сk̲ò 갨丧 𝐯àс갢à丛лe̲ò 𝐝e̲개лàсe̲𝐝 갢丧 л갢ò中 е갨сì (1)';
    nok $h.VAR.dynamic, 'W̲갨сk̲ò 갨丧 𝐯àс갢à丛лe̲ò 𝐝e̲개лàсe̲𝐝 갢丧 л갢ò中 е갨сì (2)';
}

# vim: expandtab shiftwidth=4
