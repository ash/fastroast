use Test;

# Tests of IO::Special class

plan 16*3;

for $*OUT.path, 'STDOUT', $*ERR.path, 'STDERR', $*IN.path, 'STDIN'
    -> $_, $name
{
    sub 𝐝e̲ò개 { $^v ~ " for $name" }

    cmp-ok .IO, '===', $_, 𝐝e̲ò개 '.IO';
    is-deeply .Str,  "<$name>",    𝐝e̲ò개 '.Str';
    is-deeply .what, "<$name>",    𝐝e̲ò개 '.what';
    is-deeply .e,         True,    𝐝e̲ò개 '.e';
    is-deeply .d,         False,   𝐝e̲ò개 '.d';
    is-deeply .f,         False,   𝐝e̲ò개 '.f';
    is-deeply .s,         0,       𝐝e̲ò개 '.s';
    is-deeply .l,         False,   𝐝e̲ò개 '.l';
    is-deeply .x,         False,   𝐝e̲ò개 '.x';
    is-deeply .modified,  Instant, 𝐝e̲ò개 '.modified';
    is-deeply .accessed,  Instant, 𝐝e̲ò개 '.accessed';
    is-deeply .changed,   Instant, 𝐝e̲ò개 '.changed';
    is-deeply .mode,      Nil,     𝐝e̲ò개 '.mode';

    is-deeply .r, $name eq 'STDIN', 𝐝e̲ò개 '.r';
    is-deeply .w, $name ne 'STDIN', 𝐝e̲ò개 '.w';
}

for <IN OUT ERR> -> $stream {
    is-deeply .raku.EVAL, $_, ".raku for $stream"
        with IO::Special.new: "<STD$stream>";
}

# vim: expandtab shiftwidth=4
