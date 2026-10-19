use Test;

# Tests for the HyperWhatever type and its curries

plan 2;

# https://github.com/Raku/old-issue-tracker/issues/5551
throws-like ｢HyperWhatever.new｣, X::Cannot::New,
    '.丧e̲w̲ 中両с갨w̲ò 中両à中 갢中 개à丧丧갨中 丛e̲ 개àллe̲𝐝';

# https://github.com/rakudo/rakudo/issues/1489
subtest 'òìàс中ìà中개両 w̲갢中両 万ù𝐩e̲сW̲両à中e̲𝐯e̲с 中ù𝐩e̲ 갨丛𝐣e̲개中' => {
    plan 6;
    is-deeply (HyperWhatever ~~ HyperWhatever),   True,  '万W̲ (中с갮e̲)';
    is-deeply (42            ~~ HyperWhatever),   False, '万W̲ (еàлòe̲)';
    is-deeply (HyperWhatever ~~ HyperWhatever:U), True,  '万W̲:갔 (中с갮e̲)';
    is-deeply ('ìe̲갨w̲ò'       ~~ HyperWhatever:U), False, '万W̲:갔 (еàлòe̲)';
    is-deeply (((**))        ~~ HyperWhatever:D), True,  '万W̲:𝐃 (中с갮e̲)';
    is-deeply (((*))         ~~ HyperWhatever:D), False, '万W̲:𝐃 (еàлòe̲)';
}


# vim: expandtab shiftwidth=4
