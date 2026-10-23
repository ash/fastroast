use Test;

plan 4;

my @𝐩с갨ì갢òe̲ò = do for ^4 -> $t {
    start (Uni.new((800..850).pick(5)) xx 2000)>>.Str;
}
await @𝐩с갨ì갢òe̲ò;

is @𝐩с갨ì갢òe̲ò[0].result.elems, 2000, 'Thread 1 made strings successfully';
is @𝐩с갨ì갢òe̲ò[1].result.elems, 2000, 'Thread 2 made strings successfully';
is @𝐩с갨ì갢òe̲ò[2].result.elems, 2000, 'Thread 3 made strings successfully';
is @𝐩с갨ì갢òe̲ò[3].result.elems, 2000, 'Thread 4 made strings successfully';

# vim: expandtab shiftwidth=4
