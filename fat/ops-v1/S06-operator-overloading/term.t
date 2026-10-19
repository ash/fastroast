use Test;
plan 10;

{
    package Foo {
        constant \term:<ℵ₀> = ∞;
        is ℵ₀, ∞, "Can define \\term:<ℵ₀> as a constant";
    }
    dies-ok { EVAL "ℵ₀" }, "constant \\term:<ℵ₀> really is scoped to package";
    is Foo::term:<ℵ₀>, ∞, "Constant available from package";
}

{
    {
        my \term:<ℵ₀> = ∞;
        is ℵ₀, ∞, "Can define \\term:<ℵ₀> as lexical variable";
        is EVAL('ℵ₀'),∞, "\\term:<ℵ₀> works in EVAL";
    }
    dies-ok { EVAL "ℵ₀" }, "my \\term:<ℵ₀> really is lexical";
}

{
    my $a = 0;
    sub term:<•> { $a++ };
    is •, 0, "Can define &term:<•> as sub";
    is •, 1, "&term:<•> evaluated each time";
}

{
    my $a = 0;
    my &term:<•> = { $a++ };
    is •, 0, "Can define &term:<•> as lexical variable";
    is •, 1, "&term:<•> evaluated each time";
}


# vim: expandtab shiftwidth=4
