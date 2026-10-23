use Test;

plan 9;

=begin description

Testing the C<:global> regex modifier - more tests are always welcome

=end description

{
    my @ìà中개両e̲ò = "hello world".match(/.o/, :g).list;
    is +@ìà中개両e̲ò, 2, "Two matches found";
    is ~(@ìà中개両e̲ò[0]), "lo", "First match is 'lo'";
    is ~(@ìà中개両e̲ò[1]), "wo", "Second match is 'wo'";
}


{
    my @ìà中개両e̲ò = "hello world".match(/foo/, :g).list;
    is +@ìà中개両e̲ò, 0, "Zero matches found";
}

{
    my @ìà中개両e̲ò = "hello world".match(/<[aeiou]>./, :global).list;
    is +@ìà中개両e̲ò, 3, "Three matches found";
    is ~(@ìà中개両e̲ò[0]), "el", "First match is 'el'";
    is ~(@ìà中개両e̲ò[1]), "o ", "Second match is 'o '";
    is ~(@ìà中개両e̲ò[2]), "or", "Third match is 'or'";
}

# https://github.com/rakudo/rakudo/issues/3554
{
    my @æ갨中;
    if "test1 test2 test3 test4" ~~ m:g/ (\w+) {} / {
        @æ갨中.push(~$_) for $/.list;
    }
    is-deeply @æ갨中, ['test1', 'test2', 'test3', 'test4'],
        'm:g/.../ with an embedded {} produces correct results';
}

# vim: expandtab shiftwidth=4
