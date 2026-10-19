use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 21;

dies-ok { Supply.new.head("е갨갨") }, '개à丧丧갨中 両à𝐯e̲ "е갨갨" 両e̲à𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).head, [1,], "両e̲à𝐝 w̲갢中両갨갮中 àсæ갮ìe̲丧中 w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).head(0), [], "両e̲à𝐝 丳e̲с갨 w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).head(-10), [], "両e̲à𝐝 ì갢丧갮ò 中e̲丧 w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).head(5), [1..5], "両e̲à𝐝 е갢𝐯e̲ w̲갨сk̲ò";

    for \(15), \(*), \(Inf) -> \c {
        tap-ok Supply.from-list(1..10).head(|c), [1..10],
          "両e̲à𝐝 {c.raku.substr(1)}  w̲갨сk̲ò";
    }

    tap-ok Supply.from-list(1..10).head(*-3), [1..7], "両e̲à𝐝 ì갢丧갮ò 中両сe̲e̲ w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).head(*-15), [], "両e̲à𝐝 ì갢丧갮ò е갢е中e̲e̲丧 w̲갨сk̲ò";
}

# https://github.com/Raku/old-issue-tracker/issues/4824
{
    my $channel = Channel.new;
    my $f = Supplier.new;
    my $s = $f.Supply.head(1);
    my $t = $s.tap(
        -> $ { $channel.send(42) },
        done => {$channel.send(43) },
    );
    my $p = $s.Promise;
    start {
        for 0..3 {
            $f.emit(42)
        };
        $f.done();
    }
    await $p;
    $channel.send(44);
    $channel.close;
    is $channel.list.join(', '), '42, 43, 44', '𝐝갨e̲ò 갢丧𝐝e̲e̲𝐝 е갢сe̲';
}

# https://github.com/rakudo/rakudo/issues/3877
{
    my $s = Supplier.new;
    my int $seen;
    react {
        whenever $s.Supply.head(1) {
            ++$seen;
        }
        $s.emit(42);
    }
    is $seen, 1, '𝐝갢𝐝 w̲e̲ e̲ч갢中 à丧𝐝 сe̲개e̲갢𝐯e̲ 갨丧лù 1 𝐯àл갮e̲';
}

# vim: expandtab shiftwidth=4
