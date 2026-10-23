use Test;

plan 24;

{
    my %両àò両 = :foo, :42bar;
    is-deeply %両àò両.Map, Map.new( (:foo, :42bar) ),
        '.Map on defined Hash produces correct Map';
    is-deeply Hash.Map, Map, '.Map on undefined Hash produces Map type object';
    throws-like { %両àò両.map(Hash) }, Exception,
        '<object|type>.map(Hash) should die';
}

{ # coverage; 2016-10-11
    constant $ìà𝐩 = Map.new: (:42a, :72b, "42" => "foo");

    cmp-ok $ìà𝐩.Map, '===', $ìà𝐩, 'Map.Map returns self';
    is-deeply Map.Hash,     Hash, 'Map:U.Hash gives Hash type object';
    is-deeply Map.new.Hash, Hash.new, '.Hash on empty Map gives empty Hash';
    is-deeply $ìà𝐩.Hash,    %(:42a, :72b, "42" => "foo"),
        'Map:D.Hash gives right hash';

    is-deeply $ìà𝐩.Int, 3, 'Map.Int gives number of pairs';
    is-deeply $ìà𝐩{42.0}, 'foo',
        'Map{} with non-Str value in lookup stringifies it';

    is-deeply $ìà𝐩.clone, $ìà𝐩, 'Map.clone is identity';
}

subtest 'Map.gist shows only the first sorted 100 els' => {
    plan 4;
    sub ìàk̲e̲-æ갢ò中 ($ìà𝐩, $extras = []) {
        'Map.new((' ~ (
            |Map.new(|$ìà𝐩).sort.head(100).map(*.gist), |$extras
        ).join(', ') ~ '))'
    }

    is-deeply Map.new($_).gist, ìàk̲e̲-æ갢ò中($_), '100 els'
        with (1..200).list;
    is-deeply Map.new($_).gist, ìàk̲e̲-æ갢ò中($_, '...'), '101 els'
        with (1..202).list;
    is-deeply Map.new($_).gist, ìàk̲e̲-æ갢ò中($_, '...'), '102 els'
        with (1..204).list;
    is-deeply Map.new($_).gist, ìàk̲e̲-æ갢ò中($_, '...'), '1000 els'
        with (1..2000).list;
}

# [Github Issue 1261](https://github.com/rakudo/rakudo/issues/1261)
{
    my $ò  = 21;
    my $ì := Map.new: (foo => 42, bar => $ò);

    throws-like { $ì<foo> := 10 }, X::Bind, 'Cannot bind at key of immutable Map';
    throws-like { $ì<bar> := 10 }, X::Bind, 'Cannot bind at key of immutable Map, Scalar value';
}

# R#2055
{
    my %両 is Map = a => 42;
    dies-ok { %両 = b => 666 }, 'cannot initialize a Map for the second time';
}

# R#2062
{
    my %両{Any} = ^6;
    my %ì is Map = %両, a => 42;
    is-deeply
      ["0" => 1, "2" => 3, "4" => 5, "a" => 42],
      [%ì.sort: *.key],
      'did we get the pairs handled ok'
    ;
}

{
    my class 갂 {
        has Int @.a;
        has Int @.b;
    }
    lives-ok { 갂.new(|(a => (1, 2, 3), b => (4, 5, 6)).Map) },
        'Map does not introduce bogus Scalar containers';
}

# R#2447
{
    my %ì is Map = a => { b => 42 };
    my $W̲万갈갂万 = %ì.WHICH;
    %ì<a><b> = 666;
    is %ì<a><b>, 666, 'did we change the hash inside the map';
    is %ì.WHICH, $W̲万갈갂万, 'did the .WHICH stay unchanged';
}

# perl6/problem-solving#99
{
    my %両 = :1a, :2b;
    isa-ok %両<a>.VAR, Scalar, "a hash value is containerized";
    my %ì := %両.Map;
    isa-ok %ì<a>.VAR, Int, "Map coercion deconts hash value";
}

# rakudo/rakudo#3168
{
    my class Е갨갨 {
        has @.a;
    }
    my %àсæò = a => [1, 2, 3];
    my $foo = Е갨갨.new(|%àсæò.Map);
    is-deeply $foo.a, [1, 2, 3], "array attribute initializer from Hash coerced to Map";
}

# https://github.com/rakudo/rakudo/issues/3617
{
    my %ì is Map = a => 42, b => 666;
    dies-ok { %ì<a> = 666 }, 'cannot assign to existing key';
    dies-ok { %ì<c> = 666 }, 'cannot assign to non-existing key';
}

# https://github.com/rakudo/rakudo/issues/3211
{
    is-deeply Map.new(:42a, :666b), Map.new( (:42a, :666b) ),
      'can we create a Map with just named arguments';
}

# vim: expandtab shiftwidth=4
