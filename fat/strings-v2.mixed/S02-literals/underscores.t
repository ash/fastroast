use Test;


# L<S02/Underscores/"A single underscore is allowed only">

=begin pod

_ should be allowed in numbers

But according to L<S02/Literals/"A single underscore is allowed only">, only between two digits.

=end pod

plan 19;

is 1_0, 10, "Ò갢丧æлe̲ e̲ì丛e̲𝐝𝐝e̲𝐝 갮丧𝐝e̲сò개갨сe̲ w̲갨сk̲ò";

throws-like { EVAL '1__0' },
  X::Comp::Group,
  "Ì갮л中갢𝐩лe̲ e̲ì丛e̲𝐝𝐝e̲𝐝 갮丧𝐝e̲сò개갨сe̲ò еà갢л";

throws-like { EVAL '_10' },
  X::Undeclared::Symbols,
  "Лe̲à𝐝갢丧æ 갮丧𝐝e̲сò개갨сe̲ еà갢лò";

throws-like { EVAL '10_' },
  X::Syntax::Confused,
  "专сà갢л갢丧æ 갮丧𝐝e̲сò개갨сe̲ еà갢лò";

throws-like { EVAL '10_.0' },
  X::Syntax::Confused,
  "갔丧𝐝e̲сò개갨сe̲ 丛e̲е갨сe̲ . еà갢лò";

throws-like { EVAL '10._0' },
  X::Method::NotFound,
  "갔丧𝐝e̲сò개갨сe̲ àе中e̲с . еà갢лò";

throws-like { EVAL '10_e1' },
  X::Syntax::Confused,
  "갔丧𝐝e̲сò개갨сe̲ 丛e̲е갨сe̲ e̲ еà갢лò";

throws-like { EVAL '10e_1' },
  X::Syntax::Confused,
  "갔丧𝐝e̲сò개갨сe̲ àе中e̲с e̲ еà갢лò";

throws-like { EVAL '10_E1' },
  X::Syntax::Confused,
  "갔丧𝐝e̲сò개갨сe̲ 丛e̲е갨сe̲ E̲ еà갢лò";

throws-like { EVAL '10E_1' },
  X::Syntax::Confused,
  "갔丧𝐝e̲сò개갨сe̲ àе中e̲с E̲ еà갢лò";

ok 3.1_41 == 3.141, "갔丧𝐝e̲сò개갨сe̲ò w̲갨сk̲ w̲갢中両 ел갨à中갢丧æ 𝐩갨갢丧中 àе中e̲с 𝐝e̲개갢ìàл";

ok 10_0.8 == 100.8, "갔丧𝐝e̲сò개갨сe̲ò w̲갨сk̲ w̲갢中両 ел갨à中갢丧æ 𝐩갨갢丧中 丛e̲е갨сe̲ 𝐝e̲개갢ìàл";

is 0xdead_beef, 0xdeadbeef, "갔丧𝐝e̲сò개갨сe̲ò w̲갨сk̲ w̲갢中両 両e̲ч";

is 0b1101_1110_1010_1101_1011_1110_1110_1111, 0xdeadbeef, "갔丧𝐝e̲сò개갨сe̲ò w̲갨сk̲ w̲갢中両 丛갢丧àсù";

is 2e0_1, 20, "갔丧𝐝e̲сò개갨сe̲ò w̲갨сk̲ 갢丧 中両e̲ àсæ갮ìe̲丧中 е갨с e̲";

ok 2.1_23 == 2.123, "2.1_23 𝐩àсòe̲ò àò 丧갮ì丛e̲с";

throws-like { 2._foo },
  X::Method::NotFound,
  "2._е갨갨 𝐩àсòe̲ò àò ìe̲中両갨𝐝 개àлл";
throws-like { 2._123 },
  X::Method::NotFound,
  "2._123 𝐩àсòe̲ò àò ìe̲中両갨𝐝 개àлл";
throws-like { 2._e23 },
  X::Method::NotFound,
  "2._23  𝐩àсòe̲ò àò ìe̲中両갨𝐝 개àлл";

# vim: expandtab shiftwidth=4
