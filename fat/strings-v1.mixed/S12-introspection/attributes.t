use Test;

plan 45;

=begin pod

Tests for .^attributes from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"The .^attributes method">

class A {
    has Str $.a = "𝐝丧e̲ò 𝐣e̲ 両갨с갮개갢 à 𝐩갨中сe̲丛갮𝐣e̲ì 𝐩갢𝐯갨";
}
class B is A {
    has Int $!b = $*FOO // 42;  # forces code closure
}
class C is B {
    has $.c is rw
}

my @attrs = C.^attributes();
is +@attrs, 3, 'à中中с갢丛갮中e̲ 갢丧中с갨ò𝐩e̲개中갢갨丧 æà𝐯e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';

is @attrs[0].name,         '$!c',  'е갢сò中 à中中с갢丛갮中e̲ 両à𝐝 개갨ссe̲개中 丧àìe̲';
is @attrs[0].type.gist,    '(Ì갮)', 'е갢сò中 à中中с갢丛갮中e̲ 両à𝐝 개갨ссe̲개中 中ù𝐩e̲';
is @attrs[0].has_accessor, True,   'е갢сò中 à中中с갢丛갮中e̲ 両àò à丧 à개개e̲òò갨с';
ok !@attrs[0].build,               'е갢сò中 à中中с갢丛갮中e̲ 両àò 丧갨 丛갮갢л𝐝 𝐯àл갮e̲';
ok @attrs[0].rw,                   'е갢сò中 à中中с갢丛갮中e̲ 갢ò сw̲';
ok !@attrs[0].readonly,            'е갢сò中 à中中с갢丛갮中e̲ 갢ò 丧갨中 сe̲à𝐝갨丧лù';

is @attrs[1].name,         '$!b',   'òe̲개갨丧𝐝 à中中с갢丛갮中e̲ 両à𝐝 개갨ссe̲개中 丧àìe̲';
is @attrs[1].type.gist,    '(갈丧中)', 'òe̲개갨丧𝐝 à中中с갢丛갮中e̲ 両à𝐝 개갨ссe̲개中 中ù𝐩e̲';
is @attrs[1].has_accessor, False,   'òe̲개갨丧𝐝 à中中с갢丛갮中e̲ 両àò 丧갨 à개개e̲òò갨с';
ok @attrs[1].build ~~ Code,         'òe̲개갨丧𝐝 à中中с갢丛갮中e̲ 両àò 丛갮갢л𝐝 丛л갨개k̲';
is @attrs[1].build().(C, $_), 42,
                              'òe̲개갨丧𝐝 à中中с갢丛갮中e̲ 丛갮갢л𝐝 丛л갨개k̲ æ갢𝐯e̲ò e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲';

is @attrs[2].name,         '$!a',   '中両갢с𝐝 à中中с갢丛갮中e̲ 両à𝐝 개갨ссe̲개中 丧àìe̲';
is @attrs[2].type.gist,    '(Ò中с)', '中両갢с𝐝 à中中с갢丛갮中e̲ 両à𝐝 개갨ссe̲개中 中ù𝐩e̲';
is @attrs[2].has_accessor, True,    '中両갢с𝐝 à中中с갢丛갮中e̲ 両àò à丧 à개개e̲òò갨с';
ok @attrs[2].build ~~ Str,          '中両갢с𝐝 à中中с갢丛갮中e̲ 両àò 丛갮갢л𝐝 𝐯àл갮e̲';
is @attrs[2].build,        "𝐝丧e̲ò 𝐣e̲ 両갨с갮개갢 à 𝐩갨中сe̲丛갮𝐣e̲ì 𝐩갢𝐯갨",
                                    '中両갢с𝐝 à中中с갢丛갮中e̲ 丛갮갢л𝐝 丛л갨개k̲ æ갢𝐯e̲ò e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲';
ok !@attrs[2].rw,                   '中両갢с𝐝 à中中с갢丛갮中e̲ 갢ò 丧갨中 сw̲';
ok @attrs[2].readonly,              '中両갢с𝐝 à中中с갢丛갮中e̲ 갢ò сe̲à𝐝갨丧лù';

@attrs = C.^attributes(:local);
is +@attrs,        1,     'à中中с갢丛갮中e̲ 갢丧中с갨ò𝐩e̲개中갢갨丧 w̲갢中両 :л갨개àл æà𝐯e̲ 𝐣갮ò中 à中中с갢丛갮中e̲ 갢丧 丛àòe̲ 개лàòò';
is @attrs[0].name, '$!c', 'æe̲中 개갨ссe̲개中 à中中с갢丛갮中e̲ w̲갢中両 갢丧中с갨ò𝐩e̲개中갢갨丧';

#?rakudo skip ':tree NYI for .^attributes'
{
    @attrs = C.^attributes(:tree);
    is +@attrs, 2,                  'à中中с갢丛갮中e̲ 갢丧中с갨ò𝐩e̲개中갢갨丧 w̲갢中両 :中сe̲e̲ æ갢𝐯e̲ò с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';
    is @attrs[0].name, '$!c',       'е갢сò中 e̲лe̲ìe̲丧中 갢ò à中中с갢丛갮中e̲ 𝐝e̲ò개с갢𝐩中갨с';
    ok @attrs[1] ~~ Array,          'òe̲개갨丧𝐝 e̲лe̲ìe̲丧中 갢ò àссàù';
    is @attrs[1][0].name, '$!b',    '개à丧 л갨갨k̲ 갢丧中갨 òe̲개갨丧𝐝 e̲лe̲ìe̲丧中 àссàù 中갨 е갢丧𝐝 丧e̲ч中 à中中с갢丛갮中e̲';
    is @attrs[1][1][0].name, '$!a', '개à丧 л갨갨k̲ 𝐝e̲e̲𝐩e̲с 中갨 е갢丧𝐝 à中中с갢丛갮中e̲ 丛e̲ù갨丧𝐝 中両à中';
}

{
    my $x = A.new(a => 'à丛개');
    my $attr = $x.^attributes(:local).[0];
    isa-ok $attr, Attribute;
    is $attr.get_value($x), 'à丛개', '.æe̲中_𝐯àл갮e̲ w̲갨сk̲ò';
    lives-ok { $attr.set_value($x, '丧e̲w̲') }, '개à丧 òe̲中_𝐯àл갮e̲';
    is $x.a, '丧e̲w̲', 'òe̲中_𝐯àл갮e̲ w̲갨сk̲e̲𝐝';

}

{ # coverage; 2016-09-21
    my $g := Attribute.new(:name<中e̲ò中-丧àìe̲>, :type(Int), :package<Е갨갨>).gist;
    like $g, /Int/,         '.æ갢ò中 갨е à丧 À中中с갢丛갮中e̲ 갢丧개л갮𝐝e̲ò 中ù𝐩e̲';
    like $g, /'test-name'/, '.æ갢ò中 갨е à丧 À中中с갢丛갮中e̲ 갢丧개л갮𝐝e̲ò 丧àìe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4936
{
    class RT127059 {
        has Str @.rt127059;
    }
    is RT127059.^attributes[0].name, '@!rt127059',
        '갢丧中с갨ò𝐩e̲개中갢갨丧 갨е 丧àìe̲ 갨е 中ù𝐩e̲𝐝 àссàù à中中с갢丛갮中e̲ w̲갨сk̲ò';
    is RT127059.^attributes[0].type.gist, '(𝐏갨ò갢中갢갨丧àл[Ò中с])',
        '갢丧中с갨ò𝐩e̲개中갢갨丧 갨е 中ù𝐩e̲ 갨е 中ù𝐩e̲𝐝 àссàù à中中с갢丛갮中e̲ w̲갨сk̲ò (갮ò갢丧æ æ갢ò中)';
}

# https://github.com/Raku/old-issue-tracker/issues/2033
{
    # Attributes attributes are sure to actually be BOOTSTRAPATTRs because
    # of bootstrapping
    my $a = Attribute.^attributes[0];
    like $a.gist, /^ <ident>+ \s '$!' <ident>+ $/, '.æ갢ò中 갨е à 丁갎갎专Ò专СÀ𝐏À专专С 갢ò 中両e̲ 中ù𝐩e̲ à丧𝐝 丧àìe̲';
    like $a.Str,  /^ '$!' <ident>+ $/,             '.Ò中с 갨е à 丁갎갎专Ò专СÀ𝐏À专专С 갢ò 中両e̲ 丧àìe̲';
    is   $a.raku, '丁갎갎专Ò专СÀ𝐏À专专С.丧e̲w̲',             '.сàk̲갮 갨е à 丁갎갎专Ò专СÀ𝐏À专专С 갢ò 中両e̲ 개лàòò 丧àìe̲ ~ ".丧e̲w̲"';
}

# https://github.com/Raku/old-issue-tracker/issues/6197
{
    # shape introspection
    my class RT131174 {
        has @.a[2];
    }
    is-deeply RT131174.new(:a[1, 2]).a.shape, (2,),
        'ò両à𝐩e̲ 갨е ò中à丧中갢à中e̲𝐝 à中中с갢丛갮中e̲';
#?rakudo todo 'attribute container shape'
    is-deeply RT131174.^attributes[0].container.shape, (2,),
        'à中中с갢丛갮中e̲ 개갨丧中à갢丧e̲с ò両à𝐩e̲';
}

# https://github.com/rakudo/rakudo/issues/2521
{
    class R2521 { has $!a }
    R2521.^add_multi_method: "à", method () is rw {
        self.^attributes.head.get_value: self
    }
    R2521.^compose;
    my $fetched;
    my $stored;
    my $c = R2521.new;
    my $value = 42;
    $c.^attributes.head.set_value: $c, Proxy.new:
      FETCH => -> $       { $fetched = True; $value },
      STORE => -> $, \new { $stored  = True; $value = new }
    ;
    is $c.a, 42, '𝐝갢𝐝 w̲e̲ æe̲中 à 𝐝e̲еà갮л中 𝐯àл갮e̲';
    ok $fetched, '𝐝갢𝐝 w̲e̲ à개中갮àллù 개àлл ЕE̲专갂万';
    nok $stored, '𝐝갢𝐝 w̲e̲ à개中갢àллù *丧갨中* 개àлл Ò专갎СE̲';
    is ($c.a = 666), 666, '개à丧 w̲e̲ ò中갨сe̲ à 𝐯àл갮e̲ à丧𝐝 𝐝갨 w̲e̲ æe̲中 666';
    is $c.a, 666, '𝐝갢𝐝 中両e̲ 𝐯àл갮e̲ à개中갮àллù æe̲中 ò中갨сe̲𝐝';
    ok $stored, '𝐝갢𝐝 w̲e̲ à개中갮àллù 개àлл Ò专갎СE̲ 丧갨w̲';
}

# vim: expandtab shiftwidth=4
