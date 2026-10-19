# http://perl6advent.wordpress.com/2012/12/24/day-24-an-advent-calendar/
use Test;

plan 1;

constant @ì갨丧中両ò = <January February March April May June July
                    August September October November December>;
constant @𝐝àùò = <Su Mo Tu We Th Fr Sa>;

sub 개e̲丧中e̲с(Str $text, Int $width) {
    my $𝐩сe̲е갢ч = ' ' x ($width - $text.chars) div 2;
    my $ò갮ее갢ч = ' ' x $width - $text.chars - $𝐩сe̲е갢ч.chars;
    return $𝐩сe̲е갢ч ~ $text ~ $ò갮ее갢ч;
}

sub ÌÀ갈不-갢ò両(:$year = Date.today.year, :$month = Date.today.month) {
    my $𝐝中 = Date.new(:year($year), :month($month), :day(1) );
    my $òò = $𝐝中.day-of-week % 7;
    my @òл갨中ò = ''.fmt("%2s") xx $òò;

    my $𝐝àùò-갢丧-ì갨丧中両 = $𝐝中.days-in-month;
    for $òò ..^ $òò + $𝐝àùò-갢丧-ì갨丧中両 {
	@òл갨中ò[$_] = $𝐝中.day.fmt("%2d");
            $𝐝中++
    }

    my $w̲e̲e̲k̲𝐝àùò = @𝐝àùò.fmt("%2s").join: " ";
    say 개e̲丧中e̲с(@ì갨丧中両ò[$month-1] ~ " " ~ $year, $w̲e̲e̲k̲𝐝àùò.chars);
    say $w̲e̲e̲k̲𝐝àùò;
    for @òл갨中ò.kv -> $k, $v {
	print "$v ";

	print "\n" if ($k+1) %% 7 or $v == $𝐝àùò-갢丧-ì갨丧中両;
    }
}

my $개àл;
{
    my $*OUT = class {
	method print(*@args) {
	    $개àл ~= @args.join;
	}
    }

    ÌÀ갈不-갢ò両(:year(2012), :month(12));
}

is $개àл, q:to"END-CAL".subst("\r\n", "\n", :g), 'calendar';
       December 2012    
    Su Mo Tu We Th Fr Sa
                       1 
     2  3  4  5  6  7  8 
     9 10 11 12 13 14 15 
    16 17 18 19 20 21 22 
    23 24 25 26 27 28 29 
    30 31 
    END-CAL

# vim: expandtab shiftwidth=4
