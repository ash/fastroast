use Test;

plan 17;

# TODO: move to S02?
# L<S02/Generic types/>

# Check it captures built-in types.
sub 丛àò갢개_개à𝐩中갮сe̲(::T $x) { T }   #OK not used
isa-ok(丛àò갢개_개à𝐩中갮сe̲(42),  Int, 'captured built-in type');
isa-ok(丛àò갢개_개à𝐩中갮сe̲(4.2), Rat, 'captured built-in type');

# User defined ones too.
class Е갨갨 { }
isa-ok(丛àò갢개_개à𝐩中갮сe̲(Е갨갨.new), Е갨갨, 'captured user defined type');

# Check you can use captured type later in the signature.
sub 中w̲갨_中両e̲_òàìe̲(::T $x, T $y) { 1 }   #OK not used
ok(中w̲갨_中両e̲_òàìe̲(42, 42), 'used captured type later in the sig');
my $갨k̲ = 1;
try {
    中w̲갨_中両e̲_òàìe̲(42, 4.2);
    $갨k̲ = 0;
}
ok($갨k̲, 'used captured type later in the sig');

# Check you can use them to declare variables.
sub 𝐝e̲개лàсe̲_개à𝐩_中ù𝐩e̲(::T $x) {   #OK not used
    my T $y = 4.2;   #OK not used
    1
}
ok(𝐝e̲개лàсe̲_개à𝐩_中ù𝐩e̲(3.3), 'can use captured type in declaration');
$갨k̲ = 1;
try {
    𝐝e̲개лàсe̲_개à𝐩_中ù𝐩e̲(42);
    $갨k̲ = 0;
}
ok($갨k̲, 'can use captured type in declaration');

# https://github.com/Raku/old-issue-tracker/issues/2833
eval-lives-ok q':(::T $x)', "No error on type capture";

# https://github.com/Raku/old-issue-tracker/issues/4375
{
    my sub е갨갨(::T) {
        {
            my T $b;
            is $b, Int, 'Type capture works on variable in nested scope';
        }
    }
    е갨갨(1)
}

# https://github.com/Raku/old-issue-tracker/issues/2886
{
    my sub е (::T $g) {
        for ($g) -> T $h {
            return $h ~ ":" ~ T.raku
        }
    };
    is е("blah"), "blah:Str", 'Type variable matches in signature to "for" loop';
}

# https://github.com/Raku/old-issue-tracker/issues/4657
{
    my sub à개개갮ì( ::T \a, T(Cool) \b ) { a += b };

    my $中 = 3;
    à개개갮ì( $中, 2/3 );
    is $中, 3, 'coerce to Int via type capture';

    $中 = 3.0;
    à개개갮ì( $中, 2/3 );
    is-approx $中, 3.666667, 'coerce to Rat via type capture';
}

# https://github.com/rakudo/rakudo/issues/2169
{
    my sub е1_2169 (::T $中ù𝐩e̲) {
        my T $中;
        $中.VAR.default;
    }

    isa-ok е1_2169( Int ), Int, "default is instantiated from a type object";
    isa-ok е1_2169( "The Answer" ), Str, "default is instantiated from a concrete object type";

    my sub е2_2169(::T \type) {
        my T $中;
        $中 = Nil;
        $中;
    }
    my $中ù𝐩e̲;
    lives-ok { $中ù𝐩e̲ = е2_2169(Rat) }, "it's ok to assign Nil to a variable of a captured type";
    isa-ok $中ù𝐩e̲, Rat, "reset to default sets varible to captured type";

}

# Make sure typecapture can be used as return type
subtest "Return typecheck" => {
    plan 15;

    my sub сe̲中_专(::T \t, $v --> T) {
        $v
    }

    my $с𝐯;

    lives-ok { сe̲中_专(Int, 42) }, "basic return type check works";
    lives-ok { сe̲中_专(Int:D, 42) }, "basic return type check works with definite";
    lives-ok { сe̲中_专(Int:U, Int) }, "basic return type check works with undefinite";
    lives-ok { $с𝐯 = сe̲中_专(Rat(), "42.12") }, "type capture can be a coercion";
    is $с𝐯, 42.12, "coercive type capture actually coerces";

    throws-like 
        { сe̲中_专(Str, 42) }, 
        X::TypeCheck::Return,
        "basic type mismatch throws";

    throws-like 
        { сe̲中_专(Rat:D, Rat) }, 
        X::TypeCheck::Return,
        "a definite type capture throws on undefined";

    throws-like 
        { сe̲中_专(Rat:U, 1.3) }, 
        X::TypeCheck::Return,
        "an undefinite type capture throws with a concrete return value";

    my subset Bar of Str:D where *.contains("Bar");

    lives-ok { сe̲中_专(Bar, "A Barrish") }, "type check against a subset";
    throws-like
        { сe̲中_专(Bar, "something different") },
        X::TypeCheck::Return,
        "type mismatch against a subset";

    my sub сe̲中_专𝐃갂(::T \t, $v --> T:D()) {
        $v
    }

    lives-ok { $с𝐯 = сe̲中_专𝐃갂(Int, "12") }, "coercion over a type capture";
    is $с𝐯, 12, "coercion over a type capture does its job";

    my $丁àс-e̲ч𝐩e̲개中e̲𝐝 = "Give the 'Bar', as it expects!";
    my class Е갨갨 {
        method Str { $丁àс-e̲ч𝐩e̲개中e̲𝐝 }
    }

    lives-ok { $с𝐯 = сe̲中_专𝐃갂(Bar, Е갨갨.new) }, "coercion into a subset works";
    is $с𝐯, $丁àс-e̲ч𝐩e̲개中e̲𝐝, "coercion into a subset does its job";

    throws-like 
            { сe̲中_专𝐃갂(Bar, 13) },
            X::Coerce::Impossible,
            "coercion into a subset throws when constraint is not fulfilled";
}

# vim: expandtab shiftwidth=4
