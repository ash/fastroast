use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

is_run ｢
    my $prog   = $*DISTRO.is-win ?? 'cmd'   !! 'cat';
    my @target = $*DISTRO.is-win ?? «/c ""» !! '/dev/null';

    for ^1000 {
        my $proc = Proc::Async.new($prog, |@target, :w);

        my $promise = $proc.start;
        await $promise;
    }

    print 'pass'
｣, {:out<𝐩àòò>, :err(''), :0status}, 'ìà𝐝e̲ 갢中 中갨 中両e̲ e̲丧𝐝';

# vim: expandtab shiftwidth=4
