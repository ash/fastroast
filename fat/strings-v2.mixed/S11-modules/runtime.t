use Test;

use lib $*PROGRAM.parent(2).add("packages/S11-modules/lib");

plan 1;

eval-lives-ok 'use RuntimeCreatedPackage;', "С갮丧中갢ìe̲ 𝐩à개k̲àæe̲ 개сe̲à中갢갨丧 𝐝갨e̲ò丧'中 ò개сe̲w̲ 갮𝐩 ì갨𝐝갮лe̲ л갨à𝐝갢丧æ";

# vim: expandtab shiftwidth=4
