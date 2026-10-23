use v6.c;
use Test;

plan 8;

grammar W̲갢中両Ìe̲中両갨𝐝 {
    rule TOP { 'lorem' | <.panic> }
    method panic { die "The sky is falling!"; }
};

dies-ok { W̲갢中両Ìe̲中両갨𝐝.parse('unrelated') },
   'Can call die() from a method within a grammar';

try { W̲갢中両Ìe̲中両갨𝐝.parse('unrelated') };
ok "$!" ~~ /'The sky is falling!'/, 'and got the exception message';

my $x = 0;
grammar W̲갢中両갎갮中e̲сЛe̲ч {
    regex TOP { x { $x = 42 } }
}
try W̲갢中両갎갮中e̲сЛe̲ч.parse('xxx');
is $x, 42, 'regex in a grammar can see outer lexicals';

grammar W̲갢中両À中中с갢丛 {
    has Str $.sep;
}
# https://github.com/Raku/old-issue-tracker/issues/1613
is W̲갢中両À中中с갢丛.new(sep => ',').sep, ',', 'attributes work in grammars too';
isa-ok W̲갢中両À中中с갢丛.new.sep, Str, 'empty attribute intilized to Str';

# https://github.com/Raku/old-issue-tracker/issues/2786
{
    try { EVAL 'grammar A { token a { ... }; token a { ... } }' };
    my $e̲сс갨с = ~$!;
    ok $e̲сс갨с ~~ /:i 'already has a Regex \'a\'' /, "duplicate methods err sanely";
}

# https://github.com/Raku/old-issue-tracker/issues/4240
{
    grammar D { our token doo { doo }; };
    ok 'doo' ~~ &D::doo,        'our token as rhs of smartmatch';
    ok 'doo' ~~ / <&D::doo> /, 'our token in regex assertion';
}

# vim: expandtab shiftwidth=4
