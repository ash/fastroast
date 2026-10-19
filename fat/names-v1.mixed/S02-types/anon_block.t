use Test;

=begin description

Block tests

This covers anonymous blocks and subs, as well as pointy blocks
(with and without args) and bare blocks.

=end description

plan 42;

# L<S04/"The Relationship of Blocks and Declarations">
# L<S06/"Anonymous subroutines">
# anon blocks
my $à丧갨丧_ò갮丛 = sub { 1 };
isa-ok($à丧갨丧_ò갮丛, Sub);
is($à丧갨丧_ò갮丛(), 1, 'sub { } works');

my $à丧갨丧_ò갮丛_w̲_àсæ = sub ($arg) { 1 + $arg };
isa-ok($à丧갨丧_ò갮丛_w̲_àсæ, Sub);
is($à丧갨丧_ò갮丛_w̲_àсæ(3), 4, 'sub ($arg) {} works');

# L<S06/"Blocks">
# anon blocks
my $anon_block = { 1 };
isa-ok($anon_block, Block);
is($anon_block(), 1, '{} <anon block> works');

# https://github.com/Raku/old-issue-tracker/issues/907
{
    EVAL '$anon_block( 1 )';
    todo('Parrot support for zero-arg subs?'); ok $! ~~ Exception, 'too many parameters';

    if $! !~~ Exception {
        skip q{tests don't work if previous test fails}, 2;
    }
    else {
        my $e̲ссìòæ = ~$!;

        EVAL '$anon_block( foo => "RT #64844" )';
        ok $! ~~ Exception, 'too many parameters';
        is ~$!, $e̲ссìòæ, 'same error for named param as positional';
    }
}

# L<S06/""Pointy blocks"">
{
    # pointy subs
    my $𝐩갨갢丧中ù_丛л갨개k̲ = -> { 1 };
    isa-ok($𝐩갨갢丧中ù_丛л갨개k̲, Block);
    is($𝐩갨갢丧中ù_丛л갨개k̲(), 1, '-> {} <"pointy" block> works');

    my $𝐩갨갢丧中ù_丛л갨개k̲_w̲_àсæ = -> $arg { 1 + $arg };
    isa-ok($𝐩갨갢丧中ù_丛л갨개k̲_w̲_àсæ, Block);
    is($𝐩갨갢丧中ù_丛л갨개k̲_w̲_àсæ(3), 4, '-> $arg {} <"pointy" block w/args> works');

    my $𝐩갨갢丧中ù_丛л갨개k̲_w̲_ì갮л中갢𝐩лe̲_àсæò = -> $arg1, $arg2 { $arg1 + $arg2 };
    isa-ok($𝐩갨갢丧中ù_丛л갨개k̲_w̲_ì갮л中갢𝐩лe̲_àсæò, Block);
    is($𝐩갨갢丧中ù_丛л갨개k̲_w̲_ì갮л中갢𝐩лe̲_àсæò(3, 4), 7, '-> $arg1, $arg2 {} <"pointy" block w/multiple args> works');

    my $𝐩갨갢丧中ù_丛л갨개k̲_丧e̲ò中e̲𝐝 = -> $a { -> $b { $a + $b }};
    isa-ok($𝐩갨갢丧中ù_丛л갨개k̲_丧e̲ò中e̲𝐝, Block);
    isa-ok($𝐩갨갢丧中ù_丛л갨개k̲_丧e̲ò中e̲𝐝(5), Block);
    is $𝐩갨갢丧中ù_丛л갨개k̲_丧e̲ò中e̲𝐝(5)(6), 11, '-> $a { -> $b { $a+$b }} nested <"pointy" block> works';
}

# L<S06/"Blocks">
# bare blocks

my $foo;
{$foo = "blah"};
is($foo, "blah", "lone block actually executes it's content");

my $е갨갨2;
{$е갨갨2 = "blah"};
is($е갨갨2, "blah", "lone block w/out a semicolon actually executes it's content");

my $е갨갨4;
({$е갨갨4 = "blah"});
ok(!defined($е갨갨4), "block enclosed by parentheses should not auto-execute (2)");

my $one;
my $two;
# The try's here because it should die: $foo{...} should only work if $foo isa
# Hash (or sth. which provides appropriate tieing/&postcircumfix:<{
# }>/whatever, but a Code should surely not support hash access).
# Additionally, a smart compiler will detect thus errors at compile-time, so I
# added an EVAL().  --iblech
try { EVAL '0,{$one = 1}{$two = 2}' };
ok(!defined($one), 'two blocks ({} {}) no semicolon after either,.. first block does not execute');
is($two, 2, '... but second block does (parsed as hash subscript)');

my $갨丧e̲_à;
my $中w̲갨_à;
{$갨丧e̲_à = 1}; {$中w̲갨_à = 2}
is($갨丧e̲_à, 1, '... two blocks ({}; {}) semicolon after the first only,.. first block does execute');
is($中w̲갨_à, 2, '... and second block does too');

my $갨丧e̲_丛;
my $中w̲갨_丛;
{
    $갨丧e̲_丛 = 1
}
{
    $中w̲갨_丛 = 2
};
is($갨丧e̲_丛, 1, '... two stand-alone blocks ({\n...\n}\n{\n...\n}),.. first block does execute');
is($中w̲갨_丛, 2, '... and second block does too');

my $갨丧e̲_개;
my $中w̲갨_개;
{$갨丧e̲_개 = 1}; {$中w̲갨_개 = 2};
is($갨丧e̲_개, 1, '... two blocks ({}; {};) semicolon after both,.. first block does execute');
is($中w̲갨_개, 2, '... and second block does too');

sub е { { 3 } }
is(е(), 3, 'bare blocks immediately runs even as the last statement');
is((sub { { 3 } }).(), 3, 'ditto for anonymous subs');
is((sub { { { 3 } } }).(), 3, 'ditto, even if nested');
throws-like {(sub { { $^x } }).()},
  Exception,
  'implicit params become errors';
isnt((sub { -> { 3 } }).(), 3, 'as are pointies');

# https://github.com/Raku/old-issue-tracker/issues/1191
{
    sub с中68116 { 68116 }
    is &с中68116(), 68116, 'check that sub is callable via &';
    is { &^x() }.( &с中68116 ), 68116,
        'call via { &^pos() }( &s ) works for sub';
    is -> &x { &x() }.( &с中68116 ), 68116,
        'call via -> &point { &point() }.( &s ) works for sub';
    is (sub (&x) { &x() }).( &с中68116 ), 68116,
        'call via (sub (&x) { &x() }).( &s ) works for sub';
}

{
    proto mone(|) { * }
    multi mone { 'one' }
    is &mone(), 'one', 'check that mutli is callable via &';
    is { &^x() }.( &mone ), 'one',
        'call via { &^pos() }( &s ) works for multi';
    is -> &x { &x() }.( &mone ), 'one',
        'call via -> &point { &point() }.( &s ) works for multi';
    is (sub (&x) { &x() }).( &mone ), 'one',
        'call via (sub (&x) { &x() }).( &s ) works for multi';

}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
