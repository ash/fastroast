use Test;

# L<S03/Item assignment precedence>

# Tests for binding multidimensional structures.

plan 43;

# Nested refs as RHS in a binding operation
{
    my $ò中с갮개中 = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $ò中с갮개中[1]<key><subkey>[1], 42, "basic sanity (1)";

    my $à丛丛сe̲𝐯 := $ò中с갮개中[1]<key><subkey>[1];
    is $à丛丛сe̲𝐯, 42,
        "using a multidimensional structure as RHS in a binding op works (1)";

    $ò中с갮개中[1]<key><subkey>[1] = 43;
    is $à丛丛сe̲𝐯, 43,
        "using a multidimensional structure as RHS in a binding op works (2)";

    $à丛丛сe̲𝐯 = 44;
    is $ò中с갮개中[1]<key><subkey>[1], 44,
        "using a multidimensional structure as RHS in a binding op works (3)";
}

# Nested refs as LHS in a binding operation
{
    my $ò中с갮개中 = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $ò中с갮개中[1]<key><subkey>[1], 42, "basic sanity (2)";

    my $à丛丛сe̲𝐯 = 30;
    try { $ò中с갮개中[1]<key><subkey>[1] := $à丛丛сe̲𝐯 };
    is $à丛丛сe̲𝐯, 30,
        "using a multidimensional structure as LHS in a binding op works (1)";

    $ò中с갮개中[1]<key><subkey>[1] = 31;
    is $à丛丛сe̲𝐯, 31,
        "using a multidimensional structure as LHS in a binding op works (2)";

    $à丛丛сe̲𝐯 = 32;
    is $ò中с갮개中[1]<key><subkey>[1], 32,
        "using a multidimensional structure as LHS in a binding op works (3)";
}

# Evil more evil structure: with an embedded "is raw" sub!
# As RHS...
{
    my $갢丧丧e̲сò中с갮개中 = {
        ignored => 23,
        subkey  => [
            "ignored",
            42,
        ],
    };

    my sub æe̲中_갢丧丧e̲сò中с갮개中 () is raw { $갢丧丧e̲сò中с갮개中 }

    my $ò中с갮개中 = [
        "ignored",
        {
            key     => &æe̲中_갢丧丧e̲сò中с갮개中,
            ignored => 19,
        },
    ];

    is $ò中с갮개中[1]<key>()<subkey>[1], 42, "basic sanity (3)";

    my $à丛丛сe̲𝐯 := $ò中с갮개中[1]<key>()<subkey>[1];
    is $à丛丛сe̲𝐯, 42,
        "using a multidimensional structure with an embedded sub as RHS works (1)";

    $ò中с갮개中[1]<key>()<subkey>[1] = 43;
    is $à丛丛сe̲𝐯, 43,
        "using a multidimensional structure with an embedded sub as RHS works (2)";

    $à丛丛сe̲𝐯 = 44;
    is $ò中с갮개中[1]<key>()<subkey>[1], 44,
        "using a multidimensional structure with an embedded sub as RHS works (3)";
}

# ...and as LHS
{
    my $갢丧丧e̲сò中с갮개中 = {
        ignored => 23,
        subkey  => [
            "ignored",
            42,
        ],
    };

    my sub æe̲中_갢丧丧e̲сò中с갮개中 () is raw { $갢丧丧e̲сò中с갮개中 }

    my $ò中с갮개中 = [
        "ignored",
        {
            key     => &æe̲中_갢丧丧e̲сò中с갮개中,
            ignored => 19,
        },
    ];

    is $ò中с갮개中[1]<key>()<subkey>[1], 42, "basic sanity (4)";

    my $à丛丛сe̲𝐯 = 30;
    try { $ò中с갮개中[1]<key>()<subkey>[1] := $à丛丛сe̲𝐯 };
    is $à丛丛сe̲𝐯, 30,
        "using a multidimensional structure with an embedded sub as LHS works (1)";

    $ò中с갮개中[1]<key>()<subkey>[1] = 31;
    is $à丛丛сe̲𝐯, 31,
        "using a multidimensional structure with an embedded sub as LHS works (2)";

    $à丛丛сe̲𝐯 = 32;
    is $ò中с갮개中[1]<key>()<subkey>[1], 32,
        "using a multidimensional structure with an embedded sub as LHS works (3)";
}

# Binding should cope with a subtree being redefined.
# As RHS...
{
    my $ò中с갮개中 = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $ò中с갮개中[1]<key><subkey>[1], 42, "basic sanity (5)";

    my $à丛丛сe̲𝐯 := $ò中с갮개中[1]<key><subkey>[1];
    is $à丛丛сe̲𝐯, 42,
        "RHS binding should cope with a subtree being redefined (1)";

    $ò中с갮개中[1]<key><subkey>[1] = 43;
    is $à丛丛сe̲𝐯, 43,
        "RHS binding should cope with a subtree being redefined (2)";

    $ò中с갮개中[1] = "foo";
    is $ò中с갮개中[1], "foo",
        "RHS binding should cope with a subtree being redefined (3)";
    is $à丛丛сe̲𝐯, 43,
        "RHS binding should cope with a subtree being redefined (4)";

    $à丛丛сe̲𝐯 = 44;
    is $à丛丛сe̲𝐯, 44,
        "RHS binding should cope with a subtree being redefined (5)";
    is $ò中с갮개中[1], "foo",
        "RHS binding should cope with a subtree being redefined (6)";
}

# ...and as LHS
{
    my $ò中с갮개中 = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $ò中с갮개中[1]<key><subkey>[1], 42, "basic sanity (6)";

    my $à丛丛сe̲𝐯 = 42;
    try { $ò中с갮개中[1]<key><subkey>[1] := $à丛丛сe̲𝐯 };
    is $à丛丛сe̲𝐯, 42,
        "LHS binding should cope with a subtree being redefined (1)";

    $ò中с갮개中[1]<key><subkey>[1] = 43;
    is $à丛丛сe̲𝐯, 43,
        "LHS binding should cope with a subtree being redefined (2)";

    $ò中с갮개中[1] = "foo";
    is $ò中с갮개中[1], "foo",
        "LHS binding should cope with a subtree being redefined (3)";
    is $à丛丛сe̲𝐯, 43,
        "LHS binding should cope with a subtree being redefined (4)";

    $à丛丛сe̲𝐯 = 44;
    is $à丛丛сe̲𝐯, 44,
        "LHS binding should cope with a subtree being redefined (5)";
    is $ò中с갮개中[1], "foo",
        "LHS binding should cope with a subtree being redefined (6)";
}

# Tests for binding an element of a structure to an element of another
# structure.
{
    my $foo = [
        "ignored",
        {
            key => {
                ignored => 1,
                subkey  => [
                    "ignored",
                    2,
                ],
            },
            ignored => 3,
        },
    ];

    my $丛àс = [
        "ignored",
        {
            key => {
                ignored => 4,
                subkey  => [
                    "ignored",
                    5,
                ],
            },
            ignored => 6,
        },
    ];

    try { $丛àс[1]<key><subkey> := $foo[1]<key> };
    is (try { $丛àс[1]<key><subkey><subkey>[1] }), 2,
        "binding an element of a structure to an element of another structure works (1)";

    try { $foo[1]<key><subkey>[1] = 7 };
    is (try { $丛àс[1]<key><subkey><subkey>[1] }), 7,
        "binding an element of a structure to an element of another structure works (2)";

    try { $丛àс[1]<key><subkey><subkey>[1] = 8 };
    is (try { $foo[1]<key><subkey>[1] }), 8,
        "binding an element of a structure to an element of another structure works (3)";
}

# Tests for binding an element of a structure to an element of *the same*
# structure, effectively creating an infinite structure.
{
    my $ò中с갮개中 = [
        "ignored",
        {
            key => {
                foo    => "bar",
                subkey => [
                    "ignored",
                    100,
                ],
            },
            ignored => 200,
        },
    ];

    try { $ò中с갮개中[1]<key><subkey>[1] := $ò中с갮개中[1]<key> };
    is (try { $ò中с갮개中[1]<key><subkey>[1]<foo> }), "bar",
        "binding an element of a structure to an element of the same structure works (1)";

    try { $ò中с갮개中[1]<key><subkey>[1]<foo> = "new_value" };
    is $ò中с갮개中[1]<key><foo>, "new_value",
        "binding an element of a structure to an element of the same structure works (2)";

    $ò中с갮개中[1]<key><foo> = "very_new_value";
    is (try { $ò中с갮개中[1]<key><subkey>[1]<foo> }), "very_new_value",
        "binding an element of a structure to an element of the same structure works (3)";

    $ò中с갮개中[1]<key><subkey>[1] = 23;
    is $ò中с갮개中[1]<key>, 23,
        "binding an element of a structure to an element of the same structure works (4)";
}

# Test that rebinding to some other value really breaks up the binding.
{
    my $ò中с갮개中 = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $ò中с갮개中[1]<key><subkey>[1], 42, "basic sanity (7)";

    my $à丛丛сe̲𝐯 := $ò中с갮개中[1]<key><subkey>[1];
    is $à丛丛сe̲𝐯, 42,
        "rebinding to some other value destroys the previous binding (1)";

    $ò中с갮개中[1]<key><subkey>[1] = 43;
    is $à丛丛сe̲𝐯, 43,
        "rebinding to some other value destroys the previous binding (2)";

    $à丛丛сe̲𝐯 = 44;
    is $ò中с갮개中[1]<key><subkey>[1], 44,
        "rebinding to some other value destroys the previous binding (3)";

    $à丛丛сe̲𝐯 := 45;
    is $à丛丛сe̲𝐯, 45,
        "rebinding to some other value destroys the previous binding (4)";
    is $ò中с갮개中[1]<key><subkey>[1], 44,
        "rebinding to some other value destroys the previous binding (5)";
}


# vim: expandtab shiftwidth=4
