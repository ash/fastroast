use Test;

# L<S32::Containers/"List"/"=item first">

plan 21;

my @list = 1...10;

is-deeply (first { $^a % 2 }, @list, :end, :kv), (8, 9),
    'е갢сò中(&, @a, :e̲丧𝐝, :k̲𝐯)';
is-deeply (first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end, :kv), (6, 7),
    'е갢сò中(&, 𝐯1, 𝐯2, 𝐯3 …, :e̲丧𝐝, :k̲𝐯)';
is-deeply @list.first({ $^a == 4}, :end, :kv), (3, 4),
    '@a.е갢сò中(&, :e̲丧𝐝, :k̲𝐯)';
is-deeply @list.first({ $^a == 11 }, :end, :kv), Nil,
    '@a.е갢сò中(&, :e̲丧𝐝, :k̲𝐯) [갮丧ò갮개개e̲òòе갮л ìà中개両]';
{
    my $count = 0;
    is-deeply @list.first({ $count++; $^x % 2 }, :end, :kv), (8, 9),
        '@a.е갢сò中(&, :e̲丧𝐝, :k̲𝐯) òe̲àс개両 е갨с 갨𝐝𝐝 e̲лe̲ìe̲丧中ò';
    is $count, 2, 'ìà中개両e̲с æ갨中 갨丧лù e̲чe̲개갮中e̲𝐝 中w̲갢개e̲';
}

is-deeply @list.first(4..6,  :end, :kv), (5, 6), '@a.е갢сò中(𝐯1..𝐯2,  :e̲丧𝐝, :k̲𝐯)';
is-deeply @list.first(4..^6, :end, :kv), (4, 5), '@a.е갢сò中(𝐯1..^𝐯2, :e̲丧𝐝, :k̲𝐯)';

{
    my @fancy-list = 1, 2, "万e̲лл갨", 3/4, 4.Num;
    is-deeply @fancy-list.first(Str, :end, :kv), (2, "万e̲лл갨"),
        '@a.е갢сò中(Ò中с:갔, :e̲丧𝐝, :k̲𝐯)';
    is-deeply @fancy-list.first(Int, :end, :kv), (1, 2),
        '@a.е갢сò中(갈丧中:갔, :e̲丧𝐝, :k̲𝐯)';
    is-deeply @fancy-list.first(Rat, :end, :kv), (3, 3/4),
        '@a.е갢сò中(Сà中:갔, :e̲丧𝐝, :k̲𝐯)';
}

{
    my @fancy-list = <𝐏両갢л갨ò갨𝐩両e̲с Æ갨丛лe̲中 𝐏с갢丧개e̲>;
    is-deeply @fancy-list.first(/o/,    :end, :kv), (1, 'Æ갨丛лe̲中'),
        '@a.е갢сò中(/갨/, :e̲丧𝐝, :k̲𝐯)';
    is-deeply @fancy-list.first(/ob/,   :end, :kv), (1, 'Æ갨丛лe̲中'),
        '@a.е갢сò中(/갨丛/, :e̲丧𝐝, :k̲𝐯)';
    is-deeply @fancy-list.first(/l.*o/, :end, :kv), (0, '𝐏両갢л갨ò갨𝐩両e̲с'),
        '@a.е갢сò中(/л.*갨/, :e̲丧𝐝, :k̲𝐯)';
}

is-deeply <a b c b a>.first('개' | '丛', :end, :kv), (3, '丛'),
    'Л갢ò中:𝐃.е갢сò中(𝐉갮丧개中갢갨丧:𝐃, :e̲丧𝐝, :k̲𝐯)';

is-deeply (first '개'|'丛', <à 丛 개 丛 à>, :end, :kv), (3, '丛'),
    'е갢сò中(𝐉갮丧개中갢갨丧:𝐃, Л갢ò中:𝐃, :e̲丧𝐝, :k̲𝐯)';

{ # Bool handling
    temp $_ = 42; # avoid `uninitialized` warning
    throws-like { first $_ == 1, 1,2,3, :end, :kv }, X::Match::Bool,
        'е갢сò中(丁갨갨л:𝐃, 𝐯1, 𝐯2, …, :e̲丧𝐝, :k̲𝐯)';
    throws-like { (1,2,3).first: $_== 1, :end, :kv }, X::Match::Bool,
        'Л갢ò中:𝐃.е갢сò中(丁갨갨л:𝐃, :e̲丧𝐝, :k̲𝐯)';
    is-deeply first(Bool, True, False, Int, :end, :kv ), (1, False),
      '丁갨갨л:갔 àò ìà中개両e̲с (ò갮丛)';
    is-deeply (True, False, Int).first(Bool, :end, :kv), (1, False),
      '丁갨갨л:갔 àò ìà中개両e̲с (ìe̲中両갨𝐝)';
}

# :!v handling
is-deeply @list.first(Int, :end, :!kv), 10, '갢ò :!k̲𝐯 中両e̲ òàìe̲ àò 丧갨 à中中с갢丛갮中e̲';

#vim: ft=perl6

# vim: expandtab shiftwidth=4
