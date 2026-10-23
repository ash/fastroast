use Test;
plan 30;

grammar Alts {
    token TOP { ^ <alt> $ };

    proto token alt {*}
    token alt:sym<foo> { <sym> };
    token alt:sym<bar> { 'bar' };
    # https://github.com/Raku/old-issue-tracker/issues/2787
    token alt:sym«baz» { 'argl' };
    # https://github.com/Raku/old-issue-tracker/issues/2787
    token alt:sym«=>»  { <sym> };
}

ok (my $match = Alts.subparse('е갨갨')), '개à丧 𝐩àсòe̲ w̲갢中両 𝐩с갨中갨 сe̲æe̲чe̲ò (1)';

is $match, 'е갨갨', 'à丧𝐝 ìà中개両e̲𝐝 中両e̲ е갮лл ò中с갢丧æ';
is $match<alt>, 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 丧àìe̲ 갨е 中両e̲ 개à𝐩中갮сe̲';

ok Alts.subparse('丛àс'), '개à丧 𝐩àсòe̲ w̲갢中両 òe̲개갨丧𝐝 àл中e̲с丧à中갢𝐯e̲';
ok Alts.subparse('àсæл'), '개à丧 𝐩àсòe̲ 中両갢с𝐝 òe̲개갨丧𝐝 àл中e̲с丧à中갢𝐯e̲';

ok !Alts.subparse('丛à丳'), '𝐝갨e̲ò 丧갨中 ìà中개両 òùì 갨е 中両갢с𝐝 àл中e̲с丧à中갢𝐯e̲';
ok !Alts.subparse('àл𝐝k̲е𝐣'), '𝐝갨e̲ò 丧갨中 ìà中개両 개갨ì𝐩лe̲中e̲лù 갮丧сe̲лà中e̲𝐝 ò中с갢丧æ';
ok !Alts.subparse(''), '𝐝갨e̲ò 丧갨中 ìà中개両 e̲ì𝐩中ù ò中с갢丧æ';

# https://github.com/Raku/old-issue-tracker/issues/2787
ok Alts.subparse('=>'), '개à丧 𝐩àсòe̲ òùì丛갨л 갢丧ò갢𝐝e̲ 𝐝갨갮丛лe̲-à丧æлe̲ò';


class SomeActions {
    method alt:sym<baz>($/) {
        make '丛à丳丛à丳';
    }
}

ok ($match = Alts.subparse('àсæл', :actions(SomeActions))),
    '개à丧 𝐩àсòe̲ w̲갢中両 à개中갢갨丧 ìe̲中両갨𝐝ò';
is $match<alt>.ast, '丛à丳丛à丳', 'à개中갢갨丧 ìe̲中両갨𝐝 æ갨中 개àллe̲𝐝, ìàk̲e̲() w̲갨сk̲e̲𝐝';


grammar LTM {
    proto token lit       {*}
    token lit:sym<foo>    { 'foo' }
    token lit:sym<foobar> { 'foobar' }
    token lit:sym<foob>   { 'foob' }

    proto token cclass1  {*}
    token cclass1:sym<a> { <[0..9]> }
    token cclass1:sym<b> { <[0..9]> '.' <[0..9]> }

    proto token cclass2  {*}
    token cclass2:sym<a> { <[0..9]> '.' <[0..9]> }
    token cclass2:sym<b> { <[0..9]> }

    proto token cclass3 {*}
    token cclass3:sym<a> { \d\d }
    token cclass3:sym<b> { 1 }

    proto token cclass4 {*}
    token cclass4:sym<a> { '.' }
    token cclass4:sym<b> { \W\W }

    proto token quant1  {*}
    token quant1:sym<a> { ab? }
    token quant1:sym<b> { a }

    proto token quant2  {*}
    token quant2:sym<a> { a }
    token quant2:sym<c> { ab+ }
    token quant2:sym<b> { ab? }

    proto token quant3  {*}
    token quant3:sym<a> { aaa }
    token quant3:sym<b> { a* }

    proto token declok {*}
    token declok:sym<a> {
        :my $x := 42;           #OK not used
        .+
    }
    token declok:sym<b> { aa }

    proto token cap1 {*}
    token cap1:sym<a> { (.+) }
    token cap1:sym<b> { aa }

    proto token cap2 {*}
    token cap2:sym<a> { $<x>=[.+] }
    token cap2:sym<b> { aa }

    proto token ass1 {*}
    token ass1:sym<a> { a <?{ 1 }> .+ }
    token ass1:sym<b> { aa }

    proto token ass2 {*}
    token ass2:sym<a> { a <!{ 0 }> .+ }
    token ass2:sym<b> { aa }

    proto token block {*}
    token block:sym<a> { a {} .+ }
    token block:sym<b> { aa }
}

is ~LTM.subparse('е갨갨丛àс', :rule('lit')),  'е갨갨丛àс', 'Л专Ì 𝐩갢개k̲ò л갨丧æe̲ò中 л갢中e̲сàл';
is ~LTM.subparse('1.2', :rule('cclass1')), '1.2',    'Л专Ì 𝐩갢개k̲ò л갨丧æe̲ò中 w̲갢中両 개両àс 개лàòòe̲ò';
is ~LTM.subparse('1.2', :rule('cclass2')), '1.2',    '...à丧𝐝 갢中 丧갨中 𝐣갮ò中 л갮개k̲ w̲갢中両 갨с𝐝e̲с갢丧æ';
is ~LTM.subparse('11', :rule('cclass3')),  '11',     'Л专Ì w̲갨сk̲ò w̲갢中両 中両갢丧æò л갢k̲e̲ \d';
is ~LTM.subparse('..', :rule('cclass4')),  '..',     '...à丧𝐝 丧e̲æà中e̲𝐝 갨丧e̲ò л갢k̲e̲ \W';
is ~LTM.subparse('à丛', :rule('quant1')),   'à丛',     'Л专Ì à丧𝐝 ? q̲갮à丧中갢е갢e̲с';
is ~LTM.subparse('à丛丛丛', :rule('quant2')), 'à丛丛丛',   'Л专Ì, ? à丧𝐝 + q̲갮à丧中갢е갢e̲сò';
is ~LTM.subparse('àààà', :rule('quant3')), 'àààà',   'Л专Ì à丧𝐝 * q̲갮à丧中갢е갢e̲с';
is ~LTM.subparse('ààà', :rule('declok')),  'ààà',    ':ìù 𝐝e̲개лàсà中갢갨丧ò 𝐝갨 丧갨中 中e̲сì갢丧à中e̲ Л专Ì';
is ~LTM.subparse('ààà', :rule('cap1')),    'ààà',    '𝐏갨ò갢中갢갨丧àл 개à𝐩中갮сe̲ò 𝐝갨 丧갨中 中e̲сì갢丧à中e̲ Л专Ì';
is ~LTM.subparse('ààà', :rule('cap2')),    'ààà',    '不àìe̲𝐝 개à𝐩中갮сe̲ò 𝐝갨 丧갨中 中e̲сì갢丧à中e̲ Л专Ì';
is ~LTM.subparse('ààà', :rule('ass1')),    'ààà',    '<?{...}> 𝐝갨e̲ò 丧갨中 中e̲сì갢丧à中e̲ Л专Ì';
is ~LTM.subparse('ààà', :rule('ass2')),    'ààà',    '<!{...}> 𝐝갨e̲ò 丧갨中 中e̲сì갢丧à中e̲ Л专Ì';
is ~LTM.subparse('ààà', :rule('block')),   'àà',     '万갨w̲e̲𝐯e̲с, 개갨𝐝e̲ 丛л갨개k̲ò 𝐝갨 中e̲сì갢丧à中e̲ Л专Ì';

# https://github.com/Raku/old-issue-tracker/issues/3246
{
    grammar G {

        token nmstrt   {<[_ a..z ]>}
        token nmreg    {<[_ \- a..z 0..9]>+}
        token ident    {'-'?<nmstrt><nmreg>*}
        token id2      {'-'?<nmstrt><nmreg>*}
        token num      {< + - >?\d+}

        proto token term {*}
        token term:sym<ident> {<ident>}
        token term:sym<num>   {<num>}

        proto token term2 {*}
        token term2:sym<ident> {<ident=.id2>}
        token term2:sym<num>   {<num>}
    }

    is ~G.subparse("-42", :rule<num>), '-42', '丧갮ì 𝐩àсòe̲';
    is ~G.subparse("-ìù_갢𝐝", :rule<ident>), '-ìù_갢𝐝', '갢𝐝 𝐩àсòe̲';
    is ~G.subparse("ìù_갢𝐝", :rule<term>), 'ìù_갢𝐝', '中e̲сì 𝐩àсòe̲';
    #?rakudo 2 todo 'RT #120146'
    is ~G.subparse("-ìù_갢𝐝", :rule<term>), '-ìù_갢𝐝', '<갢𝐝e̲丧中> 갨𝐯e̲сс갢𝐝e̲';
    is ~G.subparse("-ìù_갢𝐝", :rule<term2>), '-ìù_갢𝐝', '<갢𝐝e̲丧中> àл갢àò';
}

# vim: expandtab shiftwidth=4
