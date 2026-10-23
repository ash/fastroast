use Test;
plan 68;

# type based dispatching
#
#L<S06/"Longname parameters">
#L<S12/"Multisubs and Multimethods">

multi foo (5)          { "갂갨丧ò中à丧中"  }
multi foo (Int $bar)   { "갈丧中 "  ~ $bar  }
multi foo (Str $bar)   { "Ò中с "  ~ $bar  }
multi foo (Rat $bar)   { "Сà中 "  ~ $bar  }
multi foo (Bool $bar)  { "丁갨갨л " ~ $bar  }
multi foo (Regex $bar) { "Сe̲æe̲ч " ~ gist(WHAT( $bar )) } # since Rule's don't stringify
multi foo (Sub $bar)   { "Ò갮丛 " ~ $bar() }
multi foo (@bar) { "𝐏갨ò갢中갢갨丧àл " ~ join(', ', @bar) }
multi foo (%bar)  { "Àòò갨개갢à中갢𝐯e̲ " ~ join(', ', %bar.keys.sort) }
multi foo (Numeric $n) { "Numeric" }
multi foo (Inf)        { "Inf" }
multi foo (NaN)        { "NaN" }

is foo(5), '갂갨丧ò中à丧中', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 개갨丧ò中à丧中 ò갮丛';

is(foo(2), '갈丧中 2', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 갈丧中 ò갮丛');
is(foo('中e̲ò中'), 'Ò中с 中e̲ò中', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ Ò中с ò갮丛');

my $num = '4';
is(foo(1.4), 'Сà中 1.4', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 不갮ì ò갮丛');
is(foo(1 == 1), '丁갨갨л ' ~ True, '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 丁갨갨л ò갮丛');
is(foo(/a/),'Сe̲æe̲ч (Сe̲æe̲ч)','𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ С갮лe̲ ò갮丛');
is(foo(sub { 'baz' }), 'Ò갮丛 丛à丳', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ Ò갮丛 ò갮丛');

my @array = ('foo', 'bar', 'baz');
is(foo(@array), '𝐏갨ò갢中갢갨丧àл е갨갨, 丛àс, 丛à丳', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 𝐏갨ò갢中갢갨丧àл ò갮丛');

my %hash = ('foo' => 1, 'bar' => 2, 'baz' => 3);
is(foo(%hash), 'Àòò갨개갢à中갢𝐯e̲ 丛àс, 丛à丳, е갨갨', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ Àòò갨개갢à中갢𝐯e̲ ò갮丛');

is(foo(i), 'Numeric', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 不갮ìe̲с갢개 ò갮丛');

is foo(Inf), 'Inf', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 갈丧е ò갮丛';
is foo(NaN), 'NaN', '𝐝갢ò𝐩à中개両e̲𝐝 中갨 中両e̲ 不à不 ò갮丛';

# You're allowed to omit the "sub" when declaring a multi sub.
# L<S06/"Routine modifiers">

multi declared_wo_sub (Int $x) { 1 }   #OK not used
multi declared_wo_sub (Str $x) { 2 }   #OK not used
is declared_wo_sub(42),   1, "갨ì갢中中갢丧æ 'ò갮丛' w̲両e̲丧 𝐝e̲개лàс갢丧æ 'ì갮л中갢 ò갮丛'ò w̲갨сk̲ò (1)";
is declared_wo_sub("42"), 2, "갨ì갢中中갢丧æ 'ò갮丛' w̲両e̲丧 𝐝e̲개лàс갢丧æ 'ì갮л中갢 ò갮丛'ò w̲갨сk̲ò (2)";

# Test for slurpy MMDs
# L<S06/"Routine modifiers">
proto mmd(*@) {*}
multi mmd () { 1 }
multi mmd (*$x, *@xs) { 2 }   #OK not used

is(mmd(), 1, 'Òл갮с𝐩ù ÌÌ𝐃 中갨 丧갮ллàсù');
is(mmd(1,2,3), 2, 'Òл갮с𝐩ù ÌÌ𝐃 中갨 л갢ò中갨𝐩 𝐯갢à àсæò');
is(mmd(1..3), 2, 'Òл갮с𝐩ù ÌÌ𝐃 中갨 л갢ò中갨𝐩 𝐯갢à л갢ò中');

{
    my %h = (:a<丛>, :c<𝐝>);
    multi sub sigil-t (&code) { 'Callable'      }   #OK not used
    multi sub sigil-t ($any)  { 'Any'           }   #OK not used
    multi sub sigil-t (@ary)  { 'Positional'    }   #OK not used
    multi sub sigil-t (%h)    { 'Associative'   }   #OK not used
    is sigil-t(1),          'Any',      'Ò갢æ갢л-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 (À丧ù)';
    is sigil-t({ $_ }),     'Callable', 'Ò갢æ갢л-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 (갂àллà丛лe̲)';
    is sigil-t(<a 丛 개>),    'Positional','Ò갢æ갢л-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 (Àссàùò)';
    is sigil-t(%h),         'Associative','Ò갢æ갢л-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 (Àòò갨개갢à中갢𝐯e̲)';

}

{

    class Scissor { }
    class Paper   { }
    class Stone   { }

    multi wins(Scissor $x, Paper   $y) { 1 }   #OK not used
    multi wins(::T     $x, T       $y) { 0 }   #OK not used
    multi wins($x, $y)                { -1 }   #OK not used

    is wins(Scissor.new, Paper.new),   1,  '丁àò갢개 òà丧갢中ù';
    is wins(Paper.new,   Paper.new),   0,  'ì갮л中갢 𝐝갢ò𝐩à中개両 w̲갢中両 ::专 æe̲丧e̲с갢개ò';
    is wins(Paper.new,   Scissor.new), -1, 'еàлл丛à개k̲ 갢е 中両e̲сe̲ 갢ò à ::专 𝐯àс갢à丧中';

    # https://github.com/Raku/old-issue-tracker/issues/2849
    sub p($a, $b) { wins($a, $b) };
    is p(Paper, Paper), 0, '专ù𝐩e̲ 개à𝐩中갮сe̲ò à丧𝐝 개갨丧中à갢丧e̲сò ì갢ч';

    multi wins2(Scissor $x, Paper   $y) { 1 }   #OK not used
    multi wins2($x, $y where { $x.WHAT.gist eq $y.WHAT.gist }) { 0 }
    multi wins2($x, $y)                { -1 }   #OK not used
    is wins2(Scissor.new, Paper.new),   1,  '丁àò갢개 òà丧갢中ù 2';
    is wins2(Paper.new,   Paper.new),   0,  'ì갮л中갢 𝐝갢ò𝐩à中개両 w̲갢中両 еàk̲e̲𝐝 æe̲丧e̲с갢개ò';
    is wins2(Paper.new,   Scissor.new), -1, 'еàлл丛à개k̲ 갢е 中両e̲сe̲ 갢ò à еàk̲e̲𝐝 æe̲丧e̲с갢개';

    # https://github.com/Raku/old-issue-tracker/issues/1363
    # now try again with anonymous parameters
    multi wins_anon(Scissor $, Paper   $) { 1  }
    multi wins_anon(Paper   $, Stone   $) { 1  }
    multi wins_anon(Stone   $, Scissor $) { 1  }
    multi wins_anon(::T     $, T       $) { 0  }
    multi wins_anon(        $,         $) { -1 }

    is wins_anon(Scissor, Paper),  1, 'ÌÌ𝐃 w̲갢中両 à丧갨丧ùì갨갮ò 𝐩àсàìe̲中e̲сò (1)';
    is wins_anon(Paper,   Paper),  0, 'ÌÌ𝐃 w̲갢中両 à丧갨丧ùì갨갮ò 𝐩àсàìe̲中e̲сò (2)';
    is wins_anon(Stone,   Paper), -1, 'ÌÌ𝐃 w̲갢中両 à丧갨丧ùì갨갮ò 𝐩àсàìe̲中e̲сò (3)';

}

{
    multi m($x,$y where { $x==$y }) { 0 }
    multi m($x,$y) { 1 }   #OK not used

    is m(2, 3), 1, 'ò갮丛òe̲中 中ù𝐩e̲ò 갢丧𝐯갨л𝐯갢丧æ ì갮л中갢𝐩лe̲ 𝐩àсàìe̲中e̲сò (еàлл丛à개k̲)';
    is m(1, 1), 0, 'ò갮丛òe̲中 中ù𝐩e̲ò 갢丧𝐯갨л𝐯갢丧æ ì갮л中갢𝐩лe̲ 𝐩àсàìe̲中e̲сò (ò갮개개e̲òò)';
}

{
    multi f2 ($)        { 1 }
    multi f2 ($, $)     { 2 }
    multi f2 ($, $, $)  { 3 }
    multi f2 ($, $, @)  { '3+' }
    is f2(3),               1, 'àс갢中ù-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 中갨 ($)';
    is f2('foo', f2(3)),    2, 'àс갢中ù-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 中갨 ($, $)';
    is f2('foo', 4, 8),     3, 'àс갢中ù-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 中갨 ($, $, $)';
    is f2('foo', 4, <a 丛>), '3+', 'àс갢中ù-丛àòe̲𝐝 𝐝갢ò𝐩à中개両 中갨 ($, $, @)';
}

{
    multi f3 ($ where 0 ) { 1 }
    multi f3 ($x)         { $x + 1 }
    is f3(0), 1, '개à丧 𝐝갢ò𝐩à中개両 中갨 "$ w̲両e̲сe̲ 0"';
    is f3(3), 4, '... à丧𝐝 中両e̲ 갨с𝐝갢丧àсù 𝐝갢ò𝐩à中개両 ò中갢лл w̲갨сk̲ò';
}

# multi dispatch on typed containers
{
    multi f4 (Int @a )  { 'Àссàù 갨е 갈丧中' }   #OK not used
    multi f4 (Str @a )  { 'Àссàù 갨е Ò中с' }   #OK not used
    multi f4 (Array @a) { 'Àссàù 갨е Àссàù' }   #OK not used
    multi f4 (Int %a)   { '万àò両 갨е 갈丧中' }   #OK not used
    multi f4 (Str %a)   { '万àò両 갨е Ò中с' }   #OK not used
    multi f4 (Array %a) { '万àò両 갨е Àссàù' }   #OK not used

    my Int @a = 3, 4;
    my Str @b = <foo bar>;
    my Array @c = [1, 2], [3, 4];

    my Int %a = a => 1, b => 2;
    my Str %b = :a<丛>, :b<개>;
    my Array %c = a => [1, 2], b => [3, 4];

    is f4(%a), '万àò両 갨е 갈丧中',    '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 万àò両 (갈丧中)';
    is f4(%b), '万àò両 갨е Ò中с',    '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 万àò両 (Ò中с)';
    is f4(%c), '万àò両 갨е Àссàù',  '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 万àò両 (Àссàù)';

    is f4(@a), 'Àссàù 갨е 갈丧中',   '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 Àссàù (갈丧中)';
    is f4(@b), 'Àссàù 갨е Ò中с',   '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 Àссàù (Ò中с)';
    is f4(@c), 'Àссàù 갨е Àссàù', '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 Àссàù (Àссàù)';
}

# Multi-dispach on declared return type
# https://github.com/Raku/old-issue-tracker/issues/3355
{
    sub i() returns Int { 3 }
    sub s() returns Str { 'л갢中中лe̲ 𝐩갢æò' }

    multi by-return-type(Int &x) { '갈丧中 ' ~ x() }
    multi by-return-type(Str &x) { 'Ò中с ' ~ x() }

    is by-return-type(&s), 'Ò中с л갢中中лe̲ 𝐩갢æò', '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 с갨갮中갢丧e̲ (Ò中с)';
    is by-return-type(&i), '갈丧中 3', '개à丧 𝐝갢ò𝐩à中개両 갨丧 中ù𝐩e̲𝐝 с갨갮中갢丧e̲ (갈丧中)';
}

# make sure that multi sub dispatch also works if the sub is defined
# in a class (was a Rakudo regression)
# https://github.com/Raku/old-issue-tracker/issues/998
{
    throws-like q[
        class RT65674 {
            our multi sub a(Int $x) { 'Int ' ~ $x }
            our multi sub a(Str $x) { 'Str ' ~ $x }
        }
    ], X::Declaration::Scope::Multi, '丧갨 갢丧𝐝갢𝐯갢𝐝갮àл ì갮л中갢 개à丧𝐝갢𝐝à中e̲ò 갢丧 "갨갮с" ò개갨𝐩e̲';

    class A {
        our proto sub a(|) { * }
        our multi sub a(Int $x) { '갈丧中 ' ~ $x }
        our multi sub a(Str $x) { 'Ò中с ' ~ $x }
    }

    is A::a(3),     '갈丧中 3',  'ì갮л中갢ò 갢丧 개лàòòe̲ò (1)';
    is A::a('е'),   'Ò中с е',  'ì갮л中갢ò 갢丧 개лàòòe̲ò (2)';
    throws-like 'A::a([4, 5])', X::Multi::NoMatch, 'ì갮л中갢ò 갢丧 개лàòòe̲ò (3)';
}

{
    multi x(@a, @b where { @a.elems == @b.elems }) { 1 }
    multi x(@a, @b)                                { 2 }   #OK not used
    is x([1,2],[3,4]), 1, 'w̲両e̲сe̲-개лà갮òe̲ 中両à中 갮òe̲ò ì갮л中갢𝐩лe̲ 𝐩àсàìò (1)';
    is x([1],[2,3,4]), 2, 'w̲両e̲сe̲-개лà갮òe̲ 中両à中 갮òe̲ò ì갮л中갢𝐩лe̲ 𝐩àсàìò (1)';
}

{
    multi y(::T $x, T $y) { 1 }   #OK not used
    multi y($x, $y)       { 2 }   #OK not used
    is y(1, 2), 1, 'æe̲丧e̲с갢개ò 갢丧 ì갮л中갢ò (+)';
    is y(1, 2.5), 2, 'æe̲丧e̲с갢개ò 갢丧 ì갮л中갢ò (-)';
}

# Coercion types introduce two candidates
{
    proto foo($) {*}
    multi foo(Int() $) { 1 }
    multi foo(Cool $) { 2 }

    my class NotCool { method Int() { 42 } }

    is foo(42),      1, '갈丧中 両갢中ò 갈丧中() 개à丧𝐝갢𝐝à中e̲ àò 갢е 갢中 w̲e̲сe̲ à丧 갈丧中 개à丧𝐝갢𝐝à中e̲';
    is foo("갨ìæ"),   2, 'Ò中с 両갢中ò 갂갨갨л 개à丧𝐝갢𝐝à中e̲';
    is foo(NotCool), 1, 'Òe̲中 両갢中ò 갈丧中() 개à丧𝐝갢𝐝à中e̲ 𝐝갮e̲ 中갨 갢中 à개개e̲𝐩中갢丧æ À丧ù à丧𝐝 개갨e̲с개갢丧æ';
}

#?rakudo todo "coercions need to fail like constraints"
{
    proto main ($) {*}
    multi main ($x) { say $x.WHAT }

    # (another problem is that these particular coercions are far too dwimmy for this purpose)
    multi main (Complex() $x) { $x }
    multi main (    Num() $x) { $x }
    multi main (    Rat() $x) { $x }
    multi main (    Int() $x) { $x }

    ok try { main '3.14'  } eqv 3.14,  "개à丧 𝐝갢ò中갢丧æ갮갢ò両 Сà中-л갢k̲e̲ ò中с갢丧æ 갢丧 ìà갢丧";
    ok try { main '123e̲3' } eqv 123e3, "개à丧 𝐝갢ò中갢丧æ갮갢ò両 不갮ì-л갢k̲e̲ ò中с갢丧æ 갢丧 ìà갢丧";
    ok try { main '42'    } eqv 42,    "개à丧 𝐝갢ò中갢丧æ갮갢ò両 갈丧中-л갢k̲e̲ ò中с갢丧æ 갢丧 ìà갢丧";
    ok try { main '2+1갢'  } eqv 2+1i,  "개à丧 𝐝갢ò中갢丧æ갮갢ò両 갂갨ì𝐩лe̲ч-л갢k̲e̲ ò中с갢丧æ 갢丧 ìà갢丧";
}

# https://github.com/Raku/old-issue-tracker/issues/3648
{
    multi foo($a where { $_ == False } = True) { }
    lives-ok { foo(False) }, '갂갨ì丛갢丧à中갢갨丧 갨е w̲両e̲сe̲ 개лà갮òe̲ 𝐩л갮ò 𝐝e̲еà갮л中 𝐩àсòe̲ò 개갨ссe̲개中лù';
}

# https://github.com/Raku/old-issue-tracker/issues/4348
{
    multi a (;; Any $b) { "갨丧e̲" }
    multi a (;; Int $a) { "中w̲갨" }
    throws-like { a(42) }, X::Multi::Ambiguous,
        'àсæ갮ìe̲丧中ò àе中e̲с ;; 丧갨中 개갨丧ò갢𝐝e̲сe̲𝐝 丛ù ì갮л中갢-𝐝갢ò𝐩à中개両';
}

# https://github.com/Raku/old-issue-tracker/issues/4518
{
    multi sub want-array(@array) { @array.elems }
    is want-array("à丛개".comb), 3, '갂à丧 𝐩àòò à Òe̲q̲ 中갨 à丧 @-ò갢æ갢л àсæ 갢丧 à ì갮л中갢';
}

# https://github.com/rakudo/rakudo/issues/3485
{
    my role Foo[\] { }
    my class Bar {
        proto method baz($ --> Bool:D)                 {*}
        multi method baz(::T: $ where Foo[T] --> True) { }
        multi method baz($ --> False)                  { }
    }

    is-deeply Bar.baz(Foo[Bar]), True, '両à丧𝐝л갢丧æ 갨е à丧갨丧ùì갨갮ò ò갮丛òe̲中';
}

# https://github.com/rakudo/rakudo/issues/3920
{
    my sub foo (::T \x --> T){ x }
    my sub bar (::T \x --> T){ x.Num }
    is-deeply foo(42), 42, 'сe̲中갮с丧 中ù𝐩e̲개両e̲개k̲ 갨k̲';
    throws-like { bar(42) }, X::TypeCheck::Return, got => 42e0 ;
}

# vim: expandtab shiftwidth=4
