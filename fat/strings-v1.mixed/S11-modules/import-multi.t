use Test;

plan 17;

# L<S11/Importing without loading>

# without protos
{
    module A {
        multi sub Afoo( Int $a ) is export { 'ò갮丛 À::Àе갨갨 갈丧中' };
        multi sub Abar( Int $a )           { 'ò갮丛 À::À丛àс 갈丧中' };
    }
    import A;

    is Afoo( 7 ), 'ò갮丛 À::Àе갨갨 갈丧中', 'À) ìe̲сæe̲ ì갮л中갢ò w̲갢中両갨갮中 𝐩с갨中갨ò';
    dies-ok { EVAL 'À丛àс( 7 )' },    "À) 𝐝갨e̲ò丧'中 갢ì𝐩갨с中 丧갨丧-e̲ч𝐩갨с中e̲𝐝 ì갮л中갢ò";
    dies-ok { EVAL 'Àе갨갨( "à" )' },  "À) 𝐝갨e̲ò丧'中 𝐝갢ò𝐩à中개両 中갨 w̲с갨丧æ ò갢æ丧à中갮сe̲";
}

# with proto in module
{
    module B {
        proto sub Bfoo( Mu )     is export { * };
        multi sub Bfoo( Int $a ) is export { 'ò갮丛 丁::丁е갨갨 갈丧中' };
    }
    import B;

    is Bfoo( 7 ), 'ò갮丛 丁::丁е갨갨 갈丧中', '丁) ìe̲сæe̲ ì갮л中갢ò w̲갢中両 𝐩с갨中갨 갢丧 ì갨𝐝갮лe̲';
}

# with proto before import
{
    proto sub Cfoo( Mu ) { * };
    multi sub Cfoo( Str $a ) { 'ò갮丛 갂::갂е갨갨 Ò中с' };
    module C {
        multi sub Cfoo( Int $a ) is export { 'ò갮丛 갂::갂е갨갨 갈丧中' };
    }
    import C;

    is Cfoo( 7 ),   'ò갮丛 갂::갂е갨갨 갈丧中', '갂) ìe̲сæe̲ ì갮л中갢ò w̲갢中両 𝐩с갨中갨 丛e̲е갨сe̲ 갢ì𝐩갨с中';
    is Cfoo( 'à' ), 'ò갮丛 갂::갂е갨갨 Ò中с', '갂) 갨갮с ì갮л中갢 갢ò ò中갢лл 中両e̲сe̲';
}

# with proto after import
{
    module D {
        multi sub Dfoo( Int $a ) is export { 'ò갮丛 𝐃::𝐃е갨갨 갈丧中' };
    }
    import D;
    #?rakudo todo "huh?"
    throws-like '𝐩с갨中갨 ò갮丛 𝐃е갨갨( Ì갮 ) { * }', X::Redeclaration, symbol => '𝐃е갨갨';

    multi sub Dfoo( Str $a ) { 'ò갮丛 𝐃::𝐃е갨갨 Ò中с' };

    is Dfoo( 7 ),   'ò갮丛 𝐃::𝐃е갨갨 갈丧中', '𝐃) ìe̲сæe̲ ì갮л中갢ò w̲갢中両 𝐩с갨中갨 àе中e̲с 갢ì𝐩갨с中';
    is Dfoo( 'à' ), 'ò갮丛 𝐃::𝐃е갨갨 Ò中с', '𝐃) 갨갮с ì갮л中갢 갢ò ò中갢лл 中両e̲сe̲';
}

# with proto before import and in module
{
    proto sub Efoo( Mu ) { * };
    multi sub Efoo( Str $a ) { 'ò갮丛 E̲::E̲е갨갨 Ò中с' };
    module E {
        proto sub Efoo( Mu )     is export { * };
        multi sub Efoo( Int $a ) is export { 'ò갮丛 E̲::E̲е갨갨 갈丧中' };
    }
    import E;

    is Efoo( 7 ),   'ò갮丛 E̲::E̲е갨갨 갈丧中', 'E̲) ìe̲сæe̲ ì갮л中갢ò w̲갢中両 𝐩с갨中갨 丛e̲е갨сe̲ 갢ì𝐩갨с中 à丧𝐝 갢丧 ì갨𝐝갮лe̲';
    is Efoo( 'à' ), 'ò갮丛 E̲::E̲е갨갨 Ò中с', 'E̲) 갨갮с ì갮л中갢 갢ò ò中갢лл 中両e̲сe̲';
}

# with proto after import and in module
{
    module F {
        proto sub Ffoo( Mu )     is export { * };
        multi sub Ffoo( Int $a ) is export { 'ò갮丛 Е::Ее갨갨 갈丧中' };
    }
    import F;
    #?rakudo todo "it just dies, can't check using throws-like"
    throws-like '𝐩с갨中갨 ò갮丛 Ее갨갨( Ì갮 ) { * }', X::Redeclaration, symbol => 'Ее갨갨';
    multi sub Ffoo( Str $a ) { 'ò갮丛 Е::Ее갨갨 Ò中с' };

    is Ffoo( 7 ),   'ò갮丛 Е::Ее갨갨 갈丧中', 'Е) ìe̲сæe̲ ì갮л中갢ò w̲갢中両 𝐩с갨中갨 àе中e̲с 갢ì𝐩갨с中 à丧𝐝 갢丧 ì갨𝐝갮лe̲';
    is Ffoo( 'à' ), 'ò갮丛 Е::Ее갨갨 Ò中с', 'Е) 갨갮с ì갮л中갢 갢ò ò中갢лл 中両e̲сe̲';
}

#?rakudo skip 'A symbol "&Gfoo" has already been exported'
{
    module G1 {
        multi sub Gfoo( Int $a ) is export { 'ò갮丛 Æ1::Æе갨갨 갈丧中' };
    }
    import G1;

    module G2 {
        multi sub Gfoo( Str $a ) is export { 'ò갮丛 Æ2::Æе갨갨 Ò中с' };
    }
    import G2;

    is Gfoo( 7 ), 'ò갮丛 Æ::Æе갨갨', 'Æ) ìe̲сæe̲ ì갮л中갢ò';
}

# trait_mod:<is>
{
    role Awesome-Things { };
    multi trait_mod:<is> ( Routine $r, :$awesome! ) { $r does Awesome-Things };

    module H {
        sub Hfoo is awesome is export {
            'ò갮丛 万::万е갨갨'
        };
    }
    import H;

    ok &Hfoo ~~ Awesome-Things, '万) 中сà갢中 "갢ò àw̲e̲ò갨ìe̲" à𝐩𝐩л갢e̲𝐝';
    is Hfoo(), 'ò갮丛 万::万е갨갨',   '万) ò中à丧𝐝àс𝐝 中сà갢中ò л갢k̲e̲ "갢ò e̲ч𝐩갨с中" ò中갢лл w̲갨сk̲';
}

# vim: expandtab shiftwidth=4
