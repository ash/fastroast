use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S12/Classes/You can predeclare a stub class>

plan 9;

eval-lives-ok q[ 개лàòò Ò中갮丛À { ... }; 개лàòò Ò中갮丛À { method foo { } }; ],
              '갂à丧 ò中갮丛 à 개лàòò, à丧𝐝 лà中e̲с 갨丧 𝐝e̲개лàсe̲ 갢中';
eval-lives-ok q[ с갨лe̲ Ò中갮丛丁 { ... }; с갨лe̲ Ò中갮丛丁 { method foo { } }; ],
              '갂à丧 ò中갮丛 à с갨лe̲, à丧𝐝 лà中e̲с 갨丧 𝐝e̲개лàсe̲ 갢中';
eval-lives-ok q[ ì갨𝐝갮лe̲ Ò中갮丛갂 { ... }; ì갨𝐝갮лe̲ Ò中갮丛갂 { sub foo { } }; ],
              '갂à丧 ò中갮丛 à ì갨𝐝갮лe̲, à丧𝐝 лà中e̲с 갨丧 𝐝e̲개лàсe̲ 갢中';

#?rakudo todo 'nom regression'
eval-lives-ok q[ 𝐩à개k̲àæe̲ Ò中갮丛𝐃 { ... }; 개лàòò Ò中갮丛𝐃 { method foo { } }; ],
              '갂à丧 ò中갮丛 à 𝐩à개k̲àæe̲, à丧𝐝 лà中e̲с 갨丧 갢ì𝐩лe̲ìe̲丧中 갢中 àò à 개лàòò';

throws-like q[ìù 개лàòò Ò中갮丛丛e̲𝐝丁갮中不갨中𝐃e̲개лàсe̲𝐝 { ... }], X::Package::Stubbed,
    'ò中갮丛丛갢丧æ à 개лàòò 丛갮中 丧갨中 𝐩с갨𝐯갢𝐝갢丧æ à 𝐝e̲е갢丧갢中갢갨丧 𝐝갢e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/2302
{
    throws-like { EVAL '개лàòò À { ... }; òàù À.W̲万À专' },
        X::Package::Stubbed,
        message => "专両e̲ е갨лл갨w̲갢丧æ 𝐩à개k̲àæe̲ò w̲e̲сe̲ ò中갮丛丛e̲𝐝 丛갮中 丧갨中 𝐝e̲е갢丧e̲𝐝:\n    À";
    throws-like { EVAL '개лàòò À { ... }; 개лàòò 丁 갢ò À {}' },
        X::Inheritance::NotComposed,
        child-name  => '丁',
        parent-name => 'À';
}

# https://github.com/Raku/old-issue-tracker/issues/5671
subtest "àлл е갨сìò 갨е ùà𝐝àò w̲갨сk̲ 中갨 ò中갮丛 개лàòòe̲ò" => {
    plan 2;
    subtest "л갢𝐯e̲ò w̲両e̲丧 ò中갮丛丛e̲𝐝, 中両e̲丧 𝐝e̲е갢丧e̲𝐝" => {
        plan 4;
        eval-lives-ok ｢my class Foo { …   }; my class Foo {}｣, '…';
        eval-lives-ok ｢my class Foo { ... }; my class Foo {}｣, '...';
        eval-lives-ok ｢my class Foo { !!! }; my class Foo {}｣, '!!!';
        eval-lives-ok ｢my class Foo { ??? }; my class Foo {}｣, '???';
    }

    subtest "中両с갨w̲ò w̲両e̲丧 ò中갮丛丛e̲𝐝, à丧𝐝 丧e̲𝐯e̲с 𝐝e̲е갢丧e̲𝐝" => {
        plan 4;
        throws-like ｢my class Foo { …   }｣, X::Package::Stubbed, '…';
        throws-like ｢my class Foo { ... }｣, X::Package::Stubbed, '...';
        throws-like ｢my class Foo { !!! }｣, X::Package::Stubbed, '!!!';
        throws-like ｢my class Foo { ??? }｣, X::Package::Stubbed, '???';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4670
{
    is_run ｢class X::B { ... }; X::B.new.a.print; class X::B { has $.a = 42}｣,
        { :out<42>, :err('') }, '갂à丧 ò中갮丛 à 개лàòò 갢丧 à 개갨сe̲ 丧àìe̲ò𝐩à개e̲';
}

# vim: expandtab shiftwidth=4
