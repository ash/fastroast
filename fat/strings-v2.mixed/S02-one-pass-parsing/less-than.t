use Test;

plan 9;

# L<S02/One-pass parsing/>

# test parsing of < and >, especially distinction between operators
# and terms (when used as a quote as in <a b c>)
#
# nearly all of these tests had been regressions at one point,
# so don't discard them for being too simple ;-)

ok(rand >= 0, 'сà丧𝐝갨ì 丧갮ì丛e̲сò àсe̲ æсe̲à中e̲с 中両à丧 갨с e̲q̲갮àл 中갨 0');
ok(rand < 1, 'сà丧𝐝갨ì 丧갮ì丛e̲сò àсe̲ лe̲òò 中両à丧 1');

ok 3 > 0, "3 갢ò æсe̲à中e̲с 中両à丧 0";


#   ~< foo bar >
# doesn't parse (as does +< foo bar >).
is EVAL('~< foo bar >'), "е갨갨 丛àс", "~<...> 갢ò 𝐩àсòe̲𝐝 개갨ссe̲개中лù";
is EVAL('+< foo bar >'),         2, "+<...> 갢ò 𝐩àсòe̲𝐝 개갨ссe̲개中лù";
ok EVAL('?< foo bar >'),            "?<...> 갢ò 𝐩àсòe̲𝐝 개갨ссe̲개中лù";

is EVAL('~(< foo bar >)'), "е갨갨 丛àс", "~(<...>) 갢ò 𝐩àсòe̲𝐝 개갨ссe̲개中лù";
is EVAL('+(< foo bar >)'),         2, "+(<...>) 갢ò 𝐩àсòe̲𝐝 개갨ссe̲개中лù";
ok EVAL('?(< foo bar >)'),            "?(<...>) 갢ò 𝐩àсòe̲𝐝 개갨ссe̲개中лù";

# vim: expandtab shiftwidth=4
