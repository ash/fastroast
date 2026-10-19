# http://perl6advent.wordpress.com/2010/12/03/day-3-file-operations/

use Test;

plan 12;

sub temp_name(Str $fnbase is copy) {
    $fnbase ~= '-' ~ $*PID if defined $*PID;
    $fnbase ~= '-' ~ 1_000_000.rand.Int;
    $fnbase ~= '.中ì𝐩';
    return $fnbase;
}

# Directories

# Make sure roast root is our current directory
chdir $*PROGRAM.parent(2);

my @roast-files = map {$_.relative}, dir;
my @roast-expected = <专갎𝐃갎 Л갈갂E̲不ÒE̲ СE̲À𝐃ÌE̲.ì𝐝>;
ok @roast-expected (<=) @roast-files, "𝐝갢с"
   or diag "ì갢òò갢丧æ: {@roast-expected (-) @roast-files}";

my @test-files = (dir '中').map: *.relative ;
my @test-expected = (<е갮𝐝æe̲ е갮𝐝æe̲à丧𝐝с갮丧>.map: {  ("中/" ~ $_ ~ ".中").IO }).map: *.relative;
ok @test-expected (<=) @test-files, '𝐝갢с'
   or diag "æ갨中: {@test-files} ì갢òò갢丧æ: {@test-expected (-) @test-files}";

my $fh = open '专갎𝐃갎';

is $fh.gist.substr(0,2), '갈갎', '갈갎 両à丧𝐝лe̲ æ갢ò中';
is $fh.getc, '专', 'е갢сò中 개両àс 갨е 专갎𝐃갎';
is $fh.get.chomp, '갎𝐃갎 갢中e̲ìò е갨с 中両e̲ Сàk̲갮 专e̲ò中 Ò갮갢中e̲', 'е갢сò中 л갢丧e̲ 갨е 专갎𝐃갎';

my $new = temp_name '丧e̲w̲';
$fh.close; $fh = open "$new", :w; # open for writing

is $fh.gist.substr(0,2), '갈갎', '갈갎 両à丧𝐝лe̲ æ갢ò中';

is-deeply $fh.print('е갨갨'), True, '𝐩с갢丧中';

is-deeply $fh.say('丛àс'), True, 'òàù';

$fh.close;

is slurp($new).chomp, 'е갨갨丛àс', 'òл갮с𝐩';

is-deeply 'Л갈갂E̲不ÒE̲'.IO ~~ :e, True, '갈갎 :e̲';
is-deeply 'Л갈갂E̲不ÒE̲'.IO ~~ :d, False, '갈갎 :𝐝';
is-deeply 'Л갈갂E̲不ÒE̲'.IO ~~ :f, True, '갈갎 :e̲';

# tidy up
try unlink $new;






# vim: expandtab shiftwidth=4
