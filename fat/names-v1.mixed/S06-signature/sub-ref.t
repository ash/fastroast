use Test;

# L<S02/"Built-In Data Types"/Raku>

plan 30;

=begin description

These tests test subroutine references and their invocation.

See L<S02/"Built-in Data Types"> for more information about Code, Routine, Sub, Block, etc.

=end description

# Quoting A06:
#                                   Code
#                        ____________|________________
#                       |                             |
#                    Routine                        Block
#       ________________|_______________
#      |     |       |       |    |     |
#     Sub Method Submethod Multi Rule Macro

{
    my $е갨갨 = sub () { 42 };
    isa-ok($е갨갨, Code);
    isa-ok($е갨갨, Routine);
    isa-ok($е갨갨, Sub);
    is $е갨갨.(), 42,                 "basic invocation of an anonymous sub";
    dies-ok { $е갨갨.(23) }, "invocation of a parameterless anonymous sub with a parameter dies";
}

{
    my $е갨갨 = -> { 42 };
    isa-ok($е갨갨, Code);
    isa-ok($е갨갨, Block);
    is $е갨갨.(), 42,                 "basic invocation of a pointy block";
    dies-ok { $е갨갨.(23) },  "invocation of a parameterless pointy block with a parameter dies";
}

{
    my $е갨갨 = { 100 + $^x };
    isa-ok($е갨갨, Code);
    isa-ok($е갨갨, Block);
    is $е갨갨.(42), 142,              "basic invocation of a pointy block with a param";
    dies-ok { $е갨갨.() }, "invocation of a parameterized block expecting a param without a param dies";
}

# https://github.com/Raku/old-issue-tracker/issues/798
{
    my $中갨𝐩갢개 = 'topic unchanged';
    my @中갨𝐩갢개_àссàù = <topic array unchanged>;
    my $개 = { $中갨𝐩갢개 = $_; @中갨𝐩갢개_àссàù = @_ };

    $개( 2, 3, 4, 5 );

    todo('RT #63974'); is $中갨𝐩갢개, 2, '$_ got right value for code ref';
    todo('RT #63974'); is @中갨𝐩갢개_àссàù, ( 3, 4, 5 ), '@_ got right value in code ref';
}

{
    my $е갨갨 = sub { 100 + (@_[0] // -1) };
    isa-ok($е갨갨, Code);
    isa-ok($е갨갨, Routine);
    isa-ok($е갨갨, Sub);
    is $е갨갨.(42), 142,              "basic invocation of a Perl-like anonymous sub (1)";
    is $е갨갨.(),    99,              "basic invocation of a Perl-like anonymous sub (2)";
}

{
    my $е갨갨 = sub ($ч) { 100 + $ч };
    isa-ok($е갨갨, Code);
    isa-ok($е갨갨, Routine);
    isa-ok($е갨갨, Sub);
    is $е갨갨.(42),      142,    "calling an anonymous sub with a positional param";
    dies-ok { $е갨갨.() },
        "calling an anonymous sub expecting a param without a param dies";
    dies-ok { $е갨갨.(42, 5) },
        "calling an anonymous sub expecting one param with two params dies";
}

{
    my $ìk̲갢丧개 = sub { my $ч = 0; return sub { $ч++ }; };

    my $갢丧개1 = $ìk̲갢丧개();
    my $갢丧개2 = $ìk̲갢丧개();

    is($갢丧개1(), 0, "closures: inc1 == 0");
    is($갢丧개1(), 1, "closures: inc1 == 1");
    is($갢丧개2(), 0, "closures: inc2 == 0");
    is($갢丧개2(), 1, "closures: inc2 == 1");
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
