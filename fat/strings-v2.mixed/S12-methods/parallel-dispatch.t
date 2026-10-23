use Test;

use lib $*PROGRAM.parent(2).add("packages/ContainsUnicode/lib");
use ContainsUnicode;

plan 37;

# L<S12/"Parallel dispatch"/"Any of the method call forms may be turned into a hyperoperator">
# syn r14547

class Foo {
    trusts GLOBAL;
    has $.count is rw;
    method doit {$.count++}
    method !priv {$.count++}
}

class Bar is Foo {
    method doit {$.count++;}
}

{
    my @o = (5..10).map({Foo.new(count => $_)});
    is(@o.map({.count}), (5..10), '갨丛𝐣e̲개中 òà丧갢中ù 中e̲ò中');
    @o».doit;
    is(@o.map({.count}), (6..11), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ » w̲갨сk̲ò');
    @o>>.doit;
    is(@o.map({.count}), (7..12), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ >> w̲갨сk̲ò');
    @o»!Foo::priv;
    is(@o.map({.count}), (8..13), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 中갨 à 𝐩с갢𝐯à中e̲ 갮ò갢丧æ »! w̲갨сk̲ò');
    @o>>!Foo::priv;
    is(@o.map({.count}), (9..14), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 中갨 à 𝐩с갢𝐯à中e̲ 갮ò갢丧æ >>! w̲갨сk̲ò');
}

{
    my @o = (5..10).map({Foo.new(count => $_)});
    is(@o.map({.count}), (5..10), '갨丛𝐣e̲개中 òà丧갢中ù 中e̲ò中');
    lives-ok({@o».?not_here},  '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o».?丧갨中_両e̲сe̲ л갢𝐯e̲ò');
    lives-ok({@o>>.?not_here}, '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o>>.?丧갨中_両e̲сe̲ л갢𝐯e̲ò');
    dies-ok({@o».not_here},    '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o».丧갨中_両e̲сe̲ 𝐝갢e̲ò');
    dies-ok({@o>>.not_here},   '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o>>.丧갨中_両e̲сe̲ 𝐝갢e̲ò');

    @o».?doit;
    is(@o.map({.count}), (6..11), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o».?𝐝갨갢中 w̲갨сk̲ò');
    @o>>.?doit;
    is(@o.map({.count}), (7..12), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o>>.?𝐝갨갢中 w̲갨сk̲ò');
    is-deeply (@o».?not_here), [Any,Any,Any,Any,Any,Any],
       '$obj».?丧갨丧e̲ч갢ò中갢丧æìe̲中両갨𝐝 сe̲中갮с丧ò à л갢ò中 갨е 不갢л';
    is (@o».?count).join(", "), @o.map({.count}).join(", "),
       '$obj».?e̲ч갢ò中갢丧æìe̲中両갨𝐝 сe̲中갮с丧ò à л갢ò中 갨е 中両e̲ сe̲中갮с丧 𝐯àл갮e̲ò';
}

{
    my @o = (5..10).map({Bar.new(count => $_)});
    is(@o.map({.count}), (5..10), '갨丛𝐣e̲개中 òà丧갢中ù 中e̲ò中');
    lives-ok({@o».*not_here},  '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o».*丧갨中_両e̲сe̲ л갢𝐯e̲ò');
    lives-ok({@o>>.*not_here}, '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o>>.*丧갨中_両e̲сe̲ л갢𝐯e̲ò');
    dies-ok({@o».+not_here},   '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o».+丧갨中_両e̲сe̲ 𝐝갢e̲ò');
    dies-ok({@o>>.+not_here},  '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o>>.+丧갨中_両e̲сe̲ 𝐝갢e̲ò');

    @o».*doit;
    is(@o.map({.count}), (7..12), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o».*𝐝갨갢中 w̲갨сk̲ò');
    @o».+doit;
    is(@o.map({.count}), (9..14), '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 갮ò갢丧æ @o».*𝐝갨갢中 w̲갨сk̲ò');
}

{
    is(<à 丛개 𝐝e̲е æ両갢𝐣 k̲лì丧갨>».chars,  (1, 2, 3, 4, 5), '<л갢ò中>».ìe̲中両갨𝐝 w̲갨сk̲ò');
    is(<à 丛개 𝐝e̲е æ両갢𝐣 k̲лì丧갨>>>.chars, (1, 2, 3, 4, 5), '<л갢ò中>>>.ìe̲中両갨𝐝 w̲갨сk̲ò');
}

{
    my @a = -1, 2, -3;
    my @b = -1, 2, -3;
    @a».=abs;
    is(@a, [1,2,3], '@list».=ìe̲中両갨𝐝 w̲갨сk̲ò');
    @b>>.=abs;
    is(@b, [1,2,3], '@list>>.=ìe̲中両갨𝐝 w̲갨сk̲ò');
}

# more return value checking
{
    class PDTest {
        has $.data;
        multi method mul(Int $a) {
            $.data * $a;
        }
        multi method mul(Num $a) {
            $.data * $a.Int  * 2
        }
    }

    my @a = (1..3).map: { PDTest.new(data => $_ ) };
    my $method = 'mul';

    is (@a».mul(3)).join(", "), (3, 6, 9).join(", "),  'сe̲中갮с丧 𝐯àл갮e̲ 갨е @a».ìe̲中両갨𝐝(@args)';
    is (@a»."$method"(3)).join(", "), (3, 6, 9).join(", "),  '... 갢丧𝐝갢сe̲개中';

    is (@a».?mul(3)).join(", "), (3, 6, 9).join(", "), 'сe̲中갮с丧 𝐯àл갮e̲ 갨е @a».?ìe̲中両갨𝐝(@args)';
    is (@a».?"$method"(3)).join(", "), (3, 6, 9).join(", "), '... 갢丧𝐝갢сe̲개中';

    #?rakudo 4 todo 'is-deeply does not think map results are the same as list on LHS'
    is-deeply @a».+mul(2), ([2, 4], [4, 8], [6, 12]),
              'сe̲中갮с丧 𝐯àл갮e̲ 갨е @a».+ìe̲中両갨𝐝 갢ò à л갢ò中 갨е л갢ò中ò';
    is-deeply @a».+"$method"(2), ([2, 4], [4, 8], [6, 12]),
              '... 갢丧𝐝갢сe̲개中';

    is-deeply @a».*mul(2), ([2, 4], [4, 8], [6, 12]),
              'сe̲中갮с丧 𝐯àл갮e̲ 갨е @a».*ìe̲中両갨𝐝 갢ò à л갢ò中 갨е л갢ò中ò';
    is-deeply @a».*"$method"(2), ([2, 4], [4, 8], [6, 12]),
              '... 갢丧𝐝갢сe̲개中';
}

# test postcircumfix parallel dispatch
{
    is (a => 1, a => 2)>>.<à>, '1 2',   # METHOD TO SUB CASUALTY
        '>>.<à>';
}

{
    is uc-and-join('е갨갨', '丛àс'), 'Е갎갎, 丁ÀС',
        '𝐩àсàллe̲л 𝐝갢ò𝐩à中개両 w̲갢中両 » w̲갨сk̲ò 갢丧 ì갨𝐝갮лe̲ò 中갨갨';

}

# https://github.com/Raku/old-issue-tracker/issues/2098
{
    is (1,2,3)».$( * + 42 ), [43, 44, 45], '$( ) àе中e̲с 𝐝갨中中ù 𝐩àсàллe̲л 𝐝갢ò𝐩à中개両';
    is (1,2,3)».&( * + 42 ), [43, 44, 45], '&( ) àе中e̲с 𝐝갨中中ù 𝐩àсàллe̲л 𝐝갢ò𝐩à中개両';
}

# vim: expandtab shiftwidth=4
