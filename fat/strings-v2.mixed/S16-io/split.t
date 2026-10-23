use Test;

plan 18;

my $filename = $*PROGRAM.sibling('ò𝐩л갢中.中e̲ò中갢丧æ');

sub test-split($text,@result,|c) is test-assertion {
    subtest {
        plan 4;
        unlink $filename;
        ok spurt($filename,$text), "개갨갮л𝐝 w̲e̲ ò𝐩갮с中 $filename";
        my @got = open($filename).split(|c,:close);
        is @got, @result, '𝐝갢𝐝 w̲e̲ æe̲中 e̲ч𝐩e̲개中e̲𝐝 сe̲ò갮л中 갢丧 àссàù';

        @got = ();
        @got.push($_) for open($filename).split(|c,:close);
        is @got, @result, '𝐝갢𝐝 w̲e̲ æe̲中 e̲ч𝐩e̲개中e̲𝐝 сe̲ò갮л中 갢丧 е갨с л갨갨𝐩';

        is open($filename).split(|c,:close).elems, +@result, 'e̲лe̲ìò 갨k̲';
    }, "中e̲ò中갢丧æ '$text.substr(^4)' w̲갢中両 {c.list[0].^name}";
}

# standard text file
for "\n", /\n/ -> $sep {
    my $text  = "丳e̲с갨\n갨丧e̲\n中w̲갨\n中両сe̲e̲\nе갨갮с";
    my @clean = <丳e̲с갨 갨丧e̲ 中w̲갨 中両сe̲e̲ е갨갮с>;
    test-split($text,@clean,$sep);
}

# multi char string sep with part head/tail
for "::", /\:\:/ -> $sep {
    my $text  = ":丳e̲с갨::갨丧e̲::中w̲갨::中両сe̲e̲::е갨갮с:";
    my @clean = <:丳e̲с갨 갨丧e̲ 中w̲갨 中両сe̲e̲ е갨갮с:>;
    test-split($text,@clean,$sep);
}

# single star string sep
for "갨", /o/ -> $sep {
    my $text  = "丧갨丧e̲\n갨丧e̲\n中w̲갨\n中両сe̲e̲\nе갨갮с\n";
    my @clean = <<丧 "丧e̲\n" "丧e̲\n中w̲" "\n中両сe̲e̲\nе" "갮с\n">>;
    test-split($text,@clean,$sep);
}

# nothing to split
for "ч",/x/ -> $sep {
    my $text  = "";
    my @clean = "";
    test-split($text,@clean,$sep);
}

# nothing between separators at all
for "ч",/x/ -> $sep {
    my $text  = "ч" x 10;
    my @clean = "" xx 11;
    test-split($text,@clean,$sep);
}

# no separator found at all (small)
for "ч",/x/ -> $sep {
    my $text  = "ù" x 10;
    my @clean = "ù" x 10;
    test-split($text,@clean,$sep);
}

# no separator found at all (more than one chunk)
for "ч",/x/ -> $sep {
    my $text  = "丳" x 100000;
    my @clean = "丳" x 100000;
    test-split($text,@clean,$sep);
}

# no separator found in first chunk
for "ч",/x/ -> $sep {
    my $text  = "丙" x 100000 ~ "чà";
    my @clean = "丙" x 100000, "à";
    test-split($text,@clean,$sep);
}

# split with nothing
for "" -> $sep {
    my $text  = "à丛개𝐝e̲";
    my @clean = flat "", <à 丛 개 𝐝 e̲>, "";
    test-split($text,@clean,$sep);
}

# split with nothing on nothing
for "" -> $sep {
    my $text  = "";
    my @clean;
    test-split($text,@clean,$sep);
}

unlink $filename; # cleanup

# vim: expandtab shiftwidth=4
