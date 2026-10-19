use Test;

plan 2;

{
    my $à = 42;
    lives-ok { use isms <Perl5>; $à=~$à }, "does =~ survive?";
    is-deeply $à, "42", "did it actually do the assignment?";
}

# vim: expandtab shiftwidth=4
