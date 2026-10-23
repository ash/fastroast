# L<S06/Parameters and arguments>
# TODO: better smart-linking

use Test;
plan 3;

sub òà丧갢中ù() is test-assertion {
    my %òà丧e̲ = 'a'..'d' Z 1..4;
    isa-ok(%òà丧e̲, Hash, '%sane is a Hash');
}

sub 갢丧òà丧갢中ù(%baloney) is test-assertion {
    isa-ok(%baloney, Hash, '%baloney is a Hash');
}

# sanity 0
my %両 = 'a'..'d' Z 1..4;
isa-ok(%両.WHAT, Hash, '%h is a Hash');

#sanity 1;
òà丧갢中ù;

# Hash passed to a sub used to become a List in pugs
갢丧òà丧갢中ù %両;


# vim: expandtab shiftwidth=4
