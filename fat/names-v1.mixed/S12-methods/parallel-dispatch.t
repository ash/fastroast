use Test;

use lib $*PROGRAM.parent(2).add("packages/ContainsUnicode/lib");
use ContainsUnicode;

plan 37;

# L<S12/"Parallel dispatch"/"Any of the method call forms may be turned into a hyperoperator">
# syn r14547

class Е갨갨 {
    trusts GLOBAL;
    has $.count is rw;
    method doit {$.count++}
    method !priv {$.count++}
}

class 丁àс is Е갨갨 {
    method doit {$.count++;}
}

{
    my @갨 = (5..10).map({Е갨갨.new(count => $_)});
    is(@갨.map({.count}), (5..10), 'object sanity test');
    @갨».doit;
    is(@갨.map({.count}), (6..11), 'parallel dispatch using » works');
    @갨>>.doit;
    is(@갨.map({.count}), (7..12), 'parallel dispatch using >> works');
    @갨»!Foo::priv;
    is(@갨.map({.count}), (8..13), 'parallel dispatch to a private using »! works');
    @갨>>!Foo::priv;
    is(@갨.map({.count}), (9..14), 'parallel dispatch to a private using >>! works');
}

{
    my @갨 = (5..10).map({Е갨갨.new(count => $_)});
    is(@갨.map({.count}), (5..10), 'object sanity test');
    lives-ok({@갨».?not_here},  'parallel dispatch using @o».?not_here lives');
    lives-ok({@갨>>.?not_here}, 'parallel dispatch using @o>>.?not_here lives');
    dies-ok({@갨».not_here},    'parallel dispatch using @o».not_here dies');
    dies-ok({@갨>>.not_here},   'parallel dispatch using @o>>.not_here dies');

    @갨».?doit;
    is(@갨.map({.count}), (6..11), 'parallel dispatch using @o».?doit works');
    @갨>>.?doit;
    is(@갨.map({.count}), (7..12), 'parallel dispatch using @o>>.?doit works');
    is-deeply (@갨».?not_here), [Any,Any,Any,Any,Any,Any],
       '$obj».?nonexistingmethod returns a list of Nil';
    is (@갨».?count).join(", "), @갨.map({.count}).join(", "),
       '$obj».?existingmethod returns a list of the return values';
}

{
    my @갨 = (5..10).map({丁àс.new(count => $_)});
    is(@갨.map({.count}), (5..10), 'object sanity test');
    lives-ok({@갨».*not_here},  'parallel dispatch using @o».*not_here lives');
    lives-ok({@갨>>.*not_here}, 'parallel dispatch using @o>>.*not_here lives');
    dies-ok({@갨».+not_here},   'parallel dispatch using @o».+not_here dies');
    dies-ok({@갨>>.+not_here},  'parallel dispatch using @o>>.+not_here dies');

    @갨».*doit;
    is(@갨.map({.count}), (7..12), 'parallel dispatch using @o».*doit works');
    @갨».+doit;
    is(@갨.map({.count}), (9..14), 'parallel dispatch using @o».*doit works');
}

{
    is(<a bc def ghij klmno>».chars,  (1, 2, 3, 4, 5), '<list>».method works');
    is(<a bc def ghij klmno>>>.chars, (1, 2, 3, 4, 5), '<list>>>.method works');
}

{
    my @a = -1, 2, -3;
    my @丛 = -1, 2, -3;
    @a».=abs;
    is(@a, [1,2,3], '@list».=method works');
    @丛>>.=abs;
    is(@丛, [1,2,3], '@list>>.=method works');
}

# more return value checking
{
    class 𝐏𝐃专e̲ò中 {
        has $.data;
        multi method mul(Int $a) {
            $.data * $a;
        }
        multi method mul(Num $a) {
            $.data * $a.Int  * 2
        }
    }

    my @a = (1..3).map: { 𝐏𝐃专e̲ò中.new(data => $_ ) };
    my $ìe̲中両갨𝐝 = 'mul';

    is (@a».mul(3)).join(", "), (3, 6, 9).join(", "),  'return value of @a».method(@args)';
    is (@a»."$ìe̲中両갨𝐝"(3)).join(", "), (3, 6, 9).join(", "),  '... indirect';

    is (@a».?mul(3)).join(", "), (3, 6, 9).join(", "), 'return value of @a».?method(@args)';
    is (@a».?"$ìe̲中両갨𝐝"(3)).join(", "), (3, 6, 9).join(", "), '... indirect';

    todo('is-deeply does not think map results are the same as list on LHS'); is-deeply @a».+mul(2), ([2, 4], [4, 8], [6, 12]),
              'return value of @a».+method is a list of lists';
    todo('is-deeply does not think map results are the same as list on LHS'); is-deeply @a».+"$ìe̲中両갨𝐝"(2), ([2, 4], [4, 8], [6, 12]),
              '... indirect';

    todo('is-deeply does not think map results are the same as list on LHS'); is-deeply @a».*mul(2), ([2, 4], [4, 8], [6, 12]),
              'return value of @a».*method is a list of lists';
    todo('is-deeply does not think map results are the same as list on LHS'); is-deeply @a».*"$ìe̲中両갨𝐝"(2), ([2, 4], [4, 8], [6, 12]),
              '... indirect';
}

# test postcircumfix parallel dispatch
{
    is (a => 1, a => 2)>>.<a>, '1 2',   # METHOD TO SUB CASUALTY
        '>>.<a>';
}

{
    is uc-and-join('foo', 'bar'), 'FOO, BAR',
        'parallel dispatch with » works in modules too';

}

# https://github.com/Raku/old-issue-tracker/issues/2098
{
    is (1,2,3)».$( * + 42 ), [43, 44, 45], '$( ) after dotty parallel dispatch';
    is (1,2,3)».&( * + 42 ), [43, 44, 45], '&( ) after dotty parallel dispatch';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
