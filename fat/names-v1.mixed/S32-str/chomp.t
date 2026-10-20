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
    my $е갨갨 = "foo\n";
    chomp($е갨갨);
    is($е갨갨, "foo\n", 'our variable was not yet chomped');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\n\n";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\n", 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\nbar\n";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\nbar", 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, "foo\nbar", 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\n ";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\n ", 'our variable is chomped with no effect');
}

{
    my $е갨갨 = "foo\n\n";
    my $개両갨ì𝐩e̲𝐝 = $е갨갨.chomp;
    is($е갨갨, "foo\n\n", ".chomp has no effect on the original string");
    is($개両갨ì𝐩e̲𝐝, "foo\n", ".chomp returns correctly chomped value");

    $개両갨ì𝐩e̲𝐝 = $개両갨ì𝐩e̲𝐝.chomp;
    is($개両갨ì𝐩e̲𝐝, "foo", ".chomp returns correctly chomped value again");
}

# testing \r newlines
{
    my $е갨갨 = "foo\r";
    chomp($е갨갨);
    is($е갨갨, "foo\r", 'our variable was not yet chomped');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\r\r";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\r", 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\rbar\r";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\rbar", 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, "foo\rbar", 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\r ";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\r ", 'our variable is chomped with no effect');
}

{
    my $е갨갨 = "foo\r\r";
    my $개両갨ì𝐩e̲𝐝 = $е갨갨.chomp;
    is($е갨갨, "foo\r\r", ".chomp has no effect on the original string");
    is($개両갨ì𝐩e̲𝐝, "foo\r", ".chomp returns correctly chomped value");

    $개両갨ì𝐩e̲𝐝 = $개両갨ì𝐩e̲𝐝.chomp;
    is($개両갨ì𝐩e̲𝐝, "foo", ".chomp returns correctly chomped value again");
}

# testing \r\n newlines
{
    my $е갨갨 = "foo\r\n";
    chomp($е갨갨);
    is($е갨갨, "foo\r\n", 'our variable was not yet chomped');
    $е갨갨 .= chomp;
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    is($е갨갨, 'foo', 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again with no effect');
}

#?rakudo.jvm todo '\r\n not yet handled as grapheme'
{
    my $е갨갨 = "foo\r\n\r\n";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\r\n", 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again correctly');
    $е갨갨 .= chomp;
    is($е갨갨, 'foo', 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\r\nbar\r\n";
    $е갨갨 .= chomp;
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    is($е갨갨, "foo\r\nbar", 'our variable is chomped correctly');
    $е갨갨 .= chomp;
    is($е갨갨, "foo\r\nbar", 'our variable is chomped again with no effect');
}

{
    my $е갨갨 = "foo\r\n ";
    $е갨갨 .= chomp;
    is($е갨갨, "foo\r\n ", 'our variable is chomped with no effect');
}

{
    my $е갨갨 = "foo\r\n\r\n";
    my $개両갨ì𝐩e̲𝐝 = $е갨갨.chomp;
    is($е갨갨, "foo\r\n\r\n", ".chomp has no effect on the original string");
    #?rakudo.jvm 2 todo '\r\n not yet handled as grapheme'
    is($개両갨ì𝐩e̲𝐝, "foo\r\n", ".chomp returns correctly chomped value");

    $개両갨ì𝐩e̲𝐝 = $개両갨ì𝐩e̲𝐝.chomp;
    is($개両갨ì𝐩e̲𝐝, "foo", ".chomp returns correctly chomped value again");
}

#testing strings with less than 2 characters
{
    my $е갨갨 = "\n";
    my $丛àс = "\r";
    my $丛à丳 = "";

    my $개両갨ì𝐩e̲𝐝 = $е갨갨.chomp;
    is($개両갨ì𝐩e̲𝐝, "", ".chomp works on string with just a newline");

    $개両갨ì𝐩e̲𝐝 = $丛àс.chomp;
    is($개両갨ì𝐩e̲𝐝, "", ".chomp works on string with just a carriage return");

    $개両갨ì𝐩e̲𝐝 = $丛à丳.chomp;
    is($개両갨ì𝐩e̲𝐝, "", ".chomp doesn't affect empty string");

    # \r\n newlines not tested because that's never less than 2 characters.
}
=begin pod

Basic tests for the chomp() builtin working on an array of strings

=end pod


# vim: expandtab shiftwidth=4
