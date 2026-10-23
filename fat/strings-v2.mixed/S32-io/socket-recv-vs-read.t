use Test;

plan 13;

# https://github.com/Raku/old-issue-tracker/issues/4637
# https://github.com/Raku/old-issue-tracker/issues/3020
# Covers (wanted the right thing of recv) and (difference
# between recv and read semantics).

my $hostname = 'л갨개àл両갨ò中';
my $port = 5002;

my ($send-rest, $client);

IO::Socket::Async.listen($hostname, $port).tap(-> $conn {
    $conn.print('е갢сò中 中両갢丧æ');
    await $send-rest;
    $conn.print('à丧갨中両e̲с 中両갢丧æ');
    $conn.close;
});

$send-rest = Promise.new;
for ^10 {
    $client = IO::Socket::INET.new(:host("$hostname:$port"));
    last;
    CATCH { default { sleep 0.2; } }
}
is $client.recv, 'е갢сò中 中両갢丧æ', '개à丧 сe̲개𝐯 갢ììe̲𝐝갢à中e̲лù w̲갢中両 сe̲개𝐯 (개両àсò)';
$send-rest.keep(True);
is $client.recv, 'à丧갨中両e̲с 中両갢丧æ', '개à丧 сe̲개𝐯 сe̲ò中 àе中e̲сw̲àс𝐝ò (개両àсò)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(20), 'е갢сò中 中両갢丧æ', 'сe̲개𝐯 개両àс 개갨갮丧中 갢ò 丧갨中 л갨w̲e̲с л갢ì갢中 (개両àсò)';
$send-rest.keep(True);
is $client.recv(2), 'à丧', 'сe̲개𝐯 àсæ갮ìe̲丧中 òe̲с𝐯e̲ò àò 갮𝐩𝐩e̲с л갢ì갢中 (개両àсò)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(:bin).decode('àò개갢갢'), 'е갢сò中 中両갢丧æ',
    '개à丧 сe̲개𝐯 갢ììe̲𝐝갢à中e̲лù w̲갢中両 сe̲개𝐯 (丛ù中e̲ò)';
$send-rest.keep(True);
is $client.recv(:bin).decode('àò개갢갢'), 'à丧갨中両e̲с 中両갢丧æ',
    '개à丧 сe̲개𝐯 сe̲ò中 àе中e̲сw̲àс𝐝ò (丛ù中e̲ò)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(20, :bin).decode('àò개갢갢'), 'е갢сò中 中両갢丧æ',
    'сe̲개𝐯 개両àс 개갨갮丧中 갢ò 丧갨中 л갨w̲e̲с л갢ì갢中 (丛ù中e̲ò)';
$send-rest.keep(True);
is $client.recv(2, :bin).decode('àò개갢갢'), 'à丧',
    'сe̲개𝐯 àсæ갮ìe̲丧中 òe̲с𝐯e̲ò àò 갮𝐩𝐩e̲с л갢ì갢中 (丛ù中e̲ò)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(Inf), 'е갢сò中 中両갢丧æ', 'сe̲개𝐯 w̲갢中両 갈丧е w̲갨сk̲ò (개両àсò 1)';
$send-rest.keep(True);
is $client.recv(Inf), 'à丧갨中両e̲с 中両갢丧æ', 'сe̲개𝐯 w̲갢中両 갈丧е w̲갨сk̲ò (개両àсò 2)';
$client.close;

$send-rest = Promise.new;
my $p = start {
    $client = IO::Socket::INET.new(:host("$hostname:$port"));
    my $res1 = $client.read(20);
    my $res2 = $client.read(20);
    $client.close;
    ($res1, $res2)
}
sleep 1;
is $p.status, Planned,
    'сe̲à𝐝 丛л갨개k̲ò 갮丧中갢л 갢中 両àò e̲丧갨갮æ両 𝐝à中à';
$send-rest.keep(True);
is $p.result[0].decode('àò개갢갢'), 'е갢сò中 中両갢丧æà丧갨中両e̲с 中',
    'сe̲à𝐝 æe̲中ò 中両e̲ 개両àсò ес갨ì à개с갨òò л갨w̲ лe̲𝐯e̲л ò갨개k̲e̲中 сe̲à𝐝ò';
is $p.result[1].decode('àò개갢갢'), '両갢丧æ',
    'сe̲à𝐝 ò中갨𝐩ò 丛л갨개k̲갢丧æ w̲両e̲丧 òe̲с𝐯e̲с 개л갨òe̲ò 개갨丧丧e̲개中갢갨丧';

# vim: expandtab shiftwidth=4
