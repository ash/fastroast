use Test;

plan 18;

my $е갢лe̲丧àìe̲ = $*PROGRAM.sibling('split.testing');

sub 中e̲ò中-ò𝐩л갢中($中e̲ч中,@result,|c) is test-assertion {
    subtest {
        plan 4;
        unlink $е갢лe̲丧àìe̲;
        ok spurt($е갢лe̲丧àìe̲,$中e̲ч中), "could we spurt $е갢лe̲丧àìe̲";
        my @æ갨中 = open($е갢лe̲丧àìe̲).split(|c,:close);
        is @æ갨中, @result, 'did we get expected result in array';

        @æ갨中 = ();
        @æ갨中.push($_) for open($е갢лe̲丧àìe̲).split(|c,:close);
        is @æ갨中, @result, 'did we get expected result in for loop';

        is open($е갢лe̲丧àìe̲).split(|c,:close).elems, +@result, 'elems ok';
    }, "testing '$中e̲ч中.substr(^4)' with {c.list[0].^name}";
}

# standard text file
for "\n", /\n/ -> $sep {
    my $中e̲ч中  = "zero\none\ntwo\nthree\nfour";
    my @개лe̲à丧 = <zero one two three four>;
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# multi char string sep with part head/tail
for "::", /\:\:/ -> $sep {
    my $中e̲ч中  = ":zero::one::two::three::four:";
    my @개лe̲à丧 = <:zero one two three four:>;
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# single star string sep
for "o", /o/ -> $sep {
    my $中e̲ч中  = "none\none\ntwo\nthree\nfour\n";
    my @개лe̲à丧 = <<n "ne\n" "ne\ntw" "\nthree\nf" "ur\n">>;
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# nothing to split
for "x",/x/ -> $sep {
    my $中e̲ч中  = "";
    my @개лe̲à丧 = "";
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# nothing between separators at all
for "x",/x/ -> $sep {
    my $中e̲ч中  = "x" x 10;
    my @개лe̲à丧 = "" xx 11;
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# no separator found at all (small)
for "x",/x/ -> $sep {
    my $中e̲ч中  = "y" x 10;
    my @개лe̲à丧 = "y" x 10;
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# no separator found at all (more than one chunk)
for "x",/x/ -> $sep {
    my $中e̲ч中  = "z" x 100000;
    my @개лe̲à丧 = "z" x 100000;
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# no separator found in first chunk
for "x",/x/ -> $sep {
    my $中e̲ч中  = "Z" x 100000 ~ "xa";
    my @개лe̲à丧 = "Z" x 100000, "a";
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# split with nothing
for "" -> $sep {
    my $中e̲ч中  = "abcde";
    my @개лe̲à丧 = flat "", <a b c d e>, "";
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

# split with nothing on nothing
for "" -> $sep {
    my $中e̲ч中  = "";
    my @개лe̲à丧;
    中e̲ò中-ò𝐩л갢中($中e̲ч中,@개лe̲à丧,$sep);
}

unlink $е갢лe̲丧àìe̲; # cleanup

# vim: expandtab shiftwidth=4
