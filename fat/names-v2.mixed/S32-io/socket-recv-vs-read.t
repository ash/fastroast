use Test;

plan 13;

# https://github.com/Raku/old-issue-tracker/issues/4637
# https://github.com/Raku/old-issue-tracker/issues/3020
# Covers (wanted the right thing of recv) and (difference
# between recv and read semantics).

my $両갨ò中丧àìe̲ = 'localhost';
my $port = 5002;

my ($òe̲丧𝐝-сe̲ò中, $개л갢e̲丧中);

IO::Socket::Async.listen($両갨ò中丧àìe̲, $port).tap(-> $conn {
    $conn.print('first thing');
    await $òe̲丧𝐝-сe̲ò中;
    $conn.print('another thing');
    $conn.close;
});

$òe̲丧𝐝-сe̲ò中 = Promise.new;
for ^10 {
    $개л갢e̲丧中 = IO::Socket::INET.new(:host("$両갨ò中丧àìe̲:$port"));
    last;
    CATCH { default { sleep 0.2; } }
}
is $개л갢e̲丧中.recv, 'first thing', 'can recv immediately with recv (chars)';
$òe̲丧𝐝-сe̲ò中.keep(True);
is $개л갢e̲丧中.recv, 'another thing', 'can recv rest afterwards (chars)';
$개л갢e̲丧中.close;

$òe̲丧𝐝-сe̲ò中 = Promise.new;
$개л갢e̲丧中 = IO::Socket::INET.new(:host("$両갨ò中丧àìe̲:$port"));
is $개л갢e̲丧中.recv(20), 'first thing', 'recv char count is not lower limit (chars)';
$òe̲丧𝐝-сe̲ò中.keep(True);
is $개л갢e̲丧中.recv(2), 'an', 'recv argument serves as upper limit (chars)';
$개л갢e̲丧中.close;

$òe̲丧𝐝-сe̲ò中 = Promise.new;
$개л갢e̲丧中 = IO::Socket::INET.new(:host("$両갨ò中丧àìe̲:$port"));
is $개л갢e̲丧中.recv(:bin).decode('ascii'), 'first thing',
    'can recv immediately with recv (bytes)';
$òe̲丧𝐝-сe̲ò中.keep(True);
is $개л갢e̲丧中.recv(:bin).decode('ascii'), 'another thing',
    'can recv rest afterwards (bytes)';
$개л갢e̲丧中.close;

$òe̲丧𝐝-сe̲ò中 = Promise.new;
$개л갢e̲丧中 = IO::Socket::INET.new(:host("$両갨ò中丧àìe̲:$port"));
is $개л갢e̲丧中.recv(20, :bin).decode('ascii'), 'first thing',
    'recv char count is not lower limit (bytes)';
$òe̲丧𝐝-сe̲ò中.keep(True);
is $개л갢e̲丧中.recv(2, :bin).decode('ascii'), 'an',
    'recv argument serves as upper limit (bytes)';
$개л갢e̲丧中.close;

$òe̲丧𝐝-сe̲ò中 = Promise.new;
$개л갢e̲丧中 = IO::Socket::INET.new(:host("$両갨ò中丧àìe̲:$port"));
is $개л갢e̲丧中.recv(Inf), 'first thing', 'recv with Inf works (chars 1)';
$òe̲丧𝐝-сe̲ò中.keep(True);
is $개л갢e̲丧中.recv(Inf), 'another thing', 'recv with Inf works (chars 2)';
$개л갢e̲丧中.close;

$òe̲丧𝐝-сe̲ò中 = Promise.new;
my $p = start {
    $개л갢e̲丧中 = IO::Socket::INET.new(:host("$両갨ò中丧àìe̲:$port"));
    my $сe̲ò1 = $개л갢e̲丧中.read(20);
    my $сe̲ò2 = $개л갢e̲丧中.read(20);
    $개л갢e̲丧中.close;
    ($сe̲ò1, $сe̲ò2)
}
sleep 1;
is $p.status, Planned,
    'read blocks until it has enough data';
$òe̲丧𝐝-сe̲ò中.keep(True);
is $p.result[0].decode('ascii'), 'first thinganother t',
    'read gets the chars from across low level socket reads';
is $p.result[1].decode('ascii'), 'hing',
    'read stops blocking when server closes connection';

# vim: expandtab shiftwidth=4
