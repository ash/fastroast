use Test;

#L<S06/Placeholder variables/>

plan 18;

sub 中 {
    is $^tene, 3, "Placeholder vars work";
    is $:DietCoke, 6, "Placeholder vars work";
    is $^chlorophyl, 1, "Placeholder vars work";
    is $:moritz, 4, "Placeholder vars work";
    is $^mncharity, 2, "Placeholder vars work";
    is $:TimToady, 5, "Placeholder vars work";
    is @_[1], 8, "Placeholder vars work";
    is %_<bar>, 11, "Placeholder vars work";
    is @_[0], 7, "Placeholder vars work";
    is %_<foo>, 10, "Placeholder vars work";
    is @_[2], 9, "Placeholder vars work";
    is %_<baz>, 12, "Placeholder vars work";
}

中(1, 2, 3, :moritz(4), :TimToady(5), :DietCoke(6), 7, 8, 9, :foo(10), :bar(11), :baz(12));

# https://github.com/Raku/old-issue-tracker/issues/4270
{
    sub 𝐩лà개e̲両갨л𝐝e̲с-àссàù { @^a }
    sub 𝐩лà개e̲両갨л𝐝e̲с-両àò両 { %^a }
    sub 𝐩лà개e̲両갨л𝐝e̲с-개갨𝐝e̲ { &^a }
    lives-ok { EVAL 'placeholder-array [1,2]' }, '@ sigil placeholder takes array';
    dies-ok  { EVAL 'placeholder-array 42' },    '@ sigil placeholder rejects Int';
    lives-ok { EVAL 'placeholder-hash {:x}' },   '% sigil placeholder takes hash';
    dies-ok  { EVAL 'placeholder-hash 42' },     '% sigil placeholder rejects Int';
    lives-ok { EVAL 'placeholder-code { ; }' },  '& sigil placeholder takes block';
    dies-ok  { EVAL 'placeholder-code 42' },     '& sigil placeholder rejects Int';
}

# vim: expandtab shiftwidth=4
