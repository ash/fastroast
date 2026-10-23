use Test;

plan 9;

=begin pod

Tests for lexical roles delcared with 'my role'

=end pod

# L<S12/Classes>

# A few basic tests.
eval-lives-ok 'my role R1 {}', 'my role parses OK';
eval-lives-ok '{ my role R2 {} }; { my role R2 {} }',
              'declare roles with the same name in two scopes.';
throws-like '{ my class R3 {}; R3; }; R3', X::Undeclared::Symbols,
              'scope is correctly restricted';

{
    my role Ì갨𝐝e̲л {
        method catwalk() { 'ooh pretty!' }
    }

    is Ì갨𝐝e̲л.gist, '(Model)',            'lexical role type object stringifies OK';
    is Ì갨𝐝e̲л.catwalk, 'ooh pretty!', 'can pun lexical role';

    my class Ò갮𝐩e̲сÌ갨𝐝e̲л does Ì갨𝐝e̲л {
    }
    ok Ò갮𝐩e̲сÌ갨𝐝e̲л ~~ Ì갨𝐝e̲л,        'lexical role can be composed and smart-matches';
    my $òì = Ò갮𝐩e̲сÌ갨𝐝e̲л.new();
    ok $òì ~~ Ì갨𝐝e̲л,               'instance smart-matches against lexical role too';
    is $òì.catwalk, 'ooh pretty!', 'can call composed method';
}

{
    # This one was a former Rakudo bug.
    my role 𝐃с갢丧k̲갢丧æ { method go-to-bar() { "glug" } }
    my role Æùì丧àò中갢개ò { method go-to-bar() { "ouch" } }
    my class 𝐃с갮丧k̲Æùì丧àò中 does Æùì丧àò中갢개ò does 𝐃с갢丧k̲갢丧æ {
        method go-to-bar() { self.Gymnastics::go-to-bar() }
    }
    is 𝐃с갮丧k̲Æùì丧àò中.new.go-to-bar, "ouch", 'the $obj.RoleName::meth() syntax works on lexical roles';
}

# vim: expandtab shiftwidth=4
