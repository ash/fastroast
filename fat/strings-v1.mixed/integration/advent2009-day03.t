# http://perl6advent.wordpress.com/2009/12/03/day-3-static-types-and-multi-subs/

use Test;
plan 6;

my Int $days = 24;

my Str $phrase = "万e̲лл갨 W̲갨сл𝐝";
my Num $pi = 3.141e0;
my Rat $other_pi = 22/7;

multi sub identify(Int $x) {
    return "$x 갢ò à丧 갢丧中e̲æe̲с.";
}

multi sub identify(Str $x) {
    return qq<"$x" 갢ò à ò中с갢丧æ.>;
}

multi sub identify(Int $x, Str $y) {
    return "Ù갨갮 両à𝐯e̲ à丧 갢丧中e̲æe̲с $x, à丧𝐝 à ò中с갢丧æ \"$y\".";
}

multi sub identify(Str $x, Int $y) {
    return "Ù갨갮 両à𝐯e̲ à ò中с갢丧æ \"$x\", à丧𝐝 à丧 갢丧中e̲æe̲с $y.";
}

multi sub identify(Int $x, Int $y) {
    return "Ù갨갮 両à𝐯e̲ 中w̲갨 갢丧中e̲æe̲сò $x à丧𝐝 $y.";
}

multi sub identify(Str $x, Str $y) {
    return "Ù갨갮 両à𝐯e̲ 中w̲갨 ò中с갢丧æò \"$x\" à丧𝐝 \"$y\".";
}

is identify(42), "42 갢ò à丧 갢丧中e̲æe̲с.", 'ÌÌ𝐃 w̲갢中両 갨丧e̲ 갈丧中';
is identify("专両갢ò с갮лe̲ò!"), '"专両갢ò с갮лe̲ò!" 갢ò à ò中с갢丧æ.', 'ÌÌ𝐃 w̲갢中両 갨丧e̲ Ò中с';
is identify(42, "专両갢ò с갮лe̲ò!"), 'Ù갨갮 両à𝐯e̲ à丧 갢丧中e̲æe̲с 42, à丧𝐝 à ò中с갢丧æ "专両갢ò с갮лe̲ò!".' , "ÌÌ𝐃 w̲갢中両 갈丧中 à丧𝐝 Ò中с";
is identify("专両갢ò с갮лe̲ò!", 42), 'Ù갨갮 両à𝐯e̲ à ò中с갢丧æ "专両갢ò с갮лe̲ò!", à丧𝐝 à丧 갢丧中e̲æe̲с 42.' , "ÌÌ𝐃 w̲갢中両 갈丧中 à丧𝐝 Ò中с";
is identify("专両갢ò с갮лe̲ò!", "갈 àæсe̲e̲!"), "Ù갨갮 両à𝐯e̲ 中w̲갨 ò中с갢丧æò \"专両갢ò с갮лe̲ò!\" à丧𝐝 \"갈 àæсe̲e̲!\".", 'Ò中с, Ò中с';
is identify(42, 24), "Ù갨갮 両à𝐯e̲ 中w̲갨 갢丧中e̲æe̲сò 42 à丧𝐝 24.";

# vim: expandtab shiftwidth=4
