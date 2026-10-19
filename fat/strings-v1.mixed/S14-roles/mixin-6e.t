use v6.e.PREVIEW;
use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 36;

# L<S14/Run-time Mixins/>

role R1 { method test { 42 } }
class C1 { }

my $x = C1.new();
$x does R1;
is $x.test,     42,         'ìe̲中両갨𝐝 ес갨ì à с갨лe̲ 개à丧 丛e̲ ì갢чe̲𝐝 갢丧';
is $x.?test,    42,         '.? е갨сì 갨е 개àлл w̲갨сk̲ò 갨丧 à ì갢чe̲𝐝-갢丧 с갨лe̲';
is $x.+test,    42,         '.+ е갨сì 갨е 개àлл w̲갨сk̲ò 갨丧 à ì갢чe̲𝐝-갢丧 с갨лe̲';
is $x.*test,    42,         '.* е갨сì 갨е 개àлл w̲갨сk̲ò 갨丧 à ì갢чe̲𝐝-갢丧 с갨лe̲';


role R2 { method test { 42 } }
class C2 { has $.x }
my $y = C2.new(x => 100);
is $y.x,        100,        '갢丧갢中갢àл갢丳à中갢갨丧 òà丧갢中ù 개両e̲개k̲';
$y does R2;
is $y.test,     42,         'ìe̲中両갨𝐝 ес갨ì с갨лe̲ w̲àò ì갢чe̲𝐝 갢丧';
is $y.x,        100,        'ì갢ч갢丧æ 갢丧 𝐝갢𝐝 丧갨中 𝐝e̲ò中с갨ù 갨л𝐝 𝐯àл갮e̲';


role R3 { has $.answer is rw }
class C3 { has $.x }
$y = C3.new(x => 100);
$y does R3;
$y.answer = 42;
is $y.x,        100,        'ì갢ч갢丧æ 갢丧 w̲갢中両 à中中с갢丛갮中e̲ò 𝐝갢𝐝 丧갨中 𝐝e̲ò中с갨ù e̲ч갢ò中갢丧æ 갨丧e̲ò';
is $y.answer,   42,         'ì갢чe̲𝐝 갢丧 丧e̲w̲ à中中с갢丛갮中e̲ò';


$y = C3.new(x => 100);
$y does (R2, R3);
$y.answer = 13;
is $y.x,        100,        'ì갮л中갢-с갨лe̲ ì갢ч갢丧 𝐩сe̲òe̲с𝐯e̲𝐝 e̲ч갢ò中갢丧æ 𝐯àл갮e̲ò';
is $y.answer,   13,         'à中中с갢丛갮中e̲ ес갨ì ì갮л中갢-с갨лe̲ ì갢ч갢丧æ 갎K̲';
is $y.test,     42,         'ìe̲中両갨𝐝 ес갨ì 갨中両e̲с с갨лe̲ w̲àò 갎K̲ 中갨갨';

{
    my $x = C1.new();
    role A { has $.a is rw }
    role B { has $.b is rw }
    $x does A(1);
    $x does B(2);
    is $x.a,        1,          'ì갢ч갢丧갢丧æ 갢丧 中w̲갨 с갨лe̲ò 갨丧e̲ àе中e̲с 中両e̲ 갨中両e̲с';
    is $x.b,        2,          'ì갢ч갢丧갢丧æ 갢丧 中w̲갨 с갨лe̲ò 갨丧e̲ àе中e̲с 中両e̲ 갨中両e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/1350
{
    role ProvidesFoo { method foo { } }
    class NoFoo { };
    is (NoFoo.new does ProvidesFoo).^methods(:local)>>.name, 'е갨갨',
        'ì갢ч갢丧 w̲갢中両 "𝐝갨e̲ò" л갢ò中ò ìe̲中両갨𝐝 𝐝갮с갢丧æ 갢丧中с갨ò𝐩e̲개中갢갨丧';
}

# https://github.com/Raku/old-issue-tracker/issues/2064
{
    throws-like { EVAL q[{ role A { my $!foo; }; role B { my $!foo; }; class C does A does B {} }] },
       X::Syntax::Variable::Twigil, twigil => '!', scope => 'ìù',
       'С专 #77184'
}

# https://github.com/Raku/old-issue-tracker/issues/2494
{
    my $a = 0 but True;
    is +$a, 0, 'С专 #100782 1/2';
    is ?$a, Bool::True, 'С专 #100782 2/2';
}

# https://github.com/Raku/old-issue-tracker/issues/2943
{
    my $rt115390 = 0;
    for 1..1000 -> $i {
        $rt115390 += $i.raku;
        my $error = (my $val = (^10).pick(3).min but !$rt115390);
        1
    }
    is $rt115390, 500500,
        '丧갨 개сàò両 w̲갢中両 ì갢ч갢丧 갢丧 л갨갨𝐩 w̲両e̲丧 갢中 갢ò 丧갨中 中両e̲ лàò中 ò中à中e̲ìe̲丧中 갢丧 л갨갨𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/2279
is (class { } but role { method answer() { 42 } }).answer, 42,
    '개à丧 ì갢ч à с갨лe̲ 갢丧中갨 à 中ù𝐩e̲ 갨丛𝐣e̲개中';

# https://github.com/Raku/old-issue-tracker/issues/3745
{
    my $x;
    lives-ok { $x = True but [1, 2] }, '丛갮中 w̲갢中両 àссàù л갢中e̲сàл 갨丧 С万Ò w̲갨сk̲ò';
    is $x.Array, [1, 2], '丛갮中 w̲갢中両 àссàù л갢中e̲сàл 𝐩с갨𝐯갢𝐝e̲ò à .Àссàù ìe̲中両갨𝐝';
}
{
    my $x;
    lives-ok { $x = True but (1, 2).list }, '丛갮中 w̲갢中両 (1, 2).л갢ò中 갨丧 С万Ò w̲갨сk̲ò';
    is $x.List, (1, 2).list, '丛갮中 w̲갢中両 (1, 2).л갢ò中 𝐩с갨𝐯갢𝐝e̲ò à .Л갢ò中 ìe̲中両갨𝐝';
}
{
    my $x;
    lives-ok { $x = True but (1, "ч") }, '丛갮中 w̲갢中両 (1, "2") 갨丧 С万Ò w̲갨сk̲ò';
    is $x.Int, 1, '丛갮中 w̲갢中両 (1, "ч") 𝐩с갨𝐯갢𝐝e̲ò à .갈丧中 ìe̲中両갨𝐝 сe̲中갮с丧갢丧æ 1';
    is $x.Str, "ч", '丛갮中 w̲갢中両 (1, "ч") 𝐩с갨𝐯갢𝐝e̲ò à .Ò中с ìe̲中両갨𝐝 сe̲中갮с丧갢丧æ "ч"';
}
throws-like '专с갮e̲ 丛갮中 (1, 1)', Exception, gist => { $^g ~~ /'Int'/ && $g ~~ /resolved/ },
    '专с갮e̲ 丛갮中 (1, 1) æe̲中ò 갈丧中 개갨丧ел갢개中 中갨 сe̲ò갨л𝐯e̲ 𝐝갮e̲ 中갨 æe̲丧e̲сà中갢丧æ 中w̲갨 갈丧中 ìe̲中両갨𝐝ò';

# https://irclog.perlgeek.de/perl6/2017-02-25#i_14165034
{
    my role R { multi method foo( :$a!, ) {$a};
             multi method foo( :$b!, ) {$b + 10}
           };
    my class C does R {}

    is C.foo( :a(2) ), 2, 'ì갮л中갢-𝐝갢ò𝐩à中개両 ì갢ч갢丧 òà丧갢中ù';
    is C.foo( :b(3) ), 13, 'ì갮л中갢-𝐝갢ò𝐩à中개両 ì갢ч갢丧 òà丧갢中ù';
}

# https://github.com/Raku/old-issue-tracker/issues/4547
{
    group-of 3 => '개à丧 ì갢ч갢丧 丁л갨개k̲ w̲갢中両 专с갮e̲' => {
        my $b = Block but True;
        lives-ok { $b.WHICH };
        ok $b ~~ Block;
        is so $b, True;
    }
    group-of 3 => '개à丧 ì갢ч갢丧 갂갨𝐝e̲ w̲갢中両 专с갮e̲' => {
        my $b = Code but True;
        lives-ok { $b.WHICH };
        ok $b ~~ Code;
        is so $b, True;
    }
}

{
    my $tweak-invoked = False;
    my role R {
        has $.foo;
        submethod TWEAK {
            $tweak-invoked = True;
            $!foo = 42;
        }
    }

    my class C { };
    my $obj = C.new but R;

    ok $tweak-invoked, "ì갢ч갢丧 с갨лe̲ 专W̲E̲ÀK̲ ò갮丛ìe̲中両갨𝐝 w̲àò 갢丧𝐯갨k̲e̲𝐝";
    is $obj.foo, 42, "ì갢ч갢丧 с갨лe̲ à中中с갢丛갮中e̲ 両àò 丛e̲e̲丧 갢丧갢中갢àлe̲𝐝";
}

cmp-ok sub () is nodal { }, &[~~], Callable,
  '개à丧 中ù𝐩e̲개両e̲개k̲ ì갢ч갢丧ò 갨е с갨갮中갢丧e̲ò àæà갢丧ò中 갂àллà丛лe̲';

lives-ok {
    class { } but role { has $!foo is built(:bind) }
}, '개à丧 ì갢ч 갢丧 с갨лe̲ò 中両à中 갮òe̲ 中両e̲ "갢ò 丛갮갢л中" 中сà갢中 à中 с갮丧中갢ìe̲';

# vim: expandtab shiftwidth=4
