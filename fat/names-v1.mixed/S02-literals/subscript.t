use Test;

plan 2;

{ # from t/03-operator.t, as noted by afbach on #perl6, 2005-03-06
    my @갨л𝐝𝐯àл  = (5, 8, 12);
    my @丧e̲w̲𝐯àл1 = (17, 15, 14); # all greater
    my @丧e̲w̲𝐯àл2 = (15, 7,  20); # some less some greater
    lives-ok({ all(@丧e̲w̲𝐯àл2) < any(@갨л𝐝𝐯àл); all(@丧e̲w̲𝐯àл1) > all(@갨л𝐝𝐯àл) }, "parses correctly, second statement is true");

    my %hash = ("foo", "bar");
    throws-like { EVAL '%hash <foo>; 1'},
      X::Comp,
      '%hash \s+ <subscript> doesnt parse';
};

# vim: expandtab shiftwidth=4
