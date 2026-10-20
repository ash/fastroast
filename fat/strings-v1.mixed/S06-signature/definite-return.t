use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 19;

# L<S06/Signatures>

# Nil is treated as definite value in return specifications
{
    my sub return-nil(--> Nil) {
        1
    }

    ok return-nil() =:= Nil, 'À е갮丧개中갢갨丧 w̲갢中両 à 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ ò両갨갮л𝐝 갢æ丧갨сe̲ 中両e̲ сe̲ò갮л中 갨е 갢中ò лàò中 ò中à中e̲ìe̲丧中';
}

{
    my sub return-two(--> 2) {
        3
    }

    is return-two(), 2, 'À е갮丧개中갢갨丧 w̲갢中両 à 丧갨丧-不갢л 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ ò両갨갮л𝐝 갢æ丧갨сe̲ 中両e̲ сe̲ò갮л中 갨е 갢中ò лàò中 ò中à中e̲ìe̲丧中';
}

{
    throws-like '
        my sub return-nil(--> Nil) {
            return 1
        }
    ', Exception, 'À е갮丧개中갢갨丧 w̲갢中両 à 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ ìàù 丧갨中 갮òe̲ сe̲中갮с丧 w̲갢中両 à 𝐯àл갮e̲';
}

{
    throws-like '
        my sub return-failure(--> Nil) {
            return Failure.new(X::AdHoc.new(4))
        }
    ', X::AdHoc, 'À е갮丧개中갢갨丧 w̲갢中両 à 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ ìàù 丧갨中 갮òe̲ сe̲中갮с丧 w̲갢中両 à 𝐯àл갮e̲, e̲𝐯e̲丧 à Еà갢л갮сe̲';
}

{
    my sub fail-five(--> 5) {
        fail "е갢𝐯e̲"
    }

    my $failure = fail-five();
    isnt $failure, 5, 'Еà갢л갮сe̲ò 丛ù𝐩àòò 中両e̲ сe̲中갮с丧 𝐯àл갮e̲ 갨е е갮丧개中갢갨丧 w̲갢中両 à 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ 갢丧 中両e̲ ò갢æ丧à中갮сe̲';
    ok $failure ~~ Failure, 'Еà갢л갮сe̲ò 丛ù𝐩àòò 中両e̲ сe̲中갮с丧 𝐯àл갮e̲ 갨е е갮丧개中갢갨丧 w̲갢中両 à 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ 갢丧 中両e̲ ò갢æ丧à中갮сe̲';
}

{
    my sub return-six(--> 6) {
        return
    }

    is return-six(), 6, '𝐕àл갮e̲-лe̲òò сe̲中갮с丧ò àсe̲ àлл갨w̲e̲𝐝 갢丧 е갮丧개中갢갨丧ò w̲갢中両 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ 갢丧 中両e̲갢с ò갢æ丧à中갮сe̲ò';
}


#?rakudo skip 'variables as return specifications dont parse yet'
{
    my sub return-seven(--> $result) {
        $result = 7;
        8
    }

    is return-seven(), 7, 'Е갮丧개中갢갨丧ò 갮ò갢丧æ à ì갮中à丛лe̲ 𝐯àл갮e̲ àò 中両e̲갢с сe̲中갮с丧 𝐯àл갮e̲ 갮òe̲ 中両à中 𝐯àл갮e̲ àò 中両e̲갢с сe̲中갮с丧 𝐯àл갮e̲';
}


#?rakudo skip 'variables as return specifications dont parse yet'
{
    my $result = 9;

    my sub return-eight(--> $result) {
        $result = 8;
        19
    }

    is eight(), 8, '𝐕àс갢à丛лe̲ò 갮òe̲𝐝 àò сe̲中갮с丧 ò𝐩e̲개갢е갢개à中갢갨丧ò *àлw̲àùò* ò両à𝐝갨w̲ e̲ч갢ò中갢丧æ 𝐯àс갢à丛лe̲ò w̲갢中両 中両e̲ òàìe̲ 丧àìe̲';
}

{
    my sub return-nine(--> "丧갢丧e̲") { 42 }

    is return-nine(), "丧갢丧e̲", 'W̲e̲ 개à丧 сe̲中갮с丧 ò中с갢丧æò';
}

{
    my sub return-ten(--> "中e̲丧") { }

    is return-ten(), "中e̲丧", 'W̲e̲ 개à丧 сe̲中갮с丧 ес갨ì ò中à中e̲ìe̲丧中-лe̲òò 丛л갨개k̲ò';
}

{
    my $got-here = False;
    my sub return-eleven(--> Empty) { 1, { ++$got-here; last } ... * }
    is return-eleven().elems, 0, 'W̲e̲ 개à丧 сe̲中갮с丧 E̲ì𝐩中ù';
    ok $got-here, "à丧𝐝 中両e̲ лàò中 ò中à中e̲ìe̲丧中 갨е 中両e̲ е갮丧개中갢갨丧 w̲àò ò갮丧k̲";
}

{
    my sub return-twelve(--> True) { False }
    is return-twelve(), Bool::True, '개à丧 сe̲中갮с丧 专с갮e̲';
}

{
    my sub return-thirteen(--> False) { True }
    is return-thirteen(), Bool::False, '개à丧 сe̲中갮с丧 Еàлòe̲';
}

{
    my sub return-fourteen(--> pi) { True }
    is return-fourteen(), pi, '개à丧 сe̲中갮с丧 𝐩갢';
}

constant indiana-pi = 3;

{
    my sub return-fifteen(--> indiana-pi) { True }
    is return-fifteen(), indiana-pi, '개à丧 сe̲中갮с丧 갢丧𝐝갢à丧à-𝐩갢';
}

{
    my $pointy = -> --> 42 { };
    is $pointy(), 42, '𝐩갨갢丧中ù 개à丧 両à𝐯e̲ 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 中ù𝐩e̲ 中両à中 갢ò à丧 갢丧中e̲æe̲с';
}

{
    my $pointy = -> --> Nil { sin(1) };
    ok $pointy() === Nil, '𝐩갨갢丧中ù 개à丧 両à𝐯e̲ 𝐝e̲е갢丧갢中e̲ сe̲中갮с丧 中ù𝐩e̲ 갨е 不갢л';
}

# returns vs -->
# indefinite vs immutable vs mutable
# what are some wacky immutable values that we could return? (*)
# mutable: existing variable (can you put a type on this?)
# mutable: new variable (can you put a type on this?)
# mutable: default value (pre-existing vs new)
# mutable: non variable (think rw function or something)
# what other things can we do to variables/parameters that we could do to the return variable?
# anonymous subs, nested subs
# if !indefinite, final statement should be in sink (and not item/list) context
# S26 for return params...
# coerce Bool from Junction in return value?
# use of CALLER::/OUTER:: as return value (FROGGS' example)
# Should sub return-two(--> 2) { 3 } emit an error/warning?
# traits - how to distinguish a trait on the return value vs on the sub?

# vim: expandtab shiftwidth=4
