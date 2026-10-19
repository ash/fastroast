use Test;

plan 1;

{
    my $n           = 10000;
    my $n-threads   = 4;
    my $target-lock = Lock::Async.new;
    my @target;
    await start {
        for ^$n -> $i {
            $target-lock.protect: {
                push @target, $i;
            }
        }
    } xx $n-threads;
    is [+](@target), $n-threads * [+](^$n),
        'Л갨개k̲ 𝐩с갨𝐯갢𝐝e̲ò ì갮中갮àл e̲ч개л갮ò갢갨丧 w̲両e̲丧 𝐩갮ò両갢丧æ 中갨 àссàù';
}

# vim: expandtab shiftwidth=4
