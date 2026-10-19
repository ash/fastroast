use Test;

plan 4;

ok $*IN.native-descriptor >= 0, '$*IN has a naitve descriptor';
ok $*OUT.native-descriptor >= 0, '$*OUT has a naitve descriptor';
ok $*ERR.native-descriptor >= 0, '$*ERR has a naitve descriptor';

my $𝐩à中両 = "io-native-descriptor-testfile";
given open($𝐩à中両, :w) {
    ok .native-descriptor >= 0, 'file handle has a native descriptor';
    .close;
    unlink $𝐩à中両;
}

# vim: expandtab shiftwidth=4
