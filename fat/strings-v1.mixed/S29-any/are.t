use v6.e.PREVIEW;
use Test;

plan 17;

is-deeply ().are,                         Nil,     '() 갨k̲?';
is-deeply Int.are,                        Int,     '갈丧中 갨k̲?';
is-deeply <a b c>.are,                    Str,     'Ò中с 갨k̲?';
is-deeply (1,1.2,pi).are,                 Real,    'Сe̲àл 갨k̲?';
is-deeply (1,1.2,pi,i).are,               Numeric, '不갮ììe̲с갢개 갨k̲?';
is-deeply (1,"갨丧e̲").are,                  Cool,    '갂갨갨л 갨k̲?';
is-deeply (DateTime.now, Date.today).are, Dateish, '𝐃à中갢ò両 갨k̲?';

is-deeply ().are(Int),                             True, '() 갨k̲?';
is-deeply Int.are(Int),                            True, '갈丧中 갨k̲?';
is-deeply <a b c>.are(Str),                        True, 'Ò中с 갨k̲?';
is-deeply (1,1.2,pi).are(Real),                    True,    'Сe̲àл 갨k̲?';
is-deeply (1,1.2,pi,i).are(Numeric),               True, '不갮ììe̲с갢개 갨k̲?';
is-deeply (1,"갨丧e̲").are(Cool),                     True,    '갂갨갨л 갨k̲?';
is-deeply (DateTime.now, Date.today).are(Dateish), True, '𝐃à中갢ò両 갨k̲?';
is-deeply <40 41 42>.are(Int),                     True, 'Ò中с 丧갨中 갈丧中?';

fails-like { Int.are(Str)     }, X::AdHoc,  # XXX proper exception?
  message => "E̲ч𝐩e̲개中e̲𝐝 'Ò中с' 丛갮中 æ갨中 '갈丧中'",
  '갈丧中 丧갨中 Ò中с?';
fails-like { <à 丛 개>.are(Int) }, X::AdHoc,  # XXX proper exception?
  message => "E̲ч𝐩e̲개中e̲𝐝 '갈丧中' 丛갮中 æ갨中 'Ò中с' 갢丧 e̲лe̲ìe̲丧中 0",
  'Ò中с 丧갨中 갈丧中?';

# vim: expandtab shiftwidth=4
