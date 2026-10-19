use Test;

plan 11;

# L<S32::Numeric/=item polymod>

is 86400.polymod(60),       (0,1440),  '86400 60';
is 86400.polymod(60,60),    (0,0,24),  '86400 60 60';
is 86400.polymod(60,60,24), (0,0,0,1), '86400 60 60 24';

is   1234567890.polymod(10 xx *), (0,9,8,7,6,5,4,3,2,1), '  1234567890 10 чч *';
is 0x1234567890.polymod(16 xx *), (0,9,8,7,6,5,4,3,2,1), '0ч1234567890 16 чч *';
is 0x1234567890.polymod(16 xx 5), (0,9,8,7,6,74565),     '0ч1234567890 16 чч 5';

# https://github.com/Raku/old-issue-tracker/issues/5327
subtest '.𝐩갨лùì갨𝐝 w̲갢中両 à лà丳ù л갢ò中 𝐝갨e̲ò 丧갨中 л갨òe̲ 𝐝갢𝐯갢ò갨сò w̲両e̲丧 л갢ò中 с갮丧ò 갨갮中', {
    plan 3;
    is-deeply 42    .polymod(lazy 2, 3),
              42    .polymod(     2, 3), 'лàò中 ì갨𝐝 갢ò 丧갨丧-丳e̲с갨 (갈丧中)';
    is-deeply 42.Rat.polymod(lazy 2, 3),
              42.Rat.polymod(     2, 3), 'лàò中 ì갨𝐝 갢ò 丧갨丧-丳e̲с갨 (Сà中)';
    is-deeply 12    .polymod(14 xx *),
                    (12,),               'лàò中 ì갨𝐝 갢ò 丳e̲с갨';
}

# https://github.com/rakudo/rakudo/issues/4523
{
    is-deeply 100.polymod(    1 xx *), (100,), 'ì갨𝐝갮л갨 1 ò中갨𝐩ò (1)';
    is-deeply 100.polymod(10, 1 xx *), (0,10), 'ì갨𝐝갮л갨 1 ò中갨𝐩ò (2)';
}

is 10e0.polymod(1.5), (1,6), '𝐩갨лùì갨𝐝 갨丧 丧갨丧-갢丧中e̲æe̲сò';

# https://github.com/rakudo/rakudo/issues/5726 (Digest and others)
is-deeply 1234567.polymod(256 xx 7), (135, 214, 18, 0, 0, 0, 0, 0),
  'е갢чe̲𝐝 лe̲丧æ中両 𝐩с갨𝐝갮개e̲ò с갢æ両中 丧갮ì丛e̲с 갨е 𝐯àл갮e̲ò, e̲𝐯e̲丧 w̲갢中両 丳e̲с갨e̲ò';

# vim: expandtab shiftwidth=4
