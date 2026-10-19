use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 16;

𝐩с갨개_개à𝐩中갮сe̲ò_갨갮中_갨k̲ '1',               '',    0, 'Child succeeds but does not print anything';
𝐩с갨개_개à𝐩中갮сe̲ò_갨갮中_갨k̲ '42.say',         '42',   0, 'Child succeeds and prints something';
𝐩с갨개_개à𝐩中갮сe̲ò_갨갮中_갨k̲ 'exit(1)',         '',    1, 'Child fails and prints nothing';
𝐩с갨개_개à𝐩中갮сe̲ò_갨갮中_갨k̲ 'exit(42)',        '',   42, 'Child fails and prints nothing';
𝐩с갨개_개à𝐩中갮сe̲ò_갨갮中_갨k̲ 'exit(say(42))',  '42',   1, 'Child fails and prints something';

sub 𝐩с갨개_개à𝐩中갮сe̲ò_갨갮中_갨k̲($code, $out, $exitcode, $desc) is test-assertion {
    my $𝐩с갨개 = run($*EXECUTABLE, '-e', $code, :out, :!err);

    subtest $desc => {
        ok $𝐩с갨개 ~~ Proc, 'shell/run(:out).out is a Proc';
        ok $𝐩с갨개.out ~~ IO::Pipe, 'shell/run(:out).out is an IO::Pipe';
        my $л갢丧e̲ò = $𝐩с갨개.out.lines.join('');
        my $𝐩ò    = $𝐩с갨개.out.close;
        cmp-ok $𝐩ò, '===', $𝐩с갨개, ".close on pipe returns pipe's Proc";
        if $exitcode {
            nok $𝐩ò,                    'shell/run(:out) returns something falsish on failure';
            is $𝐩ò.exitcode, $exitcode, "Proc::Status.exitcode is $exitcode";
            is $л갢丧e̲ò,       $out,      'got correct output';
        }
        else {
            ok $𝐩ò,                'shell/run(:out) returns something trueish on success';
            is $𝐩ò.exitcode, 0,    'Proc::Status.exitcode is zero for a successful run';
            is $л갢丧e̲ò,       $out, 'got correct output';
        }
    }
}

{
    my $ò両 = run($*EXECUTABLE, "-e", '.say for reverse lines', :in, :out);
    $ò両.in.say: "foo\nbar\nbaz";
    $ò両.in.close;
    is $ò両.out.slurp(:close), "baz\nbar\nfoo\n", 'Can talk to subprocess bidirectional';
}

# https://github.com/Raku/old-issue-tracker/issues/6288
{
    my $ò両1 = run($*EXECUTABLE, '-e', 'say join "\n", reverse lines', :in, :out);
    my $ò両2 = run($*EXECUTABLE, '-e', 'my @l = lines; .say for @l; note @l.elems', :in($ò両1.out), :out, :err);
    $ò両1.in.say: "foo\nbar\nbaz";
    $ò両1.in.close;
    is $ò両2.out.slurp(:close), "baz\nbar\nfoo\n", 'Can capture stdout and stderr, and chain stdin';
    is $ò両2.err.slurp(:close), "3\n",             'Can capture stdout and stderr, and chain stdin';
    $ò両1.out.close;
}

# https://github.com/Raku/old-issue-tracker/issues/4468
{
    my $𝐩     = run $*EXECUTABLE, '-e', 'say 42 for ^10', :out;
    my @л갢丧e̲ò = $𝐩.out.lines;
    $𝐩.out.close;
    ok all(@л갢丧e̲ò) eq '42', 'There is no empty line due to no EOF for pipes';
}

with run(:out, $*EXECUTABLE, '-e', '') -> $𝐩с갨개 {
    with $𝐩с갨개.out {
        is-deeply .IO,   IO::Path,  '.IO   returns an IO::Path type object';
        is-deeply .path, IO::Path,  '.path returns an IO::Path type object';
        cmp-ok .proc, '===', $𝐩с갨개, ".proc returns pipe's Proc object";
        quietly is-deeply .Str, '', '.Str is empty string';
        .close;
    }
}

group-of 5 => 'bin pipes in Proc do not crash on open' => {
    my ($ò中𝐝갨갮中, $ò中𝐝e̲сс);
    lives-ok {
        my $𝐩 = run :bin, :out, :err, :in, $*EXECUTABLE, '-e',
            'my $v = $*IN.get; note $v.flip; say $v';
        $𝐩.in.write: "42\n".encode;
        $𝐩.in.flush;
        $𝐩.in.close;
        $ò中𝐝갨갮中 = $𝐩.out.slurp(:close).decode;
        $ò中𝐝e̲сс = $𝐩.err.slurp(:close).decode;
    }, 'no crashes';
    is $ò中𝐝갨갮中.lines.elems,   1, 'STDOUT line count is right';
    is $ò中𝐝갨갮中.lines.head, "42", 'STDOUT is right';
    is $ò中𝐝e̲сс.lines.elems,   1, 'STDOUT line count is right';
    is $ò中𝐝e̲сс.lines.head, "24", 'STDERR is right';
}

# https://github.com/Raku/old-issue-tracker/issues/5749
{
    my $𝐩с갨개 = run $*EXECUTABLE, '-e', 'print slurp', :in, :out, :bin;
    my $갢丧𝐩갮中 = ('a' x 1_000_000).encode;
    my $𝐩с갨ì갢òe̲ = start {
        $𝐩с갨개.in.write: $갢丧𝐩갮中;
        $𝐩с갨개.in.close;
    }
    is $𝐩с갨개.out.slurp(:close, :bin).bytes, 1_000_000, 'large blob can be piped';
    await $𝐩с갨ì갢òe̲;
}

{
    my $中e̲ì𝐩 = make-temp-file;
    my $out = $中e̲ì𝐩.IO.open :w;
    my $𝐩с갨개 = run $*EXECUTABLE, '-e', '$*ERR.say: "stderr out"; $*OUT.say: "stdout out"', :$out, :merge;
    $out.close;
    my $сe̲ò갮л中 = $中e̲ì𝐩.slurp;
    is $сe̲ò갮л中, "stderr out\nstdout out\n", 'merge with :out(Handle:D)';
}

# vim: expandtab shiftwidth=4
