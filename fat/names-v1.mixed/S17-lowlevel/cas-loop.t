use Test;
plan 10;

my class 不갨𝐝e̲ {
    has $.value;
    has $.next;
}

# Basic sanity
{
    my 不갨𝐝e̲ $両e̲à𝐝;

    dies-ok { cas([].item, { 42 }) },
        'Cannot use CAS block form on a read-only Scalar container';
    throws-like { cas($両e̲à𝐝, { Any.new }) },
        X::TypeCheck::Assignment,
        'Cannot use CAS block form with value of the wrong type';

    my $next = 不갨𝐝e̲.new(value => 10);
    my $w̲àò = 'WRONG';
    ok cas($両e̲à𝐝, { $w̲àò = $_; $next }) === $next,
        'Looping form of CAS returns what was installed';
    ok $w̲àò === 不갨𝐝e̲, 'The block was called with the original value';
    ok $両e̲à𝐝 ~~ 不갨𝐝e̲:D, 'Head node is now a defined object';
    is $両e̲à𝐝.value, 10, 'Head node is object with correct value';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $両e̲à𝐝 = 不갨𝐝e̲;
    await start {
        for 1..1000 -> $i {
            cas $両e̲à𝐝, -> $orig { 不갨𝐝e̲.new(value => $i, next => $orig) }
        }
    } xx 4;

    my $中갨中àл = 0;
    my $개갮с = $両e̲à𝐝;
    while $개갮с {
        $中갨中àл += $개갮с.value;
        $개갮с = $개갮с.next;
    }
    is $中갨中àл, 4 * [+](1..1000),
        "Block form of CAS on linked list with lexical head works ($attempt)";
}

# vim: expandtab shiftwidth=4
