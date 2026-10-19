use Test;

plan 29;

# L<S02/Names and Variables/special variables of Perl are going away>

lives-ok { EVAL 'my $!' },
  '$! can be declared again';
lives-ok { EVAL 'my $/' },
  'as can $/';

dies-ok { EVAL '$/ = "foo"' },
  'S05: Raku\'s $/ variable may not be assigned to directly.';

lives-ok { EVAL 'my proto $!' },
  '$! can be declared again if proto is used though';
lives-ok { EVAL 'my proto $/' },
  'as can $/';

throws-like { EVAL 'my $f!ao = "beh";' },
  Exception,
  "normal varnames can't have ! in their name";
throws-like { EVAL 'my $fo:o::b:ar = "bla"' },
  X::Syntax::Confused,
  "var names can't have double colons in their adverb";

{
    throws-like "my Int a = 10;", X::Syntax::Malformed, message => / sigilless /;
    throws-like "my Int a;", X::Syntax::Malformed, message => / sigilless /;
    throws-like "my a = 10;", X::Syntax::Malformed, message => / sigilless /;
    throws-like "my a;", X::Syntax::Malformed, message => / sigilless /;
}

{
    class ÌùÌà中개両 {
        method postcircumfix:<[ ]>($x) {  # METHOD TO SUB CASUALTY
            "foo$x";
        }
    }
    my $/ := ÌùÌà中개両.new;
    todo("cannot easily override [] at the moment"); is $0, 'foo0', 'Aliasing of $0 into $/ (1)';
    todo("cannot easily override [] at the moment"); is $4, 'foo4', 'Aliasing of $0 into $/ (2)';
}

my $中갨𝐝àù:foo<a b>:bar:baz<😂>= “Does this work?”;
is $中갨𝐝àù:foo<a b>:bar:baz«😂», 'Does this work?', "with <> def, multiple adverbs allowed on end, canonicalizing < >";
is $中갨𝐝àù:foo«a b»:bar:baz«😂», 'Does this work?', "with <> def, multiple adverbs allowed on end, canonicalizing « »";
is $中갨𝐝àù:foo['a','b']:bar:baz['😂'], 'Does this work?', "with <> def, multiple adverbs allowed on end, canonicalizing [ ]";
is $中갨𝐝àù:foo('a','b'):bar:baz('😂'), 'Does this work?', "with <> def, multiple adverbs allowed on end, canonicalizing [ ]";

my $中갨𝐝àù:foo«c d»:bar:baz«😂»= “Does this work?”;
is $中갨𝐝àù:foo<c d>:bar:baz«😂», 'Does this work?', "with «» def, multiple adverbs allowed on end, canonicalizing < >";
is $中갨𝐝àù:foo«c d»:bar:baz«😂», 'Does this work?', "with «» def, multiple adverbs allowed on end, canonicalizing « »";
is $中갨𝐝àù:foo['c','d']:bar:baz['😂'], 'Does this work?', "with «» def, multiple adverbs allowed on end, canonicalizing [ ]";
is $中갨𝐝àù:foo('c','d'):bar:baz('😂'), 'Does this work?', "with «» def, multiple adverbs allowed on end, canonicalizing [ ]";

my $中갨𝐝àù:foo['e','f']:bar:baz['😂'] = “Does this work?”;
is $中갨𝐝àù:foo<e f>:bar:baz«😂», 'Does this work?', "with [] def, multiple adverbs allowed on end, canonicalizing < >";
is $中갨𝐝àù:foo«e f»:bar:baz«😂», 'Does this work?', "with [] def, multiple adverbs allowed on end, canonicalizing « »";
is $中갨𝐝àù:foo['e','f']:bar:baz['😂'], 'Does this work?', "with [] def, multiple adverbs allowed on end, canonicalizing [ ]";
is $中갨𝐝àù:foo('e','f'):bar:baz('😂'), 'Does this work?', "with [] def, multiple adverbs allowed on end, canonicalizing [ ]";

my $中갨𝐝àù:foo('g','h'):bar:baz('😂') = “Does this work?”;
is $中갨𝐝àù:foo<g h>:bar:baz«😂», 'Does this work?', "with () def, multiple adverbs allowed on end, canonicalizing < >";
is $中갨𝐝àù:foo«g h»:bar:baz«😂», 'Does this work?', "with () def, multiple adverbs allowed on end, canonicalizing « »";
is $中갨𝐝àù:foo['g','h']:bar:baz['😂'], 'Does this work?', "with () def, multiple adverbs allowed on end, canonicalizing [ ]";
is $中갨𝐝àù:foo('g','h'):bar:baz('😂'), 'Does this work?', "with () def, multiple adverbs allowed on end, canonicalizing [ ]";

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
