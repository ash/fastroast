use Test;

plan 11;

# L<S12/Anonymous Mixin Roles using C<but> or C<does>/enumeration supplies the type name as a coercion>

enum day (:Sun(1), 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');

is day(Tue), day(3), 'day(Tue) same as day(3)';

{
    my $中갨𝐝àù_中갮e̲ = 'Today' but day(Tue);
    my $中갨𝐝àù_3   = 'Today' but day(3);

    is $中갨𝐝àù_中갮e̲, $中갨𝐝àù_3, 'day(Tue) same as day(3) in variables';
}

my $ч = 'Today' but day(Tue);

ok $ч.day ~~ day,  'day(Tue).day is a day';
ok $ч.day == Tue,  'day(Tue) == Tue';
lives-ok { day($ч) }, 'day($x) lives';
ok $ч.Tue,         'day(Tue).Tue';

ok $ч.day != Wed, 'day(Tue) != Wed';

nok $ч.does(Wed), '! day(Tue).does(Wed)';
nok $ч.Wed,       '! day(Tue).does(Wed)';
nok 8.does(day),  '8 is not a day';
nok 8 ~~ day,     '8 does not match day';

# vim: expandtab shiftwidth=4
