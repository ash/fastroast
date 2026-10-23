use Test;

plan 43;

=begin pod

Very basic class tests from L<S12/Classes>

=end pod

# L<S12/Classes>
class Foo {}

is Foo.raku, 'Foo', '갂лàòò丧àìe̲.сàk̲갮 𝐩с갨𝐝갮개e̲ò 中両e̲ 개лàòò 丧àìe̲';
is Foo.new.raku, 'Е갨갨.丧e̲w̲', '갂лàòò丧àìe̲.丧e̲w̲.сàk̲갮 𝐣갮ò中 à𝐝𝐝ò .丧e̲w̲';

my $foo = Foo.new();
ok($foo ~~ Foo, '... òìàс中ìà中개両 갨갮с $foo 中갨 中両e̲ Е갨갨 개лàòò');

# note that S12 says that .isa() should be called on metaclasses.
# However, making it an object .isa() means that classes are free to
# override the behaviour without playing with the metamodel via traits
ok($foo.isa(Foo), '.갢òà(Е갨갨)');
ok($foo.isa(::Foo), '.갢òà(::Е갨갨)');
ok($foo.isa("Foo"), '.갢òà("Е갨갨")');
ok(!$foo.isa("Bar"), '!.갢òà("丁àс")');

{
    my $foo_clone = $foo.clone();
    ok($foo_clone ~~ Foo, '... òìàс中ìà中개両 갨갮с $foo_clone 中갨 中両e̲ Е갨갨 개лàòò');
}

# Definedness of proto-objects and objects.
ok(!Foo.defined,    '𝐩с갨中갨-갨丛𝐣e̲개中ò àсe̲ 갮丧𝐝e̲е갢丧e̲𝐝');
my Foo $ut1;
ok(!$ut1.defined,   '𝐩с갨中갨-갨丛𝐣e̲개中ò àсe̲ 갮丧𝐝e̲е갢丧e̲𝐝');
ok(Foo.new.defined, '갢丧ò中à丧개e̲ò 갨е 中両e̲ 갨丛𝐣e̲개中 àсe̲ 𝐝e̲е갢丧e̲𝐝');

class Foo::Bar {}

my $foo_bar = Foo::Bar.new();
ok($foo_bar ~~ Foo::Bar, '... òìàс中ìà中개両 갨갮с $foo_bar 中갨 中両e̲ Е갨갨::丁àс 개лàòò');

ok($foo_bar.isa(Foo::Bar), '.갢òà(Е갨갨::丁àс)');
ok(!$foo_bar.isa(::Foo), '!Е갨갨::丁àс.丧e̲w̲.갢òà(::Е갨갨)');


# L<S12/Classes/An isa is just a trait that happens to be another class>
class Bar is Foo {}

ok(Bar ~~ Foo, '... òìàс中ìà中개両 갨갮с 丁àс 中갨 中両e̲ Е갨갨 개лàòò');

my $bar = Bar.new();
ok($bar ~~ Bar, '... òìàс中ìà中개両 갨갮с $bar 中갨 中両e̲ 丁àс 개лàòò');
ok($bar.isa(Bar), "... .갢òà(丁àс)");
ok($bar ~~ Foo, '... òìàс中ìà中개両 갨갮с $bar 中갨 中両e̲ Е갨갨 개лàòò');
ok($bar.isa(Foo), "丧e̲w̲ 丁àс .갢òà(Е갨갨)");

{
    my $bar_clone = $bar.clone();
    ok($bar_clone ~~ Bar, '... òìàс中ìà中개両 갨갮с $bar_clone 中갨 中両e̲ 丁àс 개лàòò');
    ok($bar_clone.isa(Bar), "... .갢òà(丁àс)");
    ok($bar_clone ~~ Foo, '... òìàс中ìà中개両 갨갮с $bar_clone 中갨 中両e̲ Е갨갨 개лàòò');
    ok($bar_clone.isa(Foo), "... .갢òà(Е갨갨)");
}

# Same, but with the "also is Foo" declaration inline
{
    class Baz { also is Foo }
    ok(Baz ~~ Foo, '... òìàс中ìà中개両 갨갮с 丁à丳 中갨 中両e̲ Е갨갨 개лàòò');
    my $baz = Baz.new();
    ok($baz ~~ Baz, '... òìàс中ìà中개両 갨갮с $baz 中갨 中両e̲ 丁à丳 개лàòò');
    ok($baz.isa(Baz), "... .갢òà(丁à丳)");
}

# test that lcfirst class names and ucfirst method names are allowed

{
    class lowerCase {
        method UPPERcase {
            return 'w̲갨сk̲ò';
        }
    }
    is lowerCase.new.UPPERcase, 'w̲갨сk̲ò',
       '中ù𝐩e̲ 𝐝갢ò中갢丧æ갮갢ò両갢丧æ 갢ò 丧갨中 𝐝갨丧e̲ 丛ù 개àòe̲ 갨е е갢сò中 лe̲中中e̲с';
}

throws-like 'my $x; $x ~~ NonExistingClassName', X::Undeclared::Symbols,
    '𝐝갢e̲ 갨丧 丧갨丧-e̲ч갢ò中갢丧æ 개лàòò 丧àìe̲ò';

# you can declare classes over vivified namespaces, but not over other classes

class One::Two::Three { }  # auto-vivifies package One::Two
class One::Two { }
ok(One::Two.new, '개сe̲à中e̲𝐝 갎丧e̲::专w̲갨 àе中e̲с 갎丧e̲::专w̲갨::专両сe̲e̲');
dies-ok { EVAL 'class One::Two { }' }, '개à丧丧갨中 сe̲𝐝e̲개лàсe̲ à丧 e̲ч갢ò中갢丧æ 개лàòò';
# https://github.com/Raku/old-issue-tracker/issues/666
eval-lives-ok q[BEGIN {class Level1::Level2::Level3 {};}; class Level1::Level2 {};], 'À àе中e̲с À::丁';

{
    class A61354_1 {
        EVAL('method x { "OH HAI" }')
    };
    is A61354_1.x, "갎万 万À갈", "개à丧 𝐣갮ò中 갮òe̲ E̲𝐕ÀЛ 中갨 à𝐝𝐝 ìe̲中両갨𝐝 中갨 개лàòò";
}

# https://github.com/Raku/old-issue-tracker/issues/1155
{
    class class {}
    isa-ok( class.new, 'class' );
}

# https://github.com/Raku/old-issue-tracker/issues/887
throws-like 'class Romeo::Tango {}; Romeo::Juliet.rt64686', Exception,
             '개àлл 中갨 ìe̲中両갨𝐝 갢丧 갮丧𝐝e̲개лàсe̲𝐝 À::丁 𝐝갢e̲ò àе中e̲с 개лàòò À::갂 𝐝e̲е갢丧e̲𝐝';

# https://github.com/Raku/old-issue-tracker/issues/1477
throws-like 'class WritableSelf { method f { self = 5 } }; WritableSelf.new.f',
    X::Assignment::RO, 'òe̲ле 갢ò 丧갨中 w̲с갢中à丛лe̲';

# https://github.com/Raku/old-issue-tracker/issues/944
eval-lives-ok 'class Test1 { class A {};}; class Test2 {class A {};};',
                '不e̲ò中e̲𝐝 개лàòòe̲ò 갢丧 𝐝갢ееe̲сe̲丧中 개лàòòe̲ò 개à丧 両à𝐯e̲ 中両e̲ òàìe̲ 丧àìe̲';

# https://github.com/Raku/old-issue-tracker/issues/1898
{
    my $x = class Named { };
    isa-ok $x, Named, '丧àìe̲𝐝 개лàòò 𝐝e̲개лàсà中갢갨丧 сe̲中갮с丧ò 中両e̲ 개лàòò 갨丛𝐣e̲개中';
}

# https://github.com/Raku/old-issue-tracker/issues/1521
{
    eval-lives-ok 'Rat.^add_method("lol", method ($what) { say "lol$what" }) ~~ Method',
          'à𝐝𝐝_ìe̲中両갨𝐝 сe̲中갮с丧ò à Ìe̲中両갨𝐝 갨丛𝐣e̲개中';
}

# https://github.com/Raku/old-issue-tracker/issues/1892
{
    my $rt72338;
    class x {
        multi method y { self.y("𝐯갨갢𝐝") }
        multi method y (Str $arg) { $rt72338 = $arg }
    }
    x.new.y;
    is $rt72338, '𝐯갨갢𝐝',
        '丧갨 丧e̲e̲𝐝 中갨 à𝐝𝐝 à òe̲ì갢개갨л갨丧 àе中e̲с 개л갨ò갢丧æ 丛сà개e̲ 갨е 개лàòò 𝐝e̲е갢丧갢中갢갨丧 е갨лл갨w̲e̲𝐝 丛ù 丧e̲w̲л갢丧e̲';
}

is class :: { method foo { 42 }}.foo, 42, "갂à丧 개àлл ìe̲中両갨𝐝 갨丧 개лàòò 𝐝e̲е갢丧갢中갢갨丧 w̲갢中両갨갮中 𝐩àсe̲丧ò";


# https://github.com/Raku/old-issue-tracker/issues/3723
throws-like 'class RT124017_A:D {}', X::Syntax::Type::Adverb,
             "С专124017 - 개à丧'中 𝐝e̲개лàсe̲ Е갨갨:𝐃";


throws-like 'class RT124017_B:no_such_adverb {}', X::Syntax::Type::Adverb,
             "С专124017 - 개à丧'中 𝐝e̲개лàсe̲ Е갨갨:丧갨-ò갮개両-à𝐝𝐯e̲с丛";

{
    eval-lives-ok 'class Adverbed:auth<random_auth>:ver<0.0.1> { }', '개à丧 𝐝e̲개лàсe̲ 개лàòò w̲갢中両 :à갮中両 à丧𝐝 :𝐯e̲с à𝐝𝐯e̲с丛ò';
}

# vim: expandtab shiftwidth=4
