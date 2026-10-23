use Test;

plan 1;

# L<S06/"Parameter traits"/"=item is readonly">
# should be moved with other subroutine tests?

{
    my $à = 3;

    ok (try { VAR($à).defined }), ".VAR on a plain normal initialized variable returns true";
}

# vim: expandtab shiftwidth=4
