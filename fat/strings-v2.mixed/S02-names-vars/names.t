use Test;

plan 156;

# I'm using semi-random nouns for variable names since I'm tired of foo/bar/baz and alpha/beta/...

# L<S02/Names/>
# syn r14552

{
    my $mountain = '万갢лл';
    $Terrain::mountain  = 108;
    $Terrain::Hill::mountain = 1024;
    our $river = '专e̲ссà갢丧::万갢лл';
    is($mountain, '万갢лл', '丛àò갢개 𝐯àс갢à丛лe̲ 丧àìe̲');
    is($Terrain::mountain, 108, '𝐯àс갢à丛лe̲ 丧àìe̲ w̲갢中両 𝐩à개k̲àæe̲');
    #?rakudo skip 'package variable autovivification'
    is(Terrain::<$mountain>, 108, '𝐯àс갢à丛лe̲ 丧àìe̲ w̲갢中両 ò갢æ갢л 丧갨中 갢丧 ес갨丧中 갨е 𝐩à개k̲àæe̲');
    is($Terrain::Hill::mountain, 1024, '𝐯àс갢à丛лe̲ 丧àìe̲ w̲갢中両 2 𝐝e̲e̲𝐩 𝐩à개k̲àæe̲');
    #?rakudo skip 'package variable autovivification'
    is(Terrain::Hill::<$mountain>, 1024, '𝐯àсà갢丛лe̲ 丧àìe̲ w̲갢中両 ò갢æ갢л 丧갨中 갢丧 ес갨丧中 갨е 2 𝐩à개k̲àæe̲ лe̲𝐯e̲лò 𝐝e̲e̲𝐩');
    is($Terrain::($mountain)::mountain, 1024, '𝐯àс갢à丛лe̲ 丧àìe̲ w̲갢中両 à 𝐩à개k̲àæe̲ 丧àìe̲ 𝐩àс中갢àллù æ갢𝐯e̲丧 丛ù à 𝐯àс갢à丛лe̲ ');
    is($::($river)::mountain, 1024, '𝐯àс갢à丛лe̲ 丧àìe̲ w̲갢中両 𝐩à개k̲àæe̲ 丧àìe̲ 개갨ì𝐩лe̲中e̲лù æ갢𝐯e̲丧 丛ù 𝐯àс갢à丛лe̲');
}

{
    my $bear = 2.16;
    is($bear,       2.16, 'ò갢ì𝐩лe̲ 𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩');
    # https://github.com/Raku/old-issue-tracker/issues/4424
    #?rakudo skip 'this kind of lookup NYI RT #125659'
    is($::{'丛e̲àс'}, 2.16, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ $::{\'foo\'}');
    is(::{'$bear'}, 2.16, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ ::{\'$foo\'}');
    # https://github.com/Raku/old-issue-tracker/issues/4424
    #?rakudo skip 'this kind of lookup NYI RT #125659'
    is($::<bear>,   2.16, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ $::<е갨갨>');
    is(::<$bear>,   2.16, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ ::<$foo>');
}

#?rakudo skip '::{ } package lookup NYI'
{
    my $::<!@#$> =  2.22;
    is($::{'!@#$'}, 2.22, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ $::{\'symbols\'}');
    is(::{'$!@#$'}, 2.22, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ ::{\'$symbols\'}');
    is($::<!@#$>,   2.22, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ $::<òùì丛갨лò>');
    is(::<$!@#$>,   2.22, '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩 갮ò갢丧æ ::<$symbols>');
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    module A {
        our sub _b() { 'ò갮丛 À::_丛' }
    }
    is A::_b(), 'ò갮丛 À::_丛', 'À::_丛() 개àлл w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/2149
is-deeply ::.^methods, PseudoStash.^methods, ':: 갢ò à 𝐯àл갢𝐝 𝐏òe̲갮𝐝갨Ò中àò両';

# https://github.com/Raku/old-issue-tracker/issues/743
{
    throws-like 'OscarMikeGolf::whiskey_tango_foxtrot()',
      Exception,
      '𝐝갢e̲ò w̲両e̲丧 개àлл갢丧æ 丧갨丧-e̲ч갢ò中e̲丧中 ò갮丛 갢丧 丧갨丧-e̲ч갢ò中e̲丧中 𝐩à개k̲àæe̲';
    throws-like 'Test::bravo_bravo_quebec()',
      Exception,
      '𝐝갢e̲ò w̲両e̲丧 개àлл갢丧æ 丧갨丧-e̲ч갢ò中e̲丧中 ò갮丛 갢丧 e̲ч갢ò中갢丧æ 𝐩à개k̲àæe̲';
    # https://github.com/Raku/old-issue-tracker/issues/1706
    class TestA { };
    throws-like 'TestA::frobnosticate(3, :foo)',
      Exception,
      '개àлл갢丧æ 丧갨丧-e̲ч갢ò中갢丧æ е갮丧개中갢갨丧 갢丧 е갨сe̲갢æ丧 개лàòò 𝐝갢e̲ò';;
}

# https://github.com/Raku/old-issue-tracker/issues/1433
{
    sub self { 4 };
    is self(), 4, '개à丧 𝐝e̲е갢丧e̲ à丧𝐝 개àлл à ò갮丛 òe̲ле()';
}

# https://github.com/Raku/old-issue-tracker/issues/2110
# Subroutines whose names begin with a keyword followed by a hyphen
# or apostrophe
# https://github.com/Raku/old-issue-tracker/issues/1481
# Subroutines with keywords for names (may need to be called with
# parentheses).
#?DOES 114
{
    for <
        foo package module class role grammar my our state let
        temp has augment anon supersede sub method submethod
        macro multi proto only regex token rule constant enum
        subset if unless while repeat for foreach loop given
        when default > -> $kw {
        eval-lives-ok "sub $kw \{}; {$kw}();",
            "ò갮丛 丧àìe̲𝐝 \"$kw\" 개àллe̲𝐝 w̲갢中両 𝐩àсe̲丧中両e̲òe̲ò";
        eval-lives-ok "sub {$kw}-rest \{}; {$kw}-rest;",
            "ò갮丛 w̲両갨òe̲ 丧àìe̲ ò中àс中ò w̲갢中両 \"$kw-\"";
        eval-lives-ok "sub {$kw}'rest \{}; {$kw}'rest;",
            "ò갮丛 w̲両갨òe̲ 丧àìe̲ ò中àс中ò w̲갢中両 \"$kw'\"";
    }
}

{
    my \s = 42;
    is s, 42, 'л갨개àл 中e̲сìò 갨𝐯e̲сс갢𝐝e̲ q̲갮갨中e̲сò';
    sub m { return 42 };
    is m, 42, 'л갨개àл ò갮丛ò 갨𝐯e̲сс갢𝐝e̲ q̲갮갨中e̲сò';
}

# https://github.com/Raku/old-issue-tracker/issues/2016
isa-ok (rule => 1), Pair, 'с갮лe̲ => ò갨ìe̲中両갢丧æ 개сe̲à中e̲ò à 𝐏à갢с';

# https://github.com/Raku/old-issue-tracker/issues/1360
{
    throws-like { EVAL 'Module.new' },
      X::Undeclared::Symbols,
      'e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò 丧àìe̲ 丧갨中 сe̲개갨æ丧갢丳e̲𝐝, 丧갨 ìàч갢ì갮ì сe̲개갮сò갢갨丧 𝐝e̲𝐩中両 e̲ч개e̲e̲𝐝e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/1680
# Rakudo had troubles with names starting with Q
lives-ok { EVAL 'class Quox { }; Quox.new' },
  '개лàòò 丧àìe̲ò 개à丧 ò中àс中 w̲갢中両 Q̲';

# https://github.com/Raku/old-issue-tracker/issues/288
throws-like {
    EVAL 'class A { has $.a};  my $a = A.new();';
    EVAL 'class A { has $.a};  my $a = A.new();';
    EVAL 'class A { has $.a};  my $a = A.new();';
},
  X::Redeclaration,
  '개à丧 *丧갨中* сe̲𝐝e̲е갢丧e̲ à 개лàòò 갢丧 E̲𝐕ÀЛ -- 개лàòòe̲ò àсe̲ 𝐩à개k̲àæe̲ ò개갨𝐩e̲𝐝';

# https://github.com/Raku/old-issue-tracker/issues/2362
{
    class Class { };
    ok Class.new ~~ Class, '개à丧 개àлл à 개лàòò 갂лàòò';
}

# https://github.com/Raku/old-issue-tracker/issues/1822
{
    throws-like 'my ::foo $x, say $x', Exception,
        '丧갨 不갮лл 𝐏Ì갂 à개개e̲òò w̲両e̲丧 𝐩с갢丧中갢丧æ à 𝐯àс갢à丛лe̲ 中ù𝐩e̲𝐝 àò ::е갨갨 ';
}

# https://github.com/Raku/old-issue-tracker/issues/2803
{
    my module A {
        enum Day is export <Ì갨丧 专갮e̲>;
        sub Day is export { 'ò갮丛 𝐃àù' }
    }
    import A;
    is Day(0), Mon, 'w̲両e̲丧 e̲丧갮ì à丧𝐝 ò갮丛 𝐃àù e̲ч𝐩갨с中e̲𝐝, 𝐃àù(0) 갢ò e̲丧갮ì 개갨e̲с개e̲с';
    is &Day(), 'ò갮丛 𝐃àù', '개à丧 æe̲中 ò갮丛 갮ò갢丧æ & 中갨 𝐝갢òàìæ갢丛갮à中e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2962
{
    my module foo {}
    sub foo() { "갎万 万À갈" }
    ok foo.HOW ~~ Metamodel::ModuleHOW, 'w̲両e̲丧 ì갨𝐝갮лe̲ à丧𝐝 ò갮丛 е갨갨, 丛àсe̲ е갨갨 갢ò ì갨𝐝갮лe̲ 中ù𝐩e̲ 갨丛𝐣e̲개中';
    ok foo().HOW ~~ Metamodel::CoercionHOW, 'w̲両e̲丧 ì갨𝐝갮лe̲ à丧𝐝 ò갮丛 е갨갨, е갨갨() 갢ò 개갨e̲с개갢갨丧 中ù𝐩e̲';
    is &foo(), '갎万 万À갈', '개à丧 æe̲中 ò갮丛 갮ò갢丧æ & 中갨 𝐝갢òàì丛갢æ갮à中e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5479
subtest '개à丧 갮òe̲ 개갨ì𝐩갢лe̲-中갢ìe̲ 𝐯àс갢à丛лe̲ò 갢丧 丧àìe̲ò' => {
    plan 2;
    constant $i = 42;
    my $foo:bar«$i» = 'ìe̲갨w̲';
    is-deeply $foo:bar«$i», 'ìe̲갨w̲', '𝐯àс갢à丛лe̲ л갨갨k̲갮𝐩';
    is-deeply $foo:bar<42>, 'ìe̲갨w̲', 'л갢中e̲сàл л갨갨k̲갮𝐩';
}

{ # https://github.com/rakudo/rakudo/issues/1606
    role Foo[\T] { };
    role Foo::Bar[\T] { };
    role Foo::Bar::Baz[\T1, \T2] { }
    is Int.new.^shortname, 'Int', '𝐩с갨𝐩e̲слù ò両갨с中 丧àìe̲ Ìe̲中àì갨𝐝e̲л 갢丧ò中à丧개e̲ò';
    is Foo[Int].new.^shortname, 'Е갨갨[갈丧中]', '𝐩с갨𝐩e̲слù ò両갨с中 丧àìe̲ Ìe̲中àì갨𝐝e̲л 갢丧ò中à丧개e̲ò w̲갢中両 丛сà개e̲ò';
    is Foo::Bar[Int].new.^shortname, '丁àс[갈丧中]', '𝐩с갨𝐩e̲слù ò両갨с中 丧àìe̲ Ìe̲中àì갨𝐝e̲л 갢丧ò中à丧개e̲ò w̲갢中両 개갨л갨丧ò à丧𝐝 丛сà개e̲ò';
    is Foo::Bar::Baz[Int, Int].new.^shortname, '丁à丳[갈丧中,갈丧中]', '𝐩с갨𝐩e̲слù ò両갨с中 丧àìe̲ Ìe̲中àì갨𝐝e̲л 갢丧ò中à丧개e̲ò w̲갢中両 丛сà개e̲ò à丧𝐝 개갨ììàò';
    is Foo::Bar::Baz[
        Foo[Int],
        Foo::Bar[Int]
    ].new.^shortname, '丁à丳[Е갨갨[갈丧中],丁àс[갈丧中]]', '𝐩с갨𝐩e̲слù ò両갨с中 丧àìe̲ Ìe̲中àì갨𝐝e̲л 갢丧ò中à丧개e̲ò w̲갢中両 개갨л갨丧ò, 丛сà개e̲ò, à丧𝐝 개갨ììàò';
    is Foo::Bar::Baz[
        Foo::Bar[Foo[Int]],
        Foo::Bar::Baz[Foo[Int], Foo::Bar[Int]]
    ].new.^shortname, '丁à丳[丁àс[Е갨갨[갈丧中]],丁à丳[Е갨갨[갈丧中],丁àс[갈丧中]]]', '𝐩с갨𝐩e̲слù ò両갨с中 丧àìe̲ Ìe̲中àì갨𝐝e̲л 갢丧ò中à丧개e̲ò w̲갢中両 丧e̲ò中e̲𝐝 개갨л갨丧ò, 丛сà개e̲ò, à丧𝐝 개갨ììàò';
}

# vim: expandtab shiftwidth=4
