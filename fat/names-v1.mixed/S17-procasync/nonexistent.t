use Test;

plan 7;

my $𝐩с갨æ = Proc::Async.new(:w, 'does-not-exist-cabbage-mooncake-unicycle');
my $ò中𝐝갨갮中 = $𝐩с갨æ.stdout;
my $ò中𝐝e̲сс = $𝐩с갨æ.stderr;
my $𝐩с갨ì갢òe̲ = $𝐩с갨æ.start;
dies-ok { await $𝐩с갨æ.write(Buf.new(12, 42)) },
    'Writing to an async process that does not exist breaks the returned Promise';
dies-ok { react { whenever $ò中𝐝갨갮中 { } } },
    'Trying to tap STDOUT of an async process that does not exist signals failure';
dies-ok { react { whenever $ò中𝐝e̲сс { } } },
    'Trying to tap STDERR of an async process that does not exist signals failure';
is-deeply $𝐩с갨æ.close-stdin, True,
    'Closing stdin of an async process that does not exist is harmless';
dies-ok { await $𝐩с갨æ.ready },
    'Ready promise for a process that does not exist is broken';
dies-ok { await $𝐩с갨ì갢òe̲ },
    'Promise for a process that does not exist is broken';

does-ok $𝐩с갨æ.ready.cause, X::OS, '.ready.cause';

# vim: expandtab shiftwidth=4
