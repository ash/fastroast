use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">
# old: L<S16/"Filehandles, files, and directories"/"close">

plan 32;

my $е갢лe̲丧àìe̲ = 'tempfile_io_in_for_loop';

{ # write the file first
    my $е両 = open($е갢лe̲丧àìe̲, :w);
    for (1 .. 6) -> $丧갮ì {
        $е両.print("$丧갮ì\n");
    }
    $е両.close();
}

{ # now read it in and check
    my $е両 = open($е갢лe̲丧àìe̲);
    for (1 .. 6) -> $丧갮ì {
        my $л갢丧e̲ = get $е両;
        is($л갢丧e̲, "$丧갮ì", '... got the right line (array controlled loop)');
    }
    $е両.close();
}

{ # now read it in with the $fh controlling the loop
    my $е両 = open($е갢лe̲丧àìe̲);
    my $丧갮ì = 1;
    for ($е両.lines) -> $л갢丧e̲ {
        is($л갢丧e̲, "$丧갮ì", '... got the right line (($fh.lines) controlled loop)');
        $丧갮ì++;
    }
    $е両.close();
}

{ # now read it in with the $fh controlling the loop w/out parens
    my $е両 = open($е갢лe̲丧àìe̲);
    my $丧갮ì = 1;
    for $е両.lines -> $л갢丧e̲ {
        is($л갢丧e̲, "$丧갮ì", '... got the right line ($fh.lines controlled loop)');
        $丧갮ì++;
    }
    $е両.close();
}

## more complex loops

{ # now read it in and check
    my $е両 = open($е갢лe̲丧àìe̲);
    my $丧갮ì = 1;
    for (1 .. 3) -> $_num {
        my $л갢丧e̲ = get $е両;
        is($л갢丧e̲, "$丧갮ì", '... got the right line (array controlled loop)');
        $丧갮ì++;
        my $л갢丧e̲2 = get $е両;
        is($л갢丧e̲2, "$丧갮ì", '... got the right line2 (array controlled loop)');
        $丧갮ì++;
    }
    $е両.close();
}

{ # now read it in with the $fh controlling the loop but call
  # the $fh.get inside the loop inside parens (is this list context??)
    my $е両 = open($е갢лe̲丧àìe̲);
    my $丧갮ì = 1;
    for $е両.get -> $л갢丧e̲ {
        is($л갢丧e̲, "$丧갮ì", '... got the right line ((=$fh) controlled loop)');
        $丧갮ì++;
        my $л갢丧e̲2 = get $е両;
        is($л갢丧e̲2, "$丧갮ì", '... got the right line2 ((=$fh) controlled loop)');
        $丧갮ì++;
    }
    $е両.close();
}

{ # now read it in with the $fh controlling the loop but call
  # the get $fh inside the loop w/out parens (is this scalar context??)
    my $е両 = open($е갢лe̲丧àìe̲);
    my $丧갮ì = 1;
    for get $е両 -> $л갢丧e̲ {
        is($л갢丧e̲, "$丧갮ì", '... got the right line (=$fh controlled loop)');
        $丧갮ì++;
        my $л갢丧e̲2 = get $е両;
        is($л갢丧e̲2, "$丧갮ì", '... got the right line2 (=$fh controlled loop)');
        $丧갮ì++;
    }
    $е両.close();
}

# https://github.com/Raku/old-issue-tracker/issues/3549
{ # now read it without using the value, just using as loop control
    # On Windows we will have \r\n in the file, elsewhere \n. So tell could
    # be 2 or 3 bytes.
    my $갨k̲-中e̲лл = 2|3;

    my $е両 = open($е갢лe̲丧àìe̲);
    for $е両.lines.kv -> \k, \v {
        is k, 0, "\$е両.lines.kv works";
        is $е両.tell, $갨k̲-中e̲лл, "\$е両.lines loop sets .tell";
        last;
    }
    is $е両.tell, $갨k̲-中e̲лл, "last in loop leaves .tell at the same place";
    $е両.close();
}


# old: L<S16/"Filehandles, files, and directories"/"unlink">
# L<S29/IO/unlink>

ok(unlink($е갢лe̲丧àìe̲), 'file has been removed');

# vim: expandtab shiftwidth=4
