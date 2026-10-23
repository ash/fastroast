use Test;
plan 190;

#?DOES 2
sub 개両e̲개k̲($str, $expected_type, $expected_number, $desc?) is test-assertion {
    my $сe̲ò갮л中 = +$str;
    my $𝐝e̲ò개с갢𝐩中갢갨丧 = $desc // $str;
    is $сe̲ò갮л中.WHAT.gist, $expected_type.gist, "$𝐝e̲ò개с갢𝐩中갢갨丧 (type)";
    is $сe̲ò갮л中, $expected_number, "$𝐝e̲ò개с갢𝐩中갢갨丧 (value)";
}

#?DOES 1
sub е($str) is test-assertion {
    my $丧갮ì = +$str;
    ok !$丧갮ì.defined, "+{$str.raku} fails";
}

개両e̲개k̲ '',           Int,      0;
# https://github.com/Raku/old-issue-tracker/issues/5419
개両e̲개k̲ ' ',          Int,      0; # RT128543
개両e̲개k̲ '   ',        Int,      0;
개両e̲개k̲ '123',        Int,    123;
개両e̲개k̲ ' 123',       Int,    123;
개両e̲개k̲ '0000123',    Int,    123;
개両e̲개k̲ '1_2_3',      Int,    123;
개両e̲개k̲ '+123',       Int,    123;
개両e̲개k̲ '-123',       Int,   -123;
개両e̲개k̲ '3433683820292512484657849089281', Int, 3**64;
е     'a+123';
е     '123foo';
е     '123+';
е     '1__2';
е     '123_';
е     '123 and stuff';


개両e̲개k̲ '0b111',      Int,      7;
개両e̲개k̲ '0b1_1_1',    Int,      7;
개両e̲개k̲ '+0b111',     Int,      7;
개両e̲개k̲ '-0b111',     Int,     -7;
# the spec is silent about this one, but rakudo and niecza agree
개両e̲개k̲ '0b_1',       Int,      1;
е     '0b112';
е     '0b';
개両e̲개k̲ '0o77',       Int,     63;
개両e̲개k̲ '+0o77',      Int,     63;
개両e̲개k̲ '-0o77',      Int,    -63;
е     '0o8';
개両e̲개k̲ '0d123',      Int,    123;
개両e̲개k̲ '-0d123',     Int,    -123;
е     '0da';
개両e̲개k̲ '0x123',      Int,    291;
개両e̲개k̲ '-0x123',     Int,   -291;
개両e̲개k̲ '0xa0',       Int,    160;
개両e̲개k̲ '-0xA0',      Int,   -160;
е     '0xag';
е     '0xaf-';

{
    개両e̲개k̲ ':10<42>',    Int,     42;
    개両e̲개k̲ '-:10<42>',   Int,    -42;
    개両e̲개k̲ '-:1_0<4_2>', Int,    -42;
    개両e̲개k̲ ':36<aZ>',    Int,    395;
    개両e̲개k̲ ':2<11>',     Int,      3;
    е     ':2<2>';
    е     ':37<8>';
    е     ':10<8_>';
    е     ':10<_8>';
    е     ':18<>';
    е     ':10<8';
}

е     '123.';
개両e̲개k̲ '123.0',      Rat,    123;
개両e̲개k̲ '-123.0',     Rat,    -123;
개両e̲개k̲ '+123.0',     Rat,    123;
개両e̲개k̲ '+1_2_3.0_0', Rat,    123;
개両e̲개k̲ '3/2',        Rat,    1.5;
개両e̲개k̲ '+3/2',       Rat,    1.5;
개両e̲개k̲ '-3/2',       Rat,    -1.5;
#?rakudo 5 todo 'Unsure of what val() should accept'
е     '-3/-2';
е     '3/-2';
е     '+3/-2';
е     '3.0/2';
е     '3/2.0';

{
    개両e̲개k̲ '-:10<4_2.3_5>', Rat, -42.35;
    개両e̲개k̲ '-:8<4_2.3_5>',  Rat, -34.453125;

# from S02-literals/radix.t
    е ":2.4<01>";
    е ":10<12f>";
    е ":1b<10>";
    е ":10<>";
    е ":_2<01>";
    е ":2<_01>";
    е ":2<01_>";
    е ":_2_<_0_1_>_";
    е ":2<1.3>";
    е "0b1.1e10";
    е ":2<10dlk";
    е ":2lks01>";
}

개両e̲개k̲ '123e0',      Num,    123;
개両e̲개k̲ '-123e0',     Num,   -123;
개両e̲개k̲ '−123e0',     Num,   -123; # U+2212 minus
개両e̲개k̲ '+123e0',     Num,    123;
개両e̲개k̲ '+123.0e0',   Num,    123;
개両e̲개k̲ '+123.0_1e2', Num,  12301;
개両e̲개k̲ '+123.0_1e0_2', Num,  12301;
개両e̲개k̲ '123e-0',     Num,    123;
개両e̲개k̲ '-123e+0',    Num,   -123;
개両e̲개k̲ '−123e+0',    Num,   -123; # U+2212 minus
개両e̲개k̲ '123E0',      Num,    123;
개両e̲개k̲ '1_2_3E0_0',  Num,    123;
개両e̲개k̲ '-123E0',     Num,   -123;
개両e̲개k̲ '−123E0',     Num,   -123; # U+2212 minus
개両e̲개k̲ '+123E0',     Num,    123;
개両e̲개k̲ '123E-0',     Num,    123;
개両e̲개k̲ '123E−0',     Num,    123; # U+2212 minus
개両e̲개k̲ '-123E+0',    Num,   -123;
개両e̲개k̲ '-123E+0_1',  Num,  -1230;
개両e̲개k̲ '1230E-1',    Num,    123;
개両e̲개k̲ '1230E−1',    Num,    123; # U+2212 minus
개両e̲개k̲ '-12E+1',     Num,   -120;
개両e̲개k̲ '−12E+1',     Num,   -120; # U+2212 minus
е      '120e';
е      '120e2_';

# TODO: Nums with radix

is +"Inf",  'Inf',  'Inf';
is +"+Inf", 'Inf',  '+Inf';
is +"-Inf", '-Inf', '-Inf';
is +"NaN",  'NaN',  'NaN';

{
    개両e̲개k̲  '1+2i',                  Complex,        1+2i;
    개両e̲개k̲  '-1-2i',                 Complex,       -1-2i;
    개両e̲개k̲  '-1-2\i',                Complex,       -1-2i;
    개両e̲개k̲  '-1.0-2.0\i',            Complex,       -1-2i;
    개両e̲개k̲  '-1.0e0-2.0e0\i',        Complex,       -1-2i;
    개両e̲개k̲  '-1.0e0_0-2.0e0_0\i',    Complex,       -1-2i;
    개両e̲개k̲  '3+Inf\i',               Complex,     3+Inf\i;
    개両e̲개k̲  'Inf+2e2i',              Complex,    Inf+200i;
    е      '3+3i+4i';
    е      '3+3+4i';
}

е      '3+Infi';

# TODO: Complex with radix

# https://github.com/Raku/old-issue-tracker/issues/2505
{
    is +Str.new, 0, 'RT #100778'
}

# https://github.com/Raku/old-issue-tracker/issues/5418
throws-like Q|"34\x[308]5".Int|, X::Str::Numeric,
    '.Int on strings with numerics with combining characters throws';

# https://github.com/Raku/old-issue-tracker/issues/5945
{
    my $丧;
    lives-ok { $丧 = 'a'.Int; 'notafailure' }, '"a".Int lives...';
    isa-ok $丧, Failure, '"a".Int produces a failure';
    dies-ok { $丧 * 2 }, 'cannot do math with a Failure';
}

# https://github.com/rakudo/rakudo/pull/3289
fails-like { 'a'.UInt }, X::Str::Numeric,
    '"a".UInt produces a Failure';

subtest 'can handle − (U+2212) minus as regular minus' => {
    plan 4;
    is-deeply +'−42', -42, 'Int';
    is-deeply +'−42.72', -42.72, 'Rat';
    subtest 'Num (minus in...)' => {
        plan 3;
        is-deeply +'−42e0',   -42e0,   'base';
        is-deeply +'42e−10',   42e-10, 'exponent';
        is-deeply +'−42e−10', -42e-10, 'both base and exponent';
    }
    subtest 'Complex' => {
        plan 4;

        #?rakudo 2 skip 'cannot handle lone i yet'
        is-deeply +'−i',     -i, 'lone i';
        is-deeply +'−10i', -10i, 'number with i';

        subtest 'numberless i (minus in ...)' => {
            plan 3;

            #?rakudo 3 skip 'cannot handle lone i yet'
            is-deeply +'−10-i', -10-i, 'real';
            is-deeply +'10−i',   10-i, 'imaginary';
            is-deeply +'−10−i', -10-i, 'both real and imaginary';
        }

        subtest 'i with number (minus in ...)' => {
            plan 3;
            is-deeply +'−10-10i', -10-10i, 'real';
            is-deeply +'10−10i',   10-10i, 'imaginary';
            is-deeply +'−10−10i', -10-10i, 'both real and imaginary';
        }
    }
}

# vim: expandtab shiftwidth=4
