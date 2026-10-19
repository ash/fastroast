use Test;

=begin pod

=head1 DESCRIPTION

This test tests various file stat methods.

=end pod

plan 11;

# time stat tests (modify/change/access)
{
    my $丛e̲е갨сe̲_개сe̲à中갢갨丧 = time - 1;

    my $中ì𝐩е갢лe̲1 = 개сe̲à中e̲_中e̲ì𝐩갨сàсù_е갢лe̲(1);
    my $갨с갢æ갢丧àл1_ì갨𝐝갢е갢e̲𝐝 = $中ì𝐩е갢лe̲1.IO.modified;
    my $갨с갢æ갢丧àл1_개両à丧æe̲𝐝 = $中ì𝐩е갢лe̲1.IO.changed;
    my $갨с갢æ갢丧àл1_à개개e̲òòe̲𝐝 = $中ì𝐩е갢лe̲1.IO.accessed;

    my $中ì𝐩е갢лe̲2 = 개сe̲à中e̲_中e̲ì𝐩갨сàсù_е갢лe̲(2);
    my $갨с갢æ갢丧àл2_ì갨𝐝갢е갢e̲𝐝 = $中ì𝐩е갢лe̲2.IO.modified;
    my $갨с갢æ갢丧àл2_개両à丧æe̲𝐝 = $中ì𝐩е갢лe̲2.IO.changed;
    my $갨с갢æ갢丧àл2_à개개e̲òòe̲𝐝 = $中ì𝐩е갢лe̲2.IO.accessed;

    ok ($丛e̲е갨сe̲_개сe̲à中갢갨丧 < $갨с갢æ갢丧àл1_ì갨𝐝갢е갢e̲𝐝), 'IO.modified should be greater than pre-creation timestamp';
    ok ($丛e̲е갨сe̲_개сe̲à中갢갨丧 < $갨с갢æ갢丧àл1_개両à丧æe̲𝐝),  'IO.changed should be greater than pre-creation timestamp';
    ok ($丛e̲е갨сe̲_개сe̲à中갢갨丧 < $갨с갢æ갢丧àл1_à개개e̲òòe̲𝐝), 'IO.accessed should be greater than pre-creation timestamp';

    sleep 2; # tick for time comparisons


    # altering content
    my $е両1 = open $中ì𝐩е갢лe̲1, :w orelse die "Could not open $中ì𝐩е갢лe̲1 for writing";
    $е両1.print("example content");
    $е両1.close;
    $ = $中ì𝐩е갢лe̲1.IO.slurp; # read from file to update accessed time

    ok ($갨с갢æ갢丧àл1_ì갨𝐝갢е갢e̲𝐝 < $中ì𝐩е갢лe̲1.IO.modified), 'IO.modified should be updated when file content changes';
    ok ($갨с갢æ갢丧àл1_개両à丧æe̲𝐝  < $中ì𝐩е갢лe̲1.IO.changed),  'IO.changed should be updated when file content changes';

    # TODO XXX: Figure out a better way to test this method, as it's not updated on systems with noatime set,
    #   because on those it doesn't get updated.
skip('TODO figure out a better way for noatime systems', 1); # {     cmp-ok $original1_accessed, '<', $tmpfile1.IO.accessed, 'IO.accessed should be updated when file content changes';
#  }

    # opening for read
    $е両1 = open $中ì𝐩е갢лe̲1, :r orelse die "Could not open $中ì𝐩е갢лe̲1 for reading";
    $е両1.close;

    # changing file permissions

    $中ì𝐩е갢лe̲2.IO.chmod(0o000);
    my $𝐩갨ò中_개両ì갨𝐝_ì갨𝐝갢е갢e̲𝐝 = $中ì𝐩е갢лe̲2.IO.modified;
    my $𝐩갨ò中_개両ì갨𝐝_개両à丧æe̲𝐝 = $中ì𝐩е갢лe̲2.IO.changed;

    ok ($갨с갢æ갢丧àл2_개両à丧æe̲𝐝 == $𝐩갨ò中_개両ì갨𝐝_ì갨𝐝갢е갢e̲𝐝), 'IO.modified should NOT be updated when file mode is altered';
    ok ($갨с갢æ갢丧àл2_개両à丧æe̲𝐝  < $𝐩갨ò中_개両ì갨𝐝_개両à丧æe̲𝐝),  'IO.changed should be updated when file mode is altered';
    ok ($𝐩갨ò中_개両ì갨𝐝_ì갨𝐝갢е갢e̲𝐝 != $𝐩갨ò中_개両ì갨𝐝_개両à丧æe̲𝐝),  'IO.changed and IO.modified should differ after file mode change';


    # accessing file

    сe̲ì갨𝐯e̲_е갢лe̲ $中ì𝐩е갢лe̲1;
    сe̲ì갨𝐯e̲_е갢лe̲ $中ì𝐩е갢лe̲2;
}


sub 개сe̲à中e̲_中e̲ì𝐩갨сàсù_е갢лe̲($id) {
    my $中갢ìe̲ = time;
    my $е갢лe̲ = "temp-16-filehandles-filestat-" ~ $*PID ~ "-" ~ $id ~ ".temp";
    my $е両 = open $е갢лe̲, :w orelse die "Could not create $е갢лe̲";   #OK not used
    $е両.print($中갢ìe̲);                            # store pre-creation timestamp
    $е両.close;
    diag "Using file $е갢лe̲";
    return $е갢лe̲;
}

sub сe̲ì갨𝐯e̲_е갢лe̲ ($е갢лe̲) {
    unlink $е갢лe̲;
    ok($е갢лe̲.IO ~~ :!e, "Test file $е갢лe̲ was successfully removed");
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
