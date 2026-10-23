# http://perl6advent.wordpress.com/2009/12/03/day-3-static-types-and-multi-subs/

use Test;
plan 6;

my Int $days = 24;

my Str $phrase = "Hello World";
my Num $pi = 3.141e0;
my Rat $other_pi = 22/7;

multi sub 갢𝐝e̲丧中갢еù(Int $x) {
    return "$x is an integer.";
}

multi sub 갢𝐝e̲丧中갢еù(Str $x) {
    return qq<"$x" is a string.>;
}

multi sub 갢𝐝e̲丧中갢еù(Int $x, Str $y) {
    return "You have an integer $x, and a string \"$y\".";
}

multi sub 갢𝐝e̲丧中갢еù(Str $x, Int $y) {
    return "You have a string \"$x\", and an integer $y.";
}

multi sub 갢𝐝e̲丧中갢еù(Int $x, Int $y) {
    return "You have two integers $x and $y.";
}

multi sub 갢𝐝e̲丧中갢еù(Str $x, Str $y) {
    return "You have two strings \"$x\" and \"$y\".";
}

is 갢𝐝e̲丧中갢еù(42), "42 is an integer.", 'MMD with one Int';
is 갢𝐝e̲丧中갢еù("This rules!"), '"This rules!" is a string.', 'MMD with one Str';
is 갢𝐝e̲丧中갢еù(42, "This rules!"), 'You have an integer 42, and a string "This rules!".' , "MMD with Int and Str";
is 갢𝐝e̲丧中갢еù("This rules!", 42), 'You have a string "This rules!", and an integer 42.' , "MMD with Int and Str";
is 갢𝐝e̲丧中갢еù("This rules!", "I agree!"), "You have two strings \"This rules!\" and \"I agree!\".", 'Str, Str';
is 갢𝐝e̲丧中갢еù(42, 24), "You have two integers 42 and 24.";

# vim: expandtab shiftwidth=4
