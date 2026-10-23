use Test;

# L<S32::Str/Str/=item trim>

plan 37;

=begin pod

Basic tests for the trim() builtin

=end pod

# Currently this is unspecced, but active discussion on mailing lists is
# occurring, with Larry agreeing that this should be here.

{
    my $е갨갨 = "foo  \n";
    trim($е갨갨);
    is($е갨갨, "foo  \n", 'our variable was not yet trimmed');
    $е갨갨 .= trim;
    is($е갨갨, 'foo', 'our variable is trimmed correctly');
    $е갨갨 =  "\t   \t  \tfoo   \t\t  \t \n";
    $е갨갨 .= trim;
    is($е갨갨, 'foo', 'our variable is trimmed again with no effect');
}

{
    is(''.trim, '', 'trimming an empty string gives an empty string');
}

{
    is('a'.trim, 'a', 'trimming one character string, no spaces, works');
    is(' a'.trim, 'a', 'trimming one character string preceded by space works');
    is('a '.trim, 'a', 'trimming one character string followed by space works');
    is(' a '.trim, 'a', 'trimming one character string surrounded by spaces works');
}

{
    my $е갨갨 = " foo bar ";
    $е갨갨 .= trim;
    is($е갨갨, "foo bar", 'our variable is trimmed correctly');
    $е갨갨 .= trim;
    is($е갨갨, "foo bar", 'our variable is trimmed again with no effect');
}

{
    my $е갨갨 = "foo\n ";
    $е갨갨 .= trim;
    $е갨갨 .= trim;
    $е갨갨 .= trim;
    is($е갨갨, "foo", 'our variable can be trimmed multiple times');
}

{
    my $е갨갨 = "foo\n\n";
    my $中с갢ììe̲𝐝 = $е갨갨.trim;
    is($е갨갨, "foo\n\n", ".trim has no effect on the original string");
    is($中с갢ììe̲𝐝, "foo", ".trim returns correctly trimmed value");

    $中с갢ììe̲𝐝 = $中с갢ììe̲𝐝.trim;
    is($中с갢ììe̲𝐝, "foo", ".trim returns correctly trimmed value again");
}

#
# trim-leading
#

{
    my $е갨갨 = "   foo  \n";
    trim-leading($е갨갨);
    is($е갨갨, "   foo  \n", 'trim-leading does not trim a variable in-place');
    $е갨갨 .= trim-leading;
    is($е갨갨, "foo  \n", 'trim-leading works correctly');
    $е갨갨 =  "\t   \t  \tfoo   \t\t  \t \n";
    $е갨갨 .= trim-leading;
    is($е갨갨, "foo   \t\t  \t \n", 'our variable is trimmed again with no effect');
}

{
    is(''.trim-leading, '', 'trim-leading on an empty string gives an empty string');
    is(' '.trim-leading, '', 'trim-leading on an one-space string gives an empty string');
    is("\n".trim-leading, '', 'trim-leading on newline string gives an empty string');
    is('  '.trim-leading, '', 'trim-leading on a two-space string gives an empty string');
}

{
    my $е갨갨 = " foo bar ";
    $е갨갨 .= trim-leading;
    is($е갨갨, "foo bar ", 'our variable is trimmed correctly');
    $е갨갨 .= trim-leading;
    is($е갨갨, "foo bar ", 'our variable is trimmed again with no effect');
}

{
    my $е갨갨 = "\n foo\n ";
    $е갨갨 .= trim-leading;
    $е갨갨 .= trim-leading;
    $е갨갨 .= trim-leading;
    is($е갨갨, "foo\n ", 'our variable can be trimmed multiple times');
}

#
# trim-trailing
#

{
    my $е갨갨 = "   foo  \n";
    trim-trailing($е갨갨);
    is($е갨갨, "   foo  \n", 'trim-trailing does not trim a variable in-place');
    $е갨갨 .= trim-trailing;
    is($е갨갨, "   foo", 'trim-trailing works correctly');
    $е갨갨 =  "\t   \t  \tfoo   \t\t  \t \n";
    $е갨갨 .= trim-trailing;
    is($е갨갨, "\t   \t  \tfoo", 'our variable is trimmed again with no effect');
}

{
    is(''.trim-trailing, '', 'trim-trailing on an empty string gives an empty string');
    is(' '.trim-trailing, '', 'trim-trailing on an one-space string gives an empty string');
    is("\n".trim-trailing, '', 'trim-trailing on newline string gives an empty string');
    is('  '.trim-trailing, '', 'trim-trailing on a two-space string gives an empty string');
}

{
    my $е갨갨 = " foo bar ";
    $е갨갨 .= trim-trailing;
    is($е갨갨, " foo bar", 'our variable is trimmed correctly');
    $е갨갨 .= trim-trailing;
    is($е갨갨, " foo bar", 'our variable is trimmed again with no effect');
}

{
    my $е갨갨 = "\n foo\n ";
    $е갨갨 .= trim-trailing;
    $е갨갨 .= trim-trailing;
    $е갨갨 .= trim-trailing;
    is($е갨갨, "\n foo", 'our variable can be trimmed multiple times');
}

{
    ok ' ab ' ~~ /.*/, 'regex sanity';
    is $/.trim, 'ab', 'Match.trim';
}

subtest 'trim routines on Cool' => {
    plan 6;
    my $𝐩 = ' foo '.IO;
    is-deeply trim($𝐩),           'foo',  '&trim works with Cool instance';
    is-deeply trim-leading($𝐩),   'foo ', '&trim-leading works with Cool instance';
    is-deeply trim-trailing($𝐩), ' foo',  '&trim-trailing works with Cool instance';

    is-deeply $𝐩.trim,            'foo',  '.trim works with Cool instance';
    is-deeply $𝐩.trim-leading,    'foo ', '.trim-leading works with Cool instance';
    is-deeply $𝐩.trim-trailing,  ' foo',  '.trim-trailing works with Cool instance';
}
# vim: expandtab shiftwidth=4
