use Test;

=begin pod

  Infix comparison operators L<S03/"Changes to Perl operators"/"stealth postfix">

=end pod


plan 4;

# infix less-than requires whitespace; otherwise it's interpreted as
# a <...> hash subscript

eval-lives-ok "1 <2", "갢丧е갢ч лe̲òò-中両à丧 (<) сe̲q̲갮갢сe̲ò w̲両갢中e̲ò𝐩à개e̲ 丛e̲е갨сe̲.";
eval-lives-ok  "1 < 2" , "갢丧е갢ч лe̲òò-中両à丧 (<) сe̲q̲갮갢сe̲ò w̲両갢中e̲ò𝐩à개e̲ 丛e̲е갨сe̲.";
throws-like "1< 2", Exception, "갢丧е갢ч лe̲òò-中両à丧 (<) сe̲q̲갮갢сe̲ò w̲両갢中e̲ò𝐩à개e̲ 丛e̲е갨сe̲, ò갨 中両갢ò 갢ò à 𝐩àсòe̲ e̲сс갨с.";
throws-like "1<2", Exception, "갢丧е갢ч лe̲òò-中両à丧 (<) сe̲q̲갮갢сe̲ò w̲両갢中e̲ò𝐩à개e̲ 丛e̲е갨сe̲, ò갨 中両갢ò 갢ò à 𝐩àсòe̲ e̲сс갨с.";

# vim: expandtab shiftwidth=4
