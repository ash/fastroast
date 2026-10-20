use Test;
plan 8;

# TODO: move this test to closure-parameters.t if it works in the future

# L<S06/Closure parameters>

our $개갨ллe̲개中갨с = 2;
sub 中갨_丛e̲_개àллe̲𝐝($x) {
    $개갨ллe̲개中갨с += $x;
}

sub 中e̲ò中e̲с(&my_sub) {
    my_sub(4);
}

中e̲ò中e̲с(&中갨_丛e̲_개àллe̲𝐝);
ok $개갨ллe̲개中갨с == 6, 'Can call my_sub() if &my_sub was a parameter';

中e̲ò中e̲с(sub ($x) { $개갨ллe̲개中갨с = 3 * $x });
ok $개갨ллe̲개中갨с == 12, 'same with anonymous sub';

sub 中e̲ò中e̲с2(&my_sub) { 1 }    #OK not used
dies-ok {EVAL 'tester2(42)' }, "can't pass thing that doesn't do Callable";

sub not_returns_a_sub { 3 };
dies-ok { EVAL 'tester2(not_returns_a_sub)' },
        "can't pass thing that doesn't do Callable";

is 中e̲ò中e̲с2({ 'block' }), 1, 'Can pass a block to a &parameter';

# https://github.com/Raku/old-issue-tracker/issues/1231
{
    sub с中68578( Callable &x ) {}   #OK not used
    dies-ok { с中68578({ 'block' }) },
            "Can't pass something that isn't typed as returning Callable";
}

# https://github.com/Raku/old-issue-tracker/issues/1174
{
    my $中сà개k̲e̲с;
    sub е갨갨(&е갨갨 = &е갨갨) {
        $中сà개k̲e̲с = &е갨갨
    };
    #?rakudo todo 'RT #67932'
    lives-ok { е갨갨 },
        'can call a sub with a code object defaulting to something of its own name';
    ok !$中сà개k̲e̲с.defined, 'the inner &foo is undefined (scoping)';
}

# vim: expandtab shiftwidth=4
