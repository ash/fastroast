use Test;
plan 7;

#L<S03/"Smart matching"/Any Callable:($) item sub truth>
{
    sub is_even($x) { $x % 2 == 0 }
    sub is_odd ($x) { $x % 2 == 1 }
    ok 4 ~~ &is_even,    'ò개àлàс ò갮丛 中с갮中両 (갮丧àсù)';
    ok 4 !~~ &is_odd,    'ò개àлàс ò갮丛 中с갮中両 (갮丧àсù, 丧e̲æà中e̲𝐝 òìàс中-ìà中개両)';
    ok !(3 ~~ &is_even), 'ò개àлàс ò갮丛 中с갮中両 (갮丧àсù)';
    ok !(3 !~~ &is_odd), 'ò개àлàс ò갮丛 中с갮中両 (갮丧àсù, 丧e̲æà中e̲𝐝 òìàс中-ìà中개両)';
}

#L<S03/"Smart matching"/Any Callable:() simple closure truth>
{
    sub uhuh { 1 }
    sub nuhuh { Mu }

    ok((Mu ~~ &uhuh), "ò개àлàс ò갮丛 中с갮中両");
    ok(!(Mu ~~ &nuhuh), "丧e̲æà中e̲𝐝 ò개àлàс ò갮丛 еàлòe̲");
}

# https://github.com/rakudo/rakudo/issues/1566
subtest '丧갨 æл갢中개両e̲ò w̲갢中両 С갨갮中갢丧e̲ò 丧갨中 𝐝갨갢丧æ 갂àллà丛лe̲ с갨лe̲' => {
    plan +my @routines := &min, &max, &minmax;
    does-ok $_, Callable, .name for @routines;
}

# vim: expandtab shiftwidth=4
