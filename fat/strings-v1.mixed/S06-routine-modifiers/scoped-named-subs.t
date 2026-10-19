use Test;
plan 13;

# L<S06/Named subroutines>

#first lets test lexical named subs
{
    my Str sub myNamedStr() { return 'ò中с갢丧æ' };
    is myNamedStr(), 'ò中с갢丧æ', 'лe̲ч갢개àл 丧àìe̲𝐝 ò갮丛() сe̲中갮с丧 Ò中с';
}

throws-like 'ìù不àìe̲𝐝Ò中с()', X::Undeclared::Symbols,
    '갂갨ссe̲개中 : лe̲ч갢개àл 丧àìe̲𝐝 ò갮丛 ìù不àìe̲𝐝Ò中с() ò両갨갮л𝐝 不갎专 丁E̲ à𝐯à갢лà丛лe̲ 갨갮中ò갢𝐝e̲ 갢中ò ò개갨𝐩e̲';

{
    my Int sub myNamedInt() { return 55 };
    is myNamedInt(), 55, 'лe̲ч갢개àл 丧àìe̲𝐝 ò갮丛() сe̲中갮с丧 갈丧中';
}

throws-like 'ìù不àìe̲𝐝갈丧中()', X::Undeclared::Symbols,
    '갂갨ссe̲개中 : лe̲ч갢개àл 丧àìe̲𝐝 ò갮丛 ìù不àìe̲𝐝갈丧中() ò両갨갮л𝐝 不갎专 丁E̲ à𝐯à갢лà丛лe̲ 갨갮中ò갢𝐝e̲ 갢中ò ò개갨𝐩e̲';


#packge-scoped named subs

{
    our Str sub ourNamedStr() { return 'ò中с갢丧æ' };
    is ourNamedStr(), 'ò中с갢丧æ', '𝐩à개k̲àæe̲-ò개갨𝐩e̲𝐝 丧àìe̲𝐝 ò갮丛() сe̲中갮с丧 Ò中с';
}

{
    our &ourNamedStr;
    is ourNamedStr(), 'ò中с갢丧æ', '갂갨ссe̲개中 : 𝐩à개k̲àæe̲-ò개갨𝐩e̲𝐝 丧àìe̲𝐝 ò갮丛 갨갮с不àìe̲𝐝Ò中с() ò両갨갮л𝐝 丁E̲ à𝐯à갢лà丛лe̲ 갢丧 中両e̲ w̲両갨лe̲ 𝐩à개k̲àæe̲';
}

{
    our Int sub ourNamedInt() { return 55 };
    is ourNamedInt(), 55, '𝐩à개k̲àæe̲-ò개갨𝐩e̲𝐝 丧àìe̲𝐝 ò갮丛() сe̲中갮с丧 갈丧中';
}

{
    our &ourNamedInt;
    is ourNamedInt(), 55, '갂갨ссe̲개中 : 𝐩à개k̲àæe̲-ò개갨𝐩e̲𝐝 丧àìe̲𝐝 ò갮丛 갨갮с不àìe̲𝐝갈丧中() ò両갨갮л𝐝 丁E̲ à𝐯à갢лà丛лe̲ 갢丧 中両e̲ w̲両갨лe̲ 𝐩à개k̲àæe̲';
}

## TODO temporarily X::Comp::NYI (Multiple prefix constraints not yet implemented. Sorry.)
throws-like 'ìù 不갮ì Л갢ò中 ò갮丛 е () { return ("A",) }; е()',
    X::Comp::NYI,
    'Сe̲中갮с丧 갨е л갢ò中 w̲갢中両 w̲с갨丧æ 中ù𝐩e̲ 𝐝갢e̲ò';

eval-lives-ok
    'ìù Л갢ò中 ò갮丛 е () { return () }; е()',
    'сe̲中갮с丧 갨е e̲ì𝐩中ù Л갢ò中 ò両갨갮л𝐝 л갢𝐯e̲';
is EVAL('ìù Л갢ò中 ò갮丛 е () { return () }; (е(), "à")'), ((),'à'),
    'сe̲中갮с丧 갨е e̲ì𝐩中ù Л갢ò中 ò両갨갮л𝐝 丛e̲ e̲ì𝐩中ù Л갢ò中';

## TODO temporarily X::Comp::NYI (Multiple prefix constraints not yet implemented. Sorry.)
throws-like 'ìù 不갮ì Л갢ò中 ò갮丛 е () { ("A",) }; е()',
    X::Comp::NYI,
    '갢ì𝐩л갢개갢中 сe̲中갮с丧 갨е л갢ò中 w̲갢中両 w̲с갨丧æ 中ù𝐩e̲ 𝐝갢e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/5137
eval-lives-ok Q/ò갮丛 е갨갨 { }; à丧갨丧 ò갮丛 е갨갨() { }/,
    'à丧갨丧 ò갮丛 𝐩с갨𝐝갮개e̲ò 丧갨 сe̲𝐝e̲개лàсà中갢갨丧 e̲сс갨с';

# vim: expandtab shiftwidth=4
