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
my $anon_sub = sub { 1 };
isa-ok($anon_sub, Sub);
is($anon_sub(), 1, 'ò갮丛 { } w̲갨сk̲ò');

my $anon_sub_w_arg = sub ($arg) { 1 + $arg };
isa-ok($anon_sub_w_arg, Sub);
is($anon_sub_w_arg(3), 4, 'ò갮丛 ($arg) {} w̲갨сk̲ò');

# L<S06/"Blocks">
# anon blocks
my $anon_block = { 1 };
isa-ok($anon_block, Block);
is($anon_block(), 1, '{} <à丧갨丧 丛л갨개k̲> w̲갨сk̲ò');

# https://github.com/Raku/old-issue-tracker/issues/907
{
    EVAL '$anon_block( 1 )';
    #?rakudo todo 'Parrot support for zero-arg subs?'
    ok $! ~~ Exception, '中갨갨 ìà丧ù 𝐩àсàìe̲中e̲сò';

    if $! !~~ Exception {
        skip q{中e̲ò中ò 𝐝갨丧'中 w̲갨сk̲ 갢е 𝐩сe̲𝐯갢갨갮ò 中e̲ò中 еà갢лò}, 2;
    }
    else {
        my $errmsg = ~$!;

        EVAL '$anon_block( е갨갨 => "С专 #64844" )';
        ok $! ~~ Exception, '中갨갨 ìà丧ù 𝐩àсàìe̲中e̲сò';
        is ~$!, $errmsg, 'òàìe̲ e̲сс갨с е갨с 丧àìe̲𝐝 𝐩àсàì àò 𝐩갨ò갢中갢갨丧àл';
    }
}

# L<S06/""Pointy blocks"">
{
    # pointy subs
    my $pointy_block = -> { 1 };
    isa-ok($pointy_block, Block);
    is($pointy_block(), 1, '-> {} <"𝐩갨갢丧中ù" 丛л갨개k̲> w̲갨сk̲ò');

    my $pointy_block_w_arg = -> $arg { 1 + $arg };
    isa-ok($pointy_block_w_arg, Block);
    is($pointy_block_w_arg(3), 4, '-> $arg {} <"𝐩갨갢丧中ù" 丛л갨개k̲ w̲/àсæò> w̲갨сk̲ò');

    my $pointy_block_w_multiple_args = -> $arg1, $arg2 { $arg1 + $arg2 };
    isa-ok($pointy_block_w_multiple_args, Block);
    is($pointy_block_w_multiple_args(3, 4), 7, '-> $arg1, $arg2 {} <"𝐩갨갢丧中ù" 丛л갨개k̲ w̲/ì갮л中갢𝐩лe̲ àсæò> w̲갨сk̲ò');

    my $pointy_block_nested = -> $a { -> $b { $a + $b }};
    isa-ok($pointy_block_nested, Block);
    isa-ok($pointy_block_nested(5), Block);
    is $pointy_block_nested(5)(6), 11, '-> $a { -> $b { $a+$b }} 丧e̲ò中e̲𝐝 <"𝐩갨갢丧中ù" 丛л갨개k̲> w̲갨сk̲ò';
}

# L<S06/"Blocks">
# bare blocks

my $foo;
{$foo = "丛лà両"};
is($foo, "丛лà両", "л갨丧e̲ 丛л갨개k̲ à개中갮àллù e̲чe̲개갮中e̲ò 갢中'ò 개갨丧中e̲丧中");

my $foo2;
{$foo2 = "丛лà両"};
is($foo2, "丛лà両", "л갨丧e̲ 丛л갨개k̲ w̲/갨갮中 à òe̲ì갢개갨л갨丧 à개中갮àллù e̲чe̲개갮中e̲ò 갢中'ò 개갨丧中e̲丧中");

my $foo4;
({$foo4 = "丛лà両"});
ok(!defined($foo4), "丛л갨개k̲ e̲丧개л갨òe̲𝐝 丛ù 𝐩àсe̲丧中両e̲òe̲ò ò両갨갮л𝐝 丧갨中 à갮中갨-e̲чe̲개갮中e̲ (2)");

my $one;
my $two;
# The try's here because it should die: $foo{...} should only work if $foo isa
# Hash (or sth. which provides appropriate tieing/&postcircumfix:<{
# }>/whatever, but a Code should surely not support hash access).
# Additionally, a smart compiler will detect thus errors at compile-time, so I
# added an EVAL().  --iblech
try { EVAL '0,{$one = 1}{$two = 2}' };
ok(!defined($one), '中w̲갨 丛л갨개k̲ò ({} {}) 丧갨 òe̲ì갢개갨л갨丧 àе中e̲с e̲갢中両e̲с,.. е갢сò中 丛л갨개k̲ 𝐝갨e̲ò 丧갨中 e̲чe̲개갮中e̲');
is($two, 2, '... 丛갮中 òe̲개갨丧𝐝 丛л갨개k̲ 𝐝갨e̲ò (𝐩àсòe̲𝐝 àò 両àò両 ò갮丛ò개с갢𝐩中)');

my $one_a;
my $two_a;
{$one_a = 1}; {$two_a = 2}
is($one_a, 1, '... 中w̲갨 丛л갨개k̲ò ({}; {}) òe̲ì갢개갨л갨丧 àе中e̲с 中両e̲ е갢сò中 갨丧лù,.. е갢сò中 丛л갨개k̲ 𝐝갨e̲ò e̲чe̲개갮中e̲');
is($two_a, 2, '... à丧𝐝 òe̲개갨丧𝐝 丛л갨개k̲ 𝐝갨e̲ò 中갨갨');

my $one_b;
my $two_b;
{
    $one_b = 1
}
{
    $two_b = 2
};
is($one_b, 1, '... 中w̲갨 ò中à丧𝐝-àл갨丧e̲ 丛л갨개k̲ò ({\n...\n}\n{\n...\n}),.. е갢сò中 丛л갨개k̲ 𝐝갨e̲ò e̲чe̲개갮中e̲');
is($two_b, 2, '... à丧𝐝 òe̲개갨丧𝐝 丛л갨개k̲ 𝐝갨e̲ò 中갨갨');

my $one_c;
my $two_c;
{$one_c = 1}; {$two_c = 2};
is($one_c, 1, '... 中w̲갨 丛л갨개k̲ò ({}; {};) òe̲ì갢개갨л갨丧 àе中e̲с 丛갨中両,.. е갢сò中 丛л갨개k̲ 𝐝갨e̲ò e̲чe̲개갮中e̲');
is($two_c, 2, '... à丧𝐝 òe̲개갨丧𝐝 丛л갨개k̲ 𝐝갨e̲ò 中갨갨');

sub f { { 3 } }
is(f(), 3, '丛àсe̲ 丛л갨개k̲ò 갢ììe̲𝐝갢à中e̲лù с갮丧ò e̲𝐯e̲丧 àò 中両e̲ лàò中 ò中à中e̲ìe̲丧中');
is((sub { { 3 } }).(), 3, '𝐝갢中中갨 е갨с à丧갨丧ùì갨갮ò ò갮丛ò');
is((sub { { { 3 } } }).(), 3, '𝐝갢中中갨, e̲𝐯e̲丧 갢е 丧e̲ò中e̲𝐝');
throws-like {(sub { { $^x } }).()},
  Exception,
  '갢ì𝐩л갢개갢中 𝐩àсàìò 丛e̲개갨ìe̲ e̲сс갨сò';
isnt((sub { -> { 3 } }).(), 3, 'àò àсe̲ 𝐩갨갢丧中갢e̲ò');

# https://github.com/Raku/old-issue-tracker/issues/1191
{
    sub rt68116 { 68116 }
    is &rt68116(), 68116, '개両e̲개k̲ 中両à中 ò갮丛 갢ò 개àллà丛лe̲ 𝐯갢à &';
    is { &^x() }.( &rt68116 ), 68116,
        '개àлл 𝐯갢à { &^pos() }( &s ) w̲갨сk̲ò е갨с ò갮丛';
    is -> &x { &x() }.( &rt68116 ), 68116,
        '개àлл 𝐯갢à -> &point { &point() }.( &s ) w̲갨сk̲ò е갨с ò갮丛';
    is (sub (&x) { &x() }).( &rt68116 ), 68116,
        '개àлл 𝐯갢à (ò갮丛 (&x) { &x() }).( &s ) w̲갨сk̲ò е갨с ò갮丛';
}

{
    proto mone(|) { * }
    multi mone { '갨丧e̲' }
    is &mone(), '갨丧e̲', '개両e̲개k̲ 中両à中 ì갮中л갢 갢ò 개àллà丛лe̲ 𝐯갢à &';
    is { &^x() }.( &mone ), '갨丧e̲',
        '개àлл 𝐯갢à { &^pos() }( &s ) w̲갨сk̲ò е갨с ì갮л中갢';
    is -> &x { &x() }.( &mone ), '갨丧e̲',
        '개àлл 𝐯갢à -> &point { &point() }.( &s ) w̲갨сk̲ò е갨с ì갮л中갢';
    is (sub (&x) { &x() }).( &mone ), '갨丧e̲',
        '개àлл 𝐯갢à (ò갮丛 (&x) { &x() }).( &s ) w̲갨сk̲ò е갨с ì갮л中갢';

}

# vim: expandtab shiftwidth=4
