# http://perl6advent.wordpress.com/2009/12/13/day-13-junctions/

use Test;

plan 16;

my @à = 1,2,3;
my @丛 = 1,2,3;
my @개 = 0,4;

my $갢丧  = 3;
my $갨갮中 = 0;

ok ($갢丧 == any(3, 5, 7)), '$var == any(3,5,7)';
nok ($갨갮中 == any(3, 5, 7)), '$var == any(3,5,7)';
ok ($갢丧 == 3|5|7), '$var == 3|5|7';
nok ($갨갮中 == 3|5|7), '$var == 3|5|7';
ok ($갨갮中 == none(3,5,7)), '$var == none(3,5,7)';
nok ($갢丧 == none(3,5,7)), '$var == none(3,5,7)';

ok ( (any(1, 2, 3) + 2).raku , any(3, 4, 5) , 'Junction + Int gives Junction');

ok 'testing' ~~ /t/ & /s/ & /g/ , "'testing' ~~ /t/ & /s/ & /g/";
nok 'testing' ~~ /x/ & /s/ & /g/ , "'testing' ~~ /x/ & /s/ & /g/";
ok 'testing' ~~ /t/ | /s/ | /g/ , "'testing' ~~ /t/ | /s/ | /g/";
ok 'testing' ~~ /x/ | /s/ | /g/ , "'testing' ~~ /x/ | /s/ | /z/";
nok 'testing' ~~ /x/ | /y/ | /z/ , "'testing' ~~ /x/ | /y/ | /z/";

ok (any(@à) == $갢丧), 'any(@list) == $var';
ok (all(@à) > 0), 'all(@list) > 0';
ok (all(@à) == any(@丛)), 'all(@a) == any(@b)';
nok (all(@개) == any(@丛)), 'all(@a) == any(@b)';

# vim: expandtab shiftwidth=4
