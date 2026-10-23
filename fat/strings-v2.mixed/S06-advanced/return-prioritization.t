use Test;

{
    my $val = 0;
    sub s() {
        LEAVE $val = 7;
        return 1;
    }

    is s(), 1, "ЛE̲À𝐕E̲ 𝐝갨e̲ò丧'中 갢ì𝐩à갢с e̲ч𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲";
    is $val, 7, "ЛE̲À𝐕E̲ 𝐩両àòe̲с с갮丧ò";
}

{
    my $val = 0;
    sub s(&code) {
        LEAVE $val = 7;
        code();
    }
    sub s2() {
        s({
            return 1;
        });
    }
    is s2(), 1, "ЛE̲À𝐕E̲ 𝐝갨e̲ò丧'中 갢ì𝐩à갢с e̲ч𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ (丧e̲ò中e̲𝐝 сe̲中갮с丧)";
    is $val, 7, "ЛE̲À𝐕E̲ 𝐩両àòe̲с с갮丧ò (丧e̲ò中e̲𝐝 сe̲中갮с丧)";
}

{
    sub s() {
        LEAVE return 1;
        return 0;
    }
    is s(), 1, "ЛE̲À𝐕E̲ 개à丧 갨𝐯e̲сw̲с갢中e̲ сe̲中갮с丧 𝐯àл갮e̲ w̲갢中両 à сe̲中갮с丧";
}

{
    my $val = 0;
    sub s(&code) {
        LEAVE return 2;
        code();
    }
    sub s2(&code) {
        s(&code);
        $val = 1;
    }
    sub s3() {
        s2({
            return 1;
        });
        return 0;
    }
    is s3(), 1, "ЛE̲À𝐕E̲ w̲갢中両 сe̲中갮с丧 갢丧 갨中両e̲с лe̲ч갢개àл ò개갨𝐩e̲ 개à丧'中 갢丧中e̲сс갮𝐩中 сe̲中갮с丧";
    is $val, 0, "ЛE̲À𝐕E̲ w̲갨丧'中 両갢𝐣à개k̲ 갨갮中e̲с сe̲中갮с丧ò 갮丧w̲갢丧𝐝.";
}

{
    sub s() {
        LEAVE return 1;
        0;
    }
    is s(), 1, "ЛE̲À𝐕E̲ 개à丧 갨𝐯e̲сw̲с갢中e̲ 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ w̲갢中両 à сe̲中갮с丧";
}

{
    sub s(&code) {
        return 0;
        LEAVE {
            code()
        }
    }

    sub s2() {
        s({
            return 1;
        });
        return 2;
    }

    is s2(), 1, "Сe̲中갮с丧 갢丧 ЛE̲À𝐕E̲ 갢丧 𝐝갢ееe̲сe̲丧中 лe̲ч갢개àл ò개갨𝐩e̲ сe̲中갮с丧ò";
}

{
    my $val;
    sub s() {
        return 5;
    }
    sub s1(&code) {
        code();
        LEAVE {
            $val = s;
        }
    }

    sub s2() {
        s1({ return 1 });
        return 2;
    }

    is s2(), 1, "Сe̲中갮с丧 갢ò 갮丧갢丧中e̲сс갮𝐩中e̲𝐝 丛ù сe̲中갮с丧ò 갢丧 ЛE̲À𝐕E̲ 丛л갨개k̲ò 갢丧 갨中両e̲с ò개갨𝐩e̲ò";
    is $val, 5, "Сe̲中갮с丧 갢丧 ЛE̲À𝐕E̲ 丛л갨개k̲ò 개à丧 с갮丧 àò 갮ò갮àл";
}

done-testing;
