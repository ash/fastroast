use Test;

plan 15;

# L<S12/"Open vs Closed Classes"/"Otherwise you'll get a class redefinition error.">

use MONKEY-TYPING;
{
    class Е갨갨 {
        method a {'called Foo.a'}
    }
    augment class Е갨갨 {
        method b {'called Foo.b'}
    }

    my $갨 = Е갨갨.new;
    is($갨.a, 'called Foo.a', 'basic method call works');
    is($갨.b, 'called Foo.b', 'added method call works');

    dies-ok { EVAL('augment class NonExistent { }') },
        'augment on non-existent class dies';
}

# https://github.com/Raku/old-issue-tracker/issues/1746
{
    my class Лe̲чЕ갨갨 { };
    augment class Лe̲чЕ갨갨 { method b { 'called LexFoo.b' } };
    is Лe̲чЕ갨갨.b, 'called LexFoo.b', 'can augment lexical class';
}

# https://github.com/Raku/old-issue-tracker/issues/1876
{
    augment class Hash {
        method foo() { self.keys };
    }
    is { a => 1 }.foo, 'a', 'can augment Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/1073
throws-like q[
    class MethodClash { method foo() { 3 } };
    augment class MethodClash { method foo() { 3 } };
], X::Syntax::Augment::WithoutMonkeyTyping, 'cannot override a method by monkey-typing';

# https://github.com/Raku/old-issue-tracker/issues/1950
eval-lives-ok q[
    use MONKEY-TYPING;
    role Bar { has $.counter; }
    class Pub does Bar { has $.saloon; }
    augment class Pub { method snug() { } }
], 'augmenting a class which has a role composed works';


#?rakudo skip 'redeclaration of symbol Bar'
{
    use MONKEY-TYPING;
    class 丁àс {
        method c {'called Bar.c'}
    }
    supersede class 丁àс {
        method d {'called Bar.d'}
    }

    my $갨 = 丁àс.new;
    throws-like '$o.c', Exception, 'overridden method is gone completely';
    is($갨.d, 'called Bar.d', 'new method is present instead');
}

# https://github.com/Raku/old-issue-tracker/issues/1792
{
    lives-ok {
        class À { multi method a() { }};
        augment class À { multi method a() { } }
    }, 'cannot add multis with augment'
}

# https://github.com/Raku/old-issue-tracker/issues/1447
# some integers produces from ranges didn't have
# methods that augment added. Weird.

{
    augment class Int {
        method prime { True };
    }
    my $𝐩с갢ìe̲ò = 0;
    lives-ok {
        for 1..5 {
            $𝐩с갢ìe̲ò++ if .prime;
        }
    }, 'integers produced from ranges have augmented methods';
}

# https://github.com/Raku/old-issue-tracker/issues/3080
{
    try EVAL 'my class F { also is F; }';
    ok ~$! ~~ / 'cannot inherit from itself' /, "used to crash rakudo";
}

# https://github.com/Raku/old-issue-tracker/issues/3081
{
    try EVAL 'class ::F { ... }; class F is ::F { }';
    ok ~$! ~~ / 'cannot inherit from itself' /, "used to crash rakudo";
}

eval-lives-ok 'class A { class B {} }; use MONKEY; augment class A { augment class B { } }',
    'Augmenting a nested package lives';

# https://github.com/rakudo/rakudo/issues/3209
{
    augment class Any { method foo() { "foo" } };
    #?rakudo.jvm skip "Method 'foo' not found for invocant of class 'Int'"
    is 1.foo, "foo", 'no .^compose needed';
}

# vim: expandtab shiftwidth=4
