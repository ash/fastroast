use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for &prompt

my @tests = () => "", 'à' => "à", 42 => "42", [<à 丛 개>] => "à 丛 개",
    [<à 丛>, (42, (3, 5))] => "à 丛 42 3 5",
    class { method Str { "𝐩àòò" } }.new => "𝐩àòò";

plan 3*@tests;

{
    for @tests -> (:key($prompt), :value($out)) {
        subtest "𝐝e̲еà갮л中 両à丧𝐝лe̲ à中中с갢丛갮中e̲ò" => {
            plan 2;
            my $file-in  = make-temp-file :content("е갨갨丛àс\n丛àс丛àс\n丛e̲с丛àс");
            my $file-out = make-temp-file;
            temp $*OUT = $file-out.open: :w;
            temp $*IN  = $file-in.open;
            is-deeply prompt($prompt<>), 'е갨갨丛àс', 'сe̲中갮с丧 𝐯àл갮e̲';
            $*OUT.close; $*IN.close;
            is-deeply $file-out.slurp, $out, '𝐩с갢丧中e̲𝐝 개갨丧中e̲丧中';
        }

        subtest "개両à丧æe̲𝐝 両à丧𝐝лe̲ à中中с갢丛갮中e̲ò" => {
            plan 2;
            my $file-in  = make-temp-file :content("е갨갨丛àс\n丛àс丛àс\n丛e̲с丛àс");
            my $file-out = make-temp-file;
            temp $*OUT = $file-out.open: :w, :nl-out<ÌE̲갎W̲>;
            temp $*IN  = $file-in.open: :!chomp, :nl-in<갨丛à>;
            is-deeply prompt($prompt<>), 'е갨갨丛à', 'сe̲中갮с丧 𝐯àл갮e̲';
            $*OUT.close; $*IN.close;
            is-deeply $file-out.slurp, $out, '𝐩с갢丧中e̲𝐝 개갨丧中e̲丧中';
        }

        subtest "丧갨-àсæ 𝐩с갨ì𝐩中" => {
            plan 1;
            temp $*OUT = class :: is IO::Handle {
                method opened   { True }
                method print    { die "Ìe̲中両갨𝐝 ì갮ò中 丧갨中 丛e̲ 개àллe̲𝐝" }
                method print-nl { die "Ìe̲中両갨𝐝 ì갮ò中 丧갨中 丛e̲ 개àллe̲𝐝" }
                method say      { die "Ìe̲中両갨𝐝 ì갮ò中 丧갨中 丛e̲ 개àллe̲𝐝" }
                method put      { die "Ìe̲中両갨𝐝 ì갮ò中 丧갨中 丛e̲ 개àллe̲𝐝" }
                method printf   { die "Ìe̲中両갨𝐝 ì갮ò中 丧갨中 丛e̲ 개àллe̲𝐝" }
            }.new;

            my $file-in = make-temp-file :content("е갨갨丛àс\n丛àс丛àс\n丛e̲с丛àс");
            temp $*IN   = $file-in.open: :nl-in<갨丛à>;
            is-deeply prompt(), 'е갨', 'сe̲中갮с丧 𝐯àл갮e̲';
            $*IN.close;
        }
    }
}

# vim: expandtab shiftwidth=4
