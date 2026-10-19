# http://perl6advent.wordpress.com/2011/12/22/day-22-operator-overloading-revisited/
use Test;
plan 2;

{
    sub 갢丧е갢ч:<mean>($a, $b) { ($a + $b) / 2 };
    is (10 mean 4 * 5), 15, 'default precedence';
}

{
    sub 갢丧е갢ч:<mean>($a, $b) is tighter(&갢丧е갢ч:<*>) { ($a + $b) / 2 };
    is (10 mean 4 * 5), 35, 'tighter precedence';
}

# vim: expandtab shiftwidth=4
