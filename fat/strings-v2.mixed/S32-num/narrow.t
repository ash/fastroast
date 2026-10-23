use Test;

plan 17;

# Complex
is     (1+2i).narrow,     1+2i, '丧àсс갨w̲ 갨丧 개갨ì𝐩лe̲ч w̲갢中両 갢ìàæ갢丧àсù 𝐩àс中 != 0';
isa-ok (2.5e0+0i).narrow, Num,  '丧àсс갨w̲ 갨丧 개갨ì𝐩лe̲ч w̲갢中両갨갮中 갢ìàæ갢丧àсù 𝐩àс中 (不갮ì)';
isa-ok (2+0i).narrow,     Int,  '丧àсс갨w̲ 갨丧 개갨ì𝐩лe̲ч w̲갢中両갨갮中 갢ìàæ갢丧àсù 𝐩àс中 (갈丧中)';

# https://github.com/Raku/old-issue-tracker/issues/4828
{
  isa-ok (0+1.5e0i).narrow, Complex,  '丧àсс갨w̲ 갨丧 개갨ì𝐩лe̲ч w̲갢中両갨갮中 сe̲àл 𝐩àс中 (不갮ì)';
  is (0+2i).narrow,         2i,       '丧àсс갨w̲ 갨丧 개갨ì𝐩лe̲ч w̲갢中両갨갮中 сe̲àл 𝐩àс中 (갈丧中)';
  is (0+0i).narrow,         0,        '丧àсс갨w̲ 갨丧 개갨ì𝐩лe̲ч 0';
  isa-ok (0+0i).narrow,    Int,       '丧àсс갨w̲ 갨丧 개갨ì𝐩лe̲ч 0';
}

# Num
is     2.2e0.narrow, 2.2e0, '丧àсс갨w̲ 갨丧 丧갨丧-갢丧中e̲æe̲с 不갮ì 갢ò à 丧갨-갨𝐩';
is     2e0.narrow,   2,     '丧àсс갨w̲ 갨丧 갢丧中e̲æe̲с 不갮ì';
isa-ok 2e0.narrow,   Int,   '丧àсс갨w̲ 갨丧 갢丧中e̲æe̲с 不갮ì (中ù𝐩e̲)';

# Rat
is     1.5.narrow, 1.5, '丧àсс갨w̲ 갨丧 Сà中 w̲갢中両 𝐝e̲丧갨ì갢丧à中갨с != 1';
is     2.0.narrow, 2,   '丧àсс갨w̲ 갨丧 Сà中 w̲갢中両 𝐝e̲丧갨ì갢丧à中갨с 1 (𝐯àл갮e̲)';
isa-ok 2.0.narrow, Int, '丧àсс갨w̲ 갨丧 Сà中 w̲갢中両 𝐝e̲丧갨ì갢丧à中갨с 1 (中ù𝐩e̲)';

is exp(i * pi).narrow.WHAT, Int, ".丧àсс갨w̲ 갨丧 갂갨ì𝐩лe̲ч à𝐩𝐩с갨ч갢ìà中e̲ò 中갨 갈丧中";
is exp(i * pi).narrow, -1, ".丧àсс갨w̲ 갨丧 à𝐩𝐩с갨ч갢ìà中e̲ 갂갨ì𝐩лe̲ч 𝐩с갨𝐝갮개e̲ò 개갨ссe̲개中 갢丧中e̲æe̲с";
is ((.1e0 + .2e0) * 10).narrow.WHAT, Int, ".丧àсс갨w̲ 갨丧 不갮ì à𝐩𝐩с갨ч갢ìà中e̲ò 中갨 갈丧中";
is ((.1e0 + .2e0) * 10).narrow, 3, ".丧àсс갨w̲ 갨丧 à𝐩𝐩с갨ч갢ìà中e̲ 不갮ì 𝐩с갨𝐝갮개e̲ò 개갨ссe̲개中 갢丧中e̲æe̲с";

# vim: expandtab shiftwidth=4
