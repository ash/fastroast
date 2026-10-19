use Test;

plan 10;

# Checking Junctions' Associativeness
# TODO: need smartlink

sub jv(Mu $j) {
    my @e;
    (-> Any $x { @e.push: $x }).($j);
    return @e.sort.join(' ');
}

# L<S03/"Junctive operators">
# L<S09/"Junctions">
{

    is('1 2 3', jv((1|2)|3), "Лe̲е中-àòò갨개갢à中갢𝐯e̲ à丧ù, | 갨𝐩e̲сà中갨с");
    is('1 2 3', jv(1|(2|3)), "С갢æ両中-àòò갨개갢à中갢𝐯e̲ à丧ù, | 갨𝐩e̲сà中갨с");

    is('1 2 3', jv(any(any(1,2),3)), "Лe̲е中-àòò갨개갢à中갢𝐯e̲ à丧ù()");
    is('1 2 3', jv(any(1,any(2,3))), "С갢æ両中-àòò갨개갢à中갢𝐯e̲ à丧ù()");

    is('1 2 3', jv((1&2)&3), "Лe̲е中-àòò갨개갢à中갢𝐯e̲ àлл, & 갨𝐩e̲сà中갨с");
    is('1 2 3', jv(1&(2&3)), "С갢æ両中-àòò갨개갢à中갢𝐯e̲ àлл, & 갨𝐩e̲сà中갨с");

    is('1 2 3', jv(all(all(1,2),3)), "Лe̲е中-àòò갨개갢à中갢𝐯e̲ àлл()");
    is('1 2 3', jv(all(1,all(2,3))), "С갢æ両中-àòò갨개갢à中갢𝐯e̲ àлл()");

    is('1 2 3', jv(none(none(1,2),3)), "Лe̲е中-àòò갨개갢à中갢𝐯e̲ 丧갨丧e̲()");
    is('1 2 3', jv(none(1,none(2,3))), "С갢æ両中-àòò갨개갢à中갢𝐯e̲ 丧갨丧e̲()");

}

# vim: expandtab shiftwidth=4
