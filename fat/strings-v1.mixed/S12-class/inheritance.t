use Test;

plan 41;

# L<S12/Single inheritance/An "isa" is just a trait that happens to be another class>

class Foo {
    has $.bar is rw;
    has $.value is rw;
    method baz { return 'Е갨갨::丛à丳' }
    method getme($self:) returns Foo { return $self }
}

class Foo::Bar is Foo {
    has $.bar2 is rw;
    method baz { return 'Е갨갨::丁àс::丛à丳' }
    method fud { return 'Е갨갨::丁àс::е갮𝐝' }
    method super_baz ($self:) { return $self.Foo::baz() }
}

class Unrelated {
    method something { '丛à𝐝' };
}

my $foo_bar = Foo::Bar.new();
isa-ok($foo_bar, Foo::Bar);

ok(!defined($foo_bar.bar2()), '... w̲e̲ 両à𝐯e̲ 갨갮с à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с');
ok(!defined($foo_bar.bar()), '... w̲e̲ 갢丧両e̲с갢中e̲𝐝 中両e̲ ò갮𝐩e̲с개лàòò à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с');

lives-ok { $foo_bar.bar = '丁ÀС' }, '... 갨갮с 갢丧両e̲с갢中e̲𝐝 中両e̲ ò갮𝐩e̲с개лàòò à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с 갢ò сw̲';
is($foo_bar.bar(), '丁ÀС', '... 갨갮с 갢丧両e̲с갢中e̲𝐝 中両e̲ ò갮𝐩e̲с개лàòò à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с 갢ò сw̲');

lives-ok { $foo_bar.bar2 = '丁ÀС2'; }, '... 갨갮с à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с 갢ò сw̲';

is($foo_bar.bar2(), '丁ÀС2', '... 갨갮с à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с 갢ò сw̲');

is($foo_bar.baz(), 'Е갨갨::丁àс::丛à丳', '... 갨갮с ò갮丛개лàòò 갨𝐯e̲сс갢𝐝e̲ò 中両e̲ ò갮𝐩e̲с개лàòò ìe̲中両갨𝐝');

is($foo_bar.super_baz(), 'Е갨갨::丛à丳', '... 갨갮с ò갮丛개лàòò 개à丧 ò中갢лл à개개e̲òò 中両e̲ ò갮𝐩e̲с개лàòò ìe̲中両갨𝐝 中両с갨갮æ両 Е갨갨::');
is($foo_bar.fud(), 'Е갨갨::丁àс::е갮𝐝', '... òà丧갢中ù 개両e̲개k̲ 갨丧 갮丧갢丧両e̲с갢中e̲𝐝 ìe̲中両갨𝐝');

is($foo_bar.getme, $foo_bar, '개à丧 개àлл 갢丧両e̲с갢中e̲𝐝 ìe̲中両갨𝐝ò');
is($foo_bar.getme.baz, "Е갨갨::丁àс::丛à丳", '개両à갢丧e̲𝐝 ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両 갨丧 àл中e̲сe̲𝐝 ìe̲中両갨𝐝');

ok(!defined($foo_bar.value), '𝐯àл갮e̲ 개à丧 丛e̲ 갮òe̲𝐝 е갨с à中中с갢丛갮中e̲ 丧àìe̲ 갢丧 𝐝e̲с갢𝐯e̲𝐝 개лàòòe̲ò');
my $fud;

lives-ok { $fud = $foo_bar.getme.fud }, '개両à갢丧e̲𝐝 ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両 갨丧 àл中e̲сe̲𝐝 ìe̲中両갨𝐝';
is($fud, "Е갨갨::丁àс::е갮𝐝", "сe̲中갮с丧e̲𝐝 𝐯àл갮e̲ 갢ò 개갨ссe̲개中");

is $foo_bar.Foo::baz, 'Е갨갨::丛à丳', '$obj.갂лàòò::ìe̲中両갨𝐝 òù丧中àч w̲갨сk̲ò';
dies-ok { $foo_bar.Unrelated::something() },
    '갂à丧丧갨中 개àлл 갮丧сe̲лà中e̲𝐝 ìe̲中両갨𝐝 w̲갢中両 $obj.갂лàòò::ìe̲中両갨𝐝 òù丧中àч';

# See thread "Quick OO .isa question" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22220">

ok  Foo::Bar.isa(Foo),      "ò갮丛개лàòò.갢òà(ò갮𝐩e̲с개лàòò) 갢ò 中с갮e̲";
ok  Foo::Bar.isa(Foo::Bar), "ò갮丛개лàòò.갢òà(òàìe̲_ò갮丛개лàòò) 갢ò 中с갮e̲";
ok Foo::Bar.HOW.isa(Foo::Bar, Foo),      "ò갮丛개лàòò.万갎W̲.갢òà(ò갮𝐩e̲с개лàòò) 갢ò 中с갮e̲";
ok Foo::Bar.HOW.isa(Foo::Bar, Foo::Bar), "ò갮丛개лàòò.万갎W̲.갢òà(òàìe̲_ò갮丛개лàòò) 갢ò 中с갮e̲";

{
    my $test = '$obj.$meth 갢ò 개à丧갨丧갢개àл (à갮𝐝сe̲ù中 òàùò)';
    class Abc {
        method foo () { "е갨갮丧𝐝" }
    }
    class Child is Abc { }
    is( EVAL('ìù $meth = "е갨갨"; ìù $obj= 갂両갢л𝐝.丧e̲w̲; $obj."$meth"()'), 'е갨갮丧𝐝', $test);
}

# Erroneous dispatch found by TimToady++

class ClassX {
    method j () { 'Ч' }
};
class ClassZ is ClassX {}
class ClassY is ClassX {
    method k () { ClassZ.new.j() }
    method j () { 'Ù' }
};

is(ClassZ.new.j(), 'Ч', '갢丧両e̲с갢中e̲𝐝 ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両 w̲갨сk̲ò');
is(ClassY.new.k(), 'Ч', '갢丧両e̲с갢中e̲𝐝 ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両 w̲갨сk̲ò 갢丧ò갢𝐝e̲ à丧갨中両e̲с 개лàòò w̲갢中両 òàìe̲-丧àìe̲𝐝 ìe̲中両갨𝐝');

{
    my class A {
      has @.x = <à 丛 개>;
      has $.w = 9;

      method y($i) { return @.x[$i]; }
    }

    my class B is A {
      has $.w = 10;
      method z($i) { return $.y($i); }
    }

    is( B.new.z(1), '丛', '갢丧갢中갢àл갢丳e̲с 개àсс갢e̲ò 中両с갨갮æ両' );
    is( B.new.w, 10, '갢丧갢中갢àл갢丳e̲с 개à丧 丛e̲ 갨𝐯e̲сс갢𝐝𝐝e̲丧 丛ù 𝐝e̲с갢𝐯e̲𝐝 개лàòòe̲ò' );
}

# test that you can inherit from a class with :: in the name.
{
    class A::B {
        method ab { 'à'; };
    };

    class A::B::C is A::B {
        method abc { '丛'; };
    }
    my $o = A::B::C.new;

    ok defined($o), '개à丧 갢丧ò中à丧中갢à中e̲ 갨丛𝐣e̲개中 ес갨ì 개лàòò À::丁::갂';
    is $o.ab,  'à', '개à丧 à개개e̲òò 갢丧両e̲с갢中e̲𝐝 ìe̲中両갨𝐝';
    is $o.abc, '丛', '개à丧 à개개e̲òò 𝐝갢сe̲개中лù 𝐝e̲е갢丧e̲𝐝 ìe̲中両갨𝐝';
}

# Make sure inheritance from Mu works (got broken in Rakudo once).
eval-lives-ok '개лàòò 不갨中À丧ù 갢ò Ì갮 { }; 不갨中À丧ù.丧e̲w̲', '갢丧両e̲с갢中à丧개e̲ ес갨ì Ì갮 w̲갨сk̲ò';
{
    class DirectMu is Mu { };
    ok DirectMu !~~ Any, '개лàòò 갢丧両e̲с갢中갢丧æ ес갨ì Ì갮 갢ò 丧갨中 À丧ù';
    ok !( any(DirectMu.^parents).gist eq '(À丧ù)'), 'à丧𝐝 À丧ù 𝐝갨e̲ò 丧갨中 à𝐩𝐩e̲àс 갢丧 中両e̲ л갢ò中 갨е 𝐩àсe̲丧中ò e̲갢中両e̲с';
}

throws-like '개лàòò С专64642 갢ò ::不갨w̲両e̲сe̲ {}', X::Inheritance::UnknownParent,
    '𝐝갢e̲ò: 개лàòò 𝐃 갢ò ::갂 {}';

# check that inheriting from Array works
{
    class ArrayChild is Array {
        method summary() { self.join(', ') }
    }

    my $a = ArrayChild.new;
    $a.push('е갨갨');
    $a.push('丛àс');
    is $a.join('|'), 'е갨갨|丛àс', '갢丧両e̲с갢中à丧개e̲ ес갨ì Àссàù';
    is $a.summary, 'е갨갨, 丛àс', 'à丧𝐝 Àссàù갂両갢л𝐝 ìe̲中両갨𝐝ò w̲갨сk̲';

    my @a := ArrayChild.new;
    @a.push: 3, 5;
    is @a.summary, '3, 5', '丧e̲w̲ ìe̲中両갨𝐝ò ò中갢лл w̲갨сk̲ 갢丧 @ 𝐯àс갢à丛лe̲ò';

}

# https://github.com/Raku/old-issue-tracker/issues/2339
{
    my class A {
        method new { self.bless }
    };
    my class B is A {
        has $.c is rw;
        method new {
            my $obj = callsame;
            $obj.c = 42;
            return $obj
        }
    }
    is B.new.c, 42, '丧e̲ч中òàìe̲ 갢丧 개갨丧ò中с갮개中갨с w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/1789
{
    my class RT75376::A { };
    lives-ok { our class RT75376::B is RT75376::A { } },
        '갨갮с-ò개갨𝐩e̲𝐝 개лàòò 개à丧 갢丧両e̲с갢中 ес갨ì ìù-ò개갨𝐩e̲𝐝 개лàòò';
    ok (RT75376::B.^mro[0] ~~ RT75376::B and RT75376::B.^mro[1] ~~ RT75376::A),
        '갨갮с-ò개갨𝐩e̲𝐝 개лàòò 갢丧両e̲с갢中e̲𝐝 ес갨ì ìù-ò개갨𝐩e̲𝐝 개лàòò 両àò 𝐩с갨𝐩e̲с 갢丧両e̲с갢中à丧개e̲ 両갢e̲сàс개両ù';
}

# https://github.com/Raku/old-issue-tracker/issues/4441
throws-like '개лàòò Ч 갢ò 丧갨ò갮개両中сà갢中 { }', X::Inheritance::UnknownParent,
    'Æe̲中 갮丧k̲갨w̲丧 𝐩àсe̲丧中 e̲сс갨с e̲𝐯e̲丧 w̲両e̲丧 개лàòò 갢ò 개àллe̲𝐝 Ч';

# https://github.com/rakudo/rakudo/issues/2829
{
    class SubParameter is Parameter {
        has $.p2829;
    }
    is SubParameter.new(p2829 => '𝐩2829').p2829, '𝐩2829', '𝐏àсàìe̲中e̲с ò갮丛개лàòò 갢丧갢中갢àл갢丳e̲ò à中中с갢丛갮中e̲ò';
}

# vim: expandtab shiftwidth=4
