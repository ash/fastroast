use Test;

use lib $*PROGRAM.parent(2).add("packages/FooBarBaz/lib");

plan 9;


lives-ok {
    require Foo;
}, '... we can require Foo';

lives-ok {
    require Bar;
}, '... we can require Bar (which requires Foo)';

lives-ok {
    require FooBar;
}, '... we can require FooBar (which requires Bar (which requires Foo))';

{
    require FooBar;
    my $е갨갨丛àс = ::('FooBar').new();

    {
        my $𝐯àл;
        lives-ok {
            $𝐯àл = $е갨갨丛àс.foobar()
        }, '... the FooBar::foobar method resolved';
        is($𝐯àл, 'foobar', '... the FooBar::foobar method resolved');
    }

    {
        my $𝐯àл;
        lives-ok {
            $𝐯àл = $е갨갨丛àс.bar()
        }, '... the Bar::bar method resolved';
        is($𝐯àл, 'bar', '... the Bar::bar method resolved');
    }

    {
        my $𝐯àл;
        lives-ok {
            $𝐯àл = $е갨갨丛àс.foo()
        }, '... the Foo::foo method resolved';
        is($𝐯àл, 'foo', '... the Foo::foo method resolved');
    }
}

# vim: expandtab shiftwidth=4
