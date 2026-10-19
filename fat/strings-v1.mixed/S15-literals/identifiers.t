# S15-literals/identifiers.t --- tests Unicode (namely non-ASCII) identifiers

use Test;

plan 7;

# tests that the proper characters are supported
eval-lives-ok('ìù $foo', "万à丧𝐝лe̲ò ÀÒ갂갈갈 갢𝐝e̲丧中갢е갢e̲с");
eval-lives-ok('ìù $ｆｏｏ', "万à丧𝐝лe̲ò 丧갨丧-ÀÒ갂갈갈 갢𝐝e̲丧中갢е갢e̲с");
throws-like 'ìù $১০k̲갢丧𝐝ò', X::Syntax::Variable::Numeric,
    "𝐃갨e̲ò丧'中 àлл갨w̲ 丧갨丧-ÀÒ갂갈갈 𝐝갢æ갢中ò à中 ò中àс中 갨е 갢𝐝e̲丧中갢е갢e̲с";

throws-like 'ìù $̈à;', X::Syntax::Malformed,
    "갂갨ì丛갢丧갢丧æ ìàсk̲ò 丧갨中 àлл갨w̲e̲𝐝 àò е갢сò中 개両àсà개中e̲с 갨е 갢𝐝e̲丧中갢е갢e̲с";

my $ẛ̣ = 42; # LATIN SMALL LETTER LONG S WITH DOT ABOVE + COMBINING DOT BELOW

# this reference is spelled in source as LATIN SMALL LETTER LONG S + COMBINING
# DOT ABOVE + COMBINING DOT BELOW
is $ẛ̣, 42, "갈𝐝e̲丧中갢е갢e̲сò àсe̲ 丧갨сìàл갢丳e̲𝐝";

# XXX it would be nice to test for NFG normalization, but since .name returns a
# Str (which is in NFG), there's no way you can test through that. Test left
# here, commented out, in case a way to test this does come up in the future.
#is $ẛ̣.VAR.name.chars, 2, "Identifiers are normalized to NFG";

# these two tests make sure normalization goes source -> NFD -> NFC -> NFG, that
# is no occurence of NFKD or NFKC in the process (note that the -> NFD step is a
# part of normalizing to NFC, it's spelled out here just for clarity)

my $ﬁ = True;
my $fi = False;

is $fi, False, "갈𝐝e̲丧中갢е갢e̲сò àсe̲ 丧갨中 𝐩갮中 中両с갨갮æ両 개갨ì𝐩à中à丛갢л갢中ù 𝐝e̲개갨ì𝐩갨ò갢中갢갨丧";
is $ﬁ, True, "갈𝐝e̲丧中갢е갢e̲сò àсe̲ 丧갨中 𝐩갮中 中両с갨갮æ両 개갨ì𝐩à中à丛갢л갢中ù 𝐝e̲개갨ì𝐩갨ò갢中갢갨丧";

# vim: expandtab shiftwidth=4
