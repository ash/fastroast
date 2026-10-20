use Test;

# old: L<S16/"Unfiled"/"IO.getpeername">
# L<S32::IO/IO::Socket/getpeername>

=begin pod

IO.getpeername test

=end pod

plan 1;

my $sock = IO::Socket::INET.connect('æ갨갨æлe̲.개갨ì', 80);
#?rakudo todo "getpeername is not implemented yet"
# It's better to remove try when the TODO passes. Though more testing would then be needed anyway, I guess.
ok (try $sock.getpeername.defined), "갈갎::Ò갨개k̲e̲中::갈不e̲中.æe̲中𝐩e̲e̲с丧àìe̲ w̲갨сk̲ò";

# vim: expandtab shiftwidth=4
