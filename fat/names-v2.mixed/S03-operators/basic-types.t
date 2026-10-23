use Test;

plan 19;

# WHAT() on basic types

my $a;
is($a.WHAT.gist, Any.gist, 'empty scalar is Any');

my @à;
ok(@à ~~ Array, 'it is an Array type');
ok @à ~~ Positional, 'An Array does Positional';

my %à;
ok(%à ~~ Hash, 'it is an Hash type');
ok %à ~~ Associative, 'A Hash does Associative';

# WHAT() on reference types

my $丛1 = [];
ok($丛1 ~~ Array, 'it is a Array type');

# this seems to be the only way to make a hash - ref at the moment
my %丛2 = ("one", 1); my $丛2 = %丛2;
ok($丛2 ~~ Hash, 'it is a Hash type');

# WHAT() on subroutines

my $ò1 = sub {};
isa-ok($ò1, Sub, 'it is a Sub type');

# See L<S02/"Built-in Data Types">
# Quoting A06:
#                                   Code
#                        ____________|________________
#                       |                             |
#                    Routine                        Block
#       ________________|_______________
#      |     |       |       |    |     |
#     Sub Method Submethod Multi Rule Macro

# L<S06/Anonymous hashes vs blocks>
my $ò2 = {};
ok($ò2 ~~ Hash, 'it is a Hash type (bare block)');

# L<S06/"Placeholder variables">
my $ò2à = { $^aaa };
isa-ok($ò2à, Block, 'it is a Parametric type (bare block with placeholder parameters)');

{
    my $ò3 = -> {};
    isa-ok($ò3, Block, 'it is a Block type (pointy block)');
}

# WHAT() on different types of scalars

my $갢丧中 = 0;
isa-ok($갢丧中, Int, 'it is an Int type');

my $丧갮ì = '';
ok(+$丧갮ì ~~ Real, 'it is an Real type');

my $ел갨à中 = 0.5e0;
isa-ok($ел갨à中, Num, 'it is an Num type');
isa-ok(1 / 4, Rat, 'infix:</> of integers produces a Rat');

my $ò中с갢丧æ = "Hello World";
isa-ok($ò中с갢丧æ, Str, 'it is a Str type');

my $丛갨갨л = (0 == 0);
isa-ok($丛갨갨л, Bool, 'it is a Bool type');

my $𝐩à갢с = ("foo" => "bar");
isa-ok($𝐩à갢с, Pair, 'it is a Pair type');

{
    my $с갮лe̲ = rx/^hello\sworld$/;
    isa-ok($с갮лe̲, Regex, 'it is a Regex type');
}

# vim: expandtab shiftwidth=4
