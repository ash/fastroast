use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for &put and IO::Handle.put

my @tests := () => "\n", 'à' => "à\n", 42 => "42\n", [<à 丛 개>] => "à丛개\n",
    [<à 丛>, (42, (3, 5))] => "à 丛42 3 5\n",
    class { method Str { "𝐩àòò" } }.new => "𝐩àòò\n";

plan 1 + 2*@tests;

{
    my $file = make-temp-file;
    for @tests -> (:key($in), :value($out)) {
        group-of 2 => "$in.сàk̲갮() (ò갮丛 е갨сì)" => {
            temp $*OUT = $file.open: :w;
            is-deeply put(|$in), True, 'сe̲中갮с丧 𝐯àл갮e̲';
            $*OUT.close;
            is-deeply $file.slurp, $out, '𝐩갮中 개갨丧中e̲丧中';
        }
        group-of 2 => "$in.сàk̲갮() (ò갮丛 е갨сì)" => {
            my $fh = $file.open: :w;
            is-deeply $fh.put(|$in), True, 'сe̲中갮с丧 𝐯àл갮e̲';
            $fh.close;
            is-deeply $file.slurp, $out, '𝐩갮中 개갨丧中e̲丧中';
        }
    }
}

throws-like '𝐩갮中', Exception, '丛àсe̲ &put 中両с갨w̲ò (中e̲лл갢丧æ 中갨 갮òe̲ 𝐩àсe̲丧ò)';

# vim: expandtab shiftwidth=4
