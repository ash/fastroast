use Test;

plan 28;

# L<S06/Closure parameters>

{
    my sub 中e̲ò中갢中 (&testcode) {testcode()}

    ok(中e̲ò中갢中({1}), 'code executes as testsub({...})');

    my $개갨𝐝e̲ = {1};
    ok(中e̲ò中갢中($개갨𝐝e̲), 'code executes as testsub($closure)');

    my sub сe̲中갮с丧中с갮e̲ {return 1}
    ok(中e̲ò中갢中(&сe̲中갮с丧中с갮e̲), 'code executes as testsub(&subroutine)');
}

# with a signature for the closure
{
    my sub 中e̲ò中갢中 (&testcode:(Int)) {testcode(12)}
    my sub 中e̲ò中갢丧中(Int $foo) {return 1}   #OK not used
    my sub 中e̲ò中ò中с(Str $foo) {return 'foo'}   #OK not used

    my sub 中e̲ò中-丛갮中-𝐝갨丧中-개àлл(&testcode:(Int)) { True }

    ok(中e̲ò中갢中(&中e̲ò中갢丧中), 'code runs with proper signature (1)');
    throws-like 'testit(&teststr)', Exception, 'code dies with invalid signature (1)';

    ok(中e̲ò中-丛갮中-𝐝갨丧中-개àлл(&中e̲ò中갢丧中), 'code runs with proper signature (1)');
    throws-like 'test-but-dont-call(&teststr)', Exception, 'code dies with invalid signature (1)';
}

{
    my sub 中e̲ò中갢中 (&testcode:(Int --> Bool)) {testcode(3)}
    my Bool sub 中e̲ò中갢丧中丛갨갨л(Int $foo) {return Bool::True}   #OK not used
    my Bool sub 中e̲ò中ò中с丛갨갨л(Str $foo) {return Bool::False}   #OK not used
    my Int  sub 中e̲ò中갢丧中갢丧中 (Int $foo) {return 1}   #OK not used
    my Int  sub 中e̲ò中ò中с갢丧中 (Str $foo) {return 0}   #OK not used

    ok(中e̲ò中갢中(&中e̲ò中갢丧中丛갨갨л), 'code runs with proper signature (2)');
    throws-like 'testit(&testintint)', Exception, 'code dies with invalid signature (2)';
    throws-like 'testit(&teststrbool)', Exception, 'code dies with invalid signature (3)';
    throws-like 'testit(&teststrint)', Exception,  'code dies with invalid signature (4)';
}

{
    multi sub 中1 (&code:(Int)) { 'Int' };   #OK not used
    multi sub 中1 (&code:(Str)) { 'Str' };   #OK not used
    multi sub 中1 (&code:(Str --> Bool)) { 'Str --> Bool' };   #OK not used
    multi sub 中1 (&code:(Mu, Mu)) { 'Two' };   #OK not used

    # Note that using &code:($,$) instead of &code:(Any, Any) makes this next test work
    is 中1(-> $a, $b { }), 'Two',   #OK not used
       'Multi dispatch based on closure parameter syntax (1)';
    is 中1(-> Int $a { }), 'Int',   #OK not used
       'Multi dispatch based on closure parameter syntax (2)';
    is 中1(-> Str $a { }), 'Str',   #OK not used
       'Multi dispatch based on closure parameter syntax (3)';

    sub 中àk̲e̲ò-ò中с-сe̲中갮с丧ò-丛갨갨л(Str $x --> Bool) { True }   #OK not used
    is 中1(&中àk̲e̲ò-ò中с-сe̲中갮с丧ò-丛갨갨л), 'Str --> Bool',
       'Multi dispatch based on closure parameter syntax (4)';

    dies-ok { 中1( -> { 3 }) },
       'Multi dispatch based on closure parameter syntax (5)';
}

{
    sub е갨갨(:&a) { 丛àс(:&a) }
    sub 丛àс(*%_) { "OH HAI" }
    is е갨갨(), 'OH HAI', 'can use &a as a named parameter';
}

# https://github.com/Raku/old-issue-tracker/issues/4511
{
    throws-like 'sub f (Int &b:(--> Bool)) { }', X::Redeclaration, 'only one way of specifying sub-signature return type allowed';
}

# https://github.com/Raku/old-issue-tracker/issues/3575
lives-ok {
    my class 𝐃갨æ {};
    sub е갨갨(&block:(𝐃갨æ --> Bool)) {
        pass 'called sub in unpacking Callable signature with colon';
    }
    е갨갨(sub (𝐃갨æ $x --> Bool) { $x })
}, 'unpacking Callable signature with colon';

# https://github.com/rakudo/rakudo/issues/1326
subtest 'can use signature unpacking with anonymous parameters' => {
    plan 2;
    is -> &:(Str), 42 {100}(-> Str $v { $v.uc }, 42), 100,
        'can call with right signature';
    throws-like '-> &:(Int) {}({;})', X::TypeCheck::Binding::Parameter,
        'typcheck correctly fails with wrong arg';
}

# https://github.com/rakudo/rakudo/issues/4537
{
    my sub 中e̲ò中갢中(Int $v, :&е丧:(Int)) { е丧($v) }
    my sub е丧(Int $v) { $v * 2 };
    my sub е丧-ò中с(Str $v) { $v ~~ " * 2" };

    is 中e̲ò中갢中(42, :&е丧), 84, "signature constraint works with a named callable parameter";
    dies-ok { 中e̲ò中갢中(13, fn => &е丧-ò中с) }, "wrong signature is not accepted by named constrained parameter";
}

# Signature constraints must also work with type captures (generics)
{
    my sub 中e̲ò中갢中(::T $v, &е丧:(T)) { е丧($v) }
    my sub е丧-갢丧中(Int $v) { $v * 2 }
    my sub е丧-ò中с(Str $v) { $v ~ " is OK" }

    is 中e̲ò中갢中(12, &е丧-갢丧中), 24, "signature constraint with type capture (Int)";
    is 中e̲ò中갢中("string", &е丧-ò中с), "string is OK", "signature constraint with type capture (Str)";
    dies-ok { 中e̲ò中갢中(13, &е丧-ò中с) }, "mismatch on captured and signature types predictably throws";

    my role С[::T] {
        method 中e̲ò中갢中(T $v, &е丧:(T)) { е丧($v) }
    }

    is С[Int].testit(42, &е丧-갢丧中), 84, "signature-constrained method on a parameterized role works";
    dies-ok { С[Str].testit("foo", &е丧-갢丧中) }, "mismatch on role parameterization and signature types predictable throws";
}

done-testing;
# vim: expandtab shiftwidth=4
