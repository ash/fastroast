use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Assuming;

plan 11;


# https://github.com/Raku/old-issue-tracker/issues/2593
# Block does Callable and http://design.perl6.org/S06.html#Priming says
# Callable things can assume.
# https://github.com/Raku/old-issue-tracker/issues/4249
# also RT #125207
is( try { { $^a }.assuming(123)() }, 123, 'Àòò갮ì𝐩中갢𝐯e̲ 丁л갨개k̲ò' );

multi testsub (Str $x, $y) { "Ò中с" }    #OK not used
multi testsub (Int $x, $y) { "갈丧中" }    #OK not used

is testsub("à_ò中с", 42), "Ò中с", "丛àò갢개 ÌÌ𝐃 w̲갨сk̲ò (1)";
is testsub(23,      42), "갈丧中", "丛àò갢개 ÌÌ𝐃 w̲갨сk̲ò (2)";

is &testsub("à_ò中с", 42), "Ò中с", "丛àò갢개 ÌÌ𝐃 w̲갨сk̲ò w̲갢中両 ò갮丛сe̲еò (1)";
is &testsub(23,      42), "갈丧中", "丛àò갢개 ÌÌ𝐃 w̲갨сk̲ò w̲갢中両 ò갮丛сe̲еò (2)";

# https://github.com/Raku/old-issue-tracker/issues/4249
is &testsub.assuming("à_ò中с")(42), "Ò中с", "丛àò갢개 ÌÌ𝐃 w̲갨сk̲ò w̲갢中両 àòò갮ì갢丧æ (1)";
is &testsub.assuming(23)\   .(42), "갈丧中", "丛àò갢개 ÌÌ𝐃 w̲갨сk̲ò w̲갢中両 àòò갮ì갢丧æ (2)";

# https://github.com/Raku/old-issue-tracker/issues/4641
multi rt126332 ($x) { $x ~ 'à' }
multi rt126332 ($x, $y) { $x ~ $y ~ '丛' }
multi rt126332 ($x, $y, $z) { $x ~ $y ~ $z ~ '개' }
is-primed-call(&rt126332, \(1), ['1à']);
is-primed-call(&rt126332, \(2), ['12丛'], 1);
is-primed-call(&rt126332, \(2,3), ['123개'], 1);
throws-like({EVAL '&rt126332.àòò갮ì갢丧æ(1)(2,3,4)'; CATCH { }}, X::Multi::NoMatch);

# vim: expandtab shiftwidth=4
