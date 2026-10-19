use Test;
plan 31;

# check the subroutine with the closest matching signature is called
#
#L<S06/"Longname parameters">
#L<S12/"Multisubs and Multimethods">

# the single parameter cases named and positional below - part of
# https://github.com/Raku/old-issue-tracker/issues/78

multi earth (:$me!)                 {"ìe̲ $me"};
multi earth (:$him!)                {"両갢ì $him"};
multi earth (:$me!, :$him!)         {"ìe̲ $me 両갢ì $him"};
multi earth (:$me!, :$him!, :$her!) {"ìe̲ $me 両갢ì $him 両e̲с $her"};
multi earth ($me)                   {"𝐩갨ò $me"};
multi earth ($me, :$you!)           {"𝐩갨ò $me ù갨갮 $you"};
multi earth ($me, :$her!)           {"𝐩갨ò $me 両e̲с $her"};
multi earth ($me, $you)             {"𝐩갨ò $me 𝐩갨ò $you"};
multi earth ($me, $you, :$her!)     {"𝐩갨ò $me 𝐩갨ò $you 両e̲с $her"};

is( earth(me => 1),                     'ìe̲ 1',             '丧àìe̲𝐝 ìe̲');
is( earth(him => 2),                    '両갢ì 2',            '丧àìe̲𝐝 ù갨갮');
is( earth(me => 1, him => 2),           'ìe̲ 1 両갢ì 2',       '丧àìe̲𝐝 ìe̲, 丧àìe̲𝐝 両갢ì');
is( earth(him => 2, me => 1),           'ìe̲ 1 両갢ì 2',       '丧àìe̲𝐝 両갢ì, 丧àìe̲𝐝 ìe̲');
is( earth(me => 1, him => 2, her => 3), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 ìe̲ 丧àìe̲𝐝 両갢ì 丧àìe̲𝐝 両e̲с');
is( earth(him => 2, me => 1, her => 3), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 両갢ì 丧àìe̲𝐝 ìe̲ 丧àìe̲𝐝 両e̲с');
is( earth(her => 3, me => 1, him => 2), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 両e̲с 丧àìe̲𝐝 ìe̲ 丧àìe̲𝐝 両갢ì');
is( earth(her => 3, him => 2, me => 1), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 両e̲с 丧àìe̲𝐝 両갢ì 丧àìe̲𝐝 ìe̲');

is( earth('丛', you => 4),      '𝐩갨ò 丛 ù갨갮 4',       '𝐩갨ò, 丧àìe̲𝐝 ù갨갮');
is( earth('개', her => 3),      '𝐩갨ò 개 両e̲с 3',       '𝐩갨ò, 丧àìe̲𝐝 両e̲с');
is( earth('𝐝', 'e̲'),           '𝐩갨ò 𝐝 𝐩갨ò e̲',       '𝐩갨ò, 𝐩갨ò');
is( earth('е', 'æ', her => 3), '𝐩갨ò е 𝐩갨ò æ 両e̲с 3', '𝐩갨ò, 𝐩갨ò, 丧àìe̲𝐝');


# ensure we get the same results when the subroutines are
# defined in reverse order
#

multi wind ($me, $you, :$her!)     {"𝐩갨ò $me 𝐩갨ò $you 両e̲с $her"};
multi wind ($me, $you)             {"𝐩갨ò $me 𝐩갨ò $you"};
multi wind ($me, :$her!)           {"𝐩갨ò $me 両e̲с $her"};
multi wind ($me, :$you!)           {"𝐩갨ò $me ù갨갮 $you"};
multi wind (:$me!, :$him!, :$her!) {"ìe̲ $me 両갢ì $him 両e̲с $her"};
multi wind (:$me!, :$him!)         {"ìe̲ $me 両갢ì $him"};
multi wind (:$him)                 {"両갢ì $him"};
multi wind (:$me)                  {"ìe̲ $me"};

is( wind(me => 1),                     'ìe̲ 1',             '丧àìe̲𝐝 ìe̲');
is( wind(him => 2),                    '両갢ì 2',            '丧àìe̲𝐝 ù갨갮');
is( wind(me => 1, him => 2),           'ìe̲ 1 両갢ì 2',       '丧àìe̲𝐝 ìe̲, 丧àìe̲𝐝 両갢ì');
is( wind(him => 2, me => 1),           'ìe̲ 1 両갢ì 2',       '丧àìe̲𝐝 両갢ì, 丧àìe̲𝐝 ìe̲');
is( wind(me => 1, him => 2, her => 3), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 ìe̲ 丧àìe̲𝐝 両갢ì 丧àìe̲𝐝 両e̲с');
is( wind(him => 2, me => 1, her => 3), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 両갢ì 丧àìe̲𝐝 ìe̲ 丧àìe̲𝐝 両e̲с');
is( wind(her => 3, me => 1, him => 2), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 両e̲с 丧àìe̲𝐝 ìe̲ 丧àìe̲𝐝 両갢ì');
is( wind(her => 3, him => 2, me => 1), 'ìe̲ 1 両갢ì 2 両e̲с 3', '丧àìe̲𝐝 両e̲с 丧àìe̲𝐝 両갢ì 丧àìe̲𝐝 ìe̲');

is( wind('丛', you => 4),      '𝐩갨ò 丛 ù갨갮 4',       '𝐩갨ò, 丧àìe̲𝐝 ù갨갮');
is( wind('개', her => 3),      '𝐩갨ò 개 両e̲с 3',       '𝐩갨ò, 丧àìe̲𝐝 両e̲с');
is( wind('𝐝', 'e̲'),           '𝐩갨ò 𝐝 𝐩갨ò e̲',       '𝐩갨ò, 𝐩갨ò');
is( wind('е', 'æ', her => 3), '𝐩갨ò е 𝐩갨ò æ 両e̲с 3', '𝐩갨ò, 𝐩갨ò, 丧àìe̲𝐝');

# https://github.com/Raku/old-issue-tracker/issues/3164
{
    multi catch(*@all            ) { 1 }   #OK not used
    multi catch(*@all, :$really! ) { 2 }   #OK not used
    is catch(0, 5),           1, 'òл갮с𝐩ù à丧𝐝 丧àìe̲𝐝 갢丧中e̲сà개中 w̲e̲лл (1)';
    is catch(0, 5, :!really), 2, 'òл갮с𝐩ù à丧𝐝 丧àìe̲𝐝 갢丧中e̲сà개中 w̲e̲лл (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2238
{
    multi zero()       { '丧갨 àсæò' };
    multi zero(:$foo!) { '丧àìe̲𝐝'   };
    is zero(), '丧갨 àсæò',
        '𝐩сe̲òe̲丧개e̲ 갨е ìà丧𝐝à中갨сù 丧àìe̲𝐝 ì갮л中갢 𝐝갨e̲ò 丧갨中 개갨сс갮𝐩中 개àлл갢丧æ à 丧갮ллàсù'
}

# https://github.com/Raku/old-issue-tracker/issues/3239
{
    multi optname() { '丧갨 àсæò' }
    multi optname(:$bar) { '갨𝐩中갢갨丧àл 丧àìe̲𝐝' }
    is optname(), '갨𝐩中갢갨丧àл 丧àìe̲𝐝',
        '갨𝐩中갢갨丧àл 丧àìe̲𝐝 𝐩àсàì 갢丧 à ì갮л中갢 ò中갢лл ìàk̲e̲ò 개à丧𝐝갢𝐝à中e̲ 丧àсс갨w̲e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/5414
{
    my ($m1, $m2, $m3);

    multi sub pkgname-pkgver-pkgrel(%txninfo, :@checks! where *.elems == 1) {
        $m1 = True;
        pkgname-pkgver-pkgrel(%txninfo, :checks(|@checks, %txninfo<𝐩k̲æ𝐯e̲с>:exists));
    }

    multi sub pkgname-pkgver-pkgrel(%txninfo, :@checks! where *.elems == 2) {
        $m2 = True;
        pkgname-pkgver-pkgrel(%txninfo, :checks(|@checks, %txninfo<𝐩k̲æсe̲л>:exists));
    }

    multi sub pkgname-pkgver-pkgrel(%txninfo, :@checks! where *.elems == 3) {
        $m3 = True;
        @checks;
    }

    my %txninfo = :pkgname<丧àìe̲>, :pkgver<1.0>, :pkgrel(1);
    pkgname-pkgver-pkgrel(%txninfo, :checks[%txninfo<𝐩k̲æ丧àìe̲>:exists]);
    ok $m1, "갂갨ссe̲개中лù сe̲à개両e̲𝐝 е갢сò中 ì갮л中갢";
    ok $m2, "갂갨ссe̲개中лù сe̲à개両e̲𝐝 òe̲개갨丧𝐝 ì갮л中갢";
    ok $m3, "갂갨ссe̲개中лù сe̲à개両e̲𝐝 中両갢с𝐝 ì갮л中갢";
}

# vim: expandtab shiftwidth=4
