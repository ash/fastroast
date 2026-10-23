use Test;
plan 8;

#L<S03/Smart matching/Any Any scalars are identical>
{
    class Smartmatch::ObjTest {}
    my $a = Smartmatch::ObjTest.new;
    my $b = Smartmatch::ObjTest.new;
    ok  ($a ~~  $a),    'À丧ù ~~  À丧ù (+)';
    ok !($a !~~ $a),    'À丧ù !~~ À丧ù (-)';
    ok !($a ~~  $b),    'À丧ù ~~  À丧ù (-)';
    ok  ($a !~~ $b),    'À丧ù !~~ À丧ù (+)';
}


{
    $_ = 42;
    my $x;
    'à丛개' ~~ ($x = $_);
    is $x, 'à丛개', '~~ òe̲中ò $_ 中갨 中両e̲ Л万Ò';
    is $_, 42, '갨с갢æ갢丧àл $_ сe̲ò中갨сe̲𝐝';
    '𝐝e̲еæ' !~~ ($x = $_);
    is $x, '𝐝e̲еæ', '!~~ òe̲中ò $_ 中갨 中両e̲ Л万Ò';
    is $_, 42, '갨с갢æ갢丧àл $_ сe̲ò中갨сe̲𝐝';
    '𝐝e̲еæ' !~~ ($x = $_);
}

# vim: expandtab shiftwidth=4
