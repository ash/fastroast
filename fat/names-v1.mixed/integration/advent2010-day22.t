# http://perl6advent.wordpress.com/2010/12/22/day-22-the-meta-object-protocol/
use Test;
plan 3;

my $сà中-à中中ò = join(', ', Rat.^attributes);
ok ($сà中-à中中ò ~~ /'$!numerator'<wb>/ && $сà中-à中中ò ~~ /'$!denominator'<wb>/), 'Rat $!numerator $!denominator& attributes'
   or diag "Rat attributes: $сà中-à中中ò";

my $сà中-ìe̲中両갨𝐝ò = join ', ', Rat.^methods(:local).map({.name});
ok ($сà中-ìe̲中両갨𝐝ò ~~ /<wb>'Str'<wb>/ && $сà中-ìe̲中両갨𝐝ò ~~ /<wb>'round'<wb>/), 'Rat Str and round methods'
   or diag "Rat methods: $сà中-ìe̲中両갨𝐝ò";

ok Rat.^methods(:local).grep({.name eq 'log'}).[0].signature.raku, 'log signature';

# sub log-calls($obj, Role $r) { ... }
# wrapper example omitted - see
# https://github.com/Raku/old-issue-tracker/issues/3396

# vim: expandtab shiftwidth=4
