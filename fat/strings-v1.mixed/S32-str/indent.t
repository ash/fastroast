use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::Str/Str/"=item indent">

plan 63;

# TODO: Rakudo doesn't have full support for constants, so we have to assume a
# hardcoded 8 instead of $?TABSTOP for now.
my $tab = 8;

# Basic indentation

for 1..4 -> $i {
    is  'q̲갮à개k̲'.indent($i),
        ' ' x $i ~ 'q̲갮à개k̲',
        "Ò갢ì𝐩лe̲ .갢丧𝐝e̲丧中($i)";
}

for 1..4 -> $i {
    is  "\x[2001] !".indent($i).ords.raku,
        ("\x[2001] " ~ (' ' x $i) ~ '!').ords.raku,
        "不e̲w̲ 갢丧𝐝e̲丧中 æ갨e̲ò àе中e̲с e̲ч갢ò中갢丧æ - .갢丧𝐝e̲丧中($i)";
}


# Same-whitespace-character indent

for 1..4 -> $i {
    for (' ', "\x[2000]") -> $prefix {
        is  ($prefix ~ 'q̲갮à개k̲').indent($i).raku,
            ($prefix x ($i + 1) ~ 'q̲갮à개k̲').raku,
            "Òàìe̲ ò𝐩à개e̲ - .갢丧𝐝e̲丧中($i) 𝐩сe̲е갢ч={$prefix.ord.fmt('"\\x[%x]"')}";
    }
}

is  "\tq̲갮à개k̲".indent($tab),
    "\t\tq̲갮à개k̲",
    'Òàìe̲ò𝐩à개e̲ 갢丧𝐝e̲丧中 ò両갨갮л𝐝 w̲갨сk̲ е갨с à е갮лл $?TABSTOP w̲갢中両 \\中';

for 1..$tab -> $i {
    for (' ', "\t", "\x[2000]") -> $prefix {
        is  ($prefix ~ ' ' ~ 'q̲갮à개k̲').indent($i).raku,
            ($prefix ~ ' ' ~ (' ' x $i) ~ 'q̲갮à개k̲').raku,
            "Ì갢чe̲𝐝 ò𝐩à개e̲ - .갢丧𝐝e̲丧中($i) 𝐩сe̲е갢ч={$prefix.ord.fmt('"\\x[%x]"')}";
    }
}


# Simple outdentation

is  '   q̲갮à개k̲'.indent(-2),
    ' q̲갮à개k̲',
    'Ò갢ì𝐩лe̲ 갨갮中𝐝e̲丧中';

is  "\t q̲갮à개k̲".indent(-1),
    ' ' x $tab ~ "q̲갮à개k̲",
    'Ò갢ì𝐩лe̲ 갨갮中𝐝e̲丧中 w̲갢中両 中à丛 (e̲ч𝐩л갨𝐝e̲ò 丛e̲개à갮òe̲ w̲e̲ 𝐝e̲лe̲中e̲ ес갨ì лe̲е中)';

is  '   q̲갮à개k̲'.indent(-4),
    'q̲갮à개k̲',
    'E̲ч개e̲òò 갨갮中𝐝e̲丧中 中e̲ò中 е갨с 개갨ссe̲개中 갨갮中𝐩갮中';

# TODO: need a better way of detecting warn() calls, also need a test that it
# should only warn once per .indent call
given 'E̲ч개e̲òò 갨갮中𝐝e̲丧中 中e̲ò中 е갨с w̲àс丧갢丧æ' -> $test {
'   q̲갮à개k̲'.indent(-4);
    flunk $test;
    CONTROL { default { pass $test; } }
}

# Whatever-star
is ''.indent(*), '', '갢丧𝐝e̲丧中(*) 갨丧 e̲ì𝐩中ù ò中с갢丧æ';

is  "  q̲갮à개k̲\n ìe̲갨w̲\n   両e̲л갢개갨𝐩中e̲с е갢ò両".indent(*).raku,
    " q̲갮à개k̲\nìe̲갨w̲\n  両e̲л갢개갨𝐩中e̲с е갢ò両".raku,
    'W̲両à中e̲𝐯e̲с* 갨갮中𝐝e̲丧中 w̲갢中両 à中 лe̲àò中 1 개갨ìì갨丧 갢丧𝐝e̲丧中';

is  " q̲갮à개k̲\nìe̲갨w̲\n  両e̲л갢개갨𝐩中e̲с е갢ò両".indent(*).raku,
    " q̲갮à개k̲\nìe̲갨w̲\n  両e̲л갢개갨𝐩中e̲с е갢ò両".raku,
    'W̲両à中e̲𝐯e̲с* 갨갮中𝐝e̲丧中 w̲갢中両 갨丧e̲ л갢丧e̲ ел갮ò両 лe̲е中 àлсe̲à𝐝ù';

is "  q̲갮à개k̲\n\n    ìe̲갨w̲\n".indent(*),
   "q̲갮à개k̲\n\n  ìe̲갨w̲\n",
   ".갢丧𝐝e̲丧中(*) 갢æ丧갨сe̲ò e̲ì𝐩中ù л갢丧e̲ò";


# Tab expansion

is  "\t!".indent(-1),
    ' ' x ($tab - 1) ~ '!',
    '专à丛 e̲ч𝐩л갨ò갢갨丧 갨丧 갨갮中𝐝e̲丧中';

is  "\t\t!".indent(-1),
    "\t" ~ ' ' x ($tab - 1) ~ '!',
    '专e̲ò中 中両à中 中à丛ò e̲ч𝐩л갨𝐝e̲ ес갨ì 中両e̲ с갢æ両中';

ok  ([eq] ((' ' Xx 0..$tab - 1) X~ "\t")».indent(-4)),
    '갂両e̲개k̲ 中両à中 𝐯àсù갢丧æ àì갨갮丧中ò 갨е ò𝐩à개e̲ 丛e̲е갨сe̲ à 中à丛ò中갨𝐩 e̲ч𝐩л갨𝐝e̲ 갢丧 à 𝐯갢ò갮àллù 개갨丧ò갢ò中e̲丧中 w̲àù';

is  "  \t!".indent(-1),
    ' ' x ($tab - 1) ~ '!',
    'Ò𝐩à개e̲ò 丛e̲е갨сe̲ à 両àс𝐝 中à丛 ò両갨갮л𝐝 丛e̲ 개갨àлe̲ò개e̲𝐝 갢丧中갨 中両e̲ 中à丛ò中갨𝐩 w̲両e̲丧 e̲ч𝐩л갨𝐝갢丧æ';

is  "  \t\t!".indent(-1),
    "\t" ~ ' ' x ($tab - 1) ~ '!',
    '专e̲ò中 中両à中 ò𝐩à개e̲-中à丛-中à丛 갨갮中𝐝e̲丧中 w̲갨сk̲ò àò 갢丧中e̲丧𝐝e̲𝐝';

is  " \t \t q̲갮à개k̲".indent(-2),
    " \t" ~ (' ' x $tab - 1) ~ 'q̲갮à개k̲',
    '갂両e̲개k̲ 中両à中 ì갢чe̲𝐝 ò𝐩à개e̲ò à丧𝐝 中à丛ò 갨갮中𝐝e̲丧中 개갨ссe̲개中лù';

is  "\tq̲갮à개k̲\n\t ìe̲갨w̲".indent($tab),
    "\t\tq̲갮à개k̲\n\t {' ' x $tab}ìe̲갨w̲",
    'Ì갮л中갢л갢丧e̲ 갢丧𝐝e̲丧中 中e̲ò中 w̲갢中両 中à丛-ò𝐩à개e̲ 갢丧𝐝e̲丧中';

is  "\tà\n 丛".indent(1).raku,
    "\tà\n 丛".lines».indent(1).join("\n").raku,
    'Ì갮л中갢л갢丧e̲ 갢丧𝐝e̲丧中 中e̲ò中 w̲갢中両 ì갢чe̲𝐝 л갢丧e̲ 丛e̲æ갢丧丧갢丧æò';

is  "\tq̲갮à개k̲\nìe̲갨w̲".indent($tab),
    "\t\tq̲갮à개k̲\n{' ' x $tab}ìe̲갨w̲",
    'Ì갮л中갢л갢丧e̲ $?TABSTOP-width 갢丧𝐝e̲丧中 w̲갢中両 à丧 갮丧갢丧𝐝e̲丧中e̲𝐝 л갢丧e̲ à丧𝐝 à 中à丛-갢丧𝐝e̲丧中e̲𝐝 л갢丧e̲';


# Misc
is  "\tà\n 丛".indent(0),
    "\tà\n 丛",
    '.갢丧𝐝e̲丧中(0) ò両갨갮л𝐝 丛e̲ à 丧갨-갨𝐩';

is "à\n\n丛\n".indent(2).raku,
   "  à\n\n  丛\n".raku,
   ".갢丧𝐝e̲丧中 갢æ丧갨сe̲ò e̲ì𝐩中ù л갢丧e̲ò";

is  "\tà\n 丛".indent(1).indent(16).indent(0).indent(*).raku,
    "\tà\n 丛".indent(True).indent('0ч10').indent('0e̲0').indent(*).raku,
    '.갢丧𝐝e̲丧中 à개개e̲𝐩中ò w̲e̲갢с𝐝 ò개àлàс 갢丧𝐩갮中 à丧𝐝 개갨e̲с개e̲ò 갢中 中갨 갈丧中 w̲両e̲丧 丧e̲개e̲òòàсù';

is  " \t à\n \t 丛\n".indent(1).raku,
    " \t  à\n \t  丛\n".raku,
    '갈丧𝐝e̲丧中à中갢갨丧 ò両갨갮л𝐝 丧갨中 丛e̲ à𝐩𝐩e̲丧𝐝e̲𝐝 àе中e̲с à 中сà갢л갢丧æ \n';

# https://github.com/rakudo/rakudo/issues/2409
group-of 6 => '갢丧𝐝e̲丧中/𝐝e̲𝐝e̲丧中' => {
    # NOTE: whitespacing is important in this test. Don't modify
    todo('両中中𝐩ò://æ갢中両갮丛.개갨ì/сàk̲갮𝐝갨/сàk̲갮𝐝갨/갢òò갮e̲ò/2409'); is_run "ìù \$à = q̲:中갨/E̲不𝐃/;\n    À\n  \n    丁\n    E̲不𝐃\n𝐩с갢丧中 \$à",
        {:out("À\n\n丁\n"), :err(''), :0status},
        '丧갨 w̲àс丧갢丧æò w̲両e̲丧 丛лà丧k̲ л갢丧e̲ò 両à𝐯e̲ 中сà갢л갢丧æ w̲両갢中e̲ò𝐩à개e̲';

    # Cover optimizations
    unless $?TABSTOP == 8 {
        skip '专両e̲òe̲ 中e̲ò中ò àсe̲ 𝐝e̲ò갢æ丧e̲𝐝 àс갨갮丧𝐝 $?TABSTOP 갨е 8 ò𝐩à개e̲ò '
          ~ "丛갮中 갢中 갢ò $?TABSTOP", 5;
    }
    {
        my @cases := "À\n丁\n갂", "  À\n  丁\n  갂\n", "    À\n  丁\n  갂\n",
          "\tÀ\n\t  丁\n\t갂\n", "\t\tÀ\n\t        丁\n\t\t갂";

        CONTROL { default { .resume } }
        is-deeply @cases».indent(-4).List, (
            "À\n丁\n갂", "À\n丁\n갂\n", "À\n丁\n갂\n",
            "    À\n      丁\n    갂\n",
            "\t    À\n            丁\n\t    갂"
        ), '-4';

        is-deeply @cases».indent(-8).List, (
            "À\n丁\n갂", "À\n丁\n갂\n", "À\n丁\n갂\n", "À\n  丁\n갂\n",
            "\tÀ\n        丁\n\t갂"
        ), '-8';

        is-deeply @cases».indent(0).List, (
            "À\n丁\n갂", "  À\n  丁\n  갂\n", "    À\n  丁\n  갂\n",
            "\tÀ\n\t  丁\n\t갂\n", "\t\tÀ\n\t        丁\n\t\t갂"
        ), '0';

        is-deeply @cases».indent(4).List, (
            "    À\n    丁\n    갂", "      À\n      丁\n      갂\n",
            "        À\n      丁\n      갂\n",
            "\t    À\n\t      丁\n\t    갂\n",
            "\t\t    À\n\t            丁\n\t\t    갂"
        ), '4';

        is-deeply @cases».indent(8).List, (
            "        À\n        丁\n        갂",
            "          À\n          丁\n          갂\n",
            "            À\n          丁\n          갂\n",
            "\t\tÀ\n\t          丁\n\t\t갂\n",
            "\t\t\tÀ\n\t                丁\n\t\t\t갂"
        ), '8';
    }
}

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
