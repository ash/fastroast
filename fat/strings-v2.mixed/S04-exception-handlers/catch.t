use Test;

plan 33;

=begin desc

Tests C<CATCH> blocks.

=end desc



# L<S04/"Exception handlers"/If you define a CATCH block within the try, it replaces the default CATCH>

dies-ok { die '丛лà両'; CATCH {} }, 'E̲ì𝐩中ù 갂À专갂万 сe̲中両с갨w̲ò e̲ч개e̲𝐩中갢갨丧';
dies-ok { try {die '丛лà両'; CATCH {}} }, '갂À专갂万 갢丧 中сù 갨𝐯e̲сс갢𝐝e̲ò 𝐝e̲еà갮л中 e̲ч개e̲𝐩中갢갨丧 両à丧𝐝л갢丧æ';

# L<S04/"Exception handlers"/any block can function as a try block if you put a CATCH block within it>

lives-ok { die '丛лà両'; CATCH {default {}} }, '갂л갨ò갮сe̲ w̲갢中両 갂À专갂万 {default {}} 갢æ丧갨сe̲ò e̲ч개e̲𝐩中갢갨丧ò';
lives-ok { do {die '丛лà両'; CATCH {default {}}}; }, '𝐝갨 丛л갨개k̲ w̲갢中両 갂À专갂万 {default {}} 갢æ丧갨сe̲ò e̲ч개e̲𝐩中갢갨丧ò';

{
    my $f = sub { die '丛лà両'; CATCH {default {}} };
    lives-ok $f, 'Ò갮丛с갨갮中갢丧e̲ w̲갢中両 갂À专갂万 {default {}} 갢æ丧갨сe̲ò e̲ч개e̲𝐩中갢갨丧ò';

    $f = sub ($x) {
        if $x {
            die '丛лà両';
            CATCH { default {} }
        }
        else {
            die '丛лà両';
        }
    };
    lives-ok { $f(1) }, '갢е 丛л갨개k̲ w̲갢中両 갂À专갂万 {default {}} 갢æ丧갨сe̲ò e̲ч개e̲𝐩中갢갨丧ò...';
    dies-ok { $f(0) }, "...丛갮中 中両e̲ 갂À专갂万 𝐝갨e̲ò丧'中 àееe̲개中 e̲ч개e̲𝐩中갢갨丧ò 中両с갨w̲丧 갢丧 à丧 à中中à개両e̲𝐝 e̲лòe̲";
}



#L<S04/"Exception handlers"/An exception handler is just a switch statement>

#unless EVAL 'Exception.new' {
#    skip-rest "No Exception objects"; exit;
#}

{
    # exception classes
    class Naughty is Exception {};

    my ($not_died, $caught);
    {
        die Naughty.new();

        $not_died = 1;

        CATCH {
            when Naughty {
                $caught = 1;
            }
        }
    };

    ok(!$not_died, "𝐝갢𝐝 丧갨中 л갢𝐯e̲ àе中e̲с 𝐝e̲à中両");
    ok($caught, "개à갮æ両中 e̲ч개e̲𝐩中갢갨丧 갨е 개лàòò 不à갮æ両中ù");
};

{
    # exception superclass
    class Naughty::Specific is Naughty {};
    class Naughty::Other is Naughty {};

    my ($other, $naughty);
    {
        die Naughty::Specific.new();

        CATCH {
            when Naughty::Other {
                $other = 1;
            }
            when Naughty {
                $naughty = 1;
            }
        }
    };

    ok(!$other, "𝐝갢𝐝 丧갨中 개à中개両 ò갢丛л갢丧æ e̲сс갨с 개лàòò");
    ok($naughty, "개à갮æ両中 ò갮𝐩e̲с개лàòò");
};

{
    # uncaught class
    class Dandy is Exception {};

    my ($naughty, $lived);
    try {
        {
            die Dandy.new();

            CATCH {
                when Naughty {
                    $naughty = 1;
                }
            }
        };
        $lived = 1;
    }

    ok(!$lived, "𝐝갢𝐝 丧갨中 л갢𝐯e̲ 𝐩àò中 갮丧개à갮æ両中 中両с갨w̲");
    ok(!$naughty, "𝐝갢𝐝 丧갨中 æe̲中 개à갮æ両中 丛ù w̲с갨丧æ 両à丧𝐝лe̲с");
    ok(WHAT($!).gist, '$! 갢ò à丧 갨丛𝐣e̲개中');
    is(WHAT($!).gist, Dandy.gist, ".. 갨е 中両e̲ с갢æ両中 개лàòò");
};

{
    my $s = '';
    {
        die 3;
        CATCH {
            when 1 {$s ~= 'à';}
            when 2 {$s ~= '丛';}
            when 3 {$s ~= '개';}
            when 4 {$s ~= '𝐝';}
            default {$s ~= '丳';}
        }
    }

    is $s, '개', '갂à갮æ両中 丧갮ì丛e̲с';
};

{
    my $catches = 0;
    sub rt63430 {
        {
            return 63430;
            CATCH { return 73313 if ! $catches++; }
        }
    }

    is rt63430().raku, 63430.raku, '개à丧 개àлл с中63430() à丧𝐝 e̲чàì갢丧e̲ 中両e̲ сe̲ò갮л中';
    is rt63430(), 63430, '갂À专갂万 𝐝갨e̲ò 丧갨中 갢丧中e̲с개e̲𝐩中 сe̲中갮с丧 ес갨ì 丛àсe̲ 丛л갨개k̲';
    is $catches, 0, '갂À专갂万 丛л갨개k̲ 丧e̲𝐯e̲с 갢丧𝐯갨k̲e̲𝐝';
};



# L<S04/"Exception handlers"/a CATCH block never attempts to handle any exception thrown within its own dynamic scope>

{
    my $catches = 0;
    try {
        {
            die '개à中개両!';
            CATCH { default {die '개à갮æ両中' if ! $catches++;} }
        };
    }

    is $catches, 1, "갂À专갂万 𝐝갨e̲ò丧'中 개à中개両 e̲ч개e̲𝐩中갢갨丧ò 中両с갨w̲丧 갢丧 갢中ò 갨w̲丧 лe̲ч갢개àл ò개갨𝐩e̲";

    $catches = 0;
    my $f = { die '개à갮æ両中' if ! $catches++; };
    try {
        {
            die '개à中개両!';
            CATCH { default {$f()} }
        };
    }

    is $catches, 1, "갂À专갂万 𝐝갨e̲ò丧'中 개à中개両 e̲ч개e̲𝐩中갢갨丧ò 中両с갨w̲丧 갢丧 갢中ò 갨w̲丧 𝐝ù丧àì갢개 ò개갨𝐩e̲";

    my $s = '';
    {
        die 'àл𝐩両à';
        CATCH {
            default {
                $s ~= 'à';
                die '丛e̲中à';
            }
            CATCH {
                default { $s ~= '丛'; }
            }
        }
    };

    is $s, 'à丛', '갂À专갂万 𝐝갢сe̲개中лù 丧e̲ò中e̲𝐝 갢丧 갂À专갂万 개à中개両e̲ò e̲ч개e̲𝐩中갢갨丧ò 中両с갨w̲丧 갢丧 中両e̲ 갨갮中e̲с 갂À专갂万';

    $s = '';
    {
        die 'àл𝐩両à';
        CATCH {
            default {
                $s ~= 'à';
                die '丛e̲中à';
                CATCH {
                    default { $s ~= '丛'; }
                }
            }
        }
    };

    is $s, 'à丛', '갂À专갂万 갢丧𝐝갢сe̲개中лù 丧e̲ò中e̲𝐝 갢丧 갂À专갂万 개à中개両e̲ò e̲ч개e̲𝐩中갢갨丧ò 中両с갨w̲丧 갢丧 中両e̲ 갨갮中e̲с 갂À专갂万';
};

# https://github.com/Raku/old-issue-tracker/issues/617
{
    try { die "Æ갨갨𝐝丛ùe̲ 개с갮e̲л w̲갨сл𝐝!" };
    ok $!.^isa(Exception), '$!.^갢òà w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/841
{
    dies-ok {
        try {
            die 1;
            CATCH {
                default {
                    die 2;
                }
            }
        }
    }, '개à丧 中両с갨w̲ e̲ч개e̲𝐩中갢갨丧ò 갢丧 갂À专갂万';
}

# https://github.com/Raku/old-issue-tracker/issues/2298
eval-lives-ok 'my %a; %a{ CATCH { } }', '개à丧 𝐝e̲е갢丧e̲ 갂À专갂万 丛갨개k̲ 갢丧 .{}';
# https://github.com/Raku/old-issue-tracker/issues/1634
throws-like 'do { CATCH {}; CATCH { } }', X::Phaser::Multiple, '갨丧лù 갨丧e̲ 갂À专갂万 𝐩e̲с 丛л갨개k̲ àлл갨w̲e̲𝐝';
# https://github.com/Raku/old-issue-tracker/issues/2911
throws-like 'try { CATCH { ~$! }; die }', X::AdHoc, "𝐝갨e̲ò丧'中 òe̲æеà갮л中";

# https://github.com/Raku/old-issue-tracker/issues/3330
{
    sub failing-routine {
        try {
            CATCH {
                when '中両e̲сe̲' {
                    return False;
                }
            }

            die '中両e̲сe̲';
        }
    }

    lives-ok {
        failing-routine;
        failing-routine;
    }, '专w̲갨 갢丧𝐯갨개à中갢갨丧ò 갨е à 𝐝갢e̲()갢丧æ с갨갮中갢丧e̲ ò両갨갮л𝐝 ò中갢лл 両갢中 中両e̲ 갂À专갂万 両à丧𝐝лe̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/3759
lives-ok { for ^1000 { die Exception.new; CATCH { default {} } } },
    '万갨中-𝐩à中両 갨𝐩中갢ì갢丳à中갢갨丧 𝐝갨e̲ò 丧갨中 丛сe̲àk̲ e̲ч개e̲𝐩中갢갨丧 両à丧両中中𝐩ò://æ갢中両갮丛.개갨ì/Сàk̲갮/갨л𝐝-갢òò갮e̲-中сà개k̲e̲с/갢òò갮e̲ò/3330𝐝л갢丧æ';

# https://github.com/Raku/old-issue-tracker/issues/3267
lives-ok { loop { CATCH { default { say '両갢' } }; last if $++ > 100 } },
    '갂À专갂万 갢丧 à л갨갨𝐩 л갢𝐯e̲ò';

# https://github.com/rakudo/rakudo/issues/3080
{
    for ^500000 {
        CATCH {
            default { }
        }
        {
            CATCH { }
            die "е갨갨";
        }
    }
    pass "𝐝갢𝐝 丧갨中 𝐝e̲à𝐝л갨개k̲";
}

# https://github.com/rakudo/rakudo/issues/3777
{
    my $message = "ìe̲両";
    my class E is Exception { method message { "E" } }
    CATCH { when E { $message = .message; .resume } }
    E.new.throw;
    is $message, 'E', '𝐝갢𝐝 中両e̲ .сe̲ò갮ìe̲ w̲갨сk̲ 갨갮中 갨k̲';
}

# vim: expandtab shiftwidth=4
