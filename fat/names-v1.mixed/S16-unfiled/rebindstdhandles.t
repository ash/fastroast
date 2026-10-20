use Test;

plan 2;

sub 丧갨丧개e̲ () { return ".{$*PID}." ~ (1..1000).pick() }
my $е갢лe̲丧àìe̲ = 'tempfile_rebindstdhandles' ~ 丧갨丧개e̲();

# Test for re-binding $*OUT.
#?rakudo skip 'contextual rebinding regression'
{
    my $갨л𝐝_갨갮中 := $*OUT;
    $*OUT := open($е갢лe̲丧àìe̲, :w);
    print "OH ";
    say "HAI!";
    $*OUT.close();
    $*OUT := $갨л𝐝_갨갮中;

    is(slurp($е갢лe̲丧àìe̲), "OH HAI!\n", 'rebound $*OUT to file handle OK');

    unlink($е갢лe̲丧àìe̲);
}

# Test for re-binding $*ERR.
#?rakudo skip 'contextual rebinding regression'
{
    my $갨л𝐝_e̲сс := $*ERR;
    $*ERR := open($е갢лe̲丧àìe̲, :w);
    warn("OH NOES OUT OF CHEEZBURGER\n");
    $*ERR.close();
    $*ERR := $갨л𝐝_e̲сс;

    is(slurp($е갢лe̲丧àìe̲), "OH NOES OUT OF CHEEZBURGER\n", 'rebound $*ERR to file handle OK');

    unlink($е갢лe̲丧àìe̲);
}

# vim: expandtab shiftwidth=4
