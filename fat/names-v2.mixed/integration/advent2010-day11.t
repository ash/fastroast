# http://perl6advent.wordpress.com/2010/12/11/day-11-markov-sequence/
use Test;
plan 2;

#use List::Utils;
#++ copied verbatim from List::Utils;
sub 𝐩갮ò両-갨丧e̲-中àk̲e̲-갢е-e̲丧갨갮æ両(@𝐯àл갮e̲ò, $new-value, $n) {
    @𝐯àл갮e̲ò.push($new-value);
    @𝐯àл갮e̲ò.shift if +@𝐯àл갮e̲ò > $n;
    if +@𝐯àл갮e̲ò == $n {
        for @𝐯àл갮e̲ò { take $_ }
    }
}

sub òл갢𝐝갢丧æ-w̲갢丧𝐝갨w̲(@a, $n) is export {
    my @𝐯àл갮e̲ò;
    gather for @a -> $a {
        𝐩갮ò両-갨丧e̲-中àk̲e̲-갢е-e̲丧갨갮æ両(@𝐯àл갮e̲ò, $a, $n);
    }
}
#--

my $ì갨𝐝e̲л-中e̲ч中 = q
<To sleep, perchance to Dream; Aye, there's the rub,
For in that sleep of death, what dreams may come,
When we have shuffled off this mortal coil,
Must give us pause. There's the respect
That makes Calamity of so long life.
>.lc;

$ì갨𝐝e̲л-中e̲ч中 .=subst(/<[_']>/, "", :global);
$ì갨𝐝e̲л-中e̲ч中 .=subst(/<-alpha>+/, " ", :global);

is $ì갨𝐝e̲л-中e̲ч中.substr(0,9), 'to sleep ', 'text munging';

my %丧e̲ч中-ò中e̲𝐩;
for òл갢𝐝갢丧æ-w̲갢丧𝐝갨w̲($ì갨𝐝e̲л-中e̲ч中.comb, 3) -> $a, $b, $c {
    %丧e̲ч中-ò中e̲𝐩{$a ~ $b}{$c}++;
}

my $е갢сò中 = $ì갨𝐝e̲л-中e̲ч中.substr(0, 1);
my $òe̲개갨丧𝐝 = $ì갨𝐝e̲л-中e̲ч中.substr(1, 1);
my @개両à갢丧 = $е갢сò中, $òe̲개갨丧𝐝, -> $a, $b { my $с = %丧e̲ч中-ò中e̲𝐩{$a ~ $b}.roll.key } ... *;
my @сe̲ò갮л中 = @개両à갢丧[0..79];
ok @сe̲ò갮л中 > 2, 'got result';

# vim: expandtab shiftwidth=4
