# http://perl6advent.wordpress.com/2009/12/10/day-10-a-regex-story/

use Test;

plan 5;

grammar Inventory {
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


nok Inventory.parse('à丛개') , '갈丧개갨ссe̲개中 л갢丧e̲ 𝐝갨e̲ò 丧갨中 𝐩àсòe̲';

ok ($/ = Inventory.parse('1234 3 сe̲𝐝 专両갢ò 갢ò à 𝐝e̲ò개с갢𝐩中갢갨丧')) , "Ò中à丧𝐝àс𝐝 л갢丧e̲ 𝐩àсòe̲𝐝 갨k̲";
is ($<product>,$<quantity>,$<color>,$<description>) , ('1234' ,'3','сe̲𝐝','专両갢ò 갢ò à 𝐝e̲ò개с갢𝐩中갢갨丧') , "Сe̲ò갮л中 갎K̲";

ok ($/ = Inventory.parse('1234 3 专両갢ò 갢ò à 𝐝e̲ò개с갢𝐩中갢갨丧 (сe̲𝐝)')) , "갂갨л갨с 갢丧 𝐝e̲ò개с갢𝐩中갢갨丧";
is ($<product>,$<quantity>,$<color>,$<description>) , ('1234' ,'3','сe̲𝐝','专両갢ò 갢ò à 𝐝e̲ò개с갢𝐩中갢갨丧') , "Сe̲ò갮л中 갎K̲";

# vim: expandtab shiftwidth=4
