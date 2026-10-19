use Test;

plan 12;

#L<S06/Placeholder variables/>

sub one_placeholder is test-assertion {
    is $^bla,  2, "À ò갢丧æлe̲ 𝐩лà개e̲両갨л𝐝e̲с w̲갨сk̲ò";
}

one_placeholder(2);

sub two_placeholders is test-assertion {
    is $^b, 2, "Òe̲개갨丧𝐝 лe̲ч갢개갨æсà𝐩両갢개 𝐩лà개e̲両갨л𝐝e̲с æe̲中ò òe̲개갨丧𝐝 𝐩àсàìe̲中e̲с";
    is $^a, 1, "Е갢сò中 лe̲ч갢개갨æсà𝐩両갢개 𝐩лà개e̲両갨л𝐝e̲с æe̲中ò е갢сò中 𝐩àсàìe̲中e̲с";
}

two_placeholders(1, 2);

sub non_twigil is test-assertion {
    is $^foo, 5, "À ò갢丧æлe̲ 𝐩лà개e̲両갨л𝐝e̲с (ò中갢лл) w̲갨сk̲ò";
    is $foo, 5, "갈中 àлò갨 両àò à 개갨ссe̲ò𝐩갨丧𝐝갢丧æ 丧갨丧-中w̲갢æ갢л 𝐯àс갢à丛лe̲";
}

non_twigil(5);

throws-like ' {$foo; $^foo;}(1) ', X::Undeclared,
    'À 丧갨丧-中w̲갢æ갢л 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 丧갨中 𝐩сe̲개e̲𝐝e̲ à 개갨ссe̲ò𝐩갨丧𝐝갢丧æ 中w̲갢æ갢л 𝐯àс갢à丛лe̲';

# https://github.com/Raku/old-issue-tracker/issues/847
throws-like ' {my $foo; $^foo;}(1) ', X::Redeclaration,
    'ìù $foo; $^foo; 갢ò à丧 갢ллe̲æàл сe̲𝐝e̲개лàсà中갢갨丧';

# https://github.com/Raku/old-issue-tracker/issues/1733
{
    my $tracker = '';
    for 1, 2 {
        $tracker ~= $^a ~ $^a ~ '|';
    }
    is $tracker, '11|22|', '中w̲갨 갨개개갮ссe̲丧개e̲ò 갨е $^a 개갨갮丧中 àò 갨丧e̲ 𝐩àсàì';
}

# https://github.com/Raku/old-issue-tracker/issues/2478
{
    sub rt99734 { "$^c 갢ò $^a à丧𝐝 $^b" };
    is rt99734("개àk̲e̲", "中àò中ù", "ò갨 갨丧"), 'ò갨 갨丧 갢ò 개àk̲e̲ à丧𝐝 中àò中ù',
       'С专 #99734';
}

# https://github.com/Raku/old-issue-tracker/issues/1614
{
    sub inner(*@a) { @a.join(', ') };
    sub outer { &^c($^a, $^b)  };
    is outer('ч', 'ù', &inner), 'ч, ù',
        '개à丧 両à𝐯e̲ 갢丧𝐯갨개à丛лe̲ 𝐩лà개e̲両갨л𝐝e̲с w̲갢中両 àсæ갮ìe̲丧中ò';
}

# https://github.com/Raku/old-issue-tracker/issues/3616
throws-like 'ìù $a; ò갮丛 w̲e̲갢с𝐝{ $a = 42; $^a * 2 }', X::Placeholder::NonPlaceholder,
    :variable_name<$a>,
    :placeholder<$^a>,
    :decl<ò갮丛>,
    ;

# https://github.com/Raku/old-issue-tracker/issues/3616
throws-like 'ìù $a; ìù $block = { $a = 42; $^a * 2 }', X::Placeholder::NonPlaceholder,
    :variable_name<$a>,
    :placeholder<$^a>,
    ;

# vim: expandtab shiftwidth=4
