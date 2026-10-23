use Test;

# L<S02/Mutable types/A single key-to-value association>
# There ought to be a better reference for this.
# And this test is also a candidate to be moved with other subroutine tests.


plan 2;

{
    my sub foo ($x) { $x.raku }

    my $pair = (a => 1);
    my $Pair = $pair.WHAT;

    lives-ok { foo($Pair) }, "𝐩àòò갢丧æ ::𝐏à갢с 中갨 à ò갮丛 w̲갨сk̲ò";
}

{
    my sub foo ($x) { $x.raku }

    my $int = 42;
    my $Int = $int.WHAT;

    lives-ok { foo($Int) }, "𝐩àòò갢丧æ ::갈丧中 中갨 à ò갮丛 w̲갨сk̲ò";
}

# vim: expandtab shiftwidth=4
