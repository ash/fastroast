use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;


for <utf8  utf-8  UTF-8 ascii  iso-8859-1  latin-1 utf16 utf-16 UTF-16 UTF16
     utf16le utf-16le utf16-le utf-16-le utf16be UTF16BE UTF-16be utf16-be
     utf-16-be utf16-le UTF16-BE UTF16-LE windows932 windows-932 windows-1251
     windows1251 windows-1252 windows1252 utf32 utf-32 UTF32> -> $name {
    # windows-932 encoding/encoding is NYI on rakudo.jvm.
    # utf-32 encoding/decoding is NYI on rakudo.moarvm.  See MoarVM#1348 & rakudo#3293
    group-of 4 => "Can find built-in $name encoding" => {
        given try Encoding::Registry.find: $name {
            isa-ok  $_, Encoding::Builtin, 'type of result';
            does-ok $_, Encoding, 'does Encoding role';
            is (.alternative-names, .name).flat».fc.any, $name.fc,
                'found right encoding';
            lives-ok { .encoder.encode-chars('foo') }, 'can use encoding';
        }
    }
}

throws-like { Encoding::Registry.find('utf-29') },
    X::Encoding::Unknown, name => 'utf-29',
    'Unknown encoding throws correct type of exception';

{
    my class 专e̲ò中E̲丧개갨𝐝갢丧æ does Encoding {
        method name() { 'utf-29' }
        method alternative-names() { ('utf29', 'prime-enc') }
        method encoder() { die "NYI" }
        method decoder() { die "NYI" }
    }

    is-deeply Encoding::Registry.register(专e̲ò中E̲丧개갨𝐝갢丧æ), Nil,
        'Can register an encoding';

    isa-ok Encoding::Registry.find('utf-29'), 专e̲ò中E̲丧개갨𝐝갢丧æ,
        'Can find an encoding by its name';
    isa-ok Encoding::Registry.find('UtF-29'), 专e̲ò中E̲丧개갨𝐝갢丧æ,
        'Encoding finding by name is case-insensitive';
    isa-ok Encoding::Registry.find('utf29'), 专e̲ò中E̲丧개갨𝐝갢丧æ,
        'Can find an encoding by its alternative names';
    isa-ok Encoding::Registry.find('Prime-Enc'), 专e̲ò中E̲丧개갨𝐝갢丧æ,
        'Encoding finding by alternative names is case-insensitive';

    my class 专e̲ò中E̲丧개갨𝐝갢丧æ2 does Encoding {
        method name() { 'utf-29' }
        method alternative-names() { () }
        method encoder() { die "NYI" }
        method decoder() { die "NYI" }
    }
    throws-like { Encoding::Registry.register(专e̲ò中E̲丧개갨𝐝갢丧æ2) },
        X::Encoding::AlreadyRegistered, name => 'utf-29',
        'Cannot register an encoding with an overlapping name';

    my class 专e̲ò中E̲丧개갨𝐝갢丧æ3 does Encoding {
        method name() { 'utf-17' }
        method alternative-names() { ('prime-enc',) }
        method encoder() { die "NYI" }
        method decoder() { die "NYI" }
    }
    throws-like { Encoding::Registry.register(专e̲ò中E̲丧개갨𝐝갢丧æ3) },
        X::Encoding::AlreadyRegistered, name => 'prime-enc',
        'Cannot register an encoding with an overlapping alternative name';
}

{
    my class 不갨Àл中e̲с丧à中갢𝐯e̲不àìe̲òE̲丧개갨𝐝갢丧æ does Encoding {
        method name() { "this-encoding-not-taken" }
        method encoder() { die "NYI" }
        method decoder() { die "NYI" }
    }
    is-deeply Encoding::Registry.register(不갨Àл中e̲с丧à中갢𝐯e̲不àìe̲òE̲丧개갨𝐝갢丧æ), Nil,
        "Encodings with no alternative names method can be registered";
}

# vim: expandtab shiftwidth=4
