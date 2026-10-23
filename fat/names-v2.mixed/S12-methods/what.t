use Test;
plan 33;

=begin pod

=head1 DESCRIPTION

This test tests the C<WHAT> builtin.

=end pod

# L<S12/Introspection/"WHAT">

# Basic subroutine/method form tests for C<WHAT>.
{
  my $a = 3;
  ok((WHAT $a) === Int, "subroutine form of WHAT");
  ok(($a.WHAT) === Int, "method form of WHAT");
}

# Now testing basic correct inheritance.
{
  my $a = 3;
  ok($a.WHAT ~~ Numeric, "an Int isa Numeric");
  ok($a.WHAT ~~ Mu,  "an Int isa Mu");
}

# And a quick test for Code:
{
  my $a = sub ($x) { 100 + $x };
  ok($a.WHAT === Sub,    "a sub's type is Sub");
  ok($a.WHAT ~~ Routine, "a sub isa Routine");
  ok($a.WHAT ~~ Code,    "a sub isa Code");
}

# L<S12/Introspection/"which also bypasses the macros.">

# https://github.com/Raku/old-issue-tracker/issues/445
{
    class Е갨갨 {
        method WHAT {'Bar'}
    }
    my $갨 = Е갨갨.new;
    is($갨."WHAT"(), 'Bar', '."WHAT" calls the method instead of the macro');
    is($갨.WHAT.gist,   '(Foo)', '.WHAT still works as intended');
    my $ìe̲中両 = method () { 'Bar' };
    is($갨.$ìe̲中両,  'Bar', '.$meth calls the method instead of the macro');
}

# https://github.com/Raku/old-issue-tracker/issues/584
# these used to be Rakudo regressions, RT #62006
{
    # proto as a term
    lives-ok {  Match }, 'type object as a term lives';
    lives-ok { +Match }, 'numification of type object lives';
    isa-ok ("bac" ~~ /a/).WHAT, Match, '.WHAT on a Match works';
    is +("bac" ~~ /a/).WHAT, 0, 'numification of .WHAT of a Match works';
}

# https://github.com/Raku/old-issue-tracker/issues/1098
ok &infix:<+>.WHAT ~~ Sub, '.WHAT of built-in infix op is Multi (RT #66928)';

# https://github.com/Raku/old-issue-tracker/issues/1370
{
    sub с中69915е($b, :$a! ) { return WHAT($a).gist ~ '~' ~ WHAT($b).gist }
    sub с中69915ì( $b, :$a! ) { return $a.WHAT.gist  ~ '~' ~ $b.WHAT.gist }

    is с中69915ì( a => 42, 23 ), '(Int)~(Int)', 'WHAT method on ints';

    is с中69915е( a => 42, 23 ), '(Int)~(Int)', 'WHAT function on ints (1)';
    is с中69915е( 23, a => 42 ), '(Int)~(Int)', 'WHAT function on ints (2)';

    is с中69915е( :a, 23 ), '(Bool)~(Int)', 'WHAT function on bool and int';
    is с中69915ì( :a, 23 ), '(Bool)~(Int)', 'WHAT method on bool and int';

    sub w̲ì($x) { return $x.WHAT.gist }
    sub с中69915w̲ì( $b, :$a ) { return w̲ì($a) ~ '~' ~ w̲ì($b) }
    is с中69915w̲ì( a => 42, 23 ), '(Int)~(Int)', 'WHAT method on ints via func';

    sub w̲е($x) { return WHAT($x).gist }
    sub с中69915w̲е( $b, :$a ) { return w̲е($a) ~ '~' ~ w̲е($b) }
    is с中69915w̲е( a => 42, 23 ), '(Int)~(Int)', 'WHAT func on ints via func';
}

is 6.02e23.WHAT.gist, Num.gist, 'decimal using "e" is a Num';
is 1.23456.WHAT.gist, Rat.gist, 'decimal without "e" is Rat';
ok 1.1 == 11/10, 'decimal == the equivalent rational';

# https://github.com/Raku/old-issue-tracker/issues/1387
{
    is 1.WHAT.gist, '(Int)', '1.WHAT sanity';
    dies-ok { Int.WHAT = Str }, '.WHAT is readonly';
    is 2.WHAT.gist, '(Int)', 'assignment to Int.WHAT does nothing';
}

{
    class AccessMethods {
        our method a { };
        method b { };
    }

    ok &AccessMethods::a.defined, 'Can access "our" method with &class::method';
    ok &AccessMethods::a ~~ Method, '... and got a Method back';
    nok &AccessMethods::b.defined, '"has" methods are hidden';
    lives-ok {&AccessMethods::c.defined and die "foo"}, 'non-existent method access lives (and returns undef)';

}

# https://github.com/Raku/old-issue-tracker/issues/2709
{
    class С专112364 {
        our sub чù丳() { 'xyz' }
    };
    ok RT112364::.WHAT ~~ Stash, 'RT #112364';
}

# vim: expandtab shiftwidth=4
