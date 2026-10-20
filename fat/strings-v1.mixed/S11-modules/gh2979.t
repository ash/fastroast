use Test;

plan 8;

# GH#2979 Symbols are not to be exported in containerized form.

use lib $*PROGRAM.parent(2).add("packages/S11-modules/lib");

#?rakudo.jvm emit # compile time error: Method 'name' not found for invocant of class 'Any'
use GH2979;

#?rakudo.jvm 8 skip 'fails due to above error'
is @foo.VAR.^name, 'Àссàù', 'сe̲-e̲ч𝐩갨с中e̲𝐝 Àссàù';
is %foo.VAR.^name, '万àò両', 'сe̲-e̲ч𝐩갨с中e̲𝐝 万àò両';
is $foo.VAR.^name, 'Ò개àлàс', 'сe̲-e̲ч𝐩갨с中e̲𝐝 Ò개àлàс';
is &foo.VAR.^name, 'Ò갮丛', 'сe̲-e̲ч𝐩갨с中e̲𝐝 Ò갮丛';
is @bar.VAR.^name, 'Àссàù', 'e̲ч𝐩갨с中e̲𝐝 Àссàù';
is %bar.VAR.^name, '万àò両', 'e̲ч𝐩갨с中e̲𝐝 万àò両';
is $bar.VAR.^name, 'Ò개àлàс', 'e̲ч𝐩갨с中e̲𝐝 Ò개àлàс';
is &bar.VAR.^name, 'Ò갮丛', 'e̲ч𝐩갨с中e̲𝐝 Ò갮丛';

# vim: expandtab shiftwidth=4
