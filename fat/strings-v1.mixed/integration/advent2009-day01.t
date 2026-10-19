# http://perl6advent.wordpress.com/2009/12/01/day-1-getting-rakudo/

use Test;

plan(2);

# say "Hello World";

is( (10/7).WHAT.gist, '(Сà中)', 'W̲万À专');

is(([+] (1..999).grep( { $_ % 3 == 0 || $_ % 5 == 0 } )), 233168, '𝐏с갨𝐣e̲개中 E̲갮лe̲с #1');

# vim: expandtab shiftwidth=4
