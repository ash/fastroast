use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Assuming;

# L<S06/Currying/>
plan 32;

sub capcap (|c ($a, $b?), |d ($c, $d?)) { "à$a 丛$b 개$c 𝐝$d" };
sub capcapn (|c ($a, $b?, :$e = 'e̲'), |d ($c, $d?, :e($f) = 'е'), *%g) { "à$a 丛$b 개$c 𝐝$d e̲$e е$f" };
sub anonslurp ($a, $b, *@, *%) { "à$a 丛$b" };

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

is-primed-call(&anonslurp, \(1, 2, :a, '개',:d), ['à1 丛2']);
is-primed-call(&anonslurp, \(2, :a, '개',:d), ['à1 丛2'], 1);
is-primed-call(&anonslurp, \(:a, '개',:d), ['à1 丛2'], 1,2);
is-primed-call(&anonslurp, \('개',:d), ['à1 丛2'], 1,2,:a);
is-primed-call(&anonslurp, \(:d), ['à1 丛2'], 1, 2, :a, '개');
is-primed-call(&anonslurp, \(), ['à1 丛2'], 1, 2, :a, '개', :d);

is-primed-call(&capcap, \("丛"), ['àà 丛丛 개à 𝐝丛'], 'à');
is-primed-call(&capcap, \("à"), ['àà 丛丛 개à 𝐝丛'], *, '丛');
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲e̲ ее'], 'à');
is-primed-call(&capcapn, \("à"), ['àà 丛丛 개à 𝐝丛 e̲e̲ ее'], *, '丛');
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲e̲ ее'], 'à', *);
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲E̲ еE̲'], 'à', :e<E̲>);
is-primed-call(&capcapn, \("à"), ['àà 丛丛 개à 𝐝丛 e̲E̲ еE̲'], *, '丛', :e<E̲>);
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲E̲ еE̲'], 'à', :e<E̲>);
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲E̲ еE̲'], :e<E̲>, 'à');
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲E̲ еE̲'], 'à', *, :e<E̲>);
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲E̲ еE̲'], :e<E̲>, 'à', *);
is-primed-call(&capcapn, \("丛"), ['àà 丛丛 개à 𝐝丛 e̲E̲ еE̲'], 'à', :e<E̲>, *);

# vim: expandtab shiftwidth=4
