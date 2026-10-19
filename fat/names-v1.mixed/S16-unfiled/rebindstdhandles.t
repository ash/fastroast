use Test;

plan 2;

sub 丧갨丧개e̲ () { return ".{$*PID}." ~ (1..1000).pick() }
my $е갢лe̲丧àìe̲ = 'tempfile_rebindstdhandles' ~ 丧갨丧개e̲();

# Test for re-binding $*OUT.
skip('contextual rebinding regression', 1);# {
#     my $old_out := $*OUT;
#     $*OUT := open($filename, :w);
#     print "OH ";
#     say "HAI!";
#     $*OUT.close();
#     $*OUT := $old_out;
# 
#     is(slurp($filename), "OH HAI!\n", 'rebound $*OUT to file handle OK');
# 
#     unlink($filename);
# }

# Test for re-binding $*ERR.
skip('contextual rebinding regression', 1);# {
#     my $old_err := $*ERR;
#     $*ERR := open($filename, :w);
#     warn("OH NOES OUT OF CHEEZBURGER\n");
#     $*ERR.close();
#     $*ERR := $old_err;
# 
#     is(slurp($filename), "OH NOES OUT OF CHEEZBURGER\n", 'rebound $*ERR to file handle OK');
# 
#     unlink($filename);
# }

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
