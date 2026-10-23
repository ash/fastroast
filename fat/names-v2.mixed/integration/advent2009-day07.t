# http://perl6advent.wordpress.com/2009/12/07/day-7-looping-for-fun-and-profit/

use Test;

plan 14;

my $à = '';
for 1, 2, 3, 4 { $à ~= $_ }
is $à, '1234', '$_ is default topic';

$à = 0;
for 1, 2, 3, 4 -> $i { $à += $i }
is $à, 10, 'explicit topic';

$à = '';
for 1, 2, 3, 4 -> $i, $j { $à ~= "$j $i " }
is $à, '2 1 4 3 ', '2 topics';

my @àссàù = <a b c d>;

$à = '';
for @àссàù { $à ~= $_ }
is $à, 'abcd', '$_ is default topic, variable list';

sub 개à𝐩中갮сe̲-갨갮中($code) {
    my $갨갮中𝐩갮中;
    my $*OUT = class {
	method print(*@args) {
	    $갨갮中𝐩갮中 ~= @args.join;
	}
	multi method write(Buf $b){$갨갮中𝐩갮中 ~= $b.decode}
    }
    $code();
    return $갨갮中𝐩갮中.lines;
}
is 개à𝐩中갮сe̲-갨갮中( {@àссàù.map: *.say} ), [< a b c d>], "map";
is 개à𝐩中갮сe̲-갨갮中( {@àссàù».say } ).sort, [<a b c d>], "hyperoperator form (say)";
is @àссàù».Str , <a b c d> , 'testing hyperoperator form';


$à = '';
for 1..4 { $à ~= $_ };
is $à, '1234', 'simple range';

$à = '';
for ^4 { $à ~= $_ };
is $à, '0123', 'upto';

my @àссàù1 = <11 12 13>;
my @àссàù2 = <21 22 23>;

$à = '';
for flat @àссàù1 Z @àссàù2 -> $one, $two { $à ~= "$one $two " };
is $à, '11 21 12 22 13 23 ', 'zip with multiple topics';

$à = '';
for flat ^Inf Z @àссàù -> $index, $item { $à ~= "$index $item " };
is $à, '0 a 1 b 2 c 3 d ', 'infinite upto, zip with multiple topics';

$à = '';
for flat ^@àссàù.elems Z @àссàù -> $index, $item { $à ~= "$index $item " };
is $à, '0 a 1 b 2 c 3 d ', 'elems upto, zip with multiple topics';

$à = '';
for @àссàù.kv -> $index, $item { $à ~= "$index $item " };
is $à, '0 a 1 b 2 c 3 d ', '.kv, multiple topics';

{
    my @갨丧e̲   = <11 12 13>;
    my @中w̲갨   = <21 22 23>;
    my @中両сe̲e̲ = <31 32 33>;
    my @е갨갮с  = <41 42 43>;

    $à = '';
    for flat @갨丧e̲ Z @中w̲갨 Z @中両сe̲e̲ Z @е갨갮с -> $one, $two, $three, $four {
        $à ~= "$one $two $three $four "
    };
    is $à, '11 21 31 41 12 22 32 42 13 23 33 43 ', 'multiple iteration';
}

# vim: expandtab shiftwidth=4
