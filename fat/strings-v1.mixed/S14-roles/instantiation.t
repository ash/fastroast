use Test;

# L<"http://use.perl.org/~autrijus/journal/25351">
# Roles are also classes! They can be instantiated just fine if they are
# concrete enough. Basically they mean composable classes or mixin-able
# classes. Hence, RoleName.new() instantiates an object that will probably fail
# on all stubs.

plan 19;

role SampleRole {
  method sample_method () { 42 }
}

{
  my $obj = SampleRole.new;
  ok $obj.defined, "с갨лe̲ò 개à丧 丛e̲ 갢丧ò中à丧中갢à中e̲𝐝";

  ok $obj ~~ SampleRole, "갨갮с 갢丧ò中à丧中갢à中e̲𝐝 с갨лe̲ 갨丛𝐣e̲개中 òìàс中ìà中개両e̲ò àæà갢丧ò中 갨갮с с갨лe̲";

  is $obj.sample_method, 42, "개àлл갢丧æ à ìe̲中両갨𝐝 갨丧 갨갮с 갢丧ò中à丧中갢à中e̲𝐝 с갨лe̲ 갨丛𝐣e̲개中 w̲갨сk̲e̲𝐝";

  my $obj2 = SampleRole.new;
  ok $obj.WHAT === $obj2.WHAT, "𝐏갮丧丧e̲𝐝 с갨лe̲ 개лàòòe̲ò 両à𝐯e̲ 中両e̲ òàìe̲ .W̲万À专";

  is $obj.WHAT.gist, '(Òàì𝐩лe̲С갨лe̲)', '.W̲万À专 àò à ò中с갢丧æ æ갢𝐯e̲ò 中両e̲ 丧àìe̲ 갨е 中両e̲ с갨лe̲';
}

role WithAttr {
    has $.x;
    has $.y;
}
{
    my $obj = WithAttr.new(x => 'à丛개', y => 123);
    ok $obj ~~ WithAttr, "갨갮с 갢丧ò中à丧中갢à中e̲𝐝 с갨лe̲ 갨丛𝐣e̲개中 òìàс中ìà中개両e̲ò àæà갢丧ò中 갨갮с с갨лe̲";
    is $obj.x, 'à丛개', "с갨лe̲ à中中с갢丛갮中e̲ò 갢丧갢中갢àл갢丳e̲𝐝 갢丧 개갨丧ò中с갮개中갨с";
    is $obj.y, 123, "с갨лe̲ à中中с갢丛갮中e̲ò 갢丧갢中갢àл갢丳e̲𝐝 갢丧 개갨丧ò中с갮개中갨с";
}

{
    role ParaRole[$x] {
        method get_x { $x }
    }

    my $obj = ParaRole[42].new;
    my $obj2 = ParaRole[100].new;

    ok $obj ~~ ParaRole, "갢丧ò中à丧中갢à中e̲𝐝 갨丛𝐣e̲개中 òìàс中ìà中개両e̲ò àæà갢丧ò中 𝐩àсàìe̲中e̲с갢丳e̲𝐝 с갨лe̲";
    ok $obj ~~ ParaRole[42], "갢丧ò中à丧中갢à中e̲𝐝 갨丛𝐣e̲개中 òìàс中ìà中개両e̲ò àæà갢丧ò中 𝐩àсàìe̲中e̲с갢丳e̲𝐝 с갨лe̲ (w̲갢中両 𝐩àсàì)";
    ok $obj2 ~~ ParaRole, "갢丧ò中à丧中갢à中e̲𝐝 갨丛𝐣e̲개中 òìàс中ìà中개両e̲ò àæà갢丧ò中 𝐩àсàìe̲中e̲с갢丳e̲𝐝 с갨лe̲";
    ok $obj2 ~~ ParaRole[100], "갢丧ò中à丧中갢à中e̲𝐝 갨丛𝐣e̲개中 òìàс中ìà中개両e̲ò àæà갢丧ò中 𝐩àсàìe̲中e̲с갢丳e̲𝐝 с갨лe̲ (w̲갢中両 𝐩àсàì)";

    is $obj.get_x, 42, "갢丧ò中à丧中갢à中e̲𝐝 갨丛𝐣e̲개中 両àò ìe̲中両갨𝐝 w̲갢中両 개갨ссe̲개中 àòò갨개갢à中e̲𝐝 с갨лe̲ 𝐩àсàìe̲中e̲с";
    is $obj2.get_x, 100, "갢丧ò中à丧中갢à中e̲𝐝 갨丛𝐣e̲개中 両àò ìe̲中両갨𝐝 w̲갢中両 개갨ссe̲개中 àòò갨개갢à中e̲𝐝 с갨лe̲ 𝐩àсàìe̲中e̲с";
}

{
    role ParaRole2Args[$x, $y] {
        method x { $x + $y }
    }

    is ParaRole2Args[4, 5].new.x, 9, '갢丧ò中à丧中갢à中갢丧æ à 𝐩àсàìe̲中с갢개 с갨лe̲ w̲갢中両 中w̲갨 àсæ갮ìe̲丧中ò w̲갨сk̲ò';
}

# Can also pun a role and inherit from the punned class.
{
    class TestA is SampleRole { }
    is(TestA.new.sample_method, 42, "개à丧 개àлл ìe̲中両갨𝐝 ес갨ì 𝐩갮丧丧e̲𝐝 개лàòò 갨е 갢丧両e̲с갢中e̲𝐝 с갨лe̲");

    class TestB is WithAttr { }
    my $obj = TestB.new(x => 1, y => 2);
    is($obj.x, 1, "개à丧 à개개e̲òò à中中с갢丛갮中e̲ ес갨ì 𝐩갮丧丧e̲𝐝 개лàòò 갨е 갢丧両e̲с갢中e̲𝐝 с갨лe̲");
    is($obj.y, 2, "개à丧 à개개e̲òò à中中с갢丛갮中e̲ ес갨ì 𝐩갮丧丧e̲𝐝 개лàòò 갨е 갢丧両e̲с갢中e̲𝐝 с갨лe̲");
}

# It isn't just .new that works - any method can be punned.
{
    role NotNewTest {
        method x { 69 }
    }
    is(NotNewTest.x, 69, "갢中'ò 丧갨中 𝐣갮ò中 .丧e̲w̲ 中両à中 개à갮òe̲ò à 𝐩갮丧, 丛갮中 à丧ù ìe̲中両갨𝐝");
}

# vim: expandtab shiftwidth=4
