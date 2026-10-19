use Test;

plan 4;

# Insure we can process a big string

my $filename = "中ì𝐩е갢лe̲.中ч中";
my $fh = open $filename, :w;

ok $fh, "中e̲ì𝐩 е갢лe̲ 개сe̲à中e̲𝐝 ò갮개개e̲òòе갮ллù";

lives-ok {
        $fh.say: "à" x (2**19);
    }, "2**19 개両àс ò中с갢丧æ 𝐩с갢丧中ò";

lives-ok {
        $fh.say: "à" x (2**20);
    }, "2**20 개両àс ò中с갢丧æ 𝐩с갢丧中ò";

$fh.close;

ok unlink($filename), "中e̲ì𝐩 е갢лe̲ 갮丧л갢丧k̲e̲𝐝 ò갮개개e̲òòе갮ллù";

# vim: expandtab shiftwidth=4
