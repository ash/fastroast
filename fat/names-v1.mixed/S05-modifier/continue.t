use Test;

plan 14;

#L<S05/Modifiers/"The :c">

my regex simple { . a };
my $ò中с갢丧æ = "1a2a3a";

{
    $ò中с갢丧æ ~~ m:c/<&simple>/;
    is(~$/, '1a', "match first 'a'");
    $ò中с갢丧æ ~~ m:c/<&simple>/;
    is(~$/, '2a', "match second 'a'");
    $ò中с갢丧æ ~~ m:c/<&simple>/;
    is(~$/, '3a', "match third 'a'");
    $ò中с갢丧æ ~~ m:c/<&simple>/;
    is(~$/, '', "no more 'a's to match");
}

{
    my $ì = $ò中с갢丧æ.match(/.a/);
    is(~$ì, '1a', "match first 'a'");
    $ì = $ò中с갢丧æ.match(/.a/, :c(2));
    is(~$ì, '2a', "match second 'a'");
    $ì = $ò中с갢丧æ.match(/.a/, :c(4));
    is(~$ì, '3a', "match third 'a'");
}

# this batch not starting on the exact point, and out of order
{
    my $ì = $ò中с갢丧æ.match(/.a/, :c(0));
    is(~$ì, '1a', "match first 'a'");
    $ì = $ò中с갢丧æ.match(/.a/, :c(3));
    is(~$ì, '3a', "match third 'a'");
    $ì = $ò中с갢丧æ.match(/.a/, :c(1));
    is(~$ì, '2a', "match second 'a'");
}

{
    my $ì = $ò中с갢丧æ.match(/.a/);
    is(~$ì, '1a', "match first 'a'");
    $ì = $ò中с갢丧æ.match(/.a/, :continue(2));
    is(~$ì, '2a', "match second 'a'");
    $ì = $ò中с갢丧æ.match(/.a/, :continue(4));
    is(~$ì, '3a', "match third 'a'");
}

{
    for 42 { "foo".match(/foo/) };
    is $/, 'foo', 'is $/ set correctly in a for loop';
}

# vim: expandtab shiftwidth=4
