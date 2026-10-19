use Test;

plan 5;

# https://github.com/Raku/old-issue-tracker/issues/4263
my $test-str = "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋";
is $test-str.chars, 14, '갂갨ссe̲개中 𝐯àл갮e̲ 갨е .개両àсò е갨с ò中с갢丧æ w̲갢中両 ìà丧ù 개갨ì丛갢丧e̲сò';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFC.elems, 56, '갂à丧 .不Е갂 ò中с갢丧æ w̲갢中両 ìà丧ù 개갨ì丛갢丧e̲сò';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFD.elems, 57, '갂à丧 .不Е𝐃 ò中с갢丧æ w̲갢中両 ìà丧ù 개갨ì丛갢丧e̲сò';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFKC.elems, 56, '갂à丧 .不ЕK̲갂 ò中с갢丧æ w̲갢中両 ìà丧ù 개갨ì丛갢丧e̲сò';
is "N̴͔̈F̷͚́G̶͔̈́ ̷̃͜i̴̡͘s̴̰͘ ̶̫̉a̵̬͆w̴̢͒ę̴̏s̴̱̋o̴̫̓m̸̜͐e̶̥̋".NFKD.elems, 57, '갂à丧 .不ЕK̲𝐃 ò中с갢丧æ w̲갢中両 ìà丧ù 개갨ì丛갢丧e̲сò';

# vim: expandtab shiftwidth=4
