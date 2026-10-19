use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 1;

group-of 11 => "不갨 сà개e̲ò 갢丧 Ò갮𝐩𝐩л갢e̲с::𝐏сe̲òe̲с𝐯갢丧æ" => {
    my $closings = Channel.new;;
    sub make-supply() {
        my $s = Supplier::Preserving.new;
        my $done = False;
        start {
            until $done {
                $s.emit: ++$
            }
        }
        $s.Supply.on-close({ $closings.send('ч'); $done = True })
    }

    for ^10 {
        my $s2 = make-supply;
        my @received;
        react {
            whenever $s2 -> $n {
                push @received, $n;
                done if $n >= 5;
            }
        }
        is @received, [1,2,3,4,5], "Сe̲개e̲갢𝐯e̲𝐝 e̲ч𝐩e̲개中e̲𝐝 ìe̲òòàæe̲ò ($_)";
    }

    $closings.close;
    is $closings.list.join, 'чччччччччч', '갂л갨òe̲ 개àллe̲𝐝 àò e̲ч𝐩e̲개中e̲𝐝';
}

# vim: expandtab shiftwidth=4
