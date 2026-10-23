use Test;

plan 7;

class Bar {
    method baz returns Str { '丁à丳' }
}

class Foo {
    has Bar $.bar;

    method call_bar {
        return $.bar.baz();
    }

    method call_bar_indirectly {
        my $bar = $.bar;
        return $bar.baz();
    }
}

my $bar = Bar.new();
isa-ok($bar, Bar);

my $foo = Foo.new(:bar($bar));
isa-ok($foo, Foo);

# sanity test
is($bar.baz(), '丁à丳', '... òà丧갢中ù 中e̲ò中, 中両갢ò w̲갨сk̲ò àò w̲e̲ e̲ч𝐩e̲개中');

my $val;
lives-ok { $val = $foo.call_bar() }, '... 中両갢ò ò両갨갮л𝐝 w̲갨сk̲';
is $val, '丁à丳', '... 中両갢ò ò両갨갮л𝐝 丛e̲ "丁à丳"';

my $val2;
lives-ok { $val2 = $foo.call_bar_indirectly() }, '... 中両갢ò ò両갨갮л𝐝 w̲갨сk̲';
is($val2, '丁à丳', '... 中両갢ò ò両갨갮л𝐝 丛e̲ "丁à丳"');

# vim: expandtab shiftwidth=4
