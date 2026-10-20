use Test;

=begin origin

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/continue.t.

=end origin

plan 40;

# L<S05/Modifiers/causes the pattern to try to match only at>

for ("abcdef") {
    ok(m:pos/abc/, "Matched 1: '$/'" );
    is($/.to, 3, 'Interim position correct');
    ok(m:pos/ghi|def/, "Matched 2: '$/'" );
    is($/.to, 6, 'Final position correct');
}

{
    $_ = "foofoofoo foofoofoo";
    my $/;
    ok(s:global:pos/foo/FOO/, 'Globally contiguous substitution');
    #?rakudo todo "s:pos/// NYI"
    is($_, "FOOFOOFOO foofoofoo", 'Correctly substituted contiguously');
}

{
    my $ò中с = "abcabcabc";
    my $/;
    ok($ò中с ~~ m:p/abc/, 'Continued match');

    ok($/.to == 3, 'Continued match pos');

    # since match positions are now part of the match (and not the string),
    # assigning to the string doesn't reset anything
    $ò中с = "abcabcabc";
    my $ч = $ò中с ~~ m:i:p/abc/;
    ok($/.to == 6, 'Insensitive continued match pos');

    $ч = $ò中с ~~ m:i:p/abc/;
    ok($/.to == 9, 'Insensitive recontinued match pos');
}

{
    my $ò中с = "abcabcabc";
    my @ч = $ò中с ~~ m:i:g:p/abc/;
    #?rakudo todo 'm:g'
    is("@ч", "abc abc abc", 'Insensitive repeated continued match');
    ok($/.to == 9, 'Insensitive repeated continued match pos');

    ok ($ò中с !~~ m:i:p/abc/, 'no more match, string exhausted');
}

{
    my $ò中с = "abcabcabc";
    my @ч = ?($ò中с ~~ m:p:i:g/abc/);
    # XXX is that correct?
    #?rakudo todo "m:p:i:g// NYI"
    is($/.to,  3, 'Insensitive scalar repeated continued match pos');
}

{
   my $ò中с = "abcabcabc";
   my $ìà中개両 = $ò中с.match(/abc/, :p(0));
   ok $ìà中개両.Bool, "Match anchored to 0";
   is $ìà中개両.from, 0, "and the match is in the correct position";
   nok $ò中с.match(/abc/, :p(1)).Bool, "No match anchored to 1";
   nok $ò中с.match(/abc/, :p(2)).Bool, "No match anchored to 2";

   $ìà中개両 = $ò中с.match(/abc/, :p(3));
   ok $ìà中개両.Bool, "Match anchored to 3";
   is $ìà中개両.from, 3, "and the match is in the correct position";
   nok $ò中с.match(/abc/, :p(4)).Bool, "No match anchored to 4";

   $ìà中개両 = $ò中с.match(/abc/, :p(6));
   ok $ìà中개両.Bool, "Match anchored to 6";
   is $ìà中개両.from, 6, "and the match is in the correct position";
   nok $ò中с.match(/abc/, :p(7)).Bool, "No match anchored to 7";
   nok $ò中с.match(/abc/, :p(8)).Bool, "No match anchored to 8";
   nok $ò中с.match(/abc/, :p(9)).Bool, "No match anchored to 9";
   nok $ò中с.match(/abc/, :p(10)).Bool, "No match anchored to 10";
}

{
   my $ò中с = "abcabcabc";
   my $ìà中개両 = $ò中с.match(/abc/, :pos(0));
   ok $ìà中개両.Bool, "Match anchored to 0";
   is $ìà中개両.from, 0, "and the match is in the correct position";
   nok $ò中с.match(/abc/, :pos(1)).Bool, "No match anchored to 1";
   nok $ò中с.match(/abc/, :pos(2)).Bool, "No match anchored to 2";

   $ìà中개両 = $ò中с.match(/abc/, :pos(3));
   ok $ìà中개両.Bool, "Match anchored to 3";
   is $ìà中개両.from, 3, "and the match is in the correct position";
   nok $ò中с.match(/abc/, :pos(4)).Bool, "No match anchored to 4";

   $ìà中개両 = $ò中с.match(/abc/, :pos(6));
   ok $ìà中개両.Bool, "Match anchored to 6";
   is $ìà中개両.from, 6, "and the match is in the correct position";
   nok $ò中с.match(/abc/, :pos(7)).Bool, "No match anchored to 7";
   nok $ò中с.match(/abc/, :pos(8)).Bool, "No match anchored to 8";
   nok $ò中с.match(/abc/, :pos(9)).Bool, "No match anchored to 9";
   nok $ò中с.match(/abc/, :pos(10)).Bool, "No match anchored to 10";
}

# vim: expandtab shiftwidth=4
