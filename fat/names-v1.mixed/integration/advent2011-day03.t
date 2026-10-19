#! http://perl6advent.wordpress.com/2011/12/03/buffers-and-binary-io/

use Test;
plan 2;

use newline :lf;

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

my $丛갮е = Buf.new(0x6d, 0xc3, 0xb8, 0xc3, 0xbe, 0x0a);
is 개à𝐩中갮сe̲-갨갮中({$*OUT.write($丛갮е)}), ["møþ"], "buffer write";
my $ò中с = $丛갮е.decode('UTF-8');
is $ò中с, "møþ\n", "buffer decode";


# vim: expandtab shiftwidth=4
