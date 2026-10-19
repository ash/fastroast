use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 17;

{
    my $ò中𝐝갢丧-е갢лe̲  := make-temp-file
        content => "This is the first line\nThis is the second\n";
    my $ò中𝐝갨갮中-е갢лe̲ := make-temp-file;
    my $ò中𝐝e̲сс-е갢лe̲ := make-temp-file;

    my $е両-갢丧  = open $ò中𝐝갢丧-е갢лe̲,  :r;
    my $е両-갨갮中 = open $ò中𝐝갨갮中-е갢лe̲, :w;
    my $е両-e̲сс = open $ò中𝐝e̲сс-е갢лe̲, :w;
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'note $*IN.get; say $*IN.get');
    $𝐩с갨개.bind-stdin($е両-갢丧);
    $𝐩с갨개.bind-stdout($е両-갨갮中);
    $𝐩с갨개.bind-stderr($е両-e̲сс);
    await $𝐩с갨개.start;
    .close for $е両-갢丧, $е両-갨갮中, $е両-e̲сс;

    is slurp($ò中𝐝갨갮中-е갢лe̲), "This is the second\n",
        'Handle bound to stdout got correct line from bound stdin';
    is slurp($ò中𝐝e̲сс-е갢лe̲), "This is the first line\n",
        'Handle bound to stderr got correct line from bound stdin';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1', :w);
    throws-like { $𝐩с갨개.bind-stdin($*IN) },
        X::Proc::Async::BindOrUse, handle => 'stdin',
        'Cannot both open with :w and call bind-stdin';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $𝐩с갨개.stdout; $𝐩с갨개.bind-stdout($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot get stdout stream and then bind stdout';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $𝐩с갨개.Supply; $𝐩с갨개.bind-stdout($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot get merged stream and then bind stdout';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $𝐩с갨개.bind-stdout($*OUT); $ = $𝐩с갨개.stdout },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot bind-stdout then get stdout stream';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $𝐩с갨개.bind-stdout($*OUT); $ = $𝐩с갨개.Supply },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot bind-stdout then get merged stream';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $𝐩с갨개.stderr; $𝐩с갨개.bind-stderr($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot get stderr stream and then bind stderr';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $𝐩с갨개.Supply; $𝐩с갨개.bind-stderr($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot get merged stream and then bind stderr';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $𝐩с갨개.bind-stderr($*OUT); $ = $𝐩с갨개.stderr },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot bind-stderr then get stderr stream';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $𝐩с갨개.bind-stderr($*OUT); $ = $𝐩с갨개.Supply },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot bind-stderr then get merged stream';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    my $ò中𝐝갨갮中 = $𝐩с갨개.stdout(:bin);
    my $ò中𝐝e̲сс = $𝐩с갨개.stderr(:bin);
    my $e̲ч갢中 = $𝐩с갨개.start;
    ok await($ò中𝐝갨갮中.native-descriptor) > 0, 'Can asynchronously get stdout descriptor (:bin)';
    ok await($ò中𝐝e̲сс.native-descriptor) > 0, 'Can asynchronously get stderr descriptor (:bin)';
    await $e̲ч갢中;
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    my $ò中𝐝갨갮中 = $𝐩с갨개.stdout;
    my $ò中𝐝e̲сс = $𝐩с갨개.stderr;
    my $e̲ч갢中 = $𝐩с갨개.start;
    ok await($ò中𝐝갨갮中.native-descriptor) > 0, 'Can asynchronously get stdout descriptor';
    ok await($ò中𝐝e̲сс.native-descriptor) > 0, 'Can asynchronously get stderr descriptor';
    await $e̲ч갢中;
}

{
    my $𝐩с갨개1 = Proc::Async.new($*EXECUTABLE, '-e', 'say "plumbed together"');
    my $𝐩с갨개2 = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.get.uc.say');
    $𝐩с갨개2.bind-stdin($𝐩с갨개1.stdout);
    react {
        my $갨갮中𝐩갮中 = '';
        whenever $𝐩с갨개2.stdout {
            $갨갮中𝐩갮中 ~= $_;
        }
        whenever Promise.allof($𝐩с갨개1.start, $𝐩с갨개2.start) {
            is $갨갮中𝐩갮中.trim, 'PLUMBED TOGETHER', 'Can chain async processes together (stdout)';
        }
    }
}

{
    my $𝐩с갨개1 = Proc::Async.new($*EXECUTABLE, '-e', 'note "plumbed together err"');
    my $𝐩с갨개2 = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.get.uc.say');
    $𝐩с갨개2.bind-stdin($𝐩с갨개1.stderr);
    react {
        my $갨갮中𝐩갮中 = '';
        whenever $𝐩с갨개2.stdout {
            $갨갮中𝐩갮中 ~= $_;
        }
        whenever Promise.allof($𝐩с갨개1.start, $𝐩с갨개2.start) {
            is $갨갮中𝐩갮中.trim, 'PLUMBED TOGETHER ERR', 'Can chain async processes together (stderr)';
        }
    }
}

# vim: expandtab shiftwidth=4
