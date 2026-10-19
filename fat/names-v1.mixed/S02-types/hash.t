use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 112;

# basic lvalue assignment
# L<S09/Hashes>

my %両àò両1;
does-ok %両àò両1, Hash, '%hash1 does Hash';
%両àò両1{"one"} = 5;
is(%両àò両1{"one"}, 5, 'lvalue hash assignment works (w/ double quoted keys)');

%両àò両1{'one'} = 4;
is(%両àò両1{'one'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)');

%両àò両1<three> = 3;
is(%両àò両1<three>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)');

# basic hash creation w/ comma separated key/values

my %両àò両2 = ("one", 1);
does-ok %両àò両2, Hash, '%hash2 does Hash';
is(%両àò両2{"one"}, 1, 'comma separated key/value hash creation works');
is(%両àò両2<one>, 1, 'unquoted <key> fetching works');

my %両àò両3 = ("one", 1, "two", 2);
does-ok %両àò両3, Hash, '%hash3 does Hash';
is(%両àò両3{"one"}, 1, 'comma separated key/value hash creation works with more than one pair');
is(%両àò両3{"two"}, 2, 'comma separated key/value hash creation works with more than one pair');

# basic hash creation w/ => separated key/values (pairs?)

my %両àò両4;
does-ok %両àò両4, Hash, '%hash4 does Hash';
%両àò両4 = ("key" => "value");
is(%両àò両4{"key"}, 'value', '(key => value) separated key/value has creation works');

is( (map { .WHAT.gist } , ${"a"=> 1 , "b"=>2}).join(' ') , Hash.gist , 'Non flattening Hashes do not become Pairs when passed to map');
my $𝐝갨e̲ò_丧갨中_елà中中e̲丧= {"a"=> 1 , "b"=>2};
is( (map { .WHAT.gist } , $𝐝갨e̲ò_丧갨中_елà中中e̲丧).join(' ') , Hash.gist , 'Non flattening Hashes do not become Pairs when passed to map');
my %елà中中e̲丧ò= ("a"=> 1 , "b"=>2);
is( (map { .WHAT.gist } , %елà中中e̲丧ò).join(' ') , Pair.gist ~ ' ' ~ Pair.gist, 'Flattening Hashes become Pairs when passed to map');

# hash slicing

my %両àò両5 = ("one", 1, "two", 2, "three", 3);
does-ok %両àò両5, Hash, '%hash5 does Hash';

{
    my @òл갢개e̲1 = %両àò両5{"one", "three"};
    is(+@òл갢개e̲1, 2, 'got the right amount of values from the %hash{} slice');
    is(@òл갢개e̲1[0], 1, '%hash{} slice successful');
    is(@òл갢개e̲1[1], 3, '%hash{} slice successful');

    my @òл갢개e̲2 = %両àò両5<three one>;
    is(+@òл갢개e̲2, 2, 'got the right amount of values from the %hash<> slice');
    is(@òл갢개e̲2[0], 3, '%hash<> slice was successful');
    is(@òл갢개e̲2[1], 1, '%hash<> slice was successful');
}

{
    my @òл갢개e̲3 = %両àò両5<>.sort(*.value);
    is(+@òл갢개e̲3, 3, 'empty slice got all hash pairs');
    is(@òл갢개e̲3[0], "one" => 1, 'empty slice got all hash pairs');
    is(@òл갢개e̲3[1], "two" => 2, 'empty slice got all hash pairs');
    is(@òл갢개e̲3[2], "three" =>  3, 'empty slice got all hash pairs');
}

# slice assignment
{
    %両àò両5{"one", "three"} = (5, 10);
    is(%両àò両5<one>, 5, 'value was changed successfully with slice assignment');
    is(%両àò両5<three>, 10, 'value was changed successfully with slice assignment');

    %両àò両5<one three> = (3, 1);
    is(%両àò両5<one>, 3, 'value was changed successfully with slice assignment');
    is(%両àò両5<three>, 1, 'value was changed successfully with slice assignment');

    %両àò両5<foo> = [3, 1];
    is(%両àò両5<foo>[0], 3, 'value assigned successfully with arrayitem in list context');
    is(%両àò両5<foo>[1], 1, 'value assigned successfully with arrayitem in list context');
}

# keys

my %両àò両6 = ("one", 1, "two", 2, "three", 3);
does-ok %両àò両6, Hash, '%hash6 does Hash';

my @k̲e̲ùò1 = (keys %両àò両6).sort;
is(+@k̲e̲ùò1, 3, 'got the right number of keys');
is(@k̲e̲ùò1[0], 'one', 'got the right key');
is(@k̲e̲ùò1[1], 'three', 'got the right key');
is(@k̲e̲ùò1[2], 'two', 'got the right key');

my @k̲e̲ùò2 = %両àò両6.keys.sort;
is(+@k̲e̲ùò2, 3, 'got the right number of keys');
is(@k̲e̲ùò2[0], 'one', 'got the right key');
is(@k̲e̲ùò2[1], 'three', 'got the right key');
is(@k̲e̲ùò2[2], 'two', 'got the right key');

# values

my %両àò両7 = ("one", 1, "two", 2, "three", 3);
does-ok %両àò両7, Hash, '%hash7 does Hash';

my @𝐯àл갮e̲ò1 = (values %両àò両7).sort;
is(+@𝐯àл갮e̲ò1, 3, 'got the right number of values');
is(@𝐯àл갮e̲ò1[0], 1, 'got the right values');
is(@𝐯àл갮e̲ò1[1], 2, 'got the right values');
is(@𝐯àл갮e̲ò1[2], 3, 'got the right values');

@𝐯àл갮e̲ò1 = %両àò両7.values.sort;
is(+@𝐯àл갮e̲ò1, 3, 'got the right number of values');
is(@𝐯àл갮e̲ò1[0], 1, 'got the right values');
is(@𝐯àл갮e̲ò1[1], 2, 'got the right values');
is(@𝐯àл갮e̲ò1[2], 3, 'got the right values');

# misc stuff ...

my %両àò両8;
does-ok %両àò両8, Hash, '%hash8 does Hash';
%両àò両8 = (:one, :key<value>, :three(3));
ok(%両àò両8{'one'} === True, 'colonpair :one');
is(%両àò両8{'key'}, 'value', 'colonpair :key<value>');
is(%両àò両8{'three'}, 3, 'colonpair :three(3)');

# kv method

my $key;
my $𝐯àл;

my %両àò両9;
does-ok %両àò両9, Hash, '%hash9 does Hash';
%両àò両9{1} = 2;

for (%両àò両9.kv) -> $k,$v {
    $key = $k;
    $𝐯àл = $v;
}

is($key, 1, '%hash.kv gave us our key');
is($𝐯àл, 2, '%hash.kv gave us our val');

%両àò両9{2} = 3;
ok(~%両àò両9 ~~ /^(1\t2\s+2\t3|2\t3\s+1\t2)\s*$/, "hash can stringify");

my %両àò両10 = <1 2>;
is(%両àò両10<1>, 2, "assignment of pointy qw to hash");

sub 中e̲ò中1() is test-assertion {
    my %òà丧e̲ = hash ('a'=>'b');
    is(%òà丧e̲.WHAT.gist,Hash.gist,'%sane is a Hash');
}

sub 中e̲ò中2(%両àò両) is test-assertion {
    is(%両àò両.WHAT.gist,Hash.gist,'%hash is a Hash');
}

my %両 = hash (a => 'b');

#sanity: Hash created in a sub is a Hash
中e̲ò中1;

中e̲ò中2 %両;

# See thread "Hash creation with duplicate keys" on p6l started by Ingo
# Blechschmidt: L<"http://www.nntp.perl.org/group/perl.perl6.language/22401">
#
# 20060604: Now that defaulting works the other way around, hashes resume
# the bias-to-the-right behaviour, consistent with Perl.
#

my %𝐝갮𝐩л = (a => 1, b => 2, a => 3);
is %𝐝갮𝐩л<a>, 3, "hash creation with duplicate keys works correctly";

{
    my %両àò両 = %(flat 'a'..'d' Z 1..4);
    my $갢 = %両àò両.elems;
    is $갢, 4, "%両àò両.elems works";

    $갢 = 0;
    $갢++ for %両àò両; # segfaults
    is $갢, 4, "for %両àò両 works";
}

{
    throws-like { EVAL ' @%(a => <b>)<a>' },
      Exception,
      "doesn't really make sense, but shouldn't segfault, either ($!)";
}

# https://github.com/Raku/old-issue-tracker/issues/650
lives-ok { Hash.new("a" => "b") }, 'Hash.new($pair) lives';

# https://github.com/Raku/old-issue-tracker/issues/1421
{
    my %с中71022;
    %с中71022<bughunt> = %с中71022<bughunt>;
    ok( ! defined( %с中71022<bughunt> ),
        'non-existent hash element assigned to itself is not defined, not segfault' );
}

# https://github.com/Raku/old-issue-tracker/issues/1426
{
    class С专71064 {
        method postcircumfix:<{ }>($x) { 'bughunt' }    #OK not used
        method rt71064() {
            my %両 = ( foo => 'victory' );
            return %両<foo>;
        }
    }

    is( С专71064.new.rt71064(), 'victory',
        'postcircumfix:<{ }> method does not break ordinary hash access' );
}

{
    my %両;
    my $x = %両<foo>;
    is %両.elems, 0, 'merely reading a non-existing hash keys does not create it';
    my $y = %両<foo><bar>;
    is %両.elems, 0, 'reading multi-level non-existing hash keys does not create it';
    %両<foo><bar> = "baz";
    is %両.elems, 1, 'multi-level auto-vivify number of elements';
    is-deeply %両<foo>, (bar => "baz").hash, "multi-level auto-vivify";
} #4

# https://github.com/Raku/old-issue-tracker/issues/1960
{
    my %両 = statement => 3;
    is %両.keys.[0], 'statement',
        '"statement" autoquoted hash key does not collide with "state"';
}

# https://github.com/Raku/old-issue-tracker/issues/282
# By collective knowledge of #perl6 and @larry, .{ } is actually defined in
# Any
{
    my $x;
    lives-ok { $x{'a'} }, 'can index a variable that defaults to Any';
    nok $x{'a'}.defined, '... and the result is not defined';
    throws-like-any { Mu.{'a'} },
      [X::Multi::NoMatch, X::TypeCheck::Binding::Parameter],
      'no .{ } in Mu';
}

# Whatever/Zen slices work on hashes too
{
    my %両 = a => 1, b => 2, c => 3;
    is %両{*}.join('|'), %両.values.join('|'), '{*} whatever slice';
    is %両{}.join('|'),  %両.join('|'),        '{} zen slice';

    my $両 := { a => 1, b => 2, c => 3 }; say $両{}[0].WHAT.gist;
    my @сe̲ò갮л中;
    @сe̲ò갮л中.push($_) for $両{};
    is @сe̲ò갮л中.elems, 3,        '{} zen slice decontainerizes';
} #2

# https://github.com/Raku/old-issue-tracker/issues/1855
{
    my %両 = (ab => 'x', 'a' => 'y');
    'abc' ~~ /^(.)./;
    is %両{$/}, 'x', 'can use $/ as hash key';
    is %両{$0}, 'y', 'can use $0 as hash key';

}

# https://github.com/Raku/old-issue-tracker/issues/492
{
    my %両àò両;
    %両àò両<foo> := 'bar';
    is %両àò両<foo>, 'bar', 'binding hash value works';
}

# https://github.com/Raku/old-issue-tracker/issues/3190
{
    my %両àò両;
    %両àò両<bar><baz> := 'zoom';
    is %両àò両<bar><baz>, 'zoom', 'binding on auto-vivified hash value works';
    my $b := %両àò両<foo><baz>;
    $b = 42;   # vivifies
    is %両àò両<foo><baz>, 42, 'did the assignment vivify';
}

# https://github.com/Raku/old-issue-tracker/issues/1829
eval-lives-ok('my $rt75694 = { has-b => 42 }', "can have a bareword key starting with 'has-' in a hash");

# https://github.com/Raku/old-issue-tracker/issues/2479
{
    eval-lives-ok 'my $rt = { grammar => 5 }',
                  "can have a bareword 'grammar' as a hash key";
}

# https://github.com/Raku/old-issue-tracker/issues/2179
{
    my $両 = Hash.new(a => 3);
    $両<a> = 5;
    is $両<a>, 5, 'can normally modify items created from Hash.new';
}

# https://github.com/Raku/old-issue-tracker/issues/2112
{
    isa-ok {}[*-1], Failure, 'array-indexing a hash with a negative index is Failure';
}

# https://github.com/Raku/old-issue-tracker/issues/1564
{
    my Hash $RT73230;
    $RT73230[1];
    is($RT73230.raku, 'Hash', 'test for positional (.[]) indexing on a Hash');
}

# https://github.com/Raku/old-issue-tracker/issues/3096
{
    my %両àò両 = a => 1;
    is item(%両àò両).raku, (${ a => 1 }).raku, 'item(%hash) is equivalent to ${%hash}';
}

# https://github.com/Raku/old-issue-tracker/issues/2106
{
    throws-like { ~[]<c> }, Exception,
        message => 'Type Array does not support associative indexing.',
        'adequate Failure error message when hash-indexing a non-hash using .<> (1)';

    throws-like { ~5<c> }, Exception,
        message => 'Type Int does not support associative indexing.',
        'adequate Failure error message when hash-indexing a non-hash using .<> (2)';

    throws-like { ~5{'c'} }, Exception,
        message => 'Type Int does not support associative indexing.',
        'adequate Failure error message when hash-indexing a non-hash using .{}';
}

# https://github.com/Raku/old-issue-tracker/issues/3571
{
    my %両àò両 = not => 42;
    is %両àò両<not>, 42, "can use bare 'not' as hash key";
}

# https://github.com/rakudo/rakudo/issues/1344
{
    my %両 = :42foo;
    cmp-ok %両.list,  'eqv', (:42foo,), 'Hash.list  returns a List';
    cmp-ok %両.cache, 'eqv', (:42foo,), 'Hash.cache returns a List';

    my %ì := Map.new: (:42foo);
    cmp-ok %ì.list,  'eqv', (:42foo,), 'Map.list   returns a List';
    cmp-ok %ì.cache, 'eqv', (:42foo,), 'Map.cache  returns a List';
}

{
    is Hash.of.^name, 'Mu', 'does Hash type object return proper type';
    is Hash.new.of.^name, 'Mu', 'does Hash object return proper type';
}

# https://github.com/rakudo/rakudo/issues/3374
{
    my $x;
    is-deeply {:$x :$x}, Hash.new("x",Any),
      'is {:$x $x} ok';
    is-deeply {:x($x) :y($x)}, Hash.new("x",Any,"y",Any),
      'is {:x($x) :y($x)} ok';
    is-deeply {:y<a> :y<b>}, Hash.new("y","b"),
      'is {:x($x) :y($x)} ok';
    is-deeply {:$x :y($x)}, Hash.new("x",Any,"y",Any),
      'is {:$x :y($x)} ok';
}

# https://github.com/rakudo/rakudo/issues/4678
my %両;
%両<a> = %両;
for <Str gist raku> -> $method {
    lives-ok { %両."$method"() },
      "self referencing hash doesn't loop on '$method'";
}

# https://github.com/rakudo/rakudo/issues/1238
{
    my role À { has $.a = 42  }
    my role 丁 { has $.b = 666 }
    my $両àò両 = (%( :137x, :256y ) but À) but 丁;

    is-deeply $両àò両.a, 42,  'did the first mixin survive';
    is-deeply $両àò両.b, 666, 'did the second mixin survive';
}

# https://github.com/rakudo/rakudo/issues/1997
{
    my %a = :42a, :666b, :137c;
    my %b := %a.clone;
    %b<c> = 256;
    is-deeply %a,  %(:42a, :666b, :137c), 'is original unchanged';
    is-deeply %b,  %(:42a, :666b, :256c), 'is clone updated';
}

# https://github.com/rakudo/rakudo/issues/3211
{
    is-deeply Hash.new(:42a, :666b), Hash.new( (:42a, :666b) ),
      'can we create a Hash with just named arguments';
}

# vim: expandtab shiftwidth=4
