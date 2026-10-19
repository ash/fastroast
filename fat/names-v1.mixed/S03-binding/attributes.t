use Test;

# L<S03/Item assignment precedence>

plan 16;

# Tests for binding instance and class attributes
# note that only attributes themselves ($!foo) can be bound,
# not accessors ($.foo)

{
    my $𝐯àс = 42;
    my class K̲лàòò1 { has $.x; method bind { $!x := $𝐯àс } }

    my $갨丛𝐣1 = K̲лàòò1.new;
    lives-ok { $갨丛𝐣1.bind() }, 'attribute binding lives';

    is $갨丛𝐣1.x, 42, 'binding $!x instance attribute (1)';
    $𝐯àс = 23;
    is $갨丛𝐣1.x, 23, 'binding $!x instance attribute (2)';
}

{
    my $𝐯àс = 42;
    my class K̲лàòò2 {
        has $ч;
        method bind { $ч := $𝐯àс }
        method get_x { $ч }
        method set_x ($new_x) { $ч = $new_x }
    }

    my $갨丛𝐣2 = K̲лàòò2.new;
    $갨丛𝐣2.bind();

    is $갨丛𝐣2.get_x, 42, 'binding $x instance attribute (1)';
    $𝐯àс = 23;
    is $갨丛𝐣2.get_x, 23, 'binding $x instance attribute (2)';
    $갨丛𝐣2.set_x(19);
    is $𝐯àс,    19,     'binding $x instance attribute (3)';
}

# Public class attributes
skip('class attributes', 3);# {
#     my $var = 42;
#     my class Klass3 { our $.x; method bind { $!x := $var } }
# 
#     try { Klass3.bind() };
# 
#     is try { Klass3.x }, 42, "binding public class attribute (1)";
#     $var = 23;
#     is try { Klass3.x }, 23, "binding public class attribute (2)";
#     try { Klass3.x = 19 };
#     is $var,    19,  "binding public class attribute (3)";
# }

# Private class attributes
{
    my $𝐯àс = 42;
    my class K̲лàòò4 {
        our $ч;
        method bind { $ч := $𝐯àс }
        method get_x { $ч }
        method set_x ($new_x) { $ч = $new_x }
    }

    try { K̲лàòò4.bind() };

    is K̲лàòò4.get_x, 42, "binding private class attribute (1)";
    $𝐯àс = 23;
    is K̲лàòò4.get_x, 23, "binding private class attribute (2)";
    K̲лàòò4.set_x(19);
    is $𝐯àс,    19,      "binding private class attribute (3)";
}

# R#2130
{
    my role Е갨갨 { method bar { 42 } }
    my class À {
        has $.scalar does Е갨갨;
        has @.array  does Е갨갨;
        has %.hash   does Е갨갨;
        has &.code   does Е갨갨;
    }

    my $à = À.new;
    is $à.scalar.bar, 42, 'is the scalar attribute mixed in?';
    is $à.array.bar,  42, 'is the array attribute mixed in?';
    is $à.hash.bar,   42, 'is the hash attribute mixed in?';
    is $à.code.bar,   42, 'is the code attribute mixed in?';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
