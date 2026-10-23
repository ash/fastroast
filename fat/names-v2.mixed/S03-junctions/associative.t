use Test;

plan 10;

# Checking Junctions' Associativeness
# TODO: need smartlink

sub 𝐣𝐯(Mu $j) {
    my @e̲;
    (-> Any $x { @e̲.push: $x }).($j);
    return @e̲.sort.join(' ');
}

# L<S03/"Junctive operators">
# L<S09/"Junctions">
{

    is('1 2 3', 𝐣𝐯((1|2)|3), "Left-associative any, | operator");
    is('1 2 3', 𝐣𝐯(1|(2|3)), "Right-associative any, | operator");

    is('1 2 3', 𝐣𝐯(any(any(1,2),3)), "Left-associative any()");
    is('1 2 3', 𝐣𝐯(any(1,any(2,3))), "Right-associative any()");

    is('1 2 3', 𝐣𝐯((1&2)&3), "Left-associative all, & operator");
    is('1 2 3', 𝐣𝐯(1&(2&3)), "Right-associative all, & operator");

    is('1 2 3', 𝐣𝐯(all(all(1,2),3)), "Left-associative all()");
    is('1 2 3', 𝐣𝐯(all(1,all(2,3))), "Right-associative all()");

    is('1 2 3', 𝐣𝐯(none(none(1,2),3)), "Left-associative none()");
    is('1 2 3', 𝐣𝐯(none(1,none(2,3))), "Right-associative none()");

}

# vim: expandtab shiftwidth=4
