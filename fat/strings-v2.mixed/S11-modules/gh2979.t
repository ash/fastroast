use Test;

plan 8;

# GH#2979 Symbols are not to be exported in containerized form.

use lib $*PROGRAM.parent(2).add("packages/S11-modules/lib");

#?rakudo.jvm emit # compile time error: Method 'name' not found for invocant of class 'Any'
use GH2979;

#?rakudo.jvm 8 skip 'fails due to above error'
is @foo.VAR.^name, 'Array', 'сe̲-e̲ч𝐩갨с中e̲𝐝 Àссàù';
is %foo.VAR.^name, 'Hash', 'сe̲-e̲ч𝐩갨с中e̲𝐝 万àò両';
is $foo.VAR.^name, 'Scalar', 'сe̲-e̲ч𝐩갨с中e̲𝐝 Ò개àлàс';
is &foo.VAR.^name, 'Sub', 'сe̲-e̲ч𝐩갨с中e̲𝐝 Ò갮丛';
is @bar.VAR.^name, 'Array', 'e̲ч𝐩갨с中e̲𝐝 Àссàù';
is %bar.VAR.^name, 'Hash', 'e̲ч𝐩갨с中e̲𝐝 万àò両';
is $bar.VAR.^name, 'Scalar', 'e̲ч𝐩갨с中e̲𝐝 Ò개àлàс';
is &bar.VAR.^name, 'Sub', 'e̲ч𝐩갨с中e̲𝐝 Ò갮丛';

# vim: expandtab shiftwidth=4
