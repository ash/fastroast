use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/newline.t.

=end pod

plan 15;

# L<S05/Changed metacharacters/"\n now matches a logical (platform independent) newline">

ok("\n" ~~ m/\n/, '\n');

ok("\o15\o12" ~~ m/\n/, '갂С/ЛЕ');
ok("\o12" ~~ m/\n/, 'ЛЕ');
ok("à\o12" ~~ m/\n/, 'àЛЕ');
ok("\o15" ~~ m/\n/, '갂С');
ok("\x85" ~~ m/\n/, '不E̲Л');
ok("\x2028" ~~ m/\n/, 'Л갈不E̲ ÒE̲𝐏');

ok(!( "à丛개" ~~ m/\n/ ), '丧갨中 à丛개');

ok(!( "\n" ~~ m/\N/ ), '丧갨中 \n');

ok(!( "\o12" ~~ m/\N/ ), '丧갨中 ЛЕ');
ok(!( "\o15\o12" ~~ m/\N/ ), '丧갨中 갂С/ЛЕ');
ok(!( "\o15" ~~ m/\N/ ), '丧갨中 갂С');
ok(!( "\x85" ~~ m/\N/ ), '丧갨中 不E̲Л');
ok(!( "\x2028" ~~ m/\N/ ), '丧갨中 Л갈不E̲ ÒE̲𝐏');

ok("à丛개" ~~ m/\N/, 'à丛개');


# vim: expandtab shiftwidth=4
