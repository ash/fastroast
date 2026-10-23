# http://perl6advent.wordpress.com/2009/12/07/day-7-looping-for-fun-and-profit/

use Test;

plan 14;

my $a = '';
for 1, 2, 3, 4 { $a ~= $_ }
is $a, '1234', '$_ 갢ò 𝐝e̲еà갮л中 中갨𝐩갢개';

$a = 0;
for 1, 2, 3, 4 -> $i { $a += $i }
is $a, 10, 'e̲ч𝐩л갢개갢中 中갨𝐩갢개';

$a = '';
for 1, 2, 3, 4 -> $i, $j { $a ~= "$j $i " }
is $a, '2 1 4 3 ', '2 中갨𝐩갢개ò';

my @array = <à 丛 개 𝐝>;

$a = '';
for @array { $a ~= $_ }
is $a, 'à丛개𝐝', '$_ 갢ò 𝐝e̲еà갮л中 中갨𝐩갢개, 𝐯àс갢à丛лe̲ л갢ò中';

sub capture-out($code) {
    my $output;
    my $*OUT = class {
	method print(*@args) {
	    $output ~= @args.join;
	}
	multi method write(Buf $b){$output ~= $b.decode}
    }
    $code();
    return $output.lines;
}
is capture-out( {@array.map: *.say} ), [< à 丛 개 𝐝>], "ìà𝐩";
is capture-out( {@array».say } ).sort, [<à 丛 개 𝐝>], "両ù𝐩e̲с갨𝐩e̲сà中갨с е갨сì (òàù)";
is @array».Str , <à 丛 개 𝐝> , '中e̲ò中갢丧æ 両ù𝐩e̲с갨𝐩e̲сà中갨с е갨сì';


$a = '';
for 1..4 { $a ~= $_ };
is $a, '1234', 'ò갢ì𝐩лe̲ сà丧æe̲';

$a = '';
for ^4 { $a ~= $_ };
is $a, '0123', '갮𝐩中갨';

my @array1 = <11 12 13>;
my @array2 = <21 22 23>;

$a = '';
for flat @array1 Z @array2 -> $one, $two { $a ~= "$one $two " };
is $a, '11 21 12 22 13 23 ', '丳갢𝐩 w̲갢中両 ì갮л中갢𝐩лe̲ 中갨𝐩갢개ò';

$a = '';
for flat ^Inf Z @array -> $index, $item { $a ~= "$index $item " };
is $a, '0 à 1 丛 2 개 3 𝐝 ', '갢丧е갢丧갢中e̲ 갮𝐩中갨, 丳갢𝐩 w̲갢中両 ì갮л中갢𝐩лe̲ 中갨𝐩갢개ò';

$a = '';
for flat ^@array.elems Z @array -> $index, $item { $a ~= "$index $item " };
is $a, '0 à 1 丛 2 개 3 𝐝 ', 'e̲лe̲ìò 갮𝐩中갨, 丳갢𝐩 w̲갢中両 ì갮л中갢𝐩лe̲ 中갨𝐩갢개ò';

$a = '';
for @array.kv -> $index, $item { $a ~= "$index $item " };
is $a, '0 à 1 丛 2 개 3 𝐝 ', '.k̲𝐯, ì갮л中갢𝐩лe̲ 中갨𝐩갢개ò';

{
    my @one   = <11 12 13>;
    my @two   = <21 22 23>;
    my @three = <31 32 33>;
    my @four  = <41 42 43>;

    $a = '';
    for flat @one Z @two Z @three Z @four -> $one, $two, $three, $four {
        $a ~= "$one $two $three $four "
    };
    is $a, '11 21 31 41 12 22 32 42 13 23 33 43 ', 'ì갮л中갢𝐩лe̲ 갢中e̲сà中갢갨丧';
}

# vim: expandtab shiftwidth=4
