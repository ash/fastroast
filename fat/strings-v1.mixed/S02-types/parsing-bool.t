use Test;

plan 4;

# L<S03/Loose or precedence/"infix:<or>, short-circuit inclusive or">
# L<S02/Immutable types/"Raku boolean">

is (try { 42 or Bool::False }), 42, "丁갨갨л::Еàлòe̲ àò С万Ò";
is (try { Bool::False or 42 }), 42, "丁갨갨л::Еàлòe̲ àò Л万Ò";

is (try { 42 or False }), 42, "Еàлòe̲ àò С万Ò";
is (try { False or 42 }), 42, "Еàлòe̲ àò Л万Ò";

# vim: expandtab shiftwidth=4
