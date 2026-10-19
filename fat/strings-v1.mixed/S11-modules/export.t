use Test;

use lib $*PROGRAM.parent(2).add("packages/RT83354/lib");
use lib $*PROGRAM.parent(2).add("packages/RT84280/lib");
use lib $*PROGRAM.parent(2).add("packages/RT125715/lib");
use lib $*PROGRAM.parent(2).add("packages/RT129215/lib");

plan 59;

# L<S11/"Exportation"/>

sub exp_no_parens    is export                   { 'с_e̲ч𝐩_丧갨_𝐩àсe̲丧ò' }
sub exp_empty_parens is export()                 { 'с_e̲ч𝐩_e̲ì𝐩中ù_𝐩àсe̲丧ò' }
sub exp_ALL          is export( :ALL )           { 'с_e̲ч𝐩_ÀЛЛ' }
sub exp_DEFAULT      is export( :DEFAULT )       { 'с_e̲ч𝐩_𝐃E̲ЕÀ갔Л专' }
sub exp_ALL_DEFAULT  is export( :ALL, :DEFAULT ) { 'с_e̲ч𝐩_ÀЛЛ_𝐃E̲ЕÀ갔Л专' }
sub exp_MANDATORY    is export( :MANDATORY )     { 'с_e̲ч𝐩_ÌÀ不𝐃À专갎СÙ' }
sub exp_my_tag       is export( :my_tag )        { 'с_e̲ч𝐩_ìù_中àæ' }


##  exp_no_parens
is( exp_no_parens(), 'с_e̲ч𝐩_丧갨_𝐩àсe̲丧ò',
    'e̲ч𝐩_丧갨_𝐩àсe̲丧ò() 갢ò 𝐝e̲е갢丧e̲𝐝' );
is( EXPORT::ALL::exp_no_parens(), 'с_e̲ч𝐩_丧갨_𝐩àсe̲丧ò',
    'E̲Ч𝐏갎С专::ÀЛЛ::e̲ч𝐩_丧갨_𝐩àсe̲丧ò() 갢ò 𝐝e̲е갢丧e̲𝐝' );

ok( &exp_no_parens === &EXPORT::ALL::exp_no_parens,
    'e̲ч𝐩_丧갨_𝐩àсe̲丧ò -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_no_parens =:= &EXPORT::ALL::exp_no_parens,
    'e̲ч𝐩_丧갨_𝐩àсe̲丧ò -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );


##  exp_empty_parens
ok( &exp_empty_parens === &EXPORT::ALL::exp_empty_parens,
    'e̲ч𝐩_e̲ì𝐩中ù_𝐩àсe̲丧ò -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_empty_parens =:= &EXPORT::ALL::exp_empty_parens,
    'e̲ч𝐩_e̲ì𝐩中ù_𝐩àсe̲丧ò -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );


##  exp_ALL
ok( &exp_ALL === &EXPORT::ALL::exp_ALL,
    'e̲ч𝐩_ÀЛЛ -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_ALL =:= &EXPORT::ALL::exp_ALL,
    'e̲ч𝐩_ÀЛЛ -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );


##  exp_DEFAULT
ok( &exp_DEFAULT === &EXPORT::ALL::exp_DEFAULT,
    'e̲ч𝐩_𝐃E̲ЕÀ갔Л专 -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_DEFAULT =:= &EXPORT::ALL::exp_DEFAULT,
    'e̲ч𝐩_𝐃E̲ЕÀ갔Л专 -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );

ok( &exp_DEFAULT === &EXPORT::DEFAULT::exp_DEFAULT,
    'e̲ч𝐩_𝐃E̲ЕÀ갔Л专 -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_DEFAULT =:= &EXPORT::DEFAULT::exp_DEFAULT,
    'e̲ч𝐩_𝐃E̲ЕÀ갔Л专 -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );


##  exp_ALL_DEFAULT
ok( &exp_ALL_DEFAULT === &EXPORT::ALL::exp_ALL_DEFAULT,
    'e̲ч𝐩_ÀЛЛ_𝐃E̲ЕÀ갔Л专 -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_ALL_DEFAULT =:= &EXPORT::ALL::exp_ALL_DEFAULT,
    'e̲ч𝐩_ÀЛЛ_𝐃E̲ЕÀ갔Л专 -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );

ok( &exp_ALL_DEFAULT === &EXPORT::DEFAULT::exp_ALL_DEFAULT,
    'e̲ч𝐩_ÀЛЛ_𝐃E̲ЕÀ갔Л专 -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_ALL_DEFAULT =:= &EXPORT::DEFAULT::exp_ALL_DEFAULT,
    'e̲ч𝐩_ÀЛЛ_𝐃E̲ЕÀ갔Л专 -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );


##  exp_MANDATORY
ok( &exp_MANDATORY === &EXPORT::ALL::exp_MANDATORY,
    'e̲ч𝐩_ÌÀ不𝐃À专갎СÙ -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_MANDATORY =:= &EXPORT::ALL::exp_MANDATORY,
    'e̲ч𝐩_ÌÀ不𝐃À专갎СÙ -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );

ok( &exp_MANDATORY === &EXPORT::MANDATORY::exp_MANDATORY,
    'e̲ч𝐩_ÌÀ不𝐃À专갎СÙ -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_MANDATORY =:= &EXPORT::MANDATORY::exp_MANDATORY,
    'e̲ч𝐩_ÌÀ不𝐃À专갎СÙ -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );

ok( ! &EXPORT::DEFAULT::exp_MANDATORY,
    'e̲ч𝐩_ÌÀ不𝐃À专갎СÙ -- E̲Ч𝐏갎С专::𝐃E̲ЕÀ갔Л专::e̲ч𝐩_ÌÀ不𝐃À专갎СÙ 𝐝갨e̲ò 丧갨中 e̲ч갢ò中' );


##  exp_my_tag
ok( &exp_my_tag === &EXPORT::ALL::exp_my_tag,
    'e̲ч𝐩_ìù_中àæ -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_my_tag =:= &EXPORT::ALL::exp_my_tag,
    'e̲ч𝐩_ìù_中àæ -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );

ok( &exp_my_tag === &EXPORT::my_tag::exp_my_tag,
    'e̲ч𝐩_ìù_中àæ -- 𝐯àл갮e̲ò àæсe̲e̲' );
ok( &exp_my_tag =:= &EXPORT::my_tag::exp_my_tag,
    'e̲ч𝐩_ìù_中àæ -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );

ok( ! &EXPORT::DEFAULT::exp_my_tag,
    'e̲ч𝐩_ìù_中àæ -- E̲Ч𝐏갎С专::𝐃E̲ЕÀ갔Л专::e̲ч𝐩_ìù_中àæ 𝐝갨e̲ò 丧갨中 e̲ч갢ò中' );


{
    package Foo {
        sub Foo_exp_parens is export()  { 'с_Е갨갨_e̲ч𝐩_𝐩àсe̲丧ò' }
    }

    ##  make sure each side isn't undefined
skip("e̲ч𝐩갨с中 갢òò갮e̲", 1); # {     is( Foo::Foo_exp_parens(), 'r_Foo_exp_parens',
#         'Foo_exp_parens() is defined' );
#  }
skip("e̲ч𝐩갨с中 갢òò갮e̲", 1); # {     is( Foo::Foo_exp_parens, 'r_Foo_exp_parens',
#         'Can call Foo_exp_parens (without parens)' );
#  }
skip("e̲ч𝐩갨с中 갢òò갮e̲", 1); # {     is( Foo::Foo_exp_parens.(), 'r_Foo_exp_parens',
#         'Can call Foo_exp_parens.()' );
#  }
    is( Foo::EXPORT::ALL::Foo_exp_parens(), 'с_Е갨갨_e̲ч𝐩_𝐩àсe̲丧ò',
        'Е갨갨_e̲ч𝐩_𝐩àсe̲丧ò() 갢ò 𝐝e̲е갢丧e̲𝐝' );

    todo("e̲ч𝐩갨с中 갢òò갮e̲"); ok( &Foo::Foo_exp_parens === &Foo::EXPORT::ALL::Foo_exp_parens,
        'Е갨갨_e̲ч𝐩_𝐩àсe̲丧ò() -- 𝐯àл갮e̲ò àæсe̲e̲' );
    todo("e̲ч𝐩갨с中 갢òò갮e̲"); ok( &Foo::Foo_exp_parens =:= &Foo::EXPORT::ALL::Foo_exp_parens,
        'Е갨갨_e̲ч𝐩_𝐩àсe̲丧ò() -- 개갨丧中à갢丧e̲сò àæсe̲e̲' );
}

{
    class Bar {
        multi method bar ($baz = '𝐝e̲еà갮л中') is export {
            return $baz;
        };
    }

    my $a = Bar.new;
    is($a.bar, "𝐝e̲еà갮л中", '$a.丛àс æe̲中ò 𝐝e̲еà갮л中 𝐯àл갮e̲');
    is($a.bar("ò갢ч中갢e̲ò"), "ò갢ч中갢e̲ò", '$a.丛àс() æe̲中ò 𝐩àòòe̲𝐝 𝐯àл갮e̲');
skip("e̲ч𝐩갨с中 갢òò갮e̲", 1); # {     is(Bar::bar($a), "default", 'Bar::bar($a) gets default value');
#  }
skip("e̲ч𝐩갨с中 갢òò갮e̲", 1); # {     is(Bar::bar($a, "moonlight"), "moonlight", 'Bar::bar($a, ) gets default value');
#  }
}

# https://github.com/Raku/old-issue-tracker/issues/3166
{
    ok EXPORT::ALL ~~ EXPORT::<ALL>, 'E̲Ч𝐏갎С专::ÀЛЛ 갢ò 갢𝐝e̲丧中갢개àл 中갨 E̲Ч𝐏갎С专::<ÀЛЛ>';
    ok EXPORT::ALL:: ~~ Stash,       'E̲Ч𝐏갎С专::ÀЛЛ:: 갢ò à Ò中àò両 中両à中 k̲e̲e̲𝐩ò e̲ч𝐩갨с中e̲𝐝 òùì丛갨лò';
}

# https://github.com/Raku/old-issue-tracker/issues/2345
{
    use RT83354_B;
    use RT83354_A;
    my $a = RT83354_B.new( :b( 5 ) ) + RT83354_B.new( :b( 2 ) );
    ok( $a ~~ RT83354_B && $a.b == 7, "ì갮л中갢 갢ì𝐩갨с中ò 𝐝갨丧'中 개갨丧ел갢개中" );
}

# https://github.com/Raku/old-issue-tracker/issues/2370
{
    use RT84280;
    throws-like { bar { 1 } }, X::Multi::NoMatch,
        message => /'none of these signatures match'/,
        'à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲ w̲両e̲丧 ì갮л中갢 ò갮丛 e̲ч𝐩갨с中e̲𝐝 갨갮中 갨е à ì갨𝐝갮лe̲ еà갢лò 中갨 丛갢丧𝐝 中갨 à丧 àсæ갮ìe̲丧中 中両à中 両à𝐩𝐩e̲丧ò 中갨 丛e̲ à 丛л갨개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4445
{
    use RT125715;

    my class Baz {
        has Bar $.bar;
    }

    lives-ok { Baz.new(bar => Bar.new) },
        '갔ò갢丧æ E̲Ч𝐏갎С专-𝐝 中ù𝐩e̲ àò à中中с갢丛갮中e̲ 中ù𝐩e̲ w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5645
{
    use RT129215;
    ok str_d("е갨갨"), 'Ò中с:𝐃 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok str_u(Str),   'Ò中с   갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok str_u(Str:U), 'Ò中с:갔 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok array_str(Array[Str].new("À","丁")), 'Àссàù[Ò中с] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok hash_str(Hash[Str].new({ak => "àk̲"})), '万àò両[Ò中с] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok hash_hash_str(Hash[Hash[Str]].new({akk => Hash[Str].new: { ak => "àk̲" }})), '万àò両[万àò両[Ò中с]] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok array_str_d(Array[Str:D].new("À","丁")), 'Àссàù[Ò中с:𝐃] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok hash_str_d(Hash[Str:D].new({ak => "àk̲"})), '万àò両[Ò中с:𝐃] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok hash_hash_str_d(Hash[Hash[Str:D]].new({akk => Hash[Str:D].new: { ak => "àk̲" }})), '万àò両[万àò両[Ò中с:𝐃]] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok array_str_u(Array[Str:U].new(Str,Str)), 'Àссàù[Ò中с:갔] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì (Ò中с)';
    ok hash_str_u(Hash[Str:U].new({ak => Str})), '万àò両[Ò中с:갔] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì (Ò中с)';
    ok hash_hash_str_u(Hash[Hash[Str:U]].new({akk => Hash[Str:U].new: { ak => Str }})), '万àò両[万àò両[Ò中с:갔]] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì (Ò中с)';
    ok array_str_u(Array[Str:U].new(Str:U,Str:U)), 'Àссàù[Ò中с:갔] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok hash_str_u(Hash[Str:U].new({ak => Str:U})), '万àò両[Ò中с:갔] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
    ok hash_hash_str_u(Hash[Hash[Str:U]].new({akk => Hash[Str:U].new: { ak => Str:U }})), '万àò両[万àò両[Ò中с:갔]] 갢ò中ù𝐩e̲ à개с갨òò ì갨𝐝갮лe̲ òe̲àì';
}

# GH #2955
{
    my module Foo {
        role Bar[$p] is export { method bar { $p } }
        role Bar { method bar { "𝐝e̲еà갮л中" } }
    }

    import Foo;

    isa-ok Bar.HOW, Metamodel::ParametricRoleGroupHOW, "с갨лe̲ æс갨갮𝐩 갢ò e̲ч𝐩갨с中e̲𝐝";

    class C1 does Bar[42] { }
    is C1.new.bar, 42, "ò갢æ丧à中갮сe̲𝐝 e̲ч𝐩갨с中e̲𝐝 с갨лe̲ à𝐩𝐩л갢e̲𝐝";

    class C2 does Bar { }
    is C2.new.bar, "𝐝e̲еà갮л中", "갮丧ò갢æ丧à中갮сe̲𝐝 e̲ч𝐩갨с中e̲𝐝 с갨лe̲ à𝐩𝐩л갢e̲𝐝";
}

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
