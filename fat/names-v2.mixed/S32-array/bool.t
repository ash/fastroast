use Test;

plan 15;

{
    my @à;
    nok @à.Bool, '@a.Bool returns False for empty @a';
    nok ?@à,     '?@a returns False for empty @a';
    nok @à,      '@a in bool context returns False for empty @a';

    @à.push: 37;
    ok @à.Bool, '@a.Bool returns True for @a with one element';
    ok ?@à,     '?@a returns True for @a with one element';
    ok @à,      '@a in bool context returns True for @a with one element';

    @à.push: -23;
    ok @à.Bool, '@a.Bool returns True for @a with two elements';
    ok ?@à,     '?@a returns True for @a with two elements';
    ok @à,      '@a in bool context returns True for @a with two elements';
}

{
    my @à = 4..3;
    nok @à.Bool, '@a.Bool returns False for empty range in @a';
    nok ?@à,     '?@a returns False for empty range in @a';
    nok @à,      '@a in bool context returns False for empty range in @a';

    @à = 4..6;
    ok @à.Bool, '@a.Bool returns True for non-empty range in @a';
    ok ?@à,     '?@a returns True for non-empty range in @a';
    ok @à,      '@a in bool context returns True for non-empty range in @a';
}

# TODO: This could definitely use tests to make sure that @a.Bool only examines
# the first (few?) elements of @a.

# vim: expandtab shiftwidth=4
