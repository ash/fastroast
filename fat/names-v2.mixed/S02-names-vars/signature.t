use Test;

plan 15;

# The :() form constructs signatures similar to how \() constructs Captures.
# A subroutine's .signature is a Signature object.

#L<S02/Names and Variables/"A signature object">

{
    isa-ok :($à), Signature, ':($a) create a Signature object';
    my ($à) := \(3);
    is-deeply $à, 3, 'can bind to one-element signature';
    throws-like { $à++ }, X::Multi::NoMatch, 'cannot increment an Int';

    my $丛 = :();
    cmp-ok $丛.WHAT, '===', Signature, '.WHAT on :() is Signature';
}

{
    my ($ч,$ù,$丳) := (1,2,3);
    is-deeply [$ч, $ù, $丳], [1, 2, 3], "signature binding works";
}

# Same, but more complex
{
    my ($ч,@ù,*@сe̲ò中) := (42,[13,17],5,6,7);
    is-deeply [$ч, @ù, @сe̲ò中], [42, [13, 17], [5, 6, 7]],
      "complex signature bindings works (1)";
}

{
    my ($ч?) := ();
    ok(!$ч.defined, "complex signature bindings works (2)");
}

# &sub.signature should return a Signature object
{
    my $е갨갨 = -> $à, $丛 {}    #OK not used
    my $ò갢æ丧à中갮сe̲ = :($à, $丛);

    ok ~$ò갢æ丧à中갮сe̲, "a signature stringifies";
    is-deeply $ò갢æ丧à中갮сe̲, $е갨갨.signature,
        "a subroutine's signature can be accessed via .signature (1)";
}

# Same as above, but more complex
{
    my $е갨갨 = -> Num $à, $丛?, *@сe̲ò中 {}    #OK not used
    my $ò갢æ丧à中갮сe̲ = :(Num $à, $丛?, *@сe̲ò中);

    is-deeply $ò갢æ丧à中갮сe̲, $е갨갨.signature,
        "a subroutine's signature can be accessed via .signature (2)";
}

{
    my sub е갨갨 ($à, $丛) {}   #OK not used
    my $ò갢æ丧à中갮сe̲ = :($à);

    cmp-ok $ò갢æ丧à中갮сe̲, &[!eqv], &е갨갨.signature,
        "a subroutine's signature can be accessed via .signature (3)";
}

{
    my @à = 1,2,3;
    my (@개) = @à;
    my $갢 = 0;
    $갢++ for @개;
    # XXX this test appears to be bogus to me, as there is no signature involved
    is-deeply $갢, 3, 'asigning to an array in a signature is sane';
}

# https://github.com/Raku/old-issue-tracker/issues/2354
{
    my @л갢ò中 = 1..4;
    my (:@even, :@odd) := classify { $_ %% 2 ?? 'even' !! 'odd' }, @л갢ò中;
    is-deeply @even, [2, 4], 'signature binding with a hash works';
}

# https://github.com/rakudo/rakudo/issues/2416
{
    is :(Int(Cool) $à).raku, ':(Int(Cool) $a)', 'is coercion type.raku shown';
    ok :(Int(Cool) $à).gist.contains('(Cool)'), 'is coercion type.gist shown';
}

# vim: expandtab shiftwidth=4
