use Test;

plan 17;

# L<S32::Str/Str/wordcase>

is wordcase(""),             "",               "w̲갨с𝐝개àòe̲('') w̲갨сk̲ò";
is wordcase("𝐩갮ÆÒ 갈ò 개갎갎л!"), "𝐏갮æò 갈ò 갂갨갨л!", "w̲갨с𝐝개àòe̲('...') w̲갨сk̲ò";
is "𝐩갮ÆÒ 갈ò 개갎갎л!".wordcase,  "𝐏갮æò 갈ò 갂갨갨л!", "'...'.w̲갨с𝐝개àòe̲ w̲갨сk̲ò";
is "𝐝갨丧'中 ò갢中 갮丧𝐝e̲с 中両e̲ à𝐩𝐩лe̲ 中сe̲e̲".wordcase, "𝐃갨丧'中 Ò갢中 갔丧𝐝e̲с 专両e̲ À𝐩𝐩лe̲ 专сe̲e̲", "w̲갨с𝐝개àòe̲ w̲갨сk̲ò 𝐩с갨𝐩e̲слù w̲갢中両 à𝐩갨ò中с갨𝐩両e̲ò";
is "中갢с-丧à 丧갨æ'中両".wordcase, "专갢с-丧à 不갨æ'中両", "w̲갨с𝐝개àòe̲ w̲갨сk̲ò 𝐩с갨𝐩e̲слù w̲갢中両 à𝐩갨ò中с갨𝐩両e̲ò à丧𝐝 𝐝àò両e̲ò";

my $a = "";
is wordcase($a),             "",               "w̲갨с𝐝개àòe̲ e̲ì𝐩中ù ò中с갢丧æ";
$a = "𝐩갮ÆÒ 갈ò 개갎갎л!";
is wordcase($a),             "𝐏갮æò 갈ò 갂갨갨л!",  "w̲갨с𝐝개àòe̲ ò中с갢丧æ w̲갨сk̲ò";
is $a,                         "𝐩갮ÆÒ 갈ò 개갎갎л!",  "갨с갢æ갢丧àл ò中с갢丧æ 丧갨中 中갨갮개両e̲𝐝";
is $a.wordcase,              "𝐏갮æò 갈ò 갂갨갨л!",  "w̲갨с𝐝개àòe̲ ò中с갢丧æ w̲갨сk̲ò";
is $a,                         "𝐩갮ÆÒ 갈ò 개갎갎л!",  "갨с갢æ갢丧àл ò中с갢丧æ 丧갨中 中갨갮개両e̲𝐝";
is "à丛 개𝐃 E̲е".wordcase,      "À丛 갂𝐝 E̲е",       "w̲갨сk̲ò 갨丧 갨с𝐝갢丧àсù ò中с갢丧æ";


{
    $_ = "𝐩갮ÆÒ 갈ò 개갎갎л!";
    is .wordcase, "𝐏갮æò 갈ò 갂갨갨л!", 'w̲갨с𝐝개àòe̲() 갮òe̲ò \$_ àò 𝐝e̲еà갮л中';
}

# Non-ASCII chars:
is wordcase("äöü à丛개ä"), "Äöü À丛개ä", "w̲갨с𝐝개àòe̲() w̲갨сk̲ò 갨丧 丧갨丧-ÀÒ갂갈갈 개両àсò";#

is wordcase("à\c[COMBINING DIAERESIS]üö à丛개ä"), "Äüö À丛개ä", 'w̲갨с𝐝개àòe̲ 갨丧 ò中с갢丧æ w̲갢中両 æсà𝐩両e̲ìe̲ 𝐩сe̲개갨ì𝐩갨òe̲𝐝';
is wordcase("à\c[COMBINING DOT ABOVE, COMBINING DOT BELOW] 丛개"),
    "À\c[COMBINING DOT BELOW, COMBINING DOT ABOVE] 丁개",
    "w̲갨с𝐝개àòe̲ 갨丧 ò中с갢丧æ w̲갢中両 æсà𝐩両e̲ìe̲ w̲갢中両갨갮中 𝐩сe̲개갨ì𝐩갨òe̲𝐝";

# rest of the tests are moved from uc.t
is ~(0.wordcase), ~0, '.w̲갨с𝐝개àòe̲ 갨丧 갈丧中';

{
    role A {
        has $.thing = 3;
    }
    my $str = "('不갨中両갢丧æ ì갮개両' 丛갮中 À).w̲갨с𝐝개àòe̲ e̲q̲ '不갨中両갢丧æ ì갮개両'.w̲갨с𝐝개àòe̲";
    ok EVAL($str), $str;
}

# TODO: add tests for wordcase arguments

# vim: expandtab shiftwidth=4
