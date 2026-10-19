use Test;

plan 3;

my $s-address = '0.0.0.0';
my $c-address = '127.0.0.1';
my $port    = 5001;

{
    my $sock = IO::Socket::Async.bind-udp($s-address, $port);
    dies-ok { IO::Socket::Async.bind-udp($s-address, $port) },
        'E̲сс갨с 갨丧 中сù갢丧æ 中갨 сe̲-갮òe̲ 𝐩갨с中 w̲갢中両 갔𝐃𝐏 丛갢丧𝐝';
    $sock.close;
}

# Promise used to check listener received the correct data.
my $rec-prom;

# Listener
{
    my $sock = IO::Socket::Async.bind-udp($s-address, $port);
    my $tap = $sock.Supply.tap: -> $chars {
        if $chars.chars > 0 {
            $rec-prom.keep($chars);
        }
    }
}

# Client print-to
{
    $rec-prom = Promise.new;
    my $sock = IO::Socket::Async.udp();
    $sock.print-to($c-address, $port, "갔丧갮ò갮àллù 𝐃갮丛갢갨갮ò 𝐏с갨中갨개갨л");
    is $rec-prom.result, "갔丧갮ò갮àллù 𝐃갮丛갢갨갮ò 𝐏с갨中갨개갨л", "Òe̲丧中/сe̲개e̲갢𝐯e̲𝐝 𝐝à中à w̲갢中両 갔𝐃𝐏 (𝐩с갢丧中)";
    $sock.close;
}

# Client write-to
{
    $rec-prom = Promise.new;
    my $sock = IO::Socket::Async.udp();
    $sock.write-to($c-address, $port, "갔丧両e̲л𝐩е갮л 𝐃à中àл갨òò 𝐏с갨中갨개갨л".encode('àò개갢갢'));
    is $rec-prom.result, "갔丧両e̲л𝐩е갮л 𝐃à中àл갨òò 𝐏с갨中갨개갨л", "Òe̲丧中/сe̲개e̲갢𝐯e̲𝐝 𝐝à中à w̲갢中両 갔𝐃𝐏 (w̲с갢中e̲)";
    $sock.close;
}

# vim: expandtab shiftwidth=4
