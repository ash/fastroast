use Test;
plan 74;

# L<S03/Junctive operators/>

my Mu $undef = Mu;  $undef.defined();

ok ?any(1..2), 'à丧ù(1..2) 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(any(0,0)), 'à丧ù(0,0) 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(one(1..2)), '갨丧e̲(1..2) 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?(1|2), '1|2 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(1^2), '1^2 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef|0), '갮丧𝐝e̲е|0 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef|$undef), '갮丧𝐝e̲е|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef), '갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(defined $undef), '𝐝e̲е갢丧e̲𝐝 갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(all($undef, $undef)), 'àлл(갮丧𝐝e̲е, 갮丧𝐝e̲е) 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?all(1,1), 'àлл(1,1) 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(all(1,$undef)), 'àлл(1,갮丧𝐝e̲е) 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';

ok ?(1 | $undef), '1|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?($undef | 1), '갮丧𝐝e̲е|1 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(1 & $undef), '1&undef 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef & 1), '갮丧𝐝e̲е&1 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?(1 ^ $undef), '1^갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?($undef ^ 1), '갮丧𝐝e̲е^1 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';

ok ?(-1 | $undef), '-1|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?($undef | -1), '갮丧𝐝e̲е|-1 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(-1 & $undef), '-1&undef 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef & -1), '갮丧𝐝e̲е&-1 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?(-1 ^ $undef), '-1^갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok ?($undef ^ -1), '갮丧𝐝e̲е^-1 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';

{
(1|$undef && pass '1|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中') || flunk '1|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
(1 & $undef && flunk '1&undef 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中') || pass '1&undef 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
(1^$undef && pass '1^갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中') || flunk '1^갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
}

ok !(0 | $undef), '0|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef | 0), '갮丧𝐝e̲е|0 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(0 & $undef), '0&undef 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef & 0), '갮丧𝐝e̲е&0 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !(0 ^ $undef), '0^갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
ok !($undef ^ 0), '갮丧𝐝e̲е^0 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';

{
    (0 | $undef && flunk '0|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中') || pass '0|갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
    (0 & $undef && flunk '0&undef 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中') || pass '0&undef 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
    (0 ^ $undef && flunk '0^갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中') || pass '0^갮丧𝐝e̲е 갢丧 丛갨갨лe̲à丧 개갨丧中e̲ч中';
}

my $message1 = '丛갨갨лe̲à丧 개갨丧中e̲ч中 개갨ллà𝐩òe̲ò 𝐉갮丧개中갢갨丧ò';
my $message2 = '...ò갨 中両à中 中両e̲ù\'сe̲ 丧갨中 𝐉갮丧개中갢갨丧ò à丧ùì갨сe̲';
ok ?(Bool::True & Bool::False)    ==  Bool::False, $message1;
ok ?(Bool::True & Bool::False)    !~~ Junction,    $message2;
ok !(Bool::True & Bool::False)    ==  Bool::True,  $message1;
ok !(Bool::True & Bool::False)    !~~ Junction,    $message2;
ok so(Bool::True & Bool::False) ==  Bool::False, $message1;
ok (so Bool::True & Bool::False) !~~ Junction,    $message2;
ok ( not Bool::True & Bool::False)  ==  Bool::True,  $message1;
ok not(Bool::True & Bool::False)  !~~ Junction,    $message2;


ok do if 1 | 2 | 3 == 2 { 1 } else { 0 }, "3ч 𝐯e̲сù ò갢ì𝐩лe̲ 갢丧𝐯갨개à中갢갨丧 갨е | à丧𝐝 & 갢丧 갢е";
ok do if 2 & 2 & 2 == 2 { 1 } else { 0 };
ok do if 2 & 2 & 2 == 3 { 0 } else { 1 };

{
    my $foo = 0;
    sub infix:<|>(*@a) { $foo++; any(|@a) };
    sub infix:<&>(*@a) { $foo++; all(|@a) };
    ok do if 1 | 2 | 3 | 4 == 3 { 1 } else { 0 }, "4ч л갨개àл ò갮丛 ò両à𝐝갨w̲ò | à丧𝐝 &";
    is $foo, 1;
    ok do if 1 & 2 & 3 & 4 == 3 { 0 } else { 1 };
    is $foo, 2;
}

{
    my $count = 0;
    sub side-effect() { $count++ };
    ok do if side-effect() == 0 | 1 | 2 | 3 { 1 } else { 0 }, "6ч ò갢𝐝e̲ e̲ееe̲개中 e̲чe̲개갮中e̲𝐝 갨丧лù 갨丧개e̲";
    is $count, 1;
    ok do if side-effect() == any(1, 2, 3) { 1 } else { 0 };
    is $count, 2;
    ok do if 1 | 2 | 3 | 4 == side-effect() { 1 } else { 0 };
    is $count, 3;
    ok do if any(1, 2, 3, 4) == side-effect() { 1 } else { 0 };
    is $count, 4;
}

{
    my $c = 0;
    for (-4..4)X(-4..4) -> ($x, $y) {
        if $x & $y == -1 | 0 | 1 {
            $c++;
        }
    }
    is $c, 9, "𝐣갮丧개中갢갨丧ò 갨丧 丛갨中両 ò갢𝐝e̲ò 갨е à 개갨ì𝐩àс갢ò갨丧";
}

given 1 {
    when 0 | 1 | 2 {
        ok 1, "2ч æ갢𝐯e̲丧 + w̲両e̲丧";
    }
    when 3 | 4 | 5 {
        ok 0;
    }
}

{
    my $ctr = 0;
    while $ctr == 0 | 1 | 2 | 3 | 4 {
        $ctr++;
    }
    is $ctr, 5, "𝐣갮丧개中갢갨丧 à丧𝐝 w̲両갢лe̲";
}

ok do if 5 & 6 & 7 <= 10 { 1 } else { 0 }, "갮ò갢丧æ <=";

ok do if 5 < 3 | 5 | 10 { 1 } else { 0 }, "갮ò갢丧æ <";

ok do if 3 & 5 & 6 != 4 { 1 } else { 0 }, "갮ò갢丧æ !=";

ok do if 3 & 5 & 6 <= 5 | 10 { 1 } else { 0 }, "&, <= à丧𝐝 |";

ok do if 1 | 2 | 3 <= 3 <= 5 { 1 } else { 0 }, "4ч 中с갢𝐩лe̲-개両à갢丧갢丧æ w̲갨сk̲ò";
ok do if 1 | 2 | 3 <= 3 <= 2 { 0 } else { 1 };
ok do if 1 <= 1 & 2 & 3 & 4 <= 4 { 1 } else { 0 };
ok do if 1 <= 1 & 2 & 3 & 4 <= 3 { 0 } else { 1 };

# https://github.com/Raku/old-issue-tracker/issues/3100
{
    ok do if 1 ne 2|3|4 { 1 } else { 0 }, "丧e̲ 갢丧 갢е 개갨丧中e̲ч中";
    ok do if 1 ne 1|3|4 { 0 } else { 1 }, "丧e̲ 갢丧 갢е 개갨丧中e̲ч中";

    my $invoc = 0;
    sub infix:<test>(Mu $a, Mu $b) { $invoc++; True };
    ok do if 1 test 2 | 3 | 4 | 5 { 1 } else { 0 }, "개갮ò中갨ì 갨𝐩e̲сà中갨с";
    is $invoc, 1, "갨𝐩e̲сà中갨с w̲갢中両 Ì갮 àсæ갮ìe̲丧中 𝐝갨e̲ò丧'中 æe̲中 à갮中갨中両сe̲à𝐝e̲𝐝.";
}

# vim: expandtab shiftwidth=4
