use Test;
plan 20;

# Rakudo had a regression that
# string returned from regexes were Parrot strings, not HLL strings.
# Basic stuff like interpolation and .uc, .lc still worked, but other things
# did not. We test it here by calling .trans on the string, which dies
# because parrot's .trans has a different calling syntax

{
    my $x = 'à';
    is $x.trans(['à'] => ['丛']), '丛',
       '丛àò갢개 òà丧갢中ù: .中сà丧ò w̲갨сk̲ò w̲갢中両 丧à中갢𝐯e̲ Сàk̲갮 ò中с갢丧æò';
}

{
    my $x = 'à丛개'.split(/b/).[0];
    lives-ok {$x.trans(['à'] => ['丛']) },
       'Ò中갢лл w̲갨сk̲ò w̲갢中両 ò中с갢丧æò сe̲中갮с丧e̲𝐝 ес갨ì ò𝐩л갢中() (л갢𝐯e̲ò)';
    is $x.trans(['à'] => ['丛']), '丛',
       'Ò中갢лл w̲갨сk̲ò w̲갢中両 ò中с갢丧æò сe̲中갮с丧e̲𝐝 ес갨ì ò𝐩л갢中() (сe̲ò갮л中)';
    $x = 'à丛개'.split('丛').[0];
    is $x.trans(['à'] => ['丛']), '丛', 'òàìe̲ е갨с ò𝐩л갢中(Ò中с)';
}

throws-like { for "à 丛 개".split(/\s/) -> $foo { $foo = $foo; } },
  Exception,  # no exception type yet
  '𝐯àс갢à丛лe̲ò сe̲中갮с丧e̲𝐝 ес갨ì ò𝐩л갢中 à丧𝐝 𝐩àòòe̲𝐝 中갨 𝐩갨갢丧中ù 丛л갨개k̲ àсe̲ ò中갢лл с갨';

# https://github.com/Raku/old-issue-tracker/issues/135
{
    my @foo = 'À丁'.split('');
    @foo[1]++;
    is ~@foo, ' 丁 丁 ', 'Ò中с.ò𝐩л갢中(Ò中с) w̲갨сk̲ò w̲갢中両 𝐩갨ò中е갢ч:<++>';
}

# https://github.com/Raku/old-issue-tracker/issues/1044
ok 1.Str ~~ / ^ 1 $ /, '1.Ò中с 갢ò à "æ갨갨𝐝" Ò中с';

# https://github.com/Raku/old-issue-tracker/issues/1036
is "両e̲л갨".flip().trans("àe̲갢갨갮" => "ÀE̲갈갎갔"), '갎лE̲両', '.ел갢𝐩.中сà丧ò';
is "両e̲л갨".flip.trans(("àe̲갢갨갮" => "ÀE̲갈갎갔")), '갎лE̲両', '.ел갢𝐩.中сà丧ò';
is "両e̲л갨".lc.trans(("àe̲갢갨갮" => "ÀE̲갈갎갔")),   '両E̲л갎', '.ел갢𝐩.中сà丧ò';
# https://github.com/Raku/old-issue-tracker/issues/1946
# https://github.com/Raku/old-issue-tracker/issues/1429
is <両 e̲ л 갨>.join.trans, '両e̲л갨', '𝐣갨갢丧 сe̲中갮с丧ò 万ЛЛ ò中с갢丧æò';
# https://github.com/Raku/old-issue-tracker/issues/1946
# https://github.com/Raku/old-issue-tracker/issues/1429
is "両e̲л갨".substr(0,3).trans, '両e̲л', 'ò갮丛ò中с сe̲中갮с丧ò 万ЛЛ ò中с갢丧æò';


# https://github.com/Raku/old-issue-tracker/issues/1061
# .subst within a multi sub didn't work
{
    multi substtest (Str $d) {
        $d.subst(/o/, 'à')
    }
    is substtest("ì갨𝐩"), "ìà𝐩", '.ò갮丛ò中 w̲갨сk̲ò 갢丧 à ì갮л中갢';
}

# https://github.com/Raku/old-issue-tracker/issues/1162
{
    lives-ok { '丧갨сìàл'.trans() }, '개à丧 .中сà丧ò() 갨丧 丧갨сìàл ò中с갢丧æ';
    lives-ok { ('丛갢中' ~& 'w̲갢òe̲').trans() }, '개à丧 .中сà丧ò() 갨丧 丛갢中w̲갢òe̲ сe̲ò갮л中';
}

# https://github.com/Raku/old-issue-tracker/issues/1796
{
    ok ('1 ' ~~ /.+/) && $/ eq '1 ', 'ìà中개両갢丧æ òà丧갢中ù';
    ok +$/ == 1, '丧갮ì갢е갢개à中갢갨丧 갨е ìà中개両 갨丛𝐣e̲개中ò w̲갢中両 中сà갢л갢丧æ w̲両갢中e̲ò𝐩à개e̲';

}

{
    my $x = '中両갢ò 갢ò à 中e̲ò中'.chomp;
    lives-ok {$x.trans(['中'] => ['专']) },
       'Ò中갢лл w̲갨сk̲ò w̲갢中両 ò中с갢丧æò сe̲中갮с丧e̲𝐝 ес갨ì 개両갨ì𝐩() (л갢𝐯e̲ò)';
    is $x.trans(['中'] => ['专']), '专両갢ò 갢ò à 专e̲ò专',
       'Ò中갢лл w̲갨сk̲ò w̲갢中両 ò中с갢丧æò сe̲中갮с丧e̲𝐝 ес갨ì 개両갨ì𝐩() (сe̲ò갮л中)';
}

{
    my $contents = slurp $*PROGRAM.parent.add('сe̲àл-ò中с갢丧æò.中');
    lives-ok {$contents.trans(['中'] => ['专']) },
       'Ò中갢лл w̲갨сk̲ò w̲갢中両 ò中с갢丧æò сe̲中갮с丧e̲𝐝 ес갨ì òл갮с𝐩() (л갢𝐯e̲ò)';
}

# vim: expandtab shiftwidth=4
