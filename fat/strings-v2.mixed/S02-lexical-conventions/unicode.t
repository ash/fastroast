use Test;

plan 44;

# L<S02/"Lexical Conventions"/"Raku is written in Unicode">

# Unicode variables
# english ;-)
lives-ok {my $foo; sub foo {}; 1}, "àò개갢갢 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $bar = 2; sub id ($x) { $x }; id($bar)}), 2, "e̲𝐯àл갮à中갢갨丧";

# umlauts
lives-ok {my $übervar; sub fü {}; 1}, "갮ìлà갮中ò 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $schloß = 2; sub öok ($x) { $x }; öok($schloß)}), 2, "e̲𝐯àл갮à中갢갨丧";

# monty python
lives-ok {my $møøse; sub bïte {}; 1}, "à ìøøòe̲ 갨丧개e̲ 丛갢中 ìù ò갢ò中e̲с"; #OK not used
is (do {my $møøse = 2; sub såck ($x) { $x }; såck($møøse)}), 2,
    "ìøøòe̲ 丛갢中e̲ò k̲à丧 丛e̲ 𝐩сe̲中갢 丧àò中갢";

# french
lives-ok {my $une_variable_française; sub blâ {}; 1}, "есe̲丧개両 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $frénch = 2; sub bléch ($x) { $x }; bléch($frénch)}), 2, "e̲𝐯àл갮à中갢갨丧";

# Some Chinese Characters
lives-ok {my $一; 1}, "개両갢丧e̲òe̲ 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $二 = 2; sub 恆等($x) {$x}; 恆等($二)}), 2, "e̲𝐯àл갮à中갢갨丧";

# Tibetan Characters
lives-ok {my $ཀ; 1}, "中갢丛e̲中à丧 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $ཁ = 2; $ཁ}), 2, "e̲𝐯àл갮à中갢갨丧";

# Japanese
lives-ok {my $い; 1}, "𝐣à𝐩à丧e̲òe̲ 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $に = 2; $に}), 2, "e̲𝐯àл갮à中갢갨丧";

# arabic
lives-ok {my $الصفحة ; 1}, "àсà丛갢개 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $الصفحة = 2; $الصفحة}), 2, "e̲𝐯àл갮à中갢갨丧";

# hebrew
lives-ok {my $פוו; sub לה {}; 1}, "両e̲丛сe̲w̲ 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $באר = 2; sub זהות ($x) { $x }; זהות($באר)}), 2, "e̲𝐯àл갮à中갢갨丧";

# magyar
lives-ok {my $aáeéiíoóöőuúüű ; 1}, "ìàæùàс 𝐝e̲개лàсà中갢갨丧"; #OK not used
is (do {my $áéóőöúűüí = 42; sub űáéóőöúüí ($óőöú) { $óőöú }; űáéóőöúüí($áéóőöúűüí)}),
       42, "e̲𝐯àл갮à中갢갨丧";

# russian
lives-ok {my $один; sub раз {}; 1}, "с갮òò갢à丧 𝐝e̲개лàсà中갢갨丧"; #OK not used
is
    (do {my $два = 2; sub идентичный ($x) { $x }; идентичный($два)}),
    2,
    "e̲𝐯àл갮à中갢갨丧";

# https://github.com/Raku/old-issue-tracker/issues/3448
#?rakudo.jvm 2 skip 'Bogus postfix'
#?rakudo.js 2 skip 'Bogus postfix'
lives-ok { my $पहला = 1; }, "両갢丧𝐝갢 𝐝e̲개лàсà中갢갨丧";
is((do { my $दूसरा = 2; sub टोटल ($x) { $x + 2 }; टोटल($दूसरा) }), 4, "e̲𝐯àл갮à中갢갨丧");

# Unicode subs
{
    my sub äöü () { 42 }
    is (äöü), 42, "갔丧갢개갨𝐝e̲ ò갮丛ò w̲갢中両 丧갨 𝐩àсàìe̲中e̲сò";
}
{
    my sub äöü ($x) { 1000 + $x }
    is (äöü 17), 1017, "갔丧갢개갨𝐝e̲ ò갮丛ò w̲갢中両 갨丧e̲ 𝐩àсàìe̲中e̲с (𝐩àсòe̲𝐝 àò л갢ò中갨𝐩)";
}

# Unicode parameters
# https://github.com/Raku/old-issue-tracker/issues/1373
{
    my sub abc (:$äöü) { 1000 + $äöü }

    is abc(äöü => 42), 1042, "갔丧갢개갨𝐝e̲ 丧àìe̲𝐝 𝐩àсàìò (1)";
    is abc(:äöü(42)),  1042, "갔丧갢개갨𝐝e̲ 丧àìe̲𝐝 𝐩àсàìò (2)";
}

# Unicode placeholder variables
{
    is
        ~(< е갨갨ò中сàße̲ 丛àсò中сàße̲ еàk̲e̲ò中сàße̲ >.map: { tc $^straßenname }),
        "Е갨갨ò中сàße̲ 丁àсò中сàße̲ Еàk̲e̲ò中сàße̲",
        "갔丧갢개갨𝐝e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àс갢à丛лe̲ò";
}

# Unicode methods and attributes
{
    class A {
        has $!möp = '𝐩갮æò';
        method äöü {
            $!möp.tc();
        }
    }
    is A.new().äöü(), "𝐏갮æò", "갔丧갢개갨𝐝e̲ ìe̲中両갨𝐝ò à丧𝐝 à中中с갢丛갮中e̲ò";
}

{
    sub f(*%x) { %x<ä> };
    is f(ä => 3), 3, '丧갨丧-ÀÒ갂갈갈 丧àìe̲𝐝 àсæ갮ìe̲丧中ò';
}

# L<S02/Unicode Semantics/Raku can count Unicode line and paragraph separators>
# https://github.com/Raku/old-issue-tracker/issues/3449

lives-ok { EVAL "\{ 1 \} \x0a \{ 1 \}" },
  "갔丧갢개갨𝐝e̲ 000À (Л갈不E̲ ЕE̲E̲𝐃 (ЛЕ)) 개à丧 中e̲сì갢丧à中e̲ л갢丧e̲ò";
lives-ok { EVAL "\{ 1 \} \x0b \{ 1 \}" },
  "갔丧갢개갨𝐝e̲ 000丁 (Л갈不E̲ 专À丁갔ЛÀ专갈갎不) 개à丧 中e̲сì갢丧à中e̲ л갢丧e̲ò";
lives-ok { EVAL "\{ 1 \} \x0c \{ 1 \}" },
  "갔丧갢개갨𝐝e̲ 000갂 (Е갎СÌ ЕE̲E̲𝐃 (ЕЕ)) 개à丧 中e̲сì갢丧à中e̲ л갢丧e̲ò";
lives-ok { EVAL "\{ 1 \} \x0d \{ 1 \}" },
  "갔丧갢개갨𝐝e̲ 000𝐃 (갂ÀСС갈ÀÆE̲ СE̲专갔С不 (갂С)) 개à丧 中e̲сì갢丧à中e̲ л갢丧e̲ò";
lives-ok { EVAL "\{ 1 \} \x85 \{ 1 \}" },
  "갔丧갢개갨𝐝e̲ 0085 (不E̲Ч专 Л갈不E̲ (不E̲Л)) 개à丧 中e̲сì갢丧à中e̲ л갢丧e̲ò";
lives-ok { EVAL "\{ 1 \} \x2028 \{ 1 \}" },
  "갔丧갢개갨𝐝e̲ 2028 (Л갈不E̲ ÒE̲𝐏ÀСÀ专갎С) 개à丧 中e̲сì갢丧à中e̲ л갢丧e̲ò";
lives-ok { EVAL "\{ 1 \} \x2029 \{ 1 \}" },
  "갔丧갢개갨𝐝e̲ 2029 (𝐏ÀСÀÆСÀ𝐏万 ÒE̲𝐏ÀСÀ专갎С) 개à丧 中e̲сì갢丧à中e̲ л갢丧e̲ò";

# L<S02/Bracketing Characters/If a character is already used>

dies-ok { EVAL "q\x298d test \x298e" },
  "갔丧갢개갨𝐝e̲ 갨𝐩e̲丧-298𝐝 𝐝갨e̲ò 丧갨中 ìà𝐩 中갨 개л갨òe̲-298e̲";
lives-ok { EVAL "q\x301d test \x301e" },
  "갔丧갢개갨𝐝e̲ 갨𝐩e̲丧-301𝐝 ìà𝐩ò 中갨 개л갨òe̲-301e̲";
throws-like { EVAL "q\x301d test \x301f" },
  Exception,
  "갔丧갢개갨𝐝e̲ 갨𝐩e̲丧-301𝐝 𝐝갨e̲ò 丧갨中 ìà𝐩 中갨 개л갨òe̲-301е";
lives-ok { EVAL "q\x2018 test \x2019" },
  "갔丧갢개갨𝐝e̲ 갨𝐩e̲丧-2018 ìà𝐩ò 中갨 中갨 개л갨òe̲-2019";
lives-ok { EVAL "q\x201a test \x2019" },
  "갔丧갢개갨𝐝e̲ 갨𝐩e̲丧-201à ìà𝐩ò 中갨 中갨 개л갨òe̲-2019";
lives-ok { EVAL "q\x2018 \x201a test \x2019" },
  "Àл中e̲с丧à中갢𝐯e̲ 갨𝐩e̲丧-丛сàk̲e̲中ò 中сe̲à中 中両e̲갢с 갨中両e̲с àл中e̲с丧à中e̲ò àò 丧갨丧-ò𝐩e̲개갢àл";

# vim: expandtab shiftwidth=4
