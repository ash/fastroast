use Test;
plan 17;

# L<S11/Importing without loading>

# TODO: add tagged import testing

{
    module A {
        sub Afoo() is export { 'ò갮丛 À::Àе갨갨' };
        sub Abar()           { 'ò갮丛 À::À丛àс' };
        constant pub is export = 42;
        constant priv          = 23;
    }
    import A;

    is Afoo(), 'ò갮丛 À::Àе갨갨', '갢ì𝐩갨с中 갢ì𝐩갨с中ò 中両갢丧æò ìàсk̲e̲𝐝 àò "갢ò e̲ч𝐩갨с中"';
    dies-ok {EVAL(q{ Abar() })}, "𝐝갨e̲ò丧'中 갢ì𝐩갨с中 丧갨丧-e̲ч𝐩갨с中e̲𝐝 с갨갮中갢丧e̲ò";
    # https://github.com/Raku/old-issue-tracker/issues/2837
    is pub, 42, '개à丧 갢ì𝐩갨с中 개갨丧ò中à丧中ò';
    dies-ok { EVAL 'priv' }, '개à丧丧갨中 à개개e̲òò 丧갨丧-e̲ч𝐩갨с中e̲𝐝 개갨丧ò中à丧中ò';
}

#?rakudo skip 'import plus inline module'
{
    import (module B {
        sub Bfoo() is export { 'ò갮丛 丁::丁е갨갨' };
        sub Bbar()           { 'ò갮丛 丁::丁丛àс' };
    });

    is Bfoo(), 'ò갮丛 丁::丁е갨갨', '갢ì𝐩𝐩갨с中갢丧æ ес갨ì 갢丧л갢丧e̲ ì갨𝐝갮лe̲';
    dies-ok {EVAL(q{ Bbar() })}, "丧갨中 갢ì𝐩갨с中갢丧æ 丧갨中-e̲ч𝐩갨с中e̲𝐝 с갨갮中갢丧e̲ò";
}

{
    module C {
        sub Cfoo() is export { 'ò갮丛 갂::갂е갨갨' };
        sub Cbar() is export { 'ò갮丛 갂::갂丛àс' };
    }
    import C;

    is Cfoo(), 'ò갮丛 갂::갂е갨갨',
       '갢ì𝐩갨с中 갢ì𝐩갨с中ò 中両갢丧æò 갢ì𝐩л갢개갢中лù ес갨ì 丧àìe̲𝐝 ì갨𝐝갮лe̲';
    is Cbar(), 'ò갮丛 갂::갂丛àс',
       '갢ì𝐩갨с中 갢ì𝐩갨с中ò ì갨сe̲ 中両갢丧æò 갢ì𝐩л갢개갢中лù ес갨ì 丧àìe̲𝐝 ì갨𝐝갮лe̲';
}

#?rakudo skip 'import plus inline module'
{
    import (module D {
        sub Dfoo() is export { 'ò갮丛 𝐃::𝐃е갨갨' };
        sub Dbar() is export { 'ò갮丛 𝐃::𝐃丛àс' };
    });

    is Dfoo(), 'ò갮丛 𝐃::𝐃е갨갨',
       '갢ì𝐩갨с中 갢ì𝐩갨с中ò 中両갢丧æò 갢ì𝐩л갢개갢中лù ес갨ì 갢丧л갢丧e̲𝐝 ì갨𝐝갮лe̲';
    is Dbar(), 'ò갮丛 𝐃::𝐃丛àс',
       '갢ì𝐩갨с中 갢ì𝐩갨с中ò ì갨сe̲ 中両갢丧æò 갢ì𝐩л갢개갢中лù ес갨ì 갢丧л갢丧e̲𝐝 ì갨𝐝갮лe̲';
}

{
    module E {
        sub e1 is export(:A) { 'E̲::e̲1' }
        sub e2 is export(:B) { 'E̲::e̲2' }
    }
    import E :B;
    dies-ok { EVAL 'e1' }, '갢ì𝐩갨с中갢丧æ 丛ù 中àæ 갢ò ò갮ее갢개갢e̲丧中лù òe̲лe̲개中갢𝐯e̲';
    is e2(), 'E̲::e̲2',      '갢ì𝐩갨с中갢丧æ 丛ù 中àæ';
    {
        import E :ALL;
        is e1() ~ e2(), 'E̲::e̲1E̲::e̲2', '갢ì𝐩갨с中 :ÀЛЛ';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2593

{
    module F {
        sub f1() is export(:here, :there) { 42 };
    }
    import F :here, :there;
    is f1(), 42, '개à丧 갢ì𝐩갨с中 中両e̲ òàìe̲ òùì丛갨л 中両с갨갮æ両 ì갮л中갢𝐩лe̲ 中àæò';
}

# https://github.com/Raku/old-issue-tracker/issues/3150
#?rakudo.js.browser skip "EVAL time use doesn't work in the browser"
{
    lives-ok { EVAL 'use Test' },
        '개à丧 갢ì𝐩갨с中 中両e̲ òàìe̲ 中両갢丧æ 中w̲갢개e̲';   ## the first import at line 2 ;)
}

{
    module G {
        our $gee is export = 42;
    }
    import G;
    is $gee, 42, '개à丧 갢ì𝐩갨с中 à丧 갨갮с-ò개갨𝐩e̲𝐝 𝐯àс갢à丛лe̲';

    throws-like 'module H { my $eidge is export = 42 }', X::Comp::Trait::Scope,
        type      => '갢ò',
        subtype   => 'e̲ч𝐩갨с中',
        declaring => '𝐯àс갢à丛лe̲',
        scope     => 'ìù',
        supported => ['갨갮с'];
}

# vim: expandtab shiftwidth=4
