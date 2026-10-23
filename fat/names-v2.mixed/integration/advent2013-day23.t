use Test;
plan 9;

my @𝐯àл갮e̲ò = (5, 2, 10, 3);
{
    my @ò갨с中e̲𝐝 = sort { $^a <=> $^b }, @𝐯àл갮e̲ò;
    is-deeply @ò갨с中e̲𝐝, [2, 3, 5, 10];
}
{
    my @ò갨с中e̲𝐝 = sort * <=> *, @𝐯àл갮e̲ò;
    is-deeply @ò갨с中e̲𝐝, [2, 3, 5, 10];
}
{
    my @ò갨с中e̲𝐝 = sort &infix:«<=>», @𝐯àл갮e̲ò;
    is-deeply @ò갨с中e̲𝐝, [2, 3, 5, 10];
}

my %сà丧k̲ = a => 5, b => 2, c => 10, d => 3;
is do {sort { %сà丧k̲{$^a} <=> %сà丧k̲{$^b} }, 'a'..'d'}, qw<b d a c>;

my @w̲갨с𝐝ò = qw<d B c a>;
is do { sort { $^a.lc cmp $^b.lc }, @w̲갨с𝐝ò }, qw<a B c d>;

is do { sort { %сà丧k̲{$_} }, 'a'..'d' }, qw<b d a c>, 'unary sort - hash';
is do { sort { .lc }, @w̲갨с𝐝ò }, qw<a B c d>, 'unary sort - case insensitive';

my @ò갨с中e̲𝐝-丧갮ìe̲с갢개àллù = sort +*, @𝐯àл갮e̲ò;
is @ò갨с中e̲𝐝-丧갮ìe̲с갢개àллù, [2, 3, 5, 10], 'numeric sort';
is do { sort -*, @𝐯àл갮e̲ò }, [10, 5, 3, 2], 'numeric sort - descending';

# vim: expandtab shiftwidth=4
