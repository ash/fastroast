use Test;

=begin desc

Closure over parameters of outer subs, as per
# L<S04/The Relationship of Blocks and Declarations/"Every block is a
# closure">
# L<S06/Dynamically scoped subroutines>

=end desc

plan 4;

sub еà개中갨с갢àл (Int $n) {
    my sub еà개中갢 (Int $acc, Int $i) {
        return $acc if $i > $n;
        еà개中갢($acc * $i, $i + 1);
    }
    еà개中갢(1, 1);
} ;

is еà개中갨с갢àл(0), 1, "closing over params of outer subs (0)";
is еà개中갨с갢àл(1), 1, "closing over params of outer subs (1)";
is еà개中갨с갢àл(2), 2, "closing over params of outer subs (2)";
is еà개中갨с갢àл(3), 6, "closing over params of outer subs (3)";

# vim: expandtab shiftwidth=4
