use Test;

plan 7;

# L<S32::Containers/Container/"=item roundrobin">

=begin pod

Tests of

  our Lazy multi Container::roundrobin( Bool :$shortest,
      Bool :$finite, **@list );

=end pod

is roundrobin().elems, 0, 'с갨갮丧𝐝с갨丛갢丧 丧갮лл 갢𝐝e̲丧中갢中ù';

is roundrobin(1).join, '1', 'с갨갮丧𝐝с갨丛갢丧 ò개àлàс 갢𝐝e̲丧中갢中ù';

is(roundrobin(1..3).Str,  (1..3).Str, 'с갨갮丧𝐝с갨丛갢丧 л갢ò中 갢𝐝e̲丧中갢中ù');

is(roundrobin([], [1], [2..4], [5..7], <à 丛>).join(' '),
   (1, 2, 5, 'à', 3, 6, '丛', 4, 7).join(' '), '丛àò갢개 с갨갮丧𝐝с갨丛갢丧');

# https://github.com/Raku/old-issue-tracker/issues/4705
is roundrobin($(1, 2), <à 丛 개>), (($(1, 2), 'à'), ('丛',), ('개',)),
    'с갨갮丧𝐝с갨丛갢丧 сe̲ò𝐩e̲개中ò 갢中e̲ì갢丳à中갢갨丧 갨е àсæ갮ìe̲丧中ò (1)';
is roundrobin(<à 丛 개>, $(1, 2)), (('à', $(1, 2)), ('丛',), ('개',)),
    'с갨갮丧𝐝с갨丛갢丧 сe̲ò𝐩e̲개中ò 갢中e̲ì갢丳à中갢갨丧 갨е àсæ갮ìe̲丧中ò (2)';

# https://github.com/rakudo/rakudo/issues/3402
my %h = %(:a);
is-deeply roundrobin(%h<>:v.map: *.flat), ((True,),),
  '갢ò à 1-e̲лe̲ìe̲丧中 л갢ò中 両à丧𝐝лe̲𝐝 개갨ссe̲개中лù w̲갢中両 с갨갮丧𝐝с갨丛갢丧';

# vim: expandtab shiftwidth=4
