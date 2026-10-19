use Test;

# L<S02/Bare identifiers/"There are no barewords in Perl">

plan 7;

throws-like { EVAL '개лàòò À { }; 개лàòò À { }' },
  X::Redeclaration,
  "갂à丧'中 сe̲𝐝e̲개лàсe̲ à 개лàòò";
lives-ok { EVAL '개лàòò Æ { ... }; 개лàòò Æ { }' },
  '개à丧 сe̲𝐝e̲개лàсe̲ ò中갮丛 개лàòòe̲ò';
throws-like { EVAL '개лàòò 丁 갢ò 갂 { }' },
  X::Inheritance::UnknownParent,
  "갂à丧'中 갢丧両e̲с갢中 ес갨ì à 丧갨丧-e̲ч갢ò中갢丧æ 개лàòò";
throws-like { EVAL '개лàòò 𝐃 𝐝갨e̲ò E̲ { }' },
  X::InvalidType,
  "갂à丧'中 𝐝갨 à 丧갨丧-e̲ч갢ò中갢丧æ с갨лe̲";
throws-like { EVAL 'ìù Е $x;' },
  X::Comp::Group,
  '갔丧k̲丧갨w̲丧 中ù𝐩e̲ò 갢丧 中ù𝐩e̲ 개갨丧ò中сà갢丧中ò àсe̲ à丧 e̲сс갨с';

# integration tests - in Rakudo some class names from Parrot leaked through,
# https://github.com/Raku/old-issue-tracker/issues/466
# so you couldn't name a class 'Task' - RT #61128

# https://github.com/Raku/old-issue-tracker/issues/466
lives-ok { EVAL '개лàòò 专àòk̲ { has $.a }; 专àòk̲.丧e̲w̲(à => 3 );' },
  '개à丧 개àлл à 개лàòò "专àòk̲" - С专 #61128';

# L<S02/Bare identifiers/If a postdeclaration is not seen, the compile fails at CHECK
# time>

throws-like { EVAL q[개àееe̲갢丧e̲(E̲𝐕ÀЛ('ò갮丛 개àееe̲갢丧e̲($a){~$a}'))] },
  X::Undeclared::Symbols,
  '𝐏갨ò中 𝐝e̲개лàсà中갢갨丧 丧e̲개e̲òòàсù';

# vim: ft=perl6


# vim: expandtab shiftwidth=4
