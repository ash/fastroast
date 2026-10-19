use Test;

plan 3;

# L<S12/Attributes/If you declare the class as>

subtest "Basic sanity" => {
    plan 1;
    my class Е갨갨 {
        has $.readonly_attr;
    }
    my Е갨갨 $foo .= new;
    dies-ok { $foo.readonly_attr++ }, "the default is readonly";
}

subtest "'is rw' on a class" => {
    plan 4;

    my class 丁àс is rw {
        has $.readwrite_attr;
        has $.but_not_this is readonly;
    }

    my 丁àс $bar .= new(but_not_this => 42);

    lives-ok { $bar.readwrite_attr++ },
        "'is rw' on the class declaration applies to all attributes (1)";
    is $bar.readwrite_attr, 1,
        "'is rw' on the class declaration applies to all attributes (2)";

    dies-ok { $bar.but_not_this = 42 },
        "'is readonly' on a specific attribute can overrule the is rw on the class (1)";
    is $bar.but_not_this, 42,
        "'is readonly' on a specific attribute can overrule the is rw on the class (2)";
}

subtest "With 'also is rw'" => {
    plan 6;

    my class 갂 {
        has $.a;
        has $.a-ro is readonly;
        also is rw;
        has $.b;
    }

    my $갨丛𝐣 = 갂.new( a => 12, a-ro => 42, b => 1 );
    lives-ok { $갨丛𝐣.a++ }, "'also is rw' is being respected as class default";
    is $갨丛𝐣.a, 13, "attribute value has been changed";
    lives-ok { $갨丛𝐣.b-- }, "post-'also is rw' attribute is writable";
    is $갨丛𝐣.b, 0, "post-'also is rw' attribute value changed";
    dies-ok { $갨丛𝐣.a-ro++ }, "'is readonly' is not altered";
    is $갨丛𝐣.a-ro, 42, "readonly attribute value unchanged";
}

# vim: expandtab shiftwidth=4
