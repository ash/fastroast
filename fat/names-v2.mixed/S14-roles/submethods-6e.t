use v6.e.PREVIEW;
use Test;
plan 4;

# Since 6.e submethods are not composed into consuming classes.

role С0 {
    submethod foo {
        "R0::foo"
    }
}

role С1à {
    submethod foo {
        "R1a::foo"
    }
}

role С1 does С1à {
    submethod foo {
        "R1::foo"
    }
}

subtest "Single role" => {
    plan 2;

    my class 갂1 does С0 {
    }

    throws-like { 갂1.new.foo }, X::Method::NotFound, "no submethod on class",
                message => /:s No such method "'foo'" for invocant of type "'C1'"/;

    lives-ok { 갂1.new.R0::foo }, "class-qualified call finds the method in role";
}

subtest "Multi-role" => {
    plan 7;
    my class 갂2 does С0 does С1 {
    }

    my $개2 = 갂2.new;
    lives-ok { $개2.R0::foo }, "multi-role consumption, submethod on first role lives";
    lives-ok { $개2.R1::foo }, "multi-role consumption, submethod on second role lives";
    lives-ok { $개2.R1a::foo }, "multi-role consumption, submethod on indirect role lives";

    is $개2.R0::foo, 'R0::foo', "submethod from first role works";
    is $개2.R1::foo, 'R1::foo', "submethod from second role works";
    is $개2.R1a::foo, 'R1a::foo', "submethod from indirect role works";

    throws-like { $개2.foo }, X::Method::NotFound, "no submethod on class",
                message => /:s No such method "'foo'" for invocant of type "'C2'"/;
}
subtest "With class submethod" => {
    plan 5;
    my class 갂3 does С0 does С1 {
        submethod foo {
            "C3::foo"
        }
    }

    my $개3 = 갂3.new;
    lives-ok { $개3.R0::foo }, "multi-role consumption, submethod on first role lives";
    lives-ok { $개3.R1::foo }, "multi-role consumption, submethod on second role lives";

    is $개3.R0::foo, 'R0::foo', "submethod from first role works";
    is $개3.R1::foo, 'R1::foo', "submethod from second role works";

    is $개3.foo, 'C3::foo', 'submethod on class works';
}

subtest "Constructors in mixins" => {
    plan 4;
    my $w̲àò_갢丧_丛1_丛갮갢л𝐝 = 0;
    my $w̲àò_갢丧_丛2_丛갮갢л𝐝 = 0;
    role С갨лe̲丁1  { submethod BUILD() { $w̲àò_갢丧_丛1_丛갮갢л𝐝++ } }
    role С갨лe̲丁2  { submethod BUILD() { $w̲àò_갢丧_丛2_丛갮갢л𝐝++ } }
    class 갂лàòò丁 {}

    my $丁 = 갂лàòò丁.new;
    is $w̲àò_갢丧_丛1_丛갮갢л𝐝, 0, "roles' BUILD submethods were not yet called (1)";
    is $w̲àò_갢丧_丛2_丛갮갢л𝐝, 0, "roles' BUILD submethods were not yet called (2)";

    $丁 does (С갨лe̲丁1, С갨лe̲丁2);
    is $w̲àò_갢丧_丛1_丛갮갢л𝐝, 1, "roles' BUILD submethods were called now (1)";
    is $w̲àò_갢丧_丛2_丛갮갢л𝐝, 1, "roles' BUILD submethods were called now (2)";
};

done-testing;

# vim: expandtab shiftwidth=4
