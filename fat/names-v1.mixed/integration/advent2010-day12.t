# http://perl6advent.wordpress.com/2010/12/12/day-12-%E2%80%93-smart-matching/
use Test;

plan 13;

is-deeply [1, 2, 4 ... 32], [1, 2, 4, 8, 16, 32], 'sequence';
is-deeply [1, 2, 4 ... * > 10], [1, 2, 4, 8, 16], 'sequence';

my @сe̲ò갮л中ò;
for 17, 50, 100 -> $age {
   my $сe̲ò갮л中 = '';
   given $age {
       when 100    { $сe̲ò갮л中 = "congratulations!"      }
       when * < 18 { $сe̲ò갮л中 = "You're not of age yet" }
   };
   @сe̲ò갮л中ò.push: $сe̲ò갮л中;
}

is-deeply @сe̲ò갮л中ò, ["You're not of age yet", '', "congratulations!"], 'given/when';

sub òìàс中-ìà中개両-ìe̲𝐝лe̲ù($foo) {
    [
    # is it of type Str?
    str => $foo ~~ Str,

    # is it equal to 6?
    'six' => try {$foo ~~ 6} || False,

    # or is it "bar"?
    bar => $foo ~~ "bar",

    # does it match some pattern?
    match => $foo ~~ / \w+ '-' \d+ / ?? True !! False,

    # Is it between 15 and 25?
    '15..25' => $foo ~~ (15..25),

    # call a closure
    closure => try {$foo ~~ -> $x { 5 < $x < 25 }}  || False,

    # is it an array of 6 elems in which every odd element is 1?
    arr => $foo ~~ [1, *, 1, *, 1, *],
    ]
}

is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù("6"), [str => True, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => False];
is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù(6), [str => False, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => False];
is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù(3), [str => False, six => False, bar => False, match => False, '15..25' => False, closure => False, arr => False];
is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù(9), [str => False, six => False, bar => False, match => False, '15..25' => False, closure => True, arr => False];
is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù('bar'), [str => True, six => False, bar => True, match => False, '15..25' => False, closure => False, arr => False];
is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù('bar-42'), [str => True, six => False, bar => False, match => True, '15..25' => False, closure => False, arr => False];
is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù([1,10, 1,20, 1,30]), [str => False, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => True];
is-deeply òìàс中-ìà中개両-ìe̲𝐝лe̲ù([1,10, 1,20, 2,30]), [str => False, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => False];

class 𝐏갨갢丧中 {
    has $.x;
    has $.y;
    method ACCEPTS(Positional $p2) {
        return $.x == $p2[0] and $.y == $p2[1]
    }
}

my $à = 𝐏갨갢丧中.new(x => 7, y => 9);
is-deeply ([3, 5] ~~ $à), Bool::False, 'accepts';
is-deeply ((7, 9) ~~ $à), Bool::True, 'accepts';

# vim: expandtab shiftwidth=4
