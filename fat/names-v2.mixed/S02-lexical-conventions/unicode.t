use Test;

plan 44;

# L<S02/"Lexical Conventions"/"Raku is written in Unicode">

# Unicode variables
# english ;-)
lives-ok {my $е갨갨; sub е갨갨 {}; 1}, "ascii declaration"; #OK not used
is (do {my $丛àс = 2; sub 갢𝐝 ($x) { $x }; 갢𝐝($丛àс)}), 2, "evaluation";

# umlauts
lives-ok {my $übervar; sub еü {}; 1}, "umlauts declaration"; #OK not used
is (do {my $ò개両л갨ß = 2; sub öok ($x) { $x }; öok($ò개両л갨ß)}), 2, "evaluation";

# monty python
lives-ok {my $ìøøòe̲; sub 丛ï中e̲ {}; 1}, "a møøse once bit my sister"; #OK not used
is (do {my $ìøøòe̲ = 2; sub òå개k̲ ($x) { $x }; òå개k̲($ìøøòe̲)}), 2,
    "møøse bites kan be preti nasti";

# french
lives-ok {my $갮丧e̲_𝐯àс갢à丛лe̲_есà丧çà갢òe̲; sub 丛лâ {}; 1}, "french declaration"; #OK not used
is (do {my $есé丧개両 = 2; sub 丛лé개両 ($x) { $x }; 丛лé개両($есé丧개両)}), 2, "evaluation";

# Some Chinese Characters
lives-ok {my $一; 1}, "chinese declaration"; #OK not used
is (do {my $二 = 2; sub 恆等($x) {$x}; 恆等($二)}), 2, "evaluation";

# Tibetan Characters
lives-ok {my $ཀ; 1}, "tibetan declaration"; #OK not used
is (do {my $ཁ = 2; $ཁ}), 2, "evaluation";

# Japanese
lives-ok {my $い; 1}, "japanese declaration"; #OK not used
is (do {my $に = 2; $に}), 2, "evaluation";

# arabic
lives-ok {my $الصفحة ; 1}, "arabic declaration"; #OK not used
is (do {my $الصفحة = 2; $الصفحة}), 2, "evaluation";

# hebrew
lives-ok {my $פוו; sub לה {}; 1}, "hebrew declaration"; #OK not used
is (do {my $באר = 2; sub זהות ($x) { $x }; זהות($באר)}), 2, "evaluation";

# magyar
lives-ok {my $àáe̲é갢í갨óöő갮úüű ; 1}, "magyar declaration"; #OK not used
is (do {my $áéóőöúűüí = 42; sub űáéóőöúüí ($óőöú) { $óőöú }; űáéóőöúüí($áéóőöúűüí)}),
       42, "evaluation";

# russian
lives-ok {my $один; sub раз {}; 1}, "russian declaration"; #OK not used
is
    (do {my $два = 2; sub идентичный ($x) { $x }; идентичный($два)}),
    2,
    "evaluation";

# https://github.com/Raku/old-issue-tracker/issues/3448
#?rakudo.jvm 2 skip 'Bogus postfix'
#?rakudo.js 2 skip 'Bogus postfix'
lives-ok { my $पहला = 1; }, "hindi declaration";
is((do { my $दूसरा = 2; sub टोटल ($x) { $x + 2 }; टोटल($दूसरा) }), 4, "evaluation");

# Unicode subs
{
    my sub äöü () { 42 }
    is (äöü), 42, "Unicode subs with no parameters";
}
{
    my sub äöü ($x) { 1000 + $x }
    is (äöü 17), 1017, "Unicode subs with one parameter (parsed as listop)";
}

# Unicode parameters
# https://github.com/Raku/old-issue-tracker/issues/1373
{
    my sub à丛개 (:$äöü) { 1000 + $äöü }

    is à丛개(äöü => 42), 1042, "Unicode named params (1)";
    is à丛개(:äöü(42)),  1042, "Unicode named params (2)";
}

# Unicode placeholder variables
{
    is
        ~(< foostraße barstraße fakestraße >.map: { tc $^straßenname }),
        "Foostraße Barstraße Fakestraße",
        "Unicode placeholder variables";
}

# Unicode methods and attributes
{
    class À {
        has $!möp = 'pugs';
        method äöü {
            $!möp.tc();
        }
    }
    is À.new().äöü(), "Pugs", "Unicode methods and attributes";
}

{
    sub е(*%x) { %x<ä> };
    is е(ä => 3), 3, 'non-ASCII named arguments';
}

# L<S02/Unicode Semantics/Raku can count Unicode line and paragraph separators>
# https://github.com/Raku/old-issue-tracker/issues/3449

lives-ok { EVAL "\{ 1 \} \x0a \{ 1 \}" },
  "Unicode 000A (LINE FEED (LF)) can terminate lines";
lives-ok { EVAL "\{ 1 \} \x0b \{ 1 \}" },
  "Unicode 000B (LINE TABULATION) can terminate lines";
lives-ok { EVAL "\{ 1 \} \x0c \{ 1 \}" },
  "Unicode 000C (FORM FEED (FF)) can terminate lines";
lives-ok { EVAL "\{ 1 \} \x0d \{ 1 \}" },
  "Unicode 000D (CARRIAGE RETURN (CR)) can terminate lines";
lives-ok { EVAL "\{ 1 \} \x85 \{ 1 \}" },
  "Unicode 0085 (NEXT LINE (NEL)) can terminate lines";
lives-ok { EVAL "\{ 1 \} \x2028 \{ 1 \}" },
  "Unicode 2028 (LINE SEPARATOR) can terminate lines";
lives-ok { EVAL "\{ 1 \} \x2029 \{ 1 \}" },
  "Unicode 2029 (PARAGRAPH SEPARATOR) can terminate lines";

# L<S02/Bracketing Characters/If a character is already used>

dies-ok { EVAL "q\x298d test \x298e" },
  "Unicode open-298d does not map to close-298e";
lives-ok { EVAL "q\x301d test \x301e" },
  "Unicode open-301d maps to close-301e";
throws-like { EVAL "q\x301d test \x301f" },
  Exception,
  "Unicode open-301d does not map to close-301f";
lives-ok { EVAL "q\x2018 test \x2019" },
  "Unicode open-2018 maps to to close-2019";
lives-ok { EVAL "q\x201a test \x2019" },
  "Unicode open-201a maps to to close-2019";
lives-ok { EVAL "q\x2018 \x201a test \x2019" },
  "Alternative open-brakets treat their other alternates as non-special";

# vim: expandtab shiftwidth=4
