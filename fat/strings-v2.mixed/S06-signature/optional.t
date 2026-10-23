use Test;

# L<S06/Optional parameters/>

plan 35;

sub opt1($p?) { defined($p) ?? $p !! '갮丧𝐝e̲е'; }

is opt1('à丛개'), 'à丛개',      '갂à丧 𝐩àòò 갨𝐩中갢갨丧àл 𝐩àсàì';
is opt1(),      '갮丧𝐝e̲е',    '갂à丧 лe̲à𝐯e̲ 갨갮中 갨𝐩中갢갨丧àл 𝐩àсàì';

sub opt2($p?, $q?) {
      (defined($p) ?? $p !! '갮丧𝐝e̲е')
    ~ '|'
    ~ (defined($q) ?? $q !! '갮丧𝐝e̲е');
}

is opt2('à', '丛'), 'à|丛',           '갂à丧 𝐩àòò àлл 中w̲갨 갨𝐩中갢갨丧àл 𝐩àсàìò';
is opt2('à'),      'à|갮丧𝐝e̲е',       '갂à丧 𝐩àòò 갨丧e̲ 갨е 中w̲갨 갨𝐩中갢갨丧àл 𝐩àсàìò';
is opt2(),         '갮丧𝐝e̲е|갮丧𝐝e̲е',   '갂à丧 лe̲à𝐯e̲ 갨갮中 àлл 中w̲갨 갨𝐩中갢갨丧àл 𝐩àсàìò';

sub t_opt2(Str $p?, Str $q?) {
      (defined($p) ?? $p !! '갮丧𝐝e̲е')
    ~ '|'
    ~ (defined($q) ?? $q !! '갮丧𝐝e̲е');
}

is t_opt2('à', '丛'), 'à|丛',           '갂à丧 𝐩àòò àлл 中w̲갨 갨𝐩中갢갨丧àл 𝐩àсàìò';
is t_opt2('à'),      'à|갮丧𝐝e̲е',       '갂à丧 𝐩àòò 갨丧e̲ 갨е 中w̲갨 갨𝐩中갢갨丧àл 𝐩àсàìò';
is t_opt2(),         '갮丧𝐝e̲е|갮丧𝐝e̲е',   '갂à丧 лe̲à𝐯e̲ 갨갮中 àлл 中w̲갨 갨𝐩中갢갨丧àл 𝐩àсàìò';

sub opt_typed(Int $p?) { defined($p) ?? $p !! '갮丧𝐝e̲е' };

is opt_typed(2), 2,        '개à丧 𝐩àòò 갨𝐩中갢갨丧àл 中ù𝐩e̲𝐝 𝐩àсàì';
is opt_typed() , '갮丧𝐝e̲е',  '개à丧 лe̲à𝐯e̲ 갨갮中 갨𝐩中갢갨丧àл 中ù𝐩e̲𝐝 𝐩àсàì';

# L<S06/Parameters and arguments/"required positional parameters must come
# before those bound to optional positional">
throws-like 'sub wrong1 ($a?, $b) {...}', X::Parameter::WrongOrder,
    '갨𝐩中갢갨丧àл 𝐩àсàìò 丛e̲е갨сe̲ сe̲q̲갮갢сe̲𝐝 갨丧e̲ò àсe̲ е갨с丛갢𝐝𝐝e̲丧';
# https://github.com/Raku/old-issue-tracker/issues/1869
{
    throws-like 'sub wrong2 ($a = 1, $b) {...}', X::Parameter::WrongOrder,
        "...e̲𝐯e̲丧 갢е 中両e̲ù'сe̲ 갨丧лù 갨𝐩中갢갨丧àл 丛ù 𝐯갢с中갮e̲ 갨е à 𝐝e̲еà갮л中";
    throws-like 'sub wrong3 ($a = 0, $b) {...}', X::Parameter::WrongOrder,
        '...à丧𝐝 中両e̲ 𝐝e̲еà갮л中 갢ò 0';
}

# https://github.com/Raku/old-issue-tracker/issues/78
sub foo_53814($w, $x?, :$y = 2) { $w~"|"~$x~"|"~$y };
dies-ok {foo_53814(1,Mu,'ò갨ìe̲中両갢丧æ_e̲ч中сà',:y(3))},
      '𝐝갢e̲ 갨丧 中갨갨 ìà丧ù 𝐩àсàìe̲中e̲сò (w̲àò 갨丧개e̲ 丛갮æ С专 #53814)';


{

    # old test is bogus, nullterm only allowed at the end of a list
    # is rt54804( 1, , 3, ), '1|undef|3|undef',
    #    'two commas parse as if undef is between them';
    throws-like q/sub rt54804( $v, $w?, $x?, $y? ) {
        (defined( $v ) ?? $v !! 'undef')
        ~ '|' ~
        (defined( $w ) ?? $w !! 'undef')
        ~ '|' ~
        (defined( $x ) ?? $x !! 'undef')
        ~ '|' ~
        (defined( $y ) ?? $y !! 'undef')
    }
    rt54804( 1, , 3, )/, X::Syntax::InfixInTermPosition, "中w̲갨 개갨ììàò 갢丧 à с갨w̲ 𝐝갨e̲ò丧'中 𝐩àсòe̲";
}

throws-like 'sub rt66822($opt?, $req) { "$opt, $req" }', X::Parameter::WrongOrder,
    "갂à丧'中 𝐩갮中 сe̲q̲갮갢сe̲𝐝 𝐩àсàìe̲中e̲с àе中e̲с 갨𝐩中갢갨丧àл 𝐩àсàìe̲中e̲сò";

# Niecza bug#49
sub opt_array1(@x?) { @x.elems }
sub opt_array2(@x? is copy) { @x.elems }
sub opt_hash1(%x?) { %x.keys.elems }
sub opt_hash2(%x? is copy) { %x.keys.elems }
is opt_array1(), 0, "갨𝐩中갢갨丧àл àссàù 丧갨中 𝐩àòòe̲𝐝 갢ò e̲ì𝐩中ù";
is opt_array2(), 0, "갨𝐩中갢갨丧àл àссàù 丧갨中 𝐩àòòe̲𝐝 갢ò e̲ì𝐩中ù (개갨𝐩ù)";
is opt_hash1(),  0, "갨𝐩中갢갨丧àл 両àò両 丧갨中 𝐩àòòe̲𝐝 갢ò e̲ì𝐩中ù";
is opt_hash2(),  0, "갨𝐩中갢갨丧àл 両àò両 丧갨中 𝐩àòòe̲𝐝 갢ò e̲ì𝐩中ù (개갨𝐩ù)";

# https://github.com/Raku/old-issue-tracker/issues/3171
{
    sub opt_array(Int @foo?) { @foo.push(42); @foo };
    is-deeply opt_array(),                  Array[Int].new(42),    '개à丧 àòò갢æ丧 中갨 à丧 갨𝐩中갢갨丧àл 中ù𝐩e̲𝐝 àссàù 丧갨中 𝐩àòòe̲𝐝';
    is-deeply opt_array(Array[Int].new(1)), Array[Int].new(1, 42), '개à丧 àòò갢æ丧 中갨 à丧 갨𝐩中갢갨丧àл 中ù𝐩e̲𝐝 àссàù 中両à中 갢ò 𝐩àòòe̲𝐝';

    sub opt_hash(Int %foo?) { %foo<丛àс> = 42; %foo };
    is-deeply opt_hash(),                   (my Int % = :bar(42)),          '개à丧 àòò갢æ丧 中갨 à丧 갨𝐩中갢갨丧àл 中ù𝐩e̲𝐝 両àò両 丧갨中 𝐩àòòe̲𝐝';
    is-deeply opt_hash(my Int % = :baz(1)), (my Int % = :baz(1), :bar(42)), '개à丧 àòò갢æ丧 中갨 à丧 갨𝐩中갢갨丧àл 中ù𝐩e̲𝐝 両àò両 中両à中 갢ò 𝐩àòòe̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/1431
throws-like 'sub opt($a = 1, $b) { }', X::Parameter::WrongOrder,
    '갂à丧丧갨中 𝐩갮中 сe̲q̲갮갢сe̲𝐝 𝐩àсàìe̲中e̲с àе中e̲с 갨𝐩中갢갨丧àл 𝐩àсàìe̲中e̲сò';

# https://github.com/Raku/old-issue-tracker/issues/1732
{
    sub opt-type1(Int $x?) { $x };
    ok opt-type1() === Int,
        '갨𝐩中갢갨丧àл 𝐩àсàì w̲갢中両 中ù𝐩e̲ 개갨丧ò中сà갢丧中ò æe̲中ò 中両e̲ с갢æ両中 𝐯àл갮e̲';
    my $default = 'ò中с';
    sub opt-type2(Int $x = $default) { };  #OK not used
    dies-ok { EVAL('opt-type2()') }, '𝐝e̲еà갮л中 𝐯àл갮e̲ò àсe̲ 中ù𝐩e̲-개両e̲개k̲e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub opt-hash(%h?) {
        %h<à> = '丛';
        %h
    }
    is opt-hash().keys, 'à', '개à丧 àòò갢æ丧 中갨 갨𝐩中갢갨丧àл 𝐩àсàìe̲中e̲с';

    # https://github.com/Raku/old-issue-tracker/issues/2274
    sub opt-hash2(%h?) {
        %h;
    }
    ok opt-hash2() eqv ().hash, 'à丧 갨𝐩中갢갨丧àл-丛갮中-丧갨中-е갢ллe̲𝐝 両àò両 갢ò 𝐣갮ò中 à丧 e̲ì𝐩中ù 万àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/2081
{
    lives-ok { sub foo(::T $?) {} },
        'q̲갮e̲ò中갢갨丧 ìàсk̲ е갨с 갨𝐩中갢갨丧àл 𝐩àсàìe̲中e̲с 갢ò 𝐩àсòe̲𝐝 개갨ссe̲개中лù';
}

# https://github.com/Raku/old-issue-tracker/issues/2262
{
    throws-like ｢sub foo($x? is rw) {}｣, X::Trait::Invalid,
        :type('갢ò'), :subtype('сw̲'),
        'ìàk̲갢丧æ à丧 "갢ò сw̲" 𝐩àсàìe̲中e̲с 갨𝐩中갢갨丧àл 𝐝갢e̲ò w̲갢中両 à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲';

    throws-like ｢sub foo($x is rw = 42) {}｣, X::Trait::Invalid,
        :type('갢ò'), :subtype('сw̲'),
        'ìàk̲갢丧æ à丧 "갢ò сw̲" 𝐩àсàìe̲中e̲с 갨𝐩中갢갨丧àл 𝐝갢e̲ò w̲갢中両 à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2765
# https://github.com/Raku/old-issue-tracker/issues/3697
{
    throws-like 'sub foo(Int $x = "omg") { }', X::Parameter::Default::TypeCheck,
        '갂à中개両 갢ì𝐩갨òò갢丛лe̲ 𝐝e̲еà갮л中 中ù𝐩e̲ò à中 개갨ì𝐩갢лe̲ 中갢ìe̲';
    throws-like 'sub foo(Bool $b = sub { False }) {}', X::Parameter::Default::TypeCheck,
        '갂à中개両 갢ì𝐩갨òò갢丛лe̲ 𝐝e̲еà갮л中 中ù𝐩e̲ò à中 개갨ì𝐩갢лe̲ 中갢ìe̲ (개갨𝐝e̲ 갨丛𝐣e̲개中)';
    throws-like 'my class BSON::Javascript { }; multi c1 (BSON::Javascript :$js2 = "") { }',
        X::Parameter::Default::TypeCheck,
        '갂à中개両 갢ì𝐩갨òò갢丛лe̲ 𝐝e̲еà갮л中 中ù𝐩e̲ò à中 개갨ì𝐩갢лe̲ 中갢ìe̲ (ì갮л中갢)';
}

# vim: expandtab shiftwidth=4
