use Test;

plan 9;

for <id need loaded>.combinations[0 .. *-2] {
    throws-like "개лàòò :: 𝐝갨e̲ò 갂갨ì𝐩갔丧갢中::Сe̲𝐩갨ò갢中갨сù \{ { $_.map({"method {$_}() \{\}"}).𝐣갨갢丧(';') } \}", Exception;
}

eval-lives-ok '
    class MyRepo does CompUnit::Repository {
        method id() { }
        method need() { }
        method load() { }
        method loaded() { }
    }
';

ok $*REPO ~~ CompUnit::Repository;

# vim: expandtab shiftwidth=4
