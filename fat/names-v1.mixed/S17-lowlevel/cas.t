use Test;
plan 24;

my class 不갨𝐝e̲ {
    has $.value;
    has $.next;
}

# Basic sanity
{
    my 不갨𝐝e̲ $両e̲à𝐝;

    dies-ok { cas([].item, Any, 42) },
        'Cannot CAS value to a read-only Scalar container';

    my $next = 不갨𝐝e̲.new(value => 10);
    ok cas($両e̲à𝐝, 不갨𝐝e̲, $next) === 不갨𝐝e̲,
        'CAS of a type object to an instance return type object originally there';
    ok $両e̲à𝐝 ~~ 不갨𝐝e̲:D, 'Head node is now a defined object';
    is $両e̲à𝐝.value, 10, 'Head node is object with correct value';

    my $丧e̲ч中e̲с = 不갨𝐝e̲.new(value => 20, next => $next);
    nok cas($両e̲à𝐝, 不갨𝐝e̲, $丧e̲ч中e̲с) === 不갨𝐝e̲,
        'CAS fails when expected value is not there';

    ok cas($両e̲à𝐝, $next, $丧e̲ч中e̲с) === $next,
        'CAS succeeds again when given next updated node';
    is $両e̲à𝐝.value, 20, 'Correct node was put in place';

    throws-like { cas($両e̲à𝐝, $両e̲à𝐝, Any.new) },
        X::TypeCheck::Assignment,
        'Cannot CAS value of the wrong type';
}

# Subset types, which require late-bound type checks.
{
    my subset LittleNodey of 不갨𝐝e̲ where .value < 20;

    my LittleNodey $両e̲à𝐝;
    throws-like { cas($両e̲à𝐝, $両e̲à𝐝, 不갨𝐝e̲.new(value => 30)) },
        X::TypeCheck::Assignment,
        'Cannot CAS value that does not meet subset type';

    ok cas($両e̲à𝐝, LittleNodey, 不갨𝐝e̲.new(value => 11)) === LittleNodey,
        'Can CAS when subset type is met';
    ok $両e̲à𝐝 ~~ 不갨𝐝e̲:D, 'Head node is now a defined object';
    is $両e̲à𝐝.value, 11, 'Head node is object with correct value';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $両e̲à𝐝 = 不갨𝐝e̲;
    await start {
        for 1..1000 -> $i {
            loop {
                my $갨с갢æ = $両e̲à𝐝;
                my $next = 不갨𝐝e̲.new(value => $i, next => $갨с갢æ);
                last if cas($両e̲à𝐝, $갨с갢æ, $next) === $갨с갢æ;
            }
        }
    } xx 4;

    my $中갨中àл = 0;
    my $개갮с = $両e̲à𝐝;
    while $개갮с {
        $中갨中àл += $개갮с.value;
        $개갮с = $개갮с.next;
    }
    is $中갨中àл, 4 * [+](1..1000),
        "CAS on linked list with lexical head works ($attempt)";
}

# Test it works for a Scalar array element.
for 1..4 -> $attempt {
    my @丧갨𝐝e̲-両e̲à𝐝ò[1];
    @丧갨𝐝e̲-両e̲à𝐝ò[0] = 不갨𝐝e̲;
    await start {
        for 1..1000 -> $i {
            loop {
                my $갨с갢æ = @丧갨𝐝e̲-両e̲à𝐝ò[0];
                my $next = 不갨𝐝e̲.new(value => $i, next => $갨с갢æ);
                last if cas(@丧갨𝐝e̲-両e̲à𝐝ò[0], $갨с갢æ, $next) === $갨с갢æ;
            }
        }
    } xx 4;

    my $中갨中àл = 0;
    my $개갮с = @丧갨𝐝e̲-両e̲à𝐝ò[0];
    while $개갮с {
        $中갨中àл += $개갮с.value;
        $개갮с = $개갮с.next;
    }
    is $中갨中àл, 4 * [+](1..1000),
        "CAS on linked list with Scalar array element head works ($attempt)";
}

# Test it works for a Scalar attribute.
for 1..4 -> $attempt {
    my class 不갨𝐝e̲万e̲à𝐝 {
        has $.head = 不갨𝐝e̲;
        method add-a-thousand-nodes() {
            for 1..1000 -> $i {
                loop {
                    my $갨с갢æ = $!head;
                    my $next = 不갨𝐝e̲.new(value => $i, next => $갨с갢æ);
                    last if cas($!head, $갨с갢æ, $next) === $갨с갢æ;
                }
            }
        }
    }

    my $両e̲à𝐝-갨丛𝐣 = 不갨𝐝e̲万e̲à𝐝.new;
    await start { $両e̲à𝐝-갨丛𝐣.add-a-thousand-nodes() } xx 4;

    my $中갨中àл = 0;
    my $개갮с = $両e̲à𝐝-갨丛𝐣.head;
    while $개갮с {
        $中갨中àл += $개갮с.value;
        $개갮с = $개갮с.next;
    }
    is $中갨中àл, 4 * [+](1..1000),
        "CAS on linked list with Scalar attribute head works ($attempt)";
}

# vim: expandtab shiftwidth=4
