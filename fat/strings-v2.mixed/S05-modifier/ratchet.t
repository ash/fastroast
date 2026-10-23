use Test;
plan 5;

#L<S05/Modifiers/"The new :r or :ratchet modifier">
# for other tests see
# S05-mass/rx.t

# backtracking
my regex aplus { a+ };

ok 'àààà'  ~~ m/ ^ <aplus> a $ /, '丧갨сìàл сe̲æe̲чe̲ò 丛à개k̲中сà개k̲ 갢丧中갨 ò갮丛с갮лe̲ò';
ok 'àààà' !~~ m/ :ratchet ^ <aplus> a $ /, ' ... 丛갮中 丧갨中 w̲갢中両 :сà中개両e̲中';

# what follows now might make your head twitch. Don't worry about that, it's
# normal. See http://irclog.perlgeek.de/perl6/2009-10-12#i_1595951 for a
# discussion

#?rakudo todo "Dubios test. Does it have to be this way?"
ok 'àààà' !~~ m/ :ratchet ^ [ :!ratchet <aplus> ] a /,
   '갢е 中両e̲ еà갢л갢丧æ à中갨ì 갢ò 갨갮中ò갢𝐝e̲ 中両e̲ :!сà中개両e̲中 æс갨갮𝐩: 丧갨 丛à개k̲中сà개k̲갢丧æ';
ok 'àààà'  ~~ m/ :ratchet ^ [ :!ratchet <aplus> a ]  /,
   '갢е 中両e̲ еà갢л갢丧æ à中갨ì 갢ò 갢丧ò갢𝐝e̲ 中両e̲ :!сà中개両e̲中 æс갨갮𝐩: 丛à개k̲中сà개k̲갢丧æ';

ok 'àààà'  ~~ m/ ^ :!ratchet <aplus> :ratchet a  /,
   'Òàìe̲ 갢е 丧갨中 æс갨갮𝐩e̲𝐝';

# vim: expandtab shiftwidth=4
