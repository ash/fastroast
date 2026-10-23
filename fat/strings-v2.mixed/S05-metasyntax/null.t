use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/null.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 4;

# L<S05/Nothing is illegal/To match the zero-width string, use>

ok("" ~~ m/<?>/, 'Ò갢ì𝐩лe̲ 丧갮лл àò <?>');
ok("" ~~ m/''/, "Ò갢ì𝐩лe̲ 丧갮лл àò ''");
ok("à" ~~ m/<?>/, 'Ò갢ì𝐩лe̲ 丧갮лл À');

ok("à丛" ~~ m{a<?>b}, '갂갨ì𝐩갨갮丧𝐝 丧갮лл À丁');

# vim: expandtab shiftwidth=4
