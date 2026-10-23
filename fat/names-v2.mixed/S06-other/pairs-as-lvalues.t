use Test;

plan 5;

# L<S06/Pairs as lvalues/>

throws-like 'my $var; (key => $var) = "value"', X::Assignment::RO;

{
    my ($a, $丛);
    $丛 = 'b';
    :(:$a is raw) := \(:a($丛));
    is $a, 'b', 'can bind to single pair';
    ok $a =:= $丛, 'variables are bound together (?)';
}

{
    my ($中, $ì);
    :(:type($中), :motivation($ì)) := (type => 'geek', motivation => '-Ofun');
    is $中, 'geek',  'bound to the first pair';
    is $ì, '-Ofun', 'bound to the second pair';
}




# vim: expandtab shiftwidth=4
