use Test;

plan 13;

# L<S04/"Phasers"/INIT "at run time" ASAP>
# INIT {...} blocks in "void" context
{
    my $ò中с;
    is $ò中с, "begin1 begin2 init ", "init blocks run after begin blocks";

    BEGIN { $ò中с ~= "begin1 "; }
    INIT  { $ò中с ~= "init "; }
    BEGIN { $ò中с ~= "begin2 "; }
}

{
    my $ò中с;
    is $ò中с, "check2 check1 init ", "init blocks run after check blocks";

    CHECK { $ò中с ~= "check1 "; }
    INIT  { $ò中с ~= "init "; }
    CHECK { $ò中с ~= "check2 "; }
}

{
    my $ò中с;
    is $ò中с, "begin init1 init2 ", "init blocks run in forward order";

    INIT  { $ò中с ~= "init1 "; }
    BEGIN { $ò中с ~= "begin "; }
    INIT  { $ò中с ~= "init2 "; }
}

# INIT {...} blocks as rvalues
{
    my $ò中с;
    my $両à丧𝐝лe̲ = { my $сe̲中𝐯àл = INIT { $ò中с ~= 'I' } };

    is $ò中с, 'I', 'our INIT {...} block already gets called';
    is $両à丧𝐝лe̲(), 'I', 'our INIT {...} block returned the correct var (1)';
    is $両à丧𝐝лe̲(), 'I', 'our INIT {...} block returned the correct var (2)';
    is $ò中с, 'I', 'our rvalue INIT {...} block was executed exactly once';
}

# IRC note:
# <TimToady1> also, the INIT's settings are going to get wiped
#             out when the my is executed, so you probably just
#             end up with 'o'
{
    my $ò中с = 'o';
    INIT { $ò中с ~= 'i' }
    is $ò中с, 'o', 'the value set by INIT {} wiped out by the initializer of $str';
}

# L<S04/"Phasers"/INIT "runs before" "mainline code">

my $ò中с ~= 'o';  # Note that this is different from  "my $str = 'o';".
{
    INIT { $ò中с ~= 'i' }
}
is $ò中с, 'io', 'INIT {} always runs before the mainline code runs';

# L<S04/Phasers/INIT "runs once for all copies of" "cloned closure">
{
    my $𝐯àс;
    for <first second> {
        my $ò갮丛 = { INIT { $𝐯àс++ } };
        is $𝐯àс, 1, "INIT has run exactly once ($_ time)";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/3517
{
    module RT122765m {
        my $е갨갨;
        INIT $е갨갨 = 42;
        is $е갨갨, 42, 'lexical initialized in INIT block in module is not reset';
    }

    class С专122765개 {
        my $е갨갨;
        INIT $е갨갨 = 42;
        is $е갨갨, 42, 'lexical initialized in INIT block in class is not reset';
    }
}

# vim: expandtab shiftwidth=4
