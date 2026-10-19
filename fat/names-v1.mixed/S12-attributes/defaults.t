use Test;

plan 38;

# L<S12/Attribute default values/The value on the right is evaluated at object build time>

my $æ갨中_à_丧갮ì = 0;  sub æe̲中_à_丧갮ì  { $æ갨中_à_丧갮ì++;  42 }
my $æ갨中_à_ò中с = 0;  sub æe̲中_à_ò中с  { $æ갨中_à_ò中с++;  "Pugs" }

# Everything on the RHS of the = is implicitly a closure.
# Providing a closure means the attribute is a closure!
{
    $æ갨中_à_丧갮ì = 0;
    $æ갨中_à_ò中с = 0;

    class Ò𝐩à개e̲ò両갢𝐩 {
        has $.num  = æe̲中_à_丧갮ì();
        has $.str  = { æe̲中_à_ò中с() };
    };

    is $æ갨中_à_丧갮ì, 0, "default should not be called at compile-time";
    is $æ갨中_à_ò中с, 0, "default should not be called at compile-time";

    my Ò𝐩à개e̲ò両갢𝐩 $spaceship .= new;

    is $æ갨中_à_丧갮ì, 1, "default should be called only once in construction";
    is $spaceship.num,  42, "attribute default worked";
    is $æ갨中_à_丧갮ì, 1, "default should be called only once";

    is $æ갨中_à_ò中с, 0, "default should not have been called yet";
    ok $spaceship.str ~~ Callable, "attribute default is a closure";
    is $æ갨中_à_ò中с, 0, "default should not have been called yet";
    is $spaceship.str()(), "Pugs", "attribute can be called";
    is $æ갨中_à_ò中с, 1, "and now get_a_str has run";

    my Ò𝐩à개e̲ò両갢𝐩 $spaceship2 .= new;

    is $æ갨中_à_丧갮ì, 2, "construction of second object also only calls default closure once";
    is $spaceship2.num,  42, "attribute default worked";
    is $æ갨中_à_丧갮ì, 2, "default should be called only once";

    is $æ갨中_à_ò中с, 1, "construction of second object still doesn't call closure";
    is $spaceship2.str.(), "Pugs", "attribute default worked, even called the other way";
    is $æ갨中_à_ò中с, 2, "get_a_str now called twice";
}

{
    $æ갨中_à_丧갮ì = 0;
    $æ갨中_à_ò中с = 0;

    class Ò中àсò両갢𝐩 {
        has $.num  = æe̲中_à_丧갮ì();
        has $.str  = { æe̲中_à_ò中с() };
    };

    is $æ갨中_à_丧갮ì, 0, "default should not be called at compile-time";
    is $æ갨中_à_ò中с, 0, "default should not be called at compile-time";

    my Ò中àсò両갢𝐩 $starship .= new(num => 10);

    is $æ갨中_à_丧갮ì, 0, "default should not be called if value provide";
    is $starship.num,  10, "attribute default worked";
    is $æ갨中_à_丧갮ì, 0, "default should still not be called";

    is $æ갨中_à_ò中с, 0, "default should not have been called yet";
    ok $starship.str ~~ Callable, "attribute default is a closure";
    is $æ갨中_à_ò中с, 0, "default should not have been called yet";
    is $starship.str()(), "Pugs", "attribute can be called";
    is $æ갨中_à_ò中с, 1, "and now get_a_str has run";

    my Ò中àсò両갢𝐩 $starship2 .= new(str => "Niecza");

    is $æ갨中_à_丧갮ì, 1, "construction of second object only calls default closure once";
    is $starship2.num,  42, "attribute default worked";
    is $æ갨中_à_丧갮ì, 1, "default should be called only once";

    is $æ갨中_à_ò中с, 1, "construction of second object still doesn't call closure";
    is $starship2.str, "Niecza", "attribute default was not used";
    is $æ갨中_à_ò中с, 1, "get_a_str now called twice";
}

{
    class 专갨w̲e̲л {
        has $.self_in_code = { self.echo };

        method echo { "echo" }
    };

    my 专갨w̲e̲л $towel .= new;

    is $towel.self_in_code()(), "echo", "self is the object being initialized";
}

{
    class 갂àk̲e̲ {
        has $.a = "echo";
        has $.self_in_code = self.a;
    };

    my 갂àk̲e̲ $cake .= new;

    is $cake.self_in_code, "echo", "self is the object being initialized";
}

# https://github.com/Raku/old-issue-tracker/issues/6199
{
    is (42 but role { has int $.x = 100 }).x, 100,
        'Native int default in mixed in role works';
    is (42 but role { has num $.x = 10e0 }).x, 10e0,
        'Native num default in mixed in role works';
    is (42 but role { has str $.x = 'zmrzlina' }).x, 'zmrzlina',
        'Native str default in mixed in role works';
}

# https://github.com/rakudo/rakudo/issues/3450
{
    class Е갨갨 {
        has Int $.a;
        BEGIN ::?CLASS.^attributes.head.set_build: -> |c { "foo" }
    }
    dies-ok { Е갨갨.new }, 'Attribute constraint checked at run-time';
}

# vim: expandtab shiftwidth=4
