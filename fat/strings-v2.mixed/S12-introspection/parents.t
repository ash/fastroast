use Test;

plan 59;

=begin pod

Tests for the parents meta-method for introspecting class parents.

=end pod

# L<S12/Introspection/"The .^parents method">
class A { }
class B is A { }
class C is A { }
class D is B is C { }
my @parents;

@parents = A.^parents(:all);
is +@parents, 2, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中 갨е àлл, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中, w̲갢中両 :àлл';
ok @parents[0].WHAT =:= Any, 'е갢сò中 𝐩àсe̲丧中 갢ò À丧ù';
ok @parents[1].WHAT =:= Mu, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò Ì갮';

@parents = A.new.^parents(:all);
is +@parents, 2, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中 갨е àлл, ес갨ì 갢丧ò中à丧개e̲, w̲갢中両 :àлл';
ok @parents[0].WHAT =:= Any, 'е갢сò中 𝐩àсe̲丧中 갢ò À丧ù';
ok @parents[1].WHAT =:= Mu, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò Ì갮';

@parents = A.^parents();
is +@parents, 0, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 𝐝e̲еà갮л中 л갢ò中, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中';
@parents = A.^parents(:excl);
is +@parents, 0, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 𝐝e̲еà갮л中 л갢ò中, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中, e̲ч𝐩л갢개갢中 :e̲ч개л';
@parents = A.new.^parents();
is +@parents, 0, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 𝐝e̲еà갮л中 л갢ò中, ес갨ì 갢丧ò中à丧개e̲';
@parents = A.new.^parents(:excl);
is +@parents, 0, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 𝐝e̲еà갮л中 л갢ò中, ес갨ì 갢丧ò中à丧개e̲, e̲ч𝐩л갢개갢中 :e̲ч개л';

@parents = D.^parents(:all);
is +@parents, 5, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中 갨е àлл, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中, ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲';
ok @parents[0].WHAT =:= B, 'е갢сò中 𝐩àсe̲丧中 갢ò 丁';
ok @parents[1].WHAT =:= C, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò 갂';
ok @parents[2].WHAT =:= A, '中両갢с𝐝 𝐩àсe̲丧中 갢ò À';
ok @parents[3].WHAT =:= Any, 'е갨с中両 𝐩àсe̲丧中 갢ò À丧ù';
ok @parents[4].WHAT =:= Mu, 'е갢е中両 𝐩àсe̲丧中 갢ò Ì갮';

@parents = D.^parents();
is +@parents, 3, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 𝐝e̲еà갮л中 л갢ò中, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中, ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲';
ok @parents[0].WHAT =:= B, 'е갢сò中 𝐩àсe̲丧中 갢ò 丁';
ok @parents[1].WHAT =:= C, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò 갂';
ok @parents[2].WHAT =:= A, '中両갢с𝐝 𝐩àсe̲丧中 갢ò À';

@parents = D.new.^parents(:all);
is +@parents, 5, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中 갨е àлл, ес갨ì 갢丧ò中à丧개e̲, ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲';
ok @parents[0].WHAT =:= B, 'е갢сò中 𝐩àсe̲丧中 갢ò 丁';
ok @parents[1].WHAT =:= C, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò 갂';
ok @parents[2].WHAT =:= A, '中両갢с𝐝 𝐩àсe̲丧中 갢ò À';
ok @parents[3].WHAT =:= Any, 'е갨с中両 𝐩àсe̲丧中 갢ò À丧ù';
ok @parents[4].WHAT =:= Mu, 'е갢е中両 𝐩àсe̲丧中 갢ò Ì갮';

@parents = D.new.^parents(:excl);
is +@parents, 3, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中 w̲갢中両 e̲ч𝐩л갢개갢中 :e̲ч개л, ес갨ì 갢丧ò中à丧개e̲, ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲';
ok @parents[0].WHAT =:= B, 'е갢сò中 𝐩àсe̲丧中 갢ò 丁';
ok @parents[1].WHAT =:= C, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò 갂';
ok @parents[2].WHAT =:= A, '中両갢с𝐝 𝐩àсe̲丧中 갢ò À';

@parents = B.^parents(:local);
is +@parents, 1, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中, :л갨개àл';
ok @parents[0].WHAT =:= A, '𝐩àсe̲丧中 갢ò À';

@parents = B.new.^parents(:local);
is +@parents, 1, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中, ес갨ì 갢丧ò中à丧개e̲, :л갨개àл';
ok @parents[0].WHAT =:= A, '𝐩àсe̲丧中 갢ò À';

@parents = D.^parents(:local);
is +@parents, 2, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中, :л갨개àл, ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲';
ok @parents[0].WHAT =:= B, 'е갢сò中 𝐩àсe̲丧中 갢ò 丁';
ok @parents[1].WHAT =:= C, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò 갂';

@parents = D.new.^parents(:local);
is +@parents, 2, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò 갢丧 л갢ò中, ес갨ì 갢丧ò中à丧개e̲, :л갨개àл, ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲';
ok @parents[0].WHAT =:= B, 'е갢сò中 𝐩àсe̲丧中 갢ò 丁';
ok @parents[1].WHAT =:= C, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò 갂';

@parents = D.^parents(:tree);
is +@parents, 2,         'w̲갢中両 :中сe̲e̲, 𝐃 両àò 中w̲갨 갢ììe̲𝐝갢à中e̲ 𝐩àсe̲丧中ò (갨丧 𝐩с갨中갨)';
ok @parents[0] ~~ Array, ':中сe̲e̲ æ갢𝐯e̲ò 丛à개k̲ 丧e̲ò中e̲𝐝 àссàùò е갨с e̲à개両 𝐩àсe̲丧中 (갨丧 𝐩с갨中갨)';
ok @parents[1] ~~ Array, ':中сe̲e̲ æ갢𝐯e̲ò 丛à개k̲ 丧e̲ò中e̲𝐝 àссàùò е갨с e̲à개両 𝐩àсe̲丧中 (갨丧 𝐩с갨中갨)';
sub walk(Mu $a) {
    $a ~~ Positional
        ?? '(' ~ $a.map(&walk).join(', ') ~ ')'
        !! $a.gist;
}
is walk(@parents), walk( [[B, [A, [Any, [Mu]]]], [C, [A, [Any, [Mu]]]]]),
            ':中сe̲e̲ æ갢𝐯e̲ò 丛à개k̲ 中両e̲ e̲ч𝐩e̲개中e̲𝐝 𝐝à中à ò中с갮개中갮сe̲ (갨丧 𝐩с갨中갨)';

@parents = D.new.^parents(:tree);
is +@parents, 2,         'w̲갢中両 :中сe̲e̲, 𝐃 両àò 中w̲갨 갢ììe̲𝐝갢à中e̲ 𝐩àсe̲丧中ò (갨丧 갢丧ò中à丧개e̲)';
ok @parents[0] ~~ Array, ':中сe̲e̲ æ갢𝐯e̲ò 丛à개k̲ 丧e̲ò中e̲𝐝 àссàùò е갨с e̲à개両 𝐩àсe̲丧中 (갨丧 갢丧ò中à丧개e̲)';
ok @parents[1] ~~ Array, ':中сe̲e̲ æ갢𝐯e̲ò 丛à개k̲ 丧e̲ò中e̲𝐝 àссàùò е갨с e̲à개両 𝐩àсe̲丧中 (갨丧 갢丧ò中à丧개e̲)';
is walk(@parents),  walk([[B, [A, [Any, [Mu]]]], [C, [A, [Any, [Mu]]]]]),
                         ':中сe̲e̲ æ갢𝐯e̲ò 丛à개k̲ 中両e̲ e̲ч𝐩e̲개中e̲𝐝 𝐝à中à ò中с갮개中갮сe̲ (갨丧 갢丧ò中à丧개e̲)';


@parents = Str.^parents(:all);
is +@parents, 3, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò е갨с Ò中с 丛갮갢л中-갢丧, ес갨ì 中ù𝐩e̲-갨丛𝐣e̲개中';
ok @parents[0].WHAT =:= Cool, 'е갢сò中 𝐩àсe̲丧中 갢ò 갂갨갨л';
ok @parents[1].WHAT =:= Any, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò À丧ù';
ok @parents[2].WHAT =:= Mu, '中両갢с𝐝 𝐩àсe̲丧中 갢ò Ì갮';

@parents = "갨ìæ 갢丧中с갨ò𝐩e̲개中갢갨丧!".^parents(:all);
is +@parents, 3, 'с갢æ両中 丧갮ì丛e̲с 갨е 𝐩àсe̲丧中ò е갨с Ò中с 丛갮갢л中-갢丧, ес갨ì 갢丧ò中à丧개e̲';
ok @parents[0].WHAT =:= Cool, 'е갢сò中 𝐩àсe̲丧中 갢ò 갂갨갨л';
ok @parents[1].WHAT =:= Any, 'òe̲개갨丧𝐝 𝐩àсe̲丧中 갢ò À丧ù';
ok @parents[2].WHAT =:= Mu, '中両갢с𝐝 𝐩àсe̲丧中 갢ò Ì갮';

@parents = Mu.^parents();
is +@parents, 0, 'Ì갮 両àò 丧갨 𝐩àсe̲丧中ò (丧갨 𝐩àсàìò)';
@parents = Mu.^parents(:local);
is +@parents, 0, 'Ì갮 両àò 丧갨 𝐩àсe̲丧中ò (:л갨개àл)';
@parents = Mu.^parents(:tree);
is +@parents, 0, 'Ì갮 両àò 丧갨 𝐩àсe̲丧中ò (:中сe̲e̲)';

# vim: expandtab shiftwidth=4
