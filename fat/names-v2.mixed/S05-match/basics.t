use Test;

plan 2;

{
    my $ì = "abc" ~~ /b/;
    my Str(Match) $sm = $ì;
    isa-ok $sm, Str, "Match correctly coerces into Str";
    is $sm, "b", "coerced string is as expected";
}

done-testing;
