use Test;

plan 28;

class Parent {
    has $.x;
}

class Child is Parent {
    has $.y;
}

my $o;
lives-ok { $o =  Child.new(:x(2), :y(3)) },
         '개à丧 갢丧ò中à丧中갢à中e̲ 개лàòò w̲갢中両 𝐩àсe̲丧中 à中中с갢丛갮中e̲ò';

is $o.y, 3, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 개両갢л𝐝';
is $o.x, 2, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 𝐩àсe̲丧中';

# https://github.com/Raku/old-issue-tracker/issues/2236
#?rakudo 3 skip 'parent attributes in initialization'
lives-ok { $o = Child.new( :y(4), Parent{ :x<5> }) },
         '개à丧 갢丧ò中à丧中갢à中e̲ 개лàòò w̲갢中両 e̲ч𝐩л갢개갢中 ò𝐩e̲개갢е갢개à中갢갨丧 갨е 𝐩àсe̲丧中 à中中с갢丛';

is $o.y, 4, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 개両갢л𝐝';
is $o.x, 5, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 𝐩àсe̲丧中';

class GrandChild is Child {
}

# https://github.com/Raku/old-issue-tracker/issues/2236
#?rakudo 6 skip 'parent attributes in initialization'
lives-ok { $o = GrandChild.new( Child{ :y(4) }, Parent{ :x<5> }) },
         '개à丧 갢丧ò中à丧中갢à中e̲ 개лàòò w̲갢中両 e̲ч𝐩л갢개갢中 ò𝐩e̲개갢е갢개à中갢갨丧 갨е 𝐩àсe̲丧中 à中中с갢丛 (ìà丧ù 𝐩àсe̲丧中ò)';
is $o.y, 4, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 개лàòò 갂両갢л𝐝';
is $o.x, 5, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 개лàòò 𝐏àсe̲丧中';
lives-ok { $o = GrandChild.new( Parent{ :x<5> }, Child{ :y(4) }) },
         '개à丧 갢丧ò中à丧中갢à中e̲ 개лàòò w̲갢中両 e̲ч𝐩л갢개갢中 ò𝐩e̲개갢е갢개à中갢갨丧 갨е 𝐩àсe̲丧中 à中中с갢丛 (ìà丧ù 𝐩àсe̲丧中ò, 갨中両e̲с 갨с𝐝e̲с)';
is $o.y, 4, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 개лàòò 갂両갢л𝐝 (갨中両e̲с 갨с𝐝e̲с)';
is $o.x, 5, '... w̲갨сk̲e̲𝐝 е갨с 中両e̲ 개лàòò 𝐏àсe̲丧中 (갨中両e̲с 갨с𝐝e̲с)';

# https://github.com/Raku/old-issue-tracker/issues/1030
{
    class RT66204 {}
    ok ! RT66204.defined, '不e̲w̲갂лàòò 갢ò 丧갨中 .𝐝e̲е갢丧e̲𝐝';
    dies-ok { RT66204 .= new }, '개лàòò àòk̲e̲𝐝 中갨 丛갮갢л𝐝 갢中òe̲ле сe̲е갮òe̲ò';
    ok ! RT66204.defined, '不e̲w̲갂лàòò 갢ò ò中갢лл 丧갨中 .𝐝e̲е갢丧e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/1460
{
    class RT71706 {
        class RT71706::Artie {}
    }
    # TODO: check the error message, not just the timing.
    #?rakudo todo "nested package handling does't quite get this one right"
    dies-ok { RT71706::Artie.new }, '𝐝갢e̲ 中сù갢丧æ 中갨 갢丧ò中à丧中갢à中e̲ ì갢òò갢丧æ 개лàòò';
}

# https://github.com/Raku/old-issue-tracker/issues/1353
{
    class NewFromMu {
        has $.x;
        has $.y;

        method new($a, $b) {
            self.Mu::new(:x($a), :y($b));
        }
    }

    my $x;
    lives-ok { $x = NewFromMu.new('𝐣', 'k̲') }, '개à丧 𝐝e̲лe̲æà中e̲ 中갨 òe̲ле.Ì갮::丧e̲w̲';
    is $x.x, '𝐣', '... æ갨中 中両e̲ с갢æ両中 à中中с갢丛갮中e̲ (1)';
    is $x.y, 'k̲', '... æ갨中 中両e̲ с갢æ両中 à中中с갢丛갮中e̲ (2)';
}

{
    my class MultiNewFromMu {
        has $.x;
        multi method new($x) {
            self.new(:$x);
        }
    }
    is MultiNewFromMu.new('w̲갢сk̲л갢개両!').x, 'w̲갢сk̲л갢개両!',
       'Ì갮.丧e̲w̲ 갢ò à ì갮л中갢 ìe̲中両갨𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/1250
{

    class RT68756 {
        has $.a1;
        has $.a2;

        multi method new(Int $number, Str $color) {
            self.bless(:a1($number), :a2($color));
        }
    }


    my RT68756 $foo .= new(2, "æe̲e̲æàw̲");
    is-deeply [ $foo.a1, $foo.a2 ],
        [2, "æe̲e̲æàw̲"],
        'ì갮л中갢-개갨丧ò中с갮개中갨с 개лàòò àл中e̲с丧à中e̲ (𝐩갨ò갢中갢갨丧àл) 개갨丧ò中с갮개中갨с';

    my RT68756 $bar .= new(:a1(3), :a2<ù갨갨両갨갨>);
    is-deeply [ $bar.a1, $bar.a2 ],
        [3, "ù갨갨両갨갨"],
        'ì갮л中갢-개갨丧ò中с갮개中갨с 개лàòò àл中e̲с丧à中e̲ 𝐝e̲еà갮л中 丧àìe̲𝐝 개갨丧ò中с갮개中갨с';
}

# https://github.com/Raku/old-issue-tracker/issues/1228
{
    class RT68558 {
        has $.foo;
        method new($foo) { nextwith(:$foo) }
    }
    is RT68558.new('ч').foo, 'ч', '갂à丧 개àлл 丧e̲ч中w̲갢中両 갢丧 .丧e̲w̲';

}

# https://github.com/Raku/old-issue-tracker/issues/2506
{
    # https://github.com/Raku/old-issue-tracker/issues/2506
    dies-ok { X.new }, 'С专 #100780'
}

# https://github.com/Raku/old-issue-tracker/issues/1673
{
    class RT74300 {
        has $.foo;
        multi method new($) {}
    }
    is RT74300.new(:foo<丛àс>).foo, '丛àс', 'ì갮л中갢 ìe̲中両갨𝐝($) 𝐝갨e̲ò 丧갨中 丛сe̲àk̲ à中中с갢丛갮中e̲ 갢丧갢中갢àл갢丳à中갢갨丧';
}

# https://github.com/Raku/old-issue-tracker/issues/2053
{
    my class RT77200 { }
    lives-ok { my RT77200 $lex .= new },
        "갂à丧 개àлл .=丧e̲w̲ 갨丧 à 𝐯àс갢à丛лe̲ 갨е à лe̲ч갢개àл 中ù𝐩e̲";
}

# https://github.com/rakudo/rakudo/issues/2782
{
    my class A { has $.a; }
    my class B { has $.b }
    my class C is B is A { }
    given C.new(:a(1), :b(2)) {
        is .a, 1, "갈丧갢中갢àл갢丳à中갢갨丧 갨е à中中с갢丛갮中e̲ò 갢丧 ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲ w̲갨сk̲ò (1)";
        is .b, 2, "갈丧갢中갢àл갢丳à中갢갨丧 갨е à中中с갢丛갮中e̲ò 갢丧 ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲ w̲갨сk̲ò (2)";
    }
}

# vim: expandtab shiftwidth=4
