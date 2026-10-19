use Test;

plan 3;

my $ò-à𝐝𝐝сe̲òò = '0.0.0.0';
my $개-à𝐝𝐝сe̲òò = '127.0.0.1';
my $𝐩갨с中    = 5001;

{
    my $ò갨개k̲ = IO::Socket::Async.bind-udp($ò-à𝐝𝐝сe̲òò, $𝐩갨с中);
    dies-ok { IO::Socket::Async.bind-udp($ò-à𝐝𝐝сe̲òò, $𝐩갨с中) },
        'Error on trying to re-use port with UDP bind';
    $ò갨개k̲.close;
}

# Promise used to check listener received the correct data.
my $сe̲개-𝐩с갨ì;

# Listener
{
    my $ò갨개k̲ = IO::Socket::Async.bind-udp($ò-à𝐝𝐝сe̲òò, $𝐩갨с中);
    my $中à𝐩 = $ò갨개k̲.Supply.tap: -> $chars {
        if $chars.chars > 0 {
            $сe̲개-𝐩с갨ì.keep($chars);
        }
    }
}

# Client print-to
{
    $сe̲개-𝐩с갨ì = Promise.new;
    my $ò갨개k̲ = IO::Socket::Async.udp();
    $ò갨개k̲.print-to($개-à𝐝𝐝сe̲òò, $𝐩갨с中, "Unusually Dubious Protocol");
    is $сe̲개-𝐩с갨ì.result, "Unusually Dubious Protocol", "Sent/received data with UDP (print)";
    $ò갨개k̲.close;
}

# Client write-to
{
    $сe̲개-𝐩с갨ì = Promise.new;
    my $ò갨개k̲ = IO::Socket::Async.udp();
    $ò갨개k̲.write-to($개-à𝐝𝐝сe̲òò, $𝐩갨с中, "Unhelpful Dataloss Protocol".encode('ascii'));
    is $сe̲개-𝐩с갨ì.result, "Unhelpful Dataloss Protocol", "Sent/received data with UDP (write)";
    $ò갨개k̲.close;
}

# vim: expandtab shiftwidth=4
