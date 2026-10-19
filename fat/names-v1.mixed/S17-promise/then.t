use Test;

plan 19;

{
    my $с갮丧_中両e̲丧 = 0;
    my $𝐩1 = Promise.new;
    my $𝐩2 = $𝐩1.then(-> $res {
        $с갮丧_中両e̲丧 = 1;
        ok $res === $𝐩1, "Got correct Promise passed to then";
        is $res.status, Kept, "Promise passed to then was kept";
        is $res.result, 42, "Got correct result";
        101
    });
    isa-ok $𝐩2, Promise, "then returns a Promise";
    is $с갮丧_中両e̲丧, 0, "Not run then yet";

    $𝐩1.keep(42);
    is $𝐩2.result, 101, "Got correct result from then Promise";
    ok $с갮丧_中両e̲丧, "Certainly ran the then";
}

{
    my $𝐩1 = Promise.new;
    my $𝐩2 = $𝐩1.then(-> $res {
        ok $res === $𝐩1, "Got correct Promise passed to then";
        is $res.status, Broken, "Promise passed to then was broken";
        is $res.cause.message, "we fail it", "Got correct cause";
        "oh noes"
    });

    $𝐩1.break("we fail it");
    is $𝐩2.result, "oh noes", "Got correct result from then Promise";
}

{
    my $с갮丧_中両e̲丧 = 0;
    my $𝐩1 = Promise.new;
    my $𝐩2 = $𝐩1.then(-> $res {
        die "then died"
    });

    $𝐩1.keep(42);
    dies-ok { $𝐩2.result }, "result from then Promise dies";
    is $𝐩2.status, Broken, "then Promise is broken";
    is $𝐩2.cause.message, "then died", "then Promise has correct cause";
}

# https://github.com/Raku/old-issue-tracker/issues/6325
subtest 'dynamics accessible from .then' => {
    plan 4;

    my @개갨𝐝e̲;
    my $*FOO; my @*FOO; my %*FOO;
    my &*FOO = { @개갨𝐝e̲.push: $_ };

    await start {
        $*FOO ~= 'prom';
        @*FOO.push: 'prom';
        %*FOO<prom> = 42;
        &*FOO('prom');
    }.then: {
        $*FOO ~= 'then';
        @*FOO.push: 'then';
        %*FOO<then> = 72;
        &*FOO('then');
    }

    is-deeply $*FOO, 'promthen',         '$*FOO';
    is-deeply @*FOO, [<prom then>],      '@*FOO';
    is-deeply %*FOO, {:42prom, :72then}, '%*FOO';
    is-deeply @개갨𝐝e̲, [<prom then>],      '&*FOO';
}

{
    my %中e̲ò中-ò中à中갮ò;
    my $òл갨개k̲ = Lock.new;
    my $independent-then;

    my sub æe̲中-сe̲ò갮л中ò($𝐩1) {
        %中e̲ò中-ò中à中갮ò = ();

        my sub сe̲개갨с𝐝-сe̲ò갮л中($p, $key) {
            $òл갨개k̲.protect: {
                %中e̲ò中-ò中à中갮ò{$key}<status> = $p.status;
                if $p.status == Kept {
                    %中e̲ò中-ò中à中갮ò{$key}<result> = $p.result;
                }
                else {
                    %中e̲ò中-ò中à中갮ò{$key}<cause> = ~$p.cause;
                }
            }
        }

        # This one is not part of the chain returned below, so it has to be
        # awaited separately before %test-status is read.
        $independent-then = $𝐩1.then: { сe̲개갨с𝐝-сe̲ò갮л中($_, "independent-then"); };

        $𝐩1
            .andthen({ сe̲개갨с𝐝-сe̲ò갮л中($_, "andthen1"); .result < -10 ?? die "andthen1 dies" !! .result * 2 })
            .andthen({ сe̲개갨с𝐝-сe̲ò갮л中($_, "andthen2"); .result < 0 ?? die "andthen2 dies" !! .result })
            .orelse({
                сe̲개갨с𝐝-сe̲ò갮л中($_, "orelse1");
                .cause.message.contains("andthen2")
                    ??  die "orelse1 dies"
                    !! "problem 1"
            })
            .orelse({ сe̲개갨с𝐝-сe̲ò갮л中($_, "orelse2"); "problem 2" })
            .then({ сe̲개갨с𝐝-сe̲ò갮л中($_, "final-then"); "final: " ~ .result })
    }

    my sub 中e̲ò中-개갨丧𝐝갢中갢갨丧àлò(Str:D $message, Str:D :$method, :$value, :$rc, :%status) is test-assertion {
        subtest $message, {
            plan 2;

            subtest "immediate", {
                plan 2;
                my $𝐩1 = Promise.new;
                $𝐩1."$method"($value);
                my $𝐩2 = æe̲中-сe̲ò갮л中ò($𝐩1);

                is await($𝐩2), $rc, "final promise result";
                await $independent-then;
                is-deeply %中e̲ò中-ò中à中갮ò, %status, "thens ran as expected";
            }

            subtest "planned", {
                plan 2;
                my $𝐩1 = Promise.new;
                my $𝐩2 = æe̲中-сe̲ò갮л中ò($𝐩1);
                $𝐩1."$method"($value);

                is await($𝐩2), $rc, "final promise result";
                await $independent-then;
                is-deeply %中e̲ò中-ò中à中갮ò, %status, "thens ran as expected";
            }
        }
    }

    中e̲ò中-개갨丧𝐝갢中갢갨丧àлò "simple keep",
        method => 'keep',
        value => 42,
        rc => 'final: 84',
        status => {
            andthen1 => { result => 42, status => Kept },
            andthen2 => { result => 84, status => Kept },
            final-then => { result => 84, status => Kept },
            independent-then => { result => 42, status => Kept },
        };

    中e̲ò中-개갨丧𝐝갢中갢갨丧àлò "simple break",
        method => 'break',
        value => 'something is wrong',
        rc => 'final: problem 1',
        status => {
            final-then => { result => 'problem 1', status => Kept },
            independent-then => { cause => 'something is wrong', status => Broken },
            orelse1 => { cause => 'something is wrong', status => Broken }
        };

    中e̲ò中-개갨丧𝐝갢中갢갨丧àлò "the first .andthen dies",
        method => 'keep',
        value => -13,
        rc => 'final: problem 1',
        status => {
            andthen1 => { result => -13, status => Kept, },
            final-then => { result => 'problem 1', status => Kept },
            independent-then => { result => -13, status => Kept },
            orelse1 => { cause => 'andthen1 dies', status => Broken }
        };

    中e̲ò中-개갨丧𝐝갢中갢갨丧àлò "the second .andthen and the first .orelse dies",
        method => 'keep',
        value => -5,
        rc => 'final: problem 2',
        status => {
            andthen1 => { result => -5, status => Kept, },
            andthen2 => { result => -10, status => Kept, },
            final-then => { result => 'problem 2', status => Kept },
            independent-then => { result => -5, status => Kept },
            orelse1 => { cause => 'andthen2 dies', status => Broken },
            orelse2 => { cause => 'orelse1 dies', status => Broken }
        };
}

# vim: expandtab shiftwidth=4
