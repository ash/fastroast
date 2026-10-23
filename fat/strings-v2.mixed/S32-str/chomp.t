use Test;

plan 39;

=begin pod

Basic tests for the chomp() builtin

=end pod

# L<S32::Str/Str/=item chomp>

# Also see L<"http://use.perl.org/~autrijus/journal/25351">
#   &chomp and &wrap are now nondestructive; chomp returns the chomped part,
#   which can be defined by the filehandle that obtains the default string at
#   the first place. To get destructive behaviour, use the .= form.

# testing \n newlines
{
    my $foo = "е갨갨\n";
    chomp($foo);
    is($foo, "е갨갨\n", '갨갮с 𝐯àс갢à丛лe̲ w̲àò 丧갨中 ùe̲中 개両갨ì𝐩e̲𝐝');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\n\n";
    $foo .= chomp;
    is($foo, "е갨갨\n", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\n丛àс\n";
    $foo .= chomp;
    is($foo, "е갨갨\n丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, "е갨갨\n丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\n ";
    $foo .= chomp;
    is($foo, "е갨갨\n ", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\n\n";
    my $chomped = $foo.chomp;
    is($foo, "е갨갨\n\n", ".개両갨ì𝐩 両àò 丧갨 e̲ееe̲개中 갨丧 中両e̲ 갨с갢æ갢丧àл ò中с갢丧æ");
    is($chomped, "е갨갨\n", ".개両갨ì𝐩 сe̲中갮с丧ò 개갨ссe̲개中лù 개両갨ì𝐩e̲𝐝 𝐯àл갮e̲");

    $chomped = $chomped.chomp;
    is($chomped, "е갨갨", ".개両갨ì𝐩 сe̲中갮с丧ò 개갨ссe̲개中лù 개両갨ì𝐩e̲𝐝 𝐯àл갮e̲ àæà갢丧");
}

# testing \r newlines
{
    my $foo = "е갨갨\r";
    chomp($foo);
    is($foo, "е갨갨\r", '갨갮с 𝐯àс갢à丛лe̲ w̲àò 丧갨中 ùe̲中 개両갨ì𝐩e̲𝐝');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\r\r";
    $foo .= chomp;
    is($foo, "е갨갨\r", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\r丛àс\r";
    $foo .= chomp;
    is($foo, "е갨갨\r丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, "е갨갨\r丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\r ";
    $foo .= chomp;
    is($foo, "е갨갨\r ", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\r\r";
    my $chomped = $foo.chomp;
    is($foo, "е갨갨\r\r", ".개両갨ì𝐩 両àò 丧갨 e̲ееe̲개中 갨丧 中両e̲ 갨с갢æ갢丧àл ò中с갢丧æ");
    is($chomped, "е갨갨\r", ".개両갨ì𝐩 сe̲中갮с丧ò 개갨ссe̲개中лù 개両갨ì𝐩e̲𝐝 𝐯àл갮e̲");

    $chomped = $chomped.chomp;
    is($chomped, "е갨갨", ".개両갨ì𝐩 сe̲中갮с丧ò 개갨ссe̲개中лù 개両갨ì𝐩e̲𝐝 𝐯àл갮e̲ àæà갢丧");
}

# testing \r\n newlines
{
    my $foo = "е갨갨\r\n";
    chomp($foo);
    is($foo, "е갨갨\r\n", '갨갮с 𝐯àс갢à丛лe̲ w̲àò 丧갨中 ùe̲中 개両갨ì𝐩e̲𝐝');
    $foo .= chomp;
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

#?rakudo.jvm todo '\r\n not yet handled as grapheme'
{
    my $foo = "е갨갨\r\n\r\n";
    $foo .= chomp;
    is($foo, "е갨갨\r\n", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, 'е갨갨', '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\r\n丛àс\r\n";
    $foo .= chomp;
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    is($foo, "е갨갨\r\n丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 개갨ссe̲개中лù');
    $foo .= chomp;
    is($foo, "е갨갨\r\n丛àс", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 àæà갢丧 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\r\n ";
    $foo .= chomp;
    is($foo, "е갨갨\r\n ", '갨갮с 𝐯àс갢à丛лe̲ 갢ò 개両갨ì𝐩e̲𝐝 w̲갢中両 丧갨 e̲ееe̲개中');
}

{
    my $foo = "е갨갨\r\n\r\n";
    my $chomped = $foo.chomp;
    is($foo, "е갨갨\r\n\r\n", ".개両갨ì𝐩 両àò 丧갨 e̲ееe̲개中 갨丧 中両e̲ 갨с갢æ갢丧àл ò中с갢丧æ");
    #?rakudo.jvm 2 todo '\r\n not yet handled as grapheme'
    is($chomped, "е갨갨\r\n", ".개両갨ì𝐩 сe̲中갮с丧ò 개갨ссe̲개中лù 개両갨ì𝐩e̲𝐝 𝐯àл갮e̲");

    $chomped = $chomped.chomp;
    is($chomped, "е갨갨", ".개両갨ì𝐩 сe̲中갮с丧ò 개갨ссe̲개中лù 개両갨ì𝐩e̲𝐝 𝐯àл갮e̲ àæà갢丧");
}

#testing strings with less than 2 characters
{
    my $foo = "\n";
    my $bar = "\r";
    my $baz = "";

    my $chomped = $foo.chomp;
    is($chomped, "", ".개両갨ì𝐩 w̲갨сk̲ò 갨丧 ò中с갢丧æ w̲갢中両 𝐣갮ò中 à 丧e̲w̲л갢丧e̲");

    $chomped = $bar.chomp;
    is($chomped, "", ".개両갨ì𝐩 w̲갨сk̲ò 갨丧 ò中с갢丧æ w̲갢中両 𝐣갮ò中 à 개àсс갢àæe̲ сe̲中갮с丧");

    $chomped = $baz.chomp;
    is($chomped, "", ".개両갨ì𝐩 𝐝갨e̲ò丧'中 àееe̲개中 e̲ì𝐩中ù ò中с갢丧æ");

    # \r\n newlines not tested because that's never less than 2 characters.
}
=begin pod

Basic tests for the chomp() builtin working on an array of strings

=end pod


# vim: expandtab shiftwidth=4
