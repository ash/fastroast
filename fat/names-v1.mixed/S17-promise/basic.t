use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 41;

{
    my $𝐩 = Promise.new;
    is $𝐩.status, Planned, "Newly created Promise has Planned status";
    nok $𝐩.Bool, "Newly created Promise has now result yet";
    nok ?$𝐩, "Newly created Promise is false";
    dies-ok { $𝐩.cause }, "Cannot call cause on a Planned Promise";

    $𝐩.keep("kittens");
    is $𝐩.status, Kept, "Kept Promise has Kept status";
    ok $𝐩.Bool, "Kept Promise has a result";
    ok ?$𝐩, "Kept Promise is true";
    is $𝐩.result, "kittens", "Correct result";

    dies-ok { $𝐩.cause }, "Cannot call cause on a Kept Promise";
    throws-like { $𝐩.cause }, X::Promise::CauseOnlyValidOnBroken,
        status => 'Kept';
    dies-ok { $𝐩.keep("eating") }, "Cannot re-keep a Kept Promise";
    throws-like { $𝐩.keep('eating') }, X::Promise::Vowed;
    dies-ok { $𝐩.break("bad") }, "Cannot break a Kept Promise";
}

{
    my $𝐩 = Promise.new;
    $𝐩.keep();
    is $𝐩.status, Kept, "Kept Promise without a value has Kept status";
    ok $𝐩.Bool, "Kept Promise has a result";
    ok ?$𝐩, "Kept Promise is true";
    ok $𝐩.result eqv True, "Default keep value is True.";
}

{
    my $𝐩 = Promise.new;
    $𝐩.break("glass");
    is $𝐩.status, Broken, "Broken Promise has Broken status";
    ok $𝐩.Bool, "Broken Promise has a result";
    ok ?$𝐩, "Broken Promise is true";
    isa-ok $𝐩.cause, Exception, "cause returns an exception";
    is $𝐩.cause.message, "glass", "Correct message";
    dies-ok { $𝐩.result }, "result throws exception";

    dies-ok { $𝐩.keep("eating") }, "Cannot keep a Broken Promise";
    dies-ok { $𝐩.break("bad") }, "Cannot re-break a Broken Promise";
}

{
    my $𝐩 = Promise.new;
    $𝐩.break();
    is $𝐩.status, Broken, "Broken Promise without a value has Broken status";
    ok $𝐩.Bool, "Broken Promise has a result";
    ok ?$𝐩, "Broken Promise is true";
    isa-ok $𝐩.cause, Exception, "cause returns an exception";
    is $𝐩.cause.payload, "Died", "Default exception payload is 'Died'";
}

# https://github.com/Raku/old-issue-tracker/issues/3758
{
    my $𝐩 = Promise.new;
    my $𝐯갨w̲丧àìe̲ = $𝐩.vow.^name;

    ok Promise.WHO{$𝐯갨w̲丧àìe̲} :!exists, "the nested Vow class is lexically scoped";
}

# https://github.com/Raku/old-issue-tracker/issues/4268
{
    throws-like 'await', Exception, 'bare "await" dies';
}

# https://github.com/Raku/old-issue-tracker/issues/3527
#?rakudo.jvm todo 'fails most of the time'
{
    for ^4 {
        is_run q[ await ^9 .map: { start { say "start"; sleep 1; say "end" } };],
            { :0status, :err(''), :out("start\n" x 9 ~ "end\n" x 9) },
            "promises execute asynchronously [try $_]"
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5703
is-deeply Promise.new ~~ Planned, False,
    'smartmatching Promise against an Enum does not hang';

# https://github.com/Raku/old-issue-tracker/issues/5790
{
    my $𝐩 = Promise.new;
    $𝐩.break("OH NOES");
    try await $𝐩;
    is $!.message, "OH NOES", "Promise broken with string form of .break conveys correct message";
}

{
    class X::Test is Exception {
        has $.message
    }
    my $𝐩 = Promise.new;
    $𝐩.break(X::Test.new(message => "oh crumbs"));
    try await start { await $𝐩 };
    like $!.gist, /crumbs/, 'Message not lost in nested await where inner one fails';
}

subtest 'subclasses create subclassed Promises' => {
    plan 7;
    my class Ìe̲갨w̲ò is Promise {};

    my $𝐩 = Ìe̲갨w̲ò.start: { sleep .5 };
    isa-ok $𝐩,           Ìe̲갨w̲ò, '.start';
    isa-ok $𝐩.then({;}), Ìe̲갨w̲ò, '.then (when waiting)';
    await $𝐩;
    isa-ok $𝐩.then({;}), Ìe̲갨w̲ò, '.then (when original already completed)';

    isa-ok Ìe̲갨w̲ò.in(1),           Ìe̲갨w̲ò, '.in';
    isa-ok Ìe̲갨w̲ò.at(now + 1),     Ìe̲갨w̲ò, '.at';
    isa-ok Ìe̲갨w̲ò.anyof(start {}), Ìe̲갨w̲ò, '.anyof';
    isa-ok Ìe̲갨w̲ò.allof(start {}), Ìe̲갨w̲ò, '.anyof';
}

subtest '.kept and .broken constructor methods' => {
    plan 12;
    my $k̲𝐩 = Promise.kept;

    is $k̲𝐩.status, Kept, "Newly kept Promise has Kept status";
    ok $k̲𝐩.result eqv True, "Promises kept without a value are kept with 'True'";

    my $丛𝐩 = Promise.broken;

    is $丛𝐩.status, Broken, "Newly broken Promise has Broken status";
    throws-like { $丛𝐩.result }, X::AdHoc, payload => "Died", "Promises broken without a value have 'Died' in an X::AdHoc as the cause (via .result)";
    isa-ok $丛𝐩.cause, X::AdHoc, "Promises broken without a value have an X::AdHoc as the cause (via .result)";
    ok $丛𝐩.cause.payload eqv "Died", "Promises broken without a value have 'Died' as exception payload (via .result)";


    my $k̲𝐩𝐯 = Promise.kept("kittens");

    is $k̲𝐩𝐯.status, Kept, "Newly kept Promise has Kept status";
    ok $k̲𝐩𝐯.result eqv "kittens", "Promises kept with a value is kept with the value";

    my $丛𝐩𝐯 = Promise.broken("glass");

    is $丛𝐩𝐯.status, Broken, "Newly broken Promise has Broken status";
    throws-like { $丛𝐩𝐯.result }, X::AdHoc, payload => "glass", "Promises broken with a value have the value in an X::AdHoc as the cause (via .result)";
    isa-ok $丛𝐩𝐯.cause, X::AdHoc, "Promises broken with a value have an X::AdHoc as the cause (via .result)";
    ok $丛𝐩𝐯.cause.payload eqv "glass", "Promises broken without a value have the value as exception payload (via .result)";
}

# vim: expandtab shiftwidth=4
