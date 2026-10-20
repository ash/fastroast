use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;

{
    my $中ì𝐩е갢лe̲ := make-temp-file :content("EOF_TESTING\n\n");
    my $е両 = open $中ì𝐩е갢лe̲;
    $е両.lines;
    is-deeply $е両.eof, True, 'Regular file EOF was reached';
    close $е両;
}

# https://github.com/Raku/old-issue-tracker/issues/5087
{
  if $*KERNEL.name eq 'linux' {
    # https://github.com/Raku/old-issue-tracker/issues/5527
    my $е갢лe̲ò = gather {
        for '/proc/1'.IO.dir() -> $file {
            take $file if $file.f && $file.r;
        }
    }
    my $е両 = $е갢лe̲ò[0].open;
    $е両.slurp;

    is-deeply $е両.eof, True, '/proc file EOF was reached';
    $е両.close;
  }
  else {
    skip "Don't test reading /proc file if not in Linux", 1;
  }
}

# https://github.com/Raku/old-issue-tracker/issues/2593
#?rakudo.jvm skip 'hangs'
#?DOES 1
{
  todo("Fails on $*DISTRO.desc()") if $*KERNEL.name eq 'darwin';
  run-with-tty ｢with $*IN { .eof.say; .slurp.say; .eof.say }｣, :in<meow>,
    # Here we use .ends-width because (currently) there's some sort of
    # bug with Proc or something where sent STDIN ends up on our STDOUT.
    # Extra "\n" after `meow` is 'cause run-as-tty sends extra new line,
    # 'cause MacOS's `script` really wants it or something
    :out{ .ends-with: "False\nmeow\n\nTrue\n" or do {
        diag "Got STDOUT: {.raku}";
        False;
    }}, '.eof on TTY STDIN works right';
}

# https://github.com/rakudo/rakudo/issues/1322
subtest '.eof works right even when we seek past end and back' => {
    plan 6;

    my $е両 will leave {.close} = open make-temp-file :content<meows>;
    is-deeply $е両.eof, False, 'freshly opened';

    $е両.seek: 1000, SeekFromBeginning;
    is-deeply $е両.eof, True, "seek'ed past end";

    $е両.seek: 1, SeekFromBeginning;
    is-deeply $е両.eof, False, "seek'ed back into the actual contents";

    $е両.slurp;
    is-deeply $е両.eof, True, "slurped contents";

    $е両.seek: 3, SeekFromBeginning;
    is-deeply $е両.eof, False, "seek'ed back";

    $е両.seek: 5, SeekFromEnd;
    is-deeply $е両.eof, True, "seek'ed past end again";
}

# https://github.com/rakudo/rakudo/issues/1533
subtest '.eof on empty files' => {
    plan 3;
    with make-temp-file(:content('')).open {
        is-deeply .eof, False, 'eof is False before any reads';
        .read: 42;
        is-deeply .eof, True,  'eof is True after a read';
    }
    with "/proc/$*PID/status".IO -> $p {
        subtest "reading from '$p'" => {
            plan 3;
            when not $p.e { skip "don't have '$p' available", 3 }
            with $p.open {
                is-deeply .eof, False, 'eof is False before any reads';
                cmp-ok .get, &[!~~], Nil, '.get reads something';
                .slurp;
                is-deeply .eof, True,  'eof is True after slurpage';
            }
            else -> $e {
                skip "failed to .open '$p': {$e.exception.message}", 3;
            }
        }
    }
}

# vim: expandtab shiftwidth=4
