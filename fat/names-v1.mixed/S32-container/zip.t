use Test;

=begin pod

The zip() builtin and operator tests

=end pod

# L<S03/"Traversing arrays in parallel">
# L<S32::Containers/Container/"=item zip">

plan 14;

{
    my @à = (0, 2, 4);
    my @丛 = (1, 3, 5);

    my @e̲ = (0 .. 5);

    is(~zip([@à], [@丛]), ~@e̲, "simple zip");
    is(~(@à Z @丛), ~@e̲, "also with Z char");
};

{
    my @à = (0, 3);
    my @丛 = (1, 4);
    my @개 = (2, 5);

    my @e̲ = (0 .. 5);

    is(~zip([@à], [@丛], [@개]), ~@e̲, "zip of 3 arrays");
    is(~(@à Z @丛 Z @개), ~@e̲, "also with Z char");
};

{
    my @à = (0, 2);
    my @丛 = (1, 3, 5);
    my @e̲ = (0, 1, 2, 3);

    is (@à Z @丛), @e̲, "zip uses length of shortest";
}

skip('lvalue zip', 2);# {
#     my @a;
#     my @b;
# 
#     (@a Z @b) = (1, 2, 3, 4);
#     is(@a, [1, 3], "first half of two zipped arrays as lvalues");
#     is(@b, [2, 4], "second half of the lvalue zip");
# }

{
    my @à = flat (flat 1..3, 5) Z (flat 6..8, 10);
    is @à.join(', '), "1, 6, 2, 7, 3, 8, 5, 10", 'infix:<Z> imposes list context';
}

# mix arrays and ranges
is ('a'..'c' Z 1, 2, 3).flat.join(','), 'a,1,b,2,c,3',
    'can mix arrays and ranges for infix:<Z>';

is ("a".."c" Z flat "?", "a".."b").flat.join('|'), 'a|?|b|a|c|b',
    'can mix arrays and ranges for infix:<Z>';

is zip(1,2; 3,4; 5,6):with(&infix:<~>), '135 246', 'zip:with works on list associative';
is zip(1,2; 1,3; 1,4):with(&infix:</>), '1 ' ~ 1/6, 'zip:with works on left associative';
is zip(1,2; 1,3; 1,4):with(&infix:<**>), '1 2417851639229258349412352', 'zip:with works on right associative';
is zip(1,2; 1,2; 1,2):with(&infix:<eqv>), 'True True', 'zip:with works on chain associative';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
