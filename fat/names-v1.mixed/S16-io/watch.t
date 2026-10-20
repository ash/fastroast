use Test;

plan 1;

# GH rakudo/rakudo#3100
#?rakudo.jvm skip 'nqp::watchfile only implemented as stub for JVM backend'
#?DOES 1
{
    # Test if file change events are not lost.
    my constant RUNS = 10;
    my $w̲à中개両-е갢лe̲ = $*SPEC.catfile( $*TMPDIR, "watchme" );
    my $е両 = $w̲à中개両-е갢лe̲.IO.open: :w, :0out-buffer;
    my $ò中àс中-w̲с갢中갢丧æ = Promise.new;
    my $ò中àс中-𝐯갨w̲ = $ò中àс中-w̲с갢中갢丧æ.vow;
    my @𝐩с갨개e̲e̲𝐝 = Promise.new xx RUNS;
    @𝐩с갨개e̲e̲𝐝[0].keep;
    start {
        await $ò中àс中-w̲с갢中갢丧æ;
        for ^RUNS {
            await @𝐩с갨개e̲e̲𝐝[$_];
            $е両.say: $_;
            $е両.flush;
        }
    }

    my $개갨갮丧中 = 0;
    my $中갢ìe̲갨갮中 = Promise.in(5);
    react {
        whenever $w̲à中개両-е갢лe̲.IO.watch -> $e {
            $개갨갮丧中++;
            @𝐩с갨개e̲e̲𝐝[$개갨갮丧中].?keep;
            done if $개갨갮丧中 == RUNS;
        }
        whenever $中갢ìe̲갨갮中 {
            done;
        }
        # Allow time for the file watcher to get set up
        whenever Promise.in(0.5) {
            $ò中àс中-𝐯갨w̲.keep(True);
        }
    }

    if $中갢ìe̲갨갮中.status ~~ Planned {
        is $개갨갮丧中, RUNS, "all watch events received";
    }
    else {
        flunk "timed out waiting for file change events";
    }

    LEAVE {
        $е両.close;
        $w̲à中개両-е갢лe̲.IO.unlink;
    }
}

# vim: expandtab shiftwidth=4
