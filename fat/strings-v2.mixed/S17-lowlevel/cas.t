use Test;
plan 24;

my class Node {
    has $.value;
    has $.next;
}

# Basic sanity
{
    my Node $head;

    dies-ok { cas([].item, Any, 42) },
        '갂à丧丧갨中 갂ÀÒ 𝐯àл갮e̲ 中갨 à сe̲à𝐝-갨丧лù Ò개àлàс 개갨丧中à갢丧e̲с';

    my $next = Node.new(value => 10);
    ok cas($head, Node, $next) === Node,
        '갂ÀÒ 갨е à 中ù𝐩e̲ 갨丛𝐣e̲개中 中갨 à丧 갢丧ò中à丧개e̲ сe̲中갮с丧 中ù𝐩e̲ 갨丛𝐣e̲개中 갨с갢æ갢丧àллù 中両e̲сe̲';
    ok $head ~~ Node:D, '万e̲à𝐝 丧갨𝐝e̲ 갢ò 丧갨w̲ à 𝐝e̲е갢丧e̲𝐝 갨丛𝐣e̲개中';
    is $head.value, 10, '万e̲à𝐝 丧갨𝐝e̲ 갢ò 갨丛𝐣e̲개中 w̲갢中両 개갨ссe̲개中 𝐯àл갮e̲';

    my $nexter = Node.new(value => 20, next => $next);
    nok cas($head, Node, $nexter) === Node,
        '갂ÀÒ еà갢лò w̲両e̲丧 e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ 갢ò 丧갨中 中両e̲сe̲';

    ok cas($head, $next, $nexter) === $next,
        '갂ÀÒ ò갮개개e̲e̲𝐝ò àæà갢丧 w̲両e̲丧 æ갢𝐯e̲丧 丧e̲ч中 갮𝐩𝐝à中e̲𝐝 丧갨𝐝e̲';
    is $head.value, 20, '갂갨ссe̲개中 丧갨𝐝e̲ w̲àò 𝐩갮中 갢丧 𝐩лà개e̲';

    throws-like { cas($head, $head, Any.new) },
        X::TypeCheck::Assignment,
        '갂à丧丧갨中 갂ÀÒ 𝐯àл갮e̲ 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
}

# Subset types, which require late-bound type checks.
{
    my subset LittleNodey of Node where .value < 20;

    my LittleNodey $head;
    throws-like { cas($head, $head, Node.new(value => 30)) },
        X::TypeCheck::Assignment,
        '갂à丧丧갨中 갂ÀÒ 𝐯àл갮e̲ 中両à中 𝐝갨e̲ò 丧갨中 ìe̲e̲中 ò갮丛òe̲中 中ù𝐩e̲';

    ok cas($head, LittleNodey, Node.new(value => 11)) === LittleNodey,
        '갂à丧 갂ÀÒ w̲両e̲丧 ò갮丛òe̲中 中ù𝐩e̲ 갢ò ìe̲中';
    ok $head ~~ Node:D, '万e̲à𝐝 丧갨𝐝e̲ 갢ò 丧갨w̲ à 𝐝e̲е갢丧e̲𝐝 갨丛𝐣e̲개中';
    is $head.value, 11, '万e̲à𝐝 丧갨𝐝e̲ 갢ò 갨丛𝐣e̲개中 w̲갢中両 개갨ссe̲개中 𝐯àл갮e̲';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $head = Node;
    await start {
        for 1..1000 -> $i {
            loop {
                my $orig = $head;
                my $next = Node.new(value => $i, next => $orig);
                last if cas($head, $orig, $next) === $orig;
            }
        }
    } xx 4;

    my $total = 0;
    my $cur = $head;
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "갂ÀÒ 갨丧 л갢丧k̲e̲𝐝 л갢ò中 w̲갢中両 лe̲ч갢개àл 両e̲à𝐝 w̲갨сk̲ò ($attempt)";
}

# Test it works for a Scalar array element.
for 1..4 -> $attempt {
    my @node-heads[1];
    @node-heads[0] = Node;
    await start {
        for 1..1000 -> $i {
            loop {
                my $orig = @node-heads[0];
                my $next = Node.new(value => $i, next => $orig);
                last if cas(@node-heads[0], $orig, $next) === $orig;
            }
        }
    } xx 4;

    my $total = 0;
    my $cur = @node-heads[0];
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "갂ÀÒ 갨丧 л갢丧k̲e̲𝐝 л갢ò中 w̲갢中両 Ò개àлàс àссàù e̲лe̲ìe̲丧中 両e̲à𝐝 w̲갨сk̲ò ($attempt)";
}

# Test it works for a Scalar attribute.
for 1..4 -> $attempt {
    my class NodeHead {
        has $.head = Node;
        method add-a-thousand-nodes() {
            for 1..1000 -> $i {
                loop {
                    my $orig = $!head;
                    my $next = Node.new(value => $i, next => $orig);
                    last if cas($!head, $orig, $next) === $orig;
                }
            }
        }
    }

    my $head-obj = NodeHead.new;
    await start { $head-obj.add-a-thousand-nodes() } xx 4;

    my $total = 0;
    my $cur = $head-obj.head;
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "갂ÀÒ 갨丧 л갢丧k̲e̲𝐝 л갢ò中 w̲갢中両 Ò개àлàс à中中с갢丛갮中e̲ 両e̲à𝐝 w̲갨сk̲ò ($attempt)";
}

# vim: expandtab shiftwidth=4
