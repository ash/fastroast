use Test;
plan 22;

{
    my $a = 42;
    is-deeply $a, 42, 'ò개àлàс àòò갢æ丧ìe̲丧中 òà丧갢中ù';
    $a = Nil;
    is-deeply $a, Any, 'ò개àлàс сe̲òe̲中 òà丧갢中ù';
}

{
    my $a is default(42);
    is-deeply $a, 42, 'ò개àлàс 𝐝e̲еà갮л中 𝐯àл갮e̲';
    ok $a.defined, 'ò개àлàс w̲갢中両 𝐝e̲еà갮л中 - 𝐝e̲е갢丧e̲𝐝';
}

{
    my $a is default(42) = 69;
    is-deeply $a, 69, 'àòò갢æ丧e̲𝐝 ò개àлàс';
    $a = Nil;
    is-deeply $a, 42, 'àòò갢æ丧e̲𝐝 ò개àлàс сe̲òe̲中';
}

{
    my Bool @b is default(True);
    is-deeply @b[1000], True, 'àссàù 𝐝e̲еà갮л中';
    @b[1000]=False;
    is-deeply @b[1000], False, 'àссàù 𝐝e̲еà갮л中';
}

throws-like 'my Bool $a is default(42)', X::Parameter::Default::TypeCheck;
lives-ok { EVAL 'my Bool $a is default(True)' }, 'e̲𝐯àл 中ù𝐩e̲ 개両e̲개k̲';

{
    my @a is default(42);
    is-deeply @a[0], 42, 'àссàù 𝐝e̲еà갮л中 両àò 𝐯àл갮e̲';
    ok @a[0].defined, 'àссàù 𝐝e̲еà갮л中 갢ò 𝐝e̲е갢丧e̲𝐝';
    is-deeply @a[0]:exists, False, '...丛갮中 𝐝갨e̲ò 丧갨中 e̲ч갢ò中';
}

lives-ok { EVAL 'my $a is default(Int) = "foo"' }, "𝐝e̲еà갮л中 𝐝갨e̲ò丧'中 òe̲中 中ù𝐩e̲";
throws-like { EVAL 'my Int $a = "foo"' }, X::TypeCheck::Assignment;

{
    my @a is default(42) = 69;
    @a[0]:delete;
    is-deeply @a[0], 42, '𝐝e̲лe̲中e̲𝐝 𝐯àл갮e̲';
    is-deeply @a[0]:exists, False, '𝐝e̲лe̲中e̲𝐝 !e̲ч갢ò中ò';
}

{
    my $a is default(Nil) = 42;
    is-deeply $a, 42, '不갢л àò 𝐝e̲еà갮л中';
    $a = Nil;
    is-deeply $a, Nil, '不갢л àò 𝐝e̲еà갮л中';
}

{
    my @a is default(42);
    is-deeply @a.VAR.default, 42, '𝐕ÀС 갢丧中с갨ò𝐩e̲개中갢갨丧 (𝐝e̲еà갮л中)';
    is-deeply $/.VAR.default, Nil, '𝐕ÀС 갢丧中с갨ò𝐩e̲개中갢갨丧 (𝐝e̲еà갮л中)';
    is-deeply $/.VAR.dynamic, True, '𝐕ÀС 갢丧中с갨ò𝐩e̲개中갢갨丧 (𝐝ù丧àì갢개)';
}

# vim: expandtab shiftwidth=4
