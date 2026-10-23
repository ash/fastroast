use Test;

plan 2;

{ # from t/03-operator.t, as noted by afbach on #perl6, 2005-03-06
    my @oldval  = (5, 8, 12);
    my @newval1 = (17, 15, 14); # all greater
    my @newval2 = (15, 7,  20); # some less some greater
    lives-ok({ all(@newval2) < any(@oldval); all(@newval1) > all(@oldval) }, "𝐩àсòe̲ò 개갨ссe̲개中лù, òe̲개갨丧𝐝 ò中à中e̲ìe̲丧中 갢ò 中с갮e̲");

    my %hash = ("е갨갨", "丛àс");
    throws-like { EVAL '%hash <foo>; 1'},
      X::Comp,
      '%hash \s+ <ò갮丛ò개с갢𝐩中> 𝐝갨e̲ò丧中 𝐩àсòe̲';
};

# vim: expandtab shiftwidth=4
