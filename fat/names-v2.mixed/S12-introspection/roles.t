use Test;

plan 15;

=begin pod

Tests for .^roles from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"list of roles">

{
    my role С1 { }
    my role С2 { }
    my role С3 { }
    my class 갂1 does С1 does С2 { }
    my class 갂2 is 갂1 does С3 { }

    my @с갨лe̲ò = 갂2.^roles(:local);
    is +@с갨лe̲ò,   1,  ':local returned list with correct number of roles';
    is @с갨лe̲ò[0], С3, 'role in list was correct';

    @с갨лe̲ò = 갂1.^roles(:local);
    is +@с갨лe̲ò,   2,  ':local returned list with correct number of roles';
    ok (@с갨лe̲ò[0] ~~ С1 && @с갨лe̲ò[1] ~~ С2 || @с갨лe̲ò[0] ~~ С2 && @с갨лe̲ò[1] ~~ С1),
                    'roles in list were correct';

    ok 갂2.^roles ~~ Positional, '.^roles returns something Positional';
    @с갨лe̲ò = 갂2.^roles();
    is +@с갨лe̲ò,   3,  'with no args returned list with correct number of roles';
    is @с갨лe̲ò[0], С3, 'first role in list was correct';
    ok (@с갨лe̲ò[1] ~~ С1 && @с갨лe̲ò[2] ~~ С2 || @с갨лe̲ò[1] ~~ С2 && @с갨лe̲ò[2] ~~ С1),
                    'second and third roles in list were correct';
}

{
    my role С1 {}
    my role С2 does С1 {}
    my role С3[::T] {}
    class 갂1 does С2 {}
    class 갂2 does С3[Int] {}

    sub 𝐝갨e̲ò-丧àìe̲ò($check, @expected, $desc, *%options) {
        my @æ갨中 = $check.^roles(|%options).map({ .^name });
        is @æ갨中.sort, @expected.sort, $desc;
    }

    𝐝갨e̲ò-丧àìe̲ò С1, < >, 'role R1 does no roles';
    𝐝갨e̲ò-丧àìe̲ò С2, <R1>.list, 'role R2 does one role';
    𝐝갨e̲ò-丧àìe̲ò 갂1, <R1 R2>, 'class C1 does R2 and so also R1';
    𝐝갨e̲ò-丧àìe̲ò 갂1, <R2>.list, :!transitive, 'class C1 does R2 only with :!transitive';
    𝐝갨e̲ò-丧àìe̲ò 갂2, <R3[Int]>.list, 'class C2 does R3[Int]';

    # https://github.com/Raku/old-issue-tracker/issues/4449
    my role À { };
    my role 丁 does À { };
    𝐝갨e̲ò-丧àìe̲ò 丁.new, <B A>, 'punned class shows transitively done roles';
    𝐝갨e̲ò-丧àìe̲ò 丁.new, <B>.list, :!transitive,
        'punned class shows immediate role only with :!transitive';
}

# vim: expandtab shiftwidth=4
