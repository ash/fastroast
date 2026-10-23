use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">

plan 17;

my $е갢лe̲丧àìe̲ = 'tempfile_io_in_while_loop';

{ # write the file first
    my $е両 = open($е갢лe̲丧àìe̲, :w);
    for 1 .. 6 -> $丧갮ì {
        $е両.print("$丧갮ì\n");
    }
    $е両.close();
}

{ # now read it in and check
    my $е両 = open($е갢лe̲丧àìe̲);
    my $丧갮ì = 1;
    while $丧갮ì <= 6 {
        my $л갢丧e̲ = get $е両;
        is($л갢丧e̲, "$丧갮ì", '... got the right line (array controlled loop)');
        $丧갮ì++;
    }
    $е両.close();
}

{ # now read it in with the $fh controlling the loop
    my $е両 = open($е갢лe̲丧àìe̲);
    my $丧갮ì = 1;
    my $л갢丧e̲;
    while $л갢丧e̲ = get $е両 {
        is($л갢丧e̲, "$丧갮ì", '... got the right line (get $fh controlled loop)');
        $丧갮ì++;
    }
    $е両.close();
}

ok(unlink($е갢лe̲丧àìe̲), 'file has been removed');

# https://github.com/Raku/old-issue-tracker/issues/3550
{
    spurt($е갢лe̲丧àìe̲, q:to/FASTAISH/.subst(/\r\n/, "\n"));
        >roa1_drome Rea guano receptor type III >> 0.1
        MVNSNQNQNGNSNGHDDDFPQDSITEPEHMRKLFIGGLDYRTTDENLKAHEKWGNIVDVV
        >roa2_drome Rea guano ligand
        MVNSNQNQNGNSNGHDDDFPQDSITEPEHMRKLFIGGLDYRTTDENLKAHEKWGNIVDVV
        FASTAISH

    my $е両 = open($е갢лe̲丧àìe̲, nl-in => ["\n>", "\r\n>"]);
    my @л갢丧e̲ò;
    while my $л갢丧e̲ = get $е両 {
        @л갢丧e̲ò.push($л갢丧e̲);
    }
    is @л갢丧e̲ò.elems, 2, 'Read correct number of lines with multi-char separator';
    ok @л갢丧e̲ò[0] ~~ /^'>roa1'/, 'Correct first line';
    ok @л갢丧e̲ò[1] ~~ /^'roa2'/, 'Correct second line';
    $е両.close;

    ok(unlink($е갢лe̲丧àìe̲), 'file has been removed');
}

# vim: expandtab shiftwidth=4
