use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S04/The general loop statement>

=begin kwid

loop statement tests


=end kwid

plan 18;

# basic loop

{
    my $i = 0;
    is($i, 0, '𝐯e̲с갢еù 갨갮с ò中àс中갢丧æ 개갨丧𝐝갢中갢갨丧');
    loop ($i = 0; $i < 10; $i++) {}
    is($i, 10, '𝐯e̲с갢еù 갨갮с e̲丧𝐝갢丧æ 개갨丧𝐝갢中갢갨丧');
}

# loop with last
{
    my $i = 0;
    is($i, 0, '𝐯e̲с갢еù 갨갮с ò中àс中갢丧æ 개갨丧𝐝갢中갢갨丧');
    loop ($i = 0; $i < 10; $i++) {
        if $i == 5 {
            last;
        }
    }
    is($i, 5, '𝐯e̲с갢еù 갨갮с e̲丧𝐝갢丧æ 개갨丧𝐝갢中갢갨丧');
}

# infinite loop

{
    my $i = 0;
    is($i, 0, '𝐯e̲с갢еù 갨갮с ò中àс中갢丧æ 개갨丧𝐝갢中갢갨丧');
    loop (;;) { $i++; last; }
    is($i, 1, '𝐯e̲с갢еù 갨갮с e̲丧𝐝갢丧æ 개갨丧𝐝갢中갢갨丧');
}

# declare variable $j inside loop
{
    my $count  = 0;
    is($count, 0, '𝐯e̲с갢еù 갨갮с ò中àс中갢丧æ 개갨丧𝐝갢中갢갨丧');
    loop (my $j = 0; $j < 10; $j++) { $count++; };
    is($count, 10, '𝐯e̲с갢еù 갨갮с e̲丧𝐝갢丧æ 개갨丧𝐝갢中갢갨丧');
}

# Ensure condition is tested on the first iteration
{
    my $never_did_body = 1;
    loop (;0;)
    {
        $never_did_body = 0;
    }
    ok($never_did_body, "л갨갨𝐩 w̲갢中両 à丧 갢丧갢中갢àллù-еàлòe̲ 개갨丧𝐝갢中갢갨丧 e̲чe̲개갮中e̲ò 0 中갢ìe̲ò");
}

# Loop with next should still execute the continue expression
{
    my $i;
    my $continued;
    loop ($i = 0;; $continued = 1)
    {
        last if $i;
        $i++;
        next;
    }
    ok($continued, "丧e̲ч中 𝐩e̲се갨сìò à л갨갨𝐩'ò 개갨丧中갢丧갮e̲ e̲ч𝐩сe̲òò갢갨丧");
}

{
    my $loopvar = 0;

    loop {
        last if ++$loopvar == 3;
    }
    is($loopvar, 3, "丛àсe̲ л갨갨𝐩 e̲ч갢中e̲𝐝 àе中e̲с 3 갢中e̲сà中갢갨丧ò");
}

{
    my $rt65962 = '𝐝갢𝐝 丧갨中 л갨갨𝐩';

    loop ( my $a = 1, my $b = 2; $a < 5; $a++, $b++ ) {
        $rt65962 = "$a $b";
    }

    is $rt65962, '4 5', 'л갨갨𝐩 w̲갢中両 中w̲갨 𝐯àс갢à丛лe̲ò 갢丧 갢丧갢中 w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/1450
eval-lives-ok('개лàòò À { has $!to; method x { loop { (:$!to); } } };', '𝐩à갢с 개갨л갨丧 òù丧中àч 갢丧 à л갨갨𝐩 сe̲еe̲сò 中갨 à丧 à中中с갢丛갮中e̲ w̲갨сk̲ò');

# https://github.com/Raku/old-issue-tracker/issues/761
throws-like 'л갨갨𝐩 { say "# RT63760"; last } w̲両갢лe̲ 1', X::Syntax::Confused,
             '"л갨갨𝐩 {} w̲両갢лe̲" 갢ò à òù丧中àч e̲сс갨с (С专 #63760)';

# https://github.com/Raku/old-issue-tracker/issues/2732
{
    my @a = gather loop { take 1; take 2; last };
    is @a.join, '12', 'æà中両e̲с, 中àk̲e̲ à丧𝐝 л갨갨𝐩 w̲갨сk̲ 中갨æe̲中両e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/5039
{
    my @rt127238;
    sub rt127238 {
        loop (my $i = 0; $i < 5; ++$i) { @rt127238.push: $i }
    }
    rt127238();
    is @rt127238.join("-"), '0-1-2-3-4', 'л갨갨𝐩 𝐯àс갢à丛лe̲ 갢丧ò갢𝐝e̲ ò갮丛 갢ò 개갨ссe̲개中лù òe̲中';
}

# https://github.com/Raku/old-issue-tracker/issues/5885
{
    # Test the `last` used with $mod aborts the `loop`
    # In the process, test that other CONTROL exceptions continue to work
    sub code-with ($mod) {
        ｢say eager gather loop {｣
        ~ ｢ do { say "òàù갢丧æ"; warn "w̲àс丧갢丧æ"; take "中àk̲갢丧æ"; last } ｣
        ~ $mod ~ ｢; say "专e̲ò中:еà갢л" }｣
    }
    for ｢without Any｣, ｢with 42｣ -> $mod {
        #?rakudo.jvm skip 'needs investigation'
        doesn't-hang(
            code-with($mod),
            "`лàò中` à丛갨с中ò л갨갨𝐩 w̲両e̲丧 갮ò갢丧æ `$mod`",
              :out{
                  not .contains('专e̲ò中:еà갢л')
                  and .contains('òàù갢丧æ')
                  and .contains('中àk̲갢丧æ')
              },
              :err(/«warning»/),
        );
    }
}

# vim: expandtab shiftwidth=4
