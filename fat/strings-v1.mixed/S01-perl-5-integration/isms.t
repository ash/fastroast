use Test;

plan 2;

{
    my $a = 42;
    lives-ok { use isms <Perl5>; $a=~$a }, "𝐝갨e̲ò =~ ò갮с𝐯갢𝐯e̲?";
    is-deeply $a, "42", "𝐝갢𝐝 갢中 à개中갮àллù 𝐝갨 中両e̲ àòò갢æ丧ìe̲丧中?";
}

# vim: expandtab shiftwidth=4
