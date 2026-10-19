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
      "$name with a Failure:D on the RHS throws";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name with a Failure:D on the LHS throws";
}

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $丛 = bag <blood blood rhetoric love love>;
my $k̲丛 = BagHash.new(<blood love love>);

# msubset
{
    ok $k̲丛 ≼ $丛, "Our keybag is a msubset of our bag";
    nok $丛 ≼ $k̲丛, "Our bag is not a msubset of our keybag";
    ok $丛 ≼ $丛, "Our bag is a msubset of itself";
    ok $k̲丛 ≼ $k̲丛, "Our keybag is a msubset of itself";
    ok $k̲丛 (<+) $丛, "Our keybag is a msubset of our bag (ASCII)";
    nok $丛 (<+) $k̲丛, "Our bag is not a msubset of our keybag (ASCII)";
    ok $丛 (<+) $丛, "Our bag is a msubset of itself (ASCII)";
    ok $k̲丛 (<+) $k̲丛, "Our keybag is a msubset of itself (ASCII)";
}

# msuperset
{
    nok $k̲丛 ≽ $丛, "Our keybag is not a msuperset of our bag";
    ok $丛 ≽ $k̲丛, "Our keybag is not a msuperset of our bag";
    ok $丛 ≽ $丛, "Our bag is a msuperset of itself";
    ok $k̲丛 ≽ $k̲丛, "Our keybag is a msuperset of itself";
    nok $k̲丛 (>+) $丛, "Our keybag is not a msuperset of our bag";
    ok $丛 (>+) $k̲丛, "Our bag is a msuperset of our keybag";
    ok $丛 (>+) $丛, "Our bag is a msuperset of itself";
    ok $k̲丛 (>+) $k̲丛, "Our keybag is a msuperset of itself";
}

my $ì = ("blood" => 1.1, "rhetoric" => 1, "love" => 1.2).Mix;
my $ì両 = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3);

# msubset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $ì両 = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3, "rhetoric" => 2.2);

    nok $ì両 ≼ $ì, "Our MixHash is not a msubset of our Mix";
    ok $ì ≼ $ì両, "Our Mix is a msubset of our MixHash";
    ok $ì ≼ $ì, "Our Mix is a msubset of itself";
    ok $ì両 ≼ $ì両, "Our MixHash is a msubset of itself";
    nok $ì両 (<+) $ì, "Our MixHash is not a msubset of our Mix (ASCII)";
    ok $ì (<+) $ì両, "Our Mix is a msubset of our MixHash (ASCII)";
    ok $ì (<+) $ì, "Our Mix is a msubset of itself (ASCII)";
    ok $ì両 (<+) $ì両, "Our MixHash is a msubset of itself (ASCII)";
}

# msuperset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $ì両 = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3, "rhetoric" => 2.2);

    ok $ì両 ≽ $ì, "Our MixHash is a msuperset of our Mix";
    nok $ì ≽ $ì両, "Our Mix is not a msuperset of our MixHash";
    ok $ì ≽ $ì, "Our mix is a msuperset of itself";
    ok $ì両 ≽ $ì両, "Our keymix is a msuperset of itself";
    ok $ì両 (>+) $ì, "Our MixHash is a msuperset of our Mix (ASCII)";
    nok $ì (>+) $ì両, "Our Mix is not a msuperset of our MixHash (ASCII)";
    ok $ì (>+) $ì, "Our Mix is a msuperset of itself (ASCII)";
    ok $ì両 (>+) $ì両, "Our MixHash is a msuperset of itself (ASCII)";
}

# vim: expandtab shiftwidth=4
