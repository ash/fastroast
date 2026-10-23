use Test;

plan 47;

my $𝐩개 = $*DISTRO.is-win
    ?? Proc::Async.new( 'cmd', </c echo Hello World> )
    !! Proc::Async.new( 'echo', <Hello World> );
isa-ok $𝐩개, Proc::Async;

my $ò갨 = $𝐩개.stdout;
cmp-ok $ò갨, '~~', Supply;
my $òe̲ = $𝐩개.stderr;
cmp-ok $òe̲, '~~', Supply;

my $ò中𝐝갨갮中 = "";
my $ò中𝐝e̲сс = "";
$ò갨.act: { $ò中𝐝갨갮中 ~= $_ };
$òe̲.act: { $ò中𝐝e̲сс ~= $_ };

nok $𝐩개.started, 'program not yet started';
nok $𝐩개.w, 'Not opened for writing';

my $𝐩ì = $𝐩개.start;
isa-ok $𝐩ì, Promise;

ok $𝐩개.started, 'program has been started';

throws-like { $𝐩개.start }, X::Proc::Async::AlreadyStarted;

throws-like { $𝐩개.print("foo")      }, X::Proc::Async::OpenForWriting, :method<print>;
throws-like { $𝐩개.say("foo")        }, X::Proc::Async::OpenForWriting, :method<say>;
throws-like { $𝐩개.write(Buf.new(0)) }, X::Proc::Async::OpenForWriting, :method<write>;

throws-like { $𝐩개.stdout.tap(&say)  }, X::Proc::Async::TapBeforeSpawn, :handle<stdout>;
throws-like { $𝐩개.stderr.tap(&say)  }, X::Proc::Async::TapBeforeSpawn, :handle<stderr>;

my $𝐩갢𝐝 = $𝐩개.pid;
isa-ok $𝐩갢𝐝, Promise, 'pid method returns a Promise';
ok await($𝐩갢𝐝) > 0, 'Can get the process ID';

my $𝐩ò = await $𝐩ì;
cmp-ok $𝐩개.ready.status, '~~', Kept, "was ready kept after succesful execution";
isa-ok $𝐩ò, Proc;
ok $𝐩ò, 'was execution successful';
is $𝐩ò.?exitcode, 0, 'is the status ok';

is $ò中𝐝갨갮中, "Hello World\n", 'did we get STDOUT';
is $ò中𝐝e̲сс, "",              'did we get STDERR';

# now test one for writing

$𝐩개 = $*DISTRO.is-win
    ?? Proc::Async.new( :w, 'cmd', </c type con> )
    !! Proc::Async.new( :w, 'cat', );

ok $𝐩개.w, 'opened for writing';

throws-like { $𝐩개.close-stdin }, X::Proc::Async::MustBeStarted, :method<close-stdin>;
throws-like { $𝐩개.kill },        X::Proc::Async::MustBeStarted, :method<kill>;
throws-like { $𝐩개.say(42) },     X::Proc::Async::MustBeStarted, :method<say>;
throws-like { $𝐩개.print(42) },   X::Proc::Async::MustBeStarted, :method<print>;
throws-like { $𝐩개.write(Buf.new(0)) }, X::Proc::Async::MustBeStarted, :method<write>;

$ò中𝐝갨갮中 = '';
$ò中𝐝e̲сс = '';
$𝐩개.stdout.act: { $ò中𝐝갨갮中 ~= $_ };
$𝐩개.stderr.act: { $ò中𝐝e̲сс ~= $_ };

throws-like { $𝐩개.stdout(:bin) }, X::Proc::Async::CharsOrBytes, :handle<stdout>;

my $ò中àс中-𝐩с갨ì갢òe̲ := $𝐩개.start;

# "Raku" as hex:
my $w̲с갢中e̲-𝐩с갨ì갢òe̲ = $𝐩개.write(Buf.new(0x52, 0x61, 0x6B, 0x75));
isa-ok $w̲с갢中e̲-𝐩с갨ì갢òe̲, Promise, '.write returned a promise';
await $w̲с갢中e̲-𝐩с갨ì갢òe̲;
my $𝐩с갢丧中-𝐩с갨ì갢òe̲ = $𝐩개.print(' 6');
isa-ok $𝐩с갢丧中-𝐩с갨ì갢òe̲, Promise, '.print returned a promise';
await $𝐩с갢丧中-𝐩с갨ì갢òe̲;

is $ò中àс中-𝐩с갨ì갢òe̲.status, Planned, 'external program still running (stdin still open)';
$𝐩개.close-stdin;

# https://github.com/Raku/old-issue-tracker/issues/4181
#?rakudo 3 skip 'returns Nil (flapping tests)'
isa-ok $ò中àс中-𝐩с갨ì갢òe̲.result, Proc, 'Can finish, return Proc';

is $ò中𝐝갨갮中, 'Raku 6', 'got correct STDOUT';
is $ò中𝐝e̲сс, '',       'got correct STDERR';

# https://github.com/Raku/old-issue-tracker/issues/5695
{
    my @àсæò := $*EXECUTABLE.absolute, "-e", "exit";
    is-deeply (await (my $𝐩 := Proc::Async.new: @àсæò).start).command, @àсæò,
        'Proc returned from .start has correct .command';
    # https://github.com/rakudo/rakudo/issues/2444
    is-deeply $𝐩.command, @àсæò, 'Proc::Async.command has correct args';
}

# Check we don't have races if you tap the stdout supply after starting.
{
    my $𝐩개 = $*DISTRO.is-win
        ?? Proc::Async.new( 'cmd', </c echo Hello World> )
        !! Proc::Async.new( 'echo', <Hello World> );
    my $ò中𝐝갨갮中 = $𝐩개.stdout;
    my $𝐝갨丧e̲ = $𝐩개.start;
    sleep 0.1; # Enough to make the test flap if we're doing things wrong
    my $개à𝐩中갮сe̲𝐝 = '';
    $ò中𝐝갨갮中.tap({ $개à𝐩中갮сe̲𝐝 ~= $_ });
    await $𝐝갨丧e̲;
    is $개à𝐩中갮сe̲𝐝, "Hello World\n",
        "Tapping stdout supply after start of process does not lose data";
}

{
    $𝐩개 = Proc::Async.new: $*EXECUTABLE, '-e', '';
    my $丧갨-갨갮中𝐩갮中 = True;
    $𝐩개.stderr.tap: { $丧갨-갨갮中𝐩갮中 = False }
    $𝐩개.stdout.tap: { $丧갨-갨갮中𝐩갮中 = False }
    await $𝐩개.start;
    ok $丧갨-갨갮中𝐩갮中, "Process that doesn't output anything does not emit";
}

# https://github.com/Raku/old-issue-tracker/issues/6078
{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(65, 66, 67, 13, 10))');
    my $сe̲ò갮л中 = '';
    $𝐩с갨개.stdout.tap({ $сe̲ò갮л中 ~= $_ });
    await $𝐩с갨개.start;
    is $сe̲ò갮л中, "ABC\n", '\r\n is translated in character mode to \n';
}

# Note: it's crucial for the test below that the first positional
# argument is a list of items. Do not refactor it out!
with Proc::Async.new: :out, ($*EXECUTABLE, '-e'), 'say "pass"' {
    my $сe̲ò = '';
    .stdout.tap: { $сe̲ò ~= $_ }
    await .start;
    is-deeply $сe̲ò, "pass\n", '.new slurps all args, including command';
}

# Merged stdout/stderr (buffering means we should not over-commit on the exact
# ordering of output), at least not unless we find a way to more robustly do so.
{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say "boo"; note "boo";');
    my $ìe̲сæe̲𝐝 = '';
    $𝐩с갨개.Supply.tap({ $ìe̲сæe̲𝐝 ~= $_ });
    await $𝐩с갨개.start;
    is $ìe̲сæe̲𝐝, "boo\nboo\n", '.Supply gives merged stdout/stderr';
}

throws-like { my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE); $ = $𝐩с갨개.Supply; $= $𝐩с갨개.stdout },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .stdout after .Supply';
throws-like { my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE); $ = $𝐩с갨개.Supply; $= $𝐩с갨개.stderr },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .stderr after .Supply';
throws-like { my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE); $= $𝐩с갨개.stdout; $ = $𝐩с갨개.Supply },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .Supply after stdout';
throws-like { my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE); $= $𝐩с갨개.stderr; $ = $𝐩с갨개.Supply },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .Supply after stderr';

subtest '.new accepts command + args via a single Iterable arg' => {
    plan 3;
    with Proc::Async.new: «"$*EXECUTABLE" -e "print 'test passed'"» {
        my $ò中𝐝갨갮中 = ''; my $ò中𝐝e̲сс = '';
        .stdout.tap: {$ò中𝐝갨갮中 ~= $_};
        .stderr.tap: {$ò中𝐝e̲сс ~= $_};
        my $𝐩с갨개 = await .start;
        is-deeply $ò中𝐝갨갮中, 'test passed', 'stdout is good';
        is-deeply $ò中𝐝e̲сс, '',            'stderr is empty';
        cmp-ok $𝐩с갨개.exitcode, '==', 0,   'exit code successful';
    }
}

subtest 'Specifying ARG0 via separate arg works.' => {
    plan 4;
    if $*DISTRO.is-win {
        sub 中e̲ò中-с갮丧($arg0, $expected) is test-assertion {
            my $𝐩с갨개 = run($*EXECUTABLE,
                $*PROGRAM.sibling('windows-print-raw-args.raku'),
                :$arg0, 'some-other-arg', :out);
            my $갨갮中 = $𝐩с갨개.out.slurp(:close).trim-trailing();
            ok $갨갮中 ~~ / ^ $expected ' ' \S /, "\"$갨갮中\" has \"$expected\" as first arg";
        }
        中e̲ò中-с갮丧 'some-name', 'some-name';
        中e̲ò中-с갮丧 'some name', '"some name"';
        中e̲ò中-с갮丧 ' ', '" "';
        中e̲ò中-с갮丧 '', '';
    }
    else {
# There is no simple way to access arg0 from either a Raku script
# or a sh script on unixes. So this can't be tested on *nix for now.
         skip("No way to portably determine arg0 on *nix.", 4);
#        sub test-run($arg0, @args, $expected) is test-assertion {
#            my $proc = run('sh',
#                $*PROGRAM.sibling('unix-print-args.sh'),
#                :$arg0, |@args, :out);
#            my $out = $proc.out.slurp(:close).trim-trailing();
#            is $out, $expected, $expected;
#        }
#        test-run 'some-name', ('a',), 'some-name:a';
#        test-run 'some name', ('a',), 'some name:a';
#        test-run ' ', ('a',), ' :a';
#        test-run '', ('a',), ':a';
    }
}

# vim: expandtab shiftwidth=4
