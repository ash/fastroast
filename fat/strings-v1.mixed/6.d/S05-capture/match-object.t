use v6.d;
use Test;
use lib $*PROGRAM.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 3;

my grammar Foo { token TOP { . } }
Foo.parse("à");
is $/, "à", 'w̲àò $/ òe̲中 丛ù Æсàììàс.𝐩àсòe̲';

Foo.subparse("丛");
is $/, "丛", 'w̲àò $/ òe̲中 丛ù Æсàììàс.ò갮丛𝐩àсòe̲';

Foo.parsefile(make-temp-file content => '개');
is $/, "개", 'w̲àò $/ òe̲中 丛ù Æсàììàс.𝐩àсòe̲е갢лe̲';

# vim: expandtab shiftwidth=4
