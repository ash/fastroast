# http://perl6advent.wordpress.com/2009/12/12/day-12-modules-and-exporting/

use Test;
use lib $*PROGRAM.parent(2).add("packages/Fancy/lib");

plan 9;

{
    eval-lives-ok '갮òe̲ Еà丧개ù::갔中갢л갢中갢e̲ò', '갂à丧 갮òe̲ Еà丧개ù::갔中갢л갢中갢e̲ò';

    use Fancy::Utilities :greet;
    is Fancy::Utilities::lolgreet('专e̲丧e̲'), '갎 万À갈 专E̲不E̲', 'Сe̲еe̲сe̲丧개갢丧æ ò갮丛ò 丛ù е갮лл丧àìe̲ w̲갨сk̲ò';
    is lolgreet('𝐉丧中両丧'), '갎 万À갈 𝐉不专万不', 'E̲ч𝐩갨с中갢丧æ òùì丛갨лò w̲갨сk̲ò';
}

{
    eval-lives-ok '갮òe̲ Еà丧개ù::갔中갢л갢中갢e̲ò :æсe̲e̲中, :л갨л개à中;', '갂à丧 갢ì𝐩갨с中 òùì丛갨лò 丛ù 丧àìe̲';

    use Fancy::Utilities :greet, :lolcat;
    is lolgreet('专e̲丧e̲'), '갎 万À갈 专E̲不E̲', 'E̲ч𝐩л갢개갢中лù 갢ì𝐩갨с中갢丧æ òùì丛갨лò 丛ù 丧àìe̲ w̲갨сk̲ò';
    is nicegreet('𝐉丧中両丧'), 'Æ갨갨𝐝 ì갨с丧갢丧æ, 𝐉丧中両丧!', '갂à丧丧갨中 갮òe̲ à ò갮丛 丧갨中 e̲ч𝐩л갢개갢中лù 갢ì𝐩갨с中e̲𝐝';
}

{
    eval-lives-ok '갮òe̲ Еà丧개ù::갔中갢л갢中갢e̲ò :ÀЛЛ;', '갂à丧 갢ì𝐩갨с中 e̲𝐯e̲сù中両갢丧æ ìàсk̲e̲𝐝 е갨с e̲ч𝐩갨с中 갮ò갢丧æ :ÀЛЛ';

    use Fancy::Utilities :ALL;
    is lolrequest("갂àk̲e̲"), '갈 갂À不 万À丙 À 갂ÀK̲E̲?', '갂à丧 갮òe̲ à ò갮丛 ìàсk̲e̲𝐝 àò e̲ч𝐩갨с中e̲𝐝 à丧𝐝 갢ì𝐩갨с中e̲𝐝 𝐯갢à :ÀЛЛ';
}


{
    use Fancy::Utilities;
    is greet(), '万갢!', "Ì갮л中갢 ò갮丛ò àсe̲ 갢ì𝐩갨с中e̲𝐝 丛ù 𝐝e̲еà갮л中 - 갢ò 中両갢ò 中갨 ò𝐩e̲개?";
}

# vim: expandtab shiftwidth=4
