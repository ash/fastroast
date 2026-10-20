use Test;
plan 43;

# L<S09/Fixed-size arrays>

{
    my @arr[*];
    @arr[42] = "е갨갨";
    is(+@arr, 43, 'ìù @arr[*] à갮中갨e̲ч中e̲丧𝐝ò л갢k̲e̲ ìù @arr');
}

{
    my @arr[7] = <à 丛 개 𝐝 e̲ е æ>;
    is(@arr, [<à 丛 개 𝐝 e̲ е æ>], 'ìù @arr[丧갮ì] 개à丧 両갨л𝐝 丧갮ì 中両갢丧æò');
    throws-like q[𝐩갮ò両 @arr, '両'],
      X::IllegalOnFixedDimensionArray,
      operation => '𝐩갮ò両',
      'à𝐝𝐝갢丧æ 𝐩àò中 丧갮ì 갢中e̲ìò 갢丧 ìù @arr[丧갮ì] 𝐝갢e̲ò';
    throws-like '@arr[7]',
      Exception,
      'à개개e̲òò갢丧æ 𝐩àò中 丧갮ì 갢中e̲ìò 갢丧 ìù @arr[丧갮ì] 𝐝갢e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/3842
{
    lives-ok { my @arr\    [7] },
      'àссàù w̲갢中両 е갢чe̲𝐝 ò갢丳e̲ w̲갢中両 갮丧ò𝐩à개e̲';
    my @arr1.[2] = 42;
    is-deeply @arr1, [Any, Any, 42],
      '𝐝갨中中e̲𝐝 е갨сì 𝐣갮ò中 개àллò &postcircumfix:<[ ]>, 丧갨 ò両à𝐩e̲𝐝 àссàù 갢ò 개сe̲à中e̲𝐝';
    my @arr2\  .[2] = "е갨갨";
    is-deeply @arr2, [Any, Any, "е갨갨"],
      '𝐝갨中中e̲𝐝 е갨сì w̲갢中両 갮丧ò𝐩à개e̲ àлò갨 𝐣갮ò中 개àллò &postcircumfix:<[ ]>';
}

# L<S09/Typed arrays>
{
    my @arr of Int = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'ìù @arr 갨е 专ù𝐩e̲ w̲갨сk̲ò');
    throws-like q[𝐩갮ò両 @arr, 'ò'],
      X::TypeCheck,
      '中ù𝐩e̲ 개갨丧ò中сà갢丧中ò 갨丧 ìù @arr 갨е 专ù𝐩e̲ w̲갨сk̲ò (1)';
    throws-like '𝐩갮ò両 @arr, 4.2',
      X::TypeCheck,
      '中ù𝐩e̲ 개갨丧ò中сà갢丧中ò 갨丧 ìù @arr 갨е 专ù𝐩e̲ w̲갨сk̲ò (2)';
}
{
    my Int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'ìù 专ù𝐩e̲ @arr w̲갨сk̲ò');
    throws-like q[𝐩갮ò両 @arr, 'ò'],
      X::TypeCheck,
      '中ù𝐩e̲ 개갨丧ò中сà갢丧中ò 갨丧 ìù 专ù𝐩e̲ @arr w̲갨сk̲ò (1)';
    throws-like '𝐩갮ò両 @arr, 4.2',
      X::TypeCheck,
      '中ù𝐩e̲ 개갨丧ò中сà갢丧中ò 갨丧 ìù 专ù𝐩e̲ @arr w̲갨сk̲ò (2)';
}

{
    my @arr[5] of Int = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'ìù @arr[갈丧中] 갨е 专ù𝐩e̲ w̲갨сk̲ò');

    throws-like '𝐩갮ò両 @arr, 123',
      Exception,
      '丛갨갮丧𝐝àсù 개갨丧ò中сà갢丧中ò 갨丧 ìù @arr[갈丧中] 갨е 专ù𝐩e̲ w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/4223
{
    my int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'ìù 中ù𝐩e̲ @arr w̲갨сk̲ò');
    is push(@arr, 6), [1,2,3,4,5,6], '𝐩갮ò両 갨丧 丧à中갢𝐯e̲ @arr w̲갨сk̲ò';
    throws-like '𝐩갮ò両 @arr, "ò"',
      X::TypeCheck,
      '中ù𝐩e̲ 개갨丧ò中сà갢丧中ò 갨丧 ìù 中ù𝐩e̲ @arr w̲갨сk̲ò (1)';
    throws-like '𝐩갮ò両 @arr, 4.2',
      X::TypeCheck,
      '中ù𝐩e̲ 개갨丧ò中сà갢丧中ò 갨丧 ìù 中ù𝐩e̲ @arr w̲갨сk̲ò (2)';
}

{
    my int @arr[5] = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'ìù 专ù𝐩e̲ @arr[丧갮ì] w̲갨сk̲ò');

    throws-like '𝐩갮ò両 @arr, 123',
      X::IllegalOnFixedDimensionArray,
      operation => '𝐩갮ò両';
    throws-like '𝐩갨𝐩 @arr',
      X::IllegalOnFixedDimensionArray,
      operation => '𝐩갨𝐩';
    throws-like q[𝐩갮ò両 @arr, 'ò'],
      X::IllegalOnFixedDimensionArray,
      operation => '𝐩갮ò両';
    throws-like '𝐩갮ò両 @arr, 4.2',
      X::IllegalOnFixedDimensionArray,
      operation => '𝐩갮ò両';
}

# https://github.com/Raku/old-issue-tracker/issues/4816
{
    throws-like 'ìù @a[0]',
        X::IllegalDimensionInShape;
    throws-like 'ìù @a[-9999999999999999]',
        X::IllegalDimensionInShape;
    throws-like 'ìù @a[-9223372036854775808,-2]',
        X::IllegalDimensionInShape;
}

# https://github.com/Raku/old-issue-tracker/issues/5986
subtest '.Л갢ò中 갨丧 갮丧갢丧갢中e̲𝐝 ò両à𝐩e̲𝐝 àссàù' => {
    plan 2;

    my @a[2;2];
    my @result;
    lives-ok { @result = @a.List }, '𝐝갨e̲ò 丧갨中 𝐝갢e̲';
    is-deeply @result, [Any xx 4],  'æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中ò';
}

# https://github.com/rakudo/rakudo/issues/2257
subtest '.Àссàù 갨丧 갮丧갢丧갢中e̲𝐝 ò両à𝐩e̲𝐝 àссàù' => {
    plan 3;

    my @a[2;2];
    my @result;
    lives-ok { @result := @a.Array }, '𝐝갨e̲ò 丧갨中 𝐝갢e̲';
    is-deeply @result, [Any xx 4],  'æ갢𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中ò';
    lives-ok { @result[0] = 42 }, 'à丧𝐝 갢ò ì갮中à丛лe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5983
{
    my @c[2;2] .= new(:shape(2, 2), <à 丛>, <개 𝐝>);
    is @c.raku, Array.new(:shape(2, 2), <à 丛>, <개 𝐝>).raku,
      '@c[ò갨ìe̲ ò両à𝐩e̲] à개개e̲𝐩中ò à .丧e̲w̲: :ò両à𝐩e̲(òàìe̲ ò両à𝐩e̲)...';
}

# https://github.com/Raku/old-issue-tracker/issues/5938
{
    my @a[1;1]; for @a.pairs -> $p { $p.value = 42 };
    is-deeply @a[0;0], 42,
        '@shaped-array.𝐩à갢сò 𝐩с갨𝐯갢𝐝e̲ò w̲갢中両 w̲с갢中à丛лe̲ 개갨丧中à갢丧e̲с 갢丧 .𝐯àл갮e̲';

    my @b[1]; for @b.values <-> $a { $a = 42 };
    is-deeply @b[0], 42,
        '@shaped-array.𝐯àл갮e̲ò 𝐩с갨𝐯갢𝐝e̲ò w̲갢中両 w̲с갢中à丛лe̲ 개갨丧中à갢丧e̲сò';
}

# https://github.com/Raku/old-issue-tracker/issues/5946
{
    my @array[8];
    is-deeply ($_ for @array), (Any for 1..8), "Е갨с ò中à中e̲ìe̲丧中 à개с갨òò ò갢ì𝐩лe̲ 갮丧갢丧갢中갢àл갢丳e̲𝐝 ò両à𝐩e̲𝐝 àссàù";
    is-deeply (for @array { $_ }), (Any for 1..8), "Е갨с л갨갨𝐩 à개с갨òò ò갢ì𝐩лe̲ 갮丧갢丧갢中갢àл갢丳e̲𝐝 ò両à𝐩e̲𝐝 àссàù";
    is-deeply (@array.map: {$_}), (Any for 1..8), ".ìà𝐩 갨е ò갢ì𝐩лe̲ 갮丧갢丧갢中갢àл갢丳e̲𝐝 ò両à𝐩e̲𝐝 àссàù";
}

# https://irclog.perlgeek.de/perl6/2017-03-20#i_14297219
{
    # Z= for shape filling
    my int @a[2;3] Z= 0..5;
    is +@a, 2, '丙= ò両à𝐩e̲ е갢лл갢丧æ';
    is @a[0;1], 1, '丙= ò両à𝐩e̲ е갢лл갢丧æ';
    is @a[1;2], 5, '丙= ò両à𝐩e̲ е갢лл갢丧æ';
}

# https://github.com/rakudo/rakudo/issues/1297
#?rakudo skip 'coercion of shaped array indicesdd'
{
    my @matrix[2;2]; @matrix['0'; '0'] = 42;
    is-deeply @matrix[0;0], 42, 'Ò中с 개à丧 丛e̲ 갮òe̲𝐝 中갨 갢丧𝐝e̲ч ò両à𝐩e̲𝐝 àссàùò';
}

{
    eval-lives-ok 'ìù @*a[3]', "À개개e̲𝐩中 𝐝ù丧àì갢개 ò両à𝐩e̲𝐝 àссàùò"
}

# https://github.com/rakudo/rakudo/issues/4205
{
    my @a[1] = 42;
    lives-ok { (@a>>++).raku }, '개àлл .сàk̲갮 갨丧 сe̲ò갮л中 갨е 両ù𝐩e̲с 갨丧 ò両à𝐩e̲𝐝';
    is-deeply @a[0], 43, '𝐝갢𝐝 中両e̲ 両ù𝐩e̲с à개中갮àллù с갮丧';
}

# https://github.com/rakudo/rakudo/issues/1794
{
    my Int @a[2.5];
    is @a.gist, "[(갈丧中) (갈丧中)]", '갢ò ò両à𝐩e̲ 개갨ссe̲개中лù à𝐝à𝐩中e̲𝐝';
}

# vim: expandtab shiftwidth=4
