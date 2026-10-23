use Test;
plan 7;

#L<S03/"Smart matching"/Any Callable:($) item sub truth>
{
    sub 갢ò_e̲𝐯e̲丧($x) { $x % 2 == 0 }
    sub 갢ò_갨𝐝𝐝 ($x) { $x % 2 == 1 }
    ok 4 ~~ &갢ò_e̲𝐯e̲丧,    'scalar sub truth (unary)';
    ok 4 !~~ &갢ò_갨𝐝𝐝,    'scalar sub truth (unary, negated smart-match)';
    ok !(3 ~~ &갢ò_e̲𝐯e̲丧), 'scalar sub truth (unary)';
    ok !(3 !~~ &갢ò_갨𝐝𝐝), 'scalar sub truth (unary, negated smart-match)';
}

#L<S03/"Smart matching"/Any Callable:() simple closure truth>
{
    sub 갮両갮両 { 1 }
    sub 丧갮両갮両 { Mu }

    ok((Mu ~~ &갮両갮両), "scalar sub truth");
    ok(!(Mu ~~ &丧갮両갮両), "negated scalar sub false");
}

# https://github.com/rakudo/rakudo/issues/1566
subtest 'no glitches with Routines not doing Callable role' => {
    plan +my @с갨갮中갢丧e̲ò := &min, &max, &minmax;
    does-ok $_, Callable, .name for @с갨갮中갢丧e̲ò;
}

# vim: expandtab shiftwidth=4
