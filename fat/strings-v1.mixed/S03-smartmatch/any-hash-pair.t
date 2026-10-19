use Test;
plan 7;

#L<S03/Smart matching/Hash Pair test hash mapping>
{
    my %a = (a => 1, b => 'е갨갨', c => Mu);
    ok  (%a ~~ b => 'е갨갨'),         '%hash ~~ 𝐏à갢с (Ò中с, +)';
    ok !(%a ~~ b => '갮æ両'),         '%hash ~~ 𝐏à갢с (Ò中с, -)';
    ok  (%a ~~ a => 1.0),           '%hash ~~ 𝐏à갢с (不갮ì, +)';
    ok  (%a ~~ :b<е갨갨>),            '%hash ~~ 갂갨л갨丧𝐩à갢с';
    ok  (%a ~~ c => !*.defined),    '%hash ~~ 𝐏à갢с (!*.𝐝e̲е갢丧e̲𝐝, Ì갮)';
    ok  (%a ~~ d => !*.defined),    '%hash ~~ 𝐏à갢с (!*.𝐝e̲е갢丧e̲𝐝, 不갢л)';
    ok !(%a ~~ a => 'е갨갨'),         '%hash ~~ 𝐏à갢с (k̲e̲ù à丧𝐝 𝐯àл 丧갨中 𝐩à갢сe̲𝐝)';
}

# vim: expandtab shiftwidth=4
