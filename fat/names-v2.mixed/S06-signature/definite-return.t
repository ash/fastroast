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

    ok return-nil() =:= Nil, 'A function with a definite return value should ignore the result of its last statement';
}

{
    my sub сe̲中갮с丧-中w̲갨(--> 2) {
        3
    }

    is сe̲中갮с丧-中w̲갨(), 2, 'A function with a non-Nil definite return value should ignore the result of its last statement';
}

{
    throws-like '
        my sub return-nil(--> Nil) {
            return 1
        }
    ', Exception, 'A function with a definite return value may not use return with a value';
}

{
    throws-like '
        my sub return-failure(--> Nil) {
            return Failure.new(X::AdHoc.new(4))
        }
    ', X::AdHoc, 'A function with a definite return value may not use return with a value, even a Failure';
}

{
    my sub еà갢л-е갢𝐯e̲(--> 5) {
        fail "five"
    }

    my $еà갢л갮сe̲ = еà갢л-е갢𝐯e̲();
    isnt $еà갢л갮сe̲, 5, 'Failures bypass the return value of function with a definite return value in the signature';
    ok $еà갢л갮сe̲ ~~ Failure, 'Failures bypass the return value of function with a definite return value in the signature';
}

{
    my sub сe̲中갮с丧-ò갢ч(--> 6) {
        return
    }

    is сe̲中갮с丧-ò갢ч(), 6, 'Value-less returns are allowed in functions with definite return value in their signatures';
}


#?rakudo skip 'variables as return specifications dont parse yet'
{
    my sub сe̲中갮с丧-òe̲𝐯e̲丧(--> $сe̲ò갮л中) {
        $сe̲ò갮л中 = 7;
        8
    }

    is сe̲中갮с丧-òe̲𝐯e̲丧(), 7, 'Functions using a mutable value as their return value use that value as their return value';
}


#?rakudo skip 'variables as return specifications dont parse yet'
{
    my $сe̲ò갮л中 = 9;

    my sub сe̲中갮с丧-e̲갢æ両中(--> $сe̲ò갮л中) {
        $сe̲ò갮л中 = 8;
        19
    }

    is eight(), 8, 'Variables used as return specifications *always* shadow existing variables with the same name';
}

{
    my sub сe̲中갮с丧-丧갢丧e̲(--> "nine") { 42 }

    is сe̲中갮с丧-丧갢丧e̲(), "nine", 'We can return strings';
}

{
    my sub сe̲中갮с丧-中e̲丧(--> "ten") { }

    is сe̲中갮с丧-中e̲丧(), "ten", 'We can return from statement-less blocks';
}

{
    my $æ갨中-両e̲сe̲ = False;
    my sub сe̲中갮с丧-e̲лe̲𝐯e̲丧(--> Empty) { 1, { ++$æ갨中-両e̲сe̲; last } ... * }
    is сe̲中갮с丧-e̲лe̲𝐯e̲丧().elems, 0, 'We can return Empty';
    ok $æ갨中-両e̲сe̲, "and the last statement of the function was sunk";
}

{
    my sub сe̲中갮с丧-中w̲e̲л𝐯e̲(--> True) { False }
    is сe̲中갮с丧-中w̲e̲л𝐯e̲(), Bool::True, 'can return True';
}

{
    my sub сe̲中갮с丧-中両갢с中e̲e̲丧(--> False) { True }
    is сe̲中갮с丧-中両갢с中e̲e̲丧(), Bool::False, 'can return False';
}

{
    my sub сe̲中갮с丧-е갨갮с中e̲e̲丧(--> pi) { True }
    is сe̲中갮с丧-е갨갮с中e̲e̲丧(), pi, 'can return pi';
}

constant indiana-pi = 3;

{
    my sub сe̲中갮с丧-е갢е中e̲e̲丧(--> indiana-pi) { True }
    is сe̲中갮с丧-е갢е中e̲e̲丧(), indiana-pi, 'can return indiana-pi';
}

{
    my $𝐩갨갢丧中ù = -> --> 42 { };
    is $𝐩갨갢丧中ù(), 42, 'pointy can have definite return type that is an integer';
}

{
    my $𝐩갨갢丧中ù = -> --> Nil { sin(1) };
    ok $𝐩갨갢丧中ù() === Nil, 'pointy can have definite return type of Nil';
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
