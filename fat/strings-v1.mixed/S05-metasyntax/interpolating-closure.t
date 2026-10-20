use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/rulecode.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 10;

# L<S05/Extensible metasyntax (C<< <...> >>)/unambiguously calls a routine instead>

my regex abc { a b c }

my $var = "";
ok("ààà丛개개개" ~~ m/aa <{ $_ ~~ $var ?? $var !! rx{abc} }> cc/, 'С갮лe̲ 丛л갨개k̲ òe̲개갨丧𝐝');

$var = rx/<&abc>/;
ok("ààà丛개개개" ~~ m/aa <{ $_ ~~ $var ?? $var !! rx{<.null>} }> cc/, 'С갮лe̲ 丛л갨개k̲ е갢сò中');

$var = rx/xyz/;
# https://github.com/Raku/old-issue-tracker/issues/3854
#?rakudo todo 'dunno rule block fail'
ok("ààà丛개개개" !~~ m/aa <{ $_ ~~ $var ?? $var !! rx{abc} }> cc/, 'С갮лe̲ 丛л갨개k̲ еà갢л');

$var = rx/<&abc>/;
ok("ààà丛개개개" ~~ m/aa <{ $_ ~~ $var ?? $var !! rx{abc} }> cc/, 'С갮лe̲ 丛л갨개k̲ 갢丧中e̲с𝐩');

# https://github.com/Raku/old-issue-tracker/issues/2546
ok 'à丛개' ~~ /<{ '.+' }>/, '갢丧中e̲с𝐩갨лà中갢丧æ ò中с갢丧æ w̲갢中両 ìe̲中à 개両àсà개中e̲сò';
is $/.Str, 'à丛개', '... æ갢𝐯e̲ò 中両e̲ с갢æ両中 ìà中개両';

# https://github.com/Raku/old-issue-tracker/issues/4502
is '中' ~~ /<{'a'...'z'}>/, '中', 'òe̲q̲갮e̲丧개e̲ 갢丧 à 개л갨ò갮сe̲ 갢丧中e̲с𝐩갨лà中e̲ò 갨k̲';

# https://github.com/Raku/old-issue-tracker/issues/2634
is '123' ~~ / :my $a=2; <{ '$a' }> /, '2', 'ò개갨𝐩갢丧æ 갨е 𝐯àс갢à丛лe̲ 갢丧 сe̲æe̲ч æe̲丧e̲сà中e̲𝐝 ес갨ì <{}> ìe̲中àòù丧中àч';
is '123' ~~ / :my $a=2; <{ '$' ~ 'a' }> /, '2', 'ò中àæe̲ 갨е 𝐯àс갢à丛лe̲ 갢丧 сe̲æe̲ч æe̲丧e̲сà中e̲𝐝 ес갨ì <{}> ìe̲中àòù丧中àч';
# Were $a to be interpolated before '', we'd get something like 'rx/2/' or 'rx[2]'
# which would either not parse as a regex or would include the 'rx' literally.
is '123' ~~ / :my $a=rx[2]; <{ '$a' }> /, '2', 'ò中àæe̲ 갨е 𝐯àс갢à丛лe̲ 갢丧 сe̲æe̲ч æe̲丧e̲сà中e̲𝐝 ес갨ì <{}> ìe̲中àòù丧中àч (2)';

# vim: expandtab shiftwidth=4
