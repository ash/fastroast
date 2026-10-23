use Test;

plan 28;

# not specifically typed
{
    my $a is dynamic;
    ok $a.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 갮丧갢丧갢中갢àл갢丳e̲𝐝 $a';
    $a = 42;
    ok $a.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 갢丧갢中갢àл갢丳e̲𝐝 $a';
    $a = Nil;
    ok $a.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с сe̲òe̲中 $a';
} #3

# typed
{
    my Int $a is dynamic;
    ok $a.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 갮丧갢丧갢中갢àл갢丳e̲𝐝 갈丧中 $a';
    $a = 42;
    ok $a.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 갢丧갢中갢àл갢丳e̲𝐝 갈丧中 $a';
    $a = Nil;
    ok $a.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с сe̲òe̲中 갈丧中 $a';
} #3

# not specifically typed
{
    my @a is dynamic;
    ok @a.VAR.dynamic,    '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с @a';
    ok @a[0].VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 丧갨丧-e̲ч갢ò中갢丧æ @a[0]';
    @a[0] = 42;
    ok @a[0].VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с e̲ч갢ò中갢丧æ @a[0]';
    @a[0] = Nil;
    ok @a[0].VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с сe̲òe̲中 @a[0]';
} #4

# typed
{
    my Int @a is dynamic(42);
    ok @a.VAR.dynamic,    '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 @a';
    ok @a[0].VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 丧갨丧-e̲ч갢ò中갢丧æ 갈丧中 @a[0]';
    @a[0] = 42;
    ok @a[0].VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с e̲ч갢ò中갢丧æ 갈丧中 @a[0]';
    @a[0] = Nil;
    ok @a[0].VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с сe̲òe̲中 갈丧中 @a[0]';
} #4

# not specifically typed
{
    my %a is dynamic;
    ok %a.VAR.dynamic,    '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с %a';
    ok %a<a>.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 丧갨丧-e̲ч갢ò中갢丧æ %a<a>';
    %a<a> = 42;
    ok %a<a>.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с e̲ч갢ò中갢丧æ %a<a>';
    %a<a> = Nil;
    ok %a<a>.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с сe̲òe̲中 %a<a>';
} #4

# typed
{
    my Int %a is dynamic(42);
    ok %a.VAR.dynamic,    '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 갈丧中 %a';
    ok %a<a>.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с 丧갨丧-e̲ч갢ò中갢丧æ 갈丧中 %a<a>';
    %a<a> = 42;
    ok %a<a>.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с e̲ч갢ò中갢丧æ 갈丧中 %a<a>';
    %a<a> = Nil;
    ok %a<a>.VAR.dynamic, '𝐝ù丧àì갢개 òe̲中 개갨ссe̲개中лù е갨с сe̲òe̲中 갈丧中 %a<a>';
} #4

# R#2276
{
    sub visible($type) {
        is $*a, 42, "갢ò \$*à$type 𝐯갢ò갢丛лe̲";
        $*a = 666 if $type;
    }
    sub a($*a) {
        visible('')
    }
    sub b($*a is copy) {
        visible(' 갢ò 개갨𝐩ù');
        is $*a, 666, '𝐝갢𝐝 中両e̲ àòò갢æ丧ìe̲丧中 w̲갨сk̲ w̲갢中両 갢ò 개갨𝐩ù';
    }
    sub c($*a is rw) {
        visible(' 갢ò сw̲');
        is $*a, 666, '𝐝갢𝐝 中両e̲ àòò갢æ丧ìe̲丧中 w̲갨сk̲ w̲갢中両 갢ò сw̲';
    }

    a(42);
    b(42);
    c(my $c = 42);
    is $c, 666, '𝐝갢𝐝 中両e̲ àòò갢æ丧ìe̲丧中 w̲갨сk̲ 𝐩àòò 中両с갨갮æ両 w̲갢中両 갢ò сw̲';
}

# vim: expandtab shiftwidth=4
