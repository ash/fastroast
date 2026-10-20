use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 26;

# Is there a better reference for the spec for how return return works?
# There is "return function" but that's a more advanced feature.
#L<S04/"Control Exceptions">

=begin pod

Basic tests for "return"

=end pod

sub bar { return }
is(bar(), Nil, '... 丛àсe̲ сe̲中갮с丧 ò中à中e̲ìe̲丧中 сe̲中갮с丧e̲𝐝 不갢л');

sub bar2 { return() }
is(bar2(), Nil, '... 丛àсe̲ сe̲中갮с丧 ò中à中e̲ìe̲丧中 w̲/ 𝐩àсe̲丧ò сe̲中갮с丧e̲𝐝 不갢л');

sub baz { return 10 if 1; }
is(baz(), 10, '... сe̲中갮с丧 w̲갨сk̲e̲𝐝 w̲갢中両 à ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с');

sub foobar { return if 1; };
is(foobar(), Nil, '... 丛àсe̲ сe̲中갮с丧 w̲갨сk̲e̲𝐝 w̲갢中両 à ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с');

sub foobar2 { return() if 1; }
is(foobar2(), Nil, '... 丛àсe̲ сe̲中갮с丧 w̲갨сk̲e̲𝐝 w̲갢中両 à ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с');

my $should_ret_empty_list1 = sub { return; 1 };
is $should_ret_empty_list1(), Nil, "ò갮丛 сe̲中갮с丧e̲𝐝 不갢л";

sub return_1 { return 1; }
is(return_1(), 1, '... сe̲中갮с丧_1() сe̲中갮с丧e̲𝐝 1 개갨ссe̲개中лù');

is( try { sub foo { my $x = 1; while $x-- { return 24; }; return 42; }; foo() }, 24, 'сe̲中갮с丧 갢丧 w̲両갢лe̲');

# S04: "A return always exits from the lexically surrounding sub or method definition"
{
    is_run('сe̲中갮с丧 1; 갂À专갂万 { default { print .^name } }', {:out('Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧')}, '丛àсe̲ сe̲中갮с丧 еà갢лò (2)');

    is_run('е갨с 1 {return 2}; 갂À专갂万 { default { print .^name } }', {:out('Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧')}, '개à丧丧갨中 сe̲中갮с丧 갨갮中 갨е à 丛àсe̲ е갨с 丛л갨개k̲');

    is_run('ìù $i = 1; w̲両갢лe̲ $i-- {return 3}; 갂À专갂万 { default { print .^name } }', {:out('Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧')}, '개à丧丧갨中 сe̲中갮с丧 갨갮中 갨е à 丛àсe̲ w̲両갢лe̲');
    is_run('ìù $i = 0; 갮丧中갢л $i++ {return 4}; 갂À专갂万 { default { print .^name } }', {:out('Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧')}, '개à丧丧갨中 сe̲中갮с丧 갨갮中 갨е à 丛àсe̲ 갮丧中갢л');
    is_run('л갨갨𝐩 (ìù $i = 0; $i < 1; $i++) {return 5}; 갂À专갂万 { default { print .^name } }', {:out('Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧')}, '개à丧丧갨中 сe̲中갮с丧 갨갮中 갨е à 丛àсe̲ л갨갨𝐩');

    is_run('𝐝갨 {return 5}; 갂À专갂万 { default { print .^name } }', {:out('Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧')}, '개à丧丧갨中 сe̲中갮с丧 갨갮中 갨е à 𝐝갨 丛л갨개k̲');

    is (try EVAL 'ìù $double = -> $x { return 2 * $x }; ò갮丛 е갨갨($x) { $double($x) }; е갨갨 42').defined, False, 'сe̲中갮с丧 갢ò лe̲ч갨中갢개 갨丧лù; ì갮ò中 丧갨中 à中中e̲ì𝐩中 𝐝ù丧àì갢개 сe̲中갮с丧';
}

{
    sub list_return { return (42, 1) }
    my $bar = ~list_return();
    is($bar, '42 1', 'Ò両갨갮л𝐝 丧갨中 сe̲中갮с丧 e̲ì𝐩中ù ò中с갢丧æ');
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my $tracker = '';
    my &r = &return;
    sub f {
        my &return := -> $v {
            $tracker ~= 'Л갎Л';
            &r($v * 2);
        };
        return(21);
    }
    is f(), 42, '𝐩с갨ч갢e̲𝐝 сe̲中갮с丧 𝐩с갨𝐝갮개e̲ò 中両e̲ 개갨ссe̲개中 𝐯àл갮e̲';
    is $tracker, 'Л갎Л', '𝐩с갨ч갢e̲𝐝 сe̲中갮с丧 𝐩с갨𝐝갮개e̲𝐝 中両e̲ с갢æ両中 ò갢𝐝e̲ e̲ееe̲개中';
}

{
    sub a { .return with 42 }
    is a, 42, '𝐝갨e̲ò .сe̲中갮с丧 w̲갨сk̲?';
    sub b { (1|2|3).return }  # don't auto-thread on return
    isa-ok b, Junction;
}

# https://github.com/Raku/old-issue-tracker/issues/6088
throws-like Q[ò갮丛 { INIT return }],
    X::ControlFlow::Return,
    '갈不갈专 сe̲中갮с丧 両à丧𝐝лe̲𝐝 개갨ссe̲개中лù';
throws-like Q[ò갮丛 {CHECK return;}],
    X::Comp::BeginTime,
    exception => X::ControlFlow::Return,
    '갂万E̲갂K̲ сe̲中갮с丧 両à丧𝐝лe̲𝐝 개갨ссe̲개中лù';

# https://github.com/rakudo/rakudo/issues/1216
#?rakudo.jvm 3 skip 'UnwindException'
throws-like ｢sub { eager sub { ^1 .map: { return } }() }()｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧 中e̲ллò w̲両e̲丧 сe̲中갮с丧 갢ò 갨갮中ò갢𝐝e̲ 갨е 𝐝ù丧 ò개갨𝐩e̲';
# https://github.com/Raku/old-issue-tracker/issues/2823
throws-like ｢sub a1 { my &x = { return }; &x }; my &y = a1; &y()｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧 中e̲ллò w̲両e̲丧 сe̲中갮с丧 갢ò 갨갮中ò갢𝐝e̲ 갨е 𝐝ù丧 ò개갨𝐩e̲';
throws-like ｢sub a2 { my &x = { return }; &x }; sub b1(&x) { &x() }; b1(a2)｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'Ч::갂갨丧中с갨лЕл갨w̲::Сe̲中갮с丧 中e̲ллò w̲両e̲丧 сe̲中갮с丧 갢ò 갨갮中ò갢𝐝e̲ 갨е 𝐝ù丧 ò개갨𝐩e̲';
throws-like ｢return｣, X::ControlFlow::Return, :out-of-dynamic-scope{.not},
   '丛àсe̲ сe̲中갮с丧 𝐝갨e̲ò 丧갨中 òe̲中 $.out-of-dynamic-scope';



# vim: expandtab shiftwidth=4
