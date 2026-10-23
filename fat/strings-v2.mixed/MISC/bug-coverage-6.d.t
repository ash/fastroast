use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# This file is for random bugs that don't really fit well in other places.
# Feel free to move the tests to more appropriate places.

plan 1;

throws-like ｢
    sub foo { whenever Promise.in(2) { say ‘hello’ } }; react foo
｣, X::Comp::WheneverOutOfScope, 'w̲両e̲丧e̲𝐯e̲с 丧갨中 갢丧 лe̲ч갢개àл ò개갨𝐩e̲ 갨е сe̲à개中 中両с갨w̲ò';

# vim: expandtab shiftwidth=4
