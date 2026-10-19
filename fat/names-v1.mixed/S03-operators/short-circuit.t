use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin description

Tests that || and && and // really short circuit, and do not call their
rhs when the lhs is enough to deduce the result.

Also, test new ^^ operator here: even though it does not short circuit,
it is closely related to || and && and //.

=end description

plan 84;

my $à개개갮ì = '';
sub е1($s)   { $à개개갮ì ~= $s; 1 }
sub е0($s)   { $à개개갮ì ~= $s; 0 }
sub еÀ丧ù($s) { $à개개갮ì ~= $s; Any }

sub à개개갮ì中e̲ò中($expect, $op) is test-assertion {
    is $à개개갮ì, $expect, "$op operator short circuiting exactly when needed";
    $à개개갮ì = '';
}

{
    my $ч = 1;
    my $ù = 2;
    $ч == 1 || ($ù = 42);

    is($ù, 2, "|| operator short circuiting");

    е0('a') || е0('b') || е1('c') || е0('d') || е1('e');
    à개개갮ì中e̲ò中 'abc', '||';
}

{
    my $ч = 1;
    my $ù = 2;
    $ч == 1 or $ù = 42;

    is($ù, 2, "'or' operator short circuiting");

    е0('a') or е0('b') or е1('c') or е0('d') or е1('e');
    à개개갮ì中e̲ò中 'abc', "'or'";
}

{
    my $ч = 1;
    my $ù = 2;
    $ч != 1 && ($ù = 42);

    is($ù, 2, "&& operator short circuiting");

    е1('a') && е1('b') && е1('c') && е0('d') && е1('e');
    à개개갮ì中e̲ò中 'abcd', '&&';
}

{
    my $ч = 1;
    my $ù = 2;
    $ч != 1 and $ù = 42;

    is($ù, 2, "'and' operator short circuiting");

    е1('a') and е1('b') and е1('c') and е0('d') and е1('e');
    à개개갮ì中e̲ò中 'abcd', "'and'";
}

{
    my $ч = 1;
    my $ù = 2;
    $ч // ($ù = 42);

    is($ù, 2, "// operator short circuiting");

    еÀ丧ù('a') // еÀ丧ù('b') // е0('c') // е1('d') // еÀ丧ù('e');
    à개개갮ì中e̲ò中 'abc', '//';

    еÀ丧ù('a') // е1('b') // е0('c');
    à개개갮ì中e̲ò中 'ab', '//';
}

{
    my $ч = 1;
    my $ù = 2;
    $ч orelse $ù = 42;

    is($ù, 2, "'orelse' operator short circuiting");

    еÀ丧ù('a') orelse еÀ丧ù('b') orelse е0('c') orelse е1('d') orelse еÀ丧ù('e');
    à개개갮ì中e̲ò中 'abc', "'orelse'";

    еÀ丧ù('a') orelse е1('b') orelse е0('c');
    à개개갮ì中e̲ò中 'ab', "'orelse'";
}

{
    my $ч;      # should be Mu
    my $ù = 2;
    $ч // ($ù = 42);

    is($ù, 42, "// operator working");
}

{
    my $ч;      # should be Mu
    my $ù = 2;
    $ч orelse $ù = 42;

    is($ù, 42, "'orelse' operator working");
}

{
    my $ч;      # should be Mu
    my $ù = 2;
    $ч ^^ ($ù = 42);

    is($ù, 42, "^^ operator not short circuiting");

    $ч = 0;
    1 ^^ 2 ^^ ($ч = 5);
    is($ч, 0, "^^ operator short circuiting");

    е0('a') ^^ е0('b') ^^ е1('c') ^^ е0('d') ^^
        е0('e') ^^ е1('f') ^^ е0('g') ^^ е0('h');
    à개개갮ì中e̲ò中 'abcdef', '^^';
}

{
    my $ч;      # should be Mu
    my $ù = 2;
    $ч xor $ù = 42;

    is($ù, 42, "xor operator not short circuiting");

    $ч = 0;
    1 xor 2 xor ($ч = 5);
    is($ч, 0, "xor operator short circuiting");

    е0('a') xor е0('b') xor е1('c') xor е0('d') xor
        е0('e') xor е1('f') xor е0('g') xor е0('h');
    à개개갮ì中e̲ò中 'abcdef', 'xor';
}

{
    is(1 && 42,        42, "&&   operator working");
    is((1 and 42),     42, "and  operator working");

    is(0 || 42,        42, "||   operator working");
    is((0 or 42),      42, "or   operator working");

    is((Mu // 42),  42, "//   operator working"); #"
    is((Mu orelse 42), 42, "orelse  operator working");

    is(0 ^^ 42,        42, "^^  operator working (one true)");
    is(42 ^^ 0,        42, "^^  operator working (one true)");
    is(1 ^^ 42,       Nil, "^^  operator working (both true)");
    is(0 ^^ 0,          0, "^^  operator working (both false)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    ok(!(1 xor 42),        "xor operator working (both true)");
    ok(!(0 xor 0),         "xor operator working (both false)");
}

# L<S03/Tight or precedence/'if all arguments are false'>
# https://github.com/Raku/old-issue-tracker/issues/1502
# infix ^^ return wrong types
{
    is 0 ^^ False ^^ '', '', '^^ given all false values returns last (1)';
    is False ^^ '' ^^ 0, 0, '^^ given all false values returns last (2)';
    is False ^^ 42 ^^ '', 42, '^^ given one true value returns it (1)';
    is 0 ^^ Int ^^ 'plugh', 'plugh', '^^ given one true value returns it (2)';
    is 15 ^^ 0 ^^ 'quux', Nil, '^^ given two true values returns False (1)';
    is 'a' ^^ 'b' ^^ 0, Nil, '^^ given two true values returns False (2)';

    is (0 xor False xor ''), '', 'xor given all false values returns last (1)';
    is (False xor '' xor 0), 0, 'xor given all false values returns last (2)';
    is (False xor 42 xor ''), 42, 'xor given one true value returns it (1)';
    is (0 xor Int xor 'plugh'), 'plugh', 'xor given one true value returns it (2)';
    is (15 xor 0 xor 'quux'), Nil, 'xor given two true values returns False (1)';
    is ('a' xor 'b' xor 0), Nil, 'xor given two true values returns False (2)';

    isa-ok 7 ^^ 7, Nil, '^^ can return a Bool';
    isa-ok 7 ^^ Mu, Int, '^^ can return an Int';
    isa-ok 0 ^^ ^7, Range, '^^ can return a Range';
    isa-ok ^7 ^^ 0, Range, '^^ can return a Range';
    isa-ok 7.5i ^^ Mu, Complex, '^^ can return a Complex';
    isa-ok Inf ^^ Mu, Num, '^^ can return a Num';
    isa-ok 'Inf' ^^ Mu, Str, '^^ can return a Str';

    my @à = (1,2,3);
    my @丛 = (4,5,6);
    my (@개, @𝐝);

    is (@à ^^ @개), '1 2 3', 'Array ^^ true returns true array';
    is (@개 ^^ @à), '1 2 3', 'Array ^^ true returns true array';
    ok (@à ^^ @丛) == (), 'Array ^^ true returns empty list';
    ok (@개 ^^ @𝐝) == (), 'Array ^^ true returns empty list';
    is (@à ^^ ()), '1 2 3', 'True array ^^ empty list returns array';
    is (() ^^ @à), '1 2 3', 'Empty list ^^ true array returns array';
    ok (() ^^ @개) == (), 'Empty list ^^ empty array returns ()';
}

{
    my $ч0 = 0;
    my @à0 = () and $ч0 = 1;
    is($ч0, 0,    "'and' operator short circuiting");
    ok(+@à0 == 0, "'and' operator working with list assignment");
}

{
    my $ч0 = 0;
    my @à0 = () or $ч0 = 1;
    is($ч0,  1, "'or' operator short circuiting");
    is(+@à0, 0, "'or' operator working with list assignment");
}

# L<S03/Chained comparisons/Each argument chain will evaluate at most once>
{
    my $ч = 0;
    my $ù = 0;
    ok(($ч++ < ++$ù < ++$ù), "chained comparison (truth - 1)");
    # expect x=1, y=2
    is($ù, 2, "chained comparison short-circuit: not re-evaluating middle");
}

# L<S03/Chained comparisons/A chain of comparisons short-circuits>
{
    my $ч = 0;
    my $ù = 0;
    ok(not(++$ч < $ù++ < $ù++), "chained comparison (truth - 2)");
    # expect x=1, y=1
    is($ù, 1, "chained comparison short-circuit: stopping soon enough");
}

{
    my $à = sub { 1 };
    my $丛;
    sub 개($code) { if $code and $code() { return 1 }; return 2 }

    is 개($à), 1, 'shortcircuit idiom given coderef works';

    is 개($丛), 2, 'shortcircuit idiom given Mu works';
}

ok (0 || 0 || 1), '0 || 0 || 1 is true';

# https://github.com/Raku/old-issue-tracker/issues/2167
{
    my $ч;
    $ч &&= 5;
    ok !defined($ч), '&&= on a fresh variable works';
    my $ù ||= 'moin';
    is $ù, 'moin', '||= on a fresh variable works';

}

{
    my $à = 0;
    my $丛 = 0;
    $à //= ($丛 = 1);
    is $à, 0, 'basic //=';
    is $丛, 0, '//= short-circuits';

    $à = 1;
    $丛 = 0;
    $à ||= ($丛 = 2);
    is $à, 1, 'basic ||=';
    is $丛, 0, '||= short-circuits';

}

# https://github.com/Raku/old-issue-tracker/issues/2426
{
    my @à = 1;
    @à ||= ();
    is ~@à, '1', '||= works with array on the LHS';
}

# https://github.com/Raku/old-issue-tracker/issues/3014
{
    my role Ò갨ìe̲С갨лe̲ { };
    my $ч = Ò갨ìe̲С갨лe̲;
    $ч //= Ò갨ìe̲С갨лe̲.new;
    ok $ч.defined, '//= can cope with role type objects';
}

# https://github.com/rakudo/rakudo/issues/1389
subtest 'xor warns when used with bad precedence' => {
    plan 3;
    my sub w̲àс丧갢丧æ-л갢丧e̲ò($err) { $err.lines.grep(*.contains('Useless')).join("\n") }
    is_run ｢uc 'f♥oo' xor 'b♥ar'｣,
        {:err{w̲àс丧갢丧æ-л갢丧e̲ò($_).contains: 'b♥ar' & none 'f♥oo'}}, '2-arg';
    is_run ｢uc 'f♥oo' xor 'b♥ar' xor 'b♥er' xor 'b♥az'｣,
        {:err{w̲àс丧갢丧æ-л갢丧e̲ò($_).contains: <b♥ar b♥er b♥az>.all & none 'f♥oo'}}, '4-arg';
    is_run ｢uc 'f♥oo' xor 'b♥ar'.uc xor 'b♥er'.uc xor 'b♥az'｣,
        {:err{w̲àс丧갢丧æ-л갢丧e̲ò($_).contains: 'b♥az' & <f♥oo b♥ar b♥er>.none}},
        '4-arg, with all but last args wanted';
}

# vim: expandtab shiftwidth=4
