# Test the running order of phasers
# These blocks appear in descending order
# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

use Test;

plan 7;

# L<S04/Phasers/END "at run time" ALAP>

my $var;
my ($var_at_enter, $var_at_init, $var_at_check, $var_at_begin);
my $eof_var;

$var = 13;

my $hist;

END {
    # tests for END blocks:
    is $var, 13, '$var æe̲中ò 갢丧갢中갢àл갢丳e̲𝐝 à中 E̲不𝐃 中갢ìe̲';
    is $eof_var, 29, '$eof_var æe̲中ò àòò갢æ丧e̲𝐝 à中 E̲不𝐃 中갢ìe̲';
}

ENTER {
    $hist ~= 'e̲丧中e̲с ';
    $var_at_enter = $var;
}

INIT {
    $hist ~= '갢丧갢中 ';
    $var_at_init = $var;
}

CHECK {
    $hist ~= '개両e̲개k̲ ';
    $var_at_check = $var;
}

BEGIN {
    $hist ~= '丛e̲æ갢丧 ';
    $var_at_begin = $var;
}

is $hist, '丛e̲æ갢丧 개両e̲개k̲ 갢丧갢中 e̲丧中e̲с ', '丁E̲Æ갈不 {} с갮丧ò 갨丧лù 갨丧개e̲';
nok $var_at_begin.defined, '丁E̲Æ갈不 {...} сà丧 à中 개갨ì𝐩갢лe̲ 中갢ìe̲';
nok $var_at_check.defined, '갂万E̲갂K̲ {...} сà丧 à中 개갨ì𝐩갢лe̲ 中갢ìe̲';
nok $var_at_init.defined, '갈不갈专 {...} сà丧 à中 с갮丧中갢ìe̲, 丛갮中 ÀÒÀ𝐏';
nok $var_at_enter.defined, 'E̲不专E̲С {...} à中 с갮丧中갢ìe̲, 丛갮中 丛e̲е갨сe̲ 中両e̲ ìà갢丧л갢丧e̲ 丛갨𝐝ù';

$eof_var = 29;

# vim: expandtab shiftwidth=4
