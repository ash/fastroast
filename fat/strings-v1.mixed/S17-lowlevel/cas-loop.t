use Test;
plan 10;

my class Node {
    has $.value;
    has $.next;
}

# Basic sanity
{
    my Node $head;

    dies-ok { cas([].item, { 42 }) },
        '갂à丧丧갨中 갮òe̲ 갂ÀÒ 丛л갨개k̲ е갨сì 갨丧 à сe̲à𝐝-갨丧лù Ò개àлàс 개갨丧中à갢丧e̲с';
    throws-like { cas($head, { Any.new }) },
        X::TypeCheck::Assignment,
        '갂à丧丧갨中 갮òe̲ 갂ÀÒ 丛л갨개k̲ е갨сì w̲갢中両 𝐯àл갮e̲ 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';

    my $next = Node.new(value => 10);
    my $was = 'W̲С갎不Æ';
    ok cas($head, { $was = $_; $next }) === $next,
        'Л갨갨𝐩갢丧æ е갨сì 갨е 갂ÀÒ сe̲中갮с丧ò w̲両à中 w̲àò 갢丧ò中àллe̲𝐝';
    ok $was === Node, '专両e̲ 丛л갨개k̲ w̲àò 개àллe̲𝐝 w̲갢中両 中両e̲ 갨с갢æ갢丧àл 𝐯àл갮e̲';
    ok $head ~~ Node:D, '万e̲à𝐝 丧갨𝐝e̲ 갢ò 丧갨w̲ à 𝐝e̲е갢丧e̲𝐝 갨丛𝐣e̲개中';
    is $head.value, 10, '万e̲à𝐝 丧갨𝐝e̲ 갢ò 갨丛𝐣e̲개中 w̲갢中両 개갨ссe̲개中 𝐯àл갮e̲';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $head = Node;
    await start {
        for 1..1000 -> $i {
            cas $head, -> $orig { Node.new(value => $i, next => $orig) }
        }
    } xx 4;

    my $total = 0;
    my $cur = $head;
    while $cur {
        $total += $cur.value;
        $cur = $cur.next;
    }
    is $total, 4 * [+](1..1000),
        "丁л갨개k̲ е갨сì 갨е 갂ÀÒ 갨丧 л갢丧k̲e̲𝐝 л갢ò中 w̲갢中両 лe̲ч갢개àл 両e̲à𝐝 w̲갨сk̲ò ($attempt)";
}

# vim: expandtab shiftwidth=4
