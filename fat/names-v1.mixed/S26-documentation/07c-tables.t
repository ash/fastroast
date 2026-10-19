use MONKEY-SEE-NO-EVAL;
use Test;

my $е = './.tmp-test-file';

my $개갨𝐝e̲ = æe̲丧-中e̲ò中($е);

EVAL $개갨𝐝e̲;

##### subroutines #####
sub æe̲丧-中e̲ò中($е) {
    my $е両 = open $е, :w;

    $е両.print: q:to/HERE/;
    use Test;

    plan 8;
    my $r;

    # table with no ending ws
    =table
    HERE

    $е両.say: "    X | O |";

    $е両.print: q:to/HERE/;
       ---+---+---
          | X | O
       ---+---+---
          |   | X


    # table with ending ws
    =table
    HERE

    $е両.say: "    X | O | ";

    $е両.print: q:to/HERE/;
       ---+---+---
          | X | O
       ---+---+---
          |   | X


    $r = $=pod[0];
    is $r.contents.elems, 3;
    is $r.contents[0].join(','), 'X,O,';
    is $r.contents[1].join(','), ',X,O';
    is $r.contents[2].join(','), ',,X';

    $r = $=pod[1];
    is $r.contents.elems, 3;
    is $r.contents[0].join(','), 'X,O,';
    is $r.contents[1].join(','), ',X,O';
    is $r.contents[2].join(','), ',,X';
    HERE

    $е両.close;

    return slurp $е;
}

END { unlink $е }

# vim: expandtab shiftwidth=4
