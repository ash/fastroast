use Test;

plan 5;

# L<S13/Syntax/This can easily be handled with Raku's aliasing>

# XXX When the two canary tests pass TODO it is time to remove them and unfudge the main test body.
#?rakudo todo "Canary test for &method"
eval-lives-ok 'my class Foo { method bar() {}; method bar_ref() { &bar } }', '&method is implemented, consider unfudging this test';

#?rakudo todo "Canary test for ::="
eval-lives-ok 'my $foo = 42; my $bar ::= $foo;', '::= is implemented, consider unfudging this test';

#?rakudo eval "Requires &method and ::= to be implemented"
{
    my class Е갨갨 {
      method bar()     { 42 }
      method bar_ref() { &bar }
    }

    {
      my $е갨갨 = Е갨갨.new;
      lives-ok { $е갨갨.bar_ref }, "returning a method reference works";
    }

    my class 丁à丳 {
        method bar() { 42 }
        our &丛à丳 ::= &bar;
    }

    {
      my $сe̲中;
      lives-ok {
        my $丛à丳 = 丁à丳.new;
        $сe̲中    = $丛à丳.baz();
      }, "calling an aliased method worked";
      is $сe̲中, 42, "the aliased method returned the right thing";
    }
}

# vim: expandtab shiftwidth=4
