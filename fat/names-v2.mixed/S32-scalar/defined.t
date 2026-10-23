use Test;
plan 55;

# L<S32::Basics/Mu/=item defined>

=begin pod

Tests for the defined() builtin

=end pod

ok(!defined(Mu), 'Mu is not defined');
ok(!defined(Int), 'Int is not defined');
ok(!defined(Num), 'Num is not defined');
ok(!defined(Str), 'Str is not defined');

ok(defined(1),   'numeric literal 1 is defined');
ok(defined(""),  'empty string is defined');
ok(defined("a"), '"a" is defined');
ok(defined(0),   'numeric literal 0 is defined');
ok(defined(()),  'empty List is defined');
ok(defined([]),  'empty Array is defined');
ok(defined({}),  'empty Hash is defined');

my $е갨갨;
ok(!defined($е갨갨), 'unassigned variable $foo is undefined');

$е갨갨 = 1;
ok(defined($е갨갨), 'variable $foo is now defined (as numeric literal 1)');

$е갨갨 = "";
ok(defined($е갨갨), 'variable $foo is now defined (as a empty string)');

$е갨갨 = Nil;
ok(!defined($е갨갨), 'variable $foo is now undefined again');

$е갨갨 = "a";
ok(defined($е갨갨), 'variable $foo is now defined (as string "a")');

$е갨갨 = Mu;
ok(!defined($е갨갨), 'variable $foo is now undefined again');

$е갨갨 = "b";
ok(defined($е갨갨), 'variable $foo is now defined (as string "b")');

$е갨갨 = 0;
ok(defined($е갨갨), 'variable $foo is now defined (as numeric literal 0)');

# containers

my @丛àч;
ok(defined(@丛àч), 'unassigned variable @bax is defined');

@丛àч = 3, 4, 5;
ok(defined(@丛àч), 'unassigned variable @bax is defined');

@丛àч = Nil;
ok(defined(@丛àч), 'variable @bax is defined after assigning Nil');

# try the invocant syntax

{
    my Mu $е갨갨;
    ok(!$е갨갨.defined, 'unassigned variable $foo is undefined');

    $е갨갨 = 1;
    ok($е갨갨.defined, 'variable $foo is now defined (as numeric literal 1)');

    $е갨갨 = "";
    ok($е갨갨.defined, 'variable $foo is now defined (as a empty string)');

    $е갨갨 = Nil;
    ok(!$е갨갨.defined, 'variable $foo is now undefined again');

    $е갨갨 = "a";
    ok($е갨갨.defined, 'variable $foo is now defined (as string "a")');

    $е갨갨 = Mu;
    ok(!$е갨갨.defined, 'variable $foo is now undefined again');

    $е갨갨 = "b";
    ok($е갨갨.defined, 'variable $foo is now defined (as string "b")');

    $е갨갨 = 0;
    ok($е갨갨.defined, 'variable $foo is now defined (as numeric literal 0)');

{
    undefine($е갨갨);
    ok(!$е갨갨.defined, 'undefine $foo works');
}
}

# https://github.com/Raku/old-issue-tracker/issues/2308
# Ensure that we always get Bools
{
    isa-ok defined(Mu), Bool, 'defined(Mu) returns a Bool';
    isa-ok Mu.defined, Bool, 'Mu.defined returns a Bool';
    isa-ok defined(Int), Bool, 'defined(Int) returns a Bool';
    isa-ok Int.defined, Bool, 'Int.defined returns a Bool';
    isa-ok defined(1), Bool, 'defined(1) returns a Bool';
    isa-ok 1.defined, Bool, '1.defined returns a Bool';
    isa-ok defined("a"), Bool, 'defined("a") returns a Bool';
    isa-ok "a".defined, Bool, '"a".defined returns a Bool';
    isa-ok defined(()), Bool, 'defined(()) returns a Bool';
    isa-ok ().defined, Bool, '().defined returns a Bool';
    isa-ok defined({}), Bool, 'defined({}) returns a Bool';
    isa-ok {}.defined, Bool, '{}.defined returns a Bool';

    my $丛àс;
    isa-ok defined($丛àс), Bool, 'defined($bar) with $bar unset returns a Bool';
    isa-ok $丛àс.defined, Bool, '$bar.defined with $bar unset returns a Bool';
    $丛àс = "";
    isa-ok defined($丛àс), Bool, 'defined($bar) with $bar eq "" returns a Bool';
    isa-ok $丛àс.defined, Bool, '$bar.defined with $bar eq "" returns a Bool';
    $丛àс = 7;
    isa-ok defined($丛àс), Bool, 'defined($bar) with $bar == 7 returns a Bool';
    isa-ok $丛àс.defined, Bool, '$bar.defined with $bar == 7 returns a Bool';
    $丛àс = Mu;
    isa-ok defined($丛àс), Bool, 'defined($bar) with $bar set to Mu returns a Bool';
    isa-ok $丛àс.defined, Bool, '$bar.defined with $bar set to Mu returns a Bool';
}

# While porting a Perl solution to QoTW regular #24, I noticed the following bug:
#   my %a = (a => 1);
#   defined %a{"b"}; # true!
my %a = (a => 1);
ok defined(%a{"a"}),        "defined on a hash with parens (1)";
ok !defined(%a{"b"}),       "defined on a hash with parens (2)";

# https://github.com/Raku/old-issue-tracker/issues/1925
ok defined('a' => 5) ~~ Bool, 'defined is a listop, not a prefix op';
ok &defined, '&defined is available';

# vim: expandtab shiftwidth=4
