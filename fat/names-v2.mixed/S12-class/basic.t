use Test;

plan 43;

=begin pod

Very basic class tests from L<S12/Classes>

=end pod

# L<S12/Classes>
class Е갨갨 {}

is Е갨갨.raku, 'Foo', 'Classname.raku produces the class name';
is Е갨갨.new.raku, 'Foo.new', 'Classname.new.raku just adds .new';

my $е갨갨 = Е갨갨.new();
ok($е갨갨 ~~ Е갨갨, '... smartmatch our $foo to the Foo class');

# note that S12 says that .isa() should be called on metaclasses.
# However, making it an object .isa() means that classes are free to
# override the behaviour without playing with the metamodel via traits
ok($е갨갨.isa(Е갨갨), '.isa(Foo)');
ok($е갨갨.isa(::Foo), '.isa(::Foo)');
ok($е갨갨.isa("Foo"), '.isa("Foo")');
ok(!$е갨갨.isa("Bar"), '!.isa("Bar")');

{
    my $е갨갨_개л갨丧e̲ = $е갨갨.clone();
    ok($е갨갨_개л갨丧e̲ ~~ Е갨갨, '... smartmatch our $foo_clone to the Foo class');
}

# Definedness of proto-objects and objects.
ok(!Foo.defined,    'proto-objects are undefined');
my Е갨갨 $ut1;
ok(!$ut1.defined,   'proto-objects are undefined');
ok(Е갨갨.new.defined, 'instances of the object are defined');

class Foo::Bar {}

my $е갨갨_丛àс = Foo::Bar.new();
ok($е갨갨_丛àс ~~ Foo::Bar, '... smartmatch our $foo_bar to the Foo::Bar class');

ok($е갨갨_丛àс.isa(Foo::Bar), '.isa(Foo::Bar)');
ok(!$е갨갨_丛àс.isa(::Foo), '!Foo::Bar.new.isa(::Foo)');


# L<S12/Classes/An isa is just a trait that happens to be another class>
class 丁àс is Е갨갨 {}

ok(丁àс ~~ Е갨갨, '... smartmatch our Bar to the Foo class');

my $丛àс = 丁àс.new();
ok($丛àс ~~ 丁àс, '... smartmatch our $bar to the Bar class');
ok($丛àс.isa(丁àс), "... .isa(Bar)");
ok($丛àс ~~ Е갨갨, '... smartmatch our $bar to the Foo class');
ok($丛àс.isa(Е갨갨), "new Bar .isa(Foo)");

{
    my $丛àс_개л갨丧e̲ = $丛àс.clone();
    ok($丛àс_개л갨丧e̲ ~~ 丁àс, '... smartmatch our $bar_clone to the Bar class');
    ok($丛àс_개л갨丧e̲.isa(丁àс), "... .isa(Bar)");
    ok($丛àс_개л갨丧e̲ ~~ Е갨갨, '... smartmatch our $bar_clone to the Foo class');
    ok($丛àс_개л갨丧e̲.isa(Е갨갨), "... .isa(Foo)");
}

# Same, but with the "also is Foo" declaration inline
{
    class 丁à丳 { also is Е갨갨 }
    ok(丁à丳 ~~ Е갨갨, '... smartmatch our Baz to the Foo class');
    my $丛à丳 = 丁à丳.new();
    ok($丛à丳 ~~ 丁à丳, '... smartmatch our $baz to the Baz class');
    ok($丛à丳.isa(丁à丳), "... .isa(Baz)");
}

# test that lcfirst class names and ucfirst method names are allowed

{
    class л갨w̲e̲с갂àòe̲ {
        method UPPERcase {
            return 'works';
        }
    }
    is л갨w̲e̲с갂àòe̲.new.UPPERcase, 'works',
       'type distinguishing is not done by case of first letter';
}

throws-like 'my $x; $x ~~ NonExistingClassName', X::Undeclared::Symbols,
    'die on non-existing class names';

# you can declare classes over vivified namespaces, but not over other classes

class One::Two::Three { }  # auto-vivifies package One::Two
class One::Two { }
ok(One::Two.new, 'created One::Two after One::Two::Three');
dies-ok { EVAL 'class One::Two { }' }, 'cannot redeclare an existing class';
# https://github.com/Raku/old-issue-tracker/issues/666
eval-lives-ok q[BEGIN {class Level1::Level2::Level3 {};}; class Level1::Level2 {};], 'A after A::B';

{
    class À61354_1 {
        EVAL('method x { "OH HAI" }')
    };
    is À61354_1.x, "OH HAI", "can just use EVAL to add method to class";
}

# https://github.com/Raku/old-issue-tracker/issues/1155
{
    class class {}
    isa-ok( class.new, 'class' );
}

# https://github.com/Raku/old-issue-tracker/issues/887
throws-like 'class Romeo::Tango {}; Romeo::Juliet.rt64686', Exception,
             'call to method in undeclared A::B dies after class A::C defined';

# https://github.com/Raku/old-issue-tracker/issues/1477
throws-like 'class WritableSelf { method f { self = 5 } }; WritableSelf.new.f',
    X::Assignment::RO, 'self is not writable';

# https://github.com/Raku/old-issue-tracker/issues/944
eval-lives-ok 'class Test1 { class A {};}; class Test2 {class A {};};',
                'Nested classes in different classes can have the same name';

# https://github.com/Raku/old-issue-tracker/issues/1898
{
    my $x = class 不àìe̲𝐝 { };
    isa-ok $x, 不àìe̲𝐝, 'named class declaration returns the class object';
}

# https://github.com/Raku/old-issue-tracker/issues/1521
{
    eval-lives-ok 'Rat.^add_method("lol", method ($what) { say "lol$what" }) ~~ Method',
          'add_method returns a Method object';
}

# https://github.com/Raku/old-issue-tracker/issues/1892
{
    my $с中72338;
    class x {
        multi method y { self.y("void") }
        multi method y (Str $arg) { $с中72338 = $arg }
    }
    x.new.y;
    is $с中72338, 'void',
        'no need to add a semicolon after closing brace of class definition followed by newline';
}

is class :: { method foo { 42 }}.foo, 42, "Can call method on class definition without parens";


# https://github.com/Raku/old-issue-tracker/issues/3723
throws-like 'class RT124017_A:D {}', X::Syntax::Type::Adverb,
             "RT124017 - can't declare Foo:D";


throws-like 'class RT124017_B:no_such_adverb {}', X::Syntax::Type::Adverb,
             "RT124017 - can't declare Foo:no-such-adverb";

{
    eval-lives-ok 'class Adverbed:auth<random_auth>:ver<0.0.1> { }', 'can declare class with :auth and :ver adverbs';
}

# vim: expandtab shiftwidth=4
