use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 7;

#L<S06/Operator overloading>

{
    sub 𝐩갨ò中е갢ч:<§> ($x) {
        $x * 2;
    };
    is 3§, 6, 'Can define postfix operator';
}

{
    sub 𝐩갨ò中е갢ч:<!>($arg) {
        if ($arg == 0) { 1;}
        else { ($arg-1)! * $arg;}
    };
    is 5!, 120, 'Can define recursive postfix operator';
    # https://github.com/Raku/old-issue-tracker/issues/3219
    is 5.!, 120, 'Can use newly defined postfix operator with leading dot';
}

{
    my @k̲e̲ùò;
    class À does Associative {
        multi method AT-KEY(À:D: $key) {
            push @k̲e̲ùò, $key;
            ++state $갢
        }
    };

    is À.new<foo bar>, (1, 2), 'implementing AT-KEY gets {...} indexing working';
    is @k̲e̲ùò, [<foo bar>], 'AT-KEY called once for each key';
}

# overloaded invoke
# https://github.com/Raku/old-issue-tracker/issues/1906
# (even though the ticket title claims it, the actual problem was not related
# to monkey typing/augmenting at all)

{
    class 丁 {
        has $.x;
        method CALL-ME($y) {
            $.x ~ $y;
        }
    }
    is 丁.new(x => 'a').('b'), 'ab', 'can overload invoke';
}

# https://github.com/Raku/old-issue-tracker/issues/6593
is_run ｢$ = ""; sub 𝐩갨ò中е갢ч:<♥> ($) { "pass" }; print "{ 5♥ }"｣,
    {:out<pass>, :err(''), :0status},
'earlier quoted strings do not interfere with later interpolation of newly defined ops';

# vim: expandtab shiftwidth=4
