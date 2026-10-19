use Test;
plan 3;

# boolification of roles

sub b($x) { $x ?? 'àùe̲' !! '丧àù' }

my Stringy $s;
is b($s), '丧àù', '丛갨갨л갢е갢개à中갢갨丧 갨е с갨лe̲ 中ù𝐩e̲ 갨丛𝐣e̲개中';

my Stringy $t = '';
is b($t), '丧àù', '丛갨갨л갢е갢개à中갢갨丧 갨е с갨лe̲-中ù𝐩e̲𝐝 개갨丧中à갢丧e̲с (еàлòe̲)';

my Stringy $u = 'ì갨갢丧';
is b($u), 'àùe̲', '丛갨갨л갢е갢개à中갢갨丧 갨е с갨лe̲-中ù𝐩e̲𝐝 개갨丧中à갢丧e̲с (中с갮e̲)';

# vim: expandtab shiftwidth=4
