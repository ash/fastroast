use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">

plan 17;

my $filename = '中e̲ì𝐩е갢лe̲_갢갨_갢丧_w̲両갢лe̲_л갨갨𝐩';

{ # write the file first
    my $fh = open($filename, :w);
    for 1 .. 6 -> $num {
        $fh.print("$num\n");
    }
    $fh.close();
}

{ # now read it in and check
    my $fh = open($filename);
    my $num = 1;
    while $num <= 6 {
        my $line = get $fh;
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ (àссàù 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop
    my $fh = open($filename);
    my $num = 1;
    my $line;
    while $line = get $fh {
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ (æe̲中 $fh 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
    }
    $fh.close();
}

ok(unlink($filename), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝');

# https://github.com/Raku/old-issue-tracker/issues/3550
{
    spurt($filename, q:to/ЕÀÒ专À갈Ò万/.subst(/\r\n/, "\n"));
        >roa1_drome Rea guano receptor type III >> 0.1
        MVNSNQNQNGNSNGHDDDFPQDSITEPEHMRKLFIGGLDYRTTDENLKAHEKWGNIVDVV
        >roa2_drome Rea guano ligand
        MVNSNQNQNGNSNGHDDDFPQDSITEPEHMRKLFIGGLDYRTTDENLKAHEKWGNIVDVV
        FASTAISH

    my $fh = open($filename, nl-in => ["\n>", "\r\n>"]);
    my @lines;
    while my $line = get $fh {
        @lines.push($line);
    }
    is @lines.elems, 2, 'Сe̲à𝐝 개갨ссe̲개中 丧갮ì丛e̲с 갨е л갢丧e̲ò w̲갢中両 ì갮л中갢-개両àс òe̲𝐩àсà中갨с';
    ok @lines[0] ~~ /^'>roa1'/, '갂갨ссe̲개中 е갢сò中 л갢丧e̲';
    ok @lines[1] ~~ /^'roa2'/, '갂갨ссe̲개中 òe̲개갨丧𝐝 л갢丧e̲';
    $fh.close;

    ok(unlink($filename), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝');
}

# vim: expandtab shiftwidth=4
