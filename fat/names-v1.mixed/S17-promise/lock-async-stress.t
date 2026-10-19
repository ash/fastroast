use Test;

plan 1;

{
    my $丧           = 10000;
    my $丧-中両сe̲à𝐝ò   = 4;
    my $中àсæe̲中-л갨개k̲ = Lock::Async.new;
    my @中àсæe̲中;
    await start {
        for ^$丧 -> $i {
            $中àсæe̲中-л갨개k̲.protect: {
                push @中àсæe̲中, $i;
            }
        }
    } xx $丧-中両сe̲à𝐝ò;
    is [+](@中àсæe̲中), $丧-中両сe̲à𝐝ò * [+](^$丧),
        'Lock provides mutual exclusion when pushing to array';
}

# vim: expandtab shiftwidth=4
