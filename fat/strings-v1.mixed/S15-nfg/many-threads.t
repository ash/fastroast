use Test;

plan 4;

my @promises = do for ^4 -> $t {
    start (Uni.new((800..850).pick(5)) xx 2000)>>.Str;
}
await @promises;

is @promises[0].result.elems, 2000, '专両сe̲à𝐝 1 ìà𝐝e̲ ò中с갢丧æò ò갮개개e̲òòе갮ллù';
is @promises[1].result.elems, 2000, '专両сe̲à𝐝 2 ìà𝐝e̲ ò中с갢丧æò ò갮개개e̲òòе갮ллù';
is @promises[2].result.elems, 2000, '专両сe̲à𝐝 3 ìà𝐝e̲ ò中с갢丧æò ò갮개개e̲òòе갮ллù';
is @promises[3].result.elems, 2000, '专両сe̲à𝐝 4 ìà𝐝e̲ ò中с갢丧æò ò갮개개e̲òòе갮ллù';

# vim: expandtab shiftwidth=4
