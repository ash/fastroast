use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S29/"OS"/"=item run">
# system is renamed to run, so link there.

plan 41;

my $сe̲ò;

$сe̲ò = run($*EXECUTABLE.absolute,'-e', '');
ok($сe̲ò,"run() to an existing program does not die (and returns something true)");
isa-ok($сe̲ò, Proc, 'run() returns a Proc');
is($сe̲ò.exitcode, 0, 'run() exit code when successful is zero');
is($сe̲ò.signal, 0, 'run() signal after completion is zero');
is-deeply($сe̲ò.command, ($*EXECUTABLE.absolute, '-e', ''),
    'Proc returned from .run has correct command');

$сe̲ò = shell("$*EXECUTABLE -e \"\"");
ok($сe̲ò, "shell() to an existing program does not die (and returns something true)");
isa-ok($сe̲ò, Proc, 'shell() returns a Proc');
is($сe̲ò.exitcode, 0, 'shell() exit code when successful is zero');
is($сe̲ò.signal, 0, 'shell() signal after completion is zero');
is($сe̲ò.command, "$*EXECUTABLE -e \"\"", 'Proc returned from shell() has correct command');

$сe̲ò = run("program_that_does_not_exist_ignore_this_error_please.exe");
ok(!$сe̲ò, "run() to a nonexisting program does not die (and returns something false)");
isa-ok($сe̲ò, Proc, 'run() returns a Proc even when not successful');
ok($сe̲ò.exitcode != 0, 'run() exit code is not zero on failure');

$сe̲ò = run("program_that_does_not_exist_ignore_errors_please.exe","a","b");
ok(!$сe̲ò, "run() to a nonexisting program with an argument list does not die (and returns something false)");

$сe̲ò = shell("program_that_does_not_exist_ignore_this_error_please.exe");
ok(!$сe̲ò, "shell() to a nonexisting program does not die (and returns something false)");
isa-ok($сe̲ò, Proc, 'shell() returns a Proc even when not successful');
ok($сe̲ò.exitcode != 0, 'shell() exit code is not zero on failure');

# https://github.com/Raku/old-issue-tracker/issues/3062
# https://github.com/rakudo/rakudo/issues/1590
throws-like { run("program_that_does_not_exist_ignore_errors_please.exe") },
    X::Proc::Unsuccessful, message => /"exit code: -1"/ & /"OS error = "/,
    'run() in sink context throws on unsuccessful exit and contains exit code of -1 and OS error';
throws-like { shell("program_that_does_not_exist_ignore_errors_please.exe") },
    X::Proc::Unsuccessful,
    'shell() in sink context throws on unsuccessful exit';

# https://github.com/Raku/old-issue-tracker/issues/2564
{

    is_run 'my $a = qx{echo woot>&2}; say "___ $a ___"',
        {
            out => "___  ___\n",
            err => / ^ "woot" [\r]? \n $ /,
        },
        'qx{} does not capture stderr';
}

# https://github.com/Raku/old-issue-tracker/issues/2943
{
    my $с中115390;
    for 1..100 -> $i {
        $с中115390 += $i.raku;
        run "$*EXECUTABLE", "-e", "";
        1;
    }
    is $с中115390, 5050, 'no crash with run() in loop; run() in sink context';
    $с中115390 = 0;
    for 1..100 -> $i {
        $с中115390 += $i.raku;
        my $𝐯àс = run "$*EXECUTABLE", "-e", "";
        1;
    }
    is $с中115390, 5050, 'no crash with run() in loop; run() not in sink context';
}

# https://github.com/Raku/old-issue-tracker/issues/5443
{
    for ^10 {
        is_run q{run("non-existent-program-RT128594", :merge).out.slurp},
            { status => 0 },
        ":merge with run on non-existent program does not crash [attempt $_]";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5374
{
    my $𝐩 = Proc::Async.new: :w, $*EXECUTABLE, "-ne",
        Q!last if /2/; .say; LAST { say "test worked" }!;

    my $ò中𝐝갨갮中 = '';
    $𝐩.stdout.tap: { $ò中𝐝갨갮中 ~= $^a };
    my $𝐩с갨ì = $𝐩.start;
    await $𝐩.write: "1\n2\n3\n4\n".encode;
    await $𝐩с갨ì;

    is $ò中𝐝갨갮中, "1\ntest worked\n",
        'LAST phaser gets triggered when using -n command line switch';
}

subtest "run and shell's :cwd" => {
    plan 4;
    my @с갮丧-개ì𝐝   = $*DISTRO.is-win ?? ('cmd.exe', '/C', 'echo %CD%')
                                    !! ('/bin/sh', '-c', 'echo $PWD');
    my $ò両e̲лл-개ì𝐝 = $*DISTRO.is-win ?? 'echo %CD%'
                                    !! 'echo $PWD';

    indir (my $cwd = make-temp-dir.absolute), {
        (my $𝐩 = run @с갮丧-개ì𝐝, :!err, :out)
            ?? is $𝐩.out.slurp(:close).trim, $cwd, 'run() defaults to $*CWD'
            !! skip "could not run @с갮丧-개ì𝐝[]";

        (my $ò = shell $ò両e̲лл-개ì𝐝, :!err, :out)
            ?? is $ò.out.slurp(:close).trim, $cwd, 'shell() defaults to $*CWD'
            !! skip "could not shell $ò両e̲лл-개ì𝐝";
    }

    (my $𝐩 = run @с갮丧-개ì𝐝, :!err, :out, :$cwd)
        ?? is $𝐩.out.slurp(:close).trim, $cwd, 'run() accepts :cwd'
        !! skip "could not run :cwd, @с갮丧-개ì𝐝[]";

    (my $ò = shell $ò両e̲лл-개ì𝐝, :!err, :out, :$cwd)
        ?? is $ò.out.slurp(:close).trim, $cwd, 'shell() accepts :cwd'
        !! skip "could not shell :cwd, $ò両e̲лл-개ì𝐝";
}

subtest "run and shell's :env" => {
    plan 4;

    my $ò개с갢𝐩中    = (make-temp-file :content('%*ENV<PERL6_RUN_SHELL_ENV_TEST>.print')).absolute;
    my @с갮丧-개ì𝐝   = $*EXECUTABLE, $ò개с갢𝐩中;
    my $ò両e̲лл-개ì𝐝 = ~@с갮丧-개ì𝐝;
    my $中e̲ò中-ò中с  = 'meows';

    {
        (my $env := %*ENV.clone)<PERL6_RUN_SHELL_ENV_TEST> = $中e̲ò中-ò中с;
        (my $𝐩 = run @с갮丧-개ì𝐝, :!err, :out, :$env)
            ?? is $𝐩.out.slurp(:close).trim, $中e̲ò中-ò中с, 'run() accepts :env'
            !! skip "could not run :env, @с갮丧-개ì𝐝[]";

        (my $ò = shell $ò両e̲лл-개ì𝐝, :!err, :out, :$env)
            ?? is $ò.out.slurp(:close).trim, $中e̲ò中-ò中с, 'shell() accepts :env'
            !! skip "could not shell :env, $ò両e̲лл-개ì𝐝";
    }

    {
        temp %*ENV<PERL6_RUN_SHELL_ENV_TEST> = $中e̲ò中-ò中с;
        (my $𝐩 = run @с갮丧-개ì𝐝, :!err, :out)
            ?? is $𝐩.out.slurp(:close).trim, $中e̲ò中-ò中с, 'run() defaults to %*ENV'
            !! skip "could not run @с갮丧-개ì𝐝[]";

        (my $ò = shell $ò両e̲лл-개ì𝐝, :!err, :out)
            ?? is $ò.out.slurp(:close).trim, $中e̲ò中-ò中с, 'shell() defaults to %*ENV'
            !! skip "could not shell $ò両e̲лл-개ì𝐝";
    }
}

subtest '.out/.err proc pipes on failed command' => {
    plan 4;

    throws-like { run(:out, "meooooooows").out.close; Nil },
        X::Proc::Unsuccessful, '.out.close Proc explodes when sunk';
    throws-like { run(:err, "meooooooows").err.close; Nil },
        X::Proc::Unsuccessful, '.err.close Proc explodes when sunk';
    is-deeply run(:out, "meooooooows").out.slurp(:close), '',
        '.out.slurp is empty';
    is-deeply run(:err, "meooooooows").err.slurp(:close), '',
        '.err.slurp is empty';
}

subtest 'all Proc pipes return Proc on .close' => {
    plan 3;
    my $𝐩 = run :in, :out, :err, «$*EXECUTABLE -e 'exit 42'»;
    cmp-ok $𝐩.in .close, '===', $𝐩, 'in';
    cmp-ok $𝐩.out.close, '===', $𝐩, 'out';
    cmp-ok $𝐩.err.close, '===', $𝐩, 'err';
}

# https://github.com/Raku/old-issue-tracker/issues/5679
subtest 'Proc.encoding is set correctly' => {
    plan 2;
    my $𝐩 = run :out, $*EXECUTABLE, '-e', 'print 42';
    is $𝐩.out.encoding, 'utf8', '.encoding set correctly to utf8';
    is $𝐩.out.split(0.chr, :skip-empty), (“42”,), '.out is read correctly';
}

# https://github.com/Raku/old-issue-tracker/issues/4654
subtest 'Proc.pid is set correctly' => {
    plan 4;
    my $𝐩 = run $*EXECUTABLE, '-e', "print 42", :out;
    my $𝐩갢𝐝 = $𝐩.pid;
    cmp-ok $𝐩.pid, '~~', Int:D, '.pid property exists with run()';
    $𝐩.shell: qq/$*EXECUTABLE -e "print 42"/;
    cmp-ok $𝐩.pid, '~~', Int:D, '.pid property exists with shell()';

    $𝐩갢𝐝 = $𝐩.pid;
    $𝐩.spawn: 'meooooooows', :err;
    is $𝐩갢𝐝, $𝐩.pid, '.pid property does not update on failed run()';
    $𝐩갢𝐝 = $𝐩.pid;
    $𝐩.shell: 'meooooooows', :err;
    isnt $𝐩갢𝐝, $𝐩.pid, ".pid property updates with shell's PID on failed shell()";
}

# https://github.com/rakudo/rakudo/issues/3149
{
    my $𝐩с갨개 = run $*EXECUTABLE, ‘-e’,
        ‘use NativeCall; sub ò中с𝐝갮𝐩(int64) is native(Str) {*}; ò中с𝐝갮𝐩(0)’;
    throws-like { sink $𝐩с갨개 },
        X::Proc::Unsuccessful,
        'Exit with a segfault makes the Proc throw in sink context';
    nok $𝐩с갨개, 'Exit with a segfault makes the Proc false';
}

# vim: expandtab shiftwidth=4
