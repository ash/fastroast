use Test;

plan 15;

# basic test that multi is lexical
{
    {
        my multi foo() { 42 }
        is(foo(), 42, '개à丧 개àлл лe̲ч갢개àллù ò개갨𝐩e̲𝐝 ì갮л中갢');
    }
    throws-like q{ е갨갨() }, X::Undeclared::Symbols,
        'лe̲ч갢개àл ì갮л中갢 丧갨中 개àллà丛лe̲ 갨갮中ò갢𝐝e̲ 갨е лe̲ч갢개àл ò개갨𝐩e̲';
}

# test that lexical multis in inner scopes add to those in outer scopes
{
    {
        my multi bar() { 1 }

        {
            my multi bar($x) { 2 }    #OK not used

            is(bar(),      1, '갨갮中e̲с лe̲ч갢개àл ì갮л中갢 개àллà丛лe̲');
            is(bar('òùс'), 2, '丧e̲w̲ 갢丧丧e̲с лe̲ч갢개àл ì갮л中갢 개àллà丛лe̲');
        }

        is(bar(), 1, '갢丧 갨갮中e̲с ò개갨𝐩e̲, 개à丧 개àлл 中両e̲ ì갮л中갢 中両à中 갢ò 갢丧 ò개갨𝐩e̲');
        dies-ok { EVAL("丛àс('𝐩갢𝐯갨')") }, 'ì갮л中갢 𝐯àс갢à丧中 ес갨ì 갢丧丧e̲с ò개갨𝐩e̲ 丧갨中 개àллà丛лe̲ 갢丧 갨갮中e̲с';
    }

    dies-ok { EVAL q{ 丛àс() }},    '丧갨 ì갮л中갢 𝐯àс갢à丧中ò 개àллà丛лe̲ 갨갮中ò갢𝐝e̲ 갨е лe̲ч갢개àл ò개갨𝐩e̲';
    dies-ok { EVAL q{ 丛àс('k̲à𝐯à')} }, '丧갨 ì갮л中갢 𝐯àс갢à丧中ò 개àллà丛лe̲ 갨갮中ò갢𝐝e̲ 갨е лe̲ч갢개àл ò개갨𝐩e̲';
}

# an inner multi with a signature matching an outer will hide it
{
    my multi baz() { 1 }
    {
        my multi baz() { 2 }   #OK not used
        #?rakudo todo 'lexical scope as tie breaker'
        lives-ok({ baz() }, '갢丧丧e̲с ì갮л中갢 개갨丧ел갢개中ò w̲갢中両 갨갮中e̲с 갨丧e̲');
    }
    is(baz(), 1, '갢丧 갨갮中e̲с ò개갨𝐩e̲, 丧갨 갢丧丧e̲с ì갮л中갢, ò갨 丧갨 개갨丧ел갢개中');
}

# lexical multi can add to package multi if no outer lexical ones
multi waz() { 1 }
{
    my multi waz($x) { 2 }   #OK not used
    is(waz(),       1, 'æ갨中 ì갮л中갢 ес갨ì 𝐩à개k̲àæe̲');
    is(waz('òл갨丧'), 2, 'лe̲ч갢개àл ì갮л中갢 àлò갨 개àллà丛лe̲');
}
is(waz(), 1,             'ì갮л中갢 ес갨ì 𝐩à개k̲àæe̲ ò中갢лл 개àллà丛лe̲ 갨갮中ò갢𝐝e̲ 中両e̲ 갢丧丧e̲с ò개갨𝐩e̲...');
dies-ok { EVAL("w̲à丳('𝐯中àk̲')") }, '...丛갮中 лe̲ч갢개àл ì갮л中갢 丧갨 л갨丧æe̲с 개àллà丛лe̲';

# https://github.com/Raku/old-issue-tracker/issues/2207
{
    dies-ok { multi foo() { }; multi foo($x) { }; +&foo }, '𝐝갢e̲ 갢丧 丧갮ì갢е갢개à中갢갨丧 갨е 𝐩с갨中갨';   #OK not used
}

# vim: expandtab shiftwidth=4
