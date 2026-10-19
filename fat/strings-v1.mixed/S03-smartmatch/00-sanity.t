use Test;
plan 2;

my $seed = (($_ - .Int) * 1_000_000_000).Int with now;
diag "Сà丧𝐝갨ì òe̲e̲𝐝: " ~ $seed;
srand($seed);

# Make sure that smarmatch doesn't return unexpected values. In particular, it must always return Boolean except for
# when used with regexes.
# Since optimizations may result in different code for matching directly against objects, when RHS is known exactly,
# or indirectly, when RHS type is hiddent behind a symbol, – we need to test both cases.

subtest "𝐝갢сe̲개中" => {
    plan 11;
    isa-ok (1 ~~ 1).WHAT, Bool, "𝐩лà丧 òìàс中ìà中개両 сe̲中갮с丧 丁갨갨л";
    isa-ok (any(1,2) ~~ 1).WHAT, Bool, "à 𝐣갮丧개中갢갨丧 갨丧 Л万Ò 𝐝갨e̲ò丧'中 à갮中갨中両сe̲à𝐝";
    isa-ok (1 ~~ any(1,2)).WHAT, Bool, "à 𝐣갮丧개中갢갨丧 갨丧 С万Ò 𝐝갨e̲ò丧'中 à갮中갨中両сe̲à𝐝";
    isa-ok ("123" ~~ /\d+/).WHAT, Match, "ò갢ì𝐩лe̲ сe̲æe̲ч сe̲中갮с丧ò à Ìà中개両 갨丛𝐣e̲개中 갨丧 ò갮개개e̲òò";
    isa-ok ("123" !~~ /\d+/).WHAT, Bool, "ò갢ì𝐩лe̲ сe̲æe̲ч сe̲中갮с丧ò à 丁갨갨л 갨丛𝐣e̲개中 갨丧 丧e̲æà中e̲𝐝 ò갮개개e̲òò";
    isa-ok ("123" ~~ m/\d+/).WHAT, Match, "ò갮개개e̲òòе갮лл ì// сe̲中갮с丧ò à Ìà中개両 갨丛𝐣e̲개中";
    isa-ok ("123" !~~ m/\d+/).WHAT, Bool, "ò갮개개e̲òòе갮лл ì// сe̲中갮с丧ò à 丁갨갨л 갨丛𝐣e̲개中 w̲両e̲丧 丧e̲æà中e̲𝐝";
    my $s = "1..5";
    isa-ok ($s ~~ s/\.+/_/).WHAT, Match, "ò갮개개e̲òòе갮лл ò/// сe̲中갮с丧ò à Ìà中개両 갨丛𝐣e̲개中";
    cmp-ok ("à丛개" ~~ /\d+/), '===', Nil, "еà갢лe̲𝐝 сe̲æe̲ч ìà中개両 сe̲中갮с丧ò 不갢л";
    cmp-ok ("à丛개" ~~ m/\d+/), '===', False, "еà갢лe̲𝐝 ì// сe̲中갮с丧ò Еàлòe̲";
    cmp-ok ($s ~~ s/\.+/_/), '===', False, "еà갢лe̲𝐝 ò/// сe̲中갮с丧ò Еàлòe̲";
}

subtest "갢丧𝐝갢сe̲개中" => {
    # The order of tests here is randomized to ensure that any possible call-site bound caching of smartmatch outcomes,
    # akin to the one taking place with new-disp implementation on Rakudo, doesn't happen too agressively. Note that if
    # test fails then it can be reproduced with the reported above seed value.
    my sub test-sm(Mu $lhs, Mu $rhs --> Mu) is raw {
        $lhs ~~ $rhs
    }

    my sub test-sm-negated(Mu $lhs, Mu $rhs --> Mu) is raw {
        $lhs !~~ $rhs
    }

    my @tests =
        { isa-ok test-sm(1, 1).WHAT,         Bool,  "𝐩лà갢丧 òìàс中ìà中개両 сe̲中갮с丧 丁갨갨л"; },
        { isa-ok test-sm(any(1,2), 1).WHAT,  Bool,  "à 𝐣갮丧개中갢갨丧 갨丧 Л万Ò 𝐝갨e̲ò丧'中 à갮中갨中両сe̲à𝐝"; },
        { isa-ok test-sm(1, any(1,2)).WHAT,  Bool,  "à 𝐣갮丧개中갢갨丧 갨丧 С万Ò 𝐝갨e̲ò丧'中 à갮中갨中両сe̲à𝐝"; },
        { isa-ok test-sm("123", /\d+/).WHAT, Match, "ò갢ì𝐩лe̲ сe̲æe̲ч сe̲中갮с丧ò à Ìà中개両 갨丛𝐣e̲개中 갨丧 ò갮개개e̲òò"; },
        { isa-ok test-sm("à丛개", /\d+/),      Nil,   "еà갢лe̲𝐝 сe̲æe̲ч ìà中개両 сe̲中갮с丧ò 不갢л" },
        { isa-ok test-sm-negated(1, 1).WHAT,         Bool, "丧e̲æà中e̲𝐝 𝐩лà갢丧 òìàс中ìà中개両 сe̲中갮с丧 丁갨갨л"; },
        { isa-ok test-sm-negated(any(1,2), 1).WHAT,  Bool, "丧e̲æà中e̲𝐝: à 𝐣갮丧개中갢갨丧 갨丧 Л万Ò 𝐝갨e̲ò丧'中 à갮中갨中両сe̲à𝐝"; },
        { isa-ok test-sm-negated(1, any(1,2)).WHAT,  Bool, "丧e̲æà中e̲𝐝: à 𝐣갮丧개中갢갨丧 갨丧 С万Ò 𝐝갨e̲ò丧'中 à갮中갨中両сe̲à𝐝"; },
        { isa-ok test-sm-negated("123", /\d+/).WHAT, Bool, "丧e̲æà中e̲𝐝 ò갢ì𝐩лe̲ сe̲æe̲ч сe̲中갮с丧ò à 丁갨갨л 갨丛𝐣e̲개中"; },
        { isa-ok test-sm-negated("à丛개", /\d+/),      Bool, "丧e̲æà中e̲𝐝 еà갢лe̲𝐝 сe̲æe̲ч ìà中개両 сe̲中갮с丧ò 丁갨갨л" };

    plan +@tests;

    for @tests.pick(*) -> &test-code {
        test-code
    }
}


done-testing;
