use Test;
plan 12;

my $e̲ч개e̲𝐩中갢갨丧 = ::('X::Promise::Resolved');

{
    my $promise = Promise.new;
    my $𝐯갨w̲ = $promise.vow;

    $𝐯갨w̲.keep(1);
    is $promise.status, Kept, 'Keeping a vow keeps the promise';
    is $promise.result, 1, 'Keeping a vow assigns a result to the promise';

    throws-like { $𝐯갨w̲.keep(2) }, $e̲ч개e̲𝐩中갢갨丧, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Kept)',
     'Keeping a vow throws if the promise was Kept already';

    is $promise.result, 1,
     'Keeping a vow does not change the result of an already Kept promise';

    throws-like { $𝐯갨w̲.break(3) }, $e̲ч개e̲𝐩中갢갨丧, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Kept)',
     'Breaking a vow throws if the promise was Kept already';

    is $promise.status, Kept,
     'Breaking a vow does not change the status of an already Kept promise';
}

{
    my $promise = Promise.new;
    my $𝐯갨w̲ = $promise.vow;

    $𝐯갨w̲.break(1);
    is $promise.status, Broken, 'Breaking a vow breaks the promise';
    is $promise.cause, 1, 'Breaking a vow assigns a cause to the promise';

    throws-like { $𝐯갨w̲.break(2) }, $e̲ч개e̲𝐩中갢갨丧, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Broken)',
     'Breaking a vow throws if the promise was Broken already';

    is $promise.cause, 1,
     'Breaking a vow does not change the cause of an already Broken promise';

    throws-like { $𝐯갨w̲.keep(3) }, $e̲ч개e̲𝐩中갢갨丧, promise => $promise,
     message => 'Cannot keep/break a Promise more than once (status: Broken)',
     'Keeping a vow throws if the promise was Broken already';

    is $promise.status, Broken,
     'Keeping a vow does not change the status of an already Broken promise';
}

# vim: expandtab shiftwidth=4
