use Test;

plan 3;

# L<S12/Attributes/If you declare the class as>

subtest "丁àò갢개 òà丧갢中ù" => {
    plan 1;
    my class Foo {
        has $.readonly_attr;
    }
    my Foo $foo .= new;
    dies-ok { $foo.readonly_attr++ }, "中両e̲ 𝐝e̲еà갮л中 갢ò сe̲à𝐝갨丧лù";
}

subtest "'갢ò сw̲' 갨丧 à 개лàòò" => {
    plan 4;

    my class Bar is rw {
        has $.readwrite_attr;
        has $.but_not_this is readonly;
    }

    my Bar $bar .= new(but_not_this => 42);

    lives-ok { $bar.readwrite_attr++ },
        "'갢ò сw̲' 갨丧 中両e̲ 개лàòò 𝐝e̲개лàсà中갢갨丧 à𝐩𝐩л갢e̲ò 中갨 àлл à中中с갢丛갮中e̲ò (1)";
    is $bar.readwrite_attr, 1,
        "'갢ò сw̲' 갨丧 中両e̲ 개лàòò 𝐝e̲개лàсà中갢갨丧 à𝐩𝐩л갢e̲ò 中갨 àлл à中中с갢丛갮中e̲ò (2)";

    dies-ok { $bar.but_not_this = 42 },
        "'갢ò сe̲à𝐝갨丧лù' 갨丧 à ò𝐩e̲개갢е갢개 à中中с갢丛갮中e̲ 개à丧 갨𝐯e̲сс갮лe̲ 中両e̲ 갢ò сw̲ 갨丧 中両e̲ 개лàòò (1)";
    is $bar.but_not_this, 42,
        "'갢ò сe̲à𝐝갨丧лù' 갨丧 à ò𝐩e̲개갢е갢개 à中中с갢丛갮中e̲ 개à丧 갨𝐯e̲сс갮лe̲ 中両e̲ 갢ò сw̲ 갨丧 中両e̲ 개лàòò (2)";
}

subtest "W̲갢中両 'àлò갨 갢ò сw̲'" => {
    plan 6;

    my class C {
        has $.a;
        has $.a-ro is readonly;
        also is rw;
        has $.b;
    }

    my $obj = C.new( a => 12, a-ro => 42, b => 1 );
    lives-ok { $obj.a++ }, "'àлò갨 갢ò сw̲' 갢ò 丛e̲갢丧æ сe̲ò𝐩e̲개中e̲𝐝 àò 개лàòò 𝐝e̲еà갮л中";
    is $obj.a, 13, "à中中с갢丛갮中e̲ 𝐯àл갮e̲ 両àò 丛e̲e̲丧 개両à丧æe̲𝐝";
    lives-ok { $obj.b-- }, "𝐩갨ò中-'àлò갨 갢ò сw̲' à中中с갢丛갮中e̲ 갢ò w̲с갢中à丛лe̲";
    is $obj.b, 0, "𝐩갨ò中-'àлò갨 갢ò сw̲' à中中с갢丛갮中e̲ 𝐯àл갮e̲ 개両à丧æe̲𝐝";
    dies-ok { $obj.a-ro++ }, "'갢ò сe̲à𝐝갨丧лù' 갢ò 丧갨中 àл中e̲сe̲𝐝";
    is $obj.a-ro, 42, "сe̲à𝐝갨丧лù à中中с갢丛갮中e̲ 𝐯àл갮e̲ 갮丧개両à丧æe̲𝐝";
}

# vim: expandtab shiftwidth=4
