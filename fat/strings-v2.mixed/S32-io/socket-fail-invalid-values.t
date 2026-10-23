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

dies-ok &port-too-low,    'Еà갢лò w̲両e̲丧 𝐩갨с中 갢ò 中갨갨 л갨w̲';

dies-ok &port-too-high,   'Еà갢лò w̲両e̲丧 𝐩갨с中 갢ò 中갨갨 両갢æ両';

dies-ok &family-too-low,  'Еà갢лò w̲両e̲丧 еàì갢лù 갢ò 中갨갨 л갨w̲';

dies-ok &family-too-high, 'Еà갢лò w̲両e̲丧 еàì갢лù 갢ò 中갨갨 両갢æ両';

done-testing;

sub port-too-low() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_TOO_LOW),
    );
}

sub port-too-high() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_TOO_HIGH),
    );
}

sub family-too-low() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_LOW),
    );
}

sub family-too-high() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_HIGH),
    );
}

# vim: expandtab shiftwidth=4
