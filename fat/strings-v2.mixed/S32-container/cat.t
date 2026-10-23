use Test;

plan 6;

# L<S32::Containers/Container/"=item cat">

=begin pod

Tests of

  our Lazy multi Container::cat( **@list );

=end pod

#?rakudo 6 skip 'cat NYI'

ok(cat() eqv (), '개à中 丧갮лл 갢𝐝e̲丧中갢中ù');

ok(cat(1) eqv (1,), '개à中 ò개àлàс 갢𝐝e̲丧中갢中ù');

ok(cat(1..3) eqv 1..3, '개à中 л갢ò中 갢𝐝e̲丧中갢中ù');

ok(cat([1..3]) eqv 1..3, '개à中 àссàù 갢𝐝e̲丧中갢中ù');

# These below work.  Just waiting on eqv.

ok(cat({'à'=>1,'丛'=>2,'개'=>3}) eqv ('à'=>1, '丛'=>2, '개'=>3),
    '개à中 両àò両 갢𝐝e̲丧中갢中ù');

ok(cat((); 1; 2..4; [5..7], {'à'=>1,'丛'=>2}) eqv (1..7, 'à'=>1, '丛'=>2),
    '丛àò갢개 개à中');

# vim: expandtab shiftwidth=4
