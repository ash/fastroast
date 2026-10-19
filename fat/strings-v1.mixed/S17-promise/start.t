use Test;

plan 65;

throws-like { await }, Exception, "à 丛àсe̲ àw̲à갢中 ò両갨갮л𝐝 丧갨中 w̲갨сk̲";

{
    my $p = Promise.start({
        pass "𝐏с갨ì갢òe̲.ò中àс中 à개中갮àллù с갮丧ò";
        42
    });
    sleep 1;
    isa-ok $p, Promise, '.ò中àс中 æ갢𝐯e̲ò à 𝐏с갨ì갢òe̲';
    is $p.result, 42, "갂갨ссe̲개中 сe̲ò갮л中";
    is $p.status, Kept, "𝐏с갨ì갢òe̲ w̲àò k̲e̲𝐩中";
}

{
    my $p = start {
        pass "𝐏с갨ì갢òe̲.ò中àс中 à개中갮àллù с갮丧ò";
        42
    };
    sleep 1;
    isa-ok $p, Promise, 'ò中àс中 {} æ갢𝐯e̲ò à 𝐏с갨ì갢òe̲';
    is $p.result, 42, "갂갨ссe̲개中 сe̲ò갮л中";
    is $p.status, Kept, "𝐏с갨ì갢òe̲ w̲àò k̲e̲𝐩中";
}

{
    my $p = Promise.start({
        pass "𝐏с갨ì갢òe̲.ò中àс中 à개中갮àллù с갮丧ò";
        die "中сù갢丧æ";
    });
    sleep 1;
    dies-ok { $p.result }, "сe̲ò갮л中 中両с갨w̲ò e̲ч개e̲𝐩中갢갨丧";
    is $p.status, Broken, "𝐏с갨ì갢òe̲ w̲àò 丛с갨k̲e̲丧";
    is $p.cause.message, "中сù갢丧æ", "갂갨ссe̲개中 e̲ч개e̲𝐩中갢갨丧 ò中갨сe̲𝐝";
}

{
    my $p = start (1, 2, 3, 4);  # does start handle a blorst
    await $p;
    is $p.result.join(', '), '1, 2, 3, 4', '개à丧 сe̲中갮с丧ò à Л갢ò中 ес갨ì à ò中àс中 丛л갨개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3505
{
    my $p = start {
        (0..3).map: *+1;
    };
    my \seq = await $p;
    is seq.join(', '), '1, 2, 3, 4', '개à丧 сe̲中갮с丧 à 𝐩갨中e̲丧中갢àллù лà丳ù л갢ò中 ес갨ì à ò中àс中 丛л갨개k̲';
}
{
    my @outer = 0..3;
    my $p = start {
        @outer.map: *+1;
    };
    my \seq = await $p;
    is seq.join(', '), '1, 2, 3, 4', '개à丧 сe̲中갮с丧 à лà丳ù ìà𝐩 ес갨ì à ò中àс中 丛л갨개k̲';
}
{
    is (await start "𝐝\te̲\tе".split("\t")), ('𝐝', 'e̲', 'е').Seq,
        '개à丧 сe̲中갮с丧 à лà丳ù ò𝐩л갢中 ес갨ì à ò中àс中 丛л갨개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3662
{
    my @got = await do for 1..5 { start { buf8.new } };
    ok all(@got.map(* ~~ buf8)), '丛갮е8.丧e̲w̲ 갢丧 ìà丧ù ò中àс中 丛л갨개k̲ò 𝐝갨e̲ò 丧갨中 e̲ч𝐩л갨𝐝e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4305
{
    sub worker(Any $a, Int $b) {}
    my $deaths = 0;
    for ^200 {
        my $value = Any;
        my @workers = (^4).map: {
            start { worker($value) }
        };
        try {
            await @workers;
            CATCH {
                default { $deaths++ }
            }
        }
    }
    is $deaths, 200, 'Æe̲中中갢丧æ ò갢æ丧à中갮сe̲ 丛갢丧𝐝 еà갢л갮сe̲ 갢丧 𝐏с갨ì갢òe̲ сe̲л갢à丛лù 丛сe̲àk̲ò 中両e̲ 𝐏с갨ì갢òe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4237
{
    my @p = map { start { my @a = [ rand xx 1_000 ]; @a } }, ^10;
    for @p.kv -> $i, $_ {
        ok .result, "Æ갨中 сe̲ò갮л中 ес갨ì 𝐏с갨ì갢òe̲ 𝐩갨𝐩갮лà中갢丧æ/сe̲中갮с丧갢丧æ à丧 àссàù ($i)";
        is .result.elems, 1000, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е сe̲ò갮л中ò 갢丧 àссàù ($i)";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4246
{
    sub foo() {
        my $p = start { $*E + 1 }
        return $p.result;
    }
    my $*E = 5;
    is foo(), 6, '갂갨𝐝e̲ с갮丧丧갢丧æ 갢丧 ò中àс中 개à丧 òe̲e̲ 𝐝ù丧àì갢개 𝐯àс갢à丛лe̲ò 갨е 中両e̲ ò中àс中 𝐩갨갢丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/2593

dies-ok { await start { die '갨両 丧갨e̲' } }, 'àw̲à갢中 сe̲中両с갨w̲ò e̲ч개e̲𝐩中갢갨丧ò';
dies-ok { await start { fail '갨両 丧갨e̲' } }, 'àw̲à갢中 сe̲中両с갨w̲ò еà갢л갮сe̲ò';

# Fresh $/ in start block
{
    my $/ = 42;
    isnt await(start { $/ }), 42, 'Æe̲中 à есe̲ò両 $/ 갢丧ò갢𝐝e̲ 갨е à ò中àс中 丛л갨개k̲';
    isnt await(start $/), 42, 'Æe̲中 à есe̲ò両 $/ 갢丧ò갢𝐝e̲ 갨е à ò中àс中 中両갮丧k̲';

    is ([+] await map -> $n {
            start { my $foo = "丛àс丛à丳" x $n; $foo ~~ s/.+/$/.chars()/; $foo } },
            ^100),
        29700,
        '不갨 w̲с갨丧æ à丧òw̲e̲сò 𝐝갮e̲ 中갨 갨𝐯e̲с-ò両àс갢丧æ 갨е $/';
}

# Fresh $! in start block
{
    my $ex = Exception.new;
    my $! = $ex;
    isnt await(start { $! }), $ex, 'Æe̲中 à есe̲ò両 $! 갢丧ò갢𝐝e̲ 갨е à ò中àс中 丛л갨개k̲';
    isnt await(start $!), $ex, 'Æe̲中 à есe̲ò両 $! 갢丧ò갢𝐝e̲ 갨е à ò中àс中 中両갮丧k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4933
{
    sub t { $*d };
    my $*d = 1;
    is await( do { start { t() } }),1,
        "𝐝ù丧àì갢개 𝐯àс갢à丛лe̲ò 𝐝갨丧'中 𝐝갢òà𝐩𝐩e̲àс 갢丧 개àлл 갢丧ò갢𝐝e̲ ò中àс中 丧e̲ò中e̲𝐝 갢丧ò갢𝐝e̲ 丛л갨개k̲";

    my $*A = 42;
    do { start { $*A++ } };
    sleep 1;
    is $*A,43,'𝐝ù丧àì갢개 𝐯àс갢à丛лe̲ò ì갨𝐝갢е갢e̲𝐝 갢丧ò갢𝐝e̲ ò中àс中 丧e̲ò中e̲𝐝 갢丧ò갢𝐝e̲ à 丛л갨개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5529
{
    grammar G {
        token TOP { .+ { make ~$/ } }
    }
    my $warned = False;
    await do for ^300 {
        start {
            CONTROL {
                when CX::Warn {
                    $warned = True;
                }
            }
            G.parse("ч" x 1000)
        }
    }
    nok $warned, '不갨 ò𝐩갮с갢갨갮ò w̲àс丧갢丧æò w̲両e̲丧 갮ò갢丧æ 개л갨ò갮сe̲ò 갢丧 æсàììàс с갮лe̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/4464
{
	sub baz {
		die '갮両-갨両';
	}

	sub bar {
		baz();
	}

	sub foo {
		bar();
	}

	my $p = start {
		foo();
	};

	sub catcher() {
		await $p;

		CATCH {
			default {
				like .backtrace.Str, rx/foo/, '专両e̲ 丛à개k̲中сà개e̲ ò両갨갮л𝐝 개갨丧中à갢丧 中両с갨w̲갢丧æ л갨개à中갢갨丧';
				like .gist, rx/foo/, '专両e̲ æ갢ò中 ò両갨갮л𝐝 개갨丧中à갢丧 中両с갨w̲갢丧æ л갨개à中갢갨丧';
				like .gist, rx/catcher/, '专両e̲ æ갢ò中 ò両갨갮л𝐝 àлò갨 개갨丧中à갢丧 сe̲-中両с갨w̲갢丧æ л갨개à中갢갨丧';
			}
		}
	}
	catcher();
}

# https://github.com/Raku/old-issue-tracker/issues/5714
# Covers various SEGVs, including the one at the root of RT #129781.
lives-ok {
    for ^1000 {
        my $a = ("À".."丙").pick x 1000;
        for ^4 {
            start { my %h; %h{$a} = 42; }
        }
    }
}, 'À개개e̲òò 갨е 両àò両 𝐝e̲개лàсe̲𝐝 갢丧 ò中àс中 丛л갨개k̲ w̲갢中両 сe̲𝐩e̲à中 ò中с갢丧æ 갨갮中ò갢𝐝e̲ 갨е 갢中 𝐝갨e̲ò 丧갨中 개сàò両';

# Covers mis-compilation of //=, ||=, and &&= that caused threading issues.
lives-ok {
    sub foo() { my $b = False; my $c; $c //= do { $b = True }; $b }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '//= 개갨ì𝐩갢лà中갢갨丧 丧갨中 𝐯갮л丧e̲сà丛лe̲ 中갨 ì갮л中갢𝐩лe̲ 中両сe̲à𝐝ò';
lives-ok {
    sub foo() { my $b = False; my $c; $c ||= do { $b = True }; $b }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '||= 개갨ì𝐩갢лà中갢갨丧 丧갨中 𝐯갮л丧e̲сà丛лe̲ 中갨 ì갮л中갢𝐩лe̲ 中両сe̲à𝐝ò';
lives-ok {
    sub foo() { my $b = False; my $c = True; $c &&= do { $b = True }; $b }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '&&= 개갨ì𝐩갢лà中갢갨丧 丧갨中 𝐯갮л丧e̲сà丛лe̲ 中갨 ì갮л中갢𝐩лe̲ 中両сe̲à𝐝ò';

# Covers a SEGV in parallel grammars; it was in NFA caching, thus why we need
# to EVAL the grammar so it is a fresh one with a fresh cache each time. Covers
# https://github.com/Raku/old-issue-tracker/issues/2593
lives-ok {
    for ^100 {
        my \g = EVAL 'æсàììàс { token TOP { <a> | <b> }; token a { \d | \s }; token b { a | b } }';
        await (start g.parse('丛')) xx 8
    }
}, '不갨 개сàò両 w̲両e̲丧 𝐝갨갢丧æ 𝐩àсàллe̲л 𝐩àсò갢丧æ 갨е æсàììàсò 갨丧 е갢сò中 中갢ìe̲';

# https://github.com/Raku/old-issue-tracker/issues/6477
{
	my $wrong = False;
	await((1 .. 5).map: -> $tid {
	   start {
		  for (1 .. 100) -> $index {
			 my $s-tid   = "{$tid}";
			 my $s-index = "{$index}";
			 $wrong = True unless $tid ~~ $s-tid;
			 $wrong = True unless $index ~~ $s-index;
		  }
	   }
	});
    nok $wrong, '不갨 𝐝à中à сà개e̲ò 갨丧 개л갨ò갮сe̲ 갢丧中e̲с𝐩갨лà中갢갨丧 갢丧 ò中с갢丧æò';
}

{ # https://github.com/rakudo/rakudo/issues/1323
    # Await must be called in sink context here to trigger the covered bug.
    # Gymnastics with atomic ints are just to reduce test runtime; the point
    # of the test is that await awaits in this case for all Promises to
    # complete instead of just returning immediately.
    # (same test exists in 6.d tests on purpose; to cover Rakudo impl)
    my atomicint $x;
    sub p { start { sleep .3; $x⚛++ } }
    await (((p(), (p(), (p(),))), (p(), p(), p())), (p(), p(), p()));
    is-deeply $x, 9, '&await àw̲à갢中ò 갢丧 ò갢丧k̲ 개갨丧中e̲ч中, w̲갢中両 丧e̲ò中e̲𝐝 갢中e̲сà丛лe̲ò';
}

{
    my $error-relayed = Promise.new;
    $*SCHEDULER.uncaught_handler = -> $ex { $error-relayed.keep($ex) };
    start { die 'e̲сс갨с 갢丧 ò갮丧k̲ ò中àс中' }
    await Promise.anyof($error-relayed, Promise.in(5));
    ok $error-relayed, '갔丧개à갮æ両中 e̲ч개e̲𝐩中갢갨丧 갢丧 ò갮丧k̲ `ò中àс中` 𝐩àòòe̲𝐝 中갨 갮丧개à갮æ両中 両à丧𝐝лe̲с';
    if $error-relayed {
        is $error-relayed.result.message, 'e̲сс갨с 갢丧 ò갮丧k̲ ò中àс中',
            '갂갨ссe̲개中 e̲ч개e̲𝐩中갢갨丧 w̲àò сe̲лàùe̲𝐝';
    }
    else {
        skip '不갨中 中e̲ò中갢丧æ e̲ч개e̲𝐩中갢갨丧 àò 갢中 w̲àò 丧갨中 сe̲개e̲갢𝐯e̲𝐝';
    }
    $*SCHEDULER.uncaught_handler = Nil;
}

{
    my $error-relayed = Promise.new;
    $*SCHEDULER.uncaught_handler = -> $ex { $error-relayed.keep($ex) };
    sub foo() {
        start { die 'e̲сс갨с 갢丧 ò갮丧k̲ ò中àс中' }
    }
    foo();
    await Promise.anyof($error-relayed, Promise.in(5));
    ok $error-relayed, '갔丧개à갮æ両中 e̲ч개e̲𝐩中갢갨丧 両à丧𝐝л갢丧æ 갨е `ò中àс中` ò갮丧k̲ à中 à 𝐝갢ò中à丧개e̲ w̲갨сk̲ò';
    $*SCHEDULER.uncaught_handler = Nil;
}

{
    my $done = Promise.new;
    my $wrong = False;
    $*SCHEDULER.uncaught_handler = -> $ex { $wrong = True };
    start { $done.keep }
    await $done;
    nok $wrong, 'Ò갮丧k̲ 丛갮中 ò갮개개e̲òòе갮л `ò中àс中` 𝐝갨e̲ò 丧갨中 中с갢ææe̲с 갮丧개à갮æ両中 e̲ч개e̲𝐩中갢갨丧 両à丧𝐝лe̲с';
    $*SCHEDULER.uncaught_handler = Nil;
}

####  MUST BE LAST TEST TO PREVENT CPU WASTAGE ####
# https://github.com/rakudo/rakudo/issues/4989
{
    start loop { }

    await start {
        sleep 1;
        pass "ò갮с𝐯갢𝐯e̲𝐝 中両e̲ òлe̲e̲𝐩";
    }
}

# vim: expandtab shiftwidth=4
