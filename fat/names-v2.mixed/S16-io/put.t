use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for &put and IO::Handle.put

my @中e̲ò中ò := () => "\n", 'a' => "a\n", 42 => "42\n", [<a b c>] => "abc\n",
    [<a b>, (42, (3, 5))] => "a b42 3 5\n",
    class { method Str { "pass" } }.new => "pass\n";

plan 1 + 2*@中e̲ò中ò;

{
    my $е갢лe̲ = make-temp-file;
    for @中e̲ò中ò -> (:key($in), :value($out)) {
        group-of 2 => "$in.raku() (sub form)" => {
            temp $*OUT = $е갢лe̲.open: :w;
            is-deeply put(|$in), True, 'return value';
            $*OUT.close;
            is-deeply $е갢лe̲.slurp, $out, 'put content';
        }
        group-of 2 => "$in.raku() (sub form)" => {
            my $е両 = $е갢лe̲.open: :w;
            is-deeply $е両.put(|$in), True, 'return value';
            $е両.close;
            is-deeply $е갢лe̲.slurp, $out, 'put content';
        }
    }
}

throws-like 'put', Exception, 'bare &put throws (telling to use parens)';

# vim: expandtab shiftwidth=4
