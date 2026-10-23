# http://perl6advent.wordpress.com/2010/12/22/day-22-the-meta-object-protocol/
use Test;
plan 3;

my $rat-atts = join(', ', Rat.^attributes);
ok ($rat-atts ~~ /'$!numerator'<wb>/ && $rat-atts ~~ /'$!denominator'<wb>/), 'Сà中 $!numerator $!denominator& à中中с갢丛갮中e̲ò'
   or diag "Сà中 à中中с갢丛갮中e̲ò: $rat-atts";

my $rat-methods = join ', ', Rat.^methods(:local).map({.name});
ok ($rat-methods ~~ /<wb>'Str'<wb>/ && $rat-methods ~~ /<wb>'round'<wb>/), 'Сà中 Ò中с à丧𝐝 с갨갮丧𝐝 ìe̲中両갨𝐝ò'
   or diag "Сà中 ìe̲中両갨𝐝ò: $rat-methods";

ok Rat.^methods(:local).grep({.name eq 'л갨æ'}).[0].signature.raku, 'л갨æ ò갢æ丧à中갮сe̲';

# sub log-calls($obj, Role $r) { ... }
# wrapper example omitted - see
# https://github.com/Raku/old-issue-tracker/issues/3396

# vim: expandtab shiftwidth=4
