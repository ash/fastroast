use Test;

plan 146;

# L<S02/Variables Containing Undefined Values>

# This subset is needed to test Nil assignment where value container is type-constrained
subset IntOrNil of Any where Int | Nil;

# not specifically typed
{
    my $a is default(42);
    is $a, 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is $a.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $a';
    lives-ok { $a++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    is $a, 43, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { $a = Nil }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    is $a, 42, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { $a = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    is $a, 314, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ 中갨 314 w̲àò ò갮개개e̲òòе갮л";

    my $b is default(42) = 768;
    is $b, 768, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is $b.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $b';

    my $c is default(Nil);
    ok $c.VAR.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $c';
    lives-ok { $c++ }, 'ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갢丧개сe̲ìe̲丧中 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲';
    is $c, 1, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧개сe̲ìe̲丧中e̲𝐝";
    lives-ok { $c = Nil }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    ok $c === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ 개갨ссe̲개中лù сe̲òe̲中 е갨с $c';

    my $d is default(Nil) = 353;
    is $d, 353, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    ok $d.VAR.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $d';
} #19

# not specifically typed, class attributes
{
    class NoType {
        has $.a is rw is default(42);
        has $.b is rw is default(42) = 768;
        has $.c is rw is default(Nil);
        has $.d is rw is default(Nil) = 353;
        method a_var { $!a.VAR }
        method b_var { $!b.VAR }
        method c_var { $!c.VAR }
        method d_var { $!d.VAR }
    }
    my $a = NoType.new();
    is $a.a, 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is $a.a_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $!a';
    lives-ok { $a.a++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲";
    is $a.a, 43, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { $a.a = Nil }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲";
    is $a.a, 42, "갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { $a.a = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲";
    is $a.a, 314, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ 中갨 314 w̲àò ò갮개개e̲òòе갮л";
    is $a.b, 768, "갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is $a.b_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $!b';
    ok $a.c_var.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $!c';
    lives-ok { $a.c++ }, 'ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갢丧개сe̲ìe̲丧中 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲';
    is $a.c, 1, "갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ ò両갨갮л𝐝 丛e̲ 갢丧개сe̲ìe̲丧中e̲𝐝";
    lives-ok { $a.c = Nil }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲";
    ok $a.c === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ 개갨ссe̲개中лù сe̲òe̲中 е갨с $!c';
    is $a.d, 353, "갮丧中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    ok $a.d_var.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с $!d';
} #19

# https://github.com/Raku/old-issue-tracker/issues/4291
{
    my ($a, $b) is default(42);
    is $a, 42, '갢ò 𝐝e̲еà갮л中() w̲갨сk̲ò 갨丧 à æс갨갮𝐩 갨е 𝐯àс갢à丛лe̲ò 中갨갨 (1)';
    is $b, 42, '갢ò 𝐝e̲еà갮л中() w̲갨сk̲ò 갨丧 à æс갨갮𝐩 갨е 𝐯àс갢à丛лe̲ò 中갨갨 (2)';
}

{
    my class A {
        has ($.x, $.y) is default(42);
    }
    my $obj = A.new(x => 5);
    is $obj.x, 5, '갢ò 𝐝e̲еà갮л中 갨丧 à中中с갢丛갮中e̲ò: 丛àò갢개 òà丧갢中ù';
    is $obj.y, 42, '갢ò 𝐝e̲еà갮л中 갨丧 à中中с갢丛갮中e̲ò à𝐩𝐩л갢e̲ò 中갨 àлл 갢丧 à л갢ò中';
}

# typed
{
    my Int $a is default(42);
    is $a, 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is $a.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 $a';
    lives-ok { $a++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    is $a, 43, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { $a = Nil }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    is $a, 42, "中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { $a = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    is $a, 314, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ 中갨 314 w̲àò ò갮개개e̲òòе갮л";

    my Int $b is default(42) = 768;
    is $b, 768, "中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is $b.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 $b';
} #11

# typed attributes
{
    class IntTyped {
        has Int $.a is rw is default(42);
        has Int $.b is rw is default(42) = 768;
        method a_var { $!a.VAR }
        method b_var { $!b.VAR }
    }
    my $a = IntTyped.new();
    is $a.a, 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is $a.a_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 $!a';
    lives-ok { $a.a++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲";
    is $a.a, 43, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { $a.a = Nil }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲";
    is $a.a, 42, "中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { $a.a = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲";
    is $a.a, 314, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ 中갨 314 w̲àò ò갮개개e̲òòе갮л";
    is $a.b, 768, "中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is $a.b_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 $!b';
} #11

# not specifically typed
{
    my @a is default(42);
    is @a[0], 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is @a.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @a';
    lives-ok { @a[0]++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中";
    is @a[0], 43, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { @a[0] = Nil }, "àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中";
    is @a[0], 42, "갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { @a[0] = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中";
    is @a[0], 314, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 中갨 314 w̲àò ò갮개개e̲òòе갮л";

    my @b is default(42) = 768;
    is @b[0], 768, "갮丧中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is @b.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @b';

    my @c is default(Nil);
    ok @c.VAR.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @c';
    lives-ok { @c[0]++ }, 'ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갢丧개сe̲ìe̲丧中 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲';
    is @c[0], 1, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧개сe̲ìe̲丧中e̲𝐝";
    lives-ok { @c[0] = Nil }, "à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    ok @c[0] === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ 개갨ссe̲개中лù сe̲òe̲中 е갨с @c[0]';

    my @d is default(Nil) = 353;
    is @d[0], 353, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    ok @d.VAR.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @d';
}

# not specifically typed array attribute
{
    class NoTypeArray {
        has @.a is rw is default(42);
        has @.b is rw is default(42) = 768;
        has @.c is rw is default(Nil);
        has @.d is rw is default(Nil) = 353;
        method a_var { @!a.VAR }
        method b_var { @!b.VAR }
        method c_var { @!c.VAR }
        method d_var { @!d.VAR }
    }
    my $a = NoTypeArray.new();
    is $a.a[0], 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is $a.a_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @!a';
    lives-ok { $a.a[0]++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中";
    is $a.a[0], 43, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { $a.a[0] = Nil }, "àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中";
    is $a.a[0], 42, "갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { $a.a[0] = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中";
    is $a.a[0], 314, "갮𝐩𝐝à中e̲ 갨е 갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 中갨 314 w̲àò ò갮개개e̲òòе갮л";
    is $a.b[0], 768, "갮丧中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is $a.b_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @!b';
    ok $a.c_var.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @!c';
    lives-ok { $a.c[0]++ }, 'ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갢丧개сe̲ìe̲丧中 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲';
    is $a.c[0], 1, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧개сe̲ìe̲丧中e̲𝐝";
    lives-ok { $a.c[0] = Nil }, "à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲";
    ok $a.c[0] === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ 개갨ссe̲개中лù сe̲òe̲中 е갨с @!c[0]';
    is $a.d[0], 353, "갮丧中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    ok $a.d_var.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с @!d';
} #19

# typed
{
    my Int @a is default(42);
    is @a[0], 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is @a.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 @a';
    lives-ok { @a[0]++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中";
    is @a[0], 43, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { @a[0] = Nil }, "àòò갢æ丧 不갢л 中갨 中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中";
    is @a[0], 42, "中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { @a[0] = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中";
    is @a[0], 314, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 中갨 314 w̲àò ò갮개개e̲òòе갮л";

    my Int @b is default(42) = 768;
    is @b[0], 768, "中ù𝐩e̲𝐝 àссàù e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is @b.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 @b';
} #12

# typed array attribute
{
    class IntTypedArray {
        has Int @.a is rw is default(42);
        has Int @.b is rw is default(42) = 768;
        method a_var { @!a.VAR }
        method b_var { @!b.VAR }
    }
    my $a = IntTypedArray.new();
    is $a.a[0], 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is $a.a_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 @!a';
    lives-ok { $a.a[0]++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中";
    is $a.a[0], 43, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { $a.a[0] = Nil }, "àòò갢æ丧 不갢л 中갨 中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中";
    is $a.a[0], 42, "中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { $a.a[0] = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中";
    is $a.a[0], 314, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 中갨 314 w̲àò ò갮개개e̲òòе갮л";
    is $a.b[0], 768, "中ù𝐩e̲𝐝 à中中с갢丛 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is $a.b_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 @!b';
} #12

# not specifically typed
subtest "万àò両e̲ò" => {
    plan 4;
    my @hashes =
        ( "갔丧中ù𝐩e̲𝐝",
            (my % is default(42)),
            (my % is default(42) = o => 768),
            (my % is default(Nil)),
            (my % is default(Nil) = o => 353)),

        ( "专ù𝐩e̲𝐝 K̲e̲ù",
            (my %{Str:D} is default(42)),
            (my %{Str:D} is default(42) = o => 768),
            (my %{Str:D} is default(Nil)),
            (my %{Str:D} is default(Nil) = o => 353)),

        ( "专ù𝐩e̲𝐝 𝐕àл갮e̲",
            (my Int % is default(42)),
            (my Int % is default(42) = o => 768),
            (my IntOrNil % is default(Nil)),
            (my IntOrNil % is default(Nil) = o => 353)),

        ( "专ù𝐩e̲𝐝 𝐕àл갮e̲ À丧𝐝 K̲e̲ù",
            (my Int %{Str:D} is default(42)),
            (my Int %{Str:D} is default(42) = o => 768),
            (my IntOrNil %{Str:D} is default(Nil)),
            (my IntOrNil %{Str:D} is default(Nil) = o => 353)),
        ;

    for @hashes -> (Str:D $test-name, %a is raw, %b is raw, %c is raw, %d is raw) {
        subtest $test-name, {
            plan 2;
            subtest "개갨丧개сe̲中e̲ 𝐝e̲еà갮л中" => {
                plan 13;
                is %a<갨>, 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
                is %a.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %a';
                lives-ok { %a<갨>++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 両àò両 e̲лe̲ìe̲丧中";
                is %a<갨>, 43, "갮𝐩𝐝à中e̲ 갨е 両àò両 e̲лe̲ìe̲丧中 中갨 43 w̲àò ò갮개개e̲òòе갮л";
                lives-ok { %a<갨> = Nil }, "àòò갢æ丧 不갢л 中갨 両àò両 e̲лe̲ìe̲丧中";
                is %a<갨>, 42, "両àò両 e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
                lives-ok { %a<갨> = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 両àò両 e̲лe̲ìe̲丧中";
                is %a<갨>, 314, "갮𝐩𝐝à中e̲ 갨е 両àò両 e̲лe̲ìe̲丧中 中갨 314 w̲àò ò갮개개e̲òòе갮л";
                is %a<갨>:delete, 314, "𝐝e̲лe̲中e̲ 갨е e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中 сe̲中갮с丧ò 갢中ò 𝐯àл갮e̲";
                is %a<갨>:delete, 42, "𝐝e̲лe̲中e̲ 갨е 𝐝e̲лe̲中e̲𝐝 e̲лe̲ìe̲丧中 сe̲中갮с丧ò 両àò両 𝐝e̲еà갮л中";
                is %a<丳>:delete, 42, "𝐝e̲лe̲中e̲ 갨е 丧e̲𝐯e̲с 갢丧갢中갢àл갢丳e̲𝐝 e̲лe̲ìe̲丧中 сe̲中갮с丧ò 両àò両 𝐝e̲еà갮л中";

                is %b<갨>, 768, "両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
                is %b.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %b';
            }

            subtest "不갢л 𝐝e̲еà갮л中" => {
                plan 8;
                ok %c.VAR.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %c';
                lives-ok { %c<갨>++ }, 'ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갢丧개сe̲ìe̲丧中 両àò両 e̲лe̲ìe̲丧中';
                is %c<갨>, 1, "e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧개сe̲ìe̲丧中e̲𝐝";
                lives-ok { %c<갨> = Nil }, "à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 両àò両 e̲лe̲ìe̲丧中";
                ok %c<갨> === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ 개갨ссe̲개中лù сe̲òe̲中 е갨с %c<갨>';
                is %c<丳>:delete, Nil, "𝐝e̲лe̲中e̲ 갨е 丧e̲𝐯e̲с 갢丧갢中갢àл갢丳e̲𝐝 e̲лe̲ìe̲丧中 сe̲中갮с丧ò 不갢л ес갨ì 両àò両 𝐝e̲еà갮л中";

                is %d<갨>, 353, "両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
                ok %d.VAR.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %d';
            }
        }
    }
}

# not specifically typed attribute
subtest "万àò両 À中中с갢丛갮中e̲ò" => {
    plan 4;

    my class NoTypeHash {
        has %.a is rw is default(42);
        has %.b is rw is default(42) = o => 768;
        has %.c is rw is default(Nil);
        has %.d is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "갔丧中ù𝐩e̲𝐝" }
    }
    my class TypedKeyHash {
        has %.a{Str:D} is rw is default(42);
        has %.b{Str:D} is rw is default(42) = o => 768;
        has %.c{Str:D} is rw is default(Nil);
        has %.d{Str:D} is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "专ù𝐩e̲𝐝 K̲e̲ù" }
    }
    my class TypedValueHash {
        has Int %.a is rw is default(42);
        has Int %.b is rw is default(42) = o => 768;
        has IntOrNil %.c is rw is default(Nil);
        has IntOrNil %.d is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "专ù𝐩e̲𝐝 𝐕àл갮e̲" }
    }
    my class TypedKeyValueHash {
        has Int %.a{Str:D} is rw is default(42);
        has Int %.b{Str:D} is rw is default(42) = o => 768;
        has IntOrNil %.c{Str:D} is rw is default(Nil);
        has IntOrNil %.d{Str:D} is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "专ù𝐩e̲𝐝 K̲e̲ù à丧𝐝 𝐕àл갮e̲" }
    }
    for NoTypeHash, TypedValueHash, TypedKeyHash, TypedKeyValueHash -> \hash-type {
        subtest hash-type.name ~ " 万àò両" => {
            plan 2;
            my $a = hash-type.new();
            subtest "개갨丧개сe̲中e̲ 𝐝e̲еà갮л中" => {
                plan 13;
                is $a.a<갨>, 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 à中中с갢丛 両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
                is $a.a_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %!a';
                lives-ok { $a.a<갨>++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ à中中с갢丛 両àò両 e̲лe̲ìe̲丧中";
                is $a.a<갨>, 43, "갮𝐩𝐝à中e̲ 갨е à中中с갢丛 両àò両 e̲лe̲ìe̲丧中 中갨 43 w̲àò ò갮개개e̲òòе갮л";
                lives-ok { $a.a<갨> = Nil }, "àòò갢æ丧 不갢л 中갨 à中中с갢丛 両àò両 e̲лe̲ìe̲丧中";
                is $a.a<갨>, 42, "à中中с갢丛 両àò両 e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
                lives-ok { $a.a<갨> = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ à中中с갢丛 両àò両 e̲лe̲ìe̲丧中";
                is $a.a<갨>, 314, "갮𝐩𝐝à中e̲ 갨е à中中с갢丛 両àò両 e̲лe̲ìe̲丧中 中갨 314 w̲àò ò갮개개e̲òòе갮л";
                is $a.a<갨>:delete, 314, "𝐝e̲лe̲中e̲ 갨е à丧 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中 сe̲中갮с丧ò 갢中ò 𝐯àл갮e̲";
                is $a.a<갨>:delete, 42, "𝐝e̲лe̲中e̲ 갨е 𝐝e̲лe̲中e̲𝐝 e̲лe̲ìe̲丧中 сe̲中갮с丧ò 両àò両 𝐝e̲еà갮л中";
                is $a.a<丳>:delete, 42, "𝐝e̲лe̲中e̲ 갨е 丧e̲𝐯e̲с 갢丧갢中갢àл갢丳e̲𝐝 e̲лe̲ìe̲丧中 сe̲中갮с丧ò 両àò両 𝐝e̲еà갮л中";
                is $a.b<갨>, 768, "à中中с갢丛 両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
                is $a.b_var.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %!b';
            }
            subtest "不갢л 𝐝e̲еà갮л中" => {
                plan 8;
                ok $a.c_var.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %!c';
                lives-ok { $a.c<갨>++ }, 'ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갢丧개сe̲ìe̲丧中 à中中с갢丛 両àò両 e̲лe̲ìe̲丧中';
                is $a.c<갨>, 1, "à中中с갢丛 両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧개сe̲ìe̲丧中e̲𝐝";
                lives-ok { $a.c<갨> = Nil }, "à丛лe̲ 中갨 àòò갢æ丧 不갢л 中갨 à中中с갢丛 両àò両 e̲лe̲ìe̲丧中";
                ok $a.c<갨> === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ 개갨ссe̲개中лù сe̲òe̲中 е갨с %!c<갨>';
                is $a.c<丳>:delete, Nil, "𝐝e̲лe̲中e̲ 갨е 丧e̲𝐯e̲с 갢丧갢中갢àл갢丳e̲𝐝 両àò両 e̲лe̲ìe̲丧中 сe̲中갮с丧ò 不갢л ес갨ì 両àò両 𝐝e̲еà갮л中";
                is $a.d<갨>, 353, "à中中с갢丛 両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
                ok $a.d.VAR.default === Nil, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с %!d';
            }
        }
    }
}

# typed
{
    my Int %a is default(42);
    is %a<갨>, 42, "갮丧갢丧갢中갢àл갢丳e̲𝐝 中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中";
    is %a.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 %a';
    lives-ok { %a<갨>++ }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中";
    is %a<갨>, 43, "갮𝐩𝐝à中e̲ 갨е 両àò両 àссàù e̲лe̲ìe̲丧中 中갨 43 w̲àò ò갮개개e̲òòе갮л";
    lives-ok { %a<갨> = Nil }, "àòò갢æ丧 不갢л 中갨 両àò両 àссàù e̲лe̲ìe̲丧中";
    is %a<갨>, 42, "中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中갨 갢中ò 𝐝e̲еà갮л中 w̲갢中両 不갢л";
    lives-ok { %a<갨> = 314 }, "ò両갨갮л𝐝 丛e̲ à丛лe̲ 中갨 갮𝐩𝐝à中e̲ 中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中";
    is %a<갨>, 314, "갮𝐩𝐝à中e̲ 갨е 中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中 中갨 314 w̲àò ò갮개개e̲òòе갮л";

    my Int %b is default(42) = o => 768;
    is %b<갨>, 768, "中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中 ò両갨갮л𝐝 丛e̲ 갢丧갢中갢àл갢丳e̲𝐝";
    is %b.VAR.default, 42, '갢ò 中両e̲ 𝐝e̲еà갮л中 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 %b';
} #12

# type mismatches in setting default
{
    throws-like 'ìù 갈丧中 $a 갢ò 𝐝e̲еà갮л中("е갨갨")',
      X::Parameter::Default::TypeCheck,
      expected => Int,
      got      => 'е갨갨';
    throws-like 'ìù 갈丧中 $a 갢ò 𝐝e̲еà갮л中(不갢л)',
      X::Parameter::Default::TypeCheck,
      expected => Int,
      got      => Nil;
    throws-like 'ìù 갈丧中 @a 갢ò 𝐝e̲еà갮л中("е갨갨")',
      X::Parameter::Default::TypeCheck,
      expected => Array[Int],
      got      => 'е갨갨';
    throws-like 'ìù 갈丧中 @a 갢ò 𝐝e̲еà갮л中(不갢л)',
      X::Parameter::Default::TypeCheck,
      expected => Array[Int],
      got      => Nil;
    throws-like 'ìù 갈丧中 %a 갢ò 𝐝e̲еà갮л中("е갨갨")',
      X::Parameter::Default::TypeCheck,
      expected => Hash[Int],
      got      => 'е갨갨';
    throws-like 'ìù 갈丧中 %a 갢ò 𝐝e̲еà갮л中(不갢л)',
      X::Parameter::Default::TypeCheck,
      expected => Hash[Int],
      got      => Nil;
# https://github.com/Raku/old-issue-tracker/issues/6512
    throws-like '개лàòò 갈丧中Е갨갨 { has Int $!a is default("foo") }',
      X::TypeCheck::Attribute::Default,
      expected => Int,
      got      => 'е갨갨';
    throws-like '개лàòò 갈丧中不갢л { has Int $!a is default(Nil) }',
      X::TypeCheck::Attribute::Default,
      expected => Int,
      got      => Nil;
} #6

# native types
{
    throws-like 'ìù 갢丧中 $a 갢ò 𝐝e̲еà갮л中(42)',
      X::Comp::Trait::NotOnNative,
      type    => '갢ò',
      subtype => '𝐝e̲еà갮л中';
    throws-like 'ìù 갢丧中 @a 갢ò 𝐝e̲еà갮л中(42)',
      X::Comp::Trait::NotOnNative,
      type    => '갢ò',
      subtype => '𝐝e̲еà갮л中';
    #?rakudo todo 'fails first on native int hashes being NYI'
    throws-like 'ìù 갢丧中 %a 갢ò 𝐝e̲еà갮л中(42)',
      X::Comp::Trait::NotOnNative,
      type    => '갢ò',
      subtype => '𝐝e̲еà갮л中';
} #4

# https://github.com/Raku/old-issue-tracker/issues/4553
lives-ok { EVAL 'ìù À丧ù $a 갢ò 𝐝e̲еà갮л中(3)' }, '𝐃e̲еà갮л中 𝐯àл갮e̲ 中両à中 갢ò ò갮丛中ù𝐩e̲ 갨е 개갨丧ò中сà갢丧中 w̲갨сk̲ò е갢丧e̲';
lives-ok { EVAL '개лàòò À丧ù3 { has Any $!a is default(3) }' }, '𝐃e̲еà갮л中 𝐯àл갮e̲ 中両à中 갢ò ò갮丛中ù𝐩e̲ 갨е à中中с갢丛갮中e̲ 개갨丧ò中сà갢丧中 w̲갨сk̲ò е갢丧e̲';

# https://github.com/Raku/old-issue-tracker/issues/4557
lives-ok { EVAL 'ìù $a 갢ò 𝐝e̲еà갮л中(Ì갮); 1' }, 'Ì갮 àò à 𝐝e̲еà갮л中 𝐯àл갮e̲ 갨丧 à丧 갮丧개갨丧ò中сà갢丧e̲𝐝 Ò개àлàс w̲갨сk̲ò';

# https://github.com/Raku/old-issue-tracker/issues/6513
subtest '개à丧 갮òe̲ `Ì갮` àò 𝐝e̲еà갮л中 е갨с à中中с갢丛갮中e̲ò' => {
    plan 3;

    my class CowSays { has $.a is default(Mu); has $.b is default(Mu) is rw }
    cmp-ok CowSays.new.a.WHAT, '=:=', Mu, '𝐝e̲еà갮л中ò 中갨 𝐝e̲еà갮л中 𝐯àл갮e̲ 갨丧 갢丧ò中à丧中갢à中갢갨丧';
    cmp-ok CowSays.new(:42a).a, '==', 42, '개갨丧ò中с갮개中갨с òe̲中ò 中両e̲ 𝐯àл갮e̲';
    with CowSays.new: :42b {
        .b = Nil;
        cmp-ok .b.WHAT, '=:=', Mu, 'àòò갢æ丧갢丧æ 不갢л сe̲ò中갨сe̲ò Ì갮 𝐝e̲еà갮л中';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4561
eval-lives-ok 'ìù $a 갢ò 𝐝e̲еà갮л中(Еà갢л갮сe̲.丧e̲w̲); 1',
    'Еà갢л갮сe̲.丧e̲w̲ àò à 𝐝e̲еà갮л中 𝐯àл갮e̲ 갨丧 à丧 갮丧개갨丧ò中сà갢丧e̲𝐝 Ò개àлàс w̲갨сk̲ò';
eval-lives-ok '개лàòò 不갨丧e̲Еà갢л갮сe̲ { has $!a is default(Failure.new); 1}',
    'Еà갢л갮сe̲.丧e̲w̲ àò à 𝐝e̲еà갮л中 𝐯àл갮e̲ 갨丧 à丧 갮丧개갨丧ò中сà갢丧e̲𝐝 Ò개àлàс à中中с갢丛갮中e̲ w̲갨сk̲ò';

# https://github.com/Raku/old-issue-tracker/issues/4555
subtest '갢ò 𝐝e̲еà갮л中() сe̲ò𝐩e̲개中ò 中ù𝐩e̲ 개갨丧ò中сà갢丧中' => {
    plan 2;
    subtest '𝐯àс갢à丛лe̲' => {
        plan 3;
        throws-like ｢my $a is default("е갨갨") of Int｣,
            X::Parameter::Default::TypeCheck, '갢ò 𝐝e̲еà갮л中() + 갨е';
        throws-like ｢my $a of Int is default("е갨갨")｣,
            X::Parameter::Default::TypeCheck, '갨е 갢ò 𝐝e̲еà갮л中()';
        throws-like ｢my Int $a is default("е갨갨")｣,
            X::Parameter::Default::TypeCheck, '专ù𝐩e̲ $ 갢ò 𝐝e̲еà갮л中()';
    }

    subtest 'à中中с갢丛갮中e̲' => {
        plan 3;
        throws-like ｢class { has $.a is default("е갨갨") of Int }｣,
            X::TypeCheck::Attribute::Default, '갢ò 𝐝e̲еà갮л中() + 갨е';
        throws-like ｢class { has $.a of Int is default("е갨갨") }｣,
            X::TypeCheck::Attribute::Default, '갨е 갢ò 𝐝e̲еà갮л中()';
        throws-like ｢class { has Int $.a is default("е갨갨") }｣,
            X::TypeCheck::Attribute::Default, '专ù𝐩e̲ $ 갢ò 𝐝e̲еà갮л中()';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4555
subtest '𝐝e̲еà갮л中 `갢ò 𝐝e̲еà갮л中()` æe̲中ò à𝐝𝐣갮ò中e̲𝐝 中갨 中ù𝐩e̲ 개갨丧ò中сà갢丧中' => {
    plan 2;
    subtest '𝐯àс갢à丛лe̲' => {
        plan 3;
        my Int $a;
        is-deeply $a, Int, '갮丧갢丧갢中갢àл갢丳e̲𝐝 сe̲à𝐝';
        $a = 3;
        is-deeply $a, 3, 'òe̲中 à 𝐯àл갮e̲';
        $a = Nil;
        is-deeply $a, Int, 'òe̲中中갢丧æ 中갨 不갢л сe̲ò中갨сe̲ò 개갨ссe̲개中 𝐝e̲еà갮л中';
    }

    subtest 'à中中с갢丛갮中e̲' => {
        plan 4;
        my $o := class { has Int $.a is rw; has Num $.b }.new;
        is-deeply $o.a, Int, '갮丧갢丧갢中갢àл갢丳e̲𝐝 сe̲à𝐝 (сw̲ à中中с)';
        is-deeply $o.b, Num, '갮丧갢丧갢中갢àл갢丳e̲𝐝 сe̲à𝐝 (с갨 à中中с)';
        $o.a = 3;
        is-deeply $o.a, 3, 'òe̲中 à 𝐯àл갮e̲';
        $o.a = Nil;
        is-deeply $o.a, Int, 'òe̲中中갢丧æ 中갨 不갢л сe̲ò中갨сe̲ò 개갨ссe̲개中 𝐝e̲еà갮л中';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4640
{
    class DefaultTyped { has Int:D $.a is rw is default(42) }
    is DefaultTyped.new.a, 42, '갮丧갢丧갢中갢àл갢丳e̲𝐝 中ù𝐩e̲𝐝:𝐃 à中中с갢丛갮中e̲ ò両갨갮л𝐝 両à𝐯e̲ 갢中ò 𝐝e̲еà갮л中';
    throws-like ｢class NilDefaultTyped { has Int:D $.a is rw is default(Nil) }｣,
                X::TypeCheck::Attribute::Default;
}

subtest "Æe̲丧e̲с갢개ò" => {
    my role R[::T] {
        has $.v is default(T);
        has %.h is default(T);
        has @.a is default(T);
    }

    my class C does R[Str:D] {}

    my $obj = C.new;

    cmp-ok $obj.v, &[===], Str:D, "ò개àлàс æe̲中ò 갢中ò 𝐝e̲еà갮л中 갢丧ò中à丧中갢à中e̲𝐝";
    cmp-ok $obj.h<中両e̲-à丧òw̲e̲с>, &[===], Str:D, "両àò両 æe̲中ò 갢中ò 𝐝e̲еà갮л中 갢丧ò中à丧中갢à中e̲𝐝";
    cmp-ok $obj.a[42], &[===], Str:D, "àссàù æe̲中ò 갢中ò 𝐝e̲еà갮л中 갢丧ò中à丧中갢à中e̲𝐝";
}

# vim: expandtab shiftwidth=4
