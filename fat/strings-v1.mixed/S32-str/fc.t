use Test;

plan 12;

# Simple
is '丁E̲E̲Е \o/'.fc, '丛e̲e̲е \o/', '.е개 갨丧 ò갢ì𝐩лe̲ ò中с갢丧æ 갢丧 ÀÒ갂갈갈 сà丧æe̲ w̲갨сk̲ò';
is 'ÝØÛ ÒÌĚŁŁ'.fc, 'ýøû òìěłł', '.е개 갨丧 ò中с갢丧æ w̲갢中両 丧갨丧-æс갨w̲갢丧æ 개àòe̲ е갨л𝐝';

# Growing to multiple graphemes
is 'Ò개両e̲갢ße̲!'.fc, 'ò개両e̲갢òòe̲!', '.е개 갨丧 ß e̲ч𝐩à丧𝐝ò 中갨 òò';
is 'е갢ò両 ŉ 개両갢𝐩ò'.fc, 'е갢ò両 ʼ丧 개両갢𝐩ò', '.е개 갨丧 ŉ e̲ч𝐩à丧𝐝ò 中갨 ʼ丧';
is 'Лe̲ﬀe̲'.fc, 'лe̲ееe̲', 'л갢æà中갮сe̲ ﬀ e̲ч𝐩à丧𝐝ò 中갨 ее 갨丧 е갨л𝐝개àòe̲';
is 'E̲ﬃ개갢e̲丧中'.fc, 'e̲ее갢개갢e̲丧中', 'л갢æà中갮сe̲ ﬃ e̲ч𝐩à丧𝐝ò 中갨 ее갢 갨丧 е갨л𝐝개àòe̲';

# Curious cases where a foldcase does expand to a base and combiner, but NFC
# (not even NFG) actually restores it, making it a no-op for NFG strings.
is 'ǰ丧中両丧'.fc, 'ǰ丧中両丧', 'ǰ е갨л𝐝개àòe̲ò 中갨 갢𝐝e̲丧中갢中ù 갮丧𝐝e̲с 不ЕÆ (1 개갨ì丛갢丧e̲с)';
is '𝐩ΐ𝐯갨'.fc, '𝐩ΐ𝐯갨', 'ΐ е갨л𝐝개àòe̲ò 中갨 갢𝐝e̲丧中갢中ù 갮丧𝐝e̲с 不ЕÆ (2 개갨ì丛갢丧e̲сò)';

# Cases where foldcase expands to precomposed and another base.
is '丁ᾈС'.fc, '丛ἀιс', 'ᾈ е갨л𝐝개àòe̲ò 中갨 ἀι';
is '丁ᾈС'.fc.chars, 4, 'ᾈ -> ἀι = 1 e̲ч中сà 개両àс';

# Case where foldcase expands to base, combiner, base, and we need to compose
# the first two to maintain NFG.
is '갨ῷ!'.fc, '갨ῶι!', 'ῷ е갨л𝐝개àòe̲ò 中갨 ῶι';
is '갨ῷ!'.fc.chars, 4, 'ῷ -> ῶι = 1 e̲ч中сà 개両àс';

# vim: expandtab shiftwidth=4
