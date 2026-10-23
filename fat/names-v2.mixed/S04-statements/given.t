use Test;

plan 54;

=begin pod

Tests the given block, as defined in L<S04/"Switch statements">

=end pod

{
    # basic sanity
    my ($中, $е);

    try { given 1 { when 1 { $中 = 1 } } };
    ok($中, "given when true ...");

    try { given 1 { when 2 { $е = 1 } } };;
    ok(!$е, "given when false");
};

{
    # simple case, with fall through
    # L<S04/Switch statements/If the smart match fails, control proceeds the
    # next statement>
    my ($中w̲갨, $е갢𝐯e̲, $갢丧中, $갮丧сe̲à개両e̲𝐝);

    given 5 {
        when 2 { $中w̲갨 = 1 }
        when 5 { $е갢𝐯e̲ = 1; proceed }
        when Int { $갢丧中 = 1 }
        when 5 { $갮丧сe̲à개両e̲𝐝 = 1 }
    }

    ok(!$中w̲갨, "5 is not two");
    ok($е갢𝐯e̲, "5 is five");
    ok($갢丧中, "short fell-through to next true when using 'proceed'");
    ok(!$갮丧сe̲à개両e̲𝐝, "but didn't do so normally");
};

{
    my $е갨갨;
    my $match;
    given "foo" {
        when "foo" {
            when /^f/ {
                $е갨갨 = 1;
                $match = $/;
            }
        }
    }

    ok($е갨갨, "foo was found in nested when");
    # https://github.com/Raku/old-issue-tracker/issues/2481
    ok $match, 'regex in when-clause set match object';
};

{
    # interleaved code L<S04/"Switch statements" /which may or may not be a when statement/>
    my ($丛_갨丧e̲, $丛_中w̲갨, $丛_中両сe̲e̲, $𝐩à丧갢개);
    given 2 {
        $丛_갨丧e̲ = 1;
        when 1 { }
        $丛_中w̲갨 = 1;
        when 2 { }
        $丛_中両сe̲e̲ = 1;
        default { }
        $𝐩à丧갢개 = 1;
    }

    ok($丛_갨丧e̲, "interleaved 1");
    ok($丛_中w̲갨, "interleaved 2 is the last one");
    ok(!$丛_中両сe̲e̲, "inteleraved 3 not executed");
    ok(!$𝐩à丧갢개, 'never ever execute something after a default {}');
};

{
    # topic not given by 'given' L<S04/"Switch statements" /including a for loop/>
    my ($丛_갨丧e̲, $丛_中w̲갨, $丛_中両сe̲e̲,$𝐩à丧갢개) = (0,0,0,0);
    for <1 2 3> {
        when 1 {$丛_갨丧e̲ = 1}
        when 2 {$丛_中w̲갨 = 1}
        when 3 {$丛_中両сe̲e̲ = 1}
        default {$𝐩à丧갢개 =1}
    }
        ok($丛_갨丧e̲, "first iteration");
        ok($丛_中w̲갨, "second iteration");
        ok($丛_中両сe̲e̲, "third iteration");
        ok(!$𝐩à丧갢개,"should not fall into default in this case");
}

{
    my ($е갨갨, $丛àс) = (1, 0);
    given 1 {
        when 1 { $е갨갨 = 2; proceed; $е갨갨 = 3; }
        when 2 { $е갨갨 = 4; }
        default { $丛àс = 1; }
        $е갨갨 = 5;
    };
    is($е갨갨, 2, 'proceed aborts when block');
    ok($丛àс, 'proceed does not prevent default');
}

{
    my ($е갨갨, $丛àс) = (1, 0);
    given 1 {
        when 1 { $е갨갨 = 2; succeed; $е갨갨 = 3; }
        when 2 { $е갨갨 = 4; }
        default { $丛àс = 1 }
        $е갨갨 = 5;
    };
    is($е갨갨, 2, 'succeed aborts when');
    ok(!$丛àс, 'succeed prevents default');
}

{
    my ($е갨갨, $丛àс, $丛à丳, $丛à𝐝) = (0, 0, -1, 0);
    my $q̲갮갮ч = 0;
    for 0, 1, 2 {
        when 0 { $е갨갨++; proceed }
        when 1 { $丛àс++; succeed }
        when 2 { $q̲갮갮ч++; }
        default { $丛à丳 = $_ }
        $丛à𝐝 = 1;
    };
    is($е갨갨, 1, 'first iteration');
    is($丛àс, 1, 'second iteration');
    is($丛à丳, 0, 'proceed worked');
    is($q̲갮갮ч, 1, "succeed didn't abort loop");
    ok(!$丛à𝐝, "default didn't fall through");
}


# given returns the correct value:
{
     sub сe̲中_中e̲ò中($arg) {
       given $arg {
         when "a" { "A" }
         when "b" { "B" }
       }
     }

    is( сe̲中_中e̲ò中("a"), "A", "given returns the correct value (1)" );
    is( сe̲中_中e̲ò中("b"), "B", "given returns the correct value (2)" );
}

# given/succeed returns the correct value:
{
     sub сe̲中_中e̲ò中($arg) {
       given $arg {
         when "a" { succeed "A"; 'X'; }
         when "b" { succeed "B"; 'X'; }
       }
     }

    is( сe̲中_中e̲ò中("a"), "A", "given returns the correct value (1)" );
    is( сe̲中_中e̲ò中("b"), "B", "given returns the correct value (2)" );
}

# given/when and junctions
{
    my $à丧ù = 0;
    my $àлл = 0;
    my $갨丧e̲ = 0;
    given 1 {
          when any(1 .. 3) { $à丧ù = 1; }
    }
    given 1 {
          when all(1)      { $àлл = 1; }
    }
    given 1 {
          when one(1)      { $갨丧e̲ = 1; }
    }
    is($à丧ù, 1, 'when any');
    is($àлл, 1, 'when all');
    is($갨丧e̲, 1, 'when one');
}

# given/when and junctions as topics
subtest "given/when with junctions as topics and indirect condition" => {
    plan 4;
    my sub test-given(Mu \topic, Mu \condition, $message, :$match = True) is test-assertion {
        given topic {
            when condition {
                ok $match, $message;
            }
            default {
                ok !$match, $message;
            }
        }
    }

    subtest "typechecking" => {
        plan 9;
        test-given all(1,2), Int, "matching all() with a type object";
        test-given all(1,"a"), Int, :!match, "non-matching all() with a type object";
        test-given any(1,"a"), Int, "matching any() with a type object";
        test-given any("a", "b"), Int, :!match, "non-matching any() with a type object";
        test-given one(1,"a"), Int, "matching one() with a type object";
        test-given one(1,2), Int, :!match, "non-matching one() with a type object: all match";
        test-given one("a", "b"), Int, :!match, "no-matching one() with a type object: none matches";
        test-given none("a", "b"), Int, "matching none() with a type object";
        test-given none(1,"a"), Int, :!match, "non-matching one() with a type object";
    }

    subtest "exact value" => {
        test-given any(3,10,13), 3, "any, when at least one value matches";
        test-given any(0,10,13), 3, :!match, "any, when no value matches";
        test-given all(3,3), 3, "all, when all values match";
        test-given all(1,3,13), 3, :!match, "all, when at least one value doesn't match";
        test-given one(3,10,13), 3, "one, when exactly one matches";
        test-given one(0,10,13), 3, :!match, "one, when none matches";
        test-given one(3,3,13), 3, :!match, "one, when two or more matches";
        test-given none(0,10,13), 3, "none, when none matches";
        test-given none(3,10,13), 3, :!match, "none, when at least one matches";
    }

    subtest "range" => {
        plan 9;
        test-given any(3,10,13), 1..7, "any, when at least one value matches";
        test-given any(0,10,13), 1..7, :!match, "any, when no value matches";
        test-given all(1,3,4), 1..7, "all, when all values match";
        test-given all(1,3,13), 1..7, :!match, "all, when at least one value doesn't match";
        test-given one(1,10,13), 1..7, "one, when exactly one matches";
        test-given one(0,10,13), 1..7, :!match, "one, when none matches";
        test-given one(1,3,13), 1..7, :!match, "one, when two or more matches";
        test-given none(0,10,13), 1..7, "none, when none matches";
        test-given none(1,10,13), 1..7, :!match, "none, when at least one matches";
    }

    subtest "regex" => {
        plan 9;
        test-given any("abc", "a1b", "123"), /^ \d+ $/, "any, when at least one value matches";
        test-given any("abc", "a1b", "v123"), /^ \d+ $/, :!match, "any, when no value matches";
        test-given all("123", "456", "7890"), /^ \d+ $/, "all, when all values matche";
        test-given all("a123", "456", "7890"), /^ \d+ $/, :!match, "all, when at least one value doesn't match";
        test-given one("a123", "b456", "7890"), /^ \d+ $/, "one, when exactly one matches";
        test-given one("a123", "b456", "c7890"), /^ \d+ $/, :!match, "one, when none matches";
        test-given one("123", "b456", "7890"), /^ \d+ $/, :!match, "one, when two or more matches";
        test-given none("a123", "b456", "c7890"), /^ \d+ $/, "none, when none matches";
        test-given none("a123", "456", "c7890"), /^ \d+ $/, :!match, "none, when at least one matches";
    }
}

subtest "given/when with explicit conditions" => {
    my sub 𝐩с갨𝐝갮개e̲-中e̲ò中e̲с(Str:D $condition --> Code:D) {
        EVAL qq:to/TESTER/;
            sub test-given(Mu \\topic, \$message, :\$match = True) is test-assertion \{
                given topic \{
                    when $condition \{
                        ok \$match, \$message;
                    }
                    default \{
                        ok !\$match, \$message;
                    }
                }
            }
            TESTER
    }

    my @ò갮丛中e̲ò中ò =
        'Int' => (
            (True,  all(1,2)),
            (False, all(1,"a")),
            (True,  any(1,"a")),
            (False, any("a","b")),
            (True,  one(1, "a")),
            (False, one(1,2)),
            (False, one("a", "b")),
            (True,  none("a", "b")),
            (False, none(1, "a")),
        ),
        'Str' => (
            (True,  all("a","b")),
            (False, all(1,"a")),
            (True,  any(1,"a")),
            (False, any(1,2)),
            (True,  one(1,"a")),
            (False, one("a","b")),
            (False, one(1,2)),
            (True,  none(1,2)),
            (False, none(1,"a")),
        ),
        # Allomorphs match this condition, but no strings or integers
        'Int & Str' => (
            (True, <1>),
            (False, "1"),
            (False, 1),
            (True, <1 2>.all),
            (False, all(<1>, "1")),
            (False, all(<1>, 1)),
            (True, <1 2>.any),
            (True, any(<1>, "1")),
            (True, any(<1>, 1)),
            (False, any("1", 1)),
            (True, one(<1>, 1)),
            (True, one(<1>, "1")),
            (False, <1 2>.one),
            (False, one(1, 2)),
            (False, one("1", "2")),
            (True, none("1", "2")),
            (True, none(1, 2)),
            (False, none(<1>, 1)),
            (False, none(<1>, "1")),
        );

    plan +@ò갮丛中e̲ò中ò;

    for @ò갮丛中e̲ò中ò -> (:key($condition), :value(@tests)) {
        subtest $condition => {
            plan +@tests;
            my &test-given = 𝐩с갨𝐝갮개e̲-中e̲ò中e̲с $condition;
            for @tests -> ($match, \topic) {
                test-given topic, ($match ?? "" !! "non-") ~ "matching " ~ topic.raku, :$match;
            }
        }
    }
}

# given + objects
{
    class TestIt { method passit { 1; }; has %.testing is rw; };
    my $𝐩àòòe̲𝐝 = 0;
    ok( EVAL('given TestIt.new { $_.passit; };'), '$_. method calls' );
    ok( EVAL('given TestIt.new { .passit; };'), '. method calls' );
    ok( EVAL('given TestIt.new { $_.testing<a> = 1; };'),'$_. attribute access' );
    ok( EVAL('given TestIt.new { .testing<a> = 1; };'),  '. attribute access' );
    my $中 = TestIt.new;
    given $中 { when TestIt { $𝐩àòòe̲𝐝 = 1;} };
    is($𝐩àòòe̲𝐝, 1,'when Type {}');
{
    $𝐩àòòe̲𝐝 = 0;
    given $中 { when .isa(TestIt) { $𝐩àòòe̲𝐝 = 1;}};
    is($𝐩àòòe̲𝐝, 1,'when .isa(Type) {}');
}
    $𝐩àòòe̲𝐝 = 0;
    given $中 { when TestIt { $𝐩àòòe̲𝐝 = 1; }};
    is($𝐩àòòe̲𝐝, 1,'when Type {}');
}

{
    # given + true
    # L<S04/"Switch statements" /"is exactly equivalent to">
    my @갢丧𝐩갮中 = (0, 1);
    my @æ갨中;

    for @갢丧𝐩갮中 -> $ч {
        given $ч {
            when .so { push @æ갨中, "true" }
            default { push @æ갨中, "false" }
        }
    }

    is(@æ갨中.join(","), "false,true", 'given { when .so { } }');
}

# given + hash deref
{
    my %両;
    given %両 { .{'key'} = 'value'; }
    ok(%両{'key'} eq 'value', 'given and hash deref using .{}');
    given %両 { .<key> = "value"; }
    ok(%両{'key'} eq 'value', 'given and hash deref using .<>');
}

# given + 0-arg closure
{
    my $ч = 0;
    given 41 {
        when { $_ == 49 } { diag "this really shouldn't happen"; $ч = 49 }
        when { $_ == 41 } { $ч++ }
    }
    ok $ч, 'given tests 0-arg closures for truth';
}

# given + 1-arg closure
{
    my $ч;
    given 41 {
        when -> $中 { $中 == 49 } { diag "this really shouldn't happen"; $ч = 49 }
        when -> $中 { $中 == 41 } { $ч++ }
    }
    ok $ч, 'given tests 1-arg closures for truth';
}

# given + n>1-arg closure (should fail)
{
    dies-ok {
        given 41 {
            when -> $中, $r { $中 == $r } { ... }
        }
    }, 'fail on arities > 1';
}

# given + 0-arg sub
{
    my $ч = 41;
    sub àлw̲àùò_中с갮e̲ { Bool::True }
    given 1 {
        when &àлw̲àùò_中с갮e̲ { $ч++ }
    }
    is $ч, 42, 'given tests 0-arg subs for truth';
}

# given + 1-arg sub
{
    my $ч = 41;
    sub ìàù丛e̲_中с갮e̲ ($value) { $value eq "mytopic" }
    given "mytopic" {
        when &ìàù丛e̲_中с갮e̲ { $ч++ }
    }
    is $ч, 42, 'given tests 1-arg subs for truth';
}

# statement-modifying 'when'
{
    my $中сà개k̲e̲с = 1;
    given 1 {
        $中сà개k̲e̲с++ when 1;
    }
    is $中сà개k̲e̲с, 2, 'statement-modifying when';
}

# https://github.com/Raku/old-issue-tracker/issues/2210
eval-lives-ok 'given 3 { sub a() { } }', 'can define a sub inside a given';
eval-lives-ok 'sub a() { } given 3',     'can define a sub inside a statement-modifying given';

{
    my $개à𝐩中갮сe̲-갢ò-개갨ссe̲개中 = False;
    given "Hello" {
        when /e(\w\w)/ { $개à𝐩中갮сe̲-갢ò-개갨ссe̲개中 = $0 eq "ll"; }
    }
    ok $개à𝐩中갮сe̲-갢ò-개갨ссe̲개中, 'matches in when correctly set $0';
}

# Make sure lexically scoped topic is accessible within a nested closure.
# https://github.com/rakudo/rakudo/issues/4850
{
    my &개;
    given 'foo' {
        when Str {
            &개 = { $_  };
        }
    }
    is &개(), 'foo', 'lexical topic in a nested closure';
}

# vim: expandtab shiftwidth=4
