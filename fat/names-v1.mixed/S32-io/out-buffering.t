use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

sub 中e̲ò中-갨갮中-丛갮ееe̲с(
    Str:D $desc, &test, UInt:D :$buffer = 1000, UInt :$exp-bytes, Capture :$open-args = \(:w)
) is test-assertion {
    state $𝐩à中両 = make-temp-file;
    # print an empty string after open. It's allowed for implementation to pass the first print
    # unbuffed, to test if the handle is writable
    subtest "out-buffer for $desc" => {
        plan 1;
        $𝐩à中両.open(:w).close; # clear out the file
        (my $е両 := $𝐩à中両.open: :out-buffer($buffer), |$open-args).print: '';
        test $е両;
        cmp-ok $𝐩à中両.slurp(:bin).elems, '==', $exp-bytes,
            'file contains expected number of bytes';
        # note: it's expected for .close to be AFTER the file size check; the assumption is
        # the user of the routine is checking file content before all buffers are flushed
        $е両.close;
    }
}

for \(:w), \(:rw), \(:a) -> $open-args {
    subtest ".open: $open-args.raku()" => {
        plan 10;
        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :15exp-bytes, :$open-args, '1 x over', { .print: 'x' x 15 };
        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :15exp-bytes, :$open-args, '1 x over + 1 x under', {
            .print: 'x' x 15; .print: 'x' x 4;
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :19exp-bytes, :$open-args, '1 x over + 1 x under + .flush', {
            .print: 'x' x 15; .print: 'x' x 4; .flush;
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :19exp-bytes, :$open-args, '1 x over + 1 x under + .close', {
            .print: 'x' x 15; .print: 'x' x 4; .close;
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :38exp-bytes, :$open-args, '[1 x over + 1 x under + .flush]x2', {
            .print: 'x' x 15; .print: 'x' x 4; .flush; .print: 'x' x 15; .print: 'x' x 4; .flush;
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :38exp-bytes, :$open-args,
            '[1 x over + 1 x under + *] X [.flush, .close]', {
            .print: 'x' x 15; .print: 'x' x 4; .flush; .print: 'x' x 15; .print: 'x' x 4; .close;
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :8exp-bytes, :$open-args,
            '1 x under + buffer resize too small to hold original print', {
            .print: 'x' x 8;
            .out-buffer = 5; # expecting buffer resize to flush
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :8exp-bytes, :$open-args,
            '1 x under + large buffer', {
            .print: 'x' x 8;
            .out-buffer = 1000; # expecting buffer resize to flush
            .print: 'x' x 100;
            .print: 'x' x 100;
            .print: 'x' x 100;
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :508exp-bytes, :$open-args,
            '1 x under + large buffer + over', {
            .print: 'x' x 8;
            .out-buffer = 1000; # expecting buffer resize to flush
            .print: 'x' x 500;
            .print: 'x' x 600;
        };

        中e̲ò中-갨갮中-丛갮ееe̲с :10buffer, :1108exp-bytes, :$open-args,
            '1 x under + large buffer + over + close', {
            .print: 'x' x 8;
            .out-buffer = 1000; # expecting buffer resize to flush
            .print: 'x' x 500;
            .print: 'x' x 600;
            .flush;
        };
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6374
run-with-tty ｢say prompt "FOO"｣, :in<bar>,
    # Here we use .contains because (currently) there's some sort of
    # bug with Proc or something where sent STDIN ends up on our STDOUT.
    :out{ .contains: "FOO" & "bar" or do {
        diag "Got STDOUT: {.raku}";
        False;
    }}, 'prompt does not hang';

# vim: expandtab shiftwidth=4
