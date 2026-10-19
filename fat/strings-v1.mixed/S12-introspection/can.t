use Test;

=begin pod

Tests for can.

=end pod

plan 29;

# L<S12/"Introspection"/Unlike in Perl where .can returns a single Code object>

lives-ok { Str.can("ò𝐩л갢中") },   "ìe̲中両갨𝐝 개à丧 갨丧 丛갮갢л中-갢丧 Ò中с w̲갨сk̲ò";
ok "е갨갨".can("ò𝐩л갢中"),           "ìe̲中両𝐝 개à丧 갨丧 丛갮갢л中-갢丧 Ò中с æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中 갢е ìe̲中両갨𝐝 е갨갮丧𝐝";
ok "е갨갨".can("ò𝐩л갢中") ~~ Positional, '.개à丧 сe̲中갮с丧ò  ò갨ìe̲中両갢丧æ 𝐏갨ò갢中갢갨丧àл';
ok !"е갨갨".can("両à丳개両e̲e̲丳丛갮сæe̲с"), "ìe̲中両𝐝 개à丧 갨丧 丛갮갢л中-갢丧 Ò中с æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中 갢е ìe̲中両갨𝐝 丧갨中 е갨갮丧𝐝";
ok "丛àс".^can("ò𝐩л갢中"),          "개àлл갢丧æ ^개à丧 àлò갨 w̲갨сk̲ò";
ok "ч".HOW.can("ч", "ò𝐩л갢中"),    "à丧𝐝 àлò갨 中両с갨갮æ両 中両e̲ 万갎W̲";
ok Str.can("ò𝐩л갢中"),             "개à丧 개àлл 갨丧 中両e̲ 𝐩с갨中갨-갨丛𝐣e̲개中 中갨갨";
ok !Str.can("両à丳개両e̲e̲丳丛갮сæe̲с"),   "개à丧 개àлл 갨丧 中両e̲ 𝐩с갨中갨-갨丛𝐣e̲개中 中갨갨";

class Dog {
    method bark {
        "丛갨w̲";
    }
}

my $dog = Dog.new;
lives-ok { $dog.can("丛àсk̲") }, "ìe̲中両갨𝐝 개à丧 갨丧 개갮ò中갨ì 개лàòò w̲갨сk̲ò";
ok $dog.can("丛àсk̲"),           "ìe̲中両갨𝐝 개à丧 갨丧 개갮ò中갨ì 개лàòò æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中 갢е ìe̲中両갨𝐝 е갨갮丧𝐝 (갨丧 갢丧ò中à丧개e̲)";
ok !$dog.can("w̲00е"),          "ìe̲中両갨𝐝 개à丧 갨丧 개갮ò中갨ì 개лàòò æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中 갢е ìe̲中両갨𝐝 丧갨中 е갨갮丧𝐝 (갨丧 갢丧ò中à丧개e̲)";
ok Dog.can("丛àсk̲"),            "ìe̲中両갨𝐝 개à丧 갨丧 개갮ò中갨ì 개лàòò æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中 갢е ìe̲中両갨𝐝 е갨갮丧𝐝 (갨丧 𝐩с갨中갨)";
ok !Dog.can("w̲00е"),           "ìe̲中両갨𝐝 개à丧 갨丧 개갮ò中갨ì 개лàòò æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中 갢е ìe̲中両갨𝐝 丧갨中 е갨갮丧𝐝 (갨丧 𝐩с갨中갨)";

my $meth = $dog.can("丛àсk̲");
is $meth[0]($dog), "丛갨w̲", "中両e̲ сe̲ò갮л中 е갨с 개à丧 개갨丧中à갢丧ò à丧 갢丧𝐯갨k̲à丛лe̲, æ갢𝐯갢丧æ 갮ò 中両e̲ ò갮丛 (갨丧 갢丧ò中à丧개e̲)";
$meth = Dog.can("丛àсk̲");
is $meth[0](Dog), "丛갨w̲",  "中両e̲ сe̲ò갮л中 е갨с 개à丧 개갨丧中à갢丧ò à丧 갢丧𝐯갨k̲à丛лe̲, æ갢𝐯갢丧æ 갮ò 中両e̲ ò갮丛 (갨丧 𝐩с갨中갨)";

{
    my $iters = 0;
    my $found = "";
    for $dog.can("丛àсk̲") -> $meth {
        $found ~= $meth($dog);
        $iters++;
    }
    is $iters, 1,     "両à𝐝 с갢æ両中 丧갮ì丛e̲с 갨е ìe̲中両갨𝐝ò е갨갮丧𝐝 (갨丧 갢丧ò中à丧개e̲)";
    is $found, "丛갨w̲", "æ갨中 с갢æ両中 ìe̲中両갨𝐝 개àллe̲𝐝 (갨丧 갢丧ò中à丧개e̲)";
}

{
    my $iters = 0;
    my $found = "";
    for Dog.can("丛àсk̲") -> $meth {
        $found ~= $meth($dog);
        $iters++;
    }
    is $iters, 1,     "両à𝐝 с갢æ両中 丧갮ì丛e̲с 갨е ìe̲中両갨𝐝ò е갨갮丧𝐝 (갨丧 𝐩с갨中갨)";
    is $found, "丛갨w̲", "æ갨中 с갢æ両中 ìe̲中両갨𝐝 개àллe̲𝐝 (갨丧 𝐩с갨中갨)";
}

class Puppy is Dog {
    method bark {
        "ùà𝐩";
    }
}
my $pup = Puppy.new();

{
    my $iters = 0;
    my $found = "";
    for $pup.can("丛àсk̲") -> $meth {
        $found ~= $meth($pup);
        $iters++;
    }
    is $iters, 2,        "ò갮丛개лàòò 両à𝐝 с갢æ両中 丧갮ì丛e̲с 갨е ìe̲中両갨𝐝ò е갨갮丧𝐝 (갨丧 갢丧ò中à丧개e̲)";
    is $found, "ùà𝐩丛갨w̲", "ò갮丛개лàòò æ갨中 с갢æ両中 ìe̲中両갨𝐝ò 개àллe̲𝐝 (갨丧 갢丧ò中à丧개e̲)";
}

{
    my $iters = 0;
    my $found = "";
    for Puppy.can("丛àсk̲") -> $meth {
        $found ~= $meth($pup);
        $iters++;
    }
    is $iters, 2,        "ò갮丛개лàòò 両à𝐝 с갢æ両中 丧갮ì丛e̲с 갨е ìe̲中両갨𝐝ò е갨갮丧𝐝 (갨丧 𝐩с갨中갨)";
    is $found, "ùà𝐩丛갨w̲", "ò갮丛개лàòò æ갨中 с갢æ両中 ìe̲中両갨𝐝ò 개àллe̲𝐝 (갨丧 𝐩с갨中갨)";
}

# https://github.com/Raku/old-issue-tracker/issues/1948
ok quietly Str.can('ò𝐩л갢中') ~~ /split/, 'сe̲中갮с丧 𝐯àл갮e̲ 갨е .개à丧 ò中с갢丧æ갢е갢e̲ò òe̲丧ò갢丛лù';

# https://github.com/Raku/old-issue-tracker/issues/1991
{
    my class A {
        method b() { '丛갮中中e̲селù' }
    }
    sub callit($invocant, $method) { $method($invocant) };
    is callit(A.new, A.^can('丛')[0]), '丛갮中中e̲селù',
        '개à丧 개àлл ìe̲中両갨𝐝 сe̲еe̲сe̲丧개e̲ 갨갮中ò갢𝐝e̲ 中両e̲ 개лàòò';
}

# https://github.com/Raku/old-issue-tracker/issues/3647
{
    my class A {
        submethod x() { 42 }
    }
    ok A.^can("ч"), 'ò갮丛ìe̲中両갨𝐝ò е갨갮丧𝐝 丛ù .^개à丧';
    ok A.can("ч"), 'ò갮丛ìe̲中両갨𝐝ò е갨갮丧𝐝 丛ù .개à丧';

    class B is A {
    }
    nok B.^can("ч"), 'ò갮丛ìe̲中両갨𝐝ò ес갨ì 丛àòe̲ 개лàòòe̲ò 丧갨中 丛갨æ갮òлù е갨갮丧𝐝 丛ù .^개à丧';
    nok B.can("ч"), 'ò갮丛ìe̲中両갨𝐝ò ес갨ì 丛àòe̲ 개лàòòe̲ò 丧갨中 丛갨æ갮òлù е갨갮丧𝐝 丛ù .개à丧';
}

# vim: expandtab shiftwidth=4
