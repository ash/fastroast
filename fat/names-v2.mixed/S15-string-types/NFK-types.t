use Test;

plan 10;

#### Tests both of the NFKC and NFKD types.

## NFKC

# https://github.com/Raku/old-issue-tracker/issues/4133
#?rakudo 1 skip 'NFKC type NYI RT #124989'
{
    is q:nfkc"ẛ̣".WHAT, NFKC, ":nfkc adverb on quoteforms produces NFKC string type.";
    is "ẛ̣".NFKC.WHAT, NFKC, "Str literal can be converted to NFKC.";

    my $不ЕK̲갂 = q:nfkc'ẛ̣';

    is $不ЕK̲갂.chars, 1, "NFKC.chars returns number of codepoints.";
    is $不ЕK̲갂.codes, 1, "NFKC.codes returns number of codepoints.";

    is $不ЕK̲갂.comb, 'ṩ', "NFKC correctly normalized ẛ̣";

    # note: more "correctly normalized" tests needed, esp. wrt correct order of
    # combining marks.
}

## NFKD

#?rakudo 1 skip 'NFKD type NYI'
{
    is q:nfkd"ẛ̣".WHAT, NFKD, ":nfkd adverb on quoteforms produces NFKD string type.";
    is "ẛ̣".NFKD.WHAT, NFKD, "Str literal can be converted to NFKD.";

    my $不ЕK̲𝐃 = q:nfkd'ẛ̣';

    is $不ЕK̲𝐃.chars, 3, "NFKD.chars returns number of codepoints.";
    is $不ЕK̲𝐃.codes, 3, "NFKD.codes returns number of codepoints.";

    is $不ЕK̲𝐃.comb, <s ̣ ̇>, "NFKD correctly normalized ẛ̣";
}

# vim: expandtab shiftwidth=4
