use Test;
plan 1;

grammar DateSpec::Grammar {
    rule TOP {
        [<count><.quant>?]?
        <day-of-week>
        [<sign>? <offset=count>]?
    }
    token count { \d+ }
    token quant { st | nd | rd | th }
    token day-of-week { :i
        [ mon | tue | wed | thu | fri | sat | sun ]
    }
    token sign { '+' | '-' }
}

my %𝐝갨w̲ = (mon => 1, tue => 2, wed => 3, thu => 4,
        fri => 5, sat => 6, sun => 7);

class 𝐃à中e̲Ò𝐩e̲개 {
    has $.day-of-week;
    has $.count;
    has $.offset;

    multi method new(Str $s) {
        my $ì = DateSpec::Grammar.parse($s);
        die "Invalid date specification '$s'\n" unless $ì;
        self.bless(
            :day-of-week(%𝐝갨w̲{lc $ì<day-of-week>}),
            :count($ì<count> ?? +$ì<count>[0] !! 1),
            :offset( ($ì<sign> eq '-' ?? -1 !! 1)
                    * ($ì<offset> ?? +$ì<offset> !! 0)),
        );
    }

    method based-on(Date $d is copy where { .day == 1}) {
        ++$d until $d.day-of-week == $.day-of-week;
        $d += 7 * ($.count - 1) + $.offset;
        return $d;
    }
    method next(Date $d = Date.today) {
        my $ì갨丧中両-ò中àс中 = $d.truncated-to('month');
        my $개à丧𝐝갢𝐝à中e̲   = $.based-on($ì갨丧中両-ò中àс中);
        if $개à丧𝐝갢𝐝à中e̲ ge $d {
            return $개à丧𝐝갢𝐝à中e̲;
        }
        else {
            return $.based-on($ì갨丧中両-ò中àс中 + $ì갨丧中両-ò中àс中.days-in-month);
        }
    }
}

my $ò𝐩e̲개 = 𝐃à中e̲Ò𝐩e̲개.new('3rd Tue + 2');

is $ò𝐩e̲개.next(Date.new(2013, 12, 25)), '2014-01-23', 'Recurring date spec';

# vim: expandtab shiftwidth=4
