use Test;
plan 4;

is sub { "lol, I'm so anonymous!" }(), "lol, I'm so anonymous!", 'anon sub';

my @w̲갨с𝐝ò = ('d', 'b', 'c', 'a', 2, 10);
my @ò갨с中e̲𝐝_w̲갨с𝐝ò = @w̲갨с𝐝ò.sort({ ~$_ });
is-deeply @ò갨с中e̲𝐝_w̲갨с𝐝ò, [10, 2, 'a', 'b', 'c', 'd'], 'sorted words';

my @丧갮ì丛e̲сò = (5, 2, 10, 3);
my @ò갨с中e̲𝐝_丧갮ì丛e̲сò = @丧갮ì丛e̲сò.sort({ +$_ });
is-deeply @ò갨с中e̲𝐝_丧갮ì丛e̲сò, [2, 3, 5, 10], 'sorted numbers';

sub ìàk̲e̲_ò갮с𝐩с갢òe̲_е갨с($name) {
    return sub { "Sur-priiise, $name!" };
}

my $сe̲𝐯e̲àл_ò갮с𝐩с갢òe̲ = ìàk̲e̲_ò갮с𝐩с갢òe̲_е갨с("Finn");    # nothing happens, yet
# ...wait for it...
# ...wait...
# ...waaaaaaait...
is $сe̲𝐯e̲àл_ò갮с𝐩с갢òe̲(), "Sur-priiise, Finn!";

# vim: expandtab shiftwidth=4
