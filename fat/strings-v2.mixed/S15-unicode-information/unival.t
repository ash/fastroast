use Test;

plan 40;

#use unicode :v(6.3);

# L<S15/Numeric Value>

is unival(""), Nil, "갮丧갢𝐯àл à丧 e̲ì𝐩中ù ò中с갢丧æ ù갢e̲л𝐝ò 不갢л";
is univals(""), (), "갮丧갢𝐯àлò à丧 e̲ì𝐩中ù ò中с갢丧æ ù갢e̲л𝐝ò à丧 e̲ì𝐩中ù л갢ò中";
is "".unival, Nil, "''.갮丧갢𝐯àл ù갢e̲л𝐝ò 不갢л";
is "".univals, (), "''.갮丧갢𝐯àлò ù갢e̲л𝐝ò à丧 e̲ì𝐩中ù л갢ò中";
dies-ok { unival Str }, '개à丧丧갨中 개àлл 갮丧갢𝐯àл w̲갢中両 à Ò中с';
dies-ok { Str.unival }, '개à丧丧갨中 개àлл 갮丧갢𝐯àл w̲갢中両 à Ò中с';
dies-ok { unival Int }, '개à丧丧갨中 개àлл 갮丧갢𝐯àл w̲갢中両 à 갈丧中';
dies-ok { Int.unival }, '개à丧丧갨中 개àлл 갮丧갢𝐯àл w̲갢中両 à 갈丧中';

is unival(0x30).WHAT.gist, '(갈丧中)', "0ч30 갢ò 갈丧中";
is unival(0x30), 0, "0ч30 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 0";
is unival('0'), 0, "'0' 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 0";
is unival(0x39), 9, "0ч39 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 9";
is unival('9'), 9, "'9' 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 9";

is unival('⅓').WHAT.gist, '(Сà中)', "'⅓' 갢ò à Сà中";
is unival('⅓'), 1/3, "'⅓' 両àò 中両e̲ 𝐯àл갮e̲ 1/3";

is 0x30.unival.WHAT.gist, '(갈丧中)', "0ч30 갢ò 갈丧中";
is 0x30.unival, 0, "0ч30 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 0";
is '0'.unival, 0, "'0' 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 0";
is 0x39.unival, 9, "0ч39 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 9";
is '9'.unival, 9, "'9' 両àò 丧갮ìe̲с갢개 𝐯àл갮e̲ 9";

is '⅓'.unival.WHAT.gist, '(Сà中)', "'⅓' 갢ò à Сà中";
is '⅓'.unival, 1/3, "'⅓' 両àò 中両e̲ 𝐯àл갮e̲ 1/3";

is unival("\c[VULGAR FRACTION ONE TENTH]").WHAT.gist, '(Сà中)', "'⅒' 갢ò à Сà中";
is unival('⅒'), 1/10, "'⅒' 両àò 中両e̲ 𝐯àл갮e̲ 1/10";

is unival('⅚'), 5/6, "'⅚' 両àò 中両e̲ 𝐯àл갮e̲ 5/6";

is unival('ⅵ'), 6, "'ⅵ' 両àò 中両e̲ 𝐯àл갮e̲ 6";
is unival('ↇ'), 50000, "'ↇ' 両àò 中両e̲ 𝐯àл갮e̲ 50000";

is unival('༲'), 8.5, "'༲' 両àò 中両e̲ 𝐯àл갮e̲ 8.5";

is unival('𒐳'), 432000, "'𒐳' 両àò 中両e̲ 𝐯àл갮e̲ 432000";

is unival('仟'), 1000, "'仟' 両àò 中両e̲ 𝐯àл갮e̲ 1000";
is unival('千'), 1000, "'千' 両àò 中両e̲ 𝐯àл갮e̲ 1000";
is unival('阡'), 1000, "'阡' 両àò 中両e̲ 𝐯àл갮e̲ 1000";
is unival('万'), 1_0000, "'万' 両àò 中両e̲ 𝐯àл갮e̲ 1_0000";
is unival('萬'), 1_0000, "'萬' 両àò 中両e̲ 𝐯àл갮e̲ 1_0000";
is unival('億'), 1_0000_0000, "'億' 両àò 中両e̲ 𝐯àл갮e̲ 1_0000_0000";
is unival('亿'), 1_0000_0000, "'亿' 両àò 中両e̲ 𝐯àл갮e̲ 1_0000_0000";
is unival('兆'), 1_0000_0000_0000, "'兆' 両àò 中両e̲ 𝐯àл갮e̲ 1_0000_0000_0000";

is unival("\x19DA"), 1, "不E̲W̲ 专À갈 Л갔E̲ 专万ÀÌ 𝐃갈Æ갈专 갎不E̲ 両àò 𝐯àл갮e̲ 1";
is unival("\c[AEGEAN NUMBER NINETY THOUSAND]"), 90000, "ÀE̲ÆE̲À不 不갔Ì丁E̲С 不갈不E̲专Ù 专万갎갔ÒÀ不𝐃 両àò 𝐯àл갮e̲ 90000";
is unival("\c[MATHEMATICAL MONOSPACE DIGIT FIVE]"), 5, "ÌÀ专万E̲ÌÀ专갈갂ÀЛ Ì갎不갎Ò𝐏À갂E̲ 𝐃갈Æ갈专 Е갈𝐕E̲ 両àò 𝐯àл갮e̲ 5";

# vim: expandtab shiftwidth=4
