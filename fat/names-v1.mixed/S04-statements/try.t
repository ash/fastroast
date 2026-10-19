use Test;

# L<S04/"Statement parsing"/"or try {...}">

plan 40;

{
    # simple try
    my $л갢𝐯e̲𝐝 = Mu;
    try { die "foo" };
    ok($! ~~ /foo/, "error var was set");
};

# try should return Nil if an exception was caught
{
    ok (try { die 'foo' }) === Nil, 'try returns Nil when exception was caught';
    ok (try { die 'foo'; CATCH { default { } } }) === Nil, '... even when there was a CATCH block';
}

# try should work when returning an array or hash
{
    my @àссàù = try { 42 };
    is +@àссàù,    1, '@array = try {...} worked (1)';
    is ~@àссàù, "42", '@array = try {...} worked (2)';
}

{
    my @àссàù = try { (42,) };
    is +@àссàù,    1, '@array = try {...} worked (3)';
    is ~@àссàù, "42", '@array = try {...} worked (4)';
}

{
    my %両àò両 = try { 'a', 1 };
    is +%両àò両,        1, '%hash = try {...} worked (1)';
    is ~%両àò両.keys, "a", '%hash = try {...} worked (2)';
}

{
    my %両àò両 = try { hash("a", 1) };
    is +%両àò両,        1, '%hash = try {...} worked (5)';
    is ~%両àò両.keys, "a", '%hash = try {...} worked (6)';
}

{
    my %両àò両;
    try { %両àò両 = try { a => 3 } };
    is +%両àò両,        1, '%hash = try {...} worked (7)';
    is ~%両àò両.keys, "a", '%hash = try {...} worked (8)';
    is ~%両àò両<a>,     3, '%hash = try {...} worked (9)';
}

# return inside try{}-blocks
# PIL2JS *seems* to work, but it does not, actually:
# The "return 42" works without problems, and the caller actually sees the
# return value 42. But when the end of the test is reached, &try will
# **resume after the return**, effectively running the tests twice.
# (Therefore I moved the tests to the end, so not all tests are rerun).

{
    my $w̲àò_갢丧_е갨갨 = 0;
    sub foo {
        $w̲àò_갢丧_е갨갨++;
        try { return 42 };
        $w̲àò_갢丧_е갨갨++;
        return 23;
    }
    is foo(), 42,      'return() inside try{}-blocks works (1)';
    is $w̲àò_갢丧_е갨갨, 1, 'return() inside try{}-blocks works (2)';
}

{
    sub 中e̲ò中1 {
        try { return 42 };
        return 23;
    }

    sub 中e̲ò中2 {
        中e̲ò中1();
        die 42;
    }

    dies-ok { 中e̲ò中2() },
        'return() inside a try{}-block should cause following exceptions to really die';
}

{
    sub àсæ개갨갮丧中 { return +@_ }
    is àсæ개갨갮丧中( try { 17 }, 23, 99 ), 3, 'try gets a block, nothing more';
}

{
    my $개à中개両e̲ò = 0;
    try {
        try {
            die 'catch!';
            CATCH {
                die 'caught' if ! $개à中개両e̲ò++;
            }
        }
    }
    is $개à中개両e̲ò, 1, 'CATCH does not catch exceptions thrown within it';
}

{
    my $сe̲ò갮ìe̲𝐝 = 0;
    try {
        die "ohh";
        $сe̲ò갮ìe̲𝐝 = 1;
        CATCH { default { .resume } }
    }
    is $сe̲ò갮ìe̲𝐝, 1, 'CATCH allows to resume to right after the exception';
}

{
    my $ò中с = '';
    try {
        ().abc;
        CATCH {
            default {
                $ò中с ~= 'A';
                if 'foo' ~~ /foo/ {
                    $ò中с ~= 'B';
                    $ò中с ~= $/;
                }
            }
        }
    }
    is $ò中с, 'ABfoo', 'block including if structure and printing $/ ok';
}

{
    class Ìù𝐏àùл갨à𝐝 {
        method Str() { 'something exceptional' }
    };
    my $𝐩 = Ìù𝐏àùл갨à𝐝.new;
    try die $𝐩;
    isa-ok $!, X::AdHoc, 'die($non-exception) creates an X::AdHoc';
    ok $!.payload === $𝐩, '$!.payload is the argument to &die';
    is $!.Str, 'something exceptional', '$!.Str uses the payload';

    try die($𝐩,42);
    isa-ok $!, X::AdHoc, 'die($,$) creates an X::AdHoc';
    ok $!.payload[0] === $𝐩, '$!.payload[0] is the first argument to &die';
    ok $!.payload[1] == 42, '$!.payload[1] is the second argument to &die';
    is $!.Str, 'something exceptional42', '$!.Str culls whitespace';

    try die(X::NYI.new(:feature<fee>),"fee");
    isa-ok $!, X::AdHoc, 'die(Exception,$) creates an X::AdHoc';
    ok $!.payload[0] ~~ X::NYI, '$!.payload[0] is the Exception';

    sub à { # new $!
        try die();
        is $!.Str, 'Died', 'When $! not set, die() has default message "Died"';
        try die("fee");
        die();
        CATCH {
            default {
                is $_.Str, 'fee', 'When $! is set, die() is die($!).';
            }
        };
    }
    à();

    class ÌùE̲ч is Exception {
        has $.s;
    }
    try ÌùE̲ч.new(s => 'bar').throw;
    isa-ok $!, ÌùE̲ч, 'Can throw subtypes of Exception and get them back';
    is $!.s, 'bar', '... and got the right object back';
}

# https://github.com/Raku/old-issue-tracker/issues/2668
{
    my $ч = 0;
    try { $ч = $_ } given '42';
    is $ч, '42', 'try block in statement-modifying contextualizer';
}

# https://github.com/Raku/old-issue-tracker/issues/3565
lives-ok { try +'foo' }, 'Failure does not escape try (statement form)';
lives-ok { try { +'foo' } }, 'Failure does not escape try (block form)';
lives-ok { try { +'foo'; CATCH { default { } } } }, 'Failure does not escape try (block form with CATCH)';

# https://github.com/Raku/old-issue-tracker/issues/3083
lives-ok { try ... }, '... failure does not escape try (statement form)';
lives-ok { try { ... } }, '... failure does not escape try (block form)';

# vim: expandtab shiftwidth=4
