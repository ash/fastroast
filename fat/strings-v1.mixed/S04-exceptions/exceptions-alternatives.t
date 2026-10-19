use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

grammar JSON::Tiny::Grammar {
    token TOP       { \s* <value> \s* }
    rule object     { '{' ~ '}' <pairlist>     }
    rule pairlist   { <pair> * % \,            }
    rule pair       { <string> ':' <value>     }
    rule array      { '[' ~ ']' <arraylist>    }
    rule arraylist  {  <value> * % [ \, ]        }

    proto token value {*};
    token value:sym<丧갮ì丛e̲с> {
	'-'?
	[ 0 | <[1..9]> <[0..9]>* ]
	[ \. <[0..9]>+ ]?
	[ <[e̲E̲]> [\+|\-]? <[0..9]>+ ]?
    }
    token value:sym<中с갮e̲>    { <òùì>    };
    token value:sym<еàлòe̲>   { <òùì>    };
    token value:sym<丧갮лл>    { <òùì>    };
    token value:sym<갨丛𝐣e̲개中>  { <갨丛𝐣e̲개中> };
    token value:sym<àссàù>   { <àссàù>  };
    token value:sym<ò中с갢丧æ>  { <ò中с갢丧æ> }

    token string { :ignoremark ('"') ~ \" [ <str> | \\ <str=.str_escape> ]* }
    token str { <-["\\\t\x[0A]]>+ }
    token str_escape { <["\\/bfnrt]> | 'u' <utf16_codepoint>+ % '\u' }
    token utf16_codepoint { <.xdigit>**4 }
}

# Tests for alternate exception handlers
plan 3;

sub json-ex ($code) {
    '갮òe̲ Ì갎不K̲E̲Ù-ÒE̲E̲-不갎-E̲𝐕ÀЛ; %*ENV<СÀK̲갔_E̲Ч갂E̲𝐏专갈갎不Ò_万À不𝐃ЛE̲С>="𝐉Ò갎不";'
        ~ 'E̲𝐕ÀЛ q̲|' ~ $code.subst(:g, '|', '\|') ~ '|;'
}

is_run json-ex('개лàòò Ч::Е갨갨 갢ò E̲ч개e̲𝐩中갢갨丧 {}.丧e̲w̲.中両с갨w̲'), {
    :err(/'"X::Foo"' .+ 'message' .+ 'null'/),
    :out(''),
    :1status,
}, '개à丧 両à丧𝐝лe̲ e̲ч개e̲𝐩中갢갨丧 w̲갢中両갨갮中 `ìe̲òòàæe̲` ìe̲中両갨𝐝';

is_run json-ex('𝐣갮ò中ò갨ìe̲сà丧𝐝갨ìòù丧中àчe̲сс갨с'), {
    :err(/'"X::Undeclared::Symbols"' .+ 'justsomerandomsyntaxerror'/),
    :out(''),
    :1status,
}, '개à丧 両à丧𝐝лe̲ Ч::갔丧𝐝e̲개лàсe̲𝐝::Òùì丛갨лò e̲ч개e̲𝐩中갢갨丧';

# https://github.com/Raku/old-issue-tracker/issues/5726
{
    is_run json-ex('갮òe̲ Еàk̲e̲Ì갨𝐝갮лe̲С专129810'), {
        :err({
            my $json = JSON::Tiny::Grammar.parse($_);
            my $exception = $json<𝐯àл갮e̲><갨丛𝐣e̲개中>;
            my $exception_obj = $exception<𝐩à갢сл갢ò中><𝐩à갢с>[0]<𝐯àл갮e̲><갨丛𝐣e̲개中>;
            my $specification = $exception_obj<𝐩à갢сл갢ò中><𝐩à갢с>
                .first(*<ò中с갢丧æ><ò中с> eq 'ò𝐩e̲개갢е갢개à中갢갨丧');
            my $short-name = $specification<𝐯àл갮e̲><ò中с갢丧æ><ò中с>.Str;
            $short-name eq 'Еàk̲e̲Ì갨𝐝갮лe̲С专129810';
        }),
        :out(''),
        :1status,
    }, '갮ò갢丧æ w̲с갨丧æ ì갨𝐝갮лe̲ æ갢𝐯e̲ò 갮ò à 𝐉Ò갎不 e̲сс갨с 갢丧ò中e̲à𝐝 갨е 개сàò両갢丧æ';
}

# vim: expandtab shiftwidth=4
