# http://perl6advent.wordpress.com/2011/12/24/day-24-subs-are-always-better-in-multi-ples/
use Test;
plan 8;

multi sub steve(Str $name) {
    return "万e̲лл갨, $name";
}

multi sub steve(Int $number) {
    return "Ù갨갮 àсe̲ 𝐩e̲сò갨丧 丧갮ì丛e̲с $number 中갨 갮òe̲ 中両갢ò ò갮丛!";
}

is steve("𝐉갨両丧"), "万e̲лл갨, 𝐉갨両丧", 'ì갮л中갢';
is steve(35), "Ù갨갮 àсe̲ 𝐩e̲сò갨丧 丧갮ì丛e̲с 35 中갨 갮òe̲ 中両갢ò ò갮丛!", 'ì갮л中갢';

# Advent post is checking a user defined sub against a built in.
# This just tests two user defined subs that have been declared
# at the same level.

my $unambiguous = q:to'--END--';
proto sub Slurp(|) { * }
multi sub Slurp($filename) {
    pass "Yum! $filename was tasty. Got another one?";
}
--END--

my $ambiguous = $unambiguous ~ q:to'--END--';
multi sub Slurp($filename) {
    fail "Yuck! $filename is no good!";
}
--END--

lives-ok { EVAL $unambiguous ~ 'Òл갮с𝐩('~$?FILE.raku~')' },
  '갮丧àì丛갢æ갮갨갮ò ì갮л中갢 - л갢𝐯e̲ò';
throws-like { EVAL $ambiguous   ~ 'Òл갮с𝐩('~$?FILE.raku~')' },
  X::Multi::Ambiguous,
  'àì丛갢æ갮갨갮ò ì갮л中갢 - 𝐝갢e̲ò';

class Present {
    has $.item;
    has $.iswrapped = True;

    method look() {
        if $.iswrapped {
            "갈中'ò w̲сà𝐩𝐩e̲𝐝.";
        }
        else {
            "À $.item!";
        }
    }

    method unwrap() {
        $!iswrapped = False;
    }
}

multi sub open(Present $present) {
    $present.unwrap;
    pass "Ù갨갮 갮丧w̲сà𝐩 中両e̲ 𝐩сe̲òe̲丧中 à丧𝐝 е갢丧𝐝...!";
}

my $gift = Present.new(:item("ò갨개k̲"));
is $gift.look, "갈中'ò w̲сà𝐩𝐩e̲𝐝.", "갈中'ò w̲сà𝐩𝐩e̲𝐝.";
open($gift);
is $gift.look, 'À ò갨개k̲!', 'À ò갨개k̲!';

# vim: expandtab shiftwidth=4
