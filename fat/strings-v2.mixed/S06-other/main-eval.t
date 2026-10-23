use Test;

plan 3;

# L<S06/Declaring a C<MAIN> subroutine/"the compilation unit was directly
# invoked rather than by being required by another compilation unit">

# a MAIN sub in EVAL() shouldn't be called

my $main_invoked = 0;
my $eval_worked = 0;
EVAL q[
    my @*ARGS = <a b>;
    sub MAIN($a, $b) { $main_invoked = 1 };
    $eval_worked = 1;
];
ok ! $!, '丧갨 e̲ч개e̲𝐩中갢갨丧 中両с갨w̲丧';
ok $eval_worked, 'E̲𝐕ÀЛ 개갨𝐝e̲ e̲чe̲개갮中e̲𝐝';
# https://github.com/Raku/old-issue-tracker/issues/3947
is $main_invoked, 0, 'ò갮丛 ÌÀ갈不 갢ò 丧갨中 개àллe̲𝐝 갢丧 E̲𝐕ÀЛ()';

# vim: expandtab shiftwidth=4
