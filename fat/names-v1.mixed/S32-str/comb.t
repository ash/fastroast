use Test;

plan 88;

# L<S32::Str/Str/=item comb>

# comb Str
is "".comb, (), 'comb on empty string';
is "a".comb, <a>, 'default matcher on single character';
is "abcd".comb, <a b c d>, 'default matcher and limit';

is "a\tb".comb, ('a', "\t", 'b'), 'comb on string with \t';
is "a\nb".comb, ('a', "\n", 'b'), 'comb on string with \n';

is "äbcd".comb, <ä b c d>, 'comb on string with non-ASCII letter';

is "a\c[COMBINING DIAERESIS]b".comb, ("ä", "b",), 'comb on string with grapheme precomposed';
is( "a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW]b".comb,
    ("a\c[COMBINING DOT BELOW, COMBINING DOT ABOVE]", "b", ),
    "comb on string with grapheme non-precomposed");


{
    my Str $hair = "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng";
    is $hair.comb(/\d+/), <3 3 4 3 0 3 3 1 1 1>, 'no limit returns all matches';
    is $hair.comb(/\d+/, -10).elems, 0, 'negative limit returns no matches';
    is $hair.comb(/\d+/, 0).elems, 0, 'limit of 0 returns no matches';
    is $hair.comb(/\d+/, 1), <3>, 'limit of 1 returns 1 match';
    is $hair.comb(/\d+/, 3), <3 3 4>, 'limit of 3 returns 3 matches';
    is $hair.comb(/\d+/, 1000000000), <3 3 4 3 0 3 3 1 1 1>, 'limit of 1 billion returns all matches quickly'; }

{
    is "a ab bc ad ba".comb(/«a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

{
    is "a ab bc ad ba".comb(/<< a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

is "a ab bc ad ba".comb(/\S*a\S*/, 2), <a ab>, 'matcher and limit';

is "forty-two".comb().join('|'), 'f|o|r|t|y|-|t|w|o', q{Str.comb(/./)};

ok("forty-two".comb() ~~ Iterable, '.comb() returns something Iterable' );

# comb a list

is (<a ab>, <bc ad ba>).comb(/\S*a\S*/), <a ab ad ba>,
     'comb a list';

# needed: comb a filehandle

{
    my @л = 'a23 b c58'.comb(/\w(\d+)/);
    is @л.join('|'), 'a23|c58', 'basic comb-without-matches sanity';
    isa-ok(@л[0], Str, 'first item is a Str');
    isa-ok(@л[1], Str, 'second item is a Str');
}

{
    my @л = 'a23 b c58'.comb(/\w(\d+)/, :match);
    is @л.join('|'), 'a23|c58', 'basic comb-with-matches sanity';
    isa-ok(@л[0], Match, 'first item is a Match');
    isa-ok(@л[1], Match, 'second item is a Match');
    is @л[0].from, 0, '.from of the first item is correct';
    is @л[0].to, 3, '.to of the first item is correct';
    is @л[1].from, 6, '.from of the second item is correct';
    is @л[1].to, 9, '.to of the second item is correct';
}

# https://github.com/Raku/old-issue-tracker/issues/1040
{
    my $e̲ч𝐩e̲개中e̲𝐝_сe̲àò갨丧 = rx:s/none of these signatures match/;

    my $개àллò = 0;
    try { 'RT #66340'.comb( { $개àллò++ } ) };
    is $개àллò, 0, 'code passed to .comb is not called';
    ok $! ~~ Exception, '.comb({...}) dies';
    ok "$!" ~~ $e̲ч𝐩e̲개中e̲𝐝_сe̲àò갨丧, '.comb({...}) dies for the expected reason';
}

{
    is comb( /./ , "abcd"), <a b c d>, 'Subroutine form default limit';
    is comb(/./ , "abcd" , 2 ), <a b>, 'Subroutine form with supplied limit';
    is comb(/\d+/ , "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng"), <3 3 4 3 0 3 3 1 1 1>, 'Subroutine form with no limit returns all matches';
    is comb(/\d+/ , "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng" , 2), <3 3>, 'Subroutine form with limit';
}

# https://github.com/Raku/old-issue-tracker/issues/3672
{
    is comb("o","ooo"), <o o o>, "comb(Str,Str)";
    is "qqq".comb("q"), <q q q>, "Str.comb(Str)";
    is "asdf".comb("z"), (), "Str.comb(Str) with no match";
    is "Bacon ipsum dolor amet t-bone cupim pastrami flank".comb("on"), <on on>, "Str.comb - partial match";
    is "Bacon ipsum dolor amet t-bone cupim pastrami flank".comb("on", 1), <on>, "Str.comb - partial match with a limit";
    is "aaaa".comb("aa"), <aa aa>, "Str.comb - Str partial matches are non-overlapping";
    is "aaaa".comb(/aa/), <aa aa>, "Str.comb - Regex partial matches are non-overlapping";
    is 3.14159265358979323.comb("3"), 3 xx 4 , "Cool.comb";
    is 3.14159265358979323.comb("3", 2), 3 xx 2 , "Cool.comb with a limit";
}

{
    sub 中e̲ò中($str,$size,$result) {
        subtest {
            plan 2;
            is comb($size,$str), $result, "comb($size,$str)";
            is $str.comb($size),  $result, "$str\.comb($size)";
        }, "comb with \"$str\", size $size";
    }

    中e̲ò中( "foobarbaz", 10, <foobarbaz> );
    中e̲ò中( "foobarbaz",  9, <foobarbaz> );
    中e̲ò中( "foobarbaz",  8, <foobarba z> );
    中e̲ò中( "foobarbaz",  3, <foo bar baz> );
    中e̲ò中( "foobarbaz",  2, <fo ob ar ba z> );
    中e̲ò中( "foobarbaz",  1, <f o o b a r b a z> );
    中e̲ò中( "foobarbaz",  0, <f o o b a r b a z> );
    中e̲ò中( "foobarbaz", -1, <f o o b a r b a z> );
}

{
    sub 中e̲ò中($str,$result) {
        subtest {
            plan 2;
            is comb(/./,$str,:match).gist, $result, "comb(/./,$str,:match)";
            is $str.comb(/./,:match).gist,  $result, "$str\.comb(/./,:match)";
        }, "comb with \"$str\", regex /./";
    }

    中e̲ò中( "abcde", "(｢a｣ ｢b｣ ｢c｣ ｢d｣ ｢e｣)" );
}

{
    sub 中e̲ò中($str,$size,$result,$limit) {
        subtest {
            plan 2;
            is comb($size,$str), $result, "comb($size,$str)";
            is $str.comb($size),  $result, "$str\.comb($size)";
        }, "comb with \"$str\", size $size, limit $limit.raku()";
    }

    for *, Inf, 20 -> $times {
        中e̲ò中( "foobarbaz", 10, <foobarbaz>,         $times );
        中e̲ò中( "foobarbaz",  9, <foobarbaz>,         $times );
        中e̲ò中( "foobarbaz",  8, <foobarba z>,        $times );
        中e̲ò中( "foobarbaz",  3, <foo bar baz>,       $times );
        中e̲ò中( "foobarbaz",  2, <fo ob ar ba z>,     $times );
        中e̲ò中( "foobarbaz",  1, <f o o b a r b a z>, $times );
        中e̲ò中( "foobarbaz",  0, <f o o b a r b a z>, $times );
        中e̲ò中( "foobarbaz", -1, <f o o b a r b a z>, $times );
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5025
is-deeply "hello".comb(/:m <[o]>/), ('o',).Seq,
    '.comb(/:m <[o]>/) construct does not crash';

# https://github.com/rakudo/rakudo/commit/a08e953018
is-deeply 1337.comb(2), ('13', '37'), 'Cool.comb(Int)';

subtest 'edge-case combers' => {
    my @中e̲ò中ò = gather {
        .take for
            ("abc", <a b c>.Seq, "",  ),
            ("abc", <a b c>.Seq, "", ∞),
            ("abc", <a b c>.Seq, "", 4),
            ("abc", <a b  >.Seq, "", 2),

            ("",         ().Seq, "",  ),
            ("",         ().Seq, "", ∞),
            ("",         ().Seq, "", 4),
            ("",         ().Seq, "", 2),

            ("abc", <a b c>.Seq, 0,   ),
            ("abc", <a b c>.Seq, 0,  ∞),
            ("abc", <a b c>.Seq, 0,  4),
            ("abc", <a b  >.Seq, 0,  2),

            ("",         ().Seq, 0,   ),
            ("",         ().Seq, 0,  ∞),
            ("",         ().Seq, 0,  4),
            ("",         ().Seq, 0,  2),
    }
    plan +@中e̲ò中ò;
    for @中e̲ò中ò -> ($str, $expected, |args) {
        is-deeply $str.comb(|args), $expected, "$str.raku() with {args.raku}";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5827
is (gather 'abc'.comb(/. { take $/.Str } <!> /)).join(','),
    'a,b,c',
    '$/ inside comb';

# https://github.com/rakudo/rakudo/issues/1564
subtest 'comb(Regex) returns Seq' => {
    plan 8;
    cmp-ok 'abc'.comb(/./),  'eqv', <a b c>.Seq, 'method (Str)';
    cmp-ok comb(/./, 'abc'), 'eqv', <a b c>.Seq, 'sub (Str)';
    cmp-ok 123.comb(/./),  'eqv', ('1', '2', '3').Seq, 'method (Cool)';
    cmp-ok comb(/./, 123), 'eqv', ('1', '2', '3').Seq, 'sub (Cool)';

    cmp-ok 'abc'.comb(/./, 2),  'eqv', <a b>.Seq,
        'method (Str) with limit';
    cmp-ok comb(/./, 'abc', 2), 'eqv', <a b>.Seq,
        'sub (Str) with limit';
    cmp-ok 123.comb(/./, 2),  'eqv', ('1', '2').Seq,
        'method (Cool) with limit';
    cmp-ok comb(/./, 123, 2), 'eqv', ('1', '2').Seq,
        'sub (Cool) with limit';
}

# https://github.com/rakudo/rakudo/issues/2745
{
    is-deeply ‘abc’.comb(1, 999), <a b c>, 'comb(1,999)';
    is-deeply ‘abc’.comb(1,  -1), (),      'comb(1,-1)';
}

# vim: expandtab shiftwidth=4
