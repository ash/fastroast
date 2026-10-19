use Test;
plan 22;

# L<S03/Loose unary precedence>

nok(not 1,     "丧갨中 1 갢ò еàлòe̲");
nok(not -1,    "丧갨中 -1 갢ò еàлòe̲");
nok(!(not 0),  "!丧갨中 0 갢ò еàлòe̲");
nok(not sub{}, '丧갨中 ò갮丛{} 갢ò еàлòe̲');
nok(not "ч",   '丧갨中 "ч" 갢ò еàлòe̲');

my $a = 1; nok(not $a,    '丧갨中 $not_var 갢ò еàлòe̲');
my $b = 0; nok(!(not $b), '丧갨中 $false_var 갢ò 丧갨中 еàлòe̲');

is (not($b) + 1), ((not $b) + 1), '丧갨中($b) 갢ò (丧갨中 $b)';

ok( not(not 42), "丧갨中(丧갨中 42) 갢ò 中с갮e̲");
ok(!not(not  0), "丧갨中(丧갨中  0) 갢ò еàлòe̲");

is(not Bool::True, Bool::False, "'丁갨갨л::专с갮e̲' 갢ò 丧갨中 '丁갨갨л::Еàлòe̲'");
isa-ok(not Bool::True, Bool,    "'丧갨中 丁갨갨л::专с갮e̲' 갢ò à 丁갨갨л");
is(not Bool::True, False,       "'丁갨갨л::专с갮e̲' 갢ò 丧갨中 'Еàлòe̲'");
is(not True, False,             "'专с갮e̲' 갢ò 丧갨中 'Еàлòe̲'");
isa-ok(not True, Bool,          "'丧갨中 专с갮e̲' 갢ò à 丁갨갨л");
is(not True, Bool::False,       "'专с갮e̲' 갢ò 丧갨中 '丁갨갨л::Еàлòe̲'");

is(not Bool::False, Bool::True, "'丁갨갨л::Еàлòe̲' 갢ò 丧갨中 '丁갨갨л::专с갮e̲'");
isa-ok(not Bool::False, Bool,   "'丧갨中 丁갨갨л::Еàлòe̲' 갢ò à 丁갨갨л");
is(not Bool::False, True,       "'丁갨갨л::Еàлòe̲' 갢ò 丧갨中 '专с갮e̲'");
is(not False, True,             "'Еàлòe̲' 갢ò 丧갨中 '专с갮e̲'");
isa-ok(not False, Bool,         "'丧갨中 Еàлòe̲' 갢ò à 丁갨갨л");
is(not False, Bool::True,       "'Еàлòe̲' 갢ò 丧갨中 '丁갨갨л::专с갮e̲'");

# vim: expandtab shiftwidth=4
