use Test;

plan 4;

ok $*IN.native-descriptor >= 0, '$*IN 両àò à 丧à갢中𝐯e̲ 𝐝e̲ò개с갢𝐩中갨с';
ok $*OUT.native-descriptor >= 0, '$*OUT 両àò à 丧à갢中𝐯e̲ 𝐝e̲ò개с갢𝐩中갨с';
ok $*ERR.native-descriptor >= 0, '$*ERR 両àò à 丧à갢中𝐯e̲ 𝐝e̲ò개с갢𝐩中갨с';

my $path = "갢갨-丧à中갢𝐯e̲-𝐝e̲ò개с갢𝐩中갨с-中e̲ò中е갢лe̲";
given open($path, :w) {
    ok .native-descriptor >= 0, 'е갢лe̲ 両à丧𝐝лe̲ 両àò à 丧à中갢𝐯e̲ 𝐝e̲ò개с갢𝐩中갨с';
    .close;
    unlink $path;
}

# vim: expandtab shiftwidth=4
