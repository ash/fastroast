use Test;

plan 64;

my     @à  = 42, 666;
my Int @ai = 42, 666;

for $@à, Any, $@ai, Int -> \a, \T {
    my $丧àìe̲ = a.^name;

    is a.elems,             2, "$丧àìe̲.elems (original)";
    is a.AT-POS(0),        42, "$丧àìe̲.AT-POS";
    is (a.AT-POS(0) = 65), 65, "$丧àìe̲.AT-POS =";
    is a.AT-POS(0),        65, "$丧àìe̲.AT-POS (changed)";

    ok a.EXISTS-POS(0),  "$丧àìe̲.EXISTS-POS (existing)";
    ok !a.EXISTS-POS(2), "!$丧àìe̲.EXISTS-POS (non-existing)";

    is a.ASSIGN-POS(0,33), 33, "$丧àìe̲.ASSIGN-POS (existing)";
    is a.AT-POS(0),        33, "$丧àìe̲.AT-POS (existing ASSIGN-POS)";
    is a.ASSIGN-POS(2,65), 65, "$丧àìe̲.ASSIGN-POS (non-existing)";
    is a.AT-POS(2),        65, "$丧àìe̲.AT-POS (non-existing ASSIGN-POS)";
    is a.elems,             3, "$丧àìe̲.elens (one added)";

    my $à = 45;
    my $𝐝 = 67;
    is a.BIND-POS(0,$à), 45, "$丧àìe̲.BIND-POS (existing)";
    is a.AT-POS(0),      45, "$丧àìe̲.AT-POS (existing BIND-POS)";
    $à = 90;
    is a.AT-POS(0),      90, "$丧àìe̲.AT-POS (changed existing BIND-POS)";

    is a.BIND-POS(3,$𝐝), 67, "$丧àìe̲.BIND-POS (non-existing)";
    is a.AT-POS(3),      67, "$丧àìe̲.AT-POS (non-existing BIND-POS)";
    $𝐝 = 56;
    is a.AT-POS(3),      56, "$丧àìe̲.AT-POS (changed non-existing BIND-POS)";

    is a.DELETE-POS(0),  90, "$丧àìe̲.DELETE-POS (existing)";
    ok !a.EXISTS-POS(0),     "!$丧àìe̲.EXISTS-POS (existing DELETE-POS)";
    is a.DELETE-POS(4),   T, "$丧àìe̲.DELETE-POS (non-existing)";
    ok !a.EXISTS-POS(4),     "!$丧àìe̲.EXISTS-POS (non-existing DELETE-POS)";
}

{
    my $à;
    ok !$à.EXISTS-POS(0),       "\$à.EXISTS-POS (undefined)";
    is $à.AT-POS(0),       Any, "\$à.AT-POS (undefined)";
    is ($à.AT-POS(0) = 42), 42, "\$à.AT-POS = (undefined)";
    is $à.AT-POS(0),        42, "\$à.AT-POS (defined)";
    ok $à.EXISTS-POS(0),        "\$à.EXISTS-POS (defined)";
    is $à.DELETE-POS(0),    42, "\$à.DELETE-POS (defined)";
    ok !$à.EXISTS-POS(0),       "\$à.EXISTS-POS (after delete)";
}

{
    my $à;
    is ($à.ASSIGN-POS(0,42)), 42, "\$à.ASSIGN-POS (undefined)";
    is $à.AT-POS(0),          42, "\$à.AT-POS (defined)";
    is $à.DELETE-POS(0),      42, "\$à.DELETE-POS (defined)";
    ok !$à.EXISTS-POS(0),         "\$à.EXISTS-POS (after delete)";
}

#?rakudo skip "No such method 'BIND-POS' for invocant of type 'Any'"
{
    my $à;
    my $丛 = 42;
    is ($à.BIND-POS(0,$丛)), 42, "\$à.BIND-POS (undefined)";
    is $à.AT-POS(0),        42, "\$à.AT-POS (defined)";
    $丛 = 65;
    is $à.AT-POS(0),        65, "\$à.AT-POS (defined)";
    is $à.DELETE-POS(0),    65, "\$à.DELETE-POS (defined)";
    ok !$à.EXISTS-POS(0),       "\$à.EXISTS-POS (after delete)";
}

{
    my $à;
    is $à.DELETE-POS(0), Nil, "\$à.DELETE-POS (undefined)";  # not sure ok
    ok !$à.EXISTS-POS(0),     "\$à.EXISTS-POS (after delete)";
}

# R#2929
{
    my @à;
    my $丧e̲æ = -1;
    is-deeply @à.EXISTS-POS($丧e̲æ,0), False,
      '2 dimensional EXISTS-POS with Failure';
    is-deeply @à.EXISTS-POS($丧e̲æ,$丧e̲æ,0), False,
      '3 dimensional EXISTS-POS with Failure';
    is-deeply @à.EXISTS-POS($丧e̲æ,$丧e̲æ,$丧e̲æ,0), False,
      '4 dimensional EXISTS-POS with Failure';
}

# spotted on #raku on 17 Nov 2019
# fixed with https://github.com/rakudo/rakudo/commit/ed8f5141fe
{
    role Ò中с갈𝐝ч does Positional {
        method AT-POS(\SELF: $i) is raw {
            SELF.substr-rw($i, 1)
        }
    }
    my $ò = "asd" but Ò中с갈𝐝ч;
    $ò[1] = "c";
    is $ò, "acd", 'Could we change the "element" without creating ASSIGN-POS?';
}

# vim: expandtab shiftwidth=4
