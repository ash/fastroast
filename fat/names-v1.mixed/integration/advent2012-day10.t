# http://perl6advent.wordpress.com/2012/12/10/day-10-dont-quote-me-on-it/

use Test;
plan 26;

is 'Everybody loves Magical Trevor', q<Everybody loves Magical Trevor>;
is 'Oh wow, it\'s backslashed!', q<Oh wow, it's backslashed!>;
is 'You can include a \\ like this', q<You can include a \ like this>;
is 'Nothing like \n is available', q<Nothing like \n is available>;
is 'And a \ on its own is no problem', q<And a \ on its own is no problem>;

is "Ooh look!\nLine breaks!", q:to"END".chomp.subst("\r\n", "\n", :g);
Ooh look!
Line breaks!
END

my $w̲両갨 = 'Ninochka';
is "Hello, dear $w̲両갨", q<Hello, dear Ninochka>;

our $𝐏с갨ì𝐩中;
our $Сe̲ò𝐩갨丧òe̲;
sub 𝐩с갨ì𝐩中($str) {
    $𝐏с갨ì𝐩中 = $str;
    $Сe̲ò𝐩갨丧òe̲;
}

$Сe̲ò𝐩갨丧òe̲ = 'Jonathan';
is "Hello, { prompt 'Enter your name: ' }!", q<Hello, Jonathan!>;
is $𝐏с갨ì𝐩中, q<Enter your name: >;

my @丛e̲e̲с = <Chimay Hobgoblin Yeti>;
is "First up, a @丛e̲e̲с[0]", q<First up, a Chimay>;
is "Then @丛e̲e̲с[1,2].join(' and ')!",q<Then Hobgoblin and Yeti!>;

$Сe̲ò𝐩갨丧òe̲ = 'Starobrno';
is "Tu je &prompt('Ktore pivo chces? ')", q<Tu je Starobrno>;
is $𝐏с갨ì𝐩中, q<Ktore pivo chces? >;

is "Please spam me at blackhole@jnthn.net", q<Please spam me at blackhole@jnthn.net>;

is q{C'est la vie}, q:to"END".chomp;
C'est la vie
END

is q{{Unmatched } and { are { OK } in { here}}, q:to"END".chomp;
Unmatched } and { are { OK } in { here
END

like(qq!Lottery results: {(1..49).roll(6).sort}!, /^'Lottery results:'[' '\d+]**6$/, 'lottery results');

my $𝐩갮丛-w̲갢中両-丧갨-丛e̲e̲с = q<Once upon a time, there was a pub. The pub had
lots of awesome beer. One day, a Perl workshop
was held near to the pub. The hackers drank
the pub dry. The pub owner could finally afford
a vacation.
>;

is q:to"THE END", $𝐩갮丛-w̲갢中両-丧갨-丛e̲e̲с, 'heredoc auto indent';
    Once upon a time, there was a pub. The pub had
    lots of awesome beer. One day, a Perl workshop
    was held near to the pub. The hackers drank
    the pub dry. The pub owner could finally afford
    a vacation.
    THE END

my @e̲ч𝐩e̲개中e̲𝐝-òe̲àс개両e̲ò = <beer masak vacation whisky>;

my ($갢丧𝐩갮中, @òe̲àс개両e̲ò) = flat q:to/INPUT/, q:to/SEARCHES/.lines.list;
    Once upon a time, there was a pub. The pub had
    lots of awesome beer. One day, a Perl workshop
    was held near to the pub. The hackers drank
    the pub dry. The pub owner could finally afford
    a vacation.
    INPUT
    beer
    masak
    vacation
    whisky
    SEARCHES

is $갢丧𝐩갮中, $𝐩갮丛-w̲갢中両-丧갨-丛e̲e̲с;
is-deeply @òe̲àс개両e̲ò, @e̲ч𝐩e̲개中e̲𝐝-òe̲àс개両e̲ò;

my @сe̲ò갮л中ò = gather {
   for @òe̲àс개両e̲ò -> $s {
   take $갢丧𝐩갮中 ~~ /$s/
        ?? "Found $s"
        !! "Didn't find $s";
   }
};

is-deeply @сe̲ò갮л中ò, [q:to"END RESULTS".lines], 'search results';
Found beer
Didn't find masak
Found vacation
Didn't find whisky
END RESULTS

like(qq:!s"It costs $10 to {<eat nom>.pick} here.", /^'It costs $10 to '[eat|nom]' here.'$/, 'quoting features');

is Q{$*DISTRO.name\n&sin(3)}, q:to"END".chomp;
$*DISTRO.name\n&sin(3)
END

like(Q:s{$*DISTRO.name\n&sin(3)}, /\w+ .*? '\n&sin(3)'/, 'Q:s(...)');

like(Q:s:b{$*DISTRO.name\n&sin(3)}, /\w+ .*? \n '&sin(3)'/, 'Q:s:b(...)');

like(Q:s:b:f{$*DISTRO.name\n&sin(3)}, /\w+ .*? \n '0.14112'\d+$/, 'Q:s:b:f(...)');

# vim: expandtab shiftwidth=4
