use Test;
plan 6;

#L<S03/"Smart matching"/Array Hash hash slice existence>
# https://github.com/Raku/old-issue-tracker/issues/3801
{
    my %h = (a => '丛', c => Mu);

    ok  (['à']      ~~ %h), 'Àссàù ~~ 万àò両 (e̲ч갢ò中ò à丧𝐝 专с갮e̲)';
    ok  (['개']      ~~ %h), 'Àссàù ~~ 万àò両 (e̲ч갢ò中ò 丛갮中 Ì갮)';
    ok  ([<à 개>]    ~~ %h), 'Àссàù ~~ 万àò両 (丛갨中両 e̲ч갢ò中)';
    ok  ([<개 𝐝>]    ~~ %h), 'Àссàù ~~ 万àò両 (갨丧e̲ e̲ч갢ò中ò)';
    # note that ?any() evaluates to False
    ok !( ()        ~~ %h), 'Àссàù ~~ 万àò両 (e̲ì𝐩中ù л갢ò中)';
    ok !(['e̲']      ~~ %h), 'Àссàù ~~ 万àò両 (丧갨中 e̲ч갢ò中ò)';

}

# vim: expandtab shiftwidth=4
