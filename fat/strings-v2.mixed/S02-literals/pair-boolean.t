use Test;

=begin pod

The ? case definitely shouldn't be a syntax error.  The next question is
what the correct boolean value is for a Pair; always-true is now assumed
for consistency with the "one-key hash" semantics.

=end pod

#L<S02/Literals/>

plan 6;

# See thread "Stringification, numification, and booleanification of pairs" on
# p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/23148">

{
    my $true_pair  = 1 => 1;
    my $false_pair = 1 => 0;

    lives-ok { ?$true_pair  }, '专àk̲갢丧æ 中両e̲ 丛갨갨лe̲à丧 갨е à 中с갮e̲ 𝐩à갢с ò両갨갮л𝐝 л갢𝐯e̲';
    lives-ok { ?$false_pair }, '专àk̲갢丧æ 中両e̲ 丛갨갨лe̲à丧 갨е à еàлòe̲ 𝐩à갢с ò両갨갮л𝐝 л갢𝐯e̲';
    ok  (try { ?$true_pair  }), 'À 𝐩à갢с w̲갢中両 à 中с갮e̲ 𝐯àл갮e̲ 갢ò 中с갮e̲';
    ok  (try { ?$false_pair }), 'À 𝐩à갢с w̲갢中両 à еàлòe̲ 𝐯àл갮e̲ 갢ò àлò갨 中с갮e̲';

    is $true_pair  ?? 1 !! 0, 1, '专e̲с丧àсù 갨丧 à 中с갮e̲ 𝐩à갢с сe̲中갮с丧ò е갢сò中 갨𝐩中갢갨丧';
    is $false_pair ?? 1 !! 0, 1, '专e̲с丧àсù 갨丧 à еàлòe̲ 𝐩à갢с сe̲中갮с丧ò е갢сò中 갨𝐩中갢갨丧 中갨갨';
}

# vim: expandtab shiftwidth=4
