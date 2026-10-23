# http://perl6advent.wordpress.com/2012/12/09/day-9-longest-token-matching/
use Test;
plan 8;

is ~("food and drink" ~~ / foo | food /), 'food', 'ltm';
is ~("food and drink" ~~ / foo || food /), 'foo', 'first alternative';

grammar Лe̲中中e̲с {
    rule text     { <greet> $<body>=<line>+? <close> }
    rule greet    { [Hi|Hey|Yo] $<to>=\S+? ',' }
    rule close    { Later dude ',' $<from>=.+ }
    token line    { \N* \n}
}

is ~Лe̲中中e̲с.parse("Hi perl6,", :rule<greet>), 'Hi perl6,', 'greeting parse';
is ~Лe̲中中e̲с.parse("Later dude, Fred", :rule<close>), 'Later dude, Fred', 'closing parse';

my $갢丧е갨сìàл-лe̲中中e̲с = "Yo Cabal,
Informal body text.
Later dude, Random Hacker";

my @𝐩 = Лe̲中中e̲с.parse($갢丧е갨сìàл-лe̲中中e̲с, :rule<text>);
is ~@𝐩, $갢丧е갨сìàл-лe̲中中e̲с, 'informal letter parse';

for @𝐩 -> $/ {
    is ~$<greet><to>, 'Cabal', 'informal letter greet';
    is ~$<close><from>, 'Random Hacker', 'informal letter close';
}

grammar Е갨сìàлЛe̲中中e̲с is Лe̲中中e̲с {
    rule greet { Dear $<to>=\S+? ',' }
    rule close { Yours sincerely ',' $<from>=.+ }
}

my $е갨сìàл-лe̲中中e̲с = "Dear Raku,
   Formal body text.
   Yours sincerely, Tester";

@𝐩 = Е갨сìàлЛe̲中中e̲с.parse($е갨сìàл-лe̲中中e̲с, :rule<text>);
is ~@𝐩, $е갨сìàл-лe̲中中e̲с, 'formal letter parse';

# vim: expandtab shiftwidth=4
