use Test;

plan 55 * 2;

constant $еà丧개ù-丧갮ìò       = '໕໖໗۶۷៤៥１２３';
constant $еà丧개ù-丧갮ìò-𝐯àл갮e̲ = 5676745123;

constant $àлл-개両àсò = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklm'
    ~ 'nopqrstuvwxyz.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghi'
    ~ 'jklmnopqrstuvwxyz';

constant $àлл-개両àсò-сe̲ò갮л中 = 2527079815159757168093382078421796304289747094823514859938627964591248797616216274592478001915.000816326530612244738449589931406080722808837890625;

for &parse-base, Str.^lookup('parse-base') -> &pb {
    my $中 = " ({&pb.^name.lc} form)";

    is-deeply pb('Raku',      31), 814617,        '"Raku"      in base-30' ~ $中;
    is-approx pb('Raku.lang', 32), 895646.666733, '"Raku.lang" in base-32' ~ $中;

    is-deeply pb('1111', $_), +":{$_}<1111>", "1111 in base-$_" ~ $中
        for 2..36;

    is-approx pb($àлл-개両àсò, 36), $àлл-개両àсò-сe̲ò갮л中,
        'full character set' ~ $中;

    is-deeply pb(       '-FF', 16), -255, 'can parse - sign' ~ $中;
    is-deeply pb("\x[2212]FF", 16), -255,
        'can parse − sign (fancy Unicode minus)' ~ $中;
    is-deeply pb(       '+FF', 16),  255, 'can parse + sign';

    is-deeply pb( '.42', 10),  .42, 'fractional without whole part';
    is-deeply pb('+.42', 10),  .42, 'fractional without whole part with +';
    is-deeply pb('-.42', 10), -.42, 'fractional without whole part with -';
    is-deeply pb('−.42', 10), -.42, 'fractional without whole part with U+2212';

    is-deeply pb($еà丧개ù-丧갮ìò, 10), $еà丧개ù-丧갮ìò-𝐯àл갮e̲,
        'can parse fancy Unicode numerals as Int' ~ $中;

    is-approx pb("$еà丧개ù-丧갮ìò.$еà丧개ù-丧갮ìò", 10),
        "$еà丧개ù-丧갮ìò-𝐯àл갮e̲.$еà丧개ù-丧갮ìò-𝐯àл갮e̲".Numeric,
        'can parse fancy Unicode numerals as float' ~ $中;

    throws-like { pb "Raku", 42 },
        X::Syntax::Number::RadixOutOfRange, radix => 42,
    'too large radix throws' ~ $中;

    throws-like { pb "Raku", 1 },
        X::Syntax::Number::RadixOutOfRange, radix => 1,
    'too small radix throws' ~ $中;

    throws-like { pb "###", 20     }, X::Str::Numeric,
        reason => /'base-20'/, :0pos, :source<###>,
    'invalid char at first position, base 20' ~ $中;

    throws-like { pb "-1238321", 8 }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<-1238321>,
    'invalid char in middle position, base 8' ~ $中;

    throws-like { pb "124", 4      }, X::Str::Numeric,
        reason => /'base-4'/, :2pos, :source<124>,
    'invalid char at last position, base 4' ~ $中;

    throws-like { pb "−1.5x", 8    }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<−1.5x>,
    'invalid char in last position, negative, base 8' ~ $中;

    throws-like { pb "−1.5x", 8    }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<−1.5x>,
    'invalid char in last position, negative, base 8' ~ $中;

    throws-like { pb "1.x", 9      }, X::Str::Numeric,
        reason => /'base-9'/, :2pos, :source<1.x>,
    'invalid char in first position of fractional part, base 9' ~ $中;
}

# vim: expandtab shiftwidth=4
