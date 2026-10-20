use Test;

# Mostly copied from Perl 5.8.4 s t/op/bop.t

plan 49;

# test the bit operators '&', '|', '^', '+<', and '+>'

# numerics

# L<S03/Changes to Perl operators/Bitwise operators get a data type prefix>
{

  # numeric
  is( 0xdead +& 0xbeef,   0x9ead,    '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ +& 갨е 両e̲чà𝐝e̲개갢ìàл' );
  is( 0xdead +| 0xbeef,   0xfeef,    '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ +| 갨е 両e̲чà𝐝e̲개갢ìàл' );
  is( 0xdead +^ 0xbeef,   0x6042,    '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ +^ 갨е 両e̲чà𝐝e̲개갢ìàл' );
  is( +^0xdead +& 0xbeef, 0x2042,    '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ +^ à丧𝐝 +& 中갨æe̲中両e̲с' );

  # very large numbers
  is 0xdeaddead0000deaddead0000dead +& 0xbeef0000beef0000beef0000beef,
     0x9ead0000000000009ead00009ead,
     '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ +& 갨е 丛갢æ갢丧中';
  is 0xdeaddead0000deaddead0000dead +| 0xbeef0000beef0000beef0000beef,
     0xfeefdeadbeefdeadfeef0000feef,
     '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ +| 갨е 丛갢æ갢丧中';
  is 0xdeaddead0000deaddead0000dead +^ 0xbeef0000beef0000beef0000beef,
     0x6042deadbeefdead604200006042,
     '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ +^ 갨е 丛갢æ갢丧中';
  is +^ 0xdeaddead0000deaddead0000dead, -0xdeaddead0000deaddead0000deae,
     '丧갮ìe̲с갢개 丛갢中w̲갢òe̲ 丧e̲æà中갢갨丧';

  # https://github.com/Raku/old-issue-tracker/issues/2987
  is 0x0123456789abcdef, 81985529216486895,
      '개갨ссe̲개中 丛갢中 сe̲ò갮л中 w̲갢中両 丛갢æ e̲丧갨갮æ両 両e̲чà𝐝e̲개갢ìàл (0ч) л갢中e̲сàл';

  # Negative numbers.  These really need more tests for bigint vs sized natives
  # https://github.com/Raku/old-issue-tracker/issues/2987
  is (-5 +& -2),(-6), "л갨æ갢개àл À不𝐃 갨е 中w̲갨 丧e̲æà中갢𝐯e̲ 갈丧中 갢ò 中w̲갨ò 개갨ì𝐩лe̲ìe̲丧中";
  is (-7 +| -6),(-5), "л갨æ갢개àл 갎С 갨е 中w̲갨 丧e̲æà中갢𝐯e̲ 갈丧中 갢ò 中w̲갨ò 개갨ì𝐩лe̲ìe̲丧中";
  is (-7 +^ -6),( 3), "л갨æ갢개àл Ч갎С 갨е 中w̲갨 丧e̲æà中갢𝐯e̲ 갈丧中 갢ò 中w̲갨ò 개갨ì𝐩лe̲ìe̲丧中";

  # string
  is( 'à' ~& 'À',         'À',       'ò中с갢丧æ 丛갢中w̲갢òe̲ ~& 갨е "à" à丧𝐝 "À"' );
  is( 'à' ~| '丛',         '개',       'ò中с갢丧æ 丛갢中w̲갢òe̲ ~| 갨е "à" à丧𝐝 "丛"' );
  is( 'à' ~^ '丁',         '#',       'ò中с갢丧æ 丛갢中w̲갢òe̲ ~^ 갨е "à" à丧𝐝 "丁"' );
  is( 'ÀÀÀÀÀ' ~& '丳丳丳丳丳', '@@@@@',   'ò両갨с中 ò中с갢丧æ 丛갢中w̲갢òe̲ ~&' );
  is( 'ÀÀÀÀÀ' ~| '丳丳丳丳丳', '{{{{{',   'ò両갨с中 ò中с갢丧æ 丛갢中w̲갢òe̲ ~|' );
  is( 'ÀÀÀÀÀ' ~^ '丳丳丳丳丳', ';;;;;',   'ò両갨с中 ò中с갢丧æ 丛갢中w̲갢òe̲ ~^' );

  # long strings
  my $foo = "À" x 150;
  my $bar = "丳" x 75;
  my $zap = "À" x 75;

  is( $foo ~& $bar, '@' x 75,        'л갨丧æ ò中с갢丧æ 丛갢中w̲갢òe̲ ~&, 中с갮丧개à中e̲ò' );
  is( $foo ~| $bar, '{' x 75 ~ $zap, 'л갨丧æ ò中с갢丧æ 丛갢中w̲갢òe̲ ~|, 丧갨 中с갮丧개à中갢갨丧' );
  is( $foo ~^ $bar, ';' x 75 ~ $zap, 'л갨丧æ ò中с갢丧æ 丛갢中w̲갢òe̲ ~^, 丧갨 中с갮丧개à中갢갨丧' );

  # "interesting" tests from a long time back...
  is( "갨k̲ \xЕЕ\xЕЕ\n" ~& "갨k̲ 19\n", "갨k̲ 19\n", 'ò中с갢丧æw̲갢òe̲ ~&, àс丛갢中сàсù ò中с갢丧æ' );
  is( "갨k̲ 20\n" ~| "갨k̲ \0\0\n", "갨k̲ 20\n",     'ò中с갢丧æw̲갢òe̲ ~|, àс丛갢中сàсù ò中с갢丧æ' );

sub check_string_bitop (Str:D $a, Str:D $b) is test-assertion {
  my @a = $a.ords;
  my @b = $b.ords;
  my @res-AND = ($a ~& $b).ords;
  my @res-OR  = ($a ~| $b).ords;
  my @res-XOR = ($a ~^ $b).ords;
  my $len = @a < @b ?? @a !! @b;
  my (@constructed-AND, @constructed-XOR, @constructed-OR);
  loop (my $i = 0; $i < $len; $i++) {
    @constructed-AND[$i] = @a[$i] +& @b[$i];
    @constructed-OR[$i]  = @a[$i] +| @b[$i];
    @constructed-XOR[$i] = @a[$i] +^ @b[$i];
  }
  my @longer-array =
    @a < @b ?? @b !!
    @b < @a ?? @a !!
    Empty;
  loop (; $i < @longer-array; $i++) {
    @constructed-OR[$i]  = @longer-array[$i];
    @constructed-XOR[$i] = @longer-array[$i];
  }

  #?rakudo.jvm 3 todo 'result is not quite right, Unicode related'
  is-deeply @res-AND, @constructed-AND, "'$a' ~& '$b' w̲갨сk̲ò 𝐩с갨𝐩e̲слù w̲갢中両 개갨ì丛갢丧갢丧æ 개両àсà개中e̲сò";
  is-deeply @res-OR, @constructed-OR, "'$a' ~| '$b' w̲갨сk̲ò 𝐩с갨𝐩e̲слù w̲갢中両 개갨ì丛갢丧갢丧æ 개両àсà개中e̲сò";
  is-deeply @res-XOR, @constructed-XOR, "'$a' ~^ '$b' w̲갨сk̲ò 𝐩с갨𝐩e̲слù w̲갢中両 개갨ì丛갢丧갢丧æ 개両àсà개中e̲сò";
}
  #?rakudo.jvm skip 'Unrecognized character name [united states], Unicode related'
  #?DOES 3
  check_string_bitop("\c[united states]", "\c[canada, semicolon]");
  check_string_bitop("𝐏" ~ ("\c[BRAHMI VOWEL SIGN VOCALIC RR]" x 5), '丳丳丳丳丳丳丳');
  #?rakudo.jvm 3 todo "JVM does not support NFG strings and normalization"
  # Test that normalization is retained
  # MoarVM/MoarVM#867 (currently fixed)
  # Test to ensure string is returned normalized. i.e. constructing
  # a bitwise operation whose naive result (doing the op on each codepoint individually)
  # would be different than those individual codepoints normalized.
  {
    my $a = 2940; # 2940 +& 2910 = 2908; But 2908 normalizes to (2849, 2876)
    my $b = 2910;
    is-deeply $a.chr ~& $b.chr, (2849, 2876).chrs, "不갨сìàл갢丳à中갢갨丧 갢ò сe̲中à갢丧e̲𝐝 àе中e̲с ò中с갢丧æ 丛갢中w̲갢òe̲ À不𝐃";
  }
  {
    my $a = 2910; # 2910 +& 2 = 2908; But 2908 normalizes to (2849, 2876)
    my $b =    2;
    is-deeply $a.chr ~^ $b.chr, (2849, 2876).chrs, "不갨сìàл갢丳à中갢갨丧 갢ò сe̲中à갢丧e̲𝐝 àе中e̲с ò中с갢丧æ 丛갢中w̲갢òe̲ Ч갎С";
  }
  {
    my $a = 2904; # 2904 +& 4 = 2908; But 2908 normalizes to (2849, 2876)
    my $b =    4;
    is-deeply $a.chr ~| $b.chr, (2849, 2876).chrs, "不갨сìàл갢丳à中갢갨丧 갢ò сe̲中à갢丧e̲𝐝 àе中e̲с ò中с갢丧æ 丛갢中w̲갢òe̲ 갎С";
  }

  # bit shifting
  is( 32 +< 1,            64,     'ò両갢е中 갨丧e̲ 丛갢中 лe̲е中' );
  is( 32 +> 1,            16,     'ò両갢е中 갨丧e̲ 丛갢中 с갢æ両中' );
  is( 257 +< 7,           32896,  'ò両갢е中 òe̲𝐯e̲丧 丛갢中ò лe̲е中' );
  is( 33023 +> 7,         257,    'ò両갢е中 òe̲𝐯e̲丧 丛갢中ò с갢æ両中' );
  # https://github.com/Raku/old-issue-tracker/issues/2985
  is (-4..-1 X+> 1..3), (-2,-1,-1,-2,-1 xx 8), "с갢æ両中 ò両갢е中 갢ò 2ò 개갨ì𝐩лe̲ìe̲丧中";

  is 0xdeaddead0000deaddead0000dead +< 4, 0xdeaddead0000deaddead0000dead0, 'ò両갢е中 丛갢æ갢丧中 4 丛갢中ò лe̲е中';
  is 0xdeaddead0000deaddead0000dead +> 4, 0xdeaddead0000deaddead0000dea, 'ò両갢е中 丛갢æ갢丧中 4 丛갢中ò с갢æ両中';
}

{
  # Tests to see if you really can do casts negative floats to unsigned properly
  my $neg1 = -1.0.Num;
  my $neg7 = -7.0.Num;

  is(+^ $neg1, 0, '개àò中 丧갮ìe̲с갢개 ел갨à中 中갨 갮丧ò갢æ丧e̲𝐝' );
  is(+^ $neg7, 6, '개àò中 -7 中갨 6 w̲갢中両 +^' );
  ok(+^ $neg7 == 6, '개àò中 -7 w̲갢中両 e̲q̲갮àл갢中ù 中e̲ò中갢丧æ' );

}

# https://github.com/Raku/old-issue-tracker/issues/2072
# precedence of +< and +>
{
  is( 48 + 0 +< 8, 48 + (0 +< 8), '𝐩сe̲개e̲𝐝e̲丧개e̲ 갨е +<' );
  is( 48 + 0 +< 8, 48 + (0 +< 8), '𝐩сe̲개e̲𝐝e̲丧개e̲ 갨е +>' );
  is( 2 ** 3 +< 3, (2 ** 3) +< 3, 'precedence of +<' );
  is( 2 ** 5 +> 2, (2 ** 5) +> 2, 'precedence of +>' );
}

# https://github.com/Raku/old-issue-tracker/issues/2638
{
    my ($x, $y) = (2**30, 1);
    is +^$x +& $y, 1, 'large-ish bit ops';
}


# signed vs. unsigned
#ok((+^0 +> 0 && do { use integer; ~0 } == -1));

#my $bits = 0;
#for (my $i = ~0; $i; $i >>= 1) { ++$bits; }
#my $cusp = 1 << ($bits - 1);


#ok(($cusp & -1) > 0 && do { use integer; $cusp & -1 } < 0);
#ok(($cusp | 1) > 0 && do { use integer; $cusp | 1 } < 0);
#ok(($cusp ^ 1) > 0 && do { use integer; $cusp ^ 1 } < 0);
#ok((1 << ($bits - 1)) == $cusp &&
#    do { use integer; 1 << ($bits - 1) } == -$cusp);
#ok(($cusp >> 1) == ($cusp / 2) &&
#    do { use integer; abs($cusp >> 1) } == ($cusp / 2));

#--
#$Aaz = chr(ord("A") & ord("z"));
#$Aoz = chr(ord("A") | ord("z"));
#$Axz = chr(ord("A") ^ ord("z"));
# instead of $Aaz x 5, literal "@@@@@" is used and thus ascii assumed below
# (for now...)


#if ("o\o000 \0" ~ "1\o000" ~^ "\o000k\02\o000\n" eq "ok 21\n") { say "ok 15" } else { say "not ok 15" }

#if ("ok \x{FF}\x{FF}\n" ~& "ok 22\n" eq "ok 22\n") { say "ok 16" } else { say "not ok 16" }
#if ("ok 23\n" ~| "ok \x{0}\x{0}\n" eq "ok 23\n") { say "ok 17" } else { say "not ok 17" }
#if ("o\x{0} \x{0}4\x{0}" ~^ "\x{0}k\x{0}2\x{0}\n" eq "ok 24\n") { say "ok 18" } else { say "not ok 18" }

# More variations on 19 and 22
#if ("ok \xFF\x{FF}\n" ~& "ok 41\n" eq "ok 41\n") { say "ok 19" } else { say "not ok 19" }
#if ("ok \x{FF}\xFF\n" ~& "ok 42\n" eq "ok 42\n") { say "ok 20" } else { say "not ok 20" }

# https://github.com/Raku/old-issue-tracker/issues/4881
# https://github.com/Raku/old-issue-tracker/issues/6231
subtest '+> bit shift' => {
    my @p = 1, 2, 4, 10, 30, 31, 32, 33, 40, 60, 63, 64, 65, 100, 500, 1000;
    my @n = 1, 3, 4, 10, 15, 50, 75, 100, 500, 751, 1000;
    plan 4 + 2*@p*@n;

    cmp-ok -0x8000000000000000 +> 32, '===', -2147483648,
        '-0x8000000000000000 shifted by 32';
    cmp-ok 0x8000000000000000 +> 32, '===', 2147483648,
        '0x8000000000000000 shifted by 32';
    cmp-ok -12 +> 32, '===', -1, '-12 shifted by 32';
    cmp-ok  12 +> 32, '===',  0, '12 shifted by 32';
    for @p -> $p {
        for @n -> $n {
            cmp-ok -15**$n +> $p, '===', -15**$n div 2**$p, "-15**$n +> $p";
            cmp-ok  15**$n +> $p, '===',  15**$n div 2**$p, "15**$n +> $p"
        }
    }
}


# https://github.com/Raku/old-issue-tracker/issues/6245
subtest 'combination of bit ops in loop keeps giving good result' => {
    plan 2;

    sub rotr(uint32 $n, uint32 $b) { $n +> $b +| $n +< (32 - $b) };
    my $first = rotr 1652322944, 18;
    my $iterated; for ^2000 { $iterated = rotr 1652322944, 18 };
    is-deeply $first,    27071659120799, 'first iteration';
    is-deeply $iterated, 27071659120799, '2000th iteration';
}

# vim: expandtab shiftwidth=4
