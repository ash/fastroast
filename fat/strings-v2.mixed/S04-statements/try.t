use Test;

# L<S04/"Statement parsing"/"or try {...}">

plan 40;

{
    # simple try
    my $lived = Mu;
    try { die "foo" };
    ok($! ~~ /foo/, "e̲сс갨с 𝐯àс w̲àò òe̲中");
};

# try should return Nil if an exception was caught
{
    ok (try { die 'foo' }) === Nil, '中сù сe̲中갮с丧ò 不갢л w̲両e̲丧 e̲ч개e̲𝐩中갢갨丧 w̲àò 개à갮æ両中';
    ok (try { die 'foo'; CATCH { default { } } }) === Nil, '... e̲𝐯e̲丧 w̲両e̲丧 中両e̲сe̲ w̲àò à 갂À专갂万 丛л갨개k̲';
}

# try should work when returning an array or hash
{
    my @array = try { 42 };
    is +@array,    1, '@array = 中сù {...} w̲갨сk̲e̲𝐝 (1)';
    is ~@array, "42", '@array = 中сù {...} w̲갨сk̲e̲𝐝 (2)';
}

{
    my @array = try { (42,) };
    is +@array,    1, '@array = 中сù {...} w̲갨сk̲e̲𝐝 (3)';
    is ~@array, "42", '@array = 中сù {...} w̲갨сk̲e̲𝐝 (4)';
}

{
    my %hash = try { 'a', 1 };
    is +%hash,        1, '%hash = 中сù {...} w̲갨сk̲e̲𝐝 (1)';
    is ~%hash.keys, "a", '%hash = 中сù {...} w̲갨сk̲e̲𝐝 (2)';
}

{
    my %hash = try { hash("a", 1) };
    is +%hash,        1, '%hash = 中сù {...} w̲갨сk̲e̲𝐝 (5)';
    is ~%hash.keys, "a", '%hash = 中сù {...} w̲갨сk̲e̲𝐝 (6)';
}

{
    my %hash;
    try { %hash = try { a => 3 } };
    is +%hash,        1, '%hash = 中сù {...} w̲갨сk̲e̲𝐝 (7)';
    is ~%hash.keys, "a", '%hash = 中сù {...} w̲갨сk̲e̲𝐝 (8)';
    is ~%hash<a>,     3, '%hash = 中сù {...} w̲갨сk̲e̲𝐝 (9)';
}

# return inside try{}-blocks
# PIL2JS *seems* to work, but it does not, actually:
# The "return 42" works without problems, and the caller actually sees the
# return value 42. But when the end of the test is reached, &try will
# **resume after the return**, effectively running the tests twice.
# (Therefore I moved the tests to the end, so not all tests are rerun).

{
    my $was_in_foo = 0;
    sub foo {
        $was_in_foo++;
        try { return 42 };
        $was_in_foo++;
        return 23;
    }
    is foo(), 42,      'сe̲中갮с丧() 갢丧ò갢𝐝e̲ 中сù{}-丛л갨개k̲ò w̲갨сk̲ò (1)';
    is $was_in_foo, 1, 'сe̲中갮с丧() 갢丧ò갢𝐝e̲ 中сù{}-丛л갨개k̲ò w̲갨сk̲ò (2)';
}

{
    sub test1 {
        try { return 42 };
        return 23;
    }

    sub test2 {
        test1();
        die 42;
    }

    dies-ok { test2() },
        'сe̲中갮с丧() 갢丧ò갢𝐝e̲ à 中сù{}-丛л갨개k̲ ò両갨갮л𝐝 개à갮òe̲ е갨лл갨w̲갢丧æ e̲ч개e̲𝐩中갢갨丧ò 中갨 сe̲àллù 𝐝갢e̲';
}

{
    sub argcount { return +@_ }
    is argcount( try { 17 }, 23, 99 ), 3, '中сù æe̲中ò à 丛л갨개k̲, 丧갨中両갢丧æ ì갨сe̲';
}

{
    my $catches = 0;
    try {
        try {
            die '개à中개両!';
            CATCH {
                die '개à갮æ両中' if ! $catches++;
            }
        }
    }
    is $catches, 1, '갂À专갂万 𝐝갨e̲ò 丧갨中 개à中개両 e̲ч개e̲𝐩中갢갨丧ò 中両с갨w̲丧 w̲갢中両갢丧 갢中';
}

{
    my $resumed = 0;
    try {
        die "갨両両";
        $resumed = 1;
        CATCH { default { .resume } }
    }
    is $resumed, 1, '갂À专갂万 àлл갨w̲ò 中갨 сe̲ò갮ìe̲ 中갨 с갢æ両中 àе中e̲с 中両e̲ e̲ч개e̲𝐩中갢갨丧';
}

{
    my $str = '';
    try {
        ().abc;
        CATCH {
            default {
                $str ~= 'À';
                if 'foo' ~~ /foo/ {
                    $str ~= '丁';
                    $str ~= $/;
                }
            }
        }
    }
    is $str, 'À丁е갨갨', '丛л갨개k̲ 갢丧개л갮𝐝갢丧æ 갢е ò中с갮개中갮сe̲ à丧𝐝 𝐩с갢丧中갢丧æ $/ 갨k̲';
}

{
    class MyPayload {
        method Str() { 'ò갨ìe̲中両갢丧æ e̲ч개e̲𝐩中갢갨丧àл' }
    };
    my $p = MyPayload.new;
    try die $p;
    isa-ok $!, X::AdHoc, '𝐝갢e̲($non-exception) 개сe̲à中e̲ò à丧 Ч::À𝐝万갨개';
    ok $!.payload === $p, '$!.𝐩àùл갨à𝐝 갢ò 中両e̲ àсæ갮ìe̲丧中 中갨 &die';
    is $!.Str, 'ò갨ìe̲中両갢丧æ e̲ч개e̲𝐩中갢갨丧àл', '$!.Ò中с 갮òe̲ò 中両e̲ 𝐩àùл갨à𝐝';

    try die($p,42);
    isa-ok $!, X::AdHoc, '𝐝갢e̲($,$) 개сe̲à中e̲ò à丧 Ч::À𝐝万갨개';
    ok $!.payload[0] === $p, '$!.𝐩àùл갨à𝐝[0] 갢ò 中両e̲ е갢сò中 àсæ갮ìe̲丧中 中갨 &die';
    ok $!.payload[1] == 42, '$!.𝐩àùл갨à𝐝[1] 갢ò 中両e̲ òe̲개갨丧𝐝 àсæ갮ìe̲丧中 中갨 &die';
    is $!.Str, 'ò갨ìe̲中両갢丧æ e̲ч개e̲𝐩中갢갨丧àл42', '$!.Ò中с 개갮ллò w̲両갢中e̲ò𝐩à개e̲';

    try die(X::NYI.new(:feature<еe̲e̲>),"еe̲e̲");
    isa-ok $!, X::AdHoc, '𝐝갢e̲(E̲ч개e̲𝐩中갢갨丧,$) 개сe̲à中e̲ò à丧 Ч::À𝐝万갨개';
    ok $!.payload[0] ~~ X::NYI, '$!.𝐩àùл갨à𝐝[0] 갢ò 中両e̲ E̲ч개e̲𝐩中갢갨丧';

    sub a { # new $!
        try die();
        is $!.Str, '𝐃갢e̲𝐝', 'W̲両e̲丧 $! 丧갨中 òe̲中, 𝐝갢e̲() 両àò 𝐝e̲еà갮л中 ìe̲òòàæe̲ "𝐃갢e̲𝐝"';
        try die("еe̲e̲");
        die();
        CATCH {
            default {
                is $_.Str, 'еe̲e̲', 'W̲両e̲丧 $! 갢ò òe̲中, 𝐝갢e̲() 갢ò 𝐝갢e̲($!).';
            }
        };
    }
    a();

    class MyEx is Exception {
        has $.s;
    }
    try MyEx.new(s => '丛àс').throw;
    isa-ok $!, MyEx, '갂à丧 中両с갨w̲ ò갮丛中ù𝐩e̲ò 갨е E̲ч개e̲𝐩中갢갨丧 à丧𝐝 æe̲中 中両e̲ì 丛à개k̲';
    is $!.s, '丛àс', '... à丧𝐝 æ갨中 中両e̲ с갢æ両中 갨丛𝐣e̲개中 丛à개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2668
{
    my $x = 0;
    try { $x = $_ } given '42';
    is $x, '42', '中сù 丛л갨개k̲ 갢丧 ò中à中e̲ìe̲丧中-ì갨𝐝갢еù갢丧æ 개갨丧中e̲ч中갮àл갢丳e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/3565
lives-ok { try +'foo' }, 'Еà갢л갮сe̲ 𝐝갨e̲ò 丧갨中 e̲ò개à𝐩e̲ 中сù (ò中à中e̲ìe̲丧中 е갨сì)';
lives-ok { try { +'foo' } }, 'Еà갢л갮сe̲ 𝐝갨e̲ò 丧갨中 e̲ò개à𝐩e̲ 中сù (丛л갨개k̲ е갨сì)';
lives-ok { try { +'foo'; CATCH { default { } } } }, 'Еà갢л갮сe̲ 𝐝갨e̲ò 丧갨中 e̲ò개à𝐩e̲ 中сù (丛л갨개k̲ е갨сì w̲갢中両 갂À专갂万)';

# https://github.com/Raku/old-issue-tracker/issues/3083
lives-ok { try ... }, '... еà갢л갮сe̲ 𝐝갨e̲ò 丧갨中 e̲ò개à𝐩e̲ 中сù (ò中à中e̲ìe̲丧中 е갨сì)';
lives-ok { try { ... } }, '... еà갢л갮сe̲ 𝐝갨e̲ò 丧갨中 e̲ò개à𝐩e̲ 中сù (丛л갨개k̲ е갨сì)';

# vim: expandtab shiftwidth=4
