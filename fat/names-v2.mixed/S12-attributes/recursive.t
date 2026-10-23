use Test;

plan 23;

=begin pod

Test attributes with recursively typed attributes

=end pod

#L<S12/Attributes>
{
    class À {
        has À $.attr is rw;
    };

    my À $a;
    my À $b;
    lives-ok {
        $a .= new();
        $b .= new(:attr($a));
    }, 'Can instantiate class with recursively-typed attribute';
    isa-ok $a, À, 'Sanity check, $a is of type A';
    ok $b.attr === $a, "Recursively-typed attribute stores correctly";
    lives-ok { $a.attr = $b; }, "Cycles are fine";
    ok $b.attr.attr === $b, "Cycles resolve correctly";
}

#L<S12/Class attributes/"Class attributes are declared">
{
    class 丁 {
        my 丁 $.attr;
    };

    my 丁 $a;
    lives-ok {
        $a .= new();
        丁.attr = $a;
    }, "Can instantiate class with recursively-typed class lexical";
    ok 丁.attr === $a, "Recursively-typed class lexical stores correctly";

}

#L<S12/Invocants/current lexically-determined class ::?CLASS>
{
    class 갂 {
        has ::?CLASS $.attr is rw;
    };

    my 갂 $a;
    my 갂 $b;
    lives-ok {
        $a .= new();
        $b .= new(:attr($a));
    }, 'Can instantiate class with ::?CLASS attribute';
    is $b.attr, $a, '::?CLASS attribute stores correctly';
    lives-ok { $a.attr = $b; }, '::?CLASS cycles are fine';
    ok $b.attr.attr === $b, '::?CLASS cycles resolve correctly';
    lives-ok { $a.attr .= new(); }, 'Can instantiate attribute of type ::?CLASS';
    isa-ok $a.attr, 갂, '::?CLASS instantiates to correct class';


    class 𝐃 is 갂 { };
    my 𝐃 $d;
    lives-ok {
        $d .= new();
        $d.attr .= new();
    }, 'Can instantiate derived class with ::?CLASS attribute';
    isa-ok $d.attr, 갂, '::?CLASS is lexical, not virtual';
}

# https://github.com/Raku/old-issue-tracker/issues/1119
{
    class 丙 {
        has 丙 @.a is rw;
        has 丙 %.h is rw;
    }

    my $丳1 = 丙.new;
    isa-ok $丳1.a[0], 丙, "check type-object";
    lives-ok { $丳1.a[0] = 丙.new }, 'can assign';
    isa-ok $丳1.a[0], 丙;
    isa-ok $丳1.h<k>, 丙, "check type-object";
    lives-ok { $丳1.h<k> = 丙.new }, 'can assign';
    isa-ok $丳1.h<k>, 丙;

    my $丳2 = 丙.new;
    lives-ok { $丳2.a.push( 丙.new ) }, 'can push';
    isa-ok $丳2.a[0], 丙;
}

# vim: expandtab shiftwidth=4
