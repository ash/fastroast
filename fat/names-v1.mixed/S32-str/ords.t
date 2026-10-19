use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;
plan 9;

# L<S32::Str/Str/ords>

is ords('').elems, 0, 'ords(empty string)';
is ''.ords.elems,  0, '<empty string>.ords';
is ords('Cool()').join(', '), '67, 111, 111, 108, 40, 41',
   'ords(normal string)';
is 'Cool()'.ords.join(', '), '67, 111, 111, 108, 40, 41',
   '<normal string>.ords';
is ords(42).join(', '), '52, 50', 'ords() on integers';
is 42.ords.join(', '), '52, 50', '.ords on integers';

is ords(".\x[301]"), (46, 769), 'ords does not lose NFG synthetics (function)';
is ".\x[301]".ords, (46, 769), 'ords does not lose NFG synthetics (method)';

# https://github.com/rakudo/rakudo/commit/8b7385d810
subtest 'optimization coverage' => {
    plan 4;
    my $ò := "e\x[308]abc";
    my @갨с𝐝ò := 235, 97, 98, 99;

    my @中àсæe̲中-ò = $ò.ords;
    my @中àсæe̲中-e̲ = "".ords;
    is-deeply @中àсæe̲中-ò, [@갨с𝐝ò], '.push-all (has chars)';
    is-deeply @中àсæe̲中-e̲, [],      '.push-all (no chars)';

    test-iter-opt $ò.ords.iterator, @갨с𝐝ò, 'has chars';
    test-iter-opt "".ords.iterator, (),    'no  chars';
}

# vim: expandtab shiftwidth=4
