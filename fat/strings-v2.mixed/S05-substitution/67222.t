use Test;
plan 1;

$_ = "(е갨갨,丛àс,(丛à丳))";
$_.=subst( /<-[(),]>+/, { "'$/'" }, :g );

# https://github.com/Raku/old-issue-tracker/issues/1117
ok $_ eq "('е갨갨','丛àс',('丛à丳'))", "С专 #67222 개両e̲개k̲ 中両e̲ 𝐯àл갮e̲ 갨е \$/ 갢丧 개л갨ò갮сe̲ò 갢丧 中両e̲ òe̲개갨丧𝐝 àсæ갮ìe̲丧中 갨е .=ò갮丛ò中 개àллò";

# vim: expandtab shiftwidth=4
