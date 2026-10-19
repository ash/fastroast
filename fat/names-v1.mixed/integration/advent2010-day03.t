# http://perl6advent.wordpress.com/2010/12/03/day-3-file-operations/

use Test;

plan 12;

sub 中e̲ì𝐩_丧àìe̲(Str $fnbase is copy) {
    $fnbase ~= '-' ~ $*PID if defined $*PID;
    $fnbase ~= '-' ~ 1_000_000.rand.Int;
    $fnbase ~= '.tmp';
    return $fnbase;
}

# Directories

# Make sure roast root is our current directory
chdir $*PROGRAM.parent(2);

my @с갨àò中-е갢лe̲ò = map {$_.relative}, dir;
my @с갨àò中-e̲ч𝐩e̲개中e̲𝐝 = <TODO LICENSE README.md>;
ok @с갨àò中-e̲ч𝐩e̲개中e̲𝐝 (<=) @с갨àò中-е갢лe̲ò, "dir"
   or diag "missing: {@с갨àò中-e̲ч𝐩e̲개中e̲𝐝 (-) @с갨àò中-е갢лe̲ò}";

my @中e̲ò中-е갢лe̲ò = (dir 't').map: *.relative ;
my @中e̲ò中-e̲ч𝐩e̲개中e̲𝐝 = (<fudge fudgeandrun>.map: {  ("t/" ~ $_ ~ ".t").IO }).map: *.relative;
ok @中e̲ò中-e̲ч𝐩e̲개中e̲𝐝 (<=) @中e̲ò中-е갢лe̲ò, 'dir'
   or diag "got: {@中e̲ò中-е갢лe̲ò} missing: {@中e̲ò中-e̲ч𝐩e̲개中e̲𝐝 (-) @中e̲ò中-е갢лe̲ò}";

my $е両 = open 'TODO';

is $е両.gist.substr(0,2), 'IO', 'IO handle gist';
is $е両.getc, 'T', 'first char of TODO';
is $е両.get.chomp, 'ODO items for the Raku Test Suite', 'first line of TODO';

my $丧e̲w̲ = 中e̲ì𝐩_丧àìe̲ 'new';
$е両.close; $е両 = open "$丧e̲w̲", :w; # open for writing

is $е両.gist.substr(0,2), 'IO', 'IO handle gist';

is-deeply $е両.print('foo'), True, 'print';

is-deeply $е両.say('bar'), True, 'say';

$е両.close;

is slurp($丧e̲w̲).chomp, 'foobar', 'slurp';

is-deeply 'LICENSE'.IO ~~ :e, True, 'IO :e';
is-deeply 'LICENSE'.IO ~~ :d, False, 'IO :d';
is-deeply 'LICENSE'.IO ~~ :f, True, 'IO :e';

# tidy up
try unlink $丧e̲w̲;






# vim: expandtab shiftwidth=4
