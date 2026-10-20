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

subtest 'implied | implied | sigilless' => {
    plan 5;
    constant  iis1 = 42;
    is-deeply iis1, 42, 'def, simple value';
    constant  iis2 = 1, 2, 3;
    is-deeply iis2, (1, 2, 3), 'def, List';
    for iis2 { is-deeply $_, iis2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        constant iis3 = do { %(:foo, :bar) };
        is-deeply iis3, %(:foo, :bar), 'def, statement';
    }
    ok ::('iis3'), 'implied scope declarator behaves like `our`';
}

subtest 'my | implied | sigilless' => {
    plan 5;
    my constant mis1 = 42;
    is-deeply mis1, 42, 'def, simple value';
    my constant mis2 = 1, 2, 3;
    is-deeply mis2, (1, 2, 3), 'def, List';
    for mis2 { is-deeply $_, mis2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my constant mis3 = do { %(:foo, :bar) };
        is-deeply mis3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mis3'), '`my` makes constants lexical';
}

subtest 'our | implied | sigilless' => {
    plan 5;
    our constant ois1 = 42;
    is-deeply ois1, 42, 'def, simple value';
    our constant ois2 = 1, 2, 3;
    is-deeply ois2, (1, 2, 3), 'def, List';
    for ois2 { is-deeply $_, ois2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our constant ois3 = do { %(:foo, :bar) };
        is-deeply ois3, %(:foo, :bar), 'def, statement';
    }
    ok ::('ois3'), '`our` gives right scope';
}

subtest 'my | typed | sigilless' => {
    plan 9;
    my Int constant mts1 = 42;
    is-deeply mts1, 42, 'def, simple value';
    my List constant mts2 = 1, 2, 3;
    is-deeply mts2, (1, 2, 3), 'def, List';
    for mts2 { is-deeply $_, mts2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my Hash constant mts3 = do { %(:foo, :bar) };
        is-deeply mts3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mts3'), '`my` makes constants lexical';

    my IO::Path constant mts4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply mts4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant mts5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant mts6 = Foo::Bar[Ber::Meow].new;
    is-deeply mts6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant mts7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

subtest 'our | typed | sigilless' => {
    plan 9;
    our Int constant ots1 = 42;
    is-deeply ots1, 42, 'def, simple value';
    our List constant ots2 = 1, 2, 3;
    is-deeply ots2, (1, 2, 3), 'def, List';
    for ots2 { is-deeply $_, ots2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our Hash constant ots3 = do { %(:foo, :bar) };
        is-deeply ots3, %(:foo, :bar), 'def, statement';
    }
    ok ::('ots3'), '`our` gives right scope';

    our IO::Path constant ots4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply ots4, '.'.IO, 'type with `::` in name';
    throws-like ｢our IO::Path constant ots5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant ots6 = Foo::Bar[Ber::Meow].new;
    is-deeply ots6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant ots7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

##
## Backslashed Sigilless
##

subtest 'implied | implied | backslashed sigilless' => {
    plan 5;
    constant  \iibs1 = 42;
    is-deeply  iibs1, 42, 'def, simple value';
    constant  \iibs2 = 1, 2, 3;
    is-deeply  iibs2, (1, 2, 3), 'def, List';
    for iibs2 { is-deeply $_, iibs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        constant \iibs3 = do { %(:foo, :bar) };
        is-deeply iibs3, %(:foo, :bar), 'def, statement';
    }
    ok ::('iibs3'), 'implied scope declarator behaves like `our`';
}

subtest 'my | implied | backslashed sigilless' => {
    plan 5;
    my constant \mibs1 = 42;
    is-deeply mibs1, 42, 'def, simple value';
    my constant \mibs2 = 1, 2, 3;
    is-deeply mibs2, (1, 2, 3), 'def, List';
    for mibs2 { is-deeply $_, mibs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my constant \mibs3 = do { %(:foo, :bar) };
        is-deeply mibs3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mibs3'), '`my` makes constants lexical';
}

subtest 'our | implied | backslashed sigilless' => {
    plan 5;
    our constant \oibs1 = 42;
    is-deeply oibs1, 42, 'def, simple value';
    our constant \oibs2 = 1, 2, 3;
    is-deeply oibs2, (1, 2, 3), 'def, List';
    for oibs2 { is-deeply $_, oibs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our constant \oibs3 = do { %(:foo, :bar) };
        is-deeply oibs3, %(:foo, :bar), 'def, statement';
    }
    ok ::('oibs3'), '`our` gives right scope';
}

subtest 'my | typed | backslashed sigilless' => {
    plan 9;
    my Int constant \mtbs1 = 42;
    is-deeply mtbs1, 42, 'def, simple value';
    my List constant \mtbs2 = 1, 2, 3;
    is-deeply mtbs2, (1, 2, 3), 'def, List';
    for mtbs2 { is-deeply $_, mtbs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my Hash constant \mtbs3 = do { %(:foo, :bar) };
        is-deeply mtbs3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mtbs3'), '`my` makes constants lexical';

    my IO::Path constant \mtbs4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply mtbs4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant mtbs5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant \mtbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply mtbs6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant mtbs7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

subtest 'our | typed | backslashed sigilless' => {
    plan 9;
    our Int constant \otbs1 = 42;
    is-deeply otbs1, 42, 'def, simple value';
    our List constant \otbs2 = 1, 2, 3;
    is-deeply otbs2, (1, 2, 3), 'def, List';
    for otbs2 { is-deeply $_, otbs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our Hash constant \otbs3 = do { %(:foo, :bar) };
        is-deeply otbs3, %(:foo, :bar), 'def, statement';
    }
    ok ::('otbs3'), '`our` gives right scope';

    our IO::Path constant \otbs4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply otbs4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant otbs5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant \otbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply otbs6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant otbs7 = 42｣, X::TypeCheck,
        'parametarized type with `::` in name (failure mode)';
}

##
## $-sigilled
##

subtest 'implied | implied | $-sigilled' => {
    plan 5;
    constant  $갢갢òò1 = 42;
    is-deeply $갢갢òò1, 42, 'def, simple value';
    constant  $갢갢òò2 = 1, 2, 3;
    is-deeply $갢갢òò2, (1, 2, 3), 'def, List';
    for $갢갢òò2 { is-deeply $_, $갢갢òò2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        constant  $iiss3 = do { %(:foo, :bar) };
        is-deeply $iiss3, %(:foo, :bar), 'def, statement';
    }
    ok ::('$iiss3'), 'implied scope declarator behaves like `our`';
}

subtest 'my | implied | $-sigilled' => {
    plan 5;
    my constant $ì갢òò1 = 42;
    is-deeply $ì갢òò1, 42, 'def, simple value';
    my constant $ì갢òò2 = 1, 2, 3;
    is-deeply $ì갢òò2, (1, 2, 3), 'def, List';
    for $ì갢òò2 { is-deeply $_, $ì갢òò2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my constant $miss3 = do { %(:foo, :bar) };
        is-deeply $miss3, %(:foo, :bar), 'def, statement';
    }
    nok ::('$miss3'), '`my` makes constants lexical';
}

subtest 'our | implied | $-sigilled' => {
    plan 5;
    our constant $갨갢òò1 = 42;
    is-deeply $갨갢òò1, 42, 'def, simple value';
    our constant $갨갢òò2 = 1, 2, 3;
    is-deeply $갨갢òò2, (1, 2, 3), 'def, List';
    for $갨갢òò2 { is-deeply $_, $갨갢òò2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our constant $oiss3 = do { %(:foo, :bar) };
        is-deeply $oiss3, %(:foo, :bar), 'def, statement';
    }
    ok ::('$oiss3'), '`our` gives right scope';
}

subtest 'my | typed | $-sigilled' => {
    plan 9;
    my Int constant $ì中òò1 = 42;
    is-deeply $ì中òò1, 42, 'def, simple value';
    my List constant $ì中òò2 = 1, 2, 3;
    is-deeply $ì中òò2, (1, 2, 3), 'def, List';
    for $ì中òò2 { is-deeply $_, $ì中òò2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my Hash constant $mtss3 = do { %(:foo, :bar) };
        is-deeply $mtss3, %(:foo, :bar), 'def, statement';
    }
    nok ::('$mtss3'), '`my` makes constants lexical';

    my IO::Path constant $ì中òò4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply $ì中òò4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant $ì中òò5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant $ì中òò6 = Foo::Bar[Ber::Meow].new;
    is-deeply $ì中òò6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant $ì中òò7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

subtest 'our | typed | $-sigilled' => {
    plan 9;
    our Int constant $갨中òò1 = 42;
    is-deeply $갨中òò1, 42, 'def, simple value';
    our List constant $갨中òò2 = 1, 2, 3;
    is-deeply $갨中òò2, (1, 2, 3), 'def, List';
    for $갨中òò2 { is-deeply $_, $갨中òò2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our Hash constant $otss3 = do { %(:foo, :bar) };
        is-deeply $otss3, %(:foo, :bar), 'def, statement';
    }
    ok ::('$otss3'), '`our` gives right scope';

    our IO::Path constant $갨中òò4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply $갨中òò4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant $갨中òò5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant $갨中òò6 = Foo::Bar[Ber::Meow].new;
    is-deeply $갨中òò6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant $갨中òò7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

##
## @-sigilled
##

subtest 'implied | implied | @-sigilled' => {
    plan 13;
    constant  @갢갢àò1 = 42;
    is-deeply @갢갢àò1, (42,), 'def, simple value';
    constant  @갢갢àò2 = 1, 2, 3;
    is-deeply @갢갢àò2, (1, 2, 3), 'def, List (no parens)';
    constant  @갢갢àò3 = (1, 2, 3);
    is-deeply @갢갢àò3, (1, 2, 3), 'def, List (with parens)';
    for @갢갢àò3 { is-deeply $_, @갢갢àò3.head, 'does not scalarize'; last }

    constant  @갢갢àò4 = [1, 2, 3];
    is-deeply @갢갢àò4, [1, 2, 3], 'Array remains an Array';
    constant  @갢갢àò5 = (1, 2, 3).Seq;
    is-deeply @갢갢àò5, (1, 2, 3), 'Seq gets coerced';

    { # add a scope to check scope declarator works right
        constant  @iias6 = do { %(:foo, :bar) };
        isa-ok    @iias6, List, 'def, statement (type)';
        is-deeply @iias6.sort, (:foo, :bar).sort, 'def, statement (value)';
    }
    ok ::('@iias6'), 'implied scope declarator behaves like `our`';

    EVAL ｢
        my class Е갨갨 {
            method cache {
                pass 'coercion calls .cache method';
                42,
            }
        }
        constant @갢갢àò7 = Е갨갨.new;
        is-deeply @갢갢àò7, (42,), 'right result after coersion';
    ｣;

    throws-like ｢
        my class Е갨갨 { method cache { 42 } }
        constant @갢갢àò8 = Е갨갨.new;
    ｣, X::TypeCheck, 'typecheck fails if .cache does not return Positional';

    EVAL ｢
        my class 丁àс does Positional {
            method cache { flunk 'called .cache on an already-Positional' }
        }
        constant @갢갢àò9 = 丁àс.new;
        isa-ok @갢갢àò9, 丁àс, 'no coercion of custom Positionals';
    ｣;
}

subtest 'my | implied | @-sigilled' => {
    plan 13;
    my constant @ì갢àò1 = 42;
    is-deeply   @ì갢àò1, (42,), 'def, simple value';
    my constant @ì갢àò2 = 1, 2, 3;
    is-deeply   @ì갢àò2, (1, 2, 3), 'def, List (no parens)';
    my constant @ì갢àò3 = (1, 2, 3);
    is-deeply   @ì갢àò3, (1, 2, 3), 'def, List (with parens)';
    for @ì갢àò3 { is-deeply $_, @ì갢àò3.head, 'does not scalarize'; last }

    my constant @ì갢àò4 = [1, 2, 3];
    is-deeply   @ì갢àò4, [1, 2, 3], 'Array remains an Array';
    my constant @ì갢àò5 = (1, 2, 3).Seq;
    is-deeply   @ì갢àò5, (1, 2, 3), 'Seq gets coerced';

    { # add a scope to check scope declarator works right
        my constant @mias6 = do { %(:foo, :bar) };
        isa-ok      @mias6, List, 'def, statement (type)';
        is-deeply   @mias6.sort, (:foo, :bar).sort, 'def, statement (value)';
    }
    nok ::('@mias6'), '`my` makes constants lexical';

    EVAL ｢
        my class Е갨갨 {
            method cache {
                pass 'coercion calls .cache method';
                42,
            }
        }
        my constant @ì갢àò7 = Е갨갨.new;
        is-deeply @ì갢àò7, (42,), 'right result after coersion';
    ｣;

    throws-like ｢
        my class Е갨갨 { method cache { 42 } }
        my constant @ì갢àò8 = Е갨갨.new;
    ｣, X::TypeCheck, 'typecheck fails if .cache does not return Positional';

    EVAL ｢
        my class 丁àс does Positional {
            method cache { flunk 'called .cache on an already-Positional' }
        }
        my constant @ì갢àò9 = 丁àс.new;
        isa-ok @ì갢àò9, 丁àс, 'no coercion of custom Positionals';
    ｣;
}

subtest 'our | implied | @-sigilled' => {
    plan 13;
    our constant @갨갢àò1 = 42;
    is-deeply    @갨갢àò1, (42,), 'def, simple value';
    our constant @갨갢àò2 = 1, 2, 3;
    is-deeply    @갨갢àò2, (1, 2, 3), 'def, List (no parens)';
    our constant @갨갢àò3 = (1, 2, 3);
    is-deeply    @갨갢àò3, (1, 2, 3), 'def, List (with parens)';
    for @갨갢àò3 { is-deeply $_, @갨갢àò3.head, 'does not scalarize'; last }

    our constant @갨갢àò4 = [1, 2, 3];
    is-deeply    @갨갢àò4, [1, 2, 3], 'Array remains an Array';
    our constant @갨갢àò5 = (1, 2, 3).Seq;
    is-deeply    @갨갢àò5, (1, 2, 3), 'Seq gets coerced';

    { # add a scope to check scope declarator works right
        our constant @oias6 = do { %(:foo, :bar) };
        isa-ok    @oias6, List, 'def, statement (type)';
        is-deeply @oias6.sort, (:foo, :bar).sort, 'def, statement (value)';
    }
    ok ::('@oias6'), '`our` gives right scope';

    EVAL ｢
        my class Е갨갨 {
            method cache {
                pass 'coercion calls .cache method';
                42,
            }
        }
        our constant @갨갢àò7 = Е갨갨.new;
        is-deeply @갨갢àò7, (42,), 'right result after coersion';
    ｣;

    throws-like ｢
        my class Е갨갨 { method cache { 42 } }
        our constant @갨갢àò8 = Е갨갨.new;
    ｣, X::TypeCheck, 'typecheck fails if .cache does not return Positional';

    EVAL ｢
        my class 丁àс does Positional {
            method cache { flunk 'called .cache on an already-Positional' }
        }
        our constant @갨갢àò9 = 丁àс.new;
        isa-ok @갨갢àò9, 丁àс, 'no coercion of custom Positionals';
    ｣;
}

subtest 'my | typed | @-sigilled' => {
    plan 4;
    throws-like ｢my Int constant @ì中àò1 = 42;｣,
        X::ParametricConstant, 'simple value';
    throws-like ｢my List constant @ì中àò2 = 1, 2, 3;｣,
        X::ParametricConstant, 'list';
    throws-like ｢my IO::Path constant @ì中àò5 = 42｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant @ì中àò7 = 42｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

subtest 'our | typed | @-sigilled' => {
    plan 4;
    throws-like ｢our Int constant @갨中àò1 = 42;｣,
        X::ParametricConstant, 'simple value';
    throws-like ｢our List constant @갨中àò2 = 1, 2, 3;｣,
        X::ParametricConstant, 'list';
    throws-like ｢our IO::Path constant @갨中àò5 = 42｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant @갨中àò7 = 42｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

##
## %-sigilled
##

subtest 'implied | implied | %-sigilled' => {
    plan 16;
    throws-like ｢
        use v6.d;
        constant %갢갢両ò0 = 42
    ｣, X::Hash::Store::OddNumber, 'def, simple value';

    constant  %갢갢両ò1 = 1, 2, 3, 4;
    is-deeply %갢갢両ò1, Map.new((1 => 2, 3 => 4)), 'def, List of values';
    constant  %갢갢両ò2 = :42foo, :70bar;
    is-deeply %갢갢両ò2, Map.new((:42foo, :70bar)),
        'def, List of Pairs (no parens)';
    constant  %갢갢両ò3 = (:42foo, :70bar);
    is-deeply %갢갢両ò3, Map.new((:42foo, :70bar)),
        'def, List of Pairs (with parens)';
    constant  %갢갢両ò4 = Map.new: (:42foo, :70bar);
    is-deeply %갢갢両ò4, Map.new((:42foo, :70bar)), 'def, Map';
    for %갢갢両ò4 { isa-ok $_, Pair, 'does not scalarize'; last }

    constant  %갢갢両ò5 = {:42foo, :70bar};
    is-deeply %갢갢両ò5, {:42foo, :70bar}, 'Hash remains same';
    constant  %갢갢両ò6 = :{:42foo, :70bar};
    is-deeply %갢갢両ò6, :{:42foo, :70bar}, 'Object Hash remains same';
    constant  %갢갢両ò7 = :42foo;
    is-deeply %갢갢両ò7, :42foo.Pair, 'Pair remains same';
    constant  %갢갢両ò8 = bag(<a a a b c>);
    is-deeply %갢갢両ò8, bag(<a a a b c>), 'Bag remains same';

    { # add a scope to check scope declarator works right
        constant  %iihs9 = do { %(:foo, :bar) };
        is-deeply %iihs9, %(:foo, :bar), 'def, statement';
    }
    ok ::('%iihs9'), 'implied scope declarator behaves like `our`';

    EVAL ｢
        use v6.d;
        my class Е갨갨 {
            method Map {
                pass 'coercion calls .Map method';
                Map.new: (:42foo, :70bar)
            }
        }
        constant %갢갢両ò10 = Е갨갨.new;
        is-deeply %갢갢両ò10, Map.new((:42foo, :70bar)),
            'right result after coersion';
    ｣;

    throws-like ｢
        use v6.d;
        my class Е갨갨 { method Map { 42 } }
        constant %갢갢両ò11 = Е갨갨.new;
    ｣, X::TypeCheck, 'typecheck fails if .Map does not return Associative';

    EVAL ｢
        use v6.d;
        my class 丁àс does Associative {
            method Map { flunk 'called .Map on an already-Associative' }
        }
        constant %갢갢両ò12 = 丁àс.new;
        isa-ok %갢갢両ò12, 丁àс, 'no coercion of custom Associative';
    ｣;
}

subtest 'my | implied | %-sigilled' => {
    plan 16;
    throws-like ｢
        use v6.d;
        my constant %ì갢両ò0 = 42
    ｣, X::Hash::Store::OddNumber, 'def, simple value';

    my constant %ì갢両ò1 = 1, 2, 3, 4;
    is-deeply   %ì갢両ò1, Map.new((1 => 2, 3 => 4)), 'def, List of values';
    my constant %ì갢両ò2 = :42foo, :70bar;
    is-deeply   %ì갢両ò2, Map.new((:42foo, :70bar)),
        'def, List of Pairs (no parens)';
    my constant %ì갢両ò3 = (:42foo, :70bar);
    is-deeply   %ì갢両ò3, Map.new((:42foo, :70bar)),
        'def, List of Pairs (with parens)';
    my constant %ì갢両ò4 = Map.new: (:42foo, :70bar);
    is-deeply   %ì갢両ò4, Map.new((:42foo, :70bar)), 'def, Map';
    for %ì갢両ò4 { isa-ok $_, Pair, 'does not scalarize'; last }

    my constant %ì갢両ò5 = {:42foo, :70bar};
    is-deeply   %ì갢両ò5, {:42foo, :70bar}, 'Hash remains same';
    my constant %ì갢両ò6 = :{:42foo, :70bar};
    is-deeply   %ì갢両ò6, :{:42foo, :70bar}, 'Object Hash remains same';
    my constant %ì갢両ò7 = :42foo;
    is-deeply   %ì갢両ò7, :42foo.Pair, 'Pair remains same';
    my constant %ì갢両ò8 = bag(<a a a b c>);
    is-deeply   %ì갢両ò8, bag(<a a a b c>), 'Bag remains same';

    { # add a scope to check scope declarator works right
        my constant %mihs9 = do { %(:foo, :bar) };
        is-deeply   %mihs9, %(:foo, :bar), 'def, statement';
    }
    nok ::('%mihs9'), '`my` makes constants lexical';

    EVAL ｢
        use v6.d;
        my class Е갨갨 {
            method Map {
                pass 'coercion calls .Map method';
                Map.new: (:42foo, :70bar)
            }
        }
        my constant %ì갢両ò10 = Е갨갨.new;
        is-deeply %ì갢両ò10, Map.new((:42foo, :70bar)),
            'right result after coersion';
    ｣;

    throws-like ｢
        use v6.d;
        my class Е갨갨 { method Map { 42 } }
        my constant %ì갢両ò11 = Е갨갨.new;
    ｣, X::TypeCheck, 'typecheck fails if .Map does not return Associative';

    EVAL ｢
        use v6.d;
        my class 丁àс does Associative {
            method Map { flunk 'called .Map on an already-Associative' }
        }
        my constant %ì갢両ò12 = 丁àс.new;
        isa-ok %ì갢両ò12, 丁àс, 'no coercion of custom Associative';
    ｣;
}

subtest 'our | implied | %-sigilled' => {
    plan 16;
    throws-like ｢
        use v6.d;
        our constant %갨갢両ò0 = 42
    ｣, X::Hash::Store::OddNumber, 'def, simple value';

    our constant %갨갢両ò1 = 1, 2, 3, 4;
    is-deeply    %갨갢両ò1, Map.new((1 => 2, 3 => 4)), 'def, List of values';
    our constant %갨갢両ò2 = :42foo, :70bar;
    is-deeply    %갨갢両ò2, Map.new((:42foo, :70bar)),
        'def, List of Pairs (no parens)';
    our constant %갨갢両ò3 = (:42foo, :70bar);
    is-deeply    %갨갢両ò3, Map.new((:42foo, :70bar)),
        'def, List of Pairs (with parens)';
    our constant %갨갢両ò4 = Map.new: (:42foo, :70bar);
    is-deeply    %갨갢両ò4, Map.new((:42foo, :70bar)), 'def, Map';
    for %갨갢両ò4 { isa-ok $_, Pair, 'does not scalarize'; last }

    our constant %갨갢両ò5 = {:42foo, :70bar};
    is-deeply    %갨갢両ò5, {:42foo, :70bar}, 'Hash remains same';
    our constant %갨갢両ò6 = :{:42foo, :70bar};
    is-deeply    %갨갢両ò6, :{:42foo, :70bar}, 'Object Hash remains same';
    our constant %갨갢両ò7 = :42foo;
    is-deeply    %갨갢両ò7, :42foo.Pair, 'Pair remains same';
    our constant %갨갢両ò8 = bag(<a a a b c>);
    is-deeply    %갨갢両ò8, bag(<a a a b c>), 'Bag remains same';

    { # add a scope to check scope declarator works right
        our constant %oihs9 = do { %(:foo, :bar) };
        is-deeply    %oihs9, %(:foo, :bar), 'def, statement';
    }
    ok ::('%oihs9'), 'implied scope declarator behaves like `our`';

    EVAL ｢
        use v6.d;
        my class Е갨갨 {
            method Map {
                pass 'coercion calls .Map method';
                Map.new: (:42foo, :70bar)
            }
        }
        our constant %갨갢両ò10 = Е갨갨.new;
        is-deeply %갨갢両ò10, Map.new((:42foo, :70bar)),
            'right result after coersion';
    ｣;

    throws-like ｢
        use v6.d;
        my class Е갨갨 { method Map { 42 } }
        our constant %갨갢両ò11 = Е갨갨.new;
    ｣, X::TypeCheck, 'typecheck fails if .Map does not return Associative';

    EVAL ｢
        use v6.d;
        my class 丁àс does Associative {
            method Map { flunk 'called .Map on an already-Associative' }
        }
        our constant %갨갢両ò12 = 丁àс.new;
        isa-ok %갨갢両ò12, 丁àс, 'no coercion of custom Associative';
    ｣;
}

subtest 'my | typed | %-sigilled' => {
    plan 3;
    throws-like ｢my Int constant %ì中両ò1 = :foo;｣,
        X::ParametricConstant, 'simple value';
    throws-like ｢my IO::Path constant %ì中両ò2 = :a(42)｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant %ì中両ò3 = :a(42)｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

subtest 'our | typed | %-sigilled' => {
    plan 3;
    throws-like ｢our Int constant %갨中両ò1 = :foo;｣,
        X::ParametricConstant, 'statement';
    throws-like ｢our IO::Path constant %갨中両ò2 = :a(42)｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant %갨中両ò3 = :a(42)｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

# vim: expandtab shiftwidth=4
