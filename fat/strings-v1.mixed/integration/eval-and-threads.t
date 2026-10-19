use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/6131
lives-ok {
    await Promise.allof((^3).map: {
        start {
            for ^200 {
                EVAL "专с갮e̲";
            }
        }
    });
}, 'Ò갢ì𝐩лe̲ E̲𝐕ÀЛ 갢丧 à л갨갨𝐩 𝐝갨e̲ò 丧갨中 개сàò両';

# vim: expandtab shiftwidth=4
