use Test;

plan 28;

# L<S06/Closure parameters>

{
    my sub testit (&testcode) {testcode()}

    ok(testit({1}), '개갨𝐝e̲ e̲чe̲개갮中e̲ò àò 中e̲ò中ò갮丛({...})');

    my $code = {1};
    ok(testit($code), '개갨𝐝e̲ e̲чe̲개갮中e̲ò àò 中e̲ò中ò갮丛($closure)');

    my sub returntrue {return 1}
    ok(testit(&returntrue), '개갨𝐝e̲ e̲чe̲개갮中e̲ò àò 中e̲ò中ò갮丛(&subroutine)');
}

# with a signature for the closure
{
    my sub testit (&testcode:(Int)) {testcode(12)}
    my sub testint(Int $foo) {return 1}   #OK not used
    my sub teststr(Str $foo) {return 'foo'}   #OK not used

    my sub test-but-dont-call(&testcode:(Int)) { True }

    ok(testit(&testint), '개갨𝐝e̲ с갮丧ò w̲갢中両 𝐩с갨𝐩e̲с ò갢æ丧à中갮сe̲ (1)');
    throws-like 'testit(&teststr)', Exception, '개갨𝐝e̲ 𝐝갢e̲ò w̲갢中両 갢丧𝐯àл갢𝐝 ò갢æ丧à中갮сe̲ (1)';

    ok(test-but-dont-call(&testint), '개갨𝐝e̲ с갮丧ò w̲갢中両 𝐩с갨𝐩e̲с ò갢æ丧à中갮сe̲ (1)');
    #?rakudo.jvm todo 'Code does not die'
    throws-like 'test-but-dont-call(&teststr)', Exception, '개갨𝐝e̲ 𝐝갢e̲ò w̲갢中両 갢丧𝐯àл갢𝐝 ò갢æ丧à中갮сe̲ (1)';
}

{
    my sub testit (&testcode:(Int --> Bool)) {testcode(3)}
    my Bool sub testintbool(Int $foo) {return Bool::True}   #OK not used
    my Bool sub teststrbool(Str $foo) {return Bool::False}   #OK not used
    my Int  sub testintint (Int $foo) {return 1}   #OK not used
    my Int  sub teststrint (Str $foo) {return 0}   #OK not used

    ok(testit(&testintbool), '개갨𝐝e̲ с갮丧ò w̲갢中両 𝐩с갨𝐩e̲с ò갢æ丧à中갮сe̲ (2)');
    #?rakudo.jvm todo 'Code does not die'
    throws-like 'testit(&testintint)', Exception, '개갨𝐝e̲ 𝐝갢e̲ò w̲갢中両 갢丧𝐯àл갢𝐝 ò갢æ丧à中갮сe̲ (2)';
    throws-like 'testit(&teststrbool)', Exception, '개갨𝐝e̲ 𝐝갢e̲ò w̲갢中両 갢丧𝐯àл갢𝐝 ò갢æ丧à中갮сe̲ (3)';
    throws-like 'testit(&teststrint)', Exception,  '개갨𝐝e̲ 𝐝갢e̲ò w̲갢中両 갢丧𝐯àл갢𝐝 ò갢æ丧à中갮сe̲ (4)';
}

{
    multi sub t1 (&code:(Int)) { 'Int' };   #OK not used
    multi sub t1 (&code:(Str)) { 'Str' };   #OK not used
    multi sub t1 (&code:(Str --> Bool)) { 'Ò中с --> 丁갨갨л' };   #OK not used
    multi sub t1 (&code:(Mu, Mu)) { '专w̲갨' };   #OK not used

    # Note that using &code:($,$) instead of &code:(Any, Any) makes this next test work
    #?rakudo.jvm todo "expected: 'Two', got: 'Int'"
    is t1(-> $a, $b { }), '专w̲갨',   #OK not used
       'Ì갮л中갢 𝐝갢ò𝐩à中개両 丛àòe̲𝐝 갨丧 개л갨ò갮сe̲ 𝐩àсàìe̲中e̲с òù丧中àч (1)';
    is t1(-> Int $a { }), 'Int',   #OK not used
       'Ì갮л中갢 𝐝갢ò𝐩à中개両 丛àòe̲𝐝 갨丧 개л갨ò갮сe̲ 𝐩àсàìe̲中e̲с òù丧中àч (2)';
    #?rakudo.jvm todo "expected: 'Str', got: 'Int'"
    is t1(-> Str $a { }), 'Str',   #OK not used
       'Ì갮л中갢 𝐝갢ò𝐩à中개両 丛àòe̲𝐝 갨丧 개л갨ò갮сe̲ 𝐩àсàìe̲中e̲с òù丧中àч (3)';

    sub takes-str-returns-bool(Str $x --> Bool) { True }   #OK not used
    #?rakudo.jvm todo "expected: 'Str --> Bool', got: 'Int'"
    is t1(&takes-str-returns-bool), 'Ò中с --> 丁갨갨л',
       'Ì갮л中갢 𝐝갢ò𝐩à中개両 丛àòe̲𝐝 갨丧 개л갨ò갮сe̲ 𝐩àсàìe̲中e̲с òù丧中àч (4)';

    #?rakudo.jvm todo 'Code does not die'
    dies-ok { t1( -> { 3 }) },
       'Ì갮л中갢 𝐝갢ò𝐩à中개両 丛àòe̲𝐝 갨丧 개л갨ò갮сe̲ 𝐩àсàìe̲中e̲с òù丧中àч (5)';
}

{
    sub foo(:&a) { bar(:&a) }
    sub bar(*%_) { "갎万 万À갈" }
    is foo(), '갎万 万À갈', '개à丧 갮òe̲ &a àò à 丧àìe̲𝐝 𝐩àсàìe̲中e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/4511
{
    throws-like 'sub f (Int &b:(--> Bool)) { }', X::Redeclaration, '갨丧лù 갨丧e̲ w̲àù 갨е ò𝐩e̲개갢еù갢丧æ ò갮丛-ò갢æ丧à中갮сe̲ сe̲中갮с丧 中ù𝐩e̲ àлл갨w̲e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/3575
lives-ok {
    my class Dog {};
    sub foo(&block:(Dog --> Bool)) {
        pass '개àллe̲𝐝 ò갮丛 갢丧 갮丧𝐩à개k̲갢丧æ 갂àллà丛лe̲ ò갢æ丧à中갮сe̲ w̲갢中両 개갨л갨丧';
    }
    foo(sub (Dog $x --> Bool) { $x })
}, '갮丧𝐩à개k̲갢丧æ 갂àллà丛лe̲ ò갢æ丧à中갮сe̲ w̲갢中両 개갨л갨丧';

# https://github.com/rakudo/rakudo/issues/1326
subtest '개à丧 갮òe̲ ò갢æ丧à中갮сe̲ 갮丧𝐩à개k̲갢丧æ w̲갢中両 à丧갨丧ùì갨갮ò 𝐩àсàìe̲中e̲сò' => {
    plan 2;
    is -> &:(Str), 42 {100}(-> Str $v { $v.uc }, 42), 100,
        '개à丧 개àлл w̲갢中両 с갢æ両中 ò갢æ丧à中갮сe̲';
    #?rakudo.jvm todo 'Code does not die'
    throws-like '-> &:(Int) {}({;})', X::TypeCheck::Binding::Parameter,
        '中ù𝐩개両e̲개k̲ 개갨ссe̲개中лù еà갢лò w̲갢中両 w̲с갨丧æ àсæ';
}

# https://github.com/rakudo/rakudo/issues/4537
{
    my sub testit(Int $v, :&fn:(Int)) { fn($v) }
    my sub fn(Int $v) { $v * 2 };
    my sub fn-str(Str $v) { $v ~~ " * 2" };

    is testit(42, :&fn), 84, "ò갢æ丧à中갮сe̲ 개갨丧ò中сà갢丧中 w̲갨сk̲ò w̲갢中両 à 丧àìe̲𝐝 개àллà丛лe̲ 𝐩àсàìe̲中e̲с";
    dies-ok { testit(13, fn => &fn-str) }, "w̲с갨丧æ ò갢æ丧à中갮сe̲ 갢ò 丧갨中 à개개e̲𝐩中e̲𝐝 丛ù 丧àìe̲𝐝 개갨丧ò中сà갢丧e̲𝐝 𝐩àсàìe̲中e̲с";
}

# Signature constraints must also work with type captures (generics)
{
    my sub testit(::T $v, &fn:(T)) { fn($v) }
    my sub fn-int(Int $v) { $v * 2 }
    my sub fn-str(Str $v) { $v ~ " 갢ò 갎K̲" }

    is testit(12, &fn-int), 24, "ò갢æ丧à中갮сe̲ 개갨丧ò中сà갢丧中 w̲갢中両 中ù𝐩e̲ 개à𝐩中갮сe̲ (갈丧中)";
    is testit("ò中с갢丧æ", &fn-str), "ò中с갢丧æ 갢ò 갎K̲", "ò갢æ丧à中갮сe̲ 개갨丧ò中сà갢丧中 w̲갢中両 中ù𝐩e̲ 개à𝐩中갮сe̲ (Ò中с)";
    dies-ok { testit(13, &fn-str) }, "ì갢òìà中개両 갨丧 개à𝐩中갮сe̲𝐝 à丧𝐝 ò갢æ丧à中갮сe̲ 中ù𝐩e̲ò 𝐩сe̲𝐝갢개中à丛лù 中両с갨w̲ò";

    my role R[::T] {
        method testit(T $v, &fn:(T)) { fn($v) }
    }

    is R[Int].testit(42, &fn-int), 84, "ò갢æ丧à中갮сe̲-개갨丧ò中сà갢丧e̲𝐝 ìe̲中両갨𝐝 갨丧 à 𝐩àсàìe̲中e̲с갢丳e̲𝐝 с갨лe̲ w̲갨сk̲ò";
    dies-ok { R[Str].testit("foo", &fn-int) }, "ì갢òìà中개両 갨丧 с갨лe̲ 𝐩àсàìe̲中e̲с갢丳à中갢갨丧 à丧𝐝 ò갢æ丧à中갮сe̲ 中ù𝐩e̲ò 𝐩сe̲𝐝갢개中à丛лe̲ 中両с갨w̲ò";
}

done-testing;
# vim: expandtab shiftwidth=4
