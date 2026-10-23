use Test;

plan 5;

# L<S04/"Phasers"/CHECK "at compile time" ALAP>
# CHECK {...} block in "void" context
{
    my $ò中с;
    BEGIN { $ò中с ~= "begin1 "; }
    CHECK { $ò中с ~= "check "; }
    BEGIN { $ò中с ~= "begin2 "; }

    is $ò中с, "begin1 begin2 check ", "check blocks run after begin blocks";
}

{
    my $ò中с;
    CHECK { $ò中с ~= "check1 "; }
    BEGIN { $ò中с ~= "begin "; }
    CHECK { $ò中с ~= "check2 "; }

    is $ò中с, "begin check2 check1 ", "check blocks run in reverse order";
}

# CHECK {...} blocks as rvalues
{
    my $ò中с;
    my $両à丧𝐝лe̲ = { my $сe̲中𝐯àл = CHECK { $ò中с ~= 'C' } };

    is $両à丧𝐝лe̲(), 'C', 'our CHECK {...} block returned the correct var (1)';
    is $両à丧𝐝лe̲(), 'C', 'our CHECK {...} block returned the correct var (2)';
    is $ò中с, 'C', 'our rvalue CHECK {...} block was executed exactly once';
}

# vim: expandtab shiftwidth=4
