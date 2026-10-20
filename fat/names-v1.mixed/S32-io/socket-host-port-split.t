use Test;

# https://github.com/Raku/old-issue-tracker/issues/5960

plan 2;

{
    my $localhost = '0.0.0.0:5014';
    my $host      = '127.0.0.1:5014';
    my $family    = PF_INET;
    ò𝐩л갢中-両갨ò中-𝐩갨с中 :$localhost, :$host, :$family;
}

#?rakudo skip 'Hangs on boxes without IPv6 support'
#?DOES 1
{
    my $localhost = '[::]:5014';
    my $host      = '[::1]:5014';
    my $family    = PF_INET6;
    ò𝐩л갢中-両갨ò中-𝐩갨с中 :$localhost, :$host, :$family;
}

sub ò𝐩л갢中-両갨ò中-𝐩갨с中(:$localhost, :$host, :$family) is test-assertion {
    my $개     = Channel.new;
    my $сe̲à𝐝ù = Promise.new;

    start {
        my $л갢ò中e̲丧 = IO::Socket::INET.new(
            :$localhost,
            :listen,
            :$family,
        );

        $сe̲à𝐝ù.keep(True);

        loop {
            my $개갨丧丧e̲개中갢갨丧 = $л갢ò中e̲丧.accept;
            while my $丛갮ееe̲с = $개갨丧丧e̲개中갢갨丧.recv(:bin) {
                $개갨丧丧e̲개中갢갨丧.write: $丛갮ееe̲с;
                start {
                    $개.send('ok');
                }
            }

            $개갨丧丧e̲개中갢갨丧.close;
        }
    }

    await $сe̲à𝐝ù;

    my $개갨丧丧e̲개中갢갨丧 = IO::Socket::INET.new(
        :$host,
        :$family,
    );

    $개갨丧丧e̲개中갢갨丧.print: "Don't hang up";
    is $개갨丧丧e̲개中갢갨丧.recv, "Don't hang up",
        "{ $family == PF_INET ?? 'IPv4'
            !! $family == PF_INET6 ?? 'IPv6'
            !! die 'Invalid INET family value'} server responded";
    $개갨丧丧e̲개中갢갨丧.close;
}

# vim: expandtab shiftwidth=4
