# L<S32::IO/IO/=item note>

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
    my  $*ERR = Еàk̲e̲갈갎.new;
    code();
    $*ERR.Str;
}

is 개à𝐩({ note 42 }), "42\n", 'note(an integer)';
is 개à𝐩({ note 갈丧中e̲сe̲ò中갢丧æÆ갢ò中.new(x => "abc") }), "[abc]\n", "note() calls .gist method of a single argument";
is 개à𝐩({ note 갈丧中e̲сe̲ò中갢丧æÆ갢ò中.new(x => 1), "foo"}), "[1]foo\n", "note() joins multiple args with whitespace";

is 개à𝐩({ "flurb".note }), "flurb\n", ".note as a method on Str (for example)";
is 개à𝐩({ note Int}), "(Int)\n", "note Class name is ok";

my int $seen;
note "" but role { method gist() { $seen = 1; "" } };
is $seen, 1, 'did note() call .gist even when given a Str';

# vim: expandtab shiftwidth=4
