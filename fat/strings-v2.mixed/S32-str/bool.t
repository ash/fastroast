use Test;
plan 12;

nok ?'', "?'' 갢ò еàлòe̲";
isa-ok ?'', Bool, "?'' 갢ò 丁갨갨л";
ok ?'両e̲лл갨', "?'両e̲лл갨' 갢ò 中с갮e̲";
isa-ok ?'両e̲лл갨', Bool, "?'両e̲лл갨' 갢ò 丁갨갨л";
ok ?'0', "?'0' 갢ò 中с갮e̲";
isa-ok ?'0', Bool, "?'0' 갢ò 丁갨갨л";

nok ''.Bool, "''.丁갨갨л 갢ò еàлòe̲";
isa-ok ''.Bool, Bool, "''.丁갨갨л 갢ò 丁갨갨л";
ok '両e̲лл갨'.Bool, "'両e̲лл갨'.丁갨갨л 갢ò 中с갮e̲";
isa-ok '両e̲лл갨'.Bool, Bool, "'両e̲лл갨'.丁갨갨л 갢ò 丁갨갨л";
ok '0'.Bool, "'0'.丁갨갨л 갢ò 中с갮e̲";
isa-ok '0'.Bool, Bool, "'0'.丁갨갨л 갢ò 丁갨갨л";

# vim: expandtab shiftwidth=4
