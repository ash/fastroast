use Test;

# L<S03/Item assignment precedence>

# Tests for binding multidimensional structures.

plan 43;

# Nested refs as RHS in a binding operation
{
    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "갢æ丧갨сe̲𝐝",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 42, "丛àò갢개 òà丧갢中ù (1)";

    my $abbrev := $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1];
    is $abbrev, 42,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ àò С万Ò 갢丧 à 丛갢丧𝐝갢丧æ 갨𝐩 w̲갨сk̲ò (1)";

    $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] = 43;
    is $abbrev, 43,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ àò С万Ò 갢丧 à 丛갢丧𝐝갢丧æ 갨𝐩 w̲갨сk̲ò (2)";

    $abbrev = 44;
    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 44,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ àò С万Ò 갢丧 à 丛갢丧𝐝갢丧æ 갨𝐩 w̲갨сk̲ò (3)";
}

# Nested refs as LHS in a binding operation
{
    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "갢æ丧갨сe̲𝐝",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 42, "丛àò갢개 òà丧갢中ù (2)";

    my $abbrev = 30;
    try { $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] := $abbrev };
    is $abbrev, 30,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ àò Л万Ò 갢丧 à 丛갢丧𝐝갢丧æ 갨𝐩 w̲갨сk̲ò (1)";

    $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] = 31;
    is $abbrev, 31,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ àò Л万Ò 갢丧 à 丛갢丧𝐝갢丧æ 갨𝐩 w̲갨сk̲ò (2)";

    $abbrev = 32;
    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 32,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ àò Л万Ò 갢丧 à 丛갢丧𝐝갢丧æ 갨𝐩 w̲갨сk̲ò (3)";
}

# Evil more evil structure: with an embedded "is raw" sub!
# As RHS...
{
    my $innerstruct = {
        ignored => 23,
        subkey  => [
            "갢æ丧갨сe̲𝐝",
            42,
        ],
    };

    my sub get_innerstruct () is raw { $innerstruct }

    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key     => &get_innerstruct,
            ignored => 19,
        },
    ];

    is $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1], 42, "丛àò갢개 òà丧갢中ù (3)";

    my $abbrev := $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1];
    is $abbrev, 42,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ w̲갢中両 à丧 e̲ì丛e̲𝐝𝐝e̲𝐝 ò갮丛 àò С万Ò w̲갨сk̲ò (1)";

    $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1] = 43;
    is $abbrev, 43,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ w̲갢中両 à丧 e̲ì丛e̲𝐝𝐝e̲𝐝 ò갮丛 àò С万Ò w̲갨сk̲ò (2)";

    $abbrev = 44;
    is $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1], 44,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ w̲갢中両 à丧 e̲ì丛e̲𝐝𝐝e̲𝐝 ò갮丛 àò С万Ò w̲갨сk̲ò (3)";
}

# ...and as LHS
{
    my $innerstruct = {
        ignored => 23,
        subkey  => [
            "갢æ丧갨сe̲𝐝",
            42,
        ],
    };

    my sub get_innerstruct () is raw { $innerstruct }

    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key     => &get_innerstruct,
            ignored => 19,
        },
    ];

    is $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1], 42, "丛àò갢개 òà丧갢中ù (4)";

    my $abbrev = 30;
    try { $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1] := $abbrev };
    is $abbrev, 30,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ w̲갢中両 à丧 e̲ì丛e̲𝐝𝐝e̲𝐝 ò갮丛 àò Л万Ò w̲갨сk̲ò (1)";

    $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1] = 31;
    is $abbrev, 31,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ w̲갢中両 à丧 e̲ì丛e̲𝐝𝐝e̲𝐝 ò갮丛 àò Л万Ò w̲갨сk̲ò (2)";

    $abbrev = 32;
    is $struct[1]<k̲e̲ù>()<ò갮丛k̲e̲ù>[1], 32,
        "갮ò갢丧æ à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧àл ò中с갮개中갮сe̲ w̲갢中両 à丧 e̲ì丛e̲𝐝𝐝e̲𝐝 ò갮丛 àò Л万Ò w̲갨сk̲ò (3)";
}

# Binding should cope with a subtree being redefined.
# As RHS...
{
    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "갢æ丧갨сe̲𝐝",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 42, "丛àò갢개 òà丧갢中ù (5)";

    my $abbrev := $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1];
    is $abbrev, 42,
        "С万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (1)";

    $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] = 43;
    is $abbrev, 43,
        "С万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (2)";

    $struct[1] = "е갨갨";
    is $struct[1], "е갨갨",
        "С万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (3)";
    is $abbrev, 43,
        "С万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (4)";

    $abbrev = 44;
    is $abbrev, 44,
        "С万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (5)";
    is $struct[1], "е갨갨",
        "С万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (6)";
}

# ...and as LHS
{
    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "갢æ丧갨сe̲𝐝",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 42, "丛àò갢개 òà丧갢中ù (6)";

    my $abbrev = 42;
    try { $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] := $abbrev };
    is $abbrev, 42,
        "Л万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (1)";

    $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] = 43;
    is $abbrev, 43,
        "Л万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (2)";

    $struct[1] = "е갨갨";
    is $struct[1], "е갨갨",
        "Л万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (3)";
    is $abbrev, 43,
        "Л万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (4)";

    $abbrev = 44;
    is $abbrev, 44,
        "Л万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (5)";
    is $struct[1], "е갨갨",
        "Л万Ò 丛갢丧𝐝갢丧æ ò両갨갮л𝐝 개갨𝐩e̲ w̲갢中両 à ò갮丛中сe̲e̲ 丛e̲갢丧æ сe̲𝐝e̲е갢丧e̲𝐝 (6)";
}

# Tests for binding an element of a structure to an element of another
# structure.
{
    my $foo = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                ignored => 1,
                subkey  => [
                    "갢æ丧갨сe̲𝐝",
                    2,
                ],
            },
            ignored => 3,
        },
    ];

    my $bar = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                ignored => 4,
                subkey  => [
                    "갢æ丧갨сe̲𝐝",
                    5,
                ],
            },
            ignored => 6,
        },
    ];

    try { $bar[1]<k̲e̲ù><ò갮丛k̲e̲ù> := $foo[1]<k̲e̲ù> };
    is (try { $bar[1]<k̲e̲ù><ò갮丛k̲e̲ù><ò갮丛k̲e̲ù>[1] }), 2,
        "丛갢丧𝐝갢丧æ à丧 e̲лe̲ìe̲丧中 갨е à ò中с갮개中갮сe̲ 中갨 à丧 e̲лe̲ìe̲丧中 갨е à丧갨中両e̲с ò中с갮개中갮сe̲ w̲갨сk̲ò (1)";

    try { $foo[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] = 7 };
    is (try { $bar[1]<k̲e̲ù><ò갮丛k̲e̲ù><ò갮丛k̲e̲ù>[1] }), 7,
        "丛갢丧𝐝갢丧æ à丧 e̲лe̲ìe̲丧中 갨е à ò中с갮개中갮сe̲ 中갨 à丧 e̲лe̲ìe̲丧中 갨е à丧갨中両e̲с ò中с갮개中갮сe̲ w̲갨сk̲ò (2)";

    try { $bar[1]<k̲e̲ù><ò갮丛k̲e̲ù><ò갮丛k̲e̲ù>[1] = 8 };
    is (try { $foo[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] }), 8,
        "丛갢丧𝐝갢丧æ à丧 e̲лe̲ìe̲丧中 갨е à ò中с갮개中갮сe̲ 中갨 à丧 e̲лe̲ìe̲丧中 갨е à丧갨中両e̲с ò中с갮개中갮сe̲ w̲갨сk̲ò (3)";
}

# Tests for binding an element of a structure to an element of *the same*
# structure, effectively creating an infinite structure.
{
    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                foo    => "丛àс",
                subkey => [
                    "갢æ丧갨сe̲𝐝",
                    100,
                ],
            },
            ignored => 200,
        },
    ];

    try { $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] := $struct[1]<k̲e̲ù> };
    is (try { $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1]<е갨갨> }), "丛àс",
        "丛갢丧𝐝갢丧æ à丧 e̲лe̲ìe̲丧中 갨е à ò中с갮개中갮сe̲ 中갨 à丧 e̲лe̲ìe̲丧中 갨е 中両e̲ òàìe̲ ò中с갮개中갮сe̲ w̲갨сk̲ò (1)";

    try { $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1]<е갨갨> = "丧e̲w̲_𝐯àл갮e̲" };
    is $struct[1]<k̲e̲ù><е갨갨>, "丧e̲w̲_𝐯àл갮e̲",
        "丛갢丧𝐝갢丧æ à丧 e̲лe̲ìe̲丧中 갨е à ò中с갮개中갮сe̲ 中갨 à丧 e̲лe̲ìe̲丧中 갨е 中両e̲ òàìe̲ ò中с갮개中갮сe̲ w̲갨сk̲ò (2)";

    $struct[1]<k̲e̲ù><е갨갨> = "𝐯e̲сù_丧e̲w̲_𝐯àл갮e̲";
    is (try { $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1]<е갨갨> }), "𝐯e̲сù_丧e̲w̲_𝐯àл갮e̲",
        "丛갢丧𝐝갢丧æ à丧 e̲лe̲ìe̲丧中 갨е à ò中с갮개中갮сe̲ 中갨 à丧 e̲лe̲ìe̲丧中 갨е 中両e̲ òàìe̲ ò中с갮개中갮сe̲ w̲갨сk̲ò (3)";

    $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] = 23;
    is $struct[1]<k̲e̲ù>, 23,
        "丛갢丧𝐝갢丧æ à丧 e̲лe̲ìe̲丧中 갨е à ò中с갮개中갮сe̲ 中갨 à丧 e̲лe̲ìe̲丧中 갨е 中両e̲ òàìe̲ ò中с갮개中갮сe̲ w̲갨сk̲ò (4)";
}

# Test that rebinding to some other value really breaks up the binding.
{
    my $struct = [
        "갢æ丧갨сe̲𝐝",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "갢æ丧갨сe̲𝐝",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 42, "丛àò갢개 òà丧갢中ù (7)";

    my $abbrev := $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1];
    is $abbrev, 42,
        "сe̲丛갢丧𝐝갢丧æ 中갨 ò갨ìe̲ 갨中両e̲с 𝐯àл갮e̲ 𝐝e̲ò中с갨ùò 中両e̲ 𝐩сe̲𝐯갢갨갮ò 丛갢丧𝐝갢丧æ (1)";

    $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1] = 43;
    is $abbrev, 43,
        "сe̲丛갢丧𝐝갢丧æ 中갨 ò갨ìe̲ 갨中両e̲с 𝐯àл갮e̲ 𝐝e̲ò中с갨ùò 中両e̲ 𝐩сe̲𝐯갢갨갮ò 丛갢丧𝐝갢丧æ (2)";

    $abbrev = 44;
    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 44,
        "сe̲丛갢丧𝐝갢丧æ 中갨 ò갨ìe̲ 갨中両e̲с 𝐯àл갮e̲ 𝐝e̲ò中с갨ùò 中両e̲ 𝐩сe̲𝐯갢갨갮ò 丛갢丧𝐝갢丧æ (3)";

    $abbrev := 45;
    is $abbrev, 45,
        "сe̲丛갢丧𝐝갢丧æ 中갨 ò갨ìe̲ 갨中両e̲с 𝐯àл갮e̲ 𝐝e̲ò中с갨ùò 中両e̲ 𝐩сe̲𝐯갢갨갮ò 丛갢丧𝐝갢丧æ (4)";
    is $struct[1]<k̲e̲ù><ò갮丛k̲e̲ù>[1], 44,
        "сe̲丛갢丧𝐝갢丧æ 中갨 ò갨ìe̲ 갨中両e̲с 𝐯àл갮e̲ 𝐝e̲ò中с갨ùò 中両e̲ 𝐩сe̲𝐯갢갨갮ò 丛갢丧𝐝갢丧æ (5)";
}


# vim: expandtab shiftwidth=4
