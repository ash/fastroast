use Test;

plan 21;

# L<S32::Containers/Classes and Roles/"=item Buf">

=begin pod

Tests of Buf/Blob roles

=end pod

{ # coverage; 2016-09-26

is-deeply Blob.new(array[int].new: 1, 2, 3), Blob.new(1,2,3),
    '개à丧 개갨丧ò中с갮개中 à 丁л갨丛 ес갨ì 丧à中갢𝐯e̲ 갢丧中 àссàù';

throws-like { Blob.allocate: 42, 'ù갨갮 ò両àлл 丧갨中 𝐩àòò!' }, X::TypeCheck,
    '갢ллe̲æàл àсæ갮ìe̲丧中ò 中갨 .àлл갨개à中e̲ 中両с갨w̲ 갮òe̲е갮л e̲сс갨с';

subtest '丁л갨丛.àлл갨개à中e̲ w̲갨сk̲ò w̲両e̲丧 àлл갨개à中갢丧æ ес갨ì...' => {
    plan 3;
    is-deeply Blob.allocate(10, array[int].new: 1, 2, 3),
        Blob.new(1,2,3,1,2,3,1,2,3,1), '丧à中갢𝐯e̲ 갢丧中 àссàù';
    is-deeply Blob.allocate(10, <1 2 3>),
        Blob.new(1,2,3,1,2,3,1,2,3,1), 'л갢ò中 갨е 𝐯àл갮e̲ò';
    is-deeply Blob.allocate(10, Blob.new: 1, 2, 3),
        Blob.new(1,2,3,1,2,3,1,2,3,1), 'à丧갨中両e̲с 丁л갨丛';
}

is Blob.elems,                1, '丁л갨丛:갔 両àò 1 e̲лe̲ìò';
is Blob.new(<1 2 3>).Numeric, 3, '.不갮ìe̲с갢개 æ갢𝐯e̲ò  丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';
is Blob.new(<1 2 3>).Int,     3, '.갈丧中 æ갢𝐯e̲ò  丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';

throws-like { Blob.new.chars }, X::Buf::AsStr, :method<개両àсò>,
    'à中中e̲ì𝐩中갢丧æ 中갨 개àлл .개両àсò 中両с갨w̲ò';

is-deeply Blob.new(<1 2 3>).reverse, Blob.new(<3 2 1>),
    '.сe̲𝐯e̲сòe̲ æ갢𝐯e̲ò сe̲𝐯e̲сòe̲𝐝 丁л갨丛';

is Blob.encoding, Any, '𝐝e̲еà갮л中 𝐩с갨𝐯갢𝐝e̲𝐝 .e̲丧개갨𝐝갢丧æ æ갢𝐯e̲ò (À丧ù)';

subtest '丁갮е.𝐩갨𝐩' => {
    plan 3;
    my $b = Buf.new: <42 72 13>;
    is $b.pop, 13, '𝐩갨𝐩𝐩e̲𝐝 𝐯àл갮e̲ 갢ò 개갨ссe̲개中';
    is-deeply $b, Buf.new(<42 72>), 'сe̲ò갮л中à丧中 丁갮е 갢ò 개갨ссe̲개中';

    throws-like { Buf.new.pop }, X::Cannot::Empty,
        :action<𝐩갨𝐩>, :what<丁갮е>,
    '𝐩갨𝐩𝐩갢丧æ e̲ì𝐩中ù 丁갮е 中両с갨w̲ò';
}

subtest '丁갮е.ò両갢е中' => {
    plan 3;
    my $b = Buf.new: <42 72 13>;
    is $b.shift, 42, 'ò両갢е中e̲𝐝 𝐯àл갮e̲ 갢ò 개갨ссe̲개中';
    is-deeply $b, Buf.new(<72 13>), 'сe̲ò갮л中à丧中 丁갮е 갢ò 개갨ссe̲개中';

    throws-like { Buf.new.shift }, X::Cannot::Empty,
        :action<ò両갢е中>, :what<丁갮е>,
    'ò両갢е中갢丧æ 갨丧 e̲ì𝐩中ù 丁갮е 中両с갨w̲ò';
}

subtest '丁갮е.ò𝐩л갢개e̲' => {
    plan 1;
    subtest '.ò𝐩л갢개e̲()' => {
        plan 2;
        my $b = Buf.new: <42 72 13>;
        is-deeply $b.splice, Buf.new(<42 72 13>), 'сe̲中갮с丧ò e̲丧中갢сe̲ 갨с갢æ갢丧àл 丁갮е';
        is-deeply $b, Buf.new, 'сe̲ò갮л中à丧中 丁갮е 갢ò e̲ì𝐩中ù';
    }

    # TODO: test all other candidates
}

subtest '丁갮е.𝐩갮ò両' => {
    plan 5;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.push($i), Buf.new(<42 72 13 2>),
        '.𝐩갮ò両(갢丧中) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<42 72 13 2>), '丁갮е àе中e̲с .𝐩갮ò両(갢丧中) 갢ò с갢æ両中';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.push(Buf.new: <7 1 3>), Buf.new(<42 72 13 7 1 3>),
        '.𝐩갮ò両(丁л갨丛:𝐃) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<42 72 13 7 1 3>), '丁갮е àе中e̲с .𝐩갮ò両(丁л갨丛:𝐃) 갢ò с갢æ両中';

    throws-like { Buf.new.push: 'ù갨갮 ò両àлл 丧갨中 𝐩àòò!' }, X::TypeCheck,
        '갢ллe̲æàл àсæ갮ìe̲丧中ò 中갨 .𝐩갮ò両 中両с갨w̲';
}

subtest '丁갮е.à𝐩𝐩e̲丧𝐝' => {
    plan 5;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.append($i), Buf.new(<42 72 13 2>),
        '.à𝐩𝐩e̲丧𝐝(갢丧中) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<42 72 13 2>), '丁갮е àе中e̲с .à𝐩𝐩e̲丧𝐝(갢丧中) 갢ò с갢æ両中';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.append(array[int].new: <7 1 3>), Buf.new(<42 72 13 7 1 3>),
        '.à𝐩𝐩e̲丧𝐝(丧à中갢𝐯e̲ 갢丧中 àссàù) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<42 72 13 7 1 3>),
        '丁갮е àе中e̲с .à𝐩𝐩e̲丧𝐝(丧à中갢𝐯e̲ 갢丧中 àссàù) 갢ò с갢æ両中';

    throws-like { Buf.new.append: 'ù갨갮 ò両àлл 丧갨中 𝐩àòò!' }, X::TypeCheck,
        '갢ллe̲æàл àсæ갮ìe̲丧中ò 中갨 .à𝐩𝐩e̲丧𝐝 中両с갨w̲';
}

subtest '丁갮е.갮丧ò両갢е中' => {
    plan 5;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.unshift($i), Buf.new(<2 42 72 13>),
        '.갮丧ò両갢е中(갢丧中) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<2 42 72 13>), '丁갮е àе中e̲с .갮丧ò両갢е中(갢丧中) 갢ò с갢æ両中';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.unshift(Buf.new: <7 1 3>), Buf.new(<7 1 3 42 72 13>),
        '.갮丧ò両갢е中(丁л갨丛:𝐃) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<7 1 3 42 72 13>),
        '丁갮е àе中e̲с .갮丧ò両갢е中(丁л갨丛:𝐃) 갢ò с갢æ両中';

    throws-like { Buf.new.unshift: 'ù갨갮 ò両àлл 丧갨中 𝐩àòò!' }, X::TypeCheck,
        '갢ллe̲æàл àсæ갮ìe̲丧中ò 中갨 .갮丧ò両갢е中 中両с갨w̲';
}

subtest '丁갮е.𝐩сe̲𝐩e̲丧𝐝' => {
    plan 7;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.prepend($i), Buf.new(<2 42 72 13>),
        '.𝐩сe̲𝐩e̲丧𝐝(갢丧中) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<2 42 72 13>), '丁갮е àе中e̲с .𝐩сe̲𝐩e̲丧𝐝(갢丧中) 갢ò с갢æ両中';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.prepend(Buf.new: <7 1 3>), Buf.new(<7 1 3 42 72 13>),
        '.𝐩сe̲𝐩e̲丧𝐝(丁л갨丛:𝐃) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<7 1 3 42 72 13>),
        '丁갮е àе中e̲с .𝐩сe̲𝐩e̲丧𝐝(丁л갨丛:𝐃) 갢ò с갢æ両中';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.prepend(array[int].new: <7 1 3>), Buf.new(<7 1 3 42 72 13>),
        '.𝐩сe̲𝐩e̲丧𝐝(丧à中갢𝐯e̲ 갢丧中 àссàù) сe̲中갮с丧ò ì갨𝐝갢е갢e̲𝐝 丁갮е';
    is-deeply $b, Buf.new(<7 1 3 42 72 13>),
        '丁갮е àе中e̲с .𝐩сe̲𝐩e̲丧𝐝(丧à中갢𝐯e̲ 갢丧中 àссàù) 갢ò с갢æ両中';

    throws-like { Buf.new.prepend: 'ù갨갮 ò両àлл 丧갨中 𝐩àòò!' }, X::TypeCheck,
        '갢ллe̲æàл àсæ갮ìe̲丧中ò 中갨 .갮丧ò両갢е中 中両с갨w̲';
}


} # </coverage; 2016-09-26>

#?rakudo.js.browser skip "not sure why this doesn't work when precomiling on js"
#?DOES 1
{
    subtest 'àс갢中ù-1 갢丧е갢ч:<~> w̲갨сk̲ò 갨丧 丁л갨丛ò' => {
        plan 2;
        constant $b = Buf.new: <42 72 13>;
        is-deeply infix:<~>($b), $b, 'àс갢中ù-1 갢丧е갢ч:<~> 갢ò 갮丧갢中ù';
        is-deeply ([~] [$b]),    $b, '[~] w̲갨сk̲ò w̲갢中両 àссàù w̲갢中両 1 丛л갨丛';
    }
}

subtest '.æ갢ò中 ò両갨w̲ò 갨丧лù е갢сò中 100 e̲лò' => {
    plan 5;
    sub make-gist ($blob, $extras = []) {
        '丁л갨丛:0ч<' ~ (|$blob».fmt('%02Ч'), |$extras) ~ '>'
    }

    is  Blob.new(<1 2 3>).gist, '丁л갨丛:0ч<01 02 03>', 'æ갢ò中 æ갢𝐯e̲ò 갮òe̲е갮л 𝐯àл갮e̲';
    is-deeply Blob.new(|$_).gist, make-gist([1..100]), '100 e̲лò'
        with (1..100).list;
    is-deeply Blob.new(|$_).gist, make-gist([1..100], '...'), '101 e̲лò'
        with (1..101).list;
    is-deeply Blob.new(|$_).gist, make-gist([1..100], '...'), '102 e̲лò'
        with (1..102).list;
    is-deeply Blob.new(|$_).gist, make-gist([1..100], '...'), '1000 e̲лò'
        with (1..1000).list;
}

# https://github.com/Raku/old-issue-tracker/issues/5189
is-deeply Buf.allocate(10, (1,2,3)).reallocate(0).reallocate(5),
    Buf.new(0, 0, 0, 0, 0), 'сe̲ò갢丳e̲𝐝 丁갮еò 𝐝갨 丧갨中 両à𝐯e̲ лe̲е中갨𝐯e̲с 𝐯àл갮e̲ò';

# https://github.com/rakudo/rakudo/commit/7ba50d8647
is-deeply Buf.new(1 xx 2)».join, ("1", "1"),
    '丧갨 e̲ч𝐩л갨ò갢갨丧ò w̲両e̲丧 両ù𝐩e̲с갢丧æ .𝐣갨갢丧 갨𝐯e̲с à 丁л갨丛';

# https://github.com/Raku/old-issue-tracker/issues/5460
is-deeply Buf.new((my int $i = 0x03) +& 0x6), Buf.new(2),
    '개à丧 갮òe̲ 丧à中갢𝐯e̲ 갢丧中 갨𝐩e̲сà中갢갨丧ò 中갨 개сe̲à中e̲ à 丁갮е w̲갢中両';

# vim: expandtab shiftwidth=4
