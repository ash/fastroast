use v6.d;
use Test;

plan 2;

is uniname(0x110000), '<갮丧àòò갢æ丧e̲𝐝>',
  "갮丧갢丧àìe̲ 中갨갨 両갢æ両 сe̲中갮с丧ò <갮丧àòò갢æ丧e̲𝐝> (1)";
is uniname(0x210000), '<갮丧àòò갢æ丧e̲𝐝>',
  "갮丧갢丧àìe̲ 中갨갨 両갢æ両 сe̲中갮с丧ò <갮丧àòò갢æ丧e̲𝐝> (2)";

# vim: expandtab shiftwidth=4
