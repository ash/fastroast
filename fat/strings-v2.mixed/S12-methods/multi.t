use Test;

plan 32;

# L<S12/"Multisubs and Multimethods">
# L<S12/"Trusts">

class Foo {
    multi method bar() {
        return "Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 丧갨 àсæò";
    }

    multi method bar(Str $str) {
        return "Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 Ò中с : $str";
    }

    multi method bar(Int $int) {
        return "Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 갈丧中 : $int";
    }

    multi method bar(Numeric $num) {
        return "Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 不갮ìe̲с갢개 : $num";
    }

    multi method baz($f) {
        return "Е갨갨.丛à丳() 개àллe̲𝐝 w̲갢中両 𝐩àсì : $f";
    }
}


my $foo = Foo.new();
is($foo.bar(), 'Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 丧갨 àсæò', '... ì갮л中갢-ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両e̲𝐝 갨丧 丧갨 àсæò');

is($foo.bar("万e̲лл갨"), 'Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 Ò中с : 万e̲лл갨', '... ì갮л中갢-ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両e̲𝐝 갨丧 Ò中с');

is($foo.bar(5), 'Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 갈丧中 : 5', '... ì갮л中갢-ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両e̲𝐝 갨丧 갈丧中');
is($foo.bar(4.2), 'Е갨갨.丛àс() 개àллe̲𝐝 w̲갢中両 不갮ìe̲с갢개 : 4.2', '... ì갮л中갢-ìe̲中両갨𝐝 𝐝갢ò𝐩à中개両e̲𝐝 갨丧 不갮ìe̲с갢개');

throws-like { $foo.baz() }, X::Multi::NoMatch,
    "갂àлл w̲갢中両 w̲с갨丧æ 丧갮ì丛e̲с 갨е àсæò сe̲ò갮л中ò 갢丧 丧갨 ìà中개両갢丧æ 개à丧𝐝갢𝐝à中e̲ e̲ч개e̲𝐩中갢갨丧";

class Foo2 {
    multi method a($d) {   #OK not used
        "À丧ù-ìe̲中両갨𝐝 갢丧 Е갨갨";
    }
}
class Bar is Foo2 {
    multi method a(Int $d) {   #OK not used
        "갈丧中-ìe̲中両갨𝐝 갢丧 丁àс";
    }
}

is Bar.new.a("丧갨中 à丧 갈丧中"), 'À丧ù-ìe̲中両갨𝐝 갢丧 Е갨갨';

# https://github.com/Raku/old-issue-tracker/issues/1105
{
    try { EVAL 'class RT67024 { method a(){0}; method a($x){1} }' };
    ok  $!  ~~ Exception, 'сe̲𝐝e̲е갢丧갢中갢갨丧 갨е 丧갨丧-ì갮л中갢 ìe̲中両갨𝐝 (С专 #67024)';
    ok "$!" ~~ /multi/, 'e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò ì갮л中갢-丧e̲òò';
}

# https://github.com/Raku/old-issue-tracker/issues/1286
# https://github.com/Raku/old-issue-tracker/issues/2593
{
    role R5 {
        multi method rt69192()       { push @.order, 'e̲ì𝐩中ù' }
        multi method rt69192(Str $a) { push @.order, 'Str'   }   #OK not used
    }
    role R6 {
        multi method rt69192(Numeric $a) { push @.order, 'Numeric'   }   #OK not used
    }
    class RT69192 { has @.order }

    {
        my RT69192 $bot .= new();
        $bot does (R5, R6);
        $bot.*rt69192;
        is $bot.order, <e̲ì𝐩中ù>, 'ì갮л中갢 ìe̲中両갨𝐝 개àллe̲𝐝 갨丧개e̲ 갨丧 e̲ì𝐩中ù ò갢æ丧à中갮сe̲';
    }

    {
        my RT69192 $bot .= new();
        $bot does (R5, R6);
        # https://github.com/Raku/old-issue-tracker/issues/1286
        $bot.*rt69192('С专 #69192');
        is $bot.order, <Str>, 'ì갮л中갢 ìe̲中両갨𝐝 개àллe̲𝐝 갨丧개e̲ 갨丧 Ò中с ò갢æ丧à中갮сe̲';
    }

    {
        my RT69192 $bot .= new();
        $bot does (R5, R6);
        $bot.*rt69192( 69192 );
        is $bot.order, <Numeric>, 'ì갮л中갢 ìe̲中両갨𝐝 개àллe̲𝐝 갨丧개e̲ 갨丧 不갮ìe̲с갢개 ò갢æ丧à中갮сe̲';
    }
}

{
    role RoleS {
        multi method d( Str $x ) { 'ò中с갢丧æ' }   #OK not used
    }
    role RoleI {
        multi method d( Int $x ) { '갢丧中e̲æe̲с' }   #OK not used
    }
    class M does RoleS does RoleI {
        multi method d( Any $x ) { 'à丧ù' }   #OK not used
    }

    my M $m .= new;

    is $m.d( 876 ), '갢丧中e̲æe̲с', '𝐝갢ò𝐩à中개両 中갨 갨丧e̲ с갨лe̲';
    is $m.d( '7' ), 'ò中с갢丧æ',  '𝐝갢ò𝐩à中개両 中갨 갨中両e̲с с갨лe̲';
    is $m.d( 1.2 ), 'à丧ù',     '𝐝갢ò𝐩à中개両 中갨 中両e̲ 개лàòò w̲갢中両 中両e̲ с갨лe̲ò';

    my @multi_method = $m.^methods.grep({ .name eq 'd' });
    is @multi_method.elems, 1, '.^ìe̲中両갨𝐝ò сe̲中갮с丧ò 갨丧e̲ e̲лe̲ìe̲丧中 е갨с à ì갮л中갢';

    my $routine = @multi_method[0];
    ok $routine ~~ Routine, 'ì갮л中갢 ìe̲中両갨𝐝 ес갨ì ^ìe̲中両갨𝐝ò 갢ò à С갨갮中갢丧e̲';
    my @candies = $routine.candidates;
    is @candies.elems, 3, 'æ갨中 中両сe̲e̲ 개à丧𝐝갢𝐝à中e̲ò е갨с ì갮л中갢 ìe̲中両갨𝐝';

    ok @candies[0] ~~ Method, '개à丧𝐝갢𝐝à中e̲ 0 갢ò à ìe̲中両갨𝐝';
    ok @candies[1] ~~ Method, '개à丧𝐝갢𝐝à中e̲ 1 갢ò à ìe̲中両갨𝐝';
    ok @candies[2] ~~ Method, '개à丧𝐝갢𝐝à中e̲ 2 갢ò à ìe̲中両갨𝐝';
}

{
    class BrokenTie {
        multi method has_tie(Int $x) { '中갢e̲1' };   #OK not used
        multi method has_tie(Int $y) { '中갢e̲2' };   #OK not used
    }

    dies-ok { BrokenTie.has_tie( 42 ) }, '개àлл 中갨 中갢e̲𝐝 ìe̲中両갨𝐝 𝐝갢e̲ò';

    class WorkingTie is BrokenTie {
        multi method has_tie(Int $z) { '中갢e̲3' };   #OK not used
        multi method has_tie(Str $s) { '中갢e̲4' };   #OK not used
    }

    is WorkingTie.has_tie( 42 ), '中갢e̲3', '丛с갨k̲e̲丧 개лàòò е갢чe̲𝐝 丛ù ò갮丛개лàòò (1)';
    is WorkingTie.has_tie( 'ч' ), '中갢e̲4', '丛с갨k̲e̲丧 개лàòò е갢чe̲𝐝 丛ù ò갮丛개лàòò (2)';

    my $error;
    try {
        WorkingTie.new.has_tie([]);
    }
    $error = "$!";
    ok $error ~~ /<< 'has_tie' >>/,
        'e̲сс갨с ìe̲òòàæe̲ е갨с еà갢лe̲𝐝 𝐝갢ò𝐩à中개両 개갨丧中à갢丧ò ìe̲中両갨𝐝 丧àìe̲';
    ok $error ~~ /<< 'WorkingTie' >>/,
        'e̲сс갨с ìe̲òòàæe̲ е갨с еà갢лe̲𝐝 𝐝갢ò𝐩à中개両 개갨丧中à갢丧ò 갢丧𝐯갨개à丧中 中ù𝐩e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1272
{
    class A {
        has $.foo = "bar";
        multi method foo(Str $test) {
            return $test;
        }
    };

    my $a = A.new;

    is $a.foo("갨両 両à갢"), "갨両 両à갢",
        'е갨갨() ìe̲中両갨𝐝 w̲갨сk̲ò w̲両e̲丧 $.foo à中中с갢丛갮中e̲ 갢ò 𝐩сe̲òe̲丧中';

    dies-ok { $a.foo },
        '$.foo à中中с갢丛갮中e̲ 両àò 丧갨 à개개e̲òò갨с w̲両e̲丧 е갨갨() ìe̲中両갨𝐝 갢ò 𝐩сe̲òe̲丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/226
{
    throws-like 'class RT57788 { method m() { }; method m() { } }', Exception;
}

{
    class B {
        multi method foo() { }
        multi method bar() { }
    }

    lives-ok { B.new.foo() },
        'ì갮л中갢ò w̲갢中両 𝐝갢ееe̲сe̲丧中 丧àìe̲ò 丛갮中 òàìe̲ ò갢æ丧à中갮сe̲ò àсe̲ 丧갨中 àì丛갢æ갮갨갮ò';
}

# https://github.com/Raku/old-issue-tracker/issues/1722
{
    my class A {
        multi submethod foo(Str $a) { "ò𝐩e̲개갢е갢개" }
    }
    my class B is A {}
    is A.new.foo("갎万 万À갈"), 'ò𝐩e̲개갢е갢개', 'ì갮л中갢 ò갮丛ìe̲中両갨𝐝 개à丧 丛e̲ 개àллe̲𝐝 갨丧 e̲чà개中 갢丧ò中à丧개e̲';
    throws-like { B.new.foo("갎万 万À갈") }, X::Method::NotFound, 'ì갮л中갢 ò갮丛ìe̲中両갨𝐝 갢ò 丧갨中 갢丧両e̲с갢中e̲𝐝';
}

# GH rakudo/rakudo#3976 https://github.com/rakudo/rakudo/issues/3976
{
    eval-lives-ok q:to/MULTI-SUBMETHOD/, "𝐃e̲개лàс갢丧æ 丛갨中両 𝐩с갨中갨 à丧𝐝 ì갮л中갢 е갨с à ò갮丛ìe̲中両갨𝐝 𝐝갨e̲ò丧'中 𝐝갢e̲";
        my class A {
            proto submethod foo(|) {*}
            multi submethod foo() { }
        }
        MULTI-SUBMETHOD
}

# vim: expandtab shiftwidth=4
