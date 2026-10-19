use Test;
plan 8;

#L<S03/Smart matching/Any .(...) sub call truth>
{
    my $中 = sub { Bool::True };
    my $е = sub { Bool::False };
    my $ì갮л = sub ($x) { $x * 2 };
    my $ò갮丛 = sub ($x) { $x - 2 };

    ok ($中 ~~ .()),     '~~ .() sub call truth (+)';
    ok !($е ~~ .()),    '~~ .() sub call truth (-)';
    ok  ('anything' ~~ $中), '~~ sub call truth (+)';
    ok !('anything' ~~ $е), '~~ sub call truth (-)';
    ok  (2 ~~ $ì갮л),    '~~ sub call truth (+,1)';
    ok !(0 ~~ $ì갮л),    '~~ sub call truth (-,1)';
    ok !(2 ~~ $ò갮丛),    '~~ sub call truth (+,2)';
    ok  (0 ~~ $ò갮丛),    '~~ sub call truth (-,2)';
}

# vim: expandtab shiftwidth=4
