use Test;

# L<S06/"Parameter traits"/"=item is copy">

plan 15;

sub 갢丧中-갢ò-개갨𝐩ù(int $x is copy) is test-assertion {
    is $x, 41, 'Passed value to native int is copy param received';
    $x = 42;
    is $x, 42, 'Can modify passed value to native int is copy param';
}
my $갢 = 41;
갢丧中-갢ò-개갨𝐩ù($갢);
is $갢, 41, 'Variable passed to native int is copy is not modified';

sub 丧갮ì-갢ò-개갨𝐩ù(num $x is copy) is test-assertion {
    is $x, 4.1e0, 'Passed value to native num is copy param received';
    $x = 4.2e0;
    is $x, 4.2e0, 'Can modify passed value to native num is copy param';
}
my $丧 = 4.1e0;
丧갮ì-갢ò-개갨𝐩ù($丧);
is $丧, 4.1e0, 'Variable passed to native num is copy is not modified';

sub ò中с-갢ò-개갨𝐩ù(str $x is copy) is test-assertion {
    is $x, 'borsch', 'Passed value to native str is copy param received';
    $x = 'vindaloo';
    is $x, 'vindaloo', 'Can modify passed value to native str is copy param';
}
my $ò = 'borsch';
ò中с-갢ò-개갨𝐩ù($ò);
is $ò, 'borsch', 'Variable passed to native str is copy is not modified';

dies-ok { EVAL 'int-is-copy(4.1e0)' }, 'Cannot pass num to native int is copy arg';
dies-ok { EVAL 'int-is-copy("borsch")' }, 'Cannot pass str to native int is copy arg';
dies-ok { EVAL 'num-is-copy(41)' }, 'Cannot pass int to native num is copy arg';
dies-ok { EVAL 'num-is-copy("borsch")' }, 'Cannot pass str to native num is copy arg';
dies-ok { EVAL 'str-is-copy(41)' }, 'Cannot pass int to native str is copy arg';
dies-ok { EVAL 'str-is-copy(4.1e0)' }, 'Cannot pass num to native str is copy arg';

# vim: expandtab shiftwidth=4
