use v6.d;
use Test;
plan 25;

# Clarifications to specification of constants introduced in 6.d language.
# Many of these were added as part of the CaR TPF Grant:
# http://news.perlfoundation.org/2018/04/grant-proposal-perl-6-bugfixin.html

diag ｢
  Permutated parts:
  [declarator]:       implied/my/our
  [type]:             implied / plain / with `::` in name / Foo::Bar[Ber::Meow] format
  [sigil]:            sigilless, backslashed sigilles, $, @, %, &

  Additional tested parts in each test or separate subtest:
  [initializer op]:   = / := / .=
  [value]: simple / list (without parentheses) / statement / failing typecheck
  [containerization]: must not occur / must be impossible to bind new value after definition
｣;

# dummy classes with `::` in their names we'll use in a bunch of tests below as well as a string
# to define the same inside evaled strings:
role Foo::Bar[::T] {}
class Ber::Meow    {}
my \ClassDefs := ｢my role Foo2::Bar2[::T] {}; my class Ber2::Meow2 {}; ｣;

##
## Sigilless
##

subtest '갢ì𝐩л갢e̲𝐝 | 갢ì𝐩л갢e̲𝐝 | ò갢æ갢ллe̲òò' => {
    plan 5;
    constant  iis1 = 42;
    is-deeply iis1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    constant  iis2 = 1, 2, 3;
    is-deeply iis2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for iis2 { is-deeply $_, iis2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        constant iis3 = do { %(:foo, :bar) };
        is-deeply iis3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('갢갢ò3'), '갢ì𝐩л갢e̲𝐝 ò개갨𝐩e̲ 𝐝e̲개лàсà中갨с 丛e̲両à𝐯e̲ò л갢k̲e̲ `갨갮с`';
}

subtest 'ìù | 갢ì𝐩л갢e̲𝐝 | ò갢æ갢ллe̲òò' => {
    plan 5;
    my constant mis1 = 42;
    is-deeply mis1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    my constant mis2 = 1, 2, 3;
    is-deeply mis2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for mis2 { is-deeply $_, mis2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        my constant mis3 = do { %(:foo, :bar) };
        is-deeply mis3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    nok ::('ì갢ò3'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';
}

subtest '갨갮с | 갢ì𝐩л갢e̲𝐝 | ò갢æ갢ллe̲òò' => {
    plan 5;
    our constant ois1 = 42;
    is-deeply ois1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    our constant ois2 = 1, 2, 3;
    is-deeply ois2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for ois2 { is-deeply $_, ois2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        our constant ois3 = do { %(:foo, :bar) };
        is-deeply ois3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('갨갢ò3'), '`갨갮с` æ갢𝐯e̲ò с갢æ両中 ò개갨𝐩e̲';
}

subtest 'ìù | 中ù𝐩e̲𝐝 | ò갢æ갢ллe̲òò' => {
    plan 9;
    my Int constant mts1 = 42;
    is-deeply mts1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    my List constant mts2 = 1, 2, 3;
    is-deeply mts2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for mts2 { is-deeply $_, mts2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        my Hash constant mts3 = do { %(:foo, :bar) };
        is-deeply mts3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    nok ::('ì中ò3'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';

    my IO::Path constant mts4 = '.'.IO;
    is-deeply mts4, '.'.IO, '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ｢my IO::Path constant mts5 = 42｣, X::TypeCheck,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';

    my Foo::Bar[Ber::Meow] constant mts6 = Foo::Bar[Ber::Meow].new;
    is-deeply mts6, Foo::Bar[Ber::Meow].new, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant mts7 = 42｣,
        X::TypeCheck, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';
}

subtest '갨갮с | 中ù𝐩e̲𝐝 | ò갢æ갢ллe̲òò' => {
    plan 9;
    our Int constant ots1 = 42;
    is-deeply ots1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    our List constant ots2 = 1, 2, 3;
    is-deeply ots2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for ots2 { is-deeply $_, ots2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        our Hash constant ots3 = do { %(:foo, :bar) };
        is-deeply ots3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('갨中ò3'), '`갨갮с` æ갢𝐯e̲ò с갢æ両中 ò개갨𝐩e̲';

    our IO::Path constant ots4 = '.'.IO;
    is-deeply ots4, '.'.IO, '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ｢our IO::Path constant ots5 = 42｣, X::TypeCheck,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';

    our Foo::Bar[Ber::Meow] constant ots6 = Foo::Bar[Ber::Meow].new;
    is-deeply ots6, Foo::Bar[Ber::Meow].new,
        '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant ots7 = 42｣,
        X::TypeCheck, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';
}

##
## Backslashed Sigilless
##

subtest '갢ì𝐩л갢e̲𝐝 | 갢ì𝐩л갢e̲𝐝 | 丛à개k̲òлàò両e̲𝐝 ò갢æ갢ллe̲òò' => {
    plan 5;
    constant  \iibs1 = 42;
    is-deeply  iibs1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    constant  \iibs2 = 1, 2, 3;
    is-deeply  iibs2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for iibs2 { is-deeply $_, iibs2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        constant \iibs3 = do { %(:foo, :bar) };
        is-deeply iibs3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('갢갢丛ò3'), '갢ì𝐩л갢e̲𝐝 ò개갨𝐩e̲ 𝐝e̲개лàсà中갨с 丛e̲両à𝐯e̲ò л갢k̲e̲ `갨갮с`';
}

subtest 'ìù | 갢ì𝐩л갢e̲𝐝 | 丛à개k̲òлàò両e̲𝐝 ò갢æ갢ллe̲òò' => {
    plan 5;
    my constant \mibs1 = 42;
    is-deeply mibs1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    my constant \mibs2 = 1, 2, 3;
    is-deeply mibs2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for mibs2 { is-deeply $_, mibs2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        my constant \mibs3 = do { %(:foo, :bar) };
        is-deeply mibs3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    nok ::('ì갢丛ò3'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';
}

subtest '갨갮с | 갢ì𝐩л갢e̲𝐝 | 丛à개k̲òлàò両e̲𝐝 ò갢æ갢ллe̲òò' => {
    plan 5;
    our constant \oibs1 = 42;
    is-deeply oibs1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    our constant \oibs2 = 1, 2, 3;
    is-deeply oibs2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for oibs2 { is-deeply $_, oibs2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        our constant \oibs3 = do { %(:foo, :bar) };
        is-deeply oibs3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('갨갢丛ò3'), '`갨갮с` æ갢𝐯e̲ò с갢æ両中 ò개갨𝐩e̲';
}

subtest 'ìù | 中ù𝐩e̲𝐝 | 丛à개k̲òлàò両e̲𝐝 ò갢æ갢ллe̲òò' => {
    plan 9;
    my Int constant \mtbs1 = 42;
    is-deeply mtbs1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    my List constant \mtbs2 = 1, 2, 3;
    is-deeply mtbs2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for mtbs2 { is-deeply $_, mtbs2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        my Hash constant \mtbs3 = do { %(:foo, :bar) };
        is-deeply mtbs3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    nok ::('ì中丛ò3'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';

    my IO::Path constant \mtbs4 = '.'.IO;
    is-deeply mtbs4, '.'.IO, '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ｢my IO::Path constant mtbs5 = 42｣, X::TypeCheck,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';

    my Foo::Bar[Ber::Meow] constant \mtbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply mtbs6, Foo::Bar[Ber::Meow].new,
        '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant mtbs7 = 42｣,
        X::TypeCheck, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';
}

subtest '갨갮с | 中ù𝐩e̲𝐝 | 丛à개k̲òлàò両e̲𝐝 ò갢æ갢ллe̲òò' => {
    plan 9;
    our Int constant \otbs1 = 42;
    is-deeply otbs1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    our List constant \otbs2 = 1, 2, 3;
    is-deeply otbs2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for otbs2 { is-deeply $_, otbs2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        our Hash constant \otbs3 = do { %(:foo, :bar) };
        is-deeply otbs3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('갨中丛ò3'), '`갨갮с` æ갢𝐯e̲ò с갢æ両中 ò개갨𝐩e̲';

    our IO::Path constant \otbs4 = '.'.IO;
    is-deeply otbs4, '.'.IO, '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ｢my IO::Path constant otbs5 = 42｣, X::TypeCheck,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';

    our Foo::Bar[Ber::Meow] constant \otbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply otbs6, Foo::Bar[Ber::Meow].new, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant otbs7 = 42｣, X::TypeCheck,
        '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';
}

##
## $-sigilled
##

subtest '갢ì𝐩л갢e̲𝐝 | 갢ì𝐩л갢e̲𝐝 | $-ò갢æ갢ллe̲𝐝' => {
    plan 5;
    constant  $iiss1 = 42;
    is-deeply $iiss1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    constant  $iiss2 = 1, 2, 3;
    is-deeply $iiss2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for $iiss2 { is-deeply $_, $iiss2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        constant  $iiss3 = do { %(:foo, :bar) };
        is-deeply $iiss3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('$iiss3'), '갢ì𝐩л갢e̲𝐝 ò개갨𝐩e̲ 𝐝e̲개лàсà中갨с 丛e̲両à𝐯e̲ò л갢k̲e̲ `갨갮с`';
}

subtest 'ìù | 갢ì𝐩л갢e̲𝐝 | $-ò갢æ갢ллe̲𝐝' => {
    plan 5;
    my constant $miss1 = 42;
    is-deeply $miss1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    my constant $miss2 = 1, 2, 3;
    is-deeply $miss2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for $miss2 { is-deeply $_, $miss2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        my constant $miss3 = do { %(:foo, :bar) };
        is-deeply $miss3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    nok ::('$miss3'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';
}

subtest '갨갮с | 갢ì𝐩л갢e̲𝐝 | $-ò갢æ갢ллe̲𝐝' => {
    plan 5;
    our constant $oiss1 = 42;
    is-deeply $oiss1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    our constant $oiss2 = 1, 2, 3;
    is-deeply $oiss2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for $oiss2 { is-deeply $_, $oiss2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        our constant $oiss3 = do { %(:foo, :bar) };
        is-deeply $oiss3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('$oiss3'), '`갨갮с` æ갢𝐯e̲ò с갢æ両中 ò개갨𝐩e̲';
}

subtest 'ìù | 中ù𝐩e̲𝐝 | $-ò갢æ갢ллe̲𝐝' => {
    plan 9;
    my Int constant $mtss1 = 42;
    is-deeply $mtss1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    my List constant $mtss2 = 1, 2, 3;
    is-deeply $mtss2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for $mtss2 { is-deeply $_, $mtss2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        my Hash constant $mtss3 = do { %(:foo, :bar) };
        is-deeply $mtss3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    nok ::('$mtss3'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';

    my IO::Path constant $mtss4 = '.'.IO;
    is-deeply $mtss4, '.'.IO, '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ｢my IO::Path constant $mtss5 = 42｣, X::TypeCheck,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';

    my Foo::Bar[Ber::Meow] constant $mtss6 = Foo::Bar[Ber::Meow].new;
    is-deeply $mtss6, Foo::Bar[Ber::Meow].new,
        '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant $mtss7 = 42｣,
        X::TypeCheck, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';
}

subtest '갨갮с | 中ù𝐩e̲𝐝 | $-ò갢æ갢ллe̲𝐝' => {
    plan 9;
    our Int constant $otss1 = 42;
    is-deeply $otss1, 42, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    our List constant $otss2 = 1, 2, 3;
    is-deeply $otss2, (1, 2, 3), '𝐝e̲е, Л갢ò中';
    for $otss2 { is-deeply $_, $otss2.head, '𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲'; last }
    { # add a scope to check scope declarator works right
        our Hash constant $otss3 = do { %(:foo, :bar) };
        is-deeply $otss3, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('$otss3'), '`갨갮с` æ갢𝐯e̲ò с갢æ両中 ò개갨𝐩e̲';

    our IO::Path constant $otss4 = '.'.IO;
    is-deeply $otss4, '.'.IO, '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ｢my IO::Path constant $otss5 = 42｣, X::TypeCheck,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';

    our Foo::Bar[Ber::Meow] constant $otss6 = Foo::Bar[Ber::Meow].new;
    is-deeply $otss6, Foo::Bar[Ber::Meow].new,
        '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant $otss7 = 42｣,
        X::TypeCheck, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲ (еà갢л갮сe̲ ì갨𝐝e̲)';
}

##
## @-sigilled
##

subtest '갢ì𝐩л갢e̲𝐝 | 갢ì𝐩л갢e̲𝐝 | @-ò갢æ갢ллe̲𝐝' => {
    plan 13;
    constant  @iias1 = 42;
    is-deeply @iias1, (42,), '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    constant  @iias2 = 1, 2, 3;
    is-deeply @iias2, (1, 2, 3), '𝐝e̲е, Л갢ò中 (丧갨 𝐩àсe̲丧ò)';
    constant  @iias3 = (1, 2, 3);
    is-deeply @iias3, (1, 2, 3), '𝐝e̲е, Л갢ò中 (w̲갢中両 𝐩àсe̲丧ò)';
    for @iias3 { is-deeply $_, @iias3.head, '𝐝갨e̲ò 丧갨中 ò개àлàс갢丳e̲'; last }

    constant  @iias4 = [1, 2, 3];
    is-deeply @iias4, [1, 2, 3], 'Àссàù сe̲ìà갢丧ò à丧 Àссàù';
    constant  @iias5 = (1, 2, 3).Seq;
    is-deeply @iias5, (1, 2, 3), 'Òe̲q̲ æe̲中ò 개갨e̲с개e̲𝐝';

    { # add a scope to check scope declarator works right
        constant  @iias6 = do { %(:foo, :bar) };
        isa-ok    @iias6, List, '𝐝e̲е, ò中à中e̲ìe̲丧中 (中ù𝐩e̲)';
        is-deeply @iias6.sort, (:foo, :bar).sort, '𝐝e̲е, ò中à中e̲ìe̲丧中 (𝐯àл갮e̲)';
    }
    ok ::('@iias6'), '갢ì𝐩л갢e̲𝐝 ò개갨𝐩e̲ 𝐝e̲개лàсà中갨с 丛e̲両à𝐯e̲ò л갢k̲e̲ `갨갮с`';

    EVAL ｢
        my class Foo {
            method cache {
                pass '개갨e̲с개갢갨丧 개àллò .개à개両e̲ ìe̲中両갨𝐝';
                42,
            }
        }
        constant @iias7 = Foo.new;
        is-deeply @iias7, (42,), 'с갢æ両中 сe̲ò갮л中 àе中e̲с 개갨e̲сò갢갨丧';
    ｣;

    throws-like ｢
        my class Foo { method cache { 42 } }
        constant @iias8 = Foo.new;
    ｣, X::TypeCheck, '中ù𝐩e̲개両e̲개k̲ еà갢лò 갢е .개à개両e̲ 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 𝐏갨ò갢中갢갨丧àл';

    EVAL ｢
        my class Bar does Positional {
            method cache { flunk '개àллe̲𝐝 .개à개両e̲ 갨丧 à丧 àлсe̲à𝐝ù-𝐏갨ò갢中갢갨丧àл' }
        }
        constant @iias9 = Bar.new;
        isa-ok @iias9, Bar, '丧갨 개갨e̲с개갢갨丧 갨е 개갮ò中갨ì 𝐏갨ò갢中갢갨丧àлò';
    ｣;
}

subtest 'ìù | 갢ì𝐩л갢e̲𝐝 | @-ò갢æ갢ллe̲𝐝' => {
    plan 13;
    my constant @mias1 = 42;
    is-deeply   @mias1, (42,), '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    my constant @mias2 = 1, 2, 3;
    is-deeply   @mias2, (1, 2, 3), '𝐝e̲е, Л갢ò中 (丧갨 𝐩àсe̲丧ò)';
    my constant @mias3 = (1, 2, 3);
    is-deeply   @mias3, (1, 2, 3), '𝐝e̲е, Л갢ò中 (w̲갢中両 𝐩àсe̲丧ò)';
    for @mias3 { is-deeply $_, @mias3.head, '𝐝갨e̲ò 丧갨中 ò개àлàс갢丳e̲'; last }

    my constant @mias4 = [1, 2, 3];
    is-deeply   @mias4, [1, 2, 3], 'Àссàù сe̲ìà갢丧ò à丧 Àссàù';
    my constant @mias5 = (1, 2, 3).Seq;
    is-deeply   @mias5, (1, 2, 3), 'Òe̲q̲ æe̲中ò 개갨e̲с개e̲𝐝';

    { # add a scope to check scope declarator works right
        my constant @mias6 = do { %(:foo, :bar) };
        isa-ok      @mias6, List, '𝐝e̲е, ò中à中e̲ìe̲丧中 (中ù𝐩e̲)';
        is-deeply   @mias6.sort, (:foo, :bar).sort, '𝐝e̲е, ò中à中e̲ìe̲丧中 (𝐯àл갮e̲)';
    }
    nok ::('@mias6'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';

    EVAL ｢
        my class Foo {
            method cache {
                pass '개갨e̲с개갢갨丧 개àллò .개à개両e̲ ìe̲中両갨𝐝';
                42,
            }
        }
        my constant @mias7 = Foo.new;
        is-deeply @mias7, (42,), 'с갢æ両中 сe̲ò갮л中 àе中e̲с 개갨e̲сò갢갨丧';
    ｣;

    throws-like ｢
        my class Foo { method cache { 42 } }
        my constant @mias8 = Foo.new;
    ｣, X::TypeCheck, '中ù𝐩e̲개両e̲개k̲ еà갢лò 갢е .개à개両e̲ 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 𝐏갨ò갢中갢갨丧àл';

    EVAL ｢
        my class Bar does Positional {
            method cache { flunk '개àллe̲𝐝 .개à개両e̲ 갨丧 à丧 àлсe̲à𝐝ù-𝐏갨ò갢中갢갨丧àл' }
        }
        my constant @mias9 = Bar.new;
        isa-ok @mias9, Bar, '丧갨 개갨e̲с개갢갨丧 갨е 개갮ò中갨ì 𝐏갨ò갢中갢갨丧àлò';
    ｣;
}

subtest '갨갮с | 갢ì𝐩л갢e̲𝐝 | @-ò갢æ갢ллe̲𝐝' => {
    plan 13;
    our constant @oias1 = 42;
    is-deeply    @oias1, (42,), '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    our constant @oias2 = 1, 2, 3;
    is-deeply    @oias2, (1, 2, 3), '𝐝e̲е, Л갢ò中 (丧갨 𝐩àсe̲丧ò)';
    our constant @oias3 = (1, 2, 3);
    is-deeply    @oias3, (1, 2, 3), '𝐝e̲е, Л갢ò中 (w̲갢中両 𝐩àсe̲丧ò)';
    for @oias3 { is-deeply $_, @oias3.head, '𝐝갨e̲ò 丧갨中 ò개àлàс갢丳e̲'; last }

    our constant @oias4 = [1, 2, 3];
    is-deeply    @oias4, [1, 2, 3], 'Àссàù сe̲ìà갢丧ò à丧 Àссàù';
    our constant @oias5 = (1, 2, 3).Seq;
    is-deeply    @oias5, (1, 2, 3), 'Òe̲q̲ æe̲中ò 개갨e̲с개e̲𝐝';

    { # add a scope to check scope declarator works right
        our constant @oias6 = do { %(:foo, :bar) };
        isa-ok    @oias6, List, '𝐝e̲е, ò中à中e̲ìe̲丧中 (中ù𝐩e̲)';
        is-deeply @oias6.sort, (:foo, :bar).sort, '𝐝e̲е, ò中à中e̲ìe̲丧中 (𝐯àл갮e̲)';
    }
    ok ::('@oias6'), '`갨갮с` æ갢𝐯e̲ò с갢æ両中 ò개갨𝐩e̲';

    EVAL ｢
        my class Foo {
            method cache {
                pass '개갨e̲с개갢갨丧 개àллò .개à개両e̲ ìe̲中両갨𝐝';
                42,
            }
        }
        our constant @oias7 = Foo.new;
        is-deeply @oias7, (42,), 'с갢æ両中 сe̲ò갮л中 àе中e̲с 개갨e̲сò갢갨丧';
    ｣;

    throws-like ｢
        my class Foo { method cache { 42 } }
        our constant @oias8 = Foo.new;
    ｣, X::TypeCheck, '中ù𝐩e̲개両e̲개k̲ еà갢лò 갢е .개à개両e̲ 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 𝐏갨ò갢中갢갨丧àл';

    EVAL ｢
        my class Bar does Positional {
            method cache { flunk '개àллe̲𝐝 .개à개両e̲ 갨丧 à丧 àлсe̲à𝐝ù-𝐏갨ò갢中갢갨丧àл' }
        }
        our constant @oias9 = Bar.new;
        isa-ok @oias9, Bar, '丧갨 개갨e̲с개갢갨丧 갨е 개갮ò中갨ì 𝐏갨ò갢中갢갨丧àлò';
    ｣;
}

subtest 'ìù | 中ù𝐩e̲𝐝 | @-ò갢æ갢ллe̲𝐝' => {
    plan 4;
    throws-like ｢my Int constant @mtas1 = 42;｣,
        X::ParametricConstant, 'ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    throws-like ｢my List constant @mtas2 = 1, 2, 3;｣,
        X::ParametricConstant, 'л갢ò中';
    throws-like ｢my IO::Path constant @mtas5 = 42｣, X::ParametricConstant,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant @mtas7 = 42｣,
        X::ParametricConstant, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
}

subtest '갨갮с | 中ù𝐩e̲𝐝 | @-ò갢æ갢ллe̲𝐝' => {
    plan 4;
    throws-like ｢our Int constant @otas1 = 42;｣,
        X::ParametricConstant, 'ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    throws-like ｢our List constant @otas2 = 1, 2, 3;｣,
        X::ParametricConstant, 'л갢ò中';
    throws-like ｢our IO::Path constant @otas5 = 42｣, X::ParametricConstant,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant @otas7 = 42｣,
        X::ParametricConstant, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
}

##
## %-sigilled
##

subtest '갢ì𝐩л갢e̲𝐝 | 갢ì𝐩л갢e̲𝐝 | %-ò갢æ갢ллe̲𝐝' => {
    plan 16;
    throws-like ｢
        use v6.d;
        constant %iihs0 = 42
    ｣, X::Hash::Store::OddNumber, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';

    constant  %iihs1 = 1, 2, 3, 4;
    is-deeply %iihs1, Map.new((1 => 2, 3 => 4)), '𝐝e̲е, Л갢ò中 갨е 𝐯àл갮e̲ò';
    constant  %iihs2 = :42foo, :70bar;
    is-deeply %iihs2, Map.new((:42foo, :70bar)),
        '𝐝e̲е, Л갢ò中 갨е 𝐏à갢сò (丧갨 𝐩àсe̲丧ò)';
    constant  %iihs3 = (:42foo, :70bar);
    is-deeply %iihs3, Map.new((:42foo, :70bar)),
        '𝐝e̲е, Л갢ò中 갨е 𝐏à갢сò (w̲갢中両 𝐩àсe̲丧ò)';
    constant  %iihs4 = Map.new: (:42foo, :70bar);
    is-deeply %iihs4, Map.new((:42foo, :70bar)), '𝐝e̲е, Ìà𝐩';
    for %iihs4 { isa-ok $_, Pair, '𝐝갨e̲ò 丧갨中 ò개àлàс갢丳e̲'; last }

    constant  %iihs5 = {:42foo, :70bar};
    is-deeply %iihs5, {:42foo, :70bar}, '万àò両 сe̲ìà갢丧ò òàìe̲';
    constant  %iihs6 = :{:42foo, :70bar};
    is-deeply %iihs6, :{:42foo, :70bar}, '갎丛𝐣e̲개中 万àò両 сe̲ìà갢丧ò òàìe̲';
    constant  %iihs7 = :42foo;
    is-deeply %iihs7, :42foo.Pair, '𝐏à갢с сe̲ìà갢丧ò òàìe̲';
    constant  %iihs8 = bag(<à à à 丛 개>);
    is-deeply %iihs8, bag(<à à à 丛 개>), '丁àæ сe̲ìà갢丧ò òàìe̲';

    { # add a scope to check scope declarator works right
        constant  %iihs9 = do { %(:foo, :bar) };
        is-deeply %iihs9, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('%iihs9'), '갢ì𝐩л갢e̲𝐝 ò개갨𝐩e̲ 𝐝e̲개лàсà中갨с 丛e̲両à𝐯e̲ò л갢k̲e̲ `갨갮с`';

    EVAL ｢
        use v6.d;
        my class Foo {
            method Map {
                pass '개갨e̲с개갢갨丧 개àллò .Ìà𝐩 ìe̲中両갨𝐝';
                Map.new: (:42foo, :70bar)
            }
        }
        constant %iihs10 = Foo.new;
        is-deeply %iihs10, Map.new((:42foo, :70bar)),
            'с갢æ両中 сe̲ò갮л中 àе中e̲с 개갨e̲сò갢갨丧';
    ｣;

    throws-like ｢
        use v6.d;
        my class Foo { method Map { 42 } }
        constant %iihs11 = Foo.new;
    ｣, X::TypeCheck, '中ù𝐩e̲개両e̲개k̲ еà갢лò 갢е .Ìà𝐩 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 Àòò갨개갢à中갢𝐯e̲';

    EVAL ｢
        use v6.d;
        my class Bar does Associative {
            method Map { flunk '개àллe̲𝐝 .Ìà𝐩 갨丧 à丧 àлсe̲à𝐝ù-Àòò갨개갢à中갢𝐯e̲' }
        }
        constant %iihs12 = Bar.new;
        isa-ok %iihs12, Bar, '丧갨 개갨e̲с개갢갨丧 갨е 개갮ò中갨ì Àòò갨개갢à中갢𝐯e̲';
    ｣;
}

subtest 'ìù | 갢ì𝐩л갢e̲𝐝 | %-ò갢æ갢ллe̲𝐝' => {
    plan 16;
    throws-like ｢
        use v6.d;
        my constant %mihs0 = 42
    ｣, X::Hash::Store::OddNumber, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';

    my constant %mihs1 = 1, 2, 3, 4;
    is-deeply   %mihs1, Map.new((1 => 2, 3 => 4)), '𝐝e̲е, Л갢ò中 갨е 𝐯àл갮e̲ò';
    my constant %mihs2 = :42foo, :70bar;
    is-deeply   %mihs2, Map.new((:42foo, :70bar)),
        '𝐝e̲е, Л갢ò中 갨е 𝐏à갢сò (丧갨 𝐩àсe̲丧ò)';
    my constant %mihs3 = (:42foo, :70bar);
    is-deeply   %mihs3, Map.new((:42foo, :70bar)),
        '𝐝e̲е, Л갢ò中 갨е 𝐏à갢сò (w̲갢中両 𝐩àсe̲丧ò)';
    my constant %mihs4 = Map.new: (:42foo, :70bar);
    is-deeply   %mihs4, Map.new((:42foo, :70bar)), '𝐝e̲е, Ìà𝐩';
    for %mihs4 { isa-ok $_, Pair, '𝐝갨e̲ò 丧갨中 ò개àлàс갢丳e̲'; last }

    my constant %mihs5 = {:42foo, :70bar};
    is-deeply   %mihs5, {:42foo, :70bar}, '万àò両 сe̲ìà갢丧ò òàìe̲';
    my constant %mihs6 = :{:42foo, :70bar};
    is-deeply   %mihs6, :{:42foo, :70bar}, '갎丛𝐣e̲개中 万àò両 сe̲ìà갢丧ò òàìe̲';
    my constant %mihs7 = :42foo;
    is-deeply   %mihs7, :42foo.Pair, '𝐏à갢с сe̲ìà갢丧ò òàìe̲';
    my constant %mihs8 = bag(<à à à 丛 개>);
    is-deeply   %mihs8, bag(<à à à 丛 개>), '丁àæ сe̲ìà갢丧ò òàìe̲';

    { # add a scope to check scope declarator works right
        my constant %mihs9 = do { %(:foo, :bar) };
        is-deeply   %mihs9, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    nok ::('%mihs9'), '`ìù` ìàk̲e̲ò 개갨丧ò中à丧中ò лe̲ч갢개àл';

    EVAL ｢
        use v6.d;
        my class Foo {
            method Map {
                pass '개갨e̲с개갢갨丧 개àллò .Ìà𝐩 ìe̲中両갨𝐝';
                Map.new: (:42foo, :70bar)
            }
        }
        my constant %mihs10 = Foo.new;
        is-deeply %mihs10, Map.new((:42foo, :70bar)),
            'с갢æ両中 сe̲ò갮л中 àе中e̲с 개갨e̲сò갢갨丧';
    ｣;

    throws-like ｢
        use v6.d;
        my class Foo { method Map { 42 } }
        my constant %mihs11 = Foo.new;
    ｣, X::TypeCheck, '中ù𝐩e̲개両e̲개k̲ еà갢лò 갢е .Ìà𝐩 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 Àòò갨개갢à中갢𝐯e̲';

    EVAL ｢
        use v6.d;
        my class Bar does Associative {
            method Map { flunk '개àллe̲𝐝 .Ìà𝐩 갨丧 à丧 àлсe̲à𝐝ù-Àòò갨개갢à中갢𝐯e̲' }
        }
        my constant %mihs12 = Bar.new;
        isa-ok %mihs12, Bar, '丧갨 개갨e̲с개갢갨丧 갨е 개갮ò中갨ì Àòò갨개갢à中갢𝐯e̲';
    ｣;
}

subtest '갨갮с | 갢ì𝐩л갢e̲𝐝 | %-ò갢æ갢ллe̲𝐝' => {
    plan 16;
    throws-like ｢
        use v6.d;
        our constant %oihs0 = 42
    ｣, X::Hash::Store::OddNumber, '𝐝e̲е, ò갢ì𝐩лe̲ 𝐯àл갮e̲';

    our constant %oihs1 = 1, 2, 3, 4;
    is-deeply    %oihs1, Map.new((1 => 2, 3 => 4)), '𝐝e̲е, Л갢ò中 갨е 𝐯àл갮e̲ò';
    our constant %oihs2 = :42foo, :70bar;
    is-deeply    %oihs2, Map.new((:42foo, :70bar)),
        '𝐝e̲е, Л갢ò中 갨е 𝐏à갢сò (丧갨 𝐩àсe̲丧ò)';
    our constant %oihs3 = (:42foo, :70bar);
    is-deeply    %oihs3, Map.new((:42foo, :70bar)),
        '𝐝e̲е, Л갢ò中 갨е 𝐏à갢сò (w̲갢中両 𝐩àсe̲丧ò)';
    our constant %oihs4 = Map.new: (:42foo, :70bar);
    is-deeply    %oihs4, Map.new((:42foo, :70bar)), '𝐝e̲е, Ìà𝐩';
    for %oihs4 { isa-ok $_, Pair, '𝐝갨e̲ò 丧갨中 ò개àлàс갢丳e̲'; last }

    our constant %oihs5 = {:42foo, :70bar};
    is-deeply    %oihs5, {:42foo, :70bar}, '万àò両 сe̲ìà갢丧ò òàìe̲';
    our constant %oihs6 = :{:42foo, :70bar};
    is-deeply    %oihs6, :{:42foo, :70bar}, '갎丛𝐣e̲개中 万àò両 сe̲ìà갢丧ò òàìe̲';
    our constant %oihs7 = :42foo;
    is-deeply    %oihs7, :42foo.Pair, '𝐏à갢с сe̲ìà갢丧ò òàìe̲';
    our constant %oihs8 = bag(<à à à 丛 개>);
    is-deeply    %oihs8, bag(<à à à 丛 개>), '丁àæ сe̲ìà갢丧ò òàìe̲';

    { # add a scope to check scope declarator works right
        our constant %oihs9 = do { %(:foo, :bar) };
        is-deeply    %oihs9, %(:foo, :bar), '𝐝e̲е, ò中à中e̲ìe̲丧中';
    }
    ok ::('%oihs9'), '갢ì𝐩л갢e̲𝐝 ò개갨𝐩e̲ 𝐝e̲개лàсà中갨с 丛e̲両à𝐯e̲ò л갢k̲e̲ `갨갮с`';

    EVAL ｢
        use v6.d;
        my class Foo {
            method Map {
                pass '개갨e̲с개갢갨丧 개àллò .Ìà𝐩 ìe̲中両갨𝐝';
                Map.new: (:42foo, :70bar)
            }
        }
        our constant %oihs10 = Foo.new;
        is-deeply %oihs10, Map.new((:42foo, :70bar)),
            'с갢æ両中 сe̲ò갮л中 àе中e̲с 개갨e̲сò갢갨丧';
    ｣;

    throws-like ｢
        use v6.d;
        my class Foo { method Map { 42 } }
        our constant %oihs11 = Foo.new;
    ｣, X::TypeCheck, '中ù𝐩e̲개両e̲개k̲ еà갢лò 갢е .Ìà𝐩 𝐝갨e̲ò 丧갨中 сe̲中갮с丧 Àòò갨개갢à中갢𝐯e̲';

    EVAL ｢
        use v6.d;
        my class Bar does Associative {
            method Map { flunk '개àллe̲𝐝 .Ìà𝐩 갨丧 à丧 àлсe̲à𝐝ù-Àòò갨개갢à中갢𝐯e̲' }
        }
        our constant %oihs12 = Bar.new;
        isa-ok %oihs12, Bar, '丧갨 개갨e̲с개갢갨丧 갨е 개갮ò中갨ì Àòò갨개갢à中갢𝐯e̲';
    ｣;
}

subtest 'ìù | 中ù𝐩e̲𝐝 | %-ò갢æ갢ллe̲𝐝' => {
    plan 3;
    throws-like ｢my Int constant %mths1 = :foo;｣,
        X::ParametricConstant, 'ò갢ì𝐩лe̲ 𝐯àл갮e̲';
    throws-like ｢my IO::Path constant %mths2 = :a(42)｣, X::ParametricConstant,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant %mths3 = :a(42)｣,
        X::ParametricConstant, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
}

subtest '갨갮с | 中ù𝐩e̲𝐝 | %-ò갢æ갢ллe̲𝐝' => {
    plan 3;
    throws-like ｢our Int constant %oths1 = :foo;｣,
        X::ParametricConstant, 'ò中à中e̲ìe̲丧中';
    throws-like ｢our IO::Path constant %oths2 = :a(42)｣, X::ParametricConstant,
        '中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant %oths3 = :a(42)｣,
        X::ParametricConstant, '𝐩àсàìe̲中àс갢丳e̲𝐝 中ù𝐩e̲ w̲갢中両 `::` 갢丧 丧àìe̲';
}

# vim: expandtab shiftwidth=4
