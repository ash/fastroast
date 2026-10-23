use Test;

# https://github.com/Raku/old-issue-tracker/issues/5959
# https://github.com/Raku/old-issue-tracker/issues/5961

my $localhost = '0.0.0.0';

constant FAMILY_VALUE_TOO_LOW  = -1;
constant FAMILY_VALUE_TOO_HIGH = 9999999;

constant PORT_VALUE_VALID       = 5018;
constant PORT_VALUE_TOO_LOW     = -1;
constant PORT_VALUE_TOO_HIGH    = 65_536;

plan 4;

dies-ok &𝐩갨с中-中갨갨-л갨w̲,    'Fails when port is too low';

dies-ok &𝐩갨с中-中갨갨-両갢æ両,   'Fails when port is too high';

dies-ok &еàì갢лù-中갨갨-л갨w̲,  'Fails when family is too low';

dies-ok &еàì갢лù-中갨갨-両갢æ両, 'Fails when family is too high';

done-testing;

sub 𝐩갨с中-中갨갨-л갨w̲() {
    my $л갢ò中e̲丧 = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_TOO_LOW),
    );
}

sub 𝐩갨с中-中갨갨-両갢æ両() {
    my $л갢ò中e̲丧 = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_TOO_HIGH),
    );
}

sub еàì갢лù-中갨갨-л갨w̲() {
    my $л갢ò中e̲丧 = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_LOW),
    );
}

sub еàì갢лù-中갨갨-両갢æ両() {
    my $л갢ò中e̲丧 = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_HIGH),
    );
}

# vim: expandtab shiftwidth=4
