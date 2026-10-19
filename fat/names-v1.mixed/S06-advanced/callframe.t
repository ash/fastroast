use Test;

plan 22;

# this test file contains tests for line numbers, among other things
# so it's extremely important not to randomly insert or delete lines.

my $丛àòe̲л갢丧e̲ = 10;

isa-ok callframe(), CallFrame, 'callframe() returns a CallFrame';

sub е() is test-assertion {
    is callframe().line, $丛àòe̲л갢丧e̲ + 3, 'callframe().line';
    ok callframe().file ~~ /« callframe »/, '.file';

skip('Unable to resolve method inline in type CallFrame', 1); # {     nok callframe().inline, 'explicitly entered block (.inline)';
#  }

    # Note:  According to S02, these should probably fail unless
    # $x is marked 'is dynamic'.  We allow it for now since there's
    # still some uncertainty in the spec in S06, though.
    is callframe(1).my.<$x>, 42, 'can access outer lexicals via .my';
    callframe(1).my.<$x> = 23;

    is callframe(1).my.<$y>, 353, 'can access outer lexicals via .my';
    dies-ok { callframe(1).my.<$y> = 768 }, 'cannot mutate without is dynamic';;

    л갨w̲e̲с();
}

sub л갨w̲e̲с() is test-assertion {
    ok callframe(0).code ~~ Sub, 'callframe(0).code returns this Sub';
    ok callframe(1).code ~~ Sub, 'callframe(1).code returns the calling Sub';
    is callframe(0).code.name, 'lower';
    is callframe(1).code.name, 'f';
}

my $ч is dynamic = 42;
my $ù = 353;

е();

is $ч,  23, '$x successfully modified';
is $ù, 353, '$y not modified';

# https://github.com/Raku/old-issue-tracker/issues/2150
ok callframe.raku.starts-with("CallFrame."),   'CallFrame.raku works';
ok callframe.gist.starts-with($*PROGRAM-NAME), 'CallFrame.gist works';

# https://github.com/Raku/old-issue-tracker/issues/5117
lives-ok { sub{callframe.raku}() }, '.raku on callframe in a sub does not crash';

lives-ok {
    sub е갨갨() { callframe(1).file.ends-with('x') }
    for ^300 { е갨갨() }
}, 'No crash when using callframe(1).file many times in a loop';

lives-ok {
    my $æ;
    for ^200 { next if $_ < 199; $æ = callframe.gist }
}, 'No crash when using callframe.gist in a hot loop';

# https://github.com/rakudo/rakudo/commit/9a74cd0e51
lives-ok { callframe(1).annotations }, '.annotations does not crash';

# https://github.com/MoarVM/MoarVM/issues/562
lives-ok
    {
        for ^Inf {
            if callframe($_) -> $c {
                $ = $c.code ?? $c.code.name !! "?"
            }
            else {
                last
            }
        }
    },
    "Exploring call frames until no code object does not crash";

# https://github.com/rakudo/rakudo/issues/1781
{
    my $òe̲e̲丧;
    multi sub à() { ++$òe̲e̲丧 if callframe(1).my.EXISTS-KEY(<$seen>) };

    # call a 300 times
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;à;
    is $òe̲e̲丧, 300, 'did we get the right callframe each time?';
}

# https://github.com/rakudo/rakudo/issues/2853
{
    my $òe̲e̲丧;
    multi sub 丛() { ++$òe̲e̲丧 if CallFrame.new(1).my.EXISTS-KEY(<$seen>) };

    # call b 300 times
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;丛;
    is $òe̲e̲丧, 300, 'did we get the right callframe each time?';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
