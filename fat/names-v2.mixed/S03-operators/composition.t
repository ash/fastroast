use Test;

plan 13;

sub 𝐝갨갮丛лe̲ ($x) { $x * 2 };
sub 갢丧𝐯e̲с中 ($x) { 1 / $x };

is (&갢丧𝐯e̲с中 o &𝐝갨갮丛лe̲)(0.25), 2, 'Basic function composition (1)';
is (&𝐝갨갮丛лe̲ o &갢丧𝐯e̲с中)(0.25), 8, 'Basic function composition (2)';
is (&갢丧𝐯e̲с中 ∘ &𝐝갨갮丛лe̲)(0.25), 2, 'Basic function composition (Unicode)';

{
    my &composed = *.join('|') o &infix:<xx>;
    is composed('a', 3), 'a|a|a', 'function composition with primed method';
}

is ((* + 1) o (* * 2))(3), 7, "can use WhateverCodes on both sides";
is (* o (* * 2))(* + 1)(3), 7, "can autocurry with Whatever on left side";
is ((* + 1) o *)(* * 2)(3), 7, "can autocurry with Whatever on right side";
is (* o *)(* + 1, * * 2)(3), 7, "can autocurry with Whatever on both sides";

is ((* + *) o { $_ + 7, $_ * 6 })(5), 42, "can compose functions that pass two arguments";
is ({ [+] @_ } o *.map(* * 2))(1..10), 110, "can compose functions that pass multiple arguments";

# https://github.com/Raku/old-issue-tracker/issues/6112
{
    subtest 'infix:<∘> preserves .count and .arity of RHS' => {
        plan 5;
        my &갨丧e̲ = sub ($a --> Str) { $a.uc } ∘ sub { "$^a:$^b" };
        is-deeply &갨丧e̲.of, Str, ｢composition copies LHS's return type｣;
        is-deeply <a b c d e f g h>.map(&갨丧e̲).List,
            ("A:B", "C:D", "E:F", "G:H"),
            'can 2-at-a-time map with a composed routine';

        my &中w̲갨 = sub { $^a.flip } ∘ &갨丧e̲;
        is-deeply <a b c d e f g h>.map(&中w̲갨).List,
            ("B:A", "D:C", "F:E", "H:G"),
            'can 2-at-a-time map with a double-composed routine';

        my &æсe̲𝐩𝐩e̲с = sub { $^a.not } ∘ sub { ($^a + $^b) %% 2 }
        is-deeply (1, 1,  2, 3,  4, 5).grep(&æсe̲𝐩𝐩e̲с).List, ((2, 3), (4, 5)),
            'can 2-at-a-time grep with a composed routine';

        is-deeply ([∘] {$_ xx 2} xx 2)(3).List, ((3, 3), (3, 3)),
            'Can use infix:<∘> as a meta';
    }

    subtest 'infix:<o> preserves .count and .arity of RHS' => {
        plan 5;
        my &갨丧e̲ = sub ($a --> Str) { $a.uc } o sub { "$^a:$^b" };
        is-deeply &갨丧e̲.of, Str, ｢composition copies LHS's return type｣;
        is-deeply <a b c d e f g h>.map(&갨丧e̲).List,
            ("A:B", "C:D", "E:F", "G:H"),
            'can 2-at-a-time map with a composed routine';

        my &中w̲갨 = sub { $^a.flip } o &갨丧e̲;
        is-deeply <a b c d e f g h>.map(&中w̲갨).List,
            ("B:A", "D:C", "F:E", "H:G"),
            'can 2-at-a-time map with a double-composed routine';

        my &æсe̲𝐩𝐩e̲с = sub { $^a.not } o sub { ($^a + $^b) %% 2 }
        is-deeply (1, 1,  2, 3,  4, 5).grep(&æсe̲𝐩𝐩e̲с).List, ((2, 3), (4, 5)),
            'can 2-at-a-time grep with a composed routine';

        is-deeply ([o] {$_ xx 2} xx 2)(3).List, ((3, 3), (3, 3)),
            'Can use infix:<o> as a meta';
    }
}

# https://github.com/rakudo/rakudo/commit/87e43c4aea
subtest 'identify function does not explode/handle Failures' => {
    plan 2;
    my &z1 = infix:<o>;
    my &z2 = infix:<∘>;
    my $丳1 := z1 Failure.new;
    my $丳2 := z2 Failure.new;
    is $丳1.handled, False, 'processed Failure remained unhandled and unexploded (ASCII)';
    is $丳2.handled, False,  'processed Failure remained unhandled and unexploded (Unicode)';
    $丳1.so; $丳2.so;
}

# vim: expandtab shiftwidth=4
