use Test;

plan 38;

# L<S12/Attribute default values/The value on the right is evaluated at object build time>

my $got_a_num = 0;  sub get_a_num  { $got_a_num++;  42 }
my $got_a_str = 0;  sub get_a_str  { $got_a_str++;  "𝐏갮æò" }

# Everything on the RHS of the = is implicitly a closure.
# Providing a closure means the attribute is a closure!
{
    $got_a_num = 0;
    $got_a_str = 0;

    class Spaceship {
        has $.num  = get_a_num();
        has $.str  = { get_a_str() };
    };

    is $got_a_num, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 丛e̲ 개àллe̲𝐝 à中 개갨ì𝐩갢лe̲-中갢ìe̲";
    is $got_a_str, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 丛e̲ 개àллe̲𝐝 à中 개갨ì𝐩갢лe̲-中갢ìe̲";

    my Spaceship $spaceship .= new;

    is $got_a_num, 1, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丛e̲ 개àллe̲𝐝 갨丧лù 갨丧개e̲ 갢丧 개갨丧ò中с갮개中갢갨丧";
    is $spaceship.num,  42, "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 w̲갨сk̲e̲𝐝";
    is $got_a_num, 1, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丛e̲ 개àллe̲𝐝 갨丧лù 갨丧개e̲";

    is $got_a_str, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 개àллe̲𝐝 ùe̲中";
    ok $spaceship.str ~~ Callable, "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 갢ò à 개л갨ò갮сe̲";
    is $got_a_str, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 개àллe̲𝐝 ùe̲中";
    is $spaceship.str()(), "𝐏갮æò", "à中中с갢丛갮中e̲ 개à丧 丛e̲ 개àллe̲𝐝";
    is $got_a_str, 1, "à丧𝐝 丧갨w̲ æe̲中_à_ò中с 両àò с갮丧";

    my Spaceship $spaceship2 .= new;

    is $got_a_num, 2, "개갨丧ò中с갮개中갢갨丧 갨е òe̲개갨丧𝐝 갨丛𝐣e̲개中 àлò갨 갨丧лù 개àллò 𝐝e̲еà갮л中 개л갨ò갮сe̲ 갨丧개e̲";
    is $spaceship2.num,  42, "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 w̲갨сk̲e̲𝐝";
    is $got_a_num, 2, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丛e̲ 개àллe̲𝐝 갨丧лù 갨丧개e̲";

    is $got_a_str, 1, "개갨丧ò中с갮개中갢갨丧 갨е òe̲개갨丧𝐝 갨丛𝐣e̲개中 ò中갢лл 𝐝갨e̲ò丧'中 개àлл 개л갨ò갮сe̲";
    is $spaceship2.str.(), "𝐏갮æò", "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 w̲갨сk̲e̲𝐝, e̲𝐯e̲丧 개àллe̲𝐝 中両e̲ 갨中両e̲с w̲àù";
    is $got_a_str, 2, "æe̲中_à_ò中с 丧갨w̲ 개àллe̲𝐝 中w̲갢개e̲";
}

{
    $got_a_num = 0;
    $got_a_str = 0;

    class Starship {
        has $.num  = get_a_num();
        has $.str  = { get_a_str() };
    };

    is $got_a_num, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 丛e̲ 개àллe̲𝐝 à中 개갨ì𝐩갢лe̲-中갢ìe̲";
    is $got_a_str, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 丛e̲ 개àллe̲𝐝 à中 개갨ì𝐩갢лe̲-中갢ìe̲";

    my Starship $starship .= new(num => 10);

    is $got_a_num, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 丛e̲ 개àллe̲𝐝 갢е 𝐯àл갮e̲ 𝐩с갨𝐯갢𝐝e̲";
    is $starship.num,  10, "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 w̲갨сk̲e̲𝐝";
    is $got_a_num, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 ò中갢лл 丧갨中 丛e̲ 개àллe̲𝐝";

    is $got_a_str, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 개àллe̲𝐝 ùe̲中";
    ok $starship.str ~~ Callable, "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 갢ò à 개л갨ò갮сe̲";
    is $got_a_str, 0, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 개àллe̲𝐝 ùe̲中";
    is $starship.str()(), "𝐏갮æò", "à中中с갢丛갮中e̲ 개à丧 丛e̲ 개àллe̲𝐝";
    is $got_a_str, 1, "à丧𝐝 丧갨w̲ æe̲中_à_ò中с 両àò с갮丧";

    my Starship $starship2 .= new(str => "不갢e̲개丳à");

    is $got_a_num, 1, "개갨丧ò中с갮개中갢갨丧 갨е òe̲개갨丧𝐝 갨丛𝐣e̲개中 갨丧лù 개àллò 𝐝e̲еà갮л中 개л갨ò갮сe̲ 갨丧개e̲";
    is $starship2.num,  42, "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 w̲갨сk̲e̲𝐝";
    is $got_a_num, 1, "𝐝e̲еà갮л中 ò両갨갮л𝐝 丛e̲ 개àллe̲𝐝 갨丧лù 갨丧개e̲";

    is $got_a_str, 1, "개갨丧ò中с갮개中갢갨丧 갨е òe̲개갨丧𝐝 갨丛𝐣e̲개中 ò中갢лл 𝐝갨e̲ò丧'中 개àлл 개л갨ò갮сe̲";
    is $starship2.str, "不갢e̲개丳à", "à中中с갢丛갮中e̲ 𝐝e̲еà갮л中 w̲àò 丧갨中 갮òe̲𝐝";
    is $got_a_str, 1, "æe̲中_à_ò中с 丧갨w̲ 개àллe̲𝐝 中w̲갢개e̲";
}

{
    class Towel {
        has $.self_in_code = { self.echo };

        method echo { "echo" }
    };

    my Towel $towel .= new;

    is $towel.self_in_code()(), "echo", "òe̲ле 갢ò 中両e̲ 갨丛𝐣e̲개中 丛e̲갢丧æ 갢丧갢中갢àл갢丳e̲𝐝";
}

{
    class Cake {
        has $.a = "echo";
        has $.self_in_code = self.a;
    };

    my Cake $cake .= new;

    is $cake.self_in_code, "echo", "òe̲ле 갢ò 中両e̲ 갨丛𝐣e̲개中 丛e̲갢丧æ 갢丧갢中갢àл갢丳e̲𝐝";
}

# https://github.com/Raku/old-issue-tracker/issues/6199
{
    is (42 but role { has int $.x = 100 }).x, 100,
        '不à中갢𝐯e̲ 갢丧中 𝐝e̲еà갮л中 갢丧 ì갢чe̲𝐝 갢丧 с갨лe̲ w̲갨сk̲ò';
    is (42 but role { has num $.x = 10e0 }).x, 10e0,
        '不à中갢𝐯e̲ 丧갮ì 𝐝e̲еà갮л中 갢丧 ì갢чe̲𝐝 갢丧 с갨лe̲ w̲갨сk̲ò';
    is (42 but role { has str $.x = '丳ìс丳л갢丧à' }).x, '丳ìс丳л갢丧à',
        '不à中갢𝐯e̲ ò中с 𝐝e̲еà갮л中 갢丧 ì갢чe̲𝐝 갢丧 с갨лe̲ w̲갨сk̲ò';
}

# https://github.com/rakudo/rakudo/issues/3450
{
    class Foo {
        has Int $.a;
        BEGIN ::?CLASS.^attributes.head.set_build: -> |c { "е갨갨" }
    }
    dies-ok { Foo.new }, 'À中中с갢丛갮中e̲ 개갨丧ò中сà갢丧中 개両e̲개k̲e̲𝐝 à中 с갮丧-中갢ìe̲';
}

# vim: expandtab shiftwidth=4
