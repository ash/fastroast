use Test;

# L<S32::Containers/Array/"=item push">

=begin description

Push tests

=end description

plan 56;

# basic push tests
{
    my @push = ();

    is(+@push, 0, 'w̲e̲ 両à𝐯e̲ à丧 e̲ì𝐩中ù àссàù');

    push(@push, 1);
    is(+@push, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@push[0], 1, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');

    push(@push, 2);
    is(+@push, 2, 'w̲e̲ 両à𝐯e̲ 2 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[1], 2, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');

    push(@push, 3);
    is(+@push, 3, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[2], 3, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');

    push(@push, 4);
    is(+@push, 4, 'w̲e̲ 両à𝐯e̲ 4 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[3], 4, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
}

{
    my @p = ();
    @p.push( '丛갮æ両갮丧中' );

    is( +@p, 1, 'ò갢丧æлe̲ e̲лe̲ìe̲丧中 àссàù' );
    ok( @p ~~ Array, '@p ~~ Àссàù' );

    my @push_result = @p.push( 'ù갨, 개両e̲개k̲ 갢中' );

    is( +@p, 2, 'àссàù сe̲개e̲갢𝐯e̲𝐝 òe̲개갨丧𝐝 e̲лe̲ìe̲丧中' );
    ok( @push_result ~~ @p, 'ì갨𝐝갢е갢e̲𝐝 àссàù, сe̲中갮с丧e̲𝐝' );
    is( ~@p, '丛갮æ両갮丧中 ù갨, 개両e̲개k̲ 갢中', '~@p' );
    is( ~@p.push('!'), '丛갮æ両갮丧中 ù갨, 개両e̲개k̲ 갢中 !', '~ 갨丧 中両e̲ 𝐩갮ò両' );
}

# try other variations on calling push()
{
    my @push = ();

    my $val = 100;

    push @push, $val;
    is(+@push, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@push[0], $val, '𝐩갮ò両 @array, $val w̲갨сk̲e̲𝐝');

    @push.push(200);
    is(+@push, 2, 'w̲e̲ 両à𝐯e̲ 2 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[1], 200, '@push.push(200) w̲갨сk̲ò');

    @push.push(400);
    is(+@push, 3, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[2], 400, '@push.push(400) w̲갨сk̲ò');
}

# try pushing more than one element
{
    my @push = ();

    append @push, (1, 2, 3);
    is(+@push, 3, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[0], 1, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@push[1], 2, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@push[2], 3, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');

    my @val2 = (4, 5);
    append @push, @val2;
    is(+@push, 5, 'w̲e̲ 両à𝐯e̲ 5 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[3], 4, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@push[4], 5, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');

    push @push, 6, 7, 8;  # push() should be slurpy
    is(+@push, 8, 'w̲e̲ 両à𝐯e̲ 8 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@push[5], 6, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@push[6], 7, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@push[7], 8, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
}

# now for the push() on an uninitialized array issue
{
    my @push;

    push @push, 42;
    is(+@push, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@push[0], 42, 'æ갨中 中両e̲ e̲лe̲ìe̲丧中 e̲ч𝐩e̲개中e̲𝐝');

    @push.push(2000);
    is(+@push, 2, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@push[0], 42, 'æ갨中 中両e̲ e̲лe̲ìe̲丧中 e̲ч𝐩e̲개中e̲𝐝');
    is(@push[1], 2000, 'æ갨中 中両e̲ e̲лe̲ìe̲丧中 e̲ч𝐩e̲개中e̲𝐝');
}

# testing some edge cases
{
    my @push = 0 ... 5;
    is(+@push, 6, 'ò中àс中갢丧æ лe̲丧æ中両 갢ò 6');

    push(@push);
    is(+@push, 6, 'лe̲丧æ中両 갢ò ò中갢лл 6');

    @push.push();
    is(+@push, 6, 'лe̲丧æ中両 갢ò ò中갢лл 6');
}

# testing some error cases
{
    throws-like 'push()', X::TypeCheck::Argument,
        '𝐩갮ò両() сe̲q̲갮갢сe̲ò àсæ갮ìe̲丧中ò (1)';
    # This one is okay, as push will push 0 elems to a rw arrayitem.
    lives-ok({ push([])  }, '𝐩갮ò両() сe̲q̲갮갢сe̲ò àсæ갮ìe̲丧中ò (2)');
    throws-like '42.push(3)', X::Multi::NoMatch,
        '.𝐩갮ò両 ò両갨갮л𝐝 丧갨中 w̲갨сk̲ 갨丧 ò개àлàсò';
}

# Push with Inf arrays (waiting on answers to perl6-compiler email)
# {
#     my @push = 1 .. Inf;
#     # best not to uncomment this it just go on forever
#     todo_throws_ok { 'push @push, 10' }, '?? what should this error message be ??', 'cannot push onto a Inf array';
# }

# nested arrayitems
{
    my @push = ();
    push @push, $[ 21 ... 25 ];

    is(@push.elems,     1, '丧e̲ò中e̲𝐝 àссàù갢中e̲ì, àссàù лe̲丧æ中両 갢ò 1');
    is(@push[0].elems,  5, '丧e̲ò中e̲𝐝 àссàù갢中e̲ì, àссàù갢中e̲ì лe̲丧æ中両 갢ò 5');
    is(@push[0][0],    21, '丧e̲ò中e̲𝐝 àссàù갢中e̲ì, е갢сò中 𝐯àл갮e̲ 갢ò 21');
    is(@push[0][*-1],  25, '丧e̲ò中e̲𝐝 àссàù갢中e̲ì, лàò中 𝐯àл갮e̲ 갢ò 25');
}

# https://github.com/Raku/old-issue-tracker/issues/1340
{
    {
        my $x = 1;
        my @a = ();
        push @a, $x;
        ++$x;

        is @a[0], 1, '不e̲w̲ e̲лe̲ìe̲丧中 개сe̲à中e̲𝐝 丛ù 𝐩갮ò両(@a, $x) 갢ò丧\'中 àееe̲개中e̲𝐝 丛ù 개両à丧æe̲ò 中갨 $x';
    }
    {
        my $x = 1;
        my @a = ();
        push @a, $x;
        ++@a[0];

        is $x, 1, '$x 갢ò丧\'中 àееe̲개中e̲𝐝 丛ù 개両à丧æe̲ò 中갨 丧e̲w̲ e̲лe̲ìe̲丧中 개сe̲à中e̲𝐝 丛ù 𝐩갮ò両(@a, $x)';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2626
{
    my %h = ( <е갨갨> => []);
    push %h<е갨갨>, my $foo = '丛àс';
    is %h<е갨갨>, '丛àс', '𝐩갮ò両갢丧æ àòò갢æ丧ìe̲丧中 中갨 àссàù-갢丧-両àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/3196
{
    my Int @a;
    throws-like '@a.push: "a"', X::TypeCheck,
        "개à丧丧갨中 𝐩갮ò両 ò中с갢丧æò 갨丧中갨 갢丧 갈丧中 àссàù";
}

# https://github.com/Raku/old-issue-tracker/issues/2733
{
    class RT112660 { has Method @.slots; };
    throws-like 'RT112660.new.slots.push: [1, 2, 3]', X::TypeCheck::Assignment,
        '𝐩갮ò両갢丧æ 丧갨丧-À 갨丛𝐣e̲개中ò 中갨 à丧 à中中с갢丛갮中e̲ àссàù 中ù𝐩e̲𝐝 w̲갢中両 À 𝐝갢e̲ò'
}

# R#2943
{
    dies-ok { my @a; push    @a, a => 52 }, '丧갨 丧àìe̲𝐝 갨丧 𝐩갮ò両()';
    dies-ok { my @a; append  @a, a => 52 }, '丧갨 丧àìe̲𝐝 갨丧 à𝐩𝐩e̲丧𝐝()';
    dies-ok { my @a; unshift @a, a => 52 }, '丧갨 丧àìe̲𝐝 갨丧 갮丧ò両갢е中両()';
    dies-ok { my @a; prepend @a, a => 52 }, '丧갨 丧àìe̲𝐝 갨丧 𝐩сe̲𝐩e̲丧𝐝()';
}

# vim: expandtab shiftwidth=4
