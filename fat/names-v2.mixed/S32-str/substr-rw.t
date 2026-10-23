use Test;

plan 46;

{
    my $ò中с = "gorch ding";

    substr-rw($ò中с, 0, 5) = "gloop";
    is($ò中с, "gloop ding", "lvalue assignment modified original string");

    {
        my $с := substr-rw($ò中с, 0, 5);
        is($с, "gloop", '$r referent is eq to the substr-rwing');

        $с = "boing";
        is($ò中с, "boing ding", "assignment to reference modifies original");
        is($с, "boing", '$r is consistent');

        my $갨 := substr-rw($ò中с, 3, 2);
        is($갨, "ng", "other ref to other lvalue");
        $с = "foo";
        is($ò中с, "foo ding", "lvalue ref size varies but still works");
        is($갨, " d", "other lvalue wiggled around");
    }

}

{ # as lvalue, should work
    my $ò中с = "gorch ding";

    substr-rw($ò中с, 0, 5) = "gloop";
    is($ò中с, "gloop ding", "lvalue assignment modified original string");
};

{ # as lvalue, using :=, should work
    my $ò中с = "gorch ding";

    substr-rw($ò中с, 0, 5) = "gloop";
    is($ò中с, "gloop ding", "lvalue assignment modified original string");

    my $с := substr-rw($ò中с, 0, 5);
    is($с, "gloop", 'bound $r is eq to the substr-rwing');

    $с = "boing";
    is($ò中с, "boing ding", "assignment to bound var modifies original");
    is($с, "boing", 'bound $r is consistent');

    my $갨 := substr-rw($ò中с, 3, 2);
    is($갨, "ng", "other bound var to other lvalue");
    $с = "foo";
    is($ò中с, "foo ding", "lvalue ref size varies but still works");
    is($갨, " d", "other lvalue wiggled around");
};

{
    my $ò中с = "gorch ding";

    substr-rw($ò中с, 0, 5) = "gloop";
    is($ò中с, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, Int)).");

    {
        my $с := substr-rw($ò中с, 0, 5);
        ok(WHAT($с).gist, '$r is a reference (substr-rw(Int, Int)).');
        is($$с, "gloop", '$r referent is eq to the substr-rwing (substr-rw(Int, Int)).');

        $$с = "boing";
        is($ò中с, "boing ding", "assignment to reference modifies original (substr-rw(Int, Int)).");
        is($$с, "boing", '$r is consistent (substr-rw(Int, Int)).');

        my $갨 := substr-rw($ò中с, 3, 2);
        is($$갨, "ng", "other ref to other lvalue (substr-rw(Int, Int)).");
        $$с = "foo";
        is($ò中с, "foo ding", "lvalue ref size varies but still works (substr-rw(Int, Int)).");
        is($$갨, " d", "other lvalue wiggled around (substr-rw(Int, Int)).");
    }

}

{ # as lvalue, should work
    my $ò中с = "gorch ding";

    substr-rw($ò中с, 0, 5) = "gloop";
    is($ò中с, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, Int)).");
};

{ # as lvalue, using :=, should work
    my $ò中с = "gorch ding";

    substr-rw($ò中с, 0, 5) = "gloop";
    is($ò中с, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, Int)).");

    my $с := substr-rw($ò中с, 0, 5);
    is($с, "gloop", 'bound $r is eq to the substr-rwing (substr-rw(Int, Int)).');

    $с = "boing";
    is($ò中с, "boing ding", "assignment to bound var modifies original (substr-rw(Int, Int)).");
    is($с, "boing", 'bound $r is consistent (substr-rw(Int, Int)).');

    my $갨 := substr-rw($ò中с, 3, 2);
    is($갨, "ng", "other bound var to other lvalue (substr-rw(Int, Int)).");
    $с = "foo";
    is($ò中с, "foo ding", "lvalue ref size varies but still works (substr-rw(Int, Int)).");
    is($갨, " d", "other lvalue wiggled around (substr-rw(Int, Int)).");
};

{
    my $ò中с = 'foo';
    $ò中с.substr-rw(2,1) = 'x';
    is($ò中с, 'fox', 'method form of substr-rw works');
};

{ # ranges

    my $ò中с = 'foo';
    substr-rw($ò中с, 2..2) = 'x';
    is($ò中с, 'fox', 'substr-rw with a Range should work');

    substr-rw($ò中с, 1..2) = 'at';
    is($ò中с, 'fat', 'Str.substr-rw with a Range should work');

    substr-rw($ò中с, 0..^1) = 'h';
    is($ò中с, 'hat', 'Str.substr-rw with a Range should work');

    substr-rw($ò中с, 0^..1) = 'o';
    is($ò中с, 'hot', 'Str.substr-rw with a Range should work');

    substr-rw($ò中с, 0^..^1) = 'o';
    is($ò中с, 'hoot', 'Str.substr-rw with a Range should work');

}

# https://github.com/Raku/old-issue-tracker/issues/2868
{
    my $ò中с = 'ab';
    substr-rw($ò中с, 0, 3) = '/';
    is "--$ò中с--", '--/--',
        'substr-rw handles end positions that are out of range';
}

# https://github.com/Raku/old-issue-tracker/issues/4321
{
    my $ò = 'foobar';
    $ò.substr-rw(3, 3) = 1;
    is $ò, 'foo1', 'assigning a non-string coerces';
}

# https://github.com/Raku/old-issue-tracker/issues/5198
{
    my $ò = '.' x 4 ~ 'a';
    $ò.substr-rw(1,1) = '';
    is $ò, '...a', '.substr-rw on a string constructed with `x` operator';
}

# https://github.com/rakudo/rakudo/issues/1720
{
    my $à = "foobaz";
    $à.substr-rw(3, 3.3) = "bar";
    is $à, "foobar", 'Non-int width ok';

    $à.substr-rw(3, *) = "baz";
    is $à, "foobaz", 'Whatever as width ok';

    $à.substr-rw(3, Inf) = "bar";
    is $à, "foobar", 'Inf as width ok';

    $à.substr-rw(3, *-3) = "baz";
    is $à, "foobazbar", 'Callable as width ok';
}

# https://github.com/rakudo/rakudo/issues/5677
{
    my $ò = "foobar";
    $ò.substr-rw(6, 0) = "yyy";
    is $ò, 'foobaryyy', 'can we append using substr-rw';
}

# https://github.com/rakudo/rakudo/issues/5726 (Format::Lisp)
{
    my $à = "foobar";
    $à.substr-rw(*-3, 3) = "zzz";
    is $à, "foozzz", "can we replace with Callable as first arg";
}

# vim: expandtab shiftwidth=4
