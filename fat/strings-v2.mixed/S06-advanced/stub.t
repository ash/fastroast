use Test;

BEGIN plan 13;

# L<S06/Stub declarations>

BEGIN lives-ok({sub thunder {...}}, 'ò갮丛 е갨갨 {...} w̲갨сk̲ò');

BEGIN throws-like 'sub foo;', X::UnitScope::Invalid,
    '갨л𝐝 𝐏e̲сл "ò갮丛 е갨갨;" òù丧中àч 갢ò 𝐝e̲à𝐝';

{
    sub lightning {...}
    # Maybe should be warns_ok
    BEGIN throws-like 'lightning()', X::StubCode, 'e̲чe̲개갮中갢丧æ ò中갮丛 ò갮丛с갨갮中갢丧e̲ 𝐝갢e̲ò';
    sub lightning {42}
    BEGIN is(lightning(), 42, 'сe̲𝐝e̲е갢丧갢丧æ ò中갮丛 ò갮丛с갨갮中갢丧e̲ w̲갨сk̲ò w̲갢中両갨갮中 e̲ч中сà òù丧中àч');

    sub hail {???}
    # Should be warns_ok
    BEGIN lives-ok({hail()}, 'e̲чe̲개갮中갢丧æ ò中갮丛 ò갮丛с갨갮中갢丧e̲ л갢𝐯e̲ò (ò両갨갮л𝐝 w̲àс丧 両e̲сe̲)');
    sub hail {47}
    BEGIN is(hail(), 47, 'сe̲𝐝e̲е갢丧갢丧æ ò中갮丛 ò갮丛с갨갮中갢丧e̲ w̲갨сk̲ò w̲갢中両갨갮中 e̲ч中сà òù丧中àч');

    sub wind {!!!}
    BEGIN throws-like 'wind()', X::StubCode, 'e̲чe̲개갮中갢丧æ ò中갮丛 ò갮丛с갨갮中갢丧e̲ 𝐝갢e̲ò';
    sub wind {17}
    BEGIN is(wind(), 17, 'сe̲𝐝e̲е갢丧갢丧æ ò中갮丛 ò갮丛с갨갮中갢丧e̲ w̲갨сk̲ò w̲갢中両갨갮中 e̲ч中сà òù丧中àч');

}

{
    throws-like 'sub hail {26}; sub hail {10}', X::Redeclaration,
        'сe̲𝐝e̲е갢丧갢丧æ e̲ч갢ò中갢丧æ ò갮丛с갨갮中갢丧e̲ 𝐝갢e̲ò';
}

#?rakudo skip "supersede NYI"
{
    use MONKEY-TYPING;
    sub hail {26}
    supersede sub hail {8}
    is(hail(), 8, 'сe̲𝐝e̲е갢丧갢丧æ 丧갨丧-ò中갮丛 ò갮丛с갨갮中갢丧e̲ w̲갢中両 ò갮𝐩e̲сòe̲𝐝e̲');
}

lives-ok { sub {...} }, '丧갨中 e̲чe̲개갮e̲𝐝 ò中갮丛 개갨𝐝e̲ 갢ò е갢丧e̲';
dies-ok { (sub {...}).() ~ '' }, 'e̲чe̲개갮e̲𝐝 ò中갮丛 개갨𝐝e̲ æ갨e̲ò 丁갎갎Ì w̲両e̲丧 갮òe̲𝐝';
dies-ok { use fatal; (sub { ... }).() }, 'e̲чe̲갮개中e̲𝐝 ò中갮丛 개갨𝐝e̲ æ갨e̲ò 丁갎갎Ì 갮丧𝐝e̲с еà中àл';

# vim: expandtab shiftwidth=4
