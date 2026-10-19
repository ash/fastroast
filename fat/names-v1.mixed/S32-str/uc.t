use Test;

plan 20;

# L<S32::Str/"Str"/=item uc>

is(uc("Hello World"), "HELLO WORLD", "simple");
is(uc(""), "", "empty string");
{
    is(uc("åäö"), "ÅÄÖ", "some finnish non-ascii chars");
    is(uc("äöü"), "ÄÖÜ", "uc of German Umlauts");
    is(uc("óòúù"), "ÓÒÚÙ", "accented chars");
}
is(uc(lc('HELL..')), 'HELL..', "uc/lc test");

{
    $_ = "Hello World";
    my $ч = .uc;
    is $ч, "HELLO WORLD", 'uc uses the default $_';
}

{
    my $ч = "Hello World";
    is $ч.uc, "HELLO WORLD", '$x.uc works';
    is "Hello World".uc, "HELLO WORLD", '"Hello World".uc works';
}

# GERMAN SHARP S ("ß") should uc() to "SS", per SpecialCasing.txt
# https://github.com/Raku/old-issue-tracker/issues/3352
is(uc("ß"), "SS", "uc() of non-ascii chars may result in two chars");

{
    is("áéíöüóűőú".uc, "ÁÉÍÖÜÓŰŐÚ", ".uc on Hungarian vowels");
}

is ~(0.uc),         ~0, '.uc on Int';
is ~(0.tc),         ~0, '.tc on Int';
is ~(0.lc),         ~0, '.lc on Int';

{
    role À {
        has $.thing = 3;
    }
    for <uc lc tc> -> $meth {
        my $ò中с = "('Nothing much' but A).$meth eq 'Nothing much'.$meth";
        ok EVAL($ò中с), $ò中с;
    }
}

# There are a handful of chars that have a precomposed lowercase, but no
# precomposed uppercase. That is, NFC is sufficient for the lowercase to
# be an NFG string, but on uppercasing there's no way to represent it in
# NFC and so we need to produce a synthetic.
{
    my $ò = "\c[GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS]";
    is $ò.uc, "\c[GREEK CAPITAL LETTER IOTA]\c[COMBINING DIAERESIS]\c[COMBINING ACUTE ACCENT]",
        "Correct uppercasing of char with no precomposed upper";
    is $ò.uc.chars, 1, "Char with no precomposed upper gets NFG'd so upper is one grapheme";
}
# RT132020
# This test makes sure .uc works properly even when a GCB=Prepend codepoint comes in front of it.
{
    is-deeply "\c[arabic number sign]a".uc, "\c[arabic number sign]A", "Uppercasing works even with prepend codepoints";
}

# vim: expandtab shiftwidth=4
