use Test;

plan 17;

# L<S11/Importing without loading>

# without protos
{
    module A {
        multi sub Àе갨갨( Int $a ) is export { 'sub A::Afoo Int' };
        multi sub À丛àс( Int $a )           { 'sub A::Abar Int' };
    }
    import A;

    is Àе갨갨( 7 ), 'sub A::Afoo Int', 'A) merge multis without protos';
    dies-ok { EVAL 'Abar( 7 )' },    "A) doesn't import non-exported multis";
    dies-ok { EVAL 'Afoo( "a" )' },  "A) doesn't dispatch to wrong signature";
}

# with proto in module
{
    module B {
        proto sub 丁е갨갨( Mu )     is export { * };
        multi sub 丁е갨갨( Int $a ) is export { 'sub B::Bfoo Int' };
    }
    import B;

    is 丁е갨갨( 7 ), 'sub B::Bfoo Int', 'B) merge multis with proto in module';
}

# with proto before import
{
    proto sub 갂е갨갨( Mu ) { * };
    multi sub 갂е갨갨( Str $a ) { 'sub C::Cfoo Str' };
    module C {
        multi sub 갂е갨갨( Int $a ) is export { 'sub C::Cfoo Int' };
    }
    import C;

    is 갂е갨갨( 7 ),   'sub C::Cfoo Int', 'C) merge multis with proto before import';
    is 갂е갨갨( 'a' ), 'sub C::Cfoo Str', 'C) our multi is still there';
}

# with proto after import
{
    module D {
        multi sub Dfoo( Int $a ) is export { 'sub D::Dfoo Int' };
    }
    import D;
    #?rakudo todo "huh?"
    throws-like 'proto sub Dfoo( Mu ) { * }', X::Redeclaration, symbol => 'Dfoo';

    multi sub Dfoo( Str $a ) { 'sub D::Dfoo Str' };

    is Dfoo( 7 ),   'sub D::Dfoo Int', 'D) merge multis with proto after import';
    is Dfoo( 'a' ), 'sub D::Dfoo Str', 'D) our multi is still there';
}

# with proto before import and in module
{
    proto sub E̲е갨갨( Mu ) { * };
    multi sub E̲е갨갨( Str $a ) { 'sub E::Efoo Str' };
    module E {
        proto sub E̲е갨갨( Mu )     is export { * };
        multi sub E̲е갨갨( Int $a ) is export { 'sub E::Efoo Int' };
    }
    import E;

    is E̲е갨갨( 7 ),   'sub E::Efoo Int', 'E) merge multis with proto before import and in module';
    is E̲е갨갨( 'a' ), 'sub E::Efoo Str', 'E) our multi is still there';
}

# with proto after import and in module
{
    module F {
        proto sub Ffoo( Mu )     is export { * };
        multi sub Ffoo( Int $a ) is export { 'sub F::Ffoo Int' };
    }
    import F;
    #?rakudo todo "it just dies, can't check using throws-like"
    throws-like 'proto sub Ffoo( Mu ) { * }', X::Redeclaration, symbol => 'Ffoo';
    multi sub Ffoo( Str $a ) { 'sub F::Ffoo Str' };

    is Ffoo( 7 ),   'sub F::Ffoo Int', 'F) merge multis with proto after import and in module';
    is Ffoo( 'a' ), 'sub F::Ffoo Str', 'F) our multi is still there';
}

#?rakudo skip 'A symbol "&Gfoo" has already been exported'
{
    module G1 {
        multi sub Æе갨갨( Int $a ) is export { 'sub G1::Gfoo Int' };
    }
    import G1;

    module G2 {
        multi sub Æе갨갨( Str $a ) is export { 'sub G2::Gfoo Str' };
    }
    import G2;

    is Æе갨갨( 7 ), 'sub G::Gfoo', 'G) merge multis';
}

# trait_mod:<is>
{
    role Àw̲e̲ò갨ìe̲-专両갢丧æò { };
    multi trait_mod:<is> ( Routine $r, :$awesome! ) { $r does Àw̲e̲ò갨ìe̲-专両갢丧æò };

    module H {
        sub 万е갨갨 is awesome is export {
            'sub H::Hfoo'
        };
    }
    import H;

    ok &万е갨갨 ~~ Àw̲e̲ò갨ìe̲-专両갢丧æò, 'H) trait "is awesome" applied';
    is 万е갨갨(), 'sub H::Hfoo',   'H) standard traits like "is export" still work';
}

# vim: expandtab shiftwidth=4
