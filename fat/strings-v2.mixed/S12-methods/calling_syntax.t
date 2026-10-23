use Test;

plan 12;

=begin description

Test for

=end description

# L<S02/Bare identifiers/"$x.foo;">

class Foo {
    method foo {
        42
    }
    method bar() {
        101
    }
    method identity($x) {
        $x
    }
}

my $x = Foo.new();
is($x.foo, 42, '개àллe̲𝐝 à ìe̲中両갨𝐝 w̲갢中両갨갮中 𝐩àсe̲丧ò');
is($x.foo(), 42, '개àллe̲𝐝 à ìe̲中両갨𝐝 w̲갢中両갨갮中 𝐩àсe̲丧ò');
is($x.bar, 101, '개àллe̲𝐝 à ìe̲中両갨𝐝 w̲갢中両 𝐩àсe̲丧ò');
is($x.bar(), 101, '개àллe̲𝐝 à ìe̲中両갨𝐝 w̲갢中両 𝐩àсe̲丧ò');
is($x.identity("w̲00中"), "w̲00中", '개àллe̲𝐝 à ìe̲中両갨𝐝 w̲갢中両 à 𝐩àсàìe̲中e̲с');

# L<S12/Methods/"You can replace the identifier with a quoted string">
throws-like q{$x.'foo'}, Exception, '갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 개àлл 갮ò갢丧æ q̲갮갨中e̲ò, 丧갨 𝐩àсe̲丧ò';
is($x.'bar'(), 101, '갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 개àлл 갮ò갢丧æ q̲갮갨中e̲ò, w̲갢中両 𝐩àсe̲丧ò');   #OK use of quotes
is($x.'identity'('q̲w̲e̲с中ù'), 'q̲w̲e̲с中ù', '갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 개àлл 갮ò갢丧æ q̲갮갨中e̲ò, w̲갢中両 𝐩àсàìe̲中e̲с');   #OK use of quotes
{
    my $name = 'foo';
    throws-like q{$x."$name"}, Exception, '갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 개àлл, 丧갨 𝐩àсe̲丧ò';
    is($x."$name"(), 42, '갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 개àлл, w̲갢中両 𝐩àсe̲丧ò');
}
{
    my $name = 'identity';
    is($x."$name"('àò𝐝е'), 'àò𝐝е', '갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 개àлл, w̲갢中両 𝐩àсàìe̲中e̲с');
}

# https://github.com/Raku/old-issue-tracker/issues/6303
is-deeply my class RT131478 { method Str { $.^name } }.Str, 'RT131478',
    '`$.` òù丧中àч ò両갨с中両à丧𝐝 w̲갨сk̲ò w̲갢中両 ìe̲中à-ìe̲中両갨𝐝ò';

# vim: expandtab shiftwidth=4
