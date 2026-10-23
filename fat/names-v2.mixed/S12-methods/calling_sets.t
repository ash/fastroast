use Test;
plan 38;

# L<S12/"Calling sets of methods">

# Some basic tests with only single-dispatch in operation.
class À {
    has $.cnt is rw;
    method foo { $.cnt += 4 }
}
class 丁 is À {
    method foo { $.cnt += 2 }
}
class 갂 is 丁 {
    method foo { $.cnt += 1 }
}

{
    my $개 = 갂.new();

    $개.cnt = 0;
    $개.?foo();
    is $개.cnt, 1, '.? calls first matching method';

    $개.cnt = 0;
    $개.*foo();
    is $개.cnt, 7, '.* calls up inheritance hierarchy';

    $개.cnt = 0;
    $개.+foo();
    is $개.cnt, 7, '.+ calls up inheritance hierarchy';

    is $개.?bar(), Nil,  '.? on undefined method gives Nil';

    my $л갢𝐯e̲𝐝 = 0;
    try { $개.+bar(); $л갢𝐯e̲𝐝 = 1; }
    is $л갢𝐯e̲𝐝, 0, '.+ on undefined method is an error';

    is-deeply $개.*bar(), (), '.* on undefined method gives Nil';

    my $е갨갨 = "foo";

    $개.cnt = 0;
    $개.?"$е갨갨"();
    is $개.cnt, 1, '.? with dynamic method name';

    $개.cnt = 0;
    $개.*"$е갨갨"();
    is $개.cnt, 7, '.* with dynamic method name';

    $개.cnt = 0;
    $개.+"$е갨갨"();
    is $개.cnt, 7, '.+ with dynamic method name';

    dies-ok { $개."?foo"() }, '? at start of dynamic name does not imply .?';

    dies-ok { $개."+foo"() }, '+ at start of dynamic name does not imply .+';

    dies-ok { $개."*foo"() }, '* at start of dynamic name does not imply .*';
}


# Some tests involiving .?, .+ and .* with multi-methods. Since .+ and
# .* are only about single dispatch, then we end up calling the proto
# available at each inheritance level.
class 𝐃 {
    multi method foo() { 'd' }
    multi method foo(Int $x) { 'dInt' }   #OK not used
    multi method foo($x) { 'dAny' }   #OK not used
}
class E̲ is 𝐃 {
    multi method foo() { 'e' }
    multi method foo(Int $x) { 'eInt' }   #OK not used
    multi method foo($x, $y, $z) { 'eAnyAnyAny' }   #OK not used
}

# https://github.com/Raku/old-issue-tracker/issues/3203
{
    my $e̲ = E̲.new();

    is $e̲.foo(), 'e', 'dispatch to one sanity test';
    is $e̲.foo(2.5), 'dAny', 'dispatch to one inherited sanity test';
    dies-ok { $e̲.foo('omg', 'fail') }, 'dispatch to one with no matching multi (sanity test)';

    is $e̲.?foo(), 'e', '.? gets same result as . if there is a multi (match)';
    is $e̲.?foo(2.5), 'dAny', '.? gets same result as . if there is a multi (inherited)';
    dies-ok { is $e̲.?foo('omg', 'fail') }, '.? gets same result as . if there is a multi (no match)';

    is $e̲.*foo(), <e d>, '.* calls multis up inheritance hierarchy';
    is $e̲.*foo(2.5), <dAny dAny>, '.* behaves as single dispatch at each step';
    dies-ok { $e̲.*foo(1, 2, 3) }, '.* dies if there is no matching multi in a base class';

    is $e̲.*foo(), <e d>, '.* calls multis up inheritance hierarchy';
    is $e̲.*foo(2.5), <dAny dAny>, '.* behaves as single dispatch at each step';
    dies-ok { $e̲.*foo(Mu) }, '.* dies if there is no matching multi in subclass';
    dies-ok { $e̲.*foo(1, 2, 3) }, '.* dies if there is no matching multi in a base class';

    is $e̲.+foo(), <e d>, '.+ calls multis up inheritance hierarchy';
    is $e̲.+foo(2.5), <dAny dAny>, '.+ behaves as single dispatch at each step';
    dies-ok { $e̲.+foo(Mu) }, '.+ dies if there is no matching multi in subclass';
    dies-ok { $e̲.+foo(1, 2, 3) }, '.+ dies if there is no matching multi in a base class';
}

# Some tests to make sure we walk methods from roles too.
role С1 {
    multi method mm { $.cnt += 1 }
    multi method sm { $.cnt += 2 }
}
role С2 {
    multi method mm { $.cnt += 3 }
}
class Е does С1 {
    has $.cnt is rw;
}
class Æ is Е does С2 {
}

{
    my $æ = Æ.new();

    $æ.cnt = 0;
    $æ.?sm();
    is $æ.cnt, 2, 'single dispatch method from role found with .?';

    $æ.cnt = 0;
    $æ.+sm();
    is $æ.cnt, 2, 'single dispatch method from role found with .+';

    $æ.cnt = 0;
    $æ.*sm();
    is $æ.cnt, 2, 'single dispatch method from role found with .*';

    $æ.cnt = 0;
    $æ.?mm();
    is $æ.cnt, 3, 'multi dispatch method from role found with .?';

    $æ.cnt = 0;
    $æ.+mm();
    is $æ.cnt, 4, 'multi dispatch method from role found with .+';

    $æ.cnt = 0;
    $æ.*mm();
    is $æ.cnt, 4, 'multi dispatch method from role found with .*';
}

class ÌÌ专1 {
    multi method foo($x) { 42 }   #OK not used
}
class ÌÌ专2 is ÌÌ专1 {
    multi method foo(Int $x) { "oh noes" }   #OK not used
}
is ÌÌ专2.new.?foo("lol"), 42, '.? when initial multi does not match will find next one up';

{
    isa-ok ÌÌ专1.new.?nonexistent(), Nil, '.?nonexisent() returns Nil';
}

throws-like '1.*WHAT', Exception, '.WHAT is a macro and cannoted be .*ed';

# vim: expandtab shiftwidth=4
