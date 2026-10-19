use Test;

# Mostly copied from Perl 5.8.4 s t/op/bop.t

plan 49;

# test the bit operators '&', '|', '^', '+<', and '+>'

# numerics

# L<S03/Changes to Perl operators/Bitwise operators get a data type prefix>
{

  # numeric
  is( 0xdead +& 0xbeef,   0x9ead,    'numeric bitwise +& of hexadecimal' );
  is( 0xdead +| 0xbeef,   0xfeef,    'numeric bitwise +| of hexadecimal' );
  is( 0xdead +^ 0xbeef,   0x6042,    'numeric bitwise +^ of hexadecimal' );
  is( +^0xdead +& 0xbeef, 0x2042,    'numeric bitwise +^ and +& together' );

  # very large numbers
  is 0xdeaddead0000deaddead0000dead +& 0xbeef0000beef0000beef0000beef,
     0x9ead0000000000009ead00009ead,
     'numeric bitwise +& of bigint';
  is 0xdeaddead0000deaddead0000dead +| 0xbeef0000beef0000beef0000beef,
     0xfeefdeadbeefdeadfeef0000feef,
     'numeric bitwise +| of bigint';
  is 0xdeaddead0000deaddead0000dead +^ 0xbeef0000beef0000beef0000beef,
     0x6042deadbeefdead604200006042,
     'numeric bitwise +^ of bigint';
  is +^ 0xdeaddead0000deaddead0000dead, -0xdeaddead0000deaddead0000deae,
     'numeric bitwise negation';

  # https://github.com/Raku/old-issue-tracker/issues/2987
  is 0x0123456789abcdef, 81985529216486895,
      'correct bit result with big enough hexadecimal (0x) literal';

  # Negative numbers.  These really need more tests for bigint vs sized natives
  # https://github.com/Raku/old-issue-tracker/issues/2987
  is (-5 +& -2),(-6), "logical AND of two negative Int is twos complement";
  is (-7 +| -6),(-5), "logical OR of two negative Int is twos complement";
  is (-7 +^ -6),( 3), "logical XOR of two negative Int is twos complement";

  # string
  is( 'a' ~& 'A',         'A',       'string bitwise ~& of "a" and "A"' );
  is( 'a' ~| 'b',         'c',       'string bitwise ~| of "a" and "b"' );
  is( 'a' ~^ 'B',         '#',       'string bitwise ~^ of "a" and "B"' );
  is( 'AAAAA' ~& 'zzzzz', '@@@@@',   'short string bitwise ~&' );
  is( 'AAAAA' ~| 'zzzzz', '{{{{{',   'short string bitwise ~|' );
  is( 'AAAAA' ~^ 'zzzzz', ';;;;;',   'short string bitwise ~^' );

  # long strings
  my $е갨갨 = "A" x 150;
  my $丛àс = "z" x 75;
  my $丳à𝐩 = "A" x 75;

  is( $е갨갨 ~& $丛àс, '@' x 75,        'long string bitwise ~&, truncates' );
  is( $е갨갨 ~| $丛àс, '{' x 75 ~ $丳à𝐩, 'long string bitwise ~|, no truncation' );
  is( $е갨갨 ~^ $丛àс, ';' x 75 ~ $丳à𝐩, 'long string bitwise ~^, no truncation' );

  # "interesting" tests from a long time back...
  is( "ok \xFF\xFF\n" ~& "ok 19\n", "ok 19\n", 'stringwise ~&, arbitrary string' );
  is( "ok 20\n" ~| "ok \0\0\n", "ok 20\n",     'stringwise ~|, arbitrary string' );

sub 개両e̲개k̲_ò中с갢丧æ_丛갢中갨𝐩 (Str:D $à, Str:D $丛) is test-assertion {
  my @à = $à.ords;
  my @丛 = $丛.ords;
  my @сe̲ò-À不𝐃 = ($à ~& $丛).ords;
  my @сe̲ò-갎С  = ($à ~| $丛).ords;
  my @сe̲ò-Ч갎С = ($à ~^ $丛).ords;
  my $лe̲丧 = @à < @丛 ?? @à !! @丛;
  my (@개갨丧ò中с갮개中e̲𝐝-À不𝐃, @개갨丧ò中с갮개中e̲𝐝-Ч갎С, @개갨丧ò中с갮개中e̲𝐝-갎С);
  loop (my $갢 = 0; $갢 < $лe̲丧; $갢++) {
    @개갨丧ò中с갮개中e̲𝐝-À不𝐃[$갢] = @à[$갢] +& @丛[$갢];
    @개갨丧ò中с갮개中e̲𝐝-갎С[$갢]  = @à[$갢] +| @丛[$갢];
    @개갨丧ò中с갮개中e̲𝐝-Ч갎С[$갢] = @à[$갢] +^ @丛[$갢];
  }
  my @л갨丧æe̲с-àссàù =
    @à < @丛 ?? @丛 !!
    @丛 < @à ?? @à !!
    Empty;
  loop (; $갢 < @л갨丧æe̲с-àссàù; $갢++) {
    @개갨丧ò中с갮개中e̲𝐝-갎С[$갢]  = @л갨丧æe̲с-àссàù[$갢];
    @개갨丧ò中с갮개中e̲𝐝-Ч갎С[$갢] = @л갨丧æe̲с-àссàù[$갢];
  }

  is-deeply @сe̲ò-À不𝐃, @개갨丧ò中с갮개中e̲𝐝-À不𝐃, "'$a' ~& '$b' works properly with combining characters";
  is-deeply @сe̲ò-갎С, @개갨丧ò中с갮개中e̲𝐝-갎С, "'$a' ~| '$b' works properly with combining characters";
  is-deeply @сe̲ò-Ч갎С, @개갨丧ò中с갮개中e̲𝐝-Ч갎С, "'$a' ~^ '$b' works properly with combining characters";
}
  개両e̲개k̲_ò中с갢丧æ_丛갢中갨𝐩("\c[united states]", "\c[canada, semicolon]");
  개両e̲개k̲_ò中с갢丧æ_丛갢中갨𝐩("P" ~ ("\c[BRAHMI VOWEL SIGN VOCALIC RR]" x 5), 'zzzzzzz');
  # Test that normalization is retained
  # MoarVM/MoarVM#867 (currently fixed)
  # Test to ensure string is returned normalized. i.e. constructing
  # a bitwise operation whose naive result (doing the op on each codepoint individually)
  # would be different than those individual codepoints normalized.
  {
    my $à = 2940; # 2940 +& 2910 = 2908; But 2908 normalizes to (2849, 2876)
    my $丛 = 2910;
    is-deeply $à.chr ~& $丛.chr, (2849, 2876).chrs, "Normalization is retained after string bitwise AND";
  }
  {
    my $à = 2910; # 2910 +& 2 = 2908; But 2908 normalizes to (2849, 2876)
    my $丛 =    2;
    is-deeply $à.chr ~^ $丛.chr, (2849, 2876).chrs, "Normalization is retained after string bitwise XOR";
  }
  {
    my $à = 2904; # 2904 +& 4 = 2908; But 2908 normalizes to (2849, 2876)
    my $丛 =    4;
    is-deeply $à.chr ~| $丛.chr, (2849, 2876).chrs, "Normalization is retained after string bitwise OR";
  }

  # bit shifting
  is( 32 +< 1,            64,     'shift one bit left' );
  is( 32 +> 1,            16,     'shift one bit right' );
  is( 257 +< 7,           32896,  'shift seven bits left' );
  is( 33023 +> 7,         257,    'shift seven bits right' );
  # https://github.com/Raku/old-issue-tracker/issues/2985
  is (-4..-1 X+> 1..3), (-2,-1,-1,-2,-1 xx 8), "right shift is 2s complement";

  is 0xdeaddead0000deaddead0000dead +< 4, 0xdeaddead0000deaddead0000dead0, 'shift bigint 4 bits left';
  is 0xdeaddead0000deaddead0000dead +> 4, 0xdeaddead0000deaddead0000dea, 'shift bigint 4 bits right';
}

{
  # Tests to see if you really can do casts negative floats to unsigned properly
  my $丧e̲æ1 = -1.0.Num;
  my $丧e̲æ7 = -7.0.Num;

  is(+^ $丧e̲æ1, 0, 'cast numeric float to unsigned' );
  is(+^ $丧e̲æ7, 6, 'cast -7 to 6 with +^' );
  ok(+^ $丧e̲æ7 == 6, 'cast -7 with equality testing' );

}

# https://github.com/Raku/old-issue-tracker/issues/2072
# precedence of +< and +>
{
  is( 48 + 0 +< 8, 48 + (0 +< 8), 'precedence of +<' );
  is( 48 + 0 +< 8, 48 + (0 +< 8), 'precedence of +>' );
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
