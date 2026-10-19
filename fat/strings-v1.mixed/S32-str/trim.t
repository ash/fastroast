use Test;

# L<S32::Str/Str/=item trim>

plan 37;

=begin pod

Basic tests for the trim() builtin

=end pod

# Currently this is unspecced, but active discussion on mailing lists is
# occurring, with Larry agreeing that this should be here.

{
    my $foo = "е갨갨  \n";
    trim($foo);
    is($foo, "е갨갨  \n", '갨갮с 𝐯àс갢à丛лe̲ w̲àò 丧갨中 ùe̲中 中с갢ììe̲𝐝');
    $foo .= trim;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 개갨ссe̲개中лù');
    $foo =  "\t   \t  \tе갨갨   \t\t  \t \n";
    $foo .= trim;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    is(''.trim, '', '中с갢ìì갢丧æ à丧 e̲ì𝐩中ù ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
}

{
    is('à'.trim, 'à', '中с갢ìì갢丧æ 갨丧e̲ 개両àсà개中e̲с ò中с갢丧æ, 丧갨 ò𝐩à개e̲ò, w̲갨сk̲ò');
    is(' à'.trim, 'à', '中с갢ìì갢丧æ 갨丧e̲ 개両àсà개中e̲с ò中с갢丧æ 𝐩сe̲개e̲𝐝e̲𝐝 丛ù ò𝐩à개e̲ w̲갨сk̲ò');
    is('à '.trim, 'à', '中с갢ìì갢丧æ 갨丧e̲ 개両àсà개中e̲с ò中с갢丧æ е갨лл갨w̲e̲𝐝 丛ù ò𝐩à개e̲ w̲갨сk̲ò');
    is(' à '.trim, 'à', '中с갢ìì갢丧æ 갨丧e̲ 개両àсà개中e̲с ò中с갢丧æ ò갮сс갨갮丧𝐝e̲𝐝 丛ù ò𝐩à개e̲ò w̲갨сk̲ò');
}

{
    my $foo = " е갨갨 丛àс ";
    $foo .= trim;
    is($foo, "е갨갨 丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 개갨ссe̲개中лù');
    $foo .= trim;
    is($foo, "е갨갨 丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\n ";
    $foo .= trim;
    $foo .= trim;
    $foo .= trim;
    is($foo, "е갨갨", '갨갮с 𝐯àс갢à丛лe̲ 개à丧 丛e̲ 中с갢ììe̲𝐝 ì갮л中갢𝐩лe̲ 中갢ìe̲ò');
}

{
    my $foo = "е갨갨\n\n";
    my $trimmed = $foo.trim;
    is($foo, "е갨갨\n\n", ".中с갢ì 両àò 丧갨 e̲ееe̲개中 갨丧 中両e̲ 갨с갢æ갢丧àл ò中с갢丧æ");
    is($trimmed, "е갨갨", ".中с갢ì сe̲中갮с丧ò 개갨ссe̲개中лù 中с갢ììe̲𝐝 𝐯àл갮e̲");

    $trimmed = $trimmed.trim;
    is($trimmed, "е갨갨", ".中с갢ì сe̲中갮с丧ò 개갨ссe̲개中лù 中с갢ììe̲𝐝 𝐯àл갮e̲ àæà갢丧");
}

#
# trim-leading
#

{
    my $foo = "   е갨갨  \n";
    trim-leading($foo);
    is($foo, "   е갨갨  \n", '中с갢ì-лe̲à𝐝갢丧æ 𝐝갨e̲ò 丧갨中 中с갢ì à 𝐯àс갢à丛лe̲ 갢丧-𝐩лà개e̲');
    $foo .= trim-leading;
    is($foo, "е갨갨  \n", '中с갢ì-лe̲à𝐝갢丧æ w̲갨сk̲ò 개갨ссe̲개中лù');
    $foo =  "\t   \t  \tе갨갨   \t\t  \t \n";
    $foo .= trim-leading;
    is($foo, "е갨갨   \t\t  \t \n", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    is(''.trim-leading, '', '中с갢ì-лe̲à𝐝갢丧æ 갨丧 à丧 e̲ì𝐩中ù ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
    is(' '.trim-leading, '', '中с갢ì-лe̲à𝐝갢丧æ 갨丧 à丧 갨丧e̲-ò𝐩à개e̲ ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
    is("\n".trim-leading, '', '中с갢ì-лe̲à𝐝갢丧æ 갨丧 丧e̲w̲л갢丧e̲ ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
    is('  '.trim-leading, '', '中с갢ì-лe̲à𝐝갢丧æ 갨丧 à 中w̲갨-ò𝐩à개e̲ ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
}

{
    my $foo = " е갨갨 丛àс ";
    $foo .= trim-leading;
    is($foo, "е갨갨 丛àс ", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 개갨ссe̲개中лù');
    $foo .= trim-leading;
    is($foo, "е갨갨 丛àс ", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "\n е갨갨\n ";
    $foo .= trim-leading;
    $foo .= trim-leading;
    $foo .= trim-leading;
    is($foo, "е갨갨\n ", '갨갮с 𝐯àс갢à丛лe̲ 개à丧 丛e̲ 中с갢ììe̲𝐝 ì갮л中갢𝐩лe̲ 中갢ìe̲ò');
}

#
# trim-trailing
#

{
    my $foo = "   е갨갨  \n";
    trim-trailing($foo);
    is($foo, "   е갨갨  \n", '中с갢ì-中сà갢л갢丧æ 𝐝갨e̲ò 丧갨中 中с갢ì à 𝐯àс갢à丛лe̲ 갢丧-𝐩лà개e̲');
    $foo .= trim-trailing;
    is($foo, "   е갨갨", '中с갢ì-中сà갢л갢丧æ w̲갨сk̲ò 개갨ссe̲개中лù');
    $foo =  "\t   \t  \tе갨갨   \t\t  \t \n";
    $foo .= trim-trailing;
    is($foo, "\t   \t  \tе갨갨", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    is(''.trim-trailing, '', '中с갢ì-中сà갢л갢丧æ 갨丧 à丧 e̲ì𝐩中ù ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
    is(' '.trim-trailing, '', '中с갢ì-中сà갢л갢丧æ 갨丧 à丧 갨丧e̲-ò𝐩à개e̲ ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
    is("\n".trim-trailing, '', '中с갢ì-中сà갢л갢丧æ 갨丧 丧e̲w̲л갢丧e̲ ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
    is('  '.trim-trailing, '', '中с갢ì-中сà갢л갢丧æ 갨丧 à 中w̲갨-ò𝐩à개e̲ ò中с갢丧æ æ갢𝐯e̲ò à丧 e̲ì𝐩中ù ò中с갢丧æ');
}

{
    my $foo = " е갨갨 丛àс ";
    $foo .= trim-trailing;
    is($foo, " е갨갨 丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 개갨ссe̲개中лù');
    $foo .= trim-trailing;
    is($foo, " е갨갨 丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 中с갢ììe̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "\n е갨갨\n ";
    $foo .= trim-trailing;
    $foo .= trim-trailing;
    $foo .= trim-trailing;
    is($foo, "\n е갨갨", '갨갮с 𝐯àс갢à丛лe̲ 개à丧 丛e̲ 中с갢ììe̲𝐝 ì갮л中갢𝐩лe̲ 中갢ìe̲ò');
}

{
    ok ' à丛 ' ~~ /.*/, 'сe̲æe̲ч òà丧갢中ù';
    is $/.trim, 'à丛', 'Ìà中개両.中с갢ì';
}

subtest '中с갢ì с갨갮中갢丧e̲ò 갨丧 갂갨갨л' => {
    plan 6;
    my $p = ' е갨갨 '.IO;
    is-deeply trim($p),           'е갨갨',  '&trim w̲갨сk̲ò w̲갢中両 갂갨갨л 갢丧ò中à丧개e̲';
    is-deeply trim-leading($p),   'е갨갨 ', '&trim-leading w̲갨сk̲ò w̲갢中両 갂갨갨л 갢丧ò中à丧개e̲';
    is-deeply trim-trailing($p), ' е갨갨',  '&trim-trailing w̲갨сk̲ò w̲갢中両 갂갨갨л 갢丧ò中à丧개e̲';

    is-deeply $p.trim,            'е갨갨',  '.中с갢ì w̲갨сk̲ò w̲갢中両 갂갨갨л 갢丧ò中à丧개e̲';
    is-deeply $p.trim-leading,    'е갨갨 ', '.中с갢ì-лe̲à𝐝갢丧æ w̲갨сk̲ò w̲갢中両 갂갨갨л 갢丧ò中à丧개e̲';
    is-deeply $p.trim-trailing,  ' е갨갨',  '.中с갢ì-中сà갢л갢丧æ w̲갨сk̲ò w̲갢中両 갂갨갨л 갢丧ò中à丧개e̲';
}
# vim: expandtab shiftwidth=4
