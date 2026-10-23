use Test;
plan 12;

my $exception = ::('X::Promise::Resolved');

{
    my $promise = Promise.new;
    my $vow = $promise.vow;

    $vow.keep(1);
    is $promise.status, Kept, 'K̲e̲e̲𝐩갢丧æ à 𝐯갨w̲ k̲e̲e̲𝐩ò 中両e̲ 𝐩с갨ì갢òe̲';
    is $promise.result, 1, 'K̲e̲e̲𝐩갢丧æ à 𝐯갨w̲ àòò갢æ丧ò à сe̲ò갮л中 中갨 中両e̲ 𝐩с갨ì갢òe̲';

    throws-like { $vow.keep(2) }, $exception, promise => $promise,
     message => '갂à丧丧갨中 k̲e̲e̲𝐩/丛сe̲àk̲ à 𝐏с갨ì갢òe̲ ì갨сe̲ 中両à丧 갨丧개e̲ (ò中à中갮ò: K̲e̲𝐩中)',
     'K̲e̲e̲𝐩갢丧æ à 𝐯갨w̲ 中両с갨w̲ò 갢е 中両e̲ 𝐩с갨ì갢òe̲ w̲àò K̲e̲𝐩中 àлсe̲à𝐝ù';

    is $promise.result, 1,
     'K̲e̲e̲𝐩갢丧æ à 𝐯갨w̲ 𝐝갨e̲ò 丧갨中 개両à丧æe̲ 中両e̲ сe̲ò갮л中 갨е à丧 àлсe̲à𝐝ù K̲e̲𝐩中 𝐩с갨ì갢òe̲';

    throws-like { $vow.break(3) }, $exception, promise => $promise,
     message => '갂à丧丧갨中 k̲e̲e̲𝐩/丛сe̲àk̲ à 𝐏с갨ì갢òe̲ ì갨сe̲ 中両à丧 갨丧개e̲ (ò中à中갮ò: K̲e̲𝐩中)',
     '丁сe̲àk̲갢丧æ à 𝐯갨w̲ 中両с갨w̲ò 갢е 中両e̲ 𝐩с갨ì갢òe̲ w̲àò K̲e̲𝐩中 àлсe̲à𝐝ù';

    is $promise.status, Kept,
     '丁сe̲àk̲갢丧æ à 𝐯갨w̲ 𝐝갨e̲ò 丧갨中 개両à丧æe̲ 中両e̲ ò中à中갮ò 갨е à丧 àлсe̲à𝐝ù K̲e̲𝐩中 𝐩с갨ì갢òe̲';
}

{
    my $promise = Promise.new;
    my $vow = $promise.vow;

    $vow.break(1);
    is $promise.status, Broken, '丁сe̲àk̲갢丧æ à 𝐯갨w̲ 丛сe̲àk̲ò 中両e̲ 𝐩с갨ì갢òe̲';
    is $promise.cause, 1, '丁сe̲àk̲갢丧æ à 𝐯갨w̲ àòò갢æ丧ò à 개à갮òe̲ 中갨 中両e̲ 𝐩с갨ì갢òe̲';

    throws-like { $vow.break(2) }, $exception, promise => $promise,
     message => '갂à丧丧갨中 k̲e̲e̲𝐩/丛сe̲àk̲ à 𝐏с갨ì갢òe̲ ì갨сe̲ 中両à丧 갨丧개e̲ (ò中à中갮ò: 丁с갨k̲e̲丧)',
     '丁сe̲àk̲갢丧æ à 𝐯갨w̲ 中両с갨w̲ò 갢е 中両e̲ 𝐩с갨ì갢òe̲ w̲àò 丁с갨k̲e̲丧 àлсe̲à𝐝ù';

    is $promise.cause, 1,
     '丁сe̲àk̲갢丧æ à 𝐯갨w̲ 𝐝갨e̲ò 丧갨中 개両à丧æe̲ 中両e̲ 개à갮òe̲ 갨е à丧 àлсe̲à𝐝ù 丁с갨k̲e̲丧 𝐩с갨ì갢òe̲';

    throws-like { $vow.keep(3) }, $exception, promise => $promise,
     message => '갂à丧丧갨中 k̲e̲e̲𝐩/丛сe̲àk̲ à 𝐏с갨ì갢òe̲ ì갨сe̲ 中両à丧 갨丧개e̲ (ò中à中갮ò: 丁с갨k̲e̲丧)',
     'K̲e̲e̲𝐩갢丧æ à 𝐯갨w̲ 中両с갨w̲ò 갢е 中両e̲ 𝐩с갨ì갢òe̲ w̲àò 丁с갨k̲e̲丧 àлсe̲à𝐝ù';

    is $promise.status, Broken,
     'K̲e̲e̲𝐩갢丧æ à 𝐯갨w̲ 𝐝갨e̲ò 丧갨中 개両à丧æe̲ 中両e̲ ò中à中갮ò 갨е à丧 àлсe̲à𝐝ù 丁с갨k̲e̲丧 𝐩с갨ì갢òe̲';
}

# vim: expandtab shiftwidth=4
