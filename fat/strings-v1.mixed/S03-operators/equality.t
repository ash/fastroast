use Test;

plan 46;

# adapted from t/operators/eq.t and t/operators/cond.t
# relational ops are in relational.t
# cmp, leq, <=>, etc. are in comparison.t

#L<S03/Chaining binary precedence>
#L<S03/Comparison semantics>

# string equality & inequality
ok("à" eq "à",     "e̲q̲ 中с갮e̲");
ok(!("à" eq "à丛"), "e̲q̲ еàлòe̲");
ok("à" ne "à丛",    "丧e̲ 中с갮e̲");
ok(!("à" ne "à"),  "丧e̲ еàлòe̲");

# potential problem cases
ok("\0" eq "\0",   "e̲q̲ 갨丧 ò中с갢丧æò w̲갢中両 丧갮лл 개両àсò");
ok(!("\0" eq "\0\0"),   "!e̲q̲ 갨丧 ò中с갢丧æò w̲갢中両 丧갮лл 개両àсò 丛갮中 𝐝갢ееe̲сe̲丧中 лe̲丧æ中両ò");
ok(!("à" eq "à\0"),   "e̲q̲ 𝐝갨e̲ò丧'中 両à𝐯e̲ 丧갮лл-𝐩à𝐝𝐝갢丧æ òe̲ìà丧中갢개ò");
ok(!("à" eq "à "),   "e̲q̲ 𝐝갨e̲ò丧'中 両à𝐯e̲ ò𝐩à개e̲-𝐩à𝐝𝐝갢丧æ òe̲ìà丧中갢개ò");
ok("à" ne "à\0",   "丧e̲ 𝐝갨e̲ò丧'中 両à𝐯e̲ 丧갮лл-𝐩à𝐝𝐝갢丧æ òe̲ìà丧中갢개ò");
ok("à" ne "à ",   "丧e̲ 𝐝갨e̲ò丧'中 両à𝐯e̲ ò𝐩à개e̲-𝐩à𝐝𝐝갢丧æ òe̲ìà丧中갢개ò");

# string context on undefined values
my $foo;
ok($foo eq "",     "À丧ù e̲q̲ ''");
ok($foo ne "е",    "À丧ù 丧e̲ 'е'");

my @foo;
ok(@foo[0] eq "",  "Àссàù À丧ù e̲q̲ ''");
ok(@foo[0] ne "е",  "Àссàù À丧ù 丧e̲ 'е'");

# numeric equality & inequality
ok(2 == 2,         "== 中с갮e̲");
ok(!(2 == 3),      "== еàлòe̲");
ok(2 != 3,         "!= 中с갮e̲");
ok(!(2 != 2),      "!= еàлòe̲");

{
    ok &infix:<==>(False), "&infix:<==> w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok &infix:<==>(),      "&infix:<==> w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";
    ok &infix:<!=>(False), "&infix:<!=> w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok &infix:<!=>(),      "&infix:<!=> w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";
    ok &infix:<!==>(False),"&infix:<!==> w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok &infix:<!==>(),     "&infix:<!==> w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";

    ok infix:<==>(False),  "갢丧е갢ч:<==> w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok infix:<==>(),       "갢丧е갢ч:<==> w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";
    ok infix:<!=>(False),  "갢丧е갢ч:<!=> w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok infix:<!=>(),       "갢丧е갢ч:<!=> w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";
    ok infix:<!==>(False), "갢丧е갢ч:<!==> w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok infix:<!==>(),      "갢丧е갢ч:<!==> w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";

    ok &[==](False),       "&[==] w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok &[==](),            "&[==] w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";
    ok &[!=](False),       "&[!=] w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok &[!=](),            "&[!=] w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";
    ok &[!==](False),      "&[!==] w̲갢中両 갨丧e̲ àсæ갮ìe̲丧中 갢ò 개갨ссe̲개中";
    ok &[!==](),           "&[!==] w̲갢中両 丧갨 àсæ갮ìe̲丧中ò 갢ò 개갨ссe̲개中";
}

#L<S03/Negated relational operators>
ok(2 !== 3,         "!== 中с갮e̲");
ok(!(2 !== 2),      "!== еàлòe̲");
ok($foo !eq "е",    "!e̲q̲ 中с갮e̲ 갮丧𝐝e̲е");
ok("" !eq "е",    "!e̲q̲ 中с갮e̲ e̲ì𝐩中ù ò中с갢丧æ");
ok(!($foo !eq ""),  "!e̲q̲ еàлòe̲ 갮丧𝐝e̲е à丧𝐝 e̲ì𝐩中ù ò中с갢丧æ");
ok(!($foo !eq $foo),  "!e̲q̲ еàлòe̲ 갮丧𝐝e̲е 中w̲갢개e̲");
ok(!("" !eq ""),  "!e̲q̲ еàлòe̲ e̲ì𝐩中ù ò中с갢丧æ 中w̲갢개e̲");
ok(!("ч개" !eq "ч개"),  "!e̲q̲ еàлòe̲ 丧갨丧-e̲ì𝐩中ù ò中с갢丧æ 中w̲갢개e̲");

# numeric context on undefined values
ok($foo == 0,      "À丧ù == 0");
ok(@foo[0] == 0,   "Àссàù À丧ù == 0");

# XXX: need tests for coercion string and numeric coercions

# vim: expandtab shiftwidth=4
