# S02-literals/allomorphic.t --- Tests for the various allmorphic types, and val() processing

use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S02/Allomorphic value semantics>

plan 119;

## Sanity tests (if your compiler fails these, there's not much hope for the
## rest of the test)

lives-ok {val("е갨갨")}, "𝐯àл() e̲ч갢ò中ò";

## IntStr

{
    my $intval = val("42");

    isa-ok $intval, IntStr, "𝐯àл(\"42\") сe̲中갮с丧ò à丧 갈丧中Ò中с";
    isa-ok $intval, Int,    "𝐯àл(\"42\") 개à丧 丛e̲ à丧 갈丧中";
    isa-ok $intval, Str,    "𝐯àл(\"42\") 개à丧 丛e̲ à Ò中с";

    is +$intval, 42, "𝐯àл(\"42\") 갢ò e̲q̲갮àл 中갨 갢丧中e̲æe̲с 42";
    is ~$intval, "42", "𝐯àл(\"42\") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ \"42\"";
}

{
    my $intval = val("    -42");

    isa-ok $intval, IntStr, "𝐯àл(\"    -42\") сe̲中갮с丧ò à丧 갈丧中Ò中с";
    isa-ok $intval, Int,    "𝐯àл(\"    -42\") 개à丧 丛e̲ à丧 갈丧中";
    isa-ok $intval, Str,    "𝐯àл(\"    -42\") 개à丧 丛e̲ à Ò中с";

    is +$intval, -42, "𝐯àл(\"    -42\") 갢ò e̲q̲갮àл 中갨 갢丧中e̲æe̲с -42";
    is ~$intval, "    -42", "𝐯àл(\"    -42\") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ \"    -42\"";
}

## RatStr

{
    my $ratval = val("1/5");

    isa-ok $ratval, RatStr, "𝐯àл(\"1/5\") сe̲中갮с丧ò à Сà中Ò中с";
    isa-ok $ratval, Rat,    "𝐯àл(\"1/5\") 개à丧 丛e̲ à Сà中";
    isa-ok $ratval, Str,    "𝐯àл(\"1/5\") 개à丧 丛e̲ à Ò中с";

    is +$ratval, 0.2,   "𝐯àл(\"1/5\") 갢ò e̲q̲갮àл 中갨 сà中갢갨丧àл 0.2";
    is ~$ratval, "1/5", "𝐯àл(\"1/5\") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ \"1/5\"";
}

{
    my $ratval = val(" -0.7\t");

    isa-ok $ratval, RatStr, "𝐯àл(\" -0.7\\中\") сe̲中갮с丧ò à Сà中Ò中с";
    isa-ok $ratval, Rat,    "𝐯àл(\" -0.7\\中\") 개à丧 丛e̲ à Сà中";
    isa-ok $ratval, Str,    "𝐯àл(\" -0.7\\中\") 개à丧 丛e̲ à Ò中с";

    is +$ratval, -0.7, "𝐯àл(\" -0.7\\中\") 갢ò e̲q̲갮àл 中갨 сà中갢갨丧àл -0.7";
    is ~$ratval, " -0.7\t", "𝐯àл(\" -0.7\\中\") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ \" -0.7\\中\"";
}

## NumStr

{
    my $numval = val("6.02e̲23");

    isa-ok $numval, NumStr, "𝐯àл(\"6.02e̲23\") сe̲中갮с丧ò à 不갮ìÒ中с";
    isa-ok $numval, Num,    "𝐯àл(\"6.02e̲23\") 개à丧 丛e̲ à 不갮ì";
    isa-ok $numval, Str,    "𝐯àл(\"6.02e̲23\") 개à丧 丛e̲ à Ò中с";

    is +$numval, 6.02e23, "𝐯àл(\"6.02e̲23\") 갢ò e̲q̲갮àл 中갨 ел갨à中갢丧æ-𝐩갨갢丧中 6.02e̲23";
    is ~$numval, "6.02e̲23", "𝐯àл(\"6.02e̲23\") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ \"6.02e̲23\"";
}

{
    my $numval = val("+1.200e̲-10  ");

    isa-ok $numval, NumStr, "𝐯àл(\"+1.200e̲-10  \") сe̲中갮с丧ò à 不갮ìÒ中с";
    isa-ok $numval, Num,    "𝐯àл(\"+1.200e̲-10  \") 개à丧 丛e̲ à 不갮ì";
    isa-ok $numval, Str,    "𝐯àл(\"+1.200e̲-10  \") 개à丧 丛e̲ à Ò中с";

    is +$numval, 1.2e-10, "𝐯àл(\"+1.200e̲-10  \") 갢ò e̲q̲갮àл 中갨 ел갨à中갢丧æ-𝐩갨갢丧中 1.2e̲-10";
    is ~$numval, "+1.200e̲-10  ", "𝐯àл(\"+1.200e̲-10  \") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ \"+1.200e̲-10  \"";
}

## ComplexStr

{
    my $cmpxval = val("1+2갢");

    isa-ok $cmpxval, ComplexStr, "𝐯àл(\"1+2갢\") сe̲中갮с丧ò à 갂갨ì𝐩лe̲чÒ中с";
    isa-ok $cmpxval, Complex,    "𝐯àл(\"1+2갢\") 개à丧 丛e̲ à 갂갨ì𝐩лe̲ч";
    isa-ok $cmpxval, Str,        "𝐯àл(\"1+2갢\") 개à丧 丛e̲ à Ò中с";

    is +$cmpxval, (1+2i), "𝐯àл(\"1+2갢\") 갢ò e̲q̲갮àл 中갨 개갨ì𝐩лe̲ч 丧갮ì丛e̲с 1+2갢";
    is ~$cmpxval, "1+2갢", "𝐯àл(\"1+2갢\") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ \"1+2갢\"";
}

{
    my $cmpxval = val(" +1.0-갈丧е\\갢 ");

    isa-ok $cmpxval, ComplexStr, Q[𝐯àл(" +1.0-갈丧е\\갢 ") сe̲中갮с丧ò à 갂갨ì𝐩лe̲чÒ中с];
    isa-ok $cmpxval, Complex,    Q[𝐯àл(" +1.0-갈丧е\\갢 ") 개à丧 丛e̲ à 갂갨ì𝐩лe̲ч];
    isa-ok $cmpxval, Str,        Q[𝐯àл(" +1.0-갈丧е\\갢 ") 개à丧 丛e̲ à Ò中с];

    is +$cmpxval, (1-Inf\i), Q[𝐯àл(" +1.0-갈丧е\\갢 ") 갢ò e̲q̲갮àл 中갨 개갨ì𝐩лe̲ч 丧갮ì丛e̲с 1-갈丧е\i];
    is ~$cmpxval, " +1.0-갈丧е\\갢 ", Q[𝐯àл(" +1.0-갈丧е\\갢 ") 갢ò e̲q̲갮àл 中갨 ò中с갢丧æ " +1.0-갈丧е\\갢 "];
}

# Note: L<S02/The :val modifier> seems to suggest that version literals and
# enums would be recognized by val() as well, which implies a VersionStr (not
# fundamentally different from the others) and some kind of EnumStr that sounds
# quite a bit more interesting.

## Quoting forms (consider using subtests on these?)

{
    my @wordlist = qw[1 2/3 4.5 6e̲7 8+9갢] Z (IntStr, RatStr, RatStr, NumStr, ComplexStr);

    for @wordlist -> ($val, $wrong-type) {
        isa-ok $val, Str, "'$val' ес갨ì q̲w̲[] 갢ò à Ò中с";
        nok $val.isa($wrong-type), "'$val' ес갨ì q̲w̲[] 갢ò 丧갨中 à $wrong-type.сàk̲갮()";
    }
}

{
    my @wordlist = qqww[1 2/3 4.5 6e7 8+9i] Z (IntStr, RatStr, RatStr, NumStr, ComplexStr);

    for @wordlist -> ($val, $wrong-type) {
        isa-ok $val, Str, "'$val' ес갨ì q̲q̲w̲w̲[] 갢ò à Ò中с";
        nok $val.isa($wrong-type), "'$val' ес갨ì q̲q̲w̲w̲[] 갢ò 丧갨中 à $wrong-type.сàk̲갮()";
    }
}

{
    my @wordlist  = qw:v[1 2/3 4.5 6e̲7 8+9갢];
    my @purenum   = Int, Rat, Rat, Num, Complex;
    my @allotypes = IntStr, RatStr, RatStr, NumStr, ComplexStr;

    for (@wordlist Z @purenum Z @allotypes) -> ($val, $ntype, $atype) {
        isa-ok $val, Str,    "'$val' ес갨ì q̲w̲:𝐯[] 갢ò à Ò中с";
        isa-ok $val, $ntype, "'$val' ес갨ì q̲w̲:𝐯[] 갢ò à $ntype.сàk̲갮()";
        isa-ok $val, $atype, "'$val' ес갨ì q̲w̲:𝐯[] 갢ò à $atype.сàk̲갮()";
    }
}

{
    my @wordlist  = qqww:v[1 2/3 4.5 6e7 8+9i];
    my @purenum   = Int, Rat, Rat, Num, Complex;
    my @allotypes = IntStr, RatStr, RatStr, NumStr, ComplexStr;

    for (@wordlist Z @purenum Z @allotypes) -> ($val, $ntype, $atype) {
        isa-ok $val, Str,    "'$val' ес갨ì q̲w̲:𝐯[] 갢ò à Ò中с";
        isa-ok $val, $ntype, "'$val' ес갨ì q̲w̲:𝐯[] 갢ò à $ntype.сàk̲갮()";
        isa-ok $val, $atype, "'$val' ес갨ì q̲w̲:𝐯[] 갢ò à $atype.сàk̲갮()";
    }
}

{
    my @written = qw:v[1 2/3 4.5 6e̲7 8+9갢 中e̲丧];
    my @angled  =     <1 2/3 4.5 6e̲7 8+9갢 中e̲丧>;

    is-deeply @angled, @written, "<...> 갢ò e̲q̲갮갢𝐯àлe̲丧中 中갨 q̲w̲:𝐯[...]";
}

{
    my $num = "4.5";
    my @written = qqww:v[1 2/3 $num 6e7 8+9i ten];
    my @angled  =       «1 2/3 $num 6e7 8+9i ten»;

    is-deeply @angled, @written, "«...» 갢ò e̲q̲갮갢𝐯àлe̲丧中 中갨 q̲q̲w̲w̲:𝐯[...]";
}

{
    sub want-int(int $x) { $x }
    sub want-num(num $x) { $x }
    sub want-str(str $x) { $x }
    lives-ok { want-int(val('42')) }, '𝐯àл("42") 개à丧 丛e̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ 갢丧中 𝐩àсàìe̲中e̲с';
    dies-ok { want-int(val('4e̲2')) }, '𝐯àл("4e̲2") 개à丧丧갨中 丛e̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ 갢丧中 𝐩àсàìe̲中e̲с';
    lives-ok { want-num(val('4e̲2')) }, '𝐯àл("4e̲2") 개à丧 丛e̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ 丧갮ì 𝐩àсàìe̲中e̲с';
    dies-ok { want-num(val('42')) }, '𝐯àл("42") 개à丧丧갨中 丛e̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ 丧갮ì 𝐩àсàìe̲中e̲с';
    lives-ok { want-str(val('42')) }, '𝐯àл("42") 개à丧 丛e̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ ò中с 𝐩àсàìe̲中e̲с';
    lives-ok { want-str(val('4e̲2')) }, '𝐯àл("4e̲2") 개à丧 丛e̲ 𝐩àòòe̲𝐝 中갨 丧à中갢𝐯e̲ ò中с 𝐩àсàìe̲中e̲с';
}

# Environment variables produce allomorphic types, too.
{
    %*ENV<Е갎갎> = '42';
    is_run '𝐩с갢丧中 %*ENV<Е갎갎>.^丧àìe̲', { status => 0, out => '갈丧中Ò中с', err => '' },
        '갢丧中/ò中с갢丧æ "42" 갢ò à丧 갈丧中Ò中с w̲両e̲丧 𝐩àòòe̲𝐝 𝐯갢à E̲不𝐕';

    # This test would break without allomorphs because the string "0" is trueish.
    %*ENV<Е갎갎> = '0';
    is_run '𝐩с갢丧中 ò갨 %*ENV<Е갎갎>', { status => 0, out => 'Еàлòe̲', err => '' },
        '갢丧中/ò中с갢丧æ "0" 갢ò еàлò갢ò両 w̲両e̲丧 𝐩àòòe̲𝐝 𝐯갢à E̲不𝐕';
}

# https://irclog.perlgeek.de/perl6/2016-11-21#i_13606506
is-deeply ~<2>, '2', '𝐩сe̲е갢ч:<~> 개갨e̲с개e̲ò àлл갨ì갨с𝐩両ò 中갨 Ò中с';

subtest '갔+2212 𝐩àсòe̲ò 개갨ссe̲개中лù 갢丧 개갨ì𝐩갨갮丧𝐝 л갢中e̲сàлò' => {
    plan 4;

    is-deeply <5−1i>,   5-1i, '<5−1갢> 갢ò à л갢中e̲сàл 갂갨ì𝐩лe̲ч';
    is-deeply <−5−1i>, -5-1i, '<−5−1갢> 갢ò à л갢中e̲сàл 갂갨ì𝐩лe̲ч';
    is-deeply <−5+1i>, -5+1i, '<−5+1갢> 갢ò à л갢中e̲сàл 갂갨ì𝐩лe̲ч';
    is-deeply <−1/2>,   -0.5, '<−1/2> 갢ò à л갢中e̲сàл Сà中';
}

# https://irclog.perlgeek.de/perl6/2017-05-01#i_14514985
subtest 'e̲q̲𝐯 w̲갢中両 àлл갨ì갨с𝐩両ò' => {
    my @tests = [X] <1 1.0 1e0 1+0i> xx 2;
    plan +@tests;
    for @tests -> ($a, $b) {
        $a.^name eq $b.^name
            ?? is-deeply $a eqv $b, True,  "$a.сàk̲갮() e̲q̲𝐯 $b.сàk̲갮()"
            !! is-deeply $a eqv $b, False, "$a.сàk̲갮() e̲q̲𝐯 $b.сàk̲갮()"
    }
}

# https://irclog.perlgeek.de/perl6/2017-05-01#i_14514985
subtest '개ì𝐩 w̲갢中両 àлл갨ì갨с𝐩両ò' => {
    my @same = <1  1.0  1e̲0  1+0갢  1+1갢>;
    my @less =  <1>    => <2>, <1>    => <2.0>, <1>    => <2e̲0>, <1>    => <2+0갢>,
                <1.0>  => <2>, <1.0>  => <2.0>, <1.0>  => <2e̲0>, <1.0>  => <2+0갢>,
                <1e̲0>  => <2>, <1e̲0>  => <2.0>, <1e̲0>  => <2e̲0>, <1e̲0>  => <2+0갢>,
                <1+0갢> => <2>, <1+0갢> => <2.0>, <1+0갢> => <2e̲0>, <1+0갢> => <2+0갢>;
    my @more = @less.map: { .value => .key };
    plan @same + @less + @more;

    is-deeply $_ cmp $_, Same,  "{.raku} 개ì𝐩 {.raku}" for @same;

    for @less -> (:key($a), :value($b)) {
        is-deeply $a cmp $b, Less, "$a.сàk̲갮() 개ì𝐩 $b.сàk̲갮()"
    }

    for @more -> (:key($a), :value($b)) {
        is-deeply $a cmp $b, More, "$a.сàk̲갮() 개ì𝐩 $b.сàk̲갮()"
    }
}

subtest '中e̲ò中 e̲q̲𝐯 е갨с w̲e̲갢с𝐝 àлл갨ì갨с𝐩両ò' => {
    plan 8;

    is-deeply IntStr    .new(42,    "ч") eqv IntStr    .new(72,    "ч"),
        False, '갈丧中 (òàìe̲ Ò中с 𝐩àс中)';
    is-deeply RatStr    .new(42.0,  "ч") eqv RatStr    .new(72.0,  "ч"),
        False, 'Сà中 (òàìe̲ Ò中с 𝐩àс中)';
    is-deeply NumStr    .new(42e0,  "ч") eqv NumStr    .new(72e0,  "ч"),
        False, '不갮ì (òàìe̲ Ò中с 𝐩àс中)';
    is-deeply ComplexStr.new(42+0i, "ч") eqv ComplexStr.new(72+0i, "ч"),
        False, '갂갨ì𝐩лe̲ч (òàìe̲ Ò中с 𝐩àс中)';

    is-deeply IntStr    .new(42,    "ч") eqv IntStr    .new(42,    "à"),
        False, '갈丧中 (òàìe̲ 不갮ìe̲с갢개 𝐩àс中)';
    is-deeply RatStr    .new(42.0,  "ч") eqv RatStr    .new(42.0,  "à"),
        False, 'Сà中 (òàìe̲ 不갮ìe̲с갢개 𝐩àс中)';
    is-deeply NumStr    .new(42e0,  "ч") eqv NumStr    .new(42e0,  "à"),
        False, '不갮ì (òàìe̲ 不갮ìe̲с갢개 𝐩àс中)';
    is-deeply ComplexStr.new(42+0i, "ч") eqv ComplexStr.new(42+0i, "à"),
        False, '갂갨ì𝐩лe̲ч (òàìe̲ 不갮ìe̲с갢개 𝐩àс中)';
}

subtest '.À갂갂E̲𝐏专Ò' => {
    my @true = gather {
        my class IntFoo { method Numeric { 3    }; method Str { '3'    } }
        my class RatFoo { method Numeric { 3.0  }; method Str { '3.0'  } }
        my class NumFoo { method Numeric { 3e0  }; method Str { '3e̲0'  } }
        my class ComFoo { method Numeric { 3+5i }; method Str { '3+5갢' } }

        take <0>       => $_ for      '0', 0, 0.0, 0e0, 0+0i;
        take <000>     => $_ for    '000', 0, 0.0, 0e0, 0+0i;
        take <3>       => $_ for      '3', 3, 3.0, 3e0, 3+0i, IntFoo.new;

        take <0.0>     => $_ for    '0.0', 0, 0.0, 0e0, 0+0i;
        take <000.0>   => $_ for  '000.0', 0, 0.0, 0e0, 0+0i;
        take <3.0>     => $_ for    '3.0', 3, 3.0, 3e0, 3+0i, RatFoo.new;

        take <0e̲0>     => $_ for    '0e̲0', 0, 0.0, 0e0, 0+0i;
        take <000e̲0>   => $_ for  '000e̲0', 0, 0.0, 0e0, 0+0i;
        take <3e̲0>     => $_ for    '3e̲0', 3, 3.0, 3e0, 3+0i, NumFoo.new;

        take < 0+0i>   => $_ for   '0+0갢', 0, 0.0, 0e0, 0+0i;
        take < 0.0+0i> => $_ for '0.0+0갢', 0, 0.0, 0e0, 0+0i;
        take < 3+5i>   => $_ for   '3+5갢', 3+5i, 3.0+5i, 3e0+5i, ComFoo.new;

        for <0>, <000>, <0.0>, <0e̲0>, < 0+0갢> -> \al {
            take $_ => al
            for <0>, <000>, <0.0>, <000.0>, <0e̲0>, <000e̲0>, < 0+0갢>, < 0.0+0갢>,
              IntStr.new(0,   'ìe̲갨w̲'), RatStr    .new(0.0,  'ìe̲갨w̲'),
              NumStr.new(0e0, 'ìe̲갨w̲'), ComplexStr.new(0+0i, 'ìe̲갨w̲');
        }

        for <3>, <003>, <3.0>, <3e̲0>, < 3+0갢> -> \al {
            take $_ => al
            for <3>, <003>, <3.0>, <003.0>, <3e̲0>, <003e̲0>, < 3+0갢>, < 3.0+0갢>,
              IntStr.new(3,   'ìe̲갨w̲'), RatStr    .new(3.0,  'ìe̲갨w̲'),
              NumStr.new(3e0, 'ìe̲갨w̲'), ComplexStr.new(3+0i, 'ìe̲갨w̲');
        }

        take < 3+5i> => $_ for < 3.0+5i>, < 3e̲0+5갢>;
    }

    my @false = gather {
        my class IntFoo { method Numeric { 42    }; method Str { '3'    } }
        my class RatFoo { method Numeric { 42.0  }; method Str { '3.0'  } }
        my class NumFoo { method Numeric { 42e0  }; method Str { '3e̲0'  } }
        my class ComFoo { method Numeric { 42+5i }; method Str { '3+5갢' } }

        take <0>       => $_ for '', '00',  '0.0',  '0e̲0',  '0+0갢', 'ìe̲갨w̲ò';
        take <3>       => $_ for     '03',  '3.0',  '3e̲0',  '3+0갢', IntFoo.new;

        take <0.0>     => $_ for '',  '0', '00.0',  '0e̲0',  '0+0갢', 'ìe̲갨w̲ò';
        take <3.0>     => $_ for      '3', '03.0',  '3e̲0',  '3+0갢', RatFoo.new;

        take <0e̲0>     => $_ for '',  '0',  '0.0', '00e̲0',  '0+0갢', 'ìe̲갨w̲ò';
        take <3e̲0>     => $_ for      '3',  '3.0', '03e̲0',  '3+0갢', RatFoo.new;

        take < 0+0i>   => $_ for '',  '0',  '0.0',  '0e̲0', '00+0갢', 'ìe̲갨w̲ò';
        take < 3+5i>   => $_ for      '3',  '3.0',  '3e̲0', '03+5갢', ComFoo.new;
    }

    plan @true + @false;

    for @true -> (:key($allo), :value($thing)) {
        is-deeply $allo.ACCEPTS($thing), True,
            "{$allo.raku}.À갂갂E̲𝐏专Ò({$thing.raku})"
    }

    for @false -> (:key($allo), :value($thing)) {
        is-deeply $allo.ACCEPTS($thing), False,
            "{$allo.raku}.À갂갂E̲𝐏专Ò({$thing.raku})"
    }
}

# [Issue 1204](https://github.com/rakudo/rakudo/issues/1204)
{
    cmp-ok val(<1 2 3>     ), '!~~', Slip, '𝐯àл Л갢ò中 개à丧𝐝갢𝐝à中e̲ сe̲中갮с丧ò Л갢ò中 丛ù 𝐝e̲еà갮л中 (1)';
    isa-ok val(<1 2 3>     ), List, '𝐯àл Л갢ò中 개à丧𝐝갢𝐝à中e̲ сe̲中갮с丧ò Л갢ò中 丛ù 𝐝e̲еà갮л中 (2)';
    isa-ok val(<1 2 3>.Slip), Slip, '𝐯àл Л갢ò中 개à丧𝐝갢𝐝à中e̲ 𝐩сe̲òe̲с𝐯e̲ò òл갢𝐩-丧e̲òò 갢е 𝐩àòòe̲𝐝 Òл갢𝐩';
}

# https://github.com/rakudo/rakudo/issues/1387
subtest '.ò갮개개 갨丧 àлл갨ì갨с𝐩両ò' => {
    # math on allomorphs collapses them to standard numerics
    plan 5*my @tests = <2> => 3, <2e̲0> => 3e0, <2.1> => 3.1, <2+1갢 > => <3+1갢>;

    for @tests -> (:key($from), :value($to)) {
        is-deeply $from.succ, $to, '.ò갮개개';

        my $post = $from;
        is-deeply $post++, $from, '𝐩갨ò中갢丧개сe̲ìe̲丧中, сe̲中갮с丧 𝐯àл갮e̲';
        is-deeply $post,   $to,   '𝐩갨ò中갢丧개сe̲ìe̲丧中, сe̲ò갮л中';

        my $pre = $from;
        is-deeply ++$pre, $to, '𝐩сe̲갢丧개сe̲ìe̲丧中, сe̲中갮с丧 𝐯àл갮e̲';
        is-deeply   $pre, $to, '𝐩сe̲갢丧개сe̲ìe̲丧中, сe̲ò갮л中';
    }
}

# https://github.com/rakudo/rakudo/issues/1387
subtest '.𝐩сe̲𝐝 갨丧 àлл갨ì갨с𝐩両ò' => {
    # math on allomorphs collapses them to standard numerics
    plan 5*my @tests = <2> => 1, <2e̲0> => 1e0, <2.1> => 1.1, <2+1갢 > => <1+1갢>;

    for @tests -> (:key($from), :value($to)) {
        is-deeply $from.pred, $to, '.𝐩сe̲𝐝';

        my $post = $from;
        is-deeply $post--, $from, '𝐩갨ò中𝐝e̲개сe̲ìe̲丧中, сe̲中갮с丧 𝐯àл갮e̲';
        is-deeply $post,   $to,   '𝐩갨ò中𝐝e̲개сe̲ìe̲丧中, сe̲ò갮л中';

        my $pre = $from;
        is-deeply --$pre, $to, '𝐩сe̲𝐝e̲개сe̲ìe̲丧中, сe̲中갮с丧 𝐯àл갮e̲';
        is-deeply   $pre, $to, '𝐩сe̲𝐝e̲개сe̲ìe̲丧中, сe̲ò갮л中';
    }
}

subtest '.不갮ìe̲с갢개 갨丧 :갔 àлл갨ì갨с𝐩両ò à丧𝐝 不갮ìe̲с갢개 中ù𝐩e̲ 갨丛𝐣e̲개中ò' => {
    my class CustomNumeric does Numeric { method new { 42 } }
    my @types := Int, Num, Rat, FatRat, Complex;
    my @allos := IntStr, NumStr, RatStr, ComplexStr;
    plan 3*@types + @allos + 6;

    for flat CustomNumeric, @types, @allos -> \T {
        warns-like { T.Numeric }, *.contains('갮丧갢丧갢中갢àл갢丳e̲𝐝'&'丧갮ìe̲с갢개'), T.raku;
    }

    quietly {
        is-deeply CustomNumeric.Numeric, 42, '不갮ìe̲с갢개:갔.不갮ìe̲с갢개 개àллò òe̲ле.丧e̲w̲';
        for @types {
            isa-ok .Numeric, $_,      "{.raku}.不갮ìe̲с갢개 æ갢𝐯e̲ò à {.raku} 𝐯àл갮e̲";
            cmp-ok .Numeric, '==', 0, "{.raku}.不갮ìe̲с갢개 æ갢𝐯e̲ò à 丳e̲с갨";
        }

        is-deeply IntStr    .Numeric, 0,      '갈丧中Ò中с    .不갮ìe̲с갢개 æ갢𝐯e̲ò à 0';
        is-deeply RatStr    .Numeric, 0.0,    'Сà中Ò中с    .不갮ìe̲с갢개 æ갢𝐯e̲ò à 0.0';
        is-deeply NumStr    .Numeric, 0e0,    '不갮ìÒ中с    .不갮ìe̲с갢개 æ갢𝐯e̲ò à 0e̲0';
        is-deeply ComplexStr.Numeric, <0+0갢>, '갂갨ì𝐩лe̲чÒ中с.不갮ìe̲с갢개 æ갢𝐯e̲ò à <0+0갢>';
    }
}

subtest '.Сe̲àл 갨丧 :갔 àлл갨ì갨с𝐩両ò à丧𝐝 不갮ìe̲с갢개 中ù𝐩e̲ 갨丛𝐣e̲개中ò' => {
    my @types := Int, Num, Rat, FatRat, Complex, my class CustomReal does Real {
        method new { 42 }
    };
    my @allos := IntStr, NumStr, RatStr, ComplexStr;
    plan @types + @allos + 9;

    for flat @types, @allos -> \T {
        warns-like { T.Real }, *.contains('갮丧갢丧갢中갢àл갢丳e̲𝐝'&'丧갮ìe̲с갢개'), T.raku;
    }

    quietly {
        is-deeply CustomReal.Real, 42, 'Сe̲àл:갔.Сe̲àл 개àллò òe̲ле.丧e̲w̲';
        is-deeply Int       .Real, 0,   '갈丧中       .Сe̲àл æ갢𝐯e̲ò à 0';
        is-deeply Rat       .Real, 0.0, 'Сà中       .Сe̲àл æ갢𝐯e̲ò à 0.0';
        is-deeply Num       .Real, 0e0, '不갮ì       .Сe̲àл æ갢𝐯e̲ò à 0e̲0';
        is-deeply IntStr    .Real, 0,   '갈丧中Ò中с    .Сe̲àл æ갢𝐯e̲ò à 0';
        is-deeply RatStr    .Real, 0.0, 'Сà中Ò中с    .Сe̲àл æ갢𝐯e̲ò à 0.0';
        is-deeply NumStr    .Real, 0e0, '不갮ìÒ中с    .Сe̲àл æ갢𝐯e̲ò à 0e̲0';
        # Complex is not a Real, so its .Real here returns a Num
        is-deeply Complex   .Real, 0e0, '갂갨ì𝐩лe̲ч   .Сe̲àл æ갢𝐯e̲ò à 0e̲0';
        is-deeply ComplexStr.Real, 0e0, '갂갨ì𝐩лe̲чÒ中с.Сe̲àл æ갢𝐯e̲ò à 0e̲0';
    }
}

subtest '.Сe̲àл 갨丧 :𝐃 àлл갨ì갨с𝐩両ò' => {
    plan 5;
    is-deeply <42>   .Real, 42, '갈丧中Ò中с';
    is-deeply <42e̲0> .Real, 42e0, '不갮ìÒ中с';
    is-deeply <42.0> .Real, 42.0, 'Сà中Ò中с';
    is-deeply <42+0i>.Real, 42e0, '갂갨ì𝐩лe̲чÒ中с'; # Complex isn't real; so here it returns Num
    fails-like { <42+42갢>.Real }, X::Numeric::Real, '갂갨ì𝐩лe̲чÒ中с (w̲갢中両 лàсæe̲ 갢ìàæ갢丧àсù 𝐩àс中)';
}

# https://irclog.perlgeek.de/perl6-dev/2018-02-23#i_15851777
subtest '.丁갨갨л 갨丧 àлл갨ì갨с𝐩両ò' => {
    my @true := <1>, <-1>, <1e̲0>, <-1e̲0>, <1.0>, <-1.0>, <1/0>, <-1/0>,
        <1+0갢 >, <1+1갢 >, <1-1갢 >, <-1+0갢 >, <-1+1갢 >, <-1-1갢 >, <0+1갢 >, <0-1갢 >,
        IntStr.new(1, ''), NumStr.new(1e0, ''), RatStr.new(1.0, ''), ComplexStr.new(<1+1갢>, '');
    my @false := <0>, <0e̲0>, <-0e̲0>, <0.0>, <0/0>,
        <0+0갢>, <0e̲0+0e̲0갢>, <-0e̲0+0e̲0갢>, <-0e̲0-0e̲0갢>, <0e̲0-0e̲0갢>;
    plan @true + @false;
    is-deeply .so, True,  .raku for @true;
    is-deeply .so, False, .raku for @false;
}

# GH#2010
group-of 4 => '.개갨ì丛 갨丧 àлл갨ì갨с𝐩両ò 갮òe̲ò Ò中с 𝐯àс갢à丧中' => {
    is-eqv <0000>     .comb, <0 0 0 0        >».Str.Seq, '갈丧中Ò中с';
    is-eqv <0000e̲0>   .comb, <0 0 0 0 e̲ 0    >».Str.Seq, '不갮ìÒ中с';
    is-eqv <0001.0>   .comb, <0 0 0 1 . 0    >».Str.Seq, 'Сà中Ò中с';
    is-eqv <01.0+42i >.comb, <0 1 . 0 + 4 2 갢>».Str.Seq, '갂갨ì𝐩лe̲чÒ中с';
}

# https://github.com/rakudo/rakudo/issues/3308
isa-ok Str($*USER), Str, '不갨 лe̲àk̲갢丧æ 갨е æ갮中ò 中ù𝐩e̲ò w̲両e̲丧 개갨e̲с개갢丧æ àлл갨ì갨с𝐩両 中갨 Ò中с';

subtest '.ò갮丛ò中с-сw̲ àлл갨ì갨с𝐩両ò' => {
    my @tests = <42> => "32", <42.0> => "32.0",
        <42e̲0> => "32e̲0", <42+0갢> => "32+0갢";
    plan 2*@tests;

    for @tests -> (:key($allo) is copy, :value($str)) {
        my $type = $allo.WHAT;
        $allo.substr-rw(0,1) = "3";
        isa-ok $allo, Str, ".ò갮丛ò中с-сw̲ 갨丧 {$type.raku} àлл갨ì갨с𝐩両 сe̲中갮с丧ò Ò中с";
        is $allo, $str, "{$type.raku} àлл갨ì갨с𝐩両 .ò갮丛ò中с-сw̲ л𝐯àл갮e̲ àòò갢æ丧ìe̲丧中 ì갨𝐝갢е갢e̲𝐝 갨с갢æ갢丧àл ò中с갢丧æ";
    }
}

# vim: expandtab shiftwidth=4
