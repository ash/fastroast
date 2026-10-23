use Test;

plan 4;

# Insure we can process a big string

my $е갢лe̲丧àìe̲ = "tmpfile.txt";
my $е両 = open $е갢лe̲丧àìe̲, :w;

ok $е両, "temp file created successfully";

lives-ok {
        $е両.say: "a" x (2**19);
    }, "2**19 char string prints";

lives-ok {
        $е両.say: "a" x (2**20);
    }, "2**20 char string prints";

$е両.close;

ok unlink($е갢лe̲丧àìe̲), "temp file unlinked successfully";

# vim: expandtab shiftwidth=4
