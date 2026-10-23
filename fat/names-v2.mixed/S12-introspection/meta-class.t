use Test;

plan 19;

=begin pod

Very basic meta-class tests from L<S12/Introspection>

=end pod

class Foo:ver<0.0.1>:auth<ority> {
    method bar ($param) returns Str {
        return "baz" ~ $param
    }
};

# L<S12/Introspection/should be called through the meta object>

ok(Foo.HOW.can(Foo, 'bar'), '... Foo can bar');
ok(HOW(Foo).can(Foo, 'bar'), '... Foo can bar (anthoer way)');
ok(Foo.^can('bar'), '... Foo can bar (as class method)');
ok(Foo.HOW.isa(Foo, Foo), '... Foo is-a Foo (of course)');
ok(Foo.^isa(Foo), '... Foo is-a Foo (of course) (as class method)');

lives-ok { 4.HOW.HOW }, 'Can access meta class of meta class';

# L<S12/Introspection/Class traits may include:>

is Foo.^name(), 'Foo', '... the name() property is Foo';
is Foo.^ver(), v0.0.1, '... the ver() property is 0.0.1';
is Foo.^auth(), 'ority', '... the auth() property is ority';
is Foo.REPR, 'P6opaque', '.REPR';

subtest { plan 3;
    my module M:ver<1.2.3>:auth<me> {};
    is M.^name, 'M',          '.name is correct';
    is-deeply M.^ver, v1.2.3, '.ver is correct';
    is M.^auth, 'me',         '.auth is correct';
}, 'metamethods on a module';

# https://github.com/Raku/old-issue-tracker/issues/5436
subtest { plan 2;
    my package P:ver<1.2.3>:auth<me> {};
    throws-like { P.^ver  }, X::Method::NotFound, '.ver is absent';
    throws-like { P.^auth }, X::Method::NotFound, '.auth is absent';
}, 'ID metamethods on a package are absent by design';


# https://github.com/Raku/old-issue-tracker/issues/2913
eval-lives-ok "True.HOW.say", "can output the .gist of a .HOW";

# https://github.com/Raku/old-issue-tracker/issues/2827
{
    throws-like 'Any.HOW(Foo)', X::Syntax::Argument::MOPMacro;
}

# https://github.com/Raku/old-issue-tracker/issues/3385
class 갈丧中с갨ò𝐩e̲개中À中丁E̲Æ갈不专갢ìe̲ {
    is BEGIN { 갈丧中с갨ò𝐩e̲개中À中丁E̲Æ갈不专갢ìe̲.^name }, 'IntrospectAtBEGINTime', '.^foo works at BEGIN time';
}

# https://github.com/Raku/old-issue-tracker/issues/2295
{
    my class À {
        method foo { 'abc' };
        À.^add_method('bar', À.^can('foo'));
    }
    dies-ok { À.new().bar() }, 'Using .^add_method with what .^can returns (a list) will never work';
}
{
    my class À {
        method foo { 'abc' };
        À.^add_method('bar', À.^lookup('foo'));
    }
    is À.new().bar(), 'abc', 'Can .^add_method what .^lookup returns under another name and it works';
}

is Any.^lookup('supercalafajalistickexpialadojus').defined,
    False, 'failed .^lookup returns undefined value';
is Any.^find_method('supercalafajalistickexpialadojus').defined,
    False, 'failed .^find_method returns Mu';

# vim: expandtab shiftwidth=4
