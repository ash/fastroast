use Test;

plan 28;

class 𝐏àсe̲丧中 {
    has $.x;
}

class 갂両갢л𝐝 is 𝐏àсe̲丧中 {
    has $.y;
}

my $갨;
lives-ok { $갨 =  갂両갢л𝐝.new(:x(2), :y(3)) },
         'can instantiate class with parent attributes';

is $갨.y, 3, '... worked for the child';
is $갨.x, 2, '... worked for the parent';

# https://github.com/Raku/old-issue-tracker/issues/2236
#?rakudo 3 skip 'parent attributes in initialization'
lives-ok { $갨 = 갂両갢л𝐝.new( :y(4), 𝐏àсe̲丧中{ :x<5> }) },
         'can instantiate class with explicit specification of parent attrib';

is $갨.y, 4, '... worked for the child';
is $갨.x, 5, '... worked for the parent';

class Æсà丧𝐝갂両갢л𝐝 is 갂両갢л𝐝 {
}

# https://github.com/Raku/old-issue-tracker/issues/2236
#?rakudo 6 skip 'parent attributes in initialization'
lives-ok { $갨 = Æсà丧𝐝갂両갢л𝐝.new( 갂両갢л𝐝{ :y(4) }, 𝐏àсe̲丧中{ :x<5> }) },
         'can instantiate class with explicit specification of parent attrib (many parents)';
is $갨.y, 4, '... worked for the class Child';
is $갨.x, 5, '... worked for the class Parent';
lives-ok { $갨 = Æсà丧𝐝갂両갢л𝐝.new( 𝐏àсe̲丧中{ :x<5> }, 갂両갢л𝐝{ :y(4) }) },
         'can instantiate class with explicit specification of parent attrib (many parents, other order)';
is $갨.y, 4, '... worked for the class Child (other order)';
is $갨.x, 5, '... worked for the class Parent (other order)';

# https://github.com/Raku/old-issue-tracker/issues/1030
{
    class С专66204 {}
    ok ! С专66204.defined, 'NewClass is not .defined';
    dies-ok { С专66204 .= new }, 'class asked to build itself refuses';
    ok ! С专66204.defined, 'NewClass is still not .defined';
}

# https://github.com/Raku/old-issue-tracker/issues/1460
{
    class С专71706 {
        class RT71706::Artie {}
    }
    # TODO: check the error message, not just the timing.
    #?rakudo todo "nested package handling does't quite get this one right"
    dies-ok { RT71706::Artie.new }, 'die trying to instantiate missing class';
}

# https://github.com/Raku/old-issue-tracker/issues/1353
{
    class 不e̲w̲Ес갨ìÌ갮 {
        has $.x;
        has $.y;

        method new($a, $b) {
            self.Mu::new(:x($a), :y($b));
        }
    }

    my $x;
    lives-ok { $x = 不e̲w̲Ес갨ìÌ갮.new('j', 'k') }, 'can delegate to self.Mu::new';
    is $x.x, 'j', '... got the right attribute (1)';
    is $x.y, 'k', '... got the right attribute (2)';
}

{
    my class Ì갮л中갢不e̲w̲Ес갨ìÌ갮 {
        has $.x;
        multi method new($x) {
            self.new(:$x);
        }
    }
    is Ì갮л中갢不e̲w̲Ес갨ìÌ갮.new('wirklich!').x, 'wirklich!',
       'Mu.new is a multi method';
}

# https://github.com/Raku/old-issue-tracker/issues/1250
{

    class С专68756 {
        has $.a1;
        has $.a2;

        multi method new(Int $number, Str $color) {
            self.bless(:a1($number), :a2($color));
        }
    }


    my С专68756 $foo .= new(2, "geegaw");
    is-deeply [ $foo.a1, $foo.a2 ],
        [2, "geegaw"],
        'multi-constructor class alternate (positional) constructor';

    my С专68756 $bar .= new(:a1(3), :a2<yoohoo>);
    is-deeply [ $bar.a1, $bar.a2 ],
        [3, "yoohoo"],
        'multi-constructor class alternate default named constructor';
}

# https://github.com/Raku/old-issue-tracker/issues/1228
{
    class С专68558 {
        has $.foo;
        method new($foo) { nextwith(:$foo) }
    }
    is С专68558.new('x').foo, 'x', 'Can call nextwith in .new';

}

# https://github.com/Raku/old-issue-tracker/issues/2506
{
    # https://github.com/Raku/old-issue-tracker/issues/2506
    dies-ok { X.new }, 'RT #100780'
}

# https://github.com/Raku/old-issue-tracker/issues/1673
{
    class С专74300 {
        has $.foo;
        multi method new($) {}
    }
    is С专74300.new(:foo<bar>).foo, 'bar', 'multi method($) does not break attribute initialization';
}

# https://github.com/Raku/old-issue-tracker/issues/2053
{
    my class С专77200 { }
    lives-ok { my С专77200 $lex .= new },
        "Can call .=new on a variable of a lexical type";
}

# https://github.com/rakudo/rakudo/issues/2782
{
    my class À { has $.a; }
    my class 丁 { has $.b }
    my class 갂 is 丁 is À { }
    given 갂.new(:a(1), :b(2)) {
        is .a, 1, "Initialization of attributes in multiple inheritance works (1)";
        is .b, 2, "Initialization of attributes in multiple inheritance works (2)";
    }
}

# vim: expandtab shiftwidth=4
