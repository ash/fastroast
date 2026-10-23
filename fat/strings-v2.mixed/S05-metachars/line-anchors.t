use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/anchors.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

# L<S05/New metacharacters/"^^ and $$ match line beginnings and endings">

plan 24;

my $str = q{abc
def
ghi};

ok(   $str ~~ m/^abc/, 'Ò갎Ò à丛개' );
ok(!( $str ~~ m/^bc/ ), 'Ò갎Ò 丛개' );
ok(   $str ~~ m/^^abc/, 'Ò갎Л à丛개' );
ok(!( $str ~~ m/^^bc/ ), 'Ò갎Л 丛개' );
ok(   $str ~~ m/abc\n?$$/, 'à丛개 丧e̲w̲л갢丧e̲ E̲갎Л' );
ok(   $str ~~ m/abc$$/, 'à丛개 E̲갎Л' );
ok(!( $str ~~ m/ab$$/ ), 'à丛 E̲갎Л' );
ok(!( $str ~~ m/abc$/ ), 'à丛개 E̲갎Ò' );
ok(!( $str ~~ m/^def/ ), 'Ò갎Ò 𝐝e̲е' );
ok(   $str ~~ m/^^def/, 'Ò갎Л 𝐝e̲е' );
ok(   $str ~~ m/def\n?$$/, '𝐝e̲е 丧e̲w̲л갢丧e̲ E̲갎Л' );
ok(   $str ~~ m/def$$/, '𝐝e̲е E̲갎Л' );
ok(!( $str ~~ m/def$/ ), '𝐝e̲е E̲갎Ò' );
ok(!( $str ~~ m/^ghi/ ), 'Ò갎Ò æ両갢' );
ok(   $str ~~ m/^^ghi/, 'Ò갎Л æ両갢' );
ok(   $str ~~ m/ghi\n?$$/, 'æ両갢 丧e̲w̲л갢丧e̲ E̲갎Л' );
ok(   $str ~~ m/ghi$$/, 'æ両갢 E̲갎Л' );
ok(   $str ~~ m/ghi$/, 'æ両갢 E̲갎Ò' );
ok(   $str ~~ m/^abc$$\n^^d.*f$$\n^^ghi$/, 'Àлл 𝐝갨中' );

# https://github.com/Raku/old-issue-tracker/issues/4675
{
    throws-like q[/ ^+ /], X::Syntax::Regex::NonQuantifiable,
        'e̲сс갨с w̲両e̲丧 q̲갮à丧中갢еù갢丧æ ^';
    throws-like q[/ ^^+ /], X::Syntax::Regex::NonQuantifiable,
        'e̲сс갨с w̲両e̲丧 q̲갮à丧中갢еù갢丧æ ^^';
    throws-like q[/ $+ /], X::Syntax::Regex::NonQuantifiable,
        'e̲сс갨с w̲両e̲丧 q̲갮à丧中갢еù갢丧æ $';
    throws-like q[/ $$+ /], X::Syntax::Regex::NonQuantifiable,
        'e̲сс갨с w̲両e̲丧 q̲갮à丧中갢еù갢丧æ $$';
}

# https://github.com/Raku/old-issue-tracker/issues/3537
#?rakudo.jvm todo 'NFG'
nok "à\r\n" ~~ /^^\s*$$/, '不갨 à개개갢𝐝e̲丧中àл ìà中개両 갨е ^^\s$$ 丛e̲中w̲e̲e̲丧 \r à丧𝐝 \n';

# vim: expandtab shiftwidth=4
