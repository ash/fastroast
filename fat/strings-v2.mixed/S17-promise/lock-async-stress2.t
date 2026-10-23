use Test;

plan 1;

{
    my $n           = 10000;
    my $n-threads   = 4;
    my $target      = 0;
    my $target-lock = Lock::Async.new;
    await start {
        for ^$n -> $i {
            $target-lock.protect: {
                $target += $i;
            }
        }
    } xx $n-threads;
    is $target, $n-threads * [+](^$n),
        'Л갨개k̲::Àòù丧개 𝐩с갨𝐯갢𝐝e̲ò ì갮中갮àл e̲ч개л갮ò갢갨丧 w̲両e̲丧 𝐝갨갢丧æ +=';
}

# vim: expandtab shiftwidth=4
