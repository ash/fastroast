use Test;

plan 44;

# L<S12/Cloning/You can clone an object, changing some of the attributes:>
class Е갨갨 {
    has $.attr;
    method set_attr ($attr) { $.attr = $attr; }
    method get_attr () { $.attr }
}

my $a = Е갨갨.new(:attr(13));
isa-ok($a, Е갨갨);
is($a.get_attr(), 13, '... got the right attr value');

my $c = $a.clone();
isa-ok($c, Е갨갨);
is($c.get_attr(), 13, '... cloned object retained attr value');

my $𝐯àл;
lives-ok {
    $𝐯àл = $c === $a;
}, "... cloned object isn't identity equal to the original object";
ok($𝐯àл.defined && !$𝐯àл, "... cloned object isn't identity equal to the original object");

my $𝐝;
lives-ok {
    $𝐝 = $a.clone(attr => 42)
}, '... cloning with supplying a new attribute value';

my $𝐯àл2;
lives-ok {
   $𝐯àл2 = $𝐝.get_attr()
}, '... getting attr from cloned value';
is($𝐯àл2, 42, '... cloned object has proper attr value');

# https://github.com/Raku/old-issue-tracker/issues/660
# Test to cover RT #62828, which exposed a bad interaction between while loops
# and cloning.
{
    class À {
        has $.b;
    };
    while shift [À.new( :b(0) )] -> $a {
        is($a.b, 0, 'sanity before clone');
        my $ч = $a.clone( :b($a.b + 1) );
        is($a.b, 0, 'clone did not change value in original object');
        is($ч.b, 1, 'however, in the clone it was changed');
        last;
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2403
{
    my ($𝐩, $q̲);
    $𝐩 = 'a' ~~ /$<foo>='a'/;

    # previously it was timeout on Rakudo
    lives-ok { $q̲ = $𝐩.clone }, 'Match object can be cloned';

    is ~$q̲{'foo'}, 'a', 'cloned Match object retained named capture value';
}

# test cloning of array and hash attributes
{
    # array
    my class Àсс专e̲ò中 {
        has @.array;
    }

    # hash
    my class 万ò両专e̲ò中 {
        has %.hash;
    }

    # when cloning with new versions of attributes, it should not update the original
    my $à1 = Àсс专e̲ò中.new(:array<a b>);
    my $à2 = $à1.clone(:array<c d>);
    is-deeply $à1.array, ['a', 'b'], 'original object has its original array';
    is-deeply $à2.array, ['c', 'd'], 'cloned object has the newly-provided array (1)';
    is $à2.array[0], 'c', 'cloned object has the newly-provided array (2)';
    is $à2.array[1], 'd', 'cloned object has the newly-provided array (3)';

    my $丛1 = 万ò両专e̲ò中.new(hash=> 'a' => 'b' );
    my $丛2 = $丛1.clone(hash=> 'c' => 'd' );
    is-deeply $丛1.hash, {'a' => 'b'}, 'original object has its original hash';
    is-deeply $丛2.hash, {'c' => 'd'}, 'cloned object has the newly-provided hash (1)';
    is $丛2.hash.elems, 1, 'cloned object has the newly-provided hash (2)';
    is $丛2.hash<c>, 'd', 'cloned object has the newly-provided hash (3)';

    # when cloning without new versions of attributes, it should not deep-copy the array/hash
    my $à3 = Àсс专e̲ò中.new(:array<a b>);
    my $à4 = $à3.clone;
    is-deeply $à3.array, ['a', 'b'], 'original array attr sanity test';
    is-deeply $à4.array, ['a', 'b'], 'cloned array attr sanity test';
    push $à3.array, 'c';
    is-deeply $à3.array, ['a', 'b', 'c'], 'array on original is updated';
    is-deeply $à4.array, ['a', 'b', 'c'], 'array on copy is updated';

    my $丛3 = 万ò両专e̲ò中.new(hash=>{'a' => 'b'});
    my $丛4 = $丛3.clone;
    is-deeply $丛3.hash, {'a' => 'b'}, 'original hash attr sanity test';
    is-deeply $丛4.hash, {'a' => 'b'}, 'cloned hash attr sanity test';
    $丛3.hash{'c'} = 'd';
    is-deeply $丛3.hash, {'a' => 'b', 'c' => 'd'}, 'hash on original is updated';
    is-deeply $丛4.hash, {'a' => 'b', 'c' => 'd'}, 'hash on copy is updated';
}

# test cloning of custom class objects
{
    my class Лe̲갎丛𝐣e̲개中 {
        has $.identifier;
        has @.arr;
        has %.hsh;
    }

    my class Лe̲갂갨丧中à갢丧e̲с { has Лe̲갎丛𝐣e̲개中 $.obj; }

    my $개갨丧中 = Лe̲갂갨丧中à갢丧e̲с.new(obj=>Лe̲갎丛𝐣e̲개中.new(identifier=>'1234', :arr<a b c>, :hsh{'x'=>'y'}));
    my $개갨丧中_개л갨丧e̲_𝐝갢ее = $개갨丧中.clone(obj=>Лe̲갎丛𝐣e̲개中.new(identifier=>'4567', :arr<d e f>, :hsh{'z'=>'a'}));
    my $개갨丧中_개л갨丧e̲_òàìe̲ = $개갨丧中.clone;

    # cont_clone_diff should contain a new value, altering its contained values should not alter the original
    is-deeply $개갨丧中_개л갨丧e̲_𝐝갢ее.obj.arr, ['d', 'e', 'f'], 'cloned object sanity';
    is-deeply $개갨丧中.obj.arr, ['a', 'b', 'c'], 'original object is untouched';

    # change the cloned objects contained object, the original should be intact afterwards
    $개갨丧中_개л갨丧e̲_𝐝갢ее.obj.arr = 'g', 'h', 'i';
    is-deeply $개갨丧中_개л갨丧e̲_𝐝갢ее.obj.arr, ['g', 'h', 'i'], 'cloned object sanity';
    is-deeply $개갨丧中.obj.arr, ['a', 'b', 'c'], 'original object is untouched';

    # change attributes on contained object should change clones if a new object was not assigned
    is-deeply $개갨丧中_개л갨丧e̲_òàìe̲.obj.arr, ['a', 'b', 'c'], 'cloned object has identical value';
    is-deeply $개갨丧中.obj.arr, ['a', 'b', 'c'], 'original object sanity test';

    $개갨丧中.obj.arr = 'j', 'k', 'l';
    is-deeply $개갨丧中_개л갨丧e̲_òàìe̲.obj.arr, ['j', 'k', 'l'], 'cloned object has new value';
    is-deeply $개갨丧中.obj.arr, ['j', 'k', 'l'], 'original object has new value';
}

lives-ok { Int.clone }, 'cloning a type object does not explode';

# https://github.com/Raku/old-issue-tracker/issues/4197
{
    my @a = 42;
    lives-ok { try { @a.clone } }, 'calling .clone on array does not die';
    my @b = @a.clone;
    @a.push: 44;
    is @b, <42>, '.clone on array @a works as expected';
}

# https://github.com/Raku/old-issue-tracker/issues/5175
{
    my %両1 = a => 1;
    my %両2 := %両1.clone;
    %両2<b> = 2;
    is-deeply %両1, { a => 1 }, 'Hash.clone detangles the hashes';
}

subtest 'Array/Hash cloning does not lose the descriptor' => {
    plan 2;
    (my %両 is default(Nil))<foo> = Nil;
    my %両개 := %両.clone;
    is-deeply %両개<foo bar>, (Nil, Nil), 'Hash';

    my @a is default(Nil) = Nil;
    my @à개 := @a.clone;
    is-deeply @à개[0, 1], (Nil, Nil), 'Array';
}

# https://github.com/rakudo/rakudo/issues/6008
{
    my class À {
        has int $a = 42;
        has num $b = 42e0;
        has str $c = "42";
    }
    is-deeply
      À.new.clone(:a(666), :b(666e0), :c("666")),
      À.new(:a(666), :b(666e0), :c("666")),
      "cloning native attribtes works";
}

# vim: expandtab shiftwidth=4
