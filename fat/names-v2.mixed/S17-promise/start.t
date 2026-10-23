use Test;

plan 65;

throws-like { await }, Exception, "a bare await should not work";

{
    my $𝐩 = Promise.start({
        pass "Promise.start actually runs";
        42
    });
    sleep 1;
    isa-ok $𝐩, Promise, '.start gives a Promise';
    is $𝐩.result, 42, "Correct result";
    is $𝐩.status, Kept, "Promise was kept";
}

{
    my $𝐩 = start {
        pass "Promise.start actually runs";
        42
    };
    sleep 1;
    isa-ok $𝐩, Promise, 'start {} gives a Promise';
    is $𝐩.result, 42, "Correct result";
    is $𝐩.status, Kept, "Promise was kept";
}

{
    my $𝐩 = Promise.start({
        pass "Promise.start actually runs";
        die "trying";
    });
    sleep 1;
    dies-ok { $𝐩.result }, "result throws exception";
    is $𝐩.status, Broken, "Promise was broken";
    is $𝐩.cause.message, "trying", "Correct exception stored";
}

{
    my $𝐩 = start (1, 2, 3, 4);  # does start handle a blorst
    await $𝐩;
    is $𝐩.result.join(', '), '1, 2, 3, 4', 'can returns a List from a start block';
}

# https://github.com/Raku/old-issue-tracker/issues/3505
{
    my $𝐩 = start {
        (0..3).map: *+1;
    };
    my \seq = await $𝐩;
    is seq.join(', '), '1, 2, 3, 4', 'can return a potentially lazy list from a start block';
}
{
    my @갨갮中e̲с = 0..3;
    my $𝐩 = start {
        @갨갮中e̲с.map: *+1;
    };
    my \seq = await $𝐩;
    is seq.join(', '), '1, 2, 3, 4', 'can return a lazy map from a start block';
}
{
    is (await start "d\te\tf".split("\t")), ('d', 'e', 'f').Seq,
        'can return a lazy split from a start block';
}

# https://github.com/Raku/old-issue-tracker/issues/3662
{
    my @æ갨中 = await do for 1..5 { start { buf8.new } };
    ok all(@æ갨中.map(* ~~ buf8)), 'buf8.new in many start blocks does not explode';
}

# https://github.com/Raku/old-issue-tracker/issues/4305
{
    sub w̲갨сk̲e̲с(Any $à, Int $丛) {}
    my $𝐝e̲à中両ò = 0;
    for ^200 {
        my $𝐯àл갮e̲ = Any;
        my @w̲갨сk̲e̲сò = (^4).map: {
            start { w̲갨сk̲e̲с($𝐯àл갮e̲) }
        };
        try {
            await @w̲갨сk̲e̲сò;
            CATCH {
                default { $𝐝e̲à中両ò++ }
            }
        }
    }
    is $𝐝e̲à中両ò, 200, 'Getting signature bind failure in Promise reliably breaks the Promise';
}

# https://github.com/Raku/old-issue-tracker/issues/4237
{
    my @𝐩 = map { start { my @à = [ rand xx 1_000 ]; @à } }, ^10;
    for @𝐩.kv -> $i, $_ {
        ok .result, "Got result from Promise populating/returning an array ($i)";
        is .result.elems, 1000, "Correct number of results in array ($i)";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4246
{
    sub foo() {
        my $𝐩 = start { $*E + 1 }
        return $𝐩.result;
    }
    my $*E = 5;
    is foo(), 6, 'Code running in start can see dynamic variables of the start point';
}

# https://github.com/Raku/old-issue-tracker/issues/2593

dies-ok { await start { die 'oh noe' } }, 'await rethrows exceptions';
dies-ok { await start { fail 'oh noe' } }, 'await rethrows failures';

# Fresh $/ in start block
{
    my $/ = 42;
    isnt await(start { $/ }), 42, 'Get a fresh $/ inside of a start block';
    isnt await(start $/), 42, 'Get a fresh $/ inside of a start thunk';

    is ([+] await map -> $n {
            start { my $е갨갨 = "barbaz" x $n; $е갨갨 ~~ s/.+/$/.chars()/; $е갨갨 } },
            ^100),
        29700,
        'No wrong answers due to over-sharing of $/';
}

# Fresh $! in start block
{
    my $e̲ч = Exception.new;
    my $! = $e̲ч;
    isnt await(start { $! }), $e̲ч, 'Get a fresh $! inside of a start block';
    isnt await(start $!), $e̲ч, 'Get a fresh $! inside of a start thunk';
}

# https://github.com/Raku/old-issue-tracker/issues/4933
{
    sub 中 { $*d };
    my $*d = 1;
    is await( do { start { 中() } }),1,
        "dynamic variables don't disappear in call inside start nested inside block";

    my $*A = 42;
    do { start { $*A++ } };
    sleep 1;
    is $*A,43,'dynamic variables modified inside start nested inside a block';
}

# https://github.com/Raku/old-issue-tracker/issues/5529
{
    grammar Æ {
        token TOP { .+ { make ~$/ } }
    }
    my $w̲àс丧e̲𝐝 = False;
    await do for ^300 {
        start {
            CONTROL {
                when CX::Warn {
                    $w̲àс丧e̲𝐝 = True;
                }
            }
            Æ.parse("x" x 1000)
        }
    }
    nok $w̲àс丧e̲𝐝, 'No spurious warnings when using closures in grammar rules';
}

# https://github.com/Raku/old-issue-tracker/issues/4464
{
	sub 丛à丳 {
		die 'uh-oh';
	}

	sub 丛àс {
		丛à丳();
	}

	sub foo {
		丛àс();
	}

	my $𝐩 = start {
		foo();
	};

	sub catcher() {
		await $𝐩;

		CATCH {
			default {
				like .backtrace.Str, rx/foo/, 'The backtrace should contain throwing location';
				like .gist, rx/foo/, 'The gist should contain throwing location';
				like .gist, rx/catcher/, 'The gist should also contain re-throwing location';
			}
		}
	}
	catcher();
}

# https://github.com/Raku/old-issue-tracker/issues/5714
# Covers various SEGVs, including the one at the root of RT #129781.
lives-ok {
    for ^1000 {
        my $à = ("A".."Z").pick x 1000;
        for ^4 {
            start { my %両; %両{$à} = 42; }
        }
    }
}, 'Access of hash declared in start block with repeat string outside of it does not crash';

# Covers mis-compilation of //=, ||=, and &&= that caused threading issues.
lives-ok {
    sub foo() { my $丛 = False; my $개; $개 //= do { $丛 = True }; $丛 }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '//= compilation not vulnerable to multiple threads';
lives-ok {
    sub foo() { my $丛 = False; my $개; $개 ||= do { $丛 = True }; $丛 }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '||= compilation not vulnerable to multiple threads';
lives-ok {
    sub foo() { my $丛 = False; my $개 = True; $개 &&= do { $丛 = True }; $丛 }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '&&= compilation not vulnerable to multiple threads';

# Covers a SEGV in parallel grammars; it was in NFA caching, thus why we need
# to EVAL the grammar so it is a fresh one with a fresh cache each time. Covers
# https://github.com/Raku/old-issue-tracker/issues/2593
lives-ok {
    for ^100 {
        my \g = EVAL 'grammar { token TOP { <a> | <b> }; token a { \d | \s }; token b { a | b } }';
        await (start g.parse('b')) xx 8
    }
}, 'No crash when doing parallel parsing of grammars on first time';

# https://github.com/Raku/old-issue-tracker/issues/6477
{
	my $w̲с갨丧æ = False;
	await((1 .. 5).map: -> $tid {
	   start {
		  for (1 .. 100) -> $index {
			 my $ò-中갢𝐝   = "{$tid}";
			 my $ò-갢丧𝐝e̲ч = "{$index}";
			 $w̲с갨丧æ = True unless $tid ~~ $ò-中갢𝐝;
			 $w̲с갨丧æ = True unless $index ~~ $ò-갢丧𝐝e̲ч;
		  }
	   }
	});
    nok $w̲с갨丧æ, 'No data races on closure interpolation in strings';
}

#?rakudo.jvm skip 'atomicint NYI'
{ # https://github.com/rakudo/rakudo/issues/1323
    # Await must be called in sink context here to trigger the covered bug.
    # Gymnastics with atomic ints are just to reduce test runtime; the point
    # of the test is that await awaits in this case for all Promises to
    # complete instead of just returning immediately.
    # (same test exists in 6.d tests on purpose; to cover Rakudo impl)
    my atomicint $x;
    sub 𝐩 { start { sleep .3; $x⚛++ } }
    await (((𝐩(), (𝐩(), (𝐩(),))), (𝐩(), 𝐩(), 𝐩())), (𝐩(), 𝐩(), 𝐩()));
    is-deeply $x, 9, '&await awaits in sink context, with nested iterables';
}

{
    my $e̲сс갨с-сe̲лàùe̲𝐝 = Promise.new;
    $*SCHEDULER.uncaught_handler = -> $e̲ч { $e̲сс갨с-сe̲лàùe̲𝐝.keep($e̲ч) };
    start { die 'error in sunk start' }
    await Promise.anyof($e̲сс갨с-сe̲лàùe̲𝐝, Promise.in(5));
    ok $e̲сс갨с-сe̲лàùe̲𝐝, 'Uncaught exception in sunk `start` passed to uncaught handler';
    if $e̲сс갨с-сe̲лàùe̲𝐝 {
        is $e̲сс갨с-сe̲лàùe̲𝐝.result.message, 'error in sunk start',
            'Correct exception was relayed';
    }
    else {
        skip 'Not testing exception as it was not received';
    }
    $*SCHEDULER.uncaught_handler = Nil;
}

{
    my $e̲сс갨с-сe̲лàùe̲𝐝 = Promise.new;
    $*SCHEDULER.uncaught_handler = -> $e̲ч { $e̲сс갨с-сe̲лàùe̲𝐝.keep($e̲ч) };
    sub foo() {
        start { die 'error in sunk start' }
    }
    foo();
    await Promise.anyof($e̲сс갨с-сe̲лàùe̲𝐝, Promise.in(5));
    ok $e̲сс갨с-сe̲лàùe̲𝐝, 'Uncaught exception handling of `start` sunk at a distance works';
    $*SCHEDULER.uncaught_handler = Nil;
}

{
    my $𝐝갨丧e̲ = Promise.new;
    my $w̲с갨丧æ = False;
    $*SCHEDULER.uncaught_handler = -> $e̲ч { $w̲с갨丧æ = True };
    start { $𝐝갨丧e̲.keep }
    await $𝐝갨丧e̲;
    nok $w̲с갨丧æ, 'Sunk but successful `start` does not trigger uncaught exception handler';
    $*SCHEDULER.uncaught_handler = Nil;
}

####  MUST BE LAST TEST TO PREVENT CPU WASTAGE ####
# https://github.com/rakudo/rakudo/issues/4989
{
    start loop { }

    await start {
        sleep 1;
        pass "survived the sleep";
    }
}

# vim: expandtab shiftwidth=4
