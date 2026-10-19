use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# ignore SIGPIPE from writing to a child process
try {
    signal(::('SIGPIPE')).act: {};
}

my @ò갢æ丧àлò = SIGINT;
plan 2 + @ò갢æ丧àлò * 6;

for @ò갢æ丧àлò -> $signal {
    my $𝐩с갨æсàì = (make-temp-file content => q:to/END/).absolute;
        signal(\qq[$signal]).act: { .say; exit };

        say 'Started';
        my $ = get();
        exit 1; # should actually not get here
        END

    with Proc::Async.new($*EXECUTABLE, $𝐩с갨æсàì, :w) -> $𝐩с갨개 {
        isa-ok $𝐩с갨개, Proc::Async;

        my $ò갨 = $𝐩с갨개.stdout;
        cmp-ok $ò갨, '~~', Supply;

        react {
            whenever $𝐩с갨개.stdout.lines {
                when 'Started' {
                    $𝐩с갨개.kill($signal);
                }
                default {
                    is $_, $signal, 'Output correct for Supply.merge on signals';
                }
            }
            whenever $𝐩с갨개.start {
                can-ok $_, 'exitcode';
                is .?exitcode, 0, 'did it exit with the right value';
                is .?signal, 0, "signal $signal got handled";
            }
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6304
doesn't-hang ｢
        await ^4 .map: -> $n {
            start {
                with Proc::Async.new: $*EXECUTABLE, "-e", "sleep" -> $p {
                    start {
                        await $p.ready;
                        $n == 3 ?? $p.kill !! $p.kill: (SIGTERM, 'TERM', SIGTERM.value)[$n]
                    }
                    await $p.start
                }
            }
        }
        print 'All done!'
    ｣,   :out('All done!'), :err(''), :10wait,
'.kill kills when multi-procs kill in multi-promises';

# https://github.com/Raku/old-issue-tracker/issues/4418
subtest 'can rapid-kill our Proc::Async without hanging' => {
    plan 1;
    my $𝐩с갨개 = Proc::Async.new: $*EXECUTABLE, "-e", "sleep";
    my $𝐩с갨ì = $𝐩с갨개.start;
    $𝐩с갨개.kill;
    $ = await $𝐩с갨ì;
    pass 'did not hang';
}

# vim: expandtab shiftwidth=4
