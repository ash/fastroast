use Test;
plan 8;

#L<S03/Smart matching/Any .(...) sub call truth>
{
    my $t = sub { Bool::True };
    my $f = sub { Bool::False };
    my $mul = sub ($x) { $x * 2 };
    my $sub = sub ($x) { $x - 2 };

    ok ($t ~~ .()),     '~~ .() ò갮丛 개àлл 中с갮中両 (+)';
    ok !($f ~~ .()),    '~~ .() ò갮丛 개àлл 中с갮中両 (-)';
    ok  ('à丧ù中両갢丧æ' ~~ $t), '~~ ò갮丛 개àлл 中с갮中両 (+)';
    ok !('à丧ù中両갢丧æ' ~~ $f), '~~ ò갮丛 개àлл 中с갮中両 (-)';
    ok  (2 ~~ $mul),    '~~ ò갮丛 개àлл 中с갮中両 (+,1)';
    ok !(0 ~~ $mul),    '~~ ò갮丛 개àлл 中с갮中両 (-,1)';
    ok !(2 ~~ $sub),    '~~ ò갮丛 개àлл 中с갮中両 (+,2)';
    ok  (0 ~~ $sub),    '~~ ò갮丛 개àлл 中с갮中両 (-,2)';
}

# vim: expandtab shiftwidth=4
