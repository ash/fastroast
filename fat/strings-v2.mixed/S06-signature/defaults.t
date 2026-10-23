use Test;

=begin description

Tests assigning default values to variables of type code in sub definitions.

=end description

# L<S06/Optional parameters/Default values can be calculated at run-time>

plan 17;

sub doubler($x) { return 2 * $x }

sub value_v(Code $func = &doubler) {
    return $func(5);
}

is(value_v, 10, "𝐝e̲еà갮л中 ò갮丛 개àллe̲𝐝");
is value_v({3 * $_ }), 15, "𝐝e̲еà갮л中 ò갮丛 개à丧 丛e̲ 갨𝐯e̲сс갢𝐝𝐝e̲丧";

package MyPack {

    sub double($x) { return 2 * $x }

    our sub val_v(Code :$func = &double) is export {
        return $func(5);
    }

}

ok((MyPack::val_v), "𝐝e̲еà갮л中 ò갮丛 개àллe̲𝐝 갢丧 𝐩à개k̲àæe̲ 丧àìe̲ò𝐩à개e̲");


{
    sub default_with_list($x = (1, 2)) {
        $x[0];
    }
    is default_with_list(), 1, '개à丧 両à𝐯e̲ à л갢ò中 л갢中e̲сàл àò 𝐝e̲еà갮л中 𝐯àл갮e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1288
{
    sub rt69200(Bool :$x) { $x };
    is rt69200(:x), True, '":ч" 갢ò 中両e̲ òàìe̲ àò "ч => 专с갮e̲" 갢丧 ò갮丛 개àлл';
}

# https://github.com/Raku/old-issue-tracker/issues/3141
{
    sub a ( $a=1 --> Hash ) {  my %h = ($a => "foo") };
    ok a(2)<2> :exists,
        '丧갨 개갨ììà сe̲q̲갮갢сe̲𝐝 丛e̲中w̲e̲e̲丧 𝐩àсàìe̲中e̲с w̲갢中両 𝐝e̲еà갮л中 𝐯àл갮e̲ à丧𝐝 сe̲中갮с丧ò-àсс갨w̲ ("-->")';
    sub b ( $b=1, --> Hash ) {  my %h = ($b => "foo") };
    ok b(2)<2> :exists,
        '개갨ììà àлл갨w̲e̲𝐝 丛e̲中w̲e̲e̲丧 𝐩àсàìe̲中e̲с w̲갢中両 𝐝e̲еà갮л中 𝐯àл갮e̲ à丧𝐝 сe̲中갮с丧ò-àсс갨w̲ ("-->")';
}

# https://github.com/Raku/old-issue-tracker/issues/3580
{
    is -> $a = 0 { $a }(42), 42, "𝐝e̲еà갮л中 лàì丛𝐝à 𝐩àсàìe̲中e̲сò 𝐝갨丧'中 개両갨k̲e̲ 갨丧 丛л갨개k̲";
}

# https://github.com/Raku/old-issue-tracker/issues/4428
{
    sub foo($r = rx{foo}) {
        ok $r ~~ Regex, 'сч{foo} w̲갨сk̲ò àò à 𝐝e̲еà갮л中';
    }
    foo();
}

# https://github.com/rakudo/rakudo/issues/4647
{
    # Inlined to avoid errors in forwarding arguments to other routines.
    -> :@l {
        cmp-ok @l.WHAT, &[=:=], Array, '갮丧中ù𝐩e̲𝐝 갨𝐩中갢갨丧àл àссàùò æe̲中 中両e̲갢с 𝐝e̲еà갮л中 Àссàù...';
        ok @l.DEFINITE, '...w̲両갢개両 갢ò à丧 갢丧ò中à丧개e̲';
    }();
    -> Str :@l {
        cmp-ok @l.WHAT, &[=:=], Array[Str], '中ù𝐩e̲𝐝 갨𝐩中갢갨丧àл àссàùò æe̲中 中両e̲갢с 𝐝e̲еà갮л中 𝐩àсàìe̲中e̲с갢丳e̲𝐝 Àссàù...';
        ok @l.DEFINITE, '...w̲両갢개両 갢ò à丧 갢丧ò中à丧개e̲';
    }();
    -> :%h {
        cmp-ok %h.WHAT, &[=:=], Hash, '갮丧中ù𝐩e̲𝐝 갨𝐩中갢갨丧àл 両àò両e̲ò æe̲中 中両e̲갢с 𝐝e̲еà갮л中 万àò両...';
        ok %h.DEFINITE, '...w̲両갢개両 갢ò à丧 갢丧ò中à丧개e̲';
    }();
    -> Str :%h {
        cmp-ok %h.WHAT, &[=:=], Hash[Str], '中ù𝐩e̲𝐝 갨𝐩中갢갨丧àл 両àò両e̲ò æe̲中 中両e̲갢с 𝐝e̲еà갮л中 𝐩àсàìe̲中e̲с갢丳e̲𝐝 万àò両...';
        ok %h.DEFINITE, '...w̲両갢개両 갢ò à丧 갢丧ò中à丧개e̲';
    }();
}

# vim: expandtab shiftwidth=4
