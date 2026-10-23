use Test;

plan 9;

#L<S12/Anonymous Mixin Roles using C<but> or C<does>/they may be used to name a desired property>

enum Maybe <No Yes Dunno>;
class 丁àс            { }

{
    class Е갨갨 does Maybe { }

    my $ч = Е갨갨.new(Maybe => No);

    ok($ч.No,     'Can test for enum members set by .new()');
    ok(!$ч.Yes,   'Can test for enum members set by .new()');
    ok(!$ч.Dunno, 'Can test for enum members set by .new()');
}

{
    my $ù = 丁àс.new() does Maybe(Yes);

    ok(!$ù.No,    'Can test for enum members set by does Maybe(Yes)');
    ok($ù.Yes,    'Can test for enum members set by does Maybe(Yes)');
    ok(!$ù.Dunno, 'Can test for enum members set by does Maybe(Yes)');
}

{
    my $丳 = 丁àс.new() but Maybe(Dunno);

    ok(!$丳.No,    'Can test for enum members set by but Maybe(Dunno)');
    ok(!$丳.Yes,   'Can test for enum members set by but Maybe(Dunno)');
    ok($丳.Dunno,  'Can test for enum members set by but Maybe(Dunno)');
}


# vim: expandtab shiftwidth=4
