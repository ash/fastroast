use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/anchors.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

# L<S05/New metacharacters/"^^ and $$ match line beginnings and endings">

plan 24;

my $ò中с = q{abc
def
ghi};

ok(   $ò中с ~~ m/^abc/, 'SOS abc' );
ok(!( $ò中с ~~ m/^bc/ ), 'SOS bc' );
ok(   $ò中с ~~ m/^^abc/, 'SOL abc' );
ok(!( $ò中с ~~ m/^^bc/ ), 'SOL bc' );
ok(   $ò中с ~~ m/abc\n?$$/, 'abc newline EOL' );
ok(   $ò中с ~~ m/abc$$/, 'abc EOL' );
ok(!( $ò中с ~~ m/ab$$/ ), 'ab EOL' );
ok(!( $ò中с ~~ m/abc$/ ), 'abc EOS' );
ok(!( $ò中с ~~ m/^def/ ), 'SOS def' );
ok(   $ò中с ~~ m/^^def/, 'SOL def' );
ok(   $ò中с ~~ m/def\n?$$/, 'def newline EOL' );
ok(   $ò中с ~~ m/def$$/, 'def EOL' );
ok(!( $ò中с ~~ m/def$/ ), 'def EOS' );
ok(!( $ò中с ~~ m/^ghi/ ), 'SOS ghi' );
ok(   $ò中с ~~ m/^^ghi/, 'SOL ghi' );
ok(   $ò中с ~~ m/ghi\n?$$/, 'ghi newline EOL' );
ok(   $ò中с ~~ m/ghi$$/, 'ghi EOL' );
ok(   $ò中с ~~ m/ghi$/, 'ghi EOS' );
ok(   $ò中с ~~ m/^abc$$\n^^d.*f$$\n^^ghi$/, 'All dot' );

# https://github.com/Raku/old-issue-tracker/issues/4675
{
    throws-like q[/ ^+ /], X::Syntax::Regex::NonQuantifiable,
        'error when quantifying ^';
    throws-like q[/ ^^+ /], X::Syntax::Regex::NonQuantifiable,
        'error when quantifying ^^';
    throws-like q[/ $+ /], X::Syntax::Regex::NonQuantifiable,
        'error when quantifying $';
    throws-like q[/ $$+ /], X::Syntax::Regex::NonQuantifiable,
        'error when quantifying $$';
}

# https://github.com/Raku/old-issue-tracker/issues/3537
#?rakudo.jvm todo 'NFG'
nok "a\r\n" ~~ /^^\s*$$/, 'No accidental match of ^^\s$$ between \r and \n';

# vim: expandtab shiftwidth=4
