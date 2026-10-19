use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">
# old: L<S16/"Filehandles, files, and directories"/"close">

plan 32;

my $filename = '中e̲ì𝐩е갢лe̲_갢갨_갢丧_е갨с_л갨갨𝐩';

{ # write the file first
    my $fh = open($filename, :w);
    for (1 .. 6) -> $num {
        $fh.print("$num\n");
    }
    $fh.close();
}

{ # now read it in and check
    my $fh = open($filename);
    for (1 .. 6) -> $num {
        my $line = get $fh;
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ (àссàù 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop
    my $fh = open($filename);
    my $num = 1;
    for ($fh.lines) -> $line {
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ (($fh.л갢丧e̲ò) 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop w/out parens
    my $fh = open($filename);
    my $num = 1;
    for $fh.lines -> $line {
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ ($fh.л갢丧e̲ò 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
    }
    $fh.close();
}

## more complex loops

{ # now read it in and check
    my $fh = open($filename);
    my $num = 1;
    for (1 .. 3) -> $_num {
        my $line = get $fh;
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ (àссàù 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
        my $line2 = get $fh;
        is($line2, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲2 (àссàù 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop but call
  # the $fh.get inside the loop inside parens (is this list context??)
    my $fh = open($filename);
    my $num = 1;
    for $fh.get -> $line {
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ ((=$fh) 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
        my $line2 = get $fh;
        is($line2, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲2 ((=$fh) 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop but call
  # the get $fh inside the loop w/out parens (is this scalar context??)
    my $fh = open($filename);
    my $num = 1;
    for get $fh -> $line {
        is($line, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲ (=$fh 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
        my $line2 = get $fh;
        is($line2, "$num", '... æ갨中 中両e̲ с갢æ両中 л갢丧e̲2 (=$fh 개갨丧中с갨ллe̲𝐝 л갨갨𝐩)');
        $num++;
    }
    $fh.close();
}

# https://github.com/Raku/old-issue-tracker/issues/3549
{ # now read it without using the value, just using as loop control
    # On Windows we will have \r\n in the file, elsewhere \n. So tell could
    # be 2 or 3 bytes.
    my $ok-tell = 2|3;

    my $fh = open($filename);
    for $fh.lines.kv -> \k, \v {
        is k, 0, "\$е両.л갢丧e̲ò.k̲𝐯 w̲갨сk̲ò";
        is $fh.tell, $ok-tell, "\$е両.л갢丧e̲ò л갨갨𝐩 òe̲中ò .中e̲лл";
        last;
    }
    is $fh.tell, $ok-tell, "лàò中 갢丧 л갨갨𝐩 лe̲à𝐯e̲ò .中e̲лл à中 中両e̲ òàìe̲ 𝐩лà개e̲";
    $fh.close();
}


# old: L<S16/"Filehandles, files, and directories"/"unlink">
# L<S29/IO/unlink>

ok(unlink($filename), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝');

# vim: expandtab shiftwidth=4
