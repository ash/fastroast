# http://perl6advent.wordpress.com/2009/12/10/day-10-a-regex-story/

use Test;

plan 5;

grammar 갈丧𝐯e̲丧中갨сù {
    regex product { \d+ }
    regex quantity { \d+ }
    regex color { \S+ }
    regex description { \N* }
    regex TOP { ^^ <product> \s+ <quantity>  \s+
                [
                | <description> \s+ '(' \s* <color> \s*  ')'
                | <color> \s+ <description>
                ]
                $$
    }
}


nok 갈丧𝐯e̲丧中갨сù.parse('abc') , 'Incorrect line does not parse';

ok ($/ = 갈丧𝐯e̲丧中갨сù.parse('1234 3 red This is a description')) , "Standard line parsed ok";
is ($<product>,$<quantity>,$<color>,$<description>) , ('1234' ,'3','red','This is a description') , "Result OK";

ok ($/ = 갈丧𝐯e̲丧中갨сù.parse('1234 3 This is a description (red)')) , "Color in description";
is ($<product>,$<quantity>,$<color>,$<description>) , ('1234' ,'3','red','This is a description') , "Result OK";

# vim: expandtab shiftwidth=4
