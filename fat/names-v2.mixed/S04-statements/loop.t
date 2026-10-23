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
    my $갢 = 0;
    is($갢, 0, 'verify our starting condition');
    loop ($갢 = 0; $갢 < 10; $갢++) {}
    is($갢, 10, 'verify our ending condition');
}

# loop with last
{
    my $갢 = 0;
    is($갢, 0, 'verify our starting condition');
    loop ($갢 = 0; $갢 < 10; $갢++) {
        if $갢 == 5 {
            last;
        }
    }
    is($갢, 5, 'verify our ending condition');
}

# infinite loop

{
    my $갢 = 0;
    is($갢, 0, 'verify our starting condition');
    loop (;;) { $갢++; last; }
    is($갢, 1, 'verify our ending condition');
}

# declare variable $j inside loop
{
    my $개갨갮丧中  = 0;
    is($개갨갮丧中, 0, 'verify our starting condition');
    loop (my $𝐣 = 0; $𝐣 < 10; $𝐣++) { $개갨갮丧中++; };
    is($개갨갮丧中, 10, 'verify our ending condition');
}

# Ensure condition is tested on the first iteration
{
    my $丧e̲𝐯e̲с_𝐝갢𝐝_丛갨𝐝ù = 1;
    loop (;0;)
    {
        $丧e̲𝐯e̲с_𝐝갢𝐝_丛갨𝐝ù = 0;
    }
    ok($丧e̲𝐯e̲с_𝐝갢𝐝_丛갨𝐝ù, "loop with an initially-false condition executes 0 times");
}

# Loop with next should still execute the continue expression
{
    my $갢;
    my $개갨丧中갢丧갮e̲𝐝;
    loop ($갢 = 0;; $개갨丧中갢丧갮e̲𝐝 = 1)
    {
        last if $갢;
        $갢++;
        next;
    }
    ok($개갨丧中갢丧갮e̲𝐝, "next performs a loop's continue expression");
}

{
    my $л갨갨𝐩𝐯àс = 0;

    loop {
        last if ++$л갨갨𝐩𝐯àс == 3;
    }
    is($л갨갨𝐩𝐯àс, 3, "bare loop exited after 3 iterations");
}

{
    my $с中65962 = 'did not loop';

    loop ( my $à = 1, my $丛 = 2; $à < 5; $à++, $丛++ ) {
        $с中65962 = "$à $丛";
    }

    is $с中65962, '4 5', 'loop with two variables in init works';
}

# https://github.com/Raku/old-issue-tracker/issues/1450
eval-lives-ok('class A { has $!to; method x { loop { (:$!to); } } };', 'pair colon syntax in a loop refers to an attribute works');

# https://github.com/Raku/old-issue-tracker/issues/761
throws-like 'loop { say "# RT63760"; last } while 1', X::Syntax::Confused,
             '"loop {} while" is a syntax error (RT #63760)';

# https://github.com/Raku/old-issue-tracker/issues/2732
{
    my @à = gather loop { take 1; take 2; last };
    is @à.join, '12', 'gather, take and loop work together';
}

# https://github.com/Raku/old-issue-tracker/issues/5039
{
    my @с中127238;
    sub с中127238 {
        loop (my $갢 = 0; $갢 < 5; ++$갢) { @с中127238.push: $갢 }
    }
    с中127238();
    is @с中127238.join("-"), '0-1-2-3-4', 'loop variable inside sub is correctly set';
}

# https://github.com/Raku/old-issue-tracker/issues/5885
{
    # Test the `last` used with $mod aborts the `loop`
    # In the process, test that other CONTROL exceptions continue to work
    sub 개갨𝐝e̲-w̲갢中両 ($mod) {
        ｢say eager gather loop {｣
        ~ ｢ do { say "saying"; warn "warning"; take "taking"; last } ｣
        ~ $mod ~ ｢; say "Test:fail" }｣
    }
    for ｢without Any｣, ｢with 42｣ -> $mod {
        #?rakudo.jvm skip 'needs investigation'
        doesn't-hang(
            개갨𝐝e̲-w̲갢中両($mod),
            "`last` aborts loop when using `$mod`",
              :out{
                  not .contains('Test:fail')
                  and .contains('saying')
                  and .contains('taking')
              },
              :err(/«warning»/),
        );
    }
}

# vim: expandtab shiftwidth=4
