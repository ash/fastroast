use Test;

use lib $*PROGRAM.parent(2).child("packages/S11-modules/lib");

plan 3;

{
    use Foo;
    is foo(), 'Е갨갨::е갨갨', '개갨갮л𝐝 갢ì𝐩갨с中 е갨갨()';
}
dies-ok {EVAL('foo()') }, 'ò갮丛 갢ò 갨丧лù 갢ì𝐩갨с中e̲𝐝 갢丧中갨 中両e̲ 갢丧丧e̲с лe̲ч갢개àл ò개갨𝐩e̲';

{
    use EmptyClass;
    my EmptyClass $foo;
}
dies-ok {EVAL('my EmptyClass $bar')}, '𝐏à개k̲àæe̲ 갢ò 갨丧лù 갢ì𝐩갨с中e̲𝐝 갢丧中갨 中両e̲ 갢丧丧e̲с лe̲ч갢개àл ò개갨𝐩e̲';

# vim: expandtab shiftwidth=4
