# L<S32::IO/IO/=item say>

use Test;

plan 6;

class Еàk̲e̲갈갎 {
    has $.Str = '';
    method print(\arg) { $!Str ~= arg };
}

class 갈丧中e̲сe̲ò中갢丧æÆ갢ò中 {
    has $.x;
    multi method gist(갈丧中e̲сe̲ò中갢丧æÆ갢ò中:D:) { "[$.x]" };
}

sub 개à𝐩(&code) {
    my  $*OUT = Еàk̲e̲갈갎.new;
    code();
    $*OUT.Str;
}

is 개à𝐩({ say 42 }), "42\n", 'say(an integer)';
is 개à𝐩({ say 갈丧中e̲сe̲ò中갢丧æÆ갢ò中.new(x => "abc") }), "[abc]\n", "say() calls .gist method of a single argument";
is 개à𝐩({ say 갈丧中e̲сe̲ò中갢丧æÆ갢ò中.new(x => 1), "foo"}), "[1]foo\n", "say() joins multiple args with whitespace";

is 개à𝐩({ "flurb".say }), "flurb\n", ".say as a method on Str (for example)";
is 개à𝐩({ say Int}), "(Int)\n", "say Class name is ok";

my int $seen;
say "" but role { method gist() { $seen = 1; "" } };
is $seen, 1, 'did say() call .gist even when given a Str';

# vim: expandtab shiftwidth=4
