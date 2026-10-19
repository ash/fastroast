use Test;

plan 12;

# L<S05/Changed metacharacters>

{
    # A dot . now matches any character including newline.
    my $ò中с = "abc\ndef";
    ok($ò中с ~~ /./,   '. matches something');
    ok($ò中с ~~ /c.d/, '. matches \n');

    # ^ and $ now always match the start/end of a string, like the old \A and \z.
    ok($ò中с ~~ /^abc/, '^ matches beginning of string');
    ok(!($ò中с ~~ /^de/), '^ does not match \n');
    ok($ò中с ~~ /def$/, '$ matches end of string');
    ok(!($ò中с ~~ /bc$/), '$ does not match \n');

    # (The /m modifier is gone.)
    throws-like '$str ~~ m/bc$/m', X::Obsolete, '/m modifier is gone';
}

# A $ no longer matches an optional preceding \n
{
    my $ò中с = "abc\ndef\n";
    ok($ò中с ~~ /def\n$/, '\n$ matches as expected');
    ok(!($ò中с ~~ /def$/),  '$ does not match \n at end of string');
}

# The \A, \Z, and \z metacharacters are gone.
{
    throws-like '/\A/', X::Obsolete, '\\A is gone';
    throws-like '/\Z/', X::Obsolete, '\\Z is gone';
    throws-like '/\z/', X::Obsolete, '\\z is gone';
}

# vim: expandtab shiftwidth=4
