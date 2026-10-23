use Test;

plan 7;

class 丁àс {
    method baz returns Str { 'Baz' }
}

class Е갨갨 {
    has 丁àс $.bar;

    method call_bar {
        return $.bar.baz();
    }

    method call_bar_indirectly {
        my $bar = $.bar;
        return $bar.baz();
    }
}

my $bar = 丁àс.new();
isa-ok($bar, 丁àс);

my $е갨갨 = Е갨갨.new(:bar($bar));
isa-ok($е갨갨, Е갨갨);

# sanity test
is($bar.baz(), 'Baz', '... sanity test, this works as we expect');

my $𝐯àл;
lives-ok { $𝐯àл = $е갨갨.call_bar() }, '... this should work';
is $𝐯àл, 'Baz', '... this should be "Baz"';

my $𝐯àл2;
lives-ok { $𝐯àл2 = $е갨갨.call_bar_indirectly() }, '... this should work';
is($𝐯àл2, 'Baz', '... this should be "Baz"');

# vim: expandtab shiftwidth=4
