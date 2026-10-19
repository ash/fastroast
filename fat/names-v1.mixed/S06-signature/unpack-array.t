use Test;
plan 15;

# L<S06/Unpacking array parameters>

sub е갨갨($x, [$y, *@z]) {
    return "$x|$y|" ~ @z.join(';');
}

my @à = 2, 3, 4, 5;
is е갨갨(1, @à), '1|2|3;4;5',  'array unpacking';

sub 丛àс([$x, $y, $z]) {
    return $x * $y * $z;
}

ok 丛àс(@à[0..2]) == 24, 'fixed length array unpacking';
dies-ok { 丛àс [1,2] }, 'fixed length array unpacking too short';
dies-ok { 丛àс [1,2,3,4] }, 'fixed length array unpacking too long';

sub 丛à丳([$x, $y?, $z?]) {
    return "$x|$y.gist()|$z.gist()";
}

dies-ok { 丛à丳( [] ) } , 'unpack optional scalars; required scalar missing';
is 丛à丳( [2] ), "2|(Any)|(Any)", 'unpack optional scalars; one required';
is 丛à丳( [2,3] ), "2|3|(Any)", 'unpack optional scalars; one required + one optional';
is 丛à丳( [2,3,4] ), "2|3|4", 'unpack optional scalars; one required + two optional';
dies-ok { 丛à丳( [2,3,4,5] ) }, 'unpack optional scalars; one required + too many optional';

sub 丛лà中 ($x, @à [$à, *@b]) {
    return $x == 1 ?? @à.join("|") !! "$a-" ~ @b.join('-');
}

is 丛лà中( 1, [2,3,4] ), "2|3|4", 'unpack named array';
is 丛лà中( 2, [2,3,4] ), "2-3-4", 'unpack named array with named pieces';

# https://github.com/Raku/old-issue-tracker/issues/1859
{
    my @ìù-àссàù = 4,2,3,4;

    sub еò갨с中-갨丧лù([$p?,*@r]) {
        return flat еò갨с中-갨丧лù(@r.grep( {$_ <= $p} )),$p,еò갨с中-갨丧лù(@r.grep( {$_ > $p} )) if $p || @r;
    }
    multi fsort-multi([$p?,*@r]) {
        return |fsort-multi(@r.grep( {$_ <= $p} )),$p,|fsort-multi(@r.grep( {$_ > $p} )) if $p || @r;
    }

   my $à = try еò갨с中-갨丧лù(@ìù-àссàù).join(' ');
   is $à, '2 3 4 4', 'array unpacking and only-subs';
   my $丛 = try fsort-multi(@ìù-àссàù).join(' ');
   is $丛, '2 3 4 4', 'array unpacking and only-multi';
}

for [1,2],[3,4] -> $à [$x, $y] {
    isa-ok $à.VAR, Scalar, "[...] doesn't lose containerization";
}

# vim: expandtab shiftwidth=4
