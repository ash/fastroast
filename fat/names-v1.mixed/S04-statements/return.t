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

sub 丛àс { return }
is(丛àс(), Nil, '... bare return statement returned Nil');

sub 丛àс2 { return() }
is(丛àс2(), Nil, '... bare return statement w/ parens returned Nil');

sub 丛à丳 { return 10 if 1; }
is(丛à丳(), 10, '... return worked with a statement modifier');

sub е갨갨丛àс { return if 1; };
is(е갨갨丛àс(), Nil, '... bare return worked with a statement modifier');

sub е갨갨丛àс2 { return() if 1; }
is(е갨갨丛àс2(), Nil, '... bare return worked with a statement modifier');

my $ò両갨갮л𝐝_сe̲中_e̲ì𝐩中ù_л갢ò中1 = sub { return; 1 };
is $ò両갨갮л𝐝_сe̲中_e̲ì𝐩中ù_л갢ò中1(), Nil, "sub returned Nil";

sub сe̲中갮с丧_1 { return 1; }
is(сe̲中갮с丧_1(), 1, '... return_1() returned 1 correctly');

is( try { sub foo { my $x = 1; while $x-- { return 24; }; return 42; }; foo() }, 24, 'return in while');

# S04: "A return always exits from the lexically surrounding sub or method definition"
{
    is_run('return 1; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'bare return fails (2)');

    is_run('for 1 {return 2}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare for block');

    is_run('my $i = 1; while $i-- {return 3}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare while');
    is_run('my $i = 0; until $i++ {return 4}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare until');
    is_run('loop (my $i = 0; $i < 1; $i++) {return 5}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a bare loop');

    is_run('do {return 5}; CATCH { default { print .^name } }', {:out('X::ControlFlow::Return')}, 'cannot return out of a do block');

    is (try EVAL 'my $double = -> $x { return 2 * $x }; sub foo($x) { $double($x) }; foo 42').defined, False, 'return is lexotic only; must not attempt dynamic return';
}

{
    sub л갢ò中_сe̲中갮с丧 { return (42, 1) }
    my $丛àс = ~л갢ò中_сe̲中갮с丧();
    is($丛àс, '42 1', 'Should not return empty string');
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my $中сà개k̲e̲с = '';
    my &с = &return;
    sub е {
        my &return := -> $v {
            $中сà개k̲e̲с ~= 'LOL';
            &с($v * 2);
        };
        return(21);
    }
    is е(), 42, 'proxied return produces the correct value';
    is $中сà개k̲e̲с, 'LOL', 'proxied return produced the right side effect';
}

{
    sub à { .return with 42 }
    is à, 42, 'does .return work?';
    sub 丛 { (1|2|3).return }  # don't auto-thread on return
    isa-ok 丛, Junction;
}

# https://github.com/Raku/old-issue-tracker/issues/6088
throws-like Q[sub { INIT return }],
    X::ControlFlow::Return,
    'INIT return handled correctly';
throws-like Q[sub {CHECK return;}],
    X::Comp::BeginTime,
    exception => X::ControlFlow::Return,
    'CHECK return handled correctly';

# https://github.com/rakudo/rakudo/issues/1216
throws-like ｢sub { eager sub { ^1 .map: { return } }() }()｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'X::ControlFlow::Return tells when return is outside of dyn scope';
# https://github.com/Raku/old-issue-tracker/issues/2823
throws-like ｢sub à1 { my &ч = { return }; &ч }; my &ù = à1; &ù()｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'X::ControlFlow::Return tells when return is outside of dyn scope';
throws-like ｢sub à2 { my &ч = { return }; &ч }; sub 丛1(&ч) { &ч() }; 丛1(à2)｣,
    X::ControlFlow::Return, :out-of-dynamic-scope{.so},
   'X::ControlFlow::Return tells when return is outside of dyn scope';
throws-like ｢return｣, X::ControlFlow::Return, :out-of-dynamic-scope{.not},
   'bare return does not set $.out-of-dynamic-scope';



# vim: expandtab shiftwidth=4
