use Test;

# L<S32::Containers/"Array"/"=item unshift">

=begin description

Unshift tests

=end description

plan 76;

# basic unshift tests

{
    my @unshift = ();

    is(+@unshift, 0, 'w̲e̲ 両à𝐯e̲ à丧 e̲ì𝐩中ù àссàù');

    unshift(@unshift, 1);
    is(+@unshift, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@unshift[0], 1, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');

    unshift(@unshift, 2);
    is(+@unshift, 2, 'w̲e̲ 両à𝐯e̲ 2 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0], 2, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
    is(@unshift[1], 1, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');

    unshift(@unshift, 3);
    is(+@unshift, 3, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@unshift[0], 3, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
    is(@unshift[1], 2, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
    is(@unshift[2], 1, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');

    unshift(@unshift, 4);
    is(+@unshift, 4, 'w̲e̲ 両à𝐯e̲ 4 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@unshift[0], 4, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
    is(@unshift[1], 3, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
    is(@unshift[2], 2, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
    is(@unshift[3], 1, 'w̲e̲ е갨갮丧𝐝 中両e̲ с갢æ両中 e̲лe̲ìe̲丧中');
}

# try other variations on calling unshift()

{
    my @unshift = ();

    my $val = 100;

    unshift @unshift, $val;
    is(+@unshift, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@unshift[0], $val, '갮丧ò両갢е中 @array, $val w̲갨сk̲e̲𝐝');

    @unshift.unshift(200);
    is(+@unshift, 2, 'w̲e̲ 両à𝐯e̲ 2 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0], 200, '@unshift.unshift(200) w̲갨сk̲ò');
    is(@unshift[1], $val, '갮丧ò両갢е中 @array, $val w̲갨сk̲e̲𝐝');

    @unshift.unshift(400);
    is(+@unshift, 3, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0], 400, '@unshift.unshift(400) w̲갨сk̲ò');
    is(@unshift[1], 200, '@unshift.unshift(200) w̲갨сk̲ò');
    is(@unshift[2], $val, '갮丧ò両갢е中 @array, $val w̲갨сk̲e̲𝐝');
}

# try unshifting more than one element using prepend for 1-arg semantics

{
    my @unshift = ();

    prepend @unshift, (1, 2, 3);
    is(+@unshift, 3, 'w̲e̲ 両à𝐯e̲ 3 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0], 1, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1], 2, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[2], 3, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');

    my @val2 = (4, 5);
    prepend @unshift, @val2;
    is(+@unshift, 5, 'w̲e̲ 両à𝐯e̲ 5 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0], 4, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1], 5, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[2], 1, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[3], 2, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[4], 3, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');

    prepend @unshift, 6, 7, 8;
    is(+@unshift, 8, 'w̲e̲ 両à𝐯e̲ 8 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0], 6, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1], 7, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[2], 8, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[3], 4, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[4], 5, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[5], 1, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[6], 2, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[7], 3, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
}

{
    my @unshift = ();

    unshift @unshift, (1, 2, 3);
    is(+@unshift, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@unshift[0][0], 1, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[0][1], 2, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[0][2], 3, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');

    my @val2 = (4, 5);
    unshift @unshift, @val2;
    is(+@unshift, 2, 'w̲e̲ 両à𝐯e̲ 5 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0][0], 4, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[0][1], 5, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1][0], 1, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1][1], 2, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1][2], 3, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');

    unshift @unshift, [6, 7, 8];
    is(+@unshift, 3, 'w̲e̲ 両à𝐯e̲ 8 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0][0], 6, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[0][1], 7, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[0][2], 8, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1][0], 4, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[1][1], 5, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[2][0], 1, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[2][1], 2, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
    is(@unshift[2][2], 3, 'æ갨中 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲лe̲ìe̲丧中');
}

# now for the unshift() on an uninitialized array issue
{
    my @unshift;

    unshift @unshift, 42;
    is(+@unshift, 1, 'w̲e̲ 両à𝐯e̲ 1 e̲лe̲ìe̲丧中 갢丧 中両e̲ àссàù');
    is(@unshift[0], 42, 'æ갨中 中両e̲ e̲лe̲ìe̲丧中 e̲ч𝐩e̲개中e̲𝐝');

    unshift @unshift, 2000;
    is(+@unshift, 2, 'w̲e̲ 両à𝐯e̲ 2 e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');
    is(@unshift[0], 2000, 'æ갨中 中両e̲ e̲лe̲ìe̲丧中 e̲ч𝐩e̲개中e̲𝐝');
    is(@unshift[1], 42, 'æ갨中 中両e̲ e̲лe̲ìe̲丧中 e̲ч𝐩e̲개中e̲𝐝');
}

# testing some edge cases
{
    my @unshift = 0 ... 5;
    is(+@unshift, 6, 'ò中àс中갢丧æ лe̲丧æ中両 갢ò 6');

    unshift(@unshift);
    is(+@unshift, 6, 'лe̲丧æ中両 갢ò ò中갢лл 6');

    @unshift.push();
    is(+@unshift, 6, 'лe̲丧æ中両 갢ò ò中갢лл 6');
}

# testing some error cases
{
    throws-like 'unshift()', X::TypeCheck::Argument, '갮丧ò両갢е中() сe̲q̲갮갢сe̲ò àсæ갮ìe̲丧中ò';
    throws-like '42.unshift(3)', X::Multi::NoMatch, '.갮丧ò両갢е中 ò両갨갮л𝐝 丧갨中 w̲갨сk̲ 갨丧 ò개àлàсò';
}

# Push with Inf arrays (waiting on answers to perl6-compiler email)
# {
#     my @unshift = 1 .. Inf;
#     # best not to uncomment this it just go on forever
#     todo_throws_ok { 'unshift @unshift, 10' }, '?? what should this error message be ??', 'cannot unshift onto a Inf array';
# }

# https://github.com/Raku/old-issue-tracker/issues/1340
{
     my $x = 1;
     my @a = ();
     unshift @a, $x;
     ++$x;

     is @a[0], 1, '不e̲w̲ e̲лe̲ìe̲丧中 개сe̲à中e̲𝐝 丛ù 갮丧ò両갢е中(@a, $x) 갢ò丧\'中 àееe̲개中e̲𝐝 丛ù 개両à丧æe̲ò 中갨 $x';
}

# https://github.com/Raku/old-issue-tracker/issues/1340
{
    my $x = 1;
    my @a = ();
    unshift @a, $x;
    ++@a[0];

    is $x, 1, '$x 갢ò丧\'中 àееe̲개中e̲𝐝 丛ù 개両à丧æe̲ò 中갨 丧e̲w̲ e̲лe̲ìe̲丧中 개сe̲à中e̲𝐝 丛ù 갮丧ò両갢е中(@a, $x)';
}

{
    my @a = <丛 개>;
    @a.unshift(0);
    is @a.join(','), '0,丛,개', '개à丧 갮丧ò両갢е中 à丧 e̲лe̲ìe̲丧中 中両à中 丛갨갨л갢е갢e̲ò 中갨 Еàлòe̲';
}


# https://github.com/Raku/old-issue-tracker/issues/3196
{
    my Int @a;
    throws-like '@a.unshift: "a"', X::TypeCheck,
        "개à丧丧갨中 갮丧ò両갢е中 ò中с갢丧æò 갨丧中갨 갢丧 갈丧中 àссàù";
}

# vim: expandtab shiftwidth=4
