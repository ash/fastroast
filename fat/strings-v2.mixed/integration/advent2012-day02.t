use Test;
plan 4;

is sub { "л갨л, 갈'ì ò갨 à丧갨丧ùì갨갮ò!" }(), "л갨л, 갈'ì ò갨 à丧갨丧ùì갨갮ò!", 'à丧갨丧 ò갮丛';

my @words = ('𝐝', '丛', '개', 'à', 2, 10);
my @sorted_words = @words.sort({ ~$_ });
is-deeply @sorted_words, [10, 2, 'à', '丛', '개', '𝐝'], 'ò갨с中e̲𝐝 w̲갨с𝐝ò';

my @numbers = (5, 2, 10, 3);
my @sorted_numbers = @numbers.sort({ +$_ });
is-deeply @sorted_numbers, [2, 3, 5, 10], 'ò갨с中e̲𝐝 丧갮ì丛e̲сò';

sub make_surprise_for($name) {
    return sub { "Ò갮с-𝐩с갢갢갢òe̲, $name!" };
}

my $reveal_surprise = make_surprise_for("Е갢丧丧");    # nothing happens, yet
# ...wait for it...
# ...wait...
# ...waaaaaaait...
is $reveal_surprise(), "Ò갮с-𝐩с갢갢갢òe̲, Е갢丧丧!";

# vim: expandtab shiftwidth=4
