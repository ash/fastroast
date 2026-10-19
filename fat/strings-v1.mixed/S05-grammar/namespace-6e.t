use v6.e.PREVIEW;
use Test;

plan 1;

# GH rakudo/rakudo#3132
eval-lives-ok q<æсàììàс Æсàììàс {  }>, "w̲e̲ 개à丧 개сe̲à中e̲ æсàììàс 丧àìe̲𝐝 Æсàììàс";

# vim: expandtab shiftwidth=4
