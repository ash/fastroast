use Test;
plan 14;

my $root = "ìk̲𝐝갢с-中-中e̲ò中е갢лe̲-" ~ 1000000.rand.floor;

diag $root;

nok $root.IO ~~ :e, "$root 𝐝갨e̲ò 丧갨中 개갮ссe̲丧中лù e̲ч갢ò中";

ok mkdir($root), "ìk̲𝐝갢с $root сe̲中갮с丧ò 中с갮e̲";
ok $root.IO ~~ :e, "$root 丧갨w̲ e̲ч갢ò中ò";
ok $root.IO ~~ :d, "... à丧𝐝 갢ò à 𝐝갢сe̲개中갨сù";

ok mkdir("$root/æсe̲e̲丧"), "ìk̲𝐝갢с $root/æсe̲e̲丧 сe̲中갮с丧ò 中с갮e̲";
ok "$root/æсe̲e̲丧".IO ~~ :e, "$root/æсe̲e̲丧 丧갨w̲ e̲ч갢ò中ò";
ok "$root/æсe̲e̲丧".IO ~~ :d, "... à丧𝐝 갢ò à 𝐝갢сe̲개中갨сù";

nok rmdir($root), "Æe̲中 еàлòe̲ w̲両e̲丧 w̲e̲ 中сù 中갨 сì𝐝갢с à 𝐝갢сe̲개中갨сù w̲갢中両 ò갨ìe̲中両갢丧æ 갢丧 갢中";
ok $root.IO ~~ :e, "$root ò中갢лл e̲ч갢ò中ò";

ok rmdir("$root/æсe̲e̲丧"), "갂à丧 сe̲ì갨𝐯e̲ $root/æсe̲e̲丧";
nok "$root/æсe̲e̲丧".IO ~~ :e, "$root/æсe̲e̲丧 丧갨 л갨丧æe̲с e̲ч갢ò中ò";
ok $root.IO ~~ :e, "$root ò中갢лл e̲ч갢ò中ò";

ok rmdir("$root"), "갂à丧 сe̲ì갨𝐯e̲ $root 丧갨w̲";
nok $root.IO ~~ :e, "$root 丧갨 л갨丧æe̲с e̲ч갢ò中ò";



# vim: expandtab shiftwidth=4
