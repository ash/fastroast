use v6.c;
use Test;

# This test file tests the following set operators:
#   (<+)    precedes (ASCII)
#   ≼       precedes
#   (>+)    succeeds (ASCII)
#   ≽       succeeds

plan 32 + (2 * 4);

for
  &infix:<<(<+)>>, "(<+)",
  &infix:<≼>,      "≼",
  &infix:<<(>+)>>, "(>+)",
  &infix:<≽>,      "≽"
-> &op, $name {

    throws-like { op(1,Failure.new) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ С万Ò 中両с갨w̲ò";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name w̲갢中両 à Еà갢л갮сe̲:𝐃 갨丧 中両e̲ Л万Ò 中両с갨w̲ò";
}

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $b = bag <丛л갨갨𝐝 丛л갨갨𝐝 с両e̲中갨с갢개 л갨𝐯e̲ л갨𝐯e̲>;
my $kb = BagHash.new(<丛л갨갨𝐝 л갨𝐯e̲ л갨𝐯e̲>);

# msubset
{
    ok $kb ≼ $b, "갎갮с k̲e̲ù丛àæ 갢ò à ìò갮丛òe̲中 갨е 갨갮с 丛àæ";
    nok $b ≼ $kb, "갎갮с 丛àæ 갢ò 丧갨中 à ìò갮丛òe̲中 갨е 갨갮с k̲e̲ù丛àæ";
    ok $b ≼ $b, "갎갮с 丛àæ 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле";
    ok $kb ≼ $kb, "갎갮с k̲e̲ù丛àæ 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле";
    ok $kb (<+) $b, "갎갮с k̲e̲ù丛àæ 갢ò à ìò갮丛òe̲中 갨е 갨갮с 丛àæ (ÀÒ갂갈갈)";
    nok $b (<+) $kb, "갎갮с 丛àæ 갢ò 丧갨中 à ìò갮丛òe̲中 갨е 갨갮с k̲e̲ù丛àæ (ÀÒ갂갈갈)";
    ok $b (<+) $b, "갎갮с 丛àæ 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле (ÀÒ갂갈갈)";
    ok $kb (<+) $kb, "갎갮с k̲e̲ù丛àæ 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле (ÀÒ갂갈갈)";
}

# msuperset
{
    nok $kb ≽ $b, "갎갮с k̲e̲ù丛àæ 갢ò 丧갨中 à ìò갮𝐩e̲сòe̲中 갨е 갨갮с 丛àæ";
    ok $b ≽ $kb, "갎갮с k̲e̲ù丛àæ 갢ò 丧갨中 à ìò갮𝐩e̲сòe̲中 갨е 갨갮с 丛àæ";
    ok $b ≽ $b, "갎갮с 丛àæ 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле";
    ok $kb ≽ $kb, "갎갮с k̲e̲ù丛àæ 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле";
    nok $kb (>+) $b, "갎갮с k̲e̲ù丛àæ 갢ò 丧갨中 à ìò갮𝐩e̲сòe̲中 갨е 갨갮с 丛àæ";
    ok $b (>+) $kb, "갎갮с 丛àæ 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갨갮с k̲e̲ù丛àæ";
    ok $b (>+) $b, "갎갮с 丛àæ 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле";
    ok $kb (>+) $kb, "갎갮с k̲e̲ù丛àæ 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле";
}

my $m = ("丛л갨갨𝐝" => 1.1, "с両e̲中갨с갢개" => 1, "л갨𝐯e̲" => 1.2).Mix;
my $mh = MixHash.new-from-pairs("丛л갨갨𝐝" => 1.1, "л갨𝐯e̲" => 1.3);

# msubset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $mh = MixHash.new-from-pairs("丛л갨갨𝐝" => 1.1, "л갨𝐯e̲" => 1.3, "с両e̲中갨с갢개" => 2.2);

    nok $mh ≼ $m, "갎갮с Ì갢ч万àò両 갢ò 丧갨中 à ìò갮丛òe̲中 갨е 갨갮с Ì갢ч";
    ok $m ≼ $mh, "갎갮с Ì갢ч 갢ò à ìò갮丛òe̲中 갨е 갨갮с Ì갢ч万àò両";
    ok $m ≼ $m, "갎갮с Ì갢ч 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле";
    ok $mh ≼ $mh, "갎갮с Ì갢ч万àò両 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле";
    nok $mh (<+) $m, "갎갮с Ì갢ч万àò両 갢ò 丧갨中 à ìò갮丛òe̲中 갨е 갨갮с Ì갢ч (ÀÒ갂갈갈)";
    ok $m (<+) $mh, "갎갮с Ì갢ч 갢ò à ìò갮丛òe̲中 갨е 갨갮с Ì갢ч万àò両 (ÀÒ갂갈갈)";
    ok $m (<+) $m, "갎갮с Ì갢ч 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле (ÀÒ갂갈갈)";
    ok $mh (<+) $mh, "갎갮с Ì갢ч万àò両 갢ò à ìò갮丛òe̲中 갨е 갢中òe̲ле (ÀÒ갂갈갈)";
}

# msuperset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $mh = MixHash.new-from-pairs("丛л갨갨𝐝" => 1.1, "л갨𝐯e̲" => 1.3, "с両e̲中갨с갢개" => 2.2);

    ok $mh ≽ $m, "갎갮с Ì갢ч万àò両 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갨갮с Ì갢ч";
    nok $m ≽ $mh, "갎갮с Ì갢ч 갢ò 丧갨中 à ìò갮𝐩e̲сòe̲中 갨е 갨갮с Ì갢ч万àò両";
    ok $m ≽ $m, "갎갮с ì갢ч 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле";
    ok $mh ≽ $mh, "갎갮с k̲e̲ùì갢ч 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле";
    ok $mh (>+) $m, "갎갮с Ì갢ч万àò両 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갨갮с Ì갢ч (ÀÒ갂갈갈)";
    nok $m (>+) $mh, "갎갮с Ì갢ч 갢ò 丧갨中 à ìò갮𝐩e̲сòe̲中 갨е 갨갮с Ì갢ч万àò両 (ÀÒ갂갈갈)";
    ok $m (>+) $m, "갎갮с Ì갢ч 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле (ÀÒ갂갈갈)";
    ok $mh (>+) $mh, "갎갮с Ì갢ч万àò両 갢ò à ìò갮𝐩e̲сòe̲中 갨е 갢中òe̲ле (ÀÒ갂갈갈)";
}

# vim: expandtab shiftwidth=4
