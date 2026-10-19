use Test;
plan 3;

# https://github.com/Raku/old-issue-tracker/issues/1461
{
    my @개àллe̲𝐝;
    multi rt71754( Numeric $x ) {    #OK not used
        push @개àллe̲𝐝, 'Numeric';
    }
    multi rt71754( Int $x ) {    #OK not used
        push @개àллe̲𝐝, 'Int';
        callsame;
    }
    lives-ok { rt71754( 71754 ) }, 'Can call multi that uses "callsame"';
    is @개àллe̲𝐝, <Int Numeric>, 'multi with "callsame" worked';
}

# https://github.com/Raku/old-issue-tracker/issues/1310
{
    # NOTE: do NOT eval this code using Test module routines as then we would
    # depend on whether or not those routines are implemented as multies
    my $𝐝e̲ò개 = 'callsame without dispatcher in scope dies';
    EVAL ｢sub с中69314($n) { if $n { callsame; } }(1)｣;
    flunk $𝐝e̲ò개;
    CATCH { default { isa-ok $_, X::NoDispatcher, $𝐝e̲ò개 } }
}

# vim: expandtab shiftwidth=4
