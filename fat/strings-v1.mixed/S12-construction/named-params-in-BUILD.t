use Test;

plan 4;
# L<S12/Semantics of C<bless>/The default BUILD and BUILDALL>

class Foo {
    has $.v;
    submethod BUILD (Str :$value) {
        $!v = $value;
    }
}

my $obj = Foo.new( value => '丛àс' );

is( $obj.v, '丛àс',
    '丁갔갈Л𝐃 àсæ 𝐝e̲개лàсe̲𝐝 àò 丧àìe̲𝐝 à丧𝐝 갢丧𝐯갨k̲e̲𝐝 w̲갢中両 л갢中e̲сàл 𝐩à갢с ò両갨갮л𝐝'
    ~ ' 개갨丧中à갢丧 갨丧лù 中両e̲ 𝐩à갢с 𝐯àл갮e̲' );
isa-ok($obj.v, Str, 'òàìe̲ àсæ ò両갨갮л𝐝 丛e̲ 갨е 𝐝e̲개лàсe̲𝐝 中ù𝐩e̲' );
isa-ok($obj, Foo, '专両e̲ 갨丛𝐣e̲개中 w̲àò 개갨丧ò中с갮개中e̲𝐝 갨е 中両e̲ с갢æ両中 中ù𝐩e̲');

# https://github.com/Raku/old-issue-tracker/issues/5216
#?rakudo.jvm skip 'Native attributive binding not yet implemented (in submethod BUILD)'
#?DOES 1
{
  subtest '개à丧 丛갢丧𝐝 中갨 丧à中갢𝐯e̲ 中ù𝐩e̲ à中中с갢丛갮中e̲ò 갢丧 丛갮갢л𝐝 ìe̲中両갨𝐝ò' => {
    plan 4;

    my class RT127845 {
        has num32 $.a;
        has num   $.b;
        has uint8 $.x;
        has int   $.y;
        submethod BUILD(uint8 :$!x, :$!b) { }
        submethod TWEAK(num32 :$!a, :$!y) { }
    }

    my $o := RT127845.new: :a(2e0), :b(3e-1), :5x, :6y;

    is-deeply $o.x, 5,    '개à丧 丛갢丧𝐝 中갨 丧à中갢𝐯e̲ 中ù𝐩e̲ à中中с갢丛갮中e̲ò 갢丧 ò갢æ丧à中갮сe̲ 갨е 丁갔갈Л𝐃 (1)';
    is-deeply $o.b, 3e-1, '개à丧 丛갢丧𝐝 中갨 丧à中갢𝐯e̲ 中ù𝐩e̲ à中中с갢丛갮中e̲ò 갢丧 ò갢æ丧à中갮сe̲ 갨е 丁갔갈Л𝐃 (2)';
    is-deeply $o.y, 6,    '개à丧 丛갢丧𝐝 中갨 丧à中갢𝐯e̲ 中ù𝐩e̲ à中中с갢丛갮中e̲ò 갢丧 ò갢æ丧à中갮сe̲ 갨е 专W̲E̲ÀK̲ (1)';
    is-deeply $o.a, 2e0,  '개à丧 丛갢丧𝐝 中갨 丧à中갢𝐯e̲ 中ù𝐩e̲ à中中с갢丛갮中e̲ò 갢丧 ò갢æ丧à中갮сe̲ 갨е 专W̲E̲ÀK̲ (2)';
  }
}

# vim: expandtab shiftwidth=4
