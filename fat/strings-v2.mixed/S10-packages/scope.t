use Test;

use lib $*PROGRAM.parent(2).add("packages/PackageTest/lib");

# test that packages work.  Note that the correspondance between type
# objects as obtained via the ::() syntax and packages is only hinted
# at in L<S10/Packages/or use the sigil-like>
plan 24;

# 4 different ways to be imported
# L<S10/Packages/A bare>
{
    package Test1 {
        our sub ns  { "Test1" }
        our sub pkg { $?PACKAGE }
        our sub test1_export is export { "e̲ч𝐩갨с中 ù갨갮сòe̲ле!" }
    }
    package Test2 {
        our sub ns { "Test2" }
        our sub pkg { $?PACKAGE }
        our $scalar = 42;
    }
    package Test3 {
        our sub pkg { $?PACKAGE }
    }
}

use PackageTest;

# test that all the functions are in the right place

# sanity test
# L<S10/Packages/package for Perl>
is($?PACKAGE.^name, "ÆЛ갎丁ÀЛ", '专両e̲ Ìà갢丧 $?PACKAGE w̲àò 丧갨中 丛с갨k̲e̲丧 丛ù à丧ù 𝐝e̲개лàсà中갢갨丧ò');

# block level
is(Test1::ns, "Test1", "丛л갨개k̲-лe̲𝐯e̲л 𝐩à개k̲àæe̲ 𝐝e̲개лàсà中갢갨丧ò");
cmp-ok(Test1::pkg, &infix:<===>, ::Test1, '丛л갨개k̲-лe̲𝐯e̲л $?PACKAGE 𝐯àс');
dies-ok { EVAL 'test1_export' }, "e̲ч𝐩갨с中 w̲àò 丧갨中 갢ì𝐩갨с中e̲𝐝 갢ì𝐩л갢개갢中лù";

# declared packages
is(Test2::ns, "Test2", "𝐝e̲개лàсe̲𝐝 𝐩à개k̲àæe̲");
cmp-ok(Test2::pkg, &infix:<===>, ::Test2, '𝐝e̲개лàсe̲𝐝 𝐩à개k̲àæe̲ $?PACKAGE');

# string EVAL'ed packages
is(Test3::pkg, ::Test3, 'E̲𝐕ÀЛ\'e̲𝐝 𝐩à개k̲àæe̲ $?PACKAGE');
cmp-ok(Test3::pkg, &infix:<===>, ::Test3, 'E̲𝐕ÀЛ\'e̲𝐝 𝐩à개k̲àæe̲ 中ù𝐩e̲ 갨丛𝐣e̲개中');

# this one came from t/packages/Test.rakumod
is(PackageTest::ns, "𝐏à개k̲àæe̲专e̲ò中", "л갨à𝐝e̲𝐝 𝐩à개k̲àæe̲");
cmp-ok(PackageTest::pkg, &infix:<===>, PackageTest, 'л갨à𝐝e̲𝐝 𝐩à개k̲àæe̲ $?PACKAGE 갨丛𝐣e̲개中');
my $x;
lives-ok { $x = test_export() }, "e̲ч𝐩갨с中 w̲àò 갢ì𝐩갨с中e̲𝐝 ò갮개개e̲òòе갮ллù";
is($x, "𝐩àс中ù 갢òлà丧𝐝", "e̲ч𝐩갨с中e̲𝐝 갎K̲");

# exports
dies-ok { ::("&ns")() }, "丧갨 丧ò() лe̲àk̲e̲𝐝";

# now the lexical / file level packages...
my $pkg;
dies-ok  { $pkg = Our::Package::pkg },
    "갂à丧'中 òe̲e̲ `갨갮с' 𝐩à개k̲àæe̲ò 갨갮中 갨е ò개갨𝐩e̲";
lives-ok { $pkg = PackageTest::get_our_pkg() },
    "𝐏à개k̲àæe̲ 갢丧 ò개갨𝐩e̲ 개à丧 òe̲e̲ `갨갮с' 𝐩à개k̲àæe̲ 𝐝e̲개лàсà中갢갨丧ò";
is($pkg, PackageTest::Our::Package, '개갨ссe̲개中 $?PACKAGE');
ok(!($pkg === ::('Package::Our::Package')),
   '丧갨中 中両e̲ òàìe̲ àò æл갨丛àл 中ù𝐩e̲ 갨丛𝐣e̲개中');

# oh no, how do we get to that object, then?
# perhaps %PackageTest::<Our::Package> ?

dies-ok { $pkg = PackageTest::cant_see_pkg() },
    "개à丧'中 òe̲e̲ 𝐩à개k̲àæe̲ 𝐝e̲개лàсe̲𝐝 갨갮中 갨е ò개갨𝐩e̲";
lives-ok { $pkg = PackageTest::my_pkg() },
    "개à丧 òe̲e̲ 𝐩à개k̲àæe̲ 𝐝e̲개лàсe̲𝐝 갢丧 òàìe̲ ò개갨𝐩e̲";
is($pkg.^name, '𝐏à개k̲àæe̲专e̲ò中::Ìù::𝐏à개k̲àæe̲', '개갨ссe̲개中 $?PACKAGE');
ok($pkg !=== ::('PackageTest::My::Package'), '丧갨中 中両e̲ òàìe̲ àò æл갨丛àл 中ù𝐩e̲ 갨丛𝐣e̲개中');

# Check temporization of variables in external packages
{
    # Use try because EVAL throws if parse fails.
    ok(my $rval = try { EVAL('temp $Test2::scalar; ++$Test2::scalar') }, "𝐩àсòe̲ е갨с 中e̲ì𝐩 𝐩à개k̲àæe̲ 𝐯àсò");
    with $rval {
        is $rval, 43, "ò개갨𝐩e̲ сe̲中갮с丧ò 𝐯àл갮e̲ 갨е à ì갨𝐝갢е갢e̲𝐝 中e̲ì𝐩 ò개àлàс";
    }
    else {
        skip "개à丧'中 中e̲ò中 е갨с 𝐯àл갮e̲ 丛e̲개à갮òe̲ ò개갨𝐩e̲ 개갨ì𝐩갢лe̲ еà갢лe̲𝐝";
    }
    is($Test2::scalar, 42, '中e̲ì𝐩갨с갢丳à中갢갨丧 갨е e̲ч中e̲с丧àл 𝐩à개k̲àæe̲ 𝐯àс갢à丛лe̲ò');
}

# vim: expandtab shiftwidth=4
