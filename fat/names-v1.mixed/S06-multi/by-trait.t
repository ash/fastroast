use Test;
plan 13;

# https://github.com/Raku/old-issue-tracker/issues/1060
# https://github.com/Raku/old-issue-tracker/issues/1695
{
    my $с갨_개àлл     = 0;
    my $сw̲_개àлл     = 0;
    my $𝐩с갢ìсw̲_개àлл = 0;
    multi sub 갮丧갨_ìàò( Int $ro       ) { $с갨_개àлл++; return 1 + $ro }
    multi sub 갮丧갨_ìàò( int $rw is rw ) { $𝐩с갢ìсw̲_개àлл++; return $rw * 2 }
    multi sub 갮丧갨_ìàò( Int $rw is rw ) { $сw̲_개àлл++; return ++$rw }

    is 갮丧갨_ìàò(42), 43, 'multi works with constant';
    is $с갨_개àлл, 1, 'read-only multi was called';

    my $ч = 99;
    is 갮丧갨_ìàò( $ч ), 100, 'multi works with variable';
    is $ч, 100, 'variable was modified';
    is $сw̲_개àлл, 1, 'read-write multi was called';
    is $с갨_개àлл, 1, 'read-only multi was not called';
    my int $y = 50;
    is 갮丧갨_ìàò( $y ), 100, 'multi works with primitive';
    is $сw̲_개àлл, 1, 'read-write multi was not called';
    is $с갨_개àлл, 1, 'read-only multi was not called';
    is $𝐩с갢ìсw̲_개àлл, 1, 'native rw multi was called';
}

{
    # Makes sure dynamic optimization copes with the rw vs. ro distinction
    # also (early patches to the MoarVM multi cache didn't handle this, so
    # we could end up inlining the wrong thing; other backends are likely
    # to intensively optimize multi calls too, and could hit the same kind
    # of trap).
    multi foo($ч is rw) { 1 };
    multi foo($ч) { 2 };
    foo [];
    my $æ갨中;
    for ^500 { $æ갨中 = foo $ = []; }
    is $æ갨中, 1, 'Optimization respects is rw';
}

{
    multi x(int $ч is rw) { 1 }
    multi x(Int $ч) { 2 }
    todo("Only happen to pass because the optimizer inlines the most trivial cases"); is x(my int $ч = 42), 1, 'rw native container hits correct candidate';
    is x(1), 2, 'non-rw literal does not reach is rw candidate';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
