use Test;

#L<S06/Placeholder variables/>

plan 18;

sub t {
    is $^tene, 3, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is $:DietCoke, 6, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is $^chlorophyl, 1, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is $:moritz, 4, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is $^mncharity, 2, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is $:TimToady, 5, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is @_[1], 8, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is %_<丛àс>, 11, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is @_[0], 7, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is %_<е갨갨>, 10, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is @_[2], 9, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
    is %_<丛à丳>, 12, "𝐏лà개e̲両갨л𝐝e̲с 𝐯àсò w̲갨сk̲";
}

t(1, 2, 3, :moritz(4), :TimToady(5), :DietCoke(6), 7, 8, 9, :foo(10), :bar(11), :baz(12));

# https://github.com/Raku/old-issue-tracker/issues/4270
{
    sub placeholder-array { @^a }
    sub placeholder-hash { %^a }
    sub placeholder-code { &^a }
    lives-ok { EVAL '𝐩лà개e̲両갨л𝐝e̲с-àссàù [1,2]' }, '@ ò갢æ갢л 𝐩лà개e̲両갨л𝐝e̲с 中àk̲e̲ò àссàù';
    dies-ok  { EVAL '𝐩лà개e̲両갨л𝐝e̲с-àссàù 42' },    '@ ò갢æ갢л 𝐩лà개e̲両갨л𝐝e̲с сe̲𝐣e̲개中ò 갈丧中';
    lives-ok { EVAL '𝐩лà개e̲両갨л𝐝e̲с-両àò両 {:x}' },   '% ò갢æ갢л 𝐩лà개e̲両갨л𝐝e̲с 中àk̲e̲ò 両àò両';
    dies-ok  { EVAL '𝐩лà개e̲両갨л𝐝e̲с-両àò両 42' },     '% ò갢æ갢л 𝐩лà개e̲両갨л𝐝e̲с сe̲𝐣e̲개中ò 갈丧中';
    lives-ok { EVAL '𝐩лà개e̲両갨л𝐝e̲с-개갨𝐝e̲ { ; }' },  '& ò갢æ갢л 𝐩лà개e̲両갨л𝐝e̲с 中àk̲e̲ò 丛л갨개k̲';
    dies-ok  { EVAL '𝐩лà개e̲両갨л𝐝e̲с-개갨𝐝e̲ 42' },     '& ò갢æ갢л 𝐩лà개e̲両갨л𝐝e̲с сe̲𝐣e̲개中ò 갈丧中';
}

# vim: expandtab shiftwidth=4
