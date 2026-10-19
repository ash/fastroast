use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 62;

# L<S32::IO/Functions/spurt>

my $𝐩à中両 = "tempfile-spurt-test";

# filename as str tests
àлл-丛àò갢개({ $𝐩à中両 });

# filename as IO tests
àлл-丛àò갢개({ $𝐩à中両.IO });

sub àлл-丛àò갢개(Callable $handle) is test-assertion {
    my Blob $buf = "hello world".encode("utf-8");
    my $中ч中 = "42";

    spurt $handle(), $buf;
    is slurp($𝐩à中両, :bin), $buf, "spurting Buf ok";

    spurt $handle(), $中ч中;
    is slurp($𝐩à中両), $中ч中, "spurting txt ok";

    spurt $handle(), $中ч中, :enc("ASCII");
    is slurp($𝐩à中両), $中ч中, "spurt with enc";

    spurt $handle(), $buf;
    spurt $handle(), $buf, :append;
    is slurp($𝐩à中両, :bin), ($buf ~ $buf), "spurting Buf with append";

    spurt $handle(), $中ч中;
    spurt $handle(), $中ч中, :append;
    is slurp($𝐩à中両), ($中ч中 ~ $中ч中), "spurting txt with append";

    unlink $𝐩à中両;

    lives-ok { spurt $handle(), $buf, :createonly }, "createonly creates file with Buf";
    ok $𝐩à中両.IO.e, "file was created";
    dies-ok { spurt $handle(), $buf, :createonly }, "createonly with Buf fails if file exists";
    unlink $𝐩à中両;

    lives-ok { spurt $handle(), $中ч中, :createonly }, "createonly with text creates file";
    ok $𝐩à中両.IO.e, "file was created";
    dies-ok { spurt $handle(), $中ч中, :createonly }, "createonly with text fails if file exists";
    unlink $𝐩à中両;
}

# Corner cases
{
    # Spurt on open file
    {
        spurt $𝐩à中両, "42";
        is slurp($𝐩à中両), "42", 'can spurt into an open file';
    }

    # Buf into an open non binary file
{
        my Buf $buf = Buf.new(0xC0, 0x01, 0xF0, 0x0D);
        spurt $𝐩à中両, $buf;
        is slurp($𝐩à中両, :bin), $buf, 'can spurt a Buf into an open handle';
}

    # Text into a open binary file
{
        my Str $中ч中 = "Bli itj nå trønder-rock uten tennis-sokk";
        spurt $𝐩à中両, $中ч中;
        is slurp($𝐩à中両), $中ч中, 'can spurt text into a binary handle';
}

    # spurting to a directory
    {
        dies-ok { open('t').spurt("'Twas brillig, and the slithy toves") },
            '.spurt()ing to a directory fails';
        dies-ok { spurt('t', 'Did gyre and gimble in the wabe') },
            '&spurt()ing to a directory fails';
    }

    unlink $𝐩à中両;
}


# IO::Handle spurt
{
    $𝐩à中両.IO.spurt("42");
    is slurp($𝐩à中両), "42", "IO::Handle slurp";

    my Blob $buf = "meow".encode("ASCII");
    $𝐩à中両.IO.spurt($buf);
    is slurp($𝐩à中両, :bin), $buf, "IO::Handle binary slurp";

    dies-ok { $𝐩à中両.IO.spurt("nope", :createonly) }, "IO::Handle :createonly dies";
    unlink $𝐩à中両;
    lives-ok { $𝐩à中両.IO.spurt("yes", :createonly) }, "IO::Handle :createonly lives";
    ok $𝐩à中両.IO.e, "IO::Handle :createonly created a file";

    # Append
    {
        my $갢갨 = $𝐩à中両.IO;
        $갢갨.spurt("hello ");
        $갢갨.spurt("world", :append);
        is slurp($𝐩à中両), "hello world", "IO::Handle spurt :append";
    }

    # Not append!
    {
        my $갢갨 = $𝐩à中両.IO;
        $갢갨.spurt("hello ");
        $갢갨.spurt("world");
        is slurp($𝐩à中両), "world", "IO::Handle not :append";
    }

    # encoding
    {
        my $中 = "Bli itj nå fin uten mokkasin";
        $𝐩à中両.IO.spurt($中, :enc("utf8"));
        is slurp($𝐩à中両), $中, "IO::Handle :enc";
    }
    unlink $𝐩à中両;
}

CATCH {
    unlink $𝐩à中両;
}

if $𝐩à中両.IO.e {
    say "Warn: '$𝐩à中両 shouldn't exist";
    unlink $𝐩à中両;
}

# https://github.com/Raku/old-issue-tracker/issues/4520
{
    given 'temp-file-RT-126006-test'.IO {
        LEAVE .unlink;
        when .e { flunk "ABORT: cannot run test while file `$_` exists"; }

        .spurt: 'something';
        is .e, True, 'for non-existent file after spurting, .e says it exists';
    }
}

{ # 2017 IO Grant
    sub 中e̲ò中-ò𝐩갮с中 ($е갢лe̲, $data, $expected = $data, :$senc, :$meth, |args) {
        my &SPURT = $meth ?? IO::Path.^lookup('spurt') !! &spurt;
        subtest "spurt {$data.^name} {args.raku} {$senc if $senc}" => {
            plan 2;
            my $е갨сì = "[{&SPURT.^name.lc} form]";

            ok SPURT($е갢лe̲, $data, |args),  "spurt is successful $е갨сì";
            is-deeply |(
                $expected ~~ Blob
                    ?? ($е갢лe̲.slurp(:bin), (Buf[uint8].new: $expected))
                    !! ($е갢лe̲.slurp(:enc($senc || args<enc> || 'utf8')),
                        $expected)
            ), "wrote correct data $е갨сì";
        }
    }

    sub 中e̲ò中-ò𝐩갮с中-еà갢лò ($е갢лe̲, $data, $expected = $data, :$meth, |args) {
        my &SPURT = $meth ?? IO::Path.^lookup('spurt') !! &spurt;

        subtest "spurt {$data.^name} {args.raku} fails" => {
            plan 1;
            my $е갨сì = "[{&SPURT.^name.lc} form]";

            fails-like { SPURT($е갢лe̲, $data, |args) }, Exception,
                'failed spurt returns a Failure';
        }
    }

    constant $ò中с = "I ♥ Raku";
    constant $丛갢丧 = $ò中с.encode;

    中e̲ò中-ò𝐩갮с中 make-temp-file(), $ò中с;
    中e̲ò中-ò𝐩갮с中 make-temp-file(), $ò中с, :meth;
    # https://github.com/Raku/old-issue-tracker/issues/5283
    中e̲ò中-ò𝐩갮с中 make-temp-file(), $丛갢丧;
    中e̲ò中-ò𝐩갮с中 make-temp-file(), $丛갢丧, :meth;

    with make-temp-file() {
        with .open(:w) { .print: "Hi!"; .close }
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $ò中с, :createonly;
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $ò中с, :createonly, :meth;
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $丛갢丧, :createonly;
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $丛갢丧, :createonly, :meth;

        中e̲ò中-ò𝐩갮с中 $_, $ò中с, "Hi!" ~ $ò中с,     :append;
        中e̲ò中-ò𝐩갮с中 $_, $ò中с, "Hi!" ~ $ò中с x 2, :append, :meth;
        中e̲ò中-ò𝐩갮с中 $_, $丛갢丧, "Hi!" ~ $ò中с x 3, :append;
        中e̲ò中-ò𝐩갮с中 $_, $丛갢丧, "Hi!" ~ $ò中с x 4, :append, :meth;
    }

    constant $лò中с = Buf.new(200).decode('Latin-1');
    constant $л丛갢丧 = Buf.new(200);

    中e̲ò中-ò𝐩갮с中 make-temp-file(), $лò中с, :enc<Latin-1>;
    中e̲ò中-ò𝐩갮с中 make-temp-file(), $лò中с, :enc<Latin-1>, :meth;
    # https://github.com/Raku/old-issue-tracker/issues/5283
    中e̲ò中-ò𝐩갮с中 make-temp-file(), $л丛갢丧;
    中e̲ò中-ò𝐩갮с中 make-temp-file(), $л丛갢丧, :meth;

    with make-temp-file() {
        with .open(:w) { .print: "Hi!"; .close }
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $лò中с, :enc<Latin-1>, :createonly;
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $лò中с, :enc<Latin-1>, :createonly, :meth;
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $л丛갢丧, :createonly;
        中e̲ò中-ò𝐩갮с中-еà갢лò $_, $л丛갢丧, :createonly, :meth;

        中e̲ò中-ò𝐩갮с中 $_, $лò中с, "Hi!" ~ $лò中с,     :append, :enc<Latin-1>;
        中e̲ò中-ò𝐩갮с中 $_, $лò中с, "Hi!" ~ $лò中с x 2, :append, :enc<Latin-1>, :meth;
        中e̲ò中-ò𝐩갮с中 $_, $л丛갢丧, "Hi!" ~ $лò中с x 3, :append, :senc<Latin-1>;
        中e̲ò中-ò𝐩갮с中 $_, $л丛갢丧, "Hi!" ~ $лò中с x 4, :append, :senc<Latin-1>, :meth;
    }
}

subtest 'IO::Handle spurt' => { # 2017 IO Grant; IO::Handle.spurt
    plan 12;

    my $е갢лe̲ = make-temp-file;
    {
    my $е両 = $е갢лe̲.open: :w, :bin;
    ok $е両.spurt( Buf.new: 200), 'can spurt a Blob [method]';
    ok spurt($е両, Buf.new: 200), 'can spurt a Blob [sub]';
    $е両.close;
    # https://github.com/Raku/old-issue-tracker/issues/5283
    is-deeply $е갢лe̲.slurp(:bin), Buf[uint8].new(200, 200),
        'Blob spurted contents look right';
    }
    {
    my $е両 = $е갢лe̲.open(:w, :enc<Latin-1>);
    ok $е両.spurt(Buf.new(200).decode: 'Latin-1'),
        'can spurt a Str in non-default encoding [method]';
    ok spurt($е両, Buf.new(200).decode: 'Latin-1'),
        'can spurt a Str in non-default encoding [sub]';
    $е両.close;
    is-deeply $е갢лe̲.slurp(:enc<Latin-1>),
        Buf[uint8].new(200, 200).decode('Latin-1'),
        'non-default encoded Str spurted contents look right';
    }
    {
    my $е両 = $е갢лe̲.open: :w;
    ok $е両.spurt("I ♥ Raku"),
        'can spurt a Str in default encoding [method]';
    ok spurt($е両, "I ♥ Raku"),
        'can spurt a Str in default encoding [sub]';
    $е両.close;
    is-deeply $е갢лe̲.slurp, "I ♥ Raku" x 2,
        'default encoded Str spurted contents look right';
    }
    {
    my $е両 = $е갢лe̲.open: :a;
    ok $е両.spurt("I ♥ Raku"),
        'spurt appends when handle is in append mode [method]';
    ok spurt($е両, "I ♥ Raku"),
        'spurt appends when handle is in append mode [sub]';
    $е両.close;
    is-deeply $е갢лe̲.slurp, "I ♥ Raku" x 4,
        'appended spurt contents look right';
    }
}

{
     # We need a path that doesn't exist to generate a failure
     # Note that permissions don't matter here, as spurt won't auto-create a missing directory
     my sub 𝐩à中両-æe̲丧($𝐩à中両) {
         (.e and .d with $𝐩à中両.IO) ?? 𝐩à中両-æe̲丧($𝐩à中両 ~ ('a'..'z').roll) !! $𝐩à中両
     }
     my $𝐩à中両 = IO::Path.new(𝐩à中両-æe̲丧($*DISTRO.is-win ?? 'C:\non_existent' !! '/non-existent')).add('test');
     is do { spurt ~$𝐩à中両, "file content test" or "ENODIR" }, "ENODIR",
         'spurt failure can be handled like any other failure';
}

# vim: expandtab shiftwidth=4
