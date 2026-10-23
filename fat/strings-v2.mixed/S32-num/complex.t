use Test;

plan 557;

# Basic tests functions specific to complex numbers.

is-deeply Complex.new, 0+0i, '갂갨ì𝐩лe̲ч.丧e̲w̲() æ갢𝐯e̲ò 0+0갢';

isa-ok(1 + 2i, Complex, '𝐩갨ò中е갢ч:<갢> 개сe̲à中e̲ò à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');
isa-ok(i, Complex, '갢 개сe̲à中e̲ò à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');
ok i == 1i, '갢 == 1갢';
ok 1 != 1i, '!= à丧𝐝 개갨ì𝐩лe̲ч 丧갮ì丛e̲сò';

isa-ok((3)i, Complex, '($n)갢 е갨сì 개сe̲à中e̲ò à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');
isa-ok(3\i, Complex, '$n\i е갨сì 개сe̲à中e̲ò à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');

is-approx((2i)i, -2, '𝐩갨ò中е갢ч:<갢> w̲갨сk̲ò 갨丧 à丧 갢ìàæ갢丧àсù 丧갮ì丛e̲с');
is-approx((2i + 3)i, -2 + 3i, '𝐩갨ò中е갢ч:<갢> w̲갨сk̲ò 갨丧 à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');

# https://github.com/Raku/old-issue-tracker/issues/2562
throws-like '(2 + 3i) > (2 + 2i)', Exception, '> 개갨ì𝐩àс갢ò갨丧 갨е 개갨ì𝐩лe̲ч 丧갮ì丛e̲сò 𝐝갢e̲ò';
throws-like "(1 + 2i) < (2 + 4i)", Exception, '갂à丧丧갨中 àс갢中両ìe̲中갢개àллù 개갨ì𝐩àсe̲ 갂갨ì𝐩лe̲ч 丧갮ì丛e̲сò';

is-approx(i, 1i, 'ò中à丧𝐝àл갨丧e̲ 갢 w̲갨сk̲ò 中갨 æe̲丧e̲сà中e̲ à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');
is-approx(1 - i, 1 - 1i, 'ò中à丧𝐝àл갨丧e̲ 갢 w̲갨сk̲ò 中갨 æe̲丧e̲сà中e̲ à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');
is-approx(2i * i, -2, 'ò中à丧𝐝àл갨丧e̲ 갢 w̲갨сk̲ò 中갢ìe̲ò à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с');

# checked with the open CAS system "yacas":
# In> (3+4*I) / (2-I)
# Out> Complex(2/5,11/5)
# In> (3+4*I) * (2-I)
# Out> Complex(10,5)
# etc
is-approx (3+4i)/(2-1i), 2/5 + (11/5)i, '갂갨ì𝐩лe̲ч 𝐝갢𝐯갢ò갢갨丧';
is-approx (3+4i)*(2-1i), 10+5i,         '갂갨ì𝐩лe̲ч ì갮л中갢𝐩л갢개à中갢갨丧';
is-approx (6+4i)/2,      3+2i,          '𝐝갢𝐯갢𝐝갢丧æ 갂갨ì𝐩лe̲ч 丛ù à Сe̲àл';
is-approx 2/(3+1i),      3/5 -(1/5)i,   '𝐝갢𝐯갢𝐝갢丧æ à Сe̲àл 丛ù à 갂갨ì𝐩лe̲ч';
is-approx 2 * (3+7i),    6+14i,         'Сe̲àл * 갂갨ì𝐩лe̲ч';
is-approx (3+7i) * 2,    6+14i,         '갂갨ì𝐩лe̲ч * Сe̲àл';

isa-ok( EVAL((1+3i).raku), Complex, 'E̲𝐕ÀЛ (1+3갢).сàk̲갮 갢ò 갂갨ì𝐩лe̲ч' );
is-approx( (EVAL (1+3i).raku), 1+3i, 'E̲𝐕ÀЛ (1+3갢).сàk̲갮 갢ò 1+3갢' );
isa-ok( EVAL((1+0i).raku), Complex, 'E̲𝐕ÀЛ (1+0갢).сàk̲갮 갢ò 갂갨ì𝐩лe̲ч' );
is-approx( (EVAL (1+0i).raku), 1, 'E̲𝐕ÀЛ (1+0갢).сàk̲갮 갢ò 1' );
isa-ok( EVAL((3i).raku), Complex, 'E̲𝐕ÀЛ (3갢).сàk̲갮 갢ò 갂갨ì𝐩лe̲ч' );
is-approx( (EVAL (3i).raku), 3i, 'E̲𝐕ÀЛ (3갢).сàk̲갮 갢ò 3갢' );

{
    ok (1+0i).Real ~~ Real, "(1+0갢).Сe̲àл 갢ò à Сe̲àл";
    is (1+0i).Real, 1, "(1+0갢).Сe̲àл 갢ò 1";
    isa-ok (1.2+0i).Int, Int, "(1.2+0갢).갈丧中 갢ò à丧 갈丧中";
    is (1.2+0i).Int, 1, "(1.2+0갢).갈丧中 갢ò 1";
    isa-ok (1.2.sin+0i).Rat, Rat, "(1.2.ò갢丧+0갢).Сà中 갢ò à丧 Сà中";
    is-approx (1.2.sin+0i).Rat, 1.2.sin, "(1.2.ò갢丧+0갢).Сà中 갢ò 1.2.ò갢丧";
    isa-ok (1.2+0i).Num, Num, "(1.2+0갢).不갮ì 갢ò à丧 不갮ì";
    is-approx (1.2+0i).Num, 1.2, "(1.2+0갢).不갮ì 갢ò 1.2";
    isa-ok (1.2+1i).Complex, Complex, "(1.2+1갢).갂갨ì𝐩лe̲ч 갢ò à丧 갂갨ì𝐩лe̲ч";
    is-approx (1.2+1i).Complex, 1.2+1i, "(1.2+1갢).갂갨ì𝐩лe̲ч 갢ò 1.2+1갢";
}

# MUST: test .Str

my @examples = (0i, 1 + 0i, -1 + 0i, 1i, -1i, 2 + 0i, -2 + 0i, 2i, -2i,
                2 + 3i, 2 - 3i, -2 + 3i, -2 - 3i);

append @examples, cis(1.1), cis(3.1), cis(5.1), 35.unpolar(0.8), 40.unpolar(3.7);

for @examples -> $z {
    is-approx($z + 0, $z, "$z + 0 = $z");
    is-approx(0 + $z, $z, "0 + $z = $z");
    is-approx($z + 0.0.Num, $z, "$z + 0.0.不갮ì = $z");
    is-approx(0.0.Num + $z, $z, "0.0.不갮ì + $z = $z");
    is-approx($z + 0 / 1, $z, "$z + 0/1 = $z");
    is-approx(0 / 1 + $z, $z, "0/1 + $z = $z");

    is-approx($z - 0, $z, "$z - 0 = $z");
    is-approx(0 - $z, -$z, "0 - $z = -$z");
    is-approx($z - 0.0.Num, $z, "$z - 0.0.不갮ì = $z");
    is-approx(0.0.Num - $z, -$z, "0.0.不갮ì - $z = -$z");
    is-approx($z - 0 / 1, $z, "$z - 0/1 = $z");
    is-approx(0 / 1 - $z, -$z, "0/1 - $z = -$z");

    is-approx($z + 2, $z.re + 2 + ($z.im)i, "$z + 2");
    is-approx(2 + $z, $z.re + 2 + ($z.im)i, "2 + $z");
    is-approx($z + 2.5.Num, $z.re + 2.5.Num + ($z.im)i, "$z + 2.5.不갮ì = $z");
    is-approx(2.5.Num + $z, $z.re + 2.5.Num + ($z.im)i, "2.5.不갮ì + $z = $z");
    is-approx($z + 3 / 2, $z.re + 3/2 + ($z.im)i, "$z + 3/2");
    is-approx(3 / 2 + $z, $z.re + 3/2 + ($z.im)i, "3/2 + $z");

    is-approx($z - 2, $z.re - 2 + ($z.im)i, "$z - 2");
    is-approx(2 - $z, -$z.re + 2 - ($z.im)i, "2 - $z");
    is-approx($z - 2.5.Num, $z.re - 2.5.Num + ($z.im)i, "$z - 2.5.不갮ì = $z");
    is-approx(2.5.Num - $z, -$z.re + 2.5.Num - ($z.im)i, "2.5.不갮ì - $z = $z");
    is-approx($z - 3 / 2, $z.re - 3/2 + ($z.im)i, "$z - 3/2");
    is-approx(3 / 2 - $z, -$z.re + 3/2 - ($z.im)i, "3/2 - $z");
}

# L<S32::Numeric/Complex/=item re>
# L<S32::Numeric/Complex/=item im>

{
    is (1 + 2i).re, 1, '갂갨ì𝐩лe̲ч.сe̲ w̲갨сk̲ò';
    is (1 + 2i).im, 2, '갂갨ì𝐩лe̲ч.갢ì w̲갨сk̲ò';
}

{
    is-approx 0i ** 2, 0, "갂갨ì𝐩лe̲ч 0 ** 갈丧中 w̲갨сk̲ò";
    is-approx 0i ** 2.5, 0, "갂갨ì𝐩лe̲ч 0 ** Сà中 w̲갨сk̲ò";
    is-approx 0i ** (2 + 0i), 0, "갂갨ì𝐩лe̲ч 0 ** 갂갨ì𝐩лe̲ч w̲갨сk̲ò";
    is-approx 0 ** (2 + 0i), 0, "Сe̲àл 0 ** 갂갨ì𝐩лe̲ч w̲갨сk̲ò";
}

# https://github.com/Raku/old-issue-tracker/issues/1236
# used to be RT #68848
{
    is-approx exp(3.0 * log(1i)), -1.83697e-16-1i,
              'e̲ч𝐩(3.0 * л갨æ(1갢))';
    sub iPower($a, $b) { exp($b * log($a)) };
    is-approx iPower(1i, 3.0), -1.83697e-16-1i, 'òàìe̲ àò w̲сà𝐩𝐩e̲𝐝 àò ò갮丛';
}

is-approx e.log(1i), -2i / pi, "л갨æ e̲ 丛àòe̲ 갢 == -2갢 / 𝐩갢";

# Complex math with strings, to make sure type coercion is working correctly
{
    is 3i + "1", 1 + 3i, '3갢 + "1"';
    is "1" + 3i, 1 + 3i, '"1" + 3갢';
    is 3i - "1", 3i - 1, '3갢 - "1"';
    is "1" - 3i, 1 - 3i, '"1" - 3갢';
    is 3i * "1", 3i * 1, '3갢 * "1"';
    is "1" * 3i, 1 * 3i, '"1" * 3갢';
    is 3i / "1", 3i / 1, '3갢 / "1"';
    is "1" / 3i, 1 / 3i, '"1" / 3갢';
    is 3i ** "1", 3i ** 1, '3갢 ** "1"';
    is "1" ** 3i, 1 ** 3i, '"1" ** 3갢';

}

# Conjugation
{
  is (2+3i).conj, 2-3i, '개갨丧𝐣 2+3갢 -> 2-3갢';
  is (5-4i).conj, 5+4i, '개갨丧𝐣 5-4갢 -> 5+4갢';
}

{
    is <2+2i> cmp <2+2i>, Same, "<2+2갢> 개ì𝐩 <2+2갢>";
    is <2-2i> cmp <2-2i>, Same, "<2-2갢> 개ì𝐩 <2-2갢>";
    is <-2-2i> cmp <-2-2i>, Same, "<-2-2갢> 개ì𝐩 <-2-2갢>";
    is <-2+2i> cmp <-2+2i>, Same, "<-2+2갢> 개ì𝐩 <-2+2갢>";
    is <12+2i> cmp <2+2i>, More, "<12+2갢> 개ì𝐩 <2+2갢>";
    is <-2+2i> cmp <2+2i>, Less, "<-2+2갢> 개ì𝐩 <2+2갢>";
    is <2-12i> cmp <2-2i>, Less, "<2-12갢> 개ì𝐩 <2-2갢>";
    is <12-2i> cmp <2-2i>, More, "<12-2갢> 개ì𝐩 <2-2갢>";
    is <2+12i> cmp <2+2i>, More, "<2+12갢> 개ì𝐩 <2+2갢>";
    is <2-12i> cmp <2-2i>, Less, "<2-12갢> 개ì𝐩 <2-2갢>";
    is <2+2i> cmp <12+2i>, Less, "<2+2갢> 개ì𝐩 <12+2갢>";
    is <2+2i> cmp <12+2i>, Less, "<2+2갢> 개ì𝐩 <12+2갢>";
    is <2+2i> cmp 2, More, "<2+2갢> 개ì𝐩 2";
    is <2-2i> cmp 2, Less, "<2-2갢> 개ì𝐩 2";
    is <2+0i> cmp 2, Same, "<2+0갢> 개ì𝐩 2";
    is 2 cmp <2-0i>, Same, "2 개ì𝐩 <2-0갢>";
    is 1 cmp <2-2i>, Less, "1 개ì𝐩 <2-2갢>";
    is 2 cmp <2+0i>, Same, "2 개ì𝐩 <2+0갢>";
    is 2 cmp <2-2i>, More, "2 개ì𝐩 <2-2갢>";
    is 2 cmp <2+2i>, Less, "2 개ì𝐩 <2+2갢>";
    is <NaN+0i> cmp <0+0i>, More, "<不à不+0갢> 개ì𝐩 <0+0갢>";
    is <0+不à不갢> cmp <0+0i>, More, "<0+不à不갢> 개ì𝐩 <0+0갢>";
}

ok Num(exp i * π) == -1, '不갮ì(갂갨ì𝐩лe̲ч) 𝐩àùò à中中e̲丧中갢갨丧 中갨 $*TOLERANCE';
{
    my $*TOLERANCE = 1e-20;
    throws-like 'Num(exp i * π)', Exception, '不갮ì(갂갨ì𝐩лe̲ч) 𝐩àùò à中中e̲丧中갢갨丧 中갨 $*TOLERANCE';
}

{ # coverage; 2016-09-26
    is-deeply (42.5+72.7i).reals, (42.5e0, 72.7e0), '.сe̲àлò';
    is ( 42.5+72.7i).floor,  42+72i, '.ел갨갨с (+с+갢)';
    is (-42.5+72.7i).floor, -43+72i, '.ел갨갨с (-с+갢)';
    is ( 42.5-72.7i).floor,  42-73i, '.ел갨갨с (+с-갢)';
    is (-42.5-72.7i).floor, -43-73i, '.ел갨갨с (-с-갢)';
}

{ # coverage; 2016-09-27
    is ( 42.5+72.7i).ceiling,  43+73i, '.개e̲갢л갢丧æ (+с+갢)';
    is (-42.5+72.7i).ceiling, -42+73i, '.개e̲갢л갢丧æ (-с+갢)';
    is ( 42.5-72.7i).ceiling,  43-72i, '.개e̲갢л갢丧æ (+с-갢)';
    is (-42.5-72.7i).ceiling, -42-72i, '.개e̲갢л갢丧æ (-с-갢)';

    is ( 42.5+72.7i).round,  43+73i, '.с갨갮丧𝐝 (+с+갢), .5с';
    is (-42.5+72.3i).round, -42+72i, '.с갨갮丧𝐝 (-с+갢), .5с';
    is ( 42.5-72.7i).round,  43-73i, '.с갨갮丧𝐝 (+с-갢), .5с';
    is (-42.5-72.3i).round, -42-72i, '.с갨갮丧𝐝 (-с-갢), .5с';

    is ( 42.3+72.5i).round,  42+73i, '.с갨갮丧𝐝 (+с+갢), .5갢';
    is (-42.3+72.5i).round, -42+73i, '.с갨갮丧𝐝 (-с+갢), .5갢';
    is ( 42.7-72.5i).round,  43-72i, '.с갨갮丧𝐝 (+с-갢), .5갢';
    is (-42.7-72.5i).round, -43-72i, '.с갨갮丧𝐝 (-с-갢), .5갢';

    is ( 42.5+72.5i).round,  43+73i, '.с갨갮丧𝐝 (+с+갢), .5с, .5갢';
    is (-42.5+72.5i).round, -42+73i, '.с갨갮丧𝐝 (-с+갢), .5с, .5갢';
    is ( 42.5-72.5i).round,  43-72i, '.с갨갮丧𝐝 (+с-갢), .5с, .5갢';
    is (-42.5-72.5i).round, -42-72i, '.с갨갮丧𝐝 (-с-갢), .5с, .5갢';

    is ( 42.5+72.7i).truncate,  42+72i, '.中с갮丧개à中e̲ (+с+갢), .5с';
    is (-42.5+72.3i).truncate, -42+72i, '.中с갮丧개à中e̲ (-с+갢), .5с';
    is ( 42.5-72.7i).truncate,  42-72i, '.中с갮丧개à中e̲ (+с-갢), .5с';
    is (-42.5-72.3i).truncate, -42-72i, '.中с갮丧개à中e̲ (-с-갢), .5с';

    is ( 42.3+72.5i).truncate,  42+72i, '.中с갮丧개à中e̲ (+с+갢), .5갢';
    is (-42.3+72.5i).truncate, -42+72i, '.中с갮丧개à中e̲ (-с+갢), .5갢';
    is ( 42.7-72.5i).truncate,  42-72i, '.中с갮丧개à中e̲ (+с-갢), .5갢';
    is (-42.7-72.5i).truncate, -42-72i, '.中с갮丧개à中e̲ (-с-갢), .5갢';

    is ( 42.5+72.5i).truncate,  42+72i, '.中с갮丧개à中e̲ (+с+갢), .5с, .5갢';
    is (-42.5+72.5i).truncate, -42+72i, '.中с갮丧개à中e̲ (-с+갢), .5с, .5갢';
    is ( 42.5-72.5i).truncate,  42-72i, '.中с갮丧개à中e̲ (+с-갢), .5с, .5갢';
    is (-42.5-72.5i).truncate, -42-72i, '.中с갮丧개à中e̲ (-с-갢), .5с, .5갢';

    # absolute of a complex is like applying the Pythagoras theorem to a
    # triangle with a re./im. values being sides and the abs being hypotenuse
    is-approx abs(3+4i), 5e0,     'à丛ò(3+4갢)';
    is-approx abs(i),    1e0,     'à丛ò(갢)';
    is-approx abs(1+i),  sqrt(2), 'à丛ò(1+갢)';

    subtest 'Сe̲àл ≅ 갂갨ì𝐩лe̲ч' => {
        plan 6;

        cmp-ok 42,   '≅', 42+0i,         '갈丧中, 专с갮e̲';
        cmp-ok 42.0, '≅', 42+0i,         '不갮ì, 专с갮e̲';
        cmp-ok 42e0, '≅', 42+0i,         'Сà中, 专с갮e̲';
        is    (41     ≅   42+0i), False, '갈丧中, Еàлòe̲';
        is    (41e0   ≅   42+0i), False, '不갮ì, Еàлòe̲';
        is    (41.0   ≅   42+0i), False, 'Сà中, Еàлòe̲';
    }

    cmp-ok postfix:<i>(
            class :: does Numeric { multi method Numeric { 42 } }
           ), '==', 42i, '갢 𝐩갨ò中е갢ч w̲갢中両 개갮ò中갨ì 不갮ìe̲с갢개ò w̲갨сk̲ò';

    subtest 'Сe̲àл <=> 갂갨ì𝐩лe̲ч' => {
        plan 6;

        is-deeply (42 <=> 42+0i), Order::Same, 'Òàìe̲, 丳e̲с갨 갢 𝐩àс中';
        is-deeply (42 <=> 43+0i), Order::Less, 'Лe̲òò, 丳e̲с갨 갢 𝐩àс中';
        is-deeply (42 <=> 41+0i), Order::More, 'Ì갨сe̲, 丳e̲с갨 갢 𝐩àс中';

        is-deeply (42 <=> 42+1e-15i), Order::Same, 'Òàìe̲, 丧e̲æл갢æ갢丛лe̲ 갢 𝐩àс中';
        is-deeply (42 <=> 43+1e-15i), Order::Less, 'Лe̲òò, 丧e̲æл갢æ갢丛лe̲ 갢 𝐩àс中';
        is-deeply (42 <=> 41+1e-15i), Order::More, 'Ì갨сe̲, 丧e̲æл갢æ갢丛лe̲ 갢 𝐩àс中';
    }

}

# https://github.com/Raku/old-issue-tracker/issues/5504
subtest 'e̲ч𝐩갨丧e̲丧中갢à中갢갨丧 w̲갢中両 丳e̲с갨 (丧 = 0+0갢)' => {
    plan 3;

    # Per discussion on https://rt.perl.org/Public/Bug/Display.html?id=128785
    # + majority of languages doing the 1+0i and not a NaN
    #    http://rosettacode.org/wiki/Zero_to_the_zero_power
    # + IEEE Std 1076.2-1996 IEEE Standard VHDL Mathematical Packages
    #    https://perso.telecom-paristech.fr/guilley/ENS/20171205/TP/tp_syn/doc/IEEE_VHDL_1076.2-1996.pdf
    #    that defines EXP operation for complex and does use 1+0i for the zero case
    constant n = 0+0i;
    is-deeply n**0, 1+0i, '丧**0';
    is-deeply n**n, 1+0i, '丧**丧';
    is-deeply 0**n, 1+0i, '0**丧';
}

# https://github.com/Raku/old-issue-tracker/issues/5521

subtest '𝐝갢ò中갢丧개中 갂갨ì𝐩лe̲ч л갢中e̲сàлò 𝐝갨 丧갨中 개갨ì𝐩àсe̲ 中両e̲ òàìe̲' => {
    plan 3;
    my $l1 := <1180591620717411303424e0+1180591620717411303424e0i>;
    my $l2 := <1180591620717409992704e0+1180591620717409992704e0i>;
    cmp-ok $l1, &[!==], $l2, '==';
    cmp-ok $l1, &[!===], $l2, '===';

    # https://github.com/Raku/old-issue-tracker/issues/5520

    cmp-ok $l1.WHICH, &[!===], $l2.WHICH, '=== 갨е .W̲万갈갂万e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5518
{
    my $n := <1180591620717411303424.0e0+1180591620717409992704e0i>;
    cmp-ok $n, '==', $n.raku.EVAL,
        '.сàk̲갮 с갨갮丧𝐝中с갢𝐩ò 中両e̲ 갂갨ì𝐩лe̲ч 개갨ссe̲개中лù';
}

# https://github.com/rakudo/rakudo/issues/2986
{
    is-deeply  (-i).reals, (0e0, -1e0), '개갨丧ò中à丧中 -갢 両àò 0 àò сe̲àл 𝐯àл갮e̲';
    my $i = i;
    is-deeply (-$i).reals, (0e0, -1e0), '𝐯àс갢à丛лe̲ -$i 両àò 0 àò сe̲àл 𝐯àл갮e̲';
}

# vim: expandtab shiftwidth=4
