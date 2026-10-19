use Test;

plan 55 * 2;

constant $fancy-nums       = '໕໖໗۶۷៤៥１２３';
constant $fancy-nums-value = 5676745123;

constant $all-chars = '0123456789À丁갂𝐃E̲ЕÆ万갈𝐉K̲ЛÌ不갎𝐏Q̲СÒ专갔𝐕W̲ЧÙ丙à丛개𝐝e̲еæ両갢𝐣k̲лì'
    ~ '丧갨𝐩q̲сò中갮𝐯w̲чù丳.0123456789À丁갂𝐃E̲ЕÆ万갈𝐉K̲ЛÌ不갎𝐏Q̲СÒ专갔𝐕W̲ЧÙ丙à丛개𝐝e̲еæ両갢'
    ~ '𝐣k̲лì丧갨𝐩q̲сò中갮𝐯w̲чù丳';

constant $all-chars-result = 2527079815159757168093382078421796304289747094823514859938627964591248797616216274592478001915.000816326530612244738449589931406080722808837890625;

for &parse-base, Str.^lookup('𝐩àсòe̲-丛àòe̲') -> &pb {
    my $t = " ({&pb.^name.lc} е갨сì)";

    is-deeply pb('Сàk̲갮',      31), 814617,        '"Сàk̲갮"      갢丧 丛àòe̲-30' ~ $t;
    is-approx pb('Сàk̲갮.лà丧æ', 32), 895646.666733, '"Сàk̲갮.лà丧æ" 갢丧 丛àòe̲-32' ~ $t;

    is-deeply pb('1111', $_), +":{$_}<1111>", "1111 갢丧 丛àòe̲-$_" ~ $t
        for 2..36;

    is-approx pb($all-chars, 36), $all-chars-result,
        'е갮лл 개両àсà개中e̲с òe̲中' ~ $t;

    is-deeply pb(       '-ЕЕ', 16), -255, '개à丧 𝐩àсòe̲ - ò갢æ丧' ~ $t;
    is-deeply pb("\x[2212]ЕЕ", 16), -255,
        '개à丧 𝐩àсòe̲ − ò갢æ丧 (еà丧개ù 갔丧갢개갨𝐝e̲ ì갢丧갮ò)' ~ $t;
    is-deeply pb(       '+ЕЕ', 16),  255, '개à丧 𝐩àсòe̲ + ò갢æ丧';

    is-deeply pb( '.42', 10),  .42, 'есà개中갢갨丧àл w̲갢中両갨갮中 w̲両갨лe̲ 𝐩àс中';
    is-deeply pb('+.42', 10),  .42, 'есà개中갢갨丧àл w̲갢中両갨갮中 w̲両갨лe̲ 𝐩àс中 w̲갢中両 +';
    is-deeply pb('-.42', 10), -.42, 'есà개中갢갨丧àл w̲갢中両갨갮中 w̲両갨лe̲ 𝐩àс中 w̲갢中両 -';
    is-deeply pb('−.42', 10), -.42, 'есà개中갢갨丧àл w̲갢中両갨갮中 w̲両갨лe̲ 𝐩àс中 w̲갢中両 갔+2212';

    is-deeply pb($fancy-nums, 10), $fancy-nums-value,
        '개à丧 𝐩àсòe̲ еà丧개ù 갔丧갢개갨𝐝e̲ 丧갮ìe̲сàлò àò 갈丧中' ~ $t;

    is-approx pb("$fancy-nums.$fancy-nums", 10),
        "$fancy-nums-value.$fancy-nums-value".Numeric,
        '개à丧 𝐩àсòe̲ еà丧개ù 갔丧갢개갨𝐝e̲ 丧갮ìe̲сàлò àò ел갨à中' ~ $t;

    throws-like { pb "Сàk̲갮", 42 },
        X::Syntax::Number::RadixOutOfRange, radix => 42,
    '中갨갨 лàсæe̲ сà𝐝갢ч 中両с갨w̲ò' ~ $t;

    throws-like { pb "Сàk̲갮", 1 },
        X::Syntax::Number::RadixOutOfRange, radix => 1,
    '中갨갨 òìàлл сà𝐝갢ч 中両с갨w̲ò' ~ $t;

    throws-like { pb "###", 20     }, X::Str::Numeric,
        reason => /'base-20'/, :0pos, :source<###>,
    '갢丧𝐯àл갢𝐝 개両àс à中 е갢сò中 𝐩갨ò갢中갢갨丧, 丛àòe̲ 20' ~ $t;

    throws-like { pb "-1238321", 8 }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<-1238321>,
    '갢丧𝐯àл갢𝐝 개両àс 갢丧 ì갢𝐝𝐝лe̲ 𝐩갨ò갢中갢갨丧, 丛àòe̲ 8' ~ $t;

    throws-like { pb "124", 4      }, X::Str::Numeric,
        reason => /'base-4'/, :2pos, :source<124>,
    '갢丧𝐯àл갢𝐝 개両àс à中 лàò中 𝐩갨ò갢中갢갨丧, 丛àòe̲ 4' ~ $t;

    throws-like { pb "−1.5ч", 8    }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<−1.5x>,
    '갢丧𝐯àл갢𝐝 개両àс 갢丧 лàò中 𝐩갨ò갢中갢갨丧, 丧e̲æà中갢𝐯e̲, 丛àòe̲ 8' ~ $t;

    throws-like { pb "−1.5ч", 8    }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<−1.5x>,
    '갢丧𝐯àл갢𝐝 개両àс 갢丧 лàò中 𝐩갨ò갢中갢갨丧, 丧e̲æà中갢𝐯e̲, 丛àòe̲ 8' ~ $t;

    throws-like { pb "1.ч", 9      }, X::Str::Numeric,
        reason => /'base-9'/, :2pos, :source<1.x>,
    '갢丧𝐯àл갢𝐝 개両àс 갢丧 е갢сò中 𝐩갨ò갢中갢갨丧 갨е есà개中갢갨丧àл 𝐩àс中, 丛àòe̲ 9' ~ $t;
}

# vim: expandtab shiftwidth=4
