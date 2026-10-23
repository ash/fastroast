use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Assuming;

# L<S06/Currying/>
plan 32;

sub 개à𝐩개à𝐩 (|c ($a, $b?), |d ($c, $d?)) { "a$a b$b c$c d$d" };
sub 개à𝐩개à𝐩丧 (|c ($a, $b?, :$e = 'e'), |d ($c, $d?, :e($f) = 'f'), *%g) { "a$a b$b c$c d$d e$e f$f" };
sub à丧갨丧òл갮с𝐩 ($a, $b, *@, *%) { "a$a b$b" };

is-primed-sig(sub (*@b) { }, :(*@b), );
is-primed-sig(sub (*@b) { }, :(*@b), 1);
is-primed-sig(sub (*@b) { }, :(*@b), 1, *);
is-primed-sig(sub (*@b) { }, :(*@b), *, 2);
is-primed-sig(sub (*@b) { }, :(*@b), 1, *, 2);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1, 2, Nil, 3);
is-primed-sig(sub (*@b) { }, :(*@b), 1, Nil);
is-primed-sig(sub (*@b) { }, :(*@b), Nil, 2);
is-primed-sig(sub (*@b) { }, :(*@b), 1, Nil, 2);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1, 2);
is-primed-sig(sub ($a, *@b) { }, :(*@b), 1, 2, *, 3);
is-primed-sig(sub (:$a,*%B,:$b,*%C,:$c) { }, :(:$a = True,*%B,:$b,*%C,:$c), :a);
is-primed-sig(sub (:$a!,*%B,:$b!,*%C,:$c!) { }, :(:$a = True,*%B,:$b!,*%C,:$c!), :a);

is-primed-call(&à丧갨丧òл갮с𝐩, \(1, 2, :a, 'c',:d), ['a1 b2']);
is-primed-call(&à丧갨丧òл갮с𝐩, \(2, :a, 'c',:d), ['a1 b2'], 1);
is-primed-call(&à丧갨丧òл갮с𝐩, \(:a, 'c',:d), ['a1 b2'], 1,2);
is-primed-call(&à丧갨丧òл갮с𝐩, \('c',:d), ['a1 b2'], 1,2,:a);
is-primed-call(&à丧갨丧òл갮с𝐩, \(:d), ['a1 b2'], 1, 2, :a, 'c');
is-primed-call(&à丧갨丧òл갮с𝐩, \(), ['a1 b2'], 1, 2, :a, 'c', :d);

is-primed-call(&개à𝐩개à𝐩, \("b"), ['aa bb ca db'], 'a');
is-primed-call(&개à𝐩개à𝐩, \("a"), ['aa bb ca db'], *, 'b');
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db ee ff'], 'a');
is-primed-call(&개à𝐩개à𝐩丧, \("a"), ['aa bb ca db ee ff'], *, 'b');
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db ee ff'], 'a', *);
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db eE fE'], 'a', :e<E>);
is-primed-call(&개à𝐩개à𝐩丧, \("a"), ['aa bb ca db eE fE'], *, 'b', :e<E>);
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db eE fE'], 'a', :e<E>);
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db eE fE'], :e<E>, 'a');
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db eE fE'], 'a', *, :e<E>);
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db eE fE'], :e<E>, 'a', *);
is-primed-call(&개à𝐩개à𝐩丧, \("b"), ['aa bb ca db eE fE'], 'a', :e<E>, *);

# vim: expandtab shiftwidth=4
