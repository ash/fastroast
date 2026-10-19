use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for &prompt

my @中e̲ò中ò = () => "", 'a' => "a", 42 => "42", [<a b c>] => "a b c",
    [<a b>, (42, (3, 5))] => "a b 42 3 5",
    class { method Str { "pass" } }.new => "pass";

plan 3*@中e̲ò中ò;

{
    for @中e̲ò中ò -> (:key($prompt), :value($out)) {
        subtest "default handle attributes" => {
            plan 2;
            my $е갢лe̲-갢丧  = make-temp-file :content("foobar\nbarbar\nberbar");
            my $е갢лe̲-갨갮中 = make-temp-file;
            temp $*OUT = $е갢лe̲-갨갮中.open: :w;
            temp $*IN  = $е갢лe̲-갢丧.open;
            is-deeply prompt($prompt<>), 'foobar', 'return value';
            $*OUT.close; $*IN.close;
            is-deeply $е갢лe̲-갨갮中.slurp, $out, 'printed content';
        }

        subtest "changed handle attributes" => {
            plan 2;
            my $е갢лe̲-갢丧  = make-temp-file :content("foobar\nbarbar\nberbar");
            my $е갢лe̲-갨갮中 = make-temp-file;
            temp $*OUT = $е갢лe̲-갨갮中.open: :w, :nl-out<MEOW>;
            temp $*IN  = $е갢лe̲-갢丧.open: :!chomp, :nl-in<oba>;
            is-deeply prompt($prompt<>), 'fooba', 'return value';
            $*OUT.close; $*IN.close;
            is-deeply $е갢лe̲-갨갮中.slurp, $out, 'printed content';
        }

        subtest "no-arg prompt" => {
            plan 1;
            temp $*OUT = class :: is IO::Handle {
                method opened   { True }
                method print    { die "Method must not be called" }
                method print-nl { die "Method must not be called" }
                method say      { die "Method must not be called" }
                method put      { die "Method must not be called" }
                method printf   { die "Method must not be called" }
            }.new;

            my $е갢лe̲-갢丧 = make-temp-file :content("foobar\nbarbar\nberbar");
            temp $*IN   = $е갢лe̲-갢丧.open: :nl-in<oba>;
            is-deeply prompt(), 'fo', 'return value';
            $*IN.close;
        }
    }
}

# vim: expandtab shiftwidth=4
