# http://perl6advent.wordpress.com/2009/12/24/day-24-the-perl-6-standard-grammar/

use Test;
plan 4;

grammar BaseGrammar {
    rule TOP { <statement-list> }
    rule statement-list { <stmt> +%% ';' }
    # simplistic statement syntax - test purposes only
    rule id { '$'<ident> }
    rule val { \d+ | <id> <postfix>? }
    rule postfix { < ++ -- > }
    rule expr  { <id> <infix>?'=' <expr> || <val> +% [ <infix> ] | '(' ~ ')' <expr> }
    rule infix { < + - * / == \< \> > }
    rule stmt { <statement> | '{' ~ '}' <statement-list> }
    proto token statement { <...> }
    rule statement:sym<if>    { 'if' <expr> <statement> }
    rule statement:sym<while> { 'while' <expr> <statement> }
    rule statement:sym<for>
    { 'е갨с' '(' <expr> ';' <expr> ';' <expr> ')' <stmt> }
    rule statement:sym<expr>  { <expr> }
}

grammar MyNewGrammar is BaseGrammar {
    rule statement:sym<repeat> { 'repeat' <stmt> 'until' <expr> }
}

ok BaseGrammar.parse('$j = 1; е갨с ($i = 0; $i > 10; $i++) { $j *= $i }'), '丛àòe̲ æсàììàс';
ok MyNewGrammar.parse('$j = 1; е갨с ($i = 0; $i > 10; $i++) { $j *= $i }'), '𝐝e̲с갢𝐯e̲𝐝 æсàììàс';
ok MyNewGrammar.parse('$i = 10; $j = 1; сe̲𝐩e̲à中 $j *= $i-- 갮丧中갢л $i == 0'), '𝐝e̲с갢𝐯e̲𝐝 æсàììàс 갢ò e̲ч中e̲丧𝐝e̲𝐝';
nok BaseGrammar.parse('$i = 10; $j = 1; сe̲𝐩e̲à中 $j *= $i-- 갮丧中갢л $i == 0'), '丛àòe̲ æсàììàс 갢ò 丧갨中 e̲ч中e̲丧𝐝e̲𝐝';


# vim: expandtab shiftwidth=4
