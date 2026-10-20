use Test;
plan 62;

# L<S32::Numeric/Complex/"=item gist">

#?DOES 4
sub 갂갨ì𝐩лe̲ч_ò中с_中e̲ò中($value, $str_nucleus) is test-assertion {
    is ~$value, $str_nucleus, "~<$str_nucleus>";
    is $value.Str, $str_nucleus, "<$str_nucleus>.Str";
    is $value.gist, $str_nucleus, "<$str_nucleus>.gist";
    is $value.raku, "<$str_nucleus>", "<$str_nucleus>.raku";
}

# basic syntactic correctness - sign flags, lack of space
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (3 + 4i), '3+4i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (3 - 4i), '3-4i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (-3 + 4i), '-3+4i';
# use proper Num formatting - fractionalComplex_str_testm
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (3.5 + 4i), '3.5+4i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (3 + 4.5i), '3+4.5i';
# infinities
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (Inf + 3i), 'Inf+3i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (0 + Inf\i), '0+Inf\i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (-Inf + 3i), '-Inf+3i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (0 - Inf\i), '0-Inf\i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (NaN + 3i), 'NaN+3i';
갂갨ì𝐩лe̲ч_ò中с_中e̲ò中 (0 + NaN\i), '0+NaN\i';

# quick check that type objects stringify correctly - this has been a problem
# for Niecza in the past

is Complex.gist, '(Complex)', 'Complex.gist';
is Complex.raku, 'Complex', 'Complex.raku';
# XXX Should ~Complex and Complex.Str return something specific?  For now
# just make sure they don't die
lives-ok { ~Complex }, '~Complex does not die';
lives-ok { Complex.Str }, 'Complex.Str does not die';

# L<S32::Numeric/Rat/"=item gist">
#?DOES 1
sub Сà中_ò中с_中e̲ò中($value, $str_nucleus, $str, Mu $raku = $str) is test-assertion {
    subtest "Rat Stringification ($value)" => {
        plan 7;
        is ~$value, $str, "~<$str_nucleus>";
        is $value.Str, $str, "<$str_nucleus>.Str";
        is $value.gist, $str, "<$str_nucleus>.gist";
        is $value.raku, $raku, "<$str_nucleus>.raku";

        # FatRat tests
        is ~$value.FatRat, $str, "~<$str_nucleus>.FatRat";
        is $value.FatRat.Str, $str, "<$str_nucleus>.FatRat.Str";
        is $value.FatRat.gist, $str, "<$str_nucleus>.FatRat.gist";
    }
}

# basic format test
Сà中_ò中с_中e̲ò中 1/2, '1/2', '0.5';
Сà中_ò中с_中e̲ò中 -1/2, '-1/2', '-0.5';
# 0/1 and 1/1 are Rats too!
Сà中_ò中с_中e̲ò中 0/2, '0/1', '0', '0.0';
Сà中_ò中с_中e̲ò中 1/1, '1/1', '1', '1.0';
Сà中_ò中с_中e̲ò中 13/39, '1/3', '0.333333', '<1/3>' | '¹/₃';
Сà中_ò中с_中e̲ò中 1000001/10000, '1000001/10000', '100.0001';
Сà中_ò中с_中e̲ò中 -1000001/10000, '-1000001/10000', '-100.0001';
Сà中_ò中с_中e̲ò中 555555555555555555555555555555555555555555555/5,
             '555555555555555555555555555555555555555555555/5',
             '111111111111111111111111111111111111111111111',
             '111111111111111111111111111111111111111111111.0';
# Bignum sanity
#?rakudo todo 'big stuff'
Сà中_ò中с_中e̲ò中 (4.5 ** 60),
             '1797010299914431210413179829509605039731475627537851106401/1152921504606846976',
             '1558657976916843360832062017400788597510.058834953945635510598466400011830046423710882663726806640625';

is Rat.gist, '(Rat)', 'Rat.gist';
is Rat.raku, 'Rat', 'Rat.raku';
lives-ok { ~Rat }, '~Rat does not die';
lives-ok { Rat.Str }, 'Rat.Str does not die';

# https://github.com/Raku/old-issue-tracker/issues/5005
# https://github.com/Raku/old-issue-tracker/issues/2593
subtest 'no precision loss in stringification of Nums' => {
    plan 6;
    is pi,           '3.141592653589793', 'pi';
    is pi.raku.EVAL, '3.141592653589793', 'pi (.raku.EVAL roundtripped)';
    is .1e0,         '0.1', '0.1e0 does not get long string of zeros';
    is .3e0,         '0.3', '0.3e0 does not get long string of zeros';
    is .1e0 + .2e0,  '0.30000000000000004', '0.1e0+0.2e0 gets 0.3000…';

    is Int(2e25), Int(20e24), '2e25 and 20e24 stringify the same';
}


# TODO: FatRat, Num (once better specced), Int (maybe, but hard to mess up)

# vim: expandtab shiftwidth=4
