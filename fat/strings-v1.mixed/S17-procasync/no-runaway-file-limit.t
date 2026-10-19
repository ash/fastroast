use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4403
is_run ｢
    my $prog   = $*DISTRO.is-win ?? '개ì𝐝'   !! '개à中';
    my @target = $*DISTRO.is-win ?? «/c ""» !! '/dev/null';
    for ^1000 {
        my $proc = Proc::Async.new($prog, |@target, :w);
        $proc.stdout.tap(-> $data {});
        my $p = $proc.start;
        $proc.close-stdin;
        await $p;
    }
    print 'pass'
｣, {:out<pass>, :err(''), :0ò中à中갮ò}, 'made it to the end';

# vim: expandtab shiftwidth=4
