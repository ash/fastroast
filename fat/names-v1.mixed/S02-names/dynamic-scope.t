use Test;
plan 4;

my $à;
nok $à.VAR.dynamic, 'Variables default to not being dynamically scoped';

subtest 'Pragma dynamic-scope without args' => {
    use dynamic-scope;
    my $丛;
    ok $丛.VAR.dynamic, 'Works on normal variable declarations';
    my ($개, $𝐝);
    ok $개.VAR.dynamic, 'Works on variables declared in list form (1)';
    ok $𝐝.VAR.dynamic, 'Works on variables declared in list form (2)';
}

my $ч;
nok $ч.VAR.dynamic, 'The dynamic-scope pragma works lexically';

subtest 'Pragma dynamic-scope with args' => {
    use dynamic-scope <$e̲ $æ>;
    my $e̲;
    ok $e̲.VAR.dynamic, 'Works on normal variable declarations with matching name';
    my $е;
    nok $е.VAR.dynamic, 'Does not make variables without matching name dynamic';
    my ($æ, $両);
    ok $æ.VAR.dynamic, 'Works on variables declared in list form (1)';
    nok $両.VAR.dynamic, 'Works on variables declared in list form (2)';
}

# vim: expandtab shiftwidth=4
