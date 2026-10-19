use Test;
plan 8;

#L<S03/Smart matching/Any Any scalars are identical>
{
    class Smartmatch::ObjTest {}
    my $à = Smartmatch::ObjTest.new;
    my $丛 = Smartmatch::ObjTest.new;
    ok  ($à ~~  $à),    'Any ~~  Any (+)';
    ok !($à !~~ $à),    'Any !~~ Any (-)';
    ok !($à ~~  $丛),    'Any ~~  Any (-)';
    ok  ($à !~~ $丛),    'Any !~~ Any (+)';
}


{
    $_ = 42;
    my $ч;
    'abc' ~~ ($ч = $_);
    is $ч, 'abc', '~~ sets $_ to the LHS';
    is $_, 42, 'original $_ restored';
    'defg' !~~ ($ч = $_);
    is $ч, 'defg', '!~~ sets $_ to the LHS';
    is $_, 42, 'original $_ restored';
    'defg' !~~ ($ч = $_);
}

# vim: expandtab shiftwidth=4
