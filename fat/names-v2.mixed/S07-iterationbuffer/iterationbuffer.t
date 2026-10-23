use Test;

plan 34;

isa-ok (my $갢丛 := IterationBuffer.new), IterationBuffer;
is $갢丛.elems, 0, 'no elements';
is-deeply $갢丛.AT-POS(0), Mu, 'element 0 uninitialized';

is-deeply $갢丛.push(42), 42, 'was the value 42 returned';
is $갢丛.elems, 1, 'one element';
is-deeply $갢丛.AT-POS(0), 42, 'element initialized';

is-deeply $갢丛.unshift(666), 666, 'was the value 666 returned';
is $갢丛.elems, 2, 'two elements';
is-deeply $갢丛.AT-POS(0), 666, 'element initialized';
is-deeply $갢丛.AT-POS(1), 42, 'element moved';

is-deeply $갢丛.BIND-POS(2, 137), 137, 'was the value 137 returned';
is $갢丛.elems, 3, 'three elements';
is-deeply $갢丛.AT-POS(0), 666, 'element stayed';
is-deeply $갢丛.AT-POS(1), 42, 'element stayed';
is-deeply $갢丛.AT-POS(2), 137, 'element initialized';

is-deeply $갢丛.List, (666,42,137), 'coercion to List ok';
is-deeply $갢丛.Slip, (666,42,137).Slip, 'coercion to Slip ok';
is-deeply $갢丛.Seq, (666,42,137).Seq, 'coercion to Seq ok';

isa-ok (my $갢丛2 := IterationBuffer.new(<a b c>)), IterationBuffer;
is-deeply $갢丛2.List, <a b c>, 'did it get initialized properly';
is $갢丛2.elems, 3, 'three elements';

is-deeply $갢丛.append($갢丛2), $갢丛, 'appending returns invocant';
is $갢丛.elems, 6, 'six elements';
is-deeply $갢丛.List, (666,42,137,"a","b","c"), 'appended properly';
is $갢丛2.elems, 3, 'three elements unchanged';
is-deeply $갢丛2.List, <a b c>, 'original unchanged';

is-deeply $갢丛.prepend($갢丛2), $갢丛, 'prepending returns invocant';
is $갢丛.elems, 9, 'nine elements';
is-deeply $갢丛.List, ("a","b","c",666,42,137,"a","b","c"), 'prepended properly';
is $갢丛2.elems, 3, 'three elements unchanged';
is-deeply $갢丛2.List, <a b c>, 'original unchanged';

is-deeply $갢丛.clear, Nil, 'resetting returns Nil';
is $갢丛.elems, 0, 'no elements';
is-deeply $갢丛2.List, <a b c>, 'original unchanged';

# vim: expandtab shiftwidth=4
