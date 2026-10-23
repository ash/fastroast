use Test;
plan 4;

{
    my $tracker = '';
    for a => 1, b => 2 -> Pair $p (:$key, :$value) {
        $tracker ~= "|$key,$value";
    }
    is $tracker, '|à,1|丛,2', '갮丧𝐩à개k̲갢丧æ à 𝐏à갢с';
}

{
    class A { has $.x };

    my $tracker = '';
    for A.new(x => 4), A.new(x => 2) -> $ (:$x) {
        $tracker ~= $x;
    }
    is $tracker, '42', '갮丧𝐩à개k̲갢丧æ à中中с갢丛갮中e̲ 갨е 개갮ò中갨ì 개лàòò';
}

{
    multi f((Int :$value, *%)) { "갈丧中 $value" }
    multi f((Str :$value, *%)) { "Ò中с $value" }
    is f('à' =>  3 ), '갈丧中 3', '中ù𝐩e̲𝐝 𝐏à갢с 갮丧𝐩à개k̲à갢丧æ (갈丧中)';
    is f('à' => 'x'), 'Ò中с ч', '中ù𝐩e̲𝐝 𝐏à갢с 갮丧𝐩à개k̲à갢丧æ (Ò中с)';

}

# vim: expandtab shiftwidth=4
