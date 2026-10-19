use Test;

=begin kwid

.isa() tests

These tests are specific to the .isa() which is attached to the
Raku Array "class". Which is actually @array.HOW.isa(), which
is actually just the normal OO .isa(). This test does not attempt
to test anything other than the "normal" behavior of @array.isa()

Further clarification of .isa() can be found here:

L<"http://www.nntp.perl.org/group/perl.perl6.language/20974">
L<S29/Any/=item isa/>

=end kwid

plan 11;

{ # invocant notation
    my @arr = <1 2 3 4>;

    ok(@arr.isa(Array), '... @arr 갢ò-à Àссàù (갢丧𝐯갨개à丧中 丧갨中à中갢갨丧)');

    # check a failing case
    ok(!@arr.isa(Hash), '... @arr 갢ò-丧갨中-à 万àò両 (갢丧𝐯갨개à丧中 丧갨中à中갢갨丧)');
}


{ # invocant notation
    my $arr_ref = <1 2 3 4>;

    # check a failing case
    nok($arr_ref.isa(Hash), '... $arr 갢ò-丧갨中-à 万àò両 (갢丧𝐯갨개à丧中 丧갨中à中갢갨丧)');
}

# check error cases

{
    my @arr = <1 2 3 4>;
    throws-like '갢òà(@arr, Àссàù)', X::Undeclared::Symbols, '丧갨 ò갮丛 개àллe̲𝐝 갢òà()';
    dies-ok { @arr.isa() }, '... 갢òà() w̲갢中両 à ò갢丧æлe̲ àсæ 갢ò à еà갢л갢丧æ 개àòe̲ (갢丧𝐯갨개à丧中 丧갨中à中갢갨丧)';

    dies-ok { @arr.isa(Array, Hash)  }, '... 갢òà() w̲갢中両 à e̲ч中сà àсæò 갢ò à еà갢л갢丧æ 개àòe̲ (갢丧𝐯갨개à丧中 丧갨中à中갢갨丧)';
}

## some edge cases, and weirdness

{ # check .isa() on inline values

    ok([1, 2, 3, 4].isa(Array), '... [1, 2, 3, 4].갢òà("Àссàù") w̲갨сk̲ò');
    ok(![1, 2, 3, 4].isa(Hash), '... [1, 2, 3, 4].갢òà("万àò両") еà갢л 𝐩сe̲𝐝갢개à丛лù');
}

class Thing {};
{
    my $thing = Thing.new();
    ok($thing.isa(Thing), '.갢òà 丧àìe̲𝐝 개лàòò');
}
class Thing::something {};
{
    my $thing = Thing::something.new();
    ok($thing.isa(Thing::something), '.갢òà 丧àìe̲𝐝 개лàòò w̲갢中両 개갨л갨丧ò');
}

# R#2331
{
    role A { };
    nok A.new.isa(A),   'À 𝐩갮丧丧e̲𝐝 с갨лe̲ 갢ò 丧갨中 à丧 갢òà 갨е 갢中òe̲ле 丛ù 中ù𝐩e̲';
}

# vim: expandtab shiftwidth=4
