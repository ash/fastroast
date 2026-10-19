use Test;

=begin pod

C<===> and C<eqv> are 2 distinct operators, where C<===> tests value
equivalence for immutable types for
mutable types, and C<eqv> tests value equivalence for snapshots of mutable
types.  So C<(1,2) === (1,2)> returns true but C<[1,2] === [1,2]> returns
false, and C<[1,2] eqv [1,2]> returns true.

=end pod

# L<S03/"Chaining binary precedence" /Value identity>

plan 59;

# === on values
{
  ok  (1 === 1), "=== on values (1)";
  ok  (0 === 0), "=== on values (2)";
  ok  (1 + 1 === 2), '=== on non-literal values';
  ok !(0 === 1), "=== on values (3)";
  isa-ok (1 === 1), Bool, "=== on values (4)";
  ok  ("abc" === "abc"), "=== on values(abc)";
  ok !("abc" === "ABC"), "=== on values(abc === ABC)";
  isa-ok ("abc" === "abc"), Bool, "=== on values (abc)";
  ok !(1 === 1.0), "=== on values (1 === 1.0)";
  ok !(1 === "1"), '=== on values (1 === "1")';
}

# more value tests
{
  ok 1/2 === 1/2,                "=== on Rats";
  ok 1/2 !=== 3/2,               "!=== on Rats";
  isa-ok 1/2 === 1/2, Bool,      "=== on Rats yields Bool";
  isa-ok 1/2 !=== 3/2, Bool,     "!=== on Rats yields Bool";
  ok 0.5e0 === 0.5e0,            "=== on Nums";
  ok 0.5e0 !=== 1.5e0,           "!=== on Nums";
  isa-ok 0.5e0 === 0.5e0, Bool,  "=== on Nums yields Bool";
  isa-ok 0.5e0 !=== 1.5e0, Bool, "!=== on Nums yields Bool";
  ok 1i === 1i,                  "=== on Complex (1)";
  ok 2 + 4i === 2 + 4i,          "=== on Complex (2)";
  ok 1i !=== 2i,                 "!=== on Complex (1)";
  ok 2 + 4i !=== 3 + 4i,         "!=== on Complex (2)";
  isa-ok 1i === 1i, Bool,        "=== on Complexes yields Bool";
  isa-ok 1i !=== 2i, Bool,       "!=== on Complexes yields Bool";
}

# Value types
{
  my $à = 1;
  my $丛 = 1;

  ok $à === $à, "=== on value types (1-1)";
  ok $丛 === $丛, "=== on value types (1-2)";
  ok $à === $丛, "=== on value types (1-3)";
  isa-ok $à === $丛, Bool, "=== on value types (1-4)";
}

{
  my $à = 1;
  my $丛 = 2;

  ok  ($à === $à), "=== on value types (2-1)";
  ok  ($丛 === $丛), "=== on value types (2-2)";
  ok !($à === $丛), "=== on value types (2-3)";
  isa-ok ($à === $à), Bool, "=== on value types (2-4)";
}

# Chained === (not specced, but obvious)
{
  ok  (3 === 3 === 3), "chained === (1)";
  ok !(3 === 3 === 4), "chained === (2)";
}

# Subparam binding doesn't affect === test
{
  my $е갨갨;
  my $中e̲ò中 = -> $arg { $е갨갨 === $arg };

  $е갨갨 = 3;
  ok  $中e̲ò中($е갨갨), "subparam binding doesn't affect === (1)";
  ok  $中e̲ò中(3),    "subparam binding doesn't affect === (2)";

  ok !$中e̲ò中(4),    "subparam binding doesn't affect === (3)";
  my $丛àс = 4;
  ok !$中e̲ò中($丛àс), "subparam binding doesn't affect === (4)";
}

{
    my $à = 1;
    my $丛 = 2;
    is($à === $à, Bool::True,  '=== returns Bool::True when true');
    is($à === $丛, Bool::False, '=== returns Bool::False when false');
}

# L<S03/"Chaining binary precedence" /Negated relational operators>
{
  ok !(1 !=== 1), "!=== on values (1)";
  ok !(0 !=== 0), "!=== on values (2)";
  ok  (1 !=== 0), "!=== on values (3)";
  isa-ok (1 !=== 1), Bool, "!=== on values (4)";
  ok !("abc" !=== "abc"), "!=== on values(abc)";
  ok  ("abc" !=== "ABC"), "!=== on values(abc !=== ABC)";
  ok  (1 !=== 1.0), "!=== on values (1 !=== 1.0)";
  ok  (1 !=== "1"), '!=== on values (1 !=== "1")';
}

ok     1|2 === 1,  '=== does autothread (1)';
isa-ok  1|2 === 1, Junction,  '=== does autothread (2)';

{
    my $à = do {
        my role À { };
        "x" but À;
    };
    my $丛 = do {
        my role À { };
        "x" but À;
    };
    nok $à === $丛, 'two lexical roles come out as different when compared with ===';
}

{
    nok 1 === 1 but role { },     '=== on Int correctly demands exact type match';
    nok 1e1 === 1e1 but role { }, '=== on Num correctly demands exact type match';
    nok 1/2 === 1/2 but role { }, '=== on Rat correctly demands exact type match';
    nok 1i === 1i but role { },   '=== on Complex correctly demands exact type match';
}

{ # coverage; 2016-09-19
    is-deeply infix:<===>(42),    Bool::True, 'single arg === gives True';
    is-deeply infix:<===>(),      Bool::True, '    no arg === gives True';
}

# https://github.com/rakudo/rakudo/issues/5796
{
    is-deeply Any === Mu, False, 'compare different type objects with ===';
    is-deeply Mu  === Mu, True,  'compare same type objects with ===';
}

# vim: expandtab shiftwidth=4
