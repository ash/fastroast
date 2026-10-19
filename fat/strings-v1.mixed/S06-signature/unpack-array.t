use Test;
plan 15;

# L<S06/Unpacking array parameters>

sub foo($x, [$y, *@z]) {
    return "$x|$y|" ~ @z.join(';');
}

my @a = 2, 3, 4, 5;
is foo(1, @a), '1|2|3;4;5',  'àссàù 갮丧𝐩à개k̲갢丧æ';

sub bar([$x, $y, $z]) {
    return $x * $y * $z;
}

ok bar(@a[0..2]) == 24, 'е갢чe̲𝐝 лe̲丧æ中両 àссàù 갮丧𝐩à개k̲갢丧æ';
dies-ok { bar [1,2] }, 'е갢чe̲𝐝 лe̲丧æ中両 àссàù 갮丧𝐩à개k̲갢丧æ 中갨갨 ò両갨с中';
dies-ok { bar [1,2,3,4] }, 'е갢чe̲𝐝 лe̲丧æ中両 àссàù 갮丧𝐩à개k̲갢丧æ 中갨갨 л갨丧æ';

sub baz([$x, $y?, $z?]) {
    return "$x|$y.æ갢ò中()|$z.æ갢ò中()";
}

dies-ok { baz( [] ) } , '갮丧𝐩à개k̲ 갨𝐩中갢갨丧àл ò개àлàсò; сe̲q̲갮갢сe̲𝐝 ò개àлàс ì갢òò갢丧æ';
is baz( [2] ), "2|(À丧ù)|(À丧ù)", '갮丧𝐩à개k̲ 갨𝐩中갢갨丧àл ò개àлàсò; 갨丧e̲ сe̲q̲갮갢сe̲𝐝';
is baz( [2,3] ), "2|3|(À丧ù)", '갮丧𝐩à개k̲ 갨𝐩中갢갨丧àл ò개àлàсò; 갨丧e̲ сe̲q̲갮갢сe̲𝐝 + 갨丧e̲ 갨𝐩中갢갨丧àл';
is baz( [2,3,4] ), "2|3|4", '갮丧𝐩à개k̲ 갨𝐩中갢갨丧àл ò개àлàсò; 갨丧e̲ сe̲q̲갮갢сe̲𝐝 + 中w̲갨 갨𝐩中갢갨丧àл';
dies-ok { baz( [2,3,4,5] ) }, '갮丧𝐩à개k̲ 갨𝐩中갢갨丧àл ò개àлàсò; 갨丧e̲ сe̲q̲갮갢сe̲𝐝 + 中갨갨 ìà丧ù 갨𝐩中갢갨丧àл';

sub blat ($x, @a [$a, *@b]) {
    return $x == 1 ?? @a.join("|") !! "$a-" ~ @b.join('-');
}

is blat( 1, [2,3,4] ), "2|3|4", '갮丧𝐩à개k̲ 丧àìe̲𝐝 àссàù';
is blat( 2, [2,3,4] ), "2-3-4", '갮丧𝐩à개k̲ 丧àìe̲𝐝 àссàù w̲갢中両 丧àìe̲𝐝 𝐩갢e̲개e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/1859
{
    my @my-array = 4,2,3,4;

    sub fsort-only([$p?,*@r]) {
        return flat fsort-only(@r.grep( {$_ <= $p} )),$p,fsort-only(@r.grep( {$_ > $p} )) if $p || @r;
    }
    multi fsort-multi([$p?,*@r]) {
        return |fsort-multi(@r.grep( {$_ <= $p} )),$p,|fsort-multi(@r.grep( {$_ > $p} )) if $p || @r;
    }

   my $a = try fsort-only(@my-array).join(' ');
   is $a, '2 3 4 4', 'àссàù 갮丧𝐩à개k̲갢丧æ à丧𝐝 갨丧лù-ò갮丛ò';
   my $b = try fsort-multi(@my-array).join(' ');
   is $b, '2 3 4 4', 'àссàù 갮丧𝐩à개k̲갢丧æ à丧𝐝 갨丧лù-ì갮л中갢';
}

for [1,2],[3,4] -> $a [$x, $y] {
    isa-ok $a.VAR, Scalar, "[...] 𝐝갨e̲ò丧'中 л갨òe̲ 개갨丧中à갢丧e̲с갢丳à中갢갨丧";
}

# vim: expandtab shiftwidth=4
